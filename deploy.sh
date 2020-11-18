docker build -t sktymnxr6ifoux/multi-client:latest -t sktymnxr6ifoux/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t sktymnxr6ifoux/multi-server:latest -t sktymnxr6ifoux/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t sktymnxr6ifoux/multi-worker:latest -t sktymnxr6ifoux/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push sktymnxr6ifoux/multi-client:latest
docker push sktymnxr6ifoux/multi-server:latest
docker push sktymnxr6ifoux/multi-worker:latest

docker push sktymnxr6ifoux/multi-client:$GIT_SHA
docker push sktymnxr6ifoux/multi-server:$GIT_SHA
docker push sktymnxr6ifoux/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=sktymnxr6ifoux/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=sktymnxr6ifoux/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=sktymnxr6ifoux/multi-worker:$GIT_SHA