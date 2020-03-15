docker build -t foup/multi-client:latest -t foup/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t foup/multi-server:latest -t foup/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t foup/nulti-worker:latest -t foup/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push foup/multi-client:latest
docker push foup/multi-server:latest
docker push foup/multi-worker:latest

docker push foup/multi-client:$SHA
docker push foup/multi-server:$SHA
docker push foup/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=foup/multi-server:$SHA
kubectl set image deployments/client-deployment client=foup/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=foup/multi-worker:$SHA
