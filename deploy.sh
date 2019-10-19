docker build -t hrmtsngh18/multi-client:latest -t hrmtsngh18/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hrmtsngh18/multi-server:latest -t hrmtsngh18/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hrmtsngh18/multi-worker:latest -t hrmtsngh18/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hrmtsngh18/multi-client:latest
docker push hrmtsngh18/multi-client:$SHA
docker push hrmtsngh18/multi-server:latest
docker push hrmtsngh18/multi-server:$SHA
docker push hrmtsngh18/multi-worker:latest
docker push hrmtsngh18/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hrmtsngh18/multi-server:$SHA
kubectl set image deployments/client-deployment client=hrmtsngh18/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hrmtsngh18/multi-worker:$SHA