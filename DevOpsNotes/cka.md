# Certified kubernetes administrator

## **Architecture of kubernetes**

---

### **Control Plane**

- **kuber-api server**\
kuberapi server is the primary management component of kubernetes the kube api server is responsible for orchstrating all the operations within the cluster it exposes the kubernetes api whihc is used by external users to perform management operations on the clusters. whenever we run any command it first goes to kube-api server the kube api server then authenticate validate the request and then retrieves data from the etcd cluster and then responds back with requested data **``kube-api server authenticate user valiate request retrieve data update etcd schdule kubelet``**

- **ETCD**\
etcd stores  information of cluster like nodes, pods, configs, secrets, accounts, roles, bindings, others
it sotres data about the cluster advertise client url the url whhere etcd listens port 2379

- **kuber controller manager**\
A controller is a process that continuously monitors the state of various components within the system, we have different controller to do different jobs like node controller is responsible for monitoring the status of the nodes and taking necessary actions to keep the application running. Replication controller are responsible for monitoring the replicas present on the nodes.

- **Kube-scheduler**\
scheduler decides which pod will go on which container.
---

### **Worker node**
- **kubelet**\
this section is to be filled

- **kube-proxy**\
this section is to be filled

---

## **PODS**

---

Smallest object in kubernetes. we can have multiple containers in one pods but the other container should be helper container like dependent not same container in same pod.\
`Kubectl run nginx --image nginx`

for a pod file 4 components are important
```yaml
apiVersion: V1
kind: Pod
metadata: 
  name:
  label:
     app:
     type:
spec: 
  containers: 
  - name:
    image:
```
---

## **Replication Controller**

Replica Set is the new name for replication controller selector is required in replicaset but not in replication controller

---

## **labels and Selectors**

---

## **Deployments**

`kubectl create deployment --image=ngnix nginx --dry-run=client -o yaml`

`kubectl create deployment --image=ngnix nginx --dry-run=client -o yaml> nginx-deployment.yaml`

---

## **Services**

- **NodePort**\
target port is the pod port. in spec we have type and ports then targetPort then port which is service port and then we provide nodePort the port on which we will access thhe service then in selector we define the selector and provide labels taht we used to deploy the pod. in this tyr of service the pod is made accessible on a port on the node. and to access the service externally we used the node ip and its node port

- **ClusterIP**\
default service

- **Loadbalancer**\
external setup

---

## **Scheduling**
---

labels and selectors are to group objects in cluster. label are properties attached to each objects and selector are used to identify them.. in metadata section we can specify label.\
`kubectl get pods --selector env=dev,bu=finance`

---
## **Taints and toleration**
Taints are condition we apply on the node and any pod will not be able to be schedule on this node until there is an toleration in pods specified which will enable the pod to handle the taint taint and tolerations are not used to place a pod on a node but it only used to accepts certain node. eg for master node we generally set a taint specify.\
kubectl taint nodes node1 key1=value1:noschedule format is key=value:effect
toleartions to be added in the podspec part
```yaml
tolerations:
- key: "key1"
  operator: "Equal"
  value: "value1"
  effect: "NoSchedule"

```
if you provide operator as exist then no need for value.

---

## **Nodeselectors**

`kubectl label nodes << node -name >> < label-key >=< label-value >`\
ex. `kubectl label nodes node01 size=Large`

## **Node Affinity**
---
To limit pod placing on specific nodes.
under spec at the same level as containers we place affinity in which we will write nodeAffinity and provide the conditions.
```yaml
affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: disktype
            operator: In
            values:
            - ssd  
```
---
**nodeaffinity and taints&toleration**

using nodeaffinity we cannot gurantee that other pods who do not have any affinity define will not land up on our node ex if i have lbel my node as blue and i have two pods in one i have nodeaffiniy set as blue and there is another pod on which i have defined no node affinity in this case the pod with blue node affinity will land on my node but the pod with no node affinity may also land on my node.\
Similary when i define taint my pod with the toleration to that taint may be placed on the node where i have the taint or it may get placed on different node where there is not taint .

## **Kubeclt commands for quick help**
____
```cli
kubeclt get pods
kubectl get deployments
kubectl get pods -o wide
kubectl describe pod podname
kubectl describe deployment deploymentname
```
___