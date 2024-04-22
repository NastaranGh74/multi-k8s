docker build -t nastaran74/multi-client:latest -t nastaran74/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nastaran74/multi-server:latest -t nastaran74/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nastaran74/multi-worker:latest -t nastaran74/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push nastaran74/multi-client:latest
docker push nastaran74/multi-server:latest
docker push nastaran74/multi-worker:latest

docker push nastaran74/multi-client:$SHA
docker push nastaran74/multi-server:$SHA
docker push nastaran74/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nastaran74/multi-server:$SHA
kubectl set image deployments/client-deployment client=nastaran74/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nastaran74/multi-worker:$SHA
