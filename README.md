# qnap-qts-rtorrent-rutorrent-docker
rTorrent with ruTorrent as a docker image for qnap qts container station

Docker image with rTorrent/ruTorrent created for qnap qts

To run this on your qnap nas:

1. Clone this repo:

    git@github.com:harek/qnap-qts-rtorrent-rutorrent-docker.git
2. Build docker image:

    docker build -t "harek/rtorrent" . (in project dir)
3. Save image as tarball:

    docker save "harek/rtorrent" > rtorrent.tar
4. Install "Container station" app on your qnap nas
5. Create some new network share/folder on your qnap nas volumen which will be used by rtorrent
6. Upload your rtorrent configuration to the top dir created in step 5 as a "rtorrent.rc" file (notice lack of preceded dot)
7. Go to "Container station" app and select import tab, then import button and select local tar file created in step 3
8. Type name for your image
9. Go to advanced settings:
  - on shared directories tab: set volumen created in step 5 for mount point /download (read-write access)
  - Optionaly: you should change auto port to some fixed ports in network tab
10. Save created image in conatainer station

:)
