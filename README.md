# kubectl image

## Usage

```bash
docker run ghcr.io/trstringer/kubectl:v1.28.3
```

## Run kubectl in a pod

**Service account**

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: kubectl
```

**Role**

*Adjust according to your requirements.*

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: kubectl
rules:
  - apiGroups: [""]
    resources:
      - pods
    verbs:
      - get
      - list
      - delete
```

**Role binding**

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: kubectl
subjects:
  - kind: ServiceAccount
    name: kubectl
roleRef:
  kind: Role
  name: kubectl
  apiGroup: rbac.authorization.k8s.io
```

**Job**

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: kubectl
spec:
  template:
    metadata:
      name: kubectl
    spec:
      restartPolicy: Never
      serviceAccountName: kubectl
      containers:
        - name: kubectl
          image: ghcr.io/trstringer/kubectl:latest
          args: ["get", "po"]
          # command: ["/bin/bash"]
          # args: ["-c", "sleep 10 && kubectl get po"]
```

```
kubectl logs -l batch.kubernetes.io/job-name=kubectl
```
