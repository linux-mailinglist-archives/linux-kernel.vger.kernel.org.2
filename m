Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2682F34DDA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhC3BhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhC3Bgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:36:54 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024E7C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 18:36:54 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n198so14806931iod.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 18:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyCGnwGXC+XNnvx4uNqau3wnYVDaw+dKBtB8XYrUblw=;
        b=ZSEQDpwq5HhPjDR5JNP9sYoVwAcMpfYjYgaUXPsRib28GHM5pekOZmkkhsG53u8IiH
         tTiEQoMeFQQY3jYSwVU+VEB9paqCTKiEhNgEEVKe1Z6xwGP21DGR7YzKGVqoAfRn+7al
         PpGrVGJ2vl04zHbHcEA1hYym+9W0FJrZZo2eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyCGnwGXC+XNnvx4uNqau3wnYVDaw+dKBtB8XYrUblw=;
        b=anPzTp7eIYVytcKXHpraIoSN/Ph2m9hxo89EB1draUEs8blG0zBphcWKAsjADsN27e
         5NTcKlOBzYQIAIl3q/iB52YpzBtmltsZGhYI2HStXlAWp2REhTf6w1ff7DJpPPFjE4bQ
         gSp3zpNtbn5k24TBmykGkrgNW+gWvsq0M37NP5WsiAHa/NmnZuzIeXHviT0ETxP+9EJ8
         tCDXdGR7F080HCupR+Lo5XmAlPoA7m+PlZO/D80JJRMy1j8ai1AcgZzqix0qHreY7O4z
         3KmrztfxJE6d+3wnY8MaAruTDz8kJ7GWIX5k/xgIJXkHqKpx0c/ZNRnkRjp1pJ+4NiJK
         xDAA==
X-Gm-Message-State: AOAM532XQw75ZqQddvacKrI5x+tGxerQ3it/oPsk1mrnH3RO4ig52wRJ
        iCZJK256+RrpS2xr3Aa9cBjJG/9K/CAc9g==
X-Google-Smtp-Source: ABdhPJxHjb6KdN+eZhjimwTzpK74ggotD/Vm9maFNTtkfCzwbdr69wmMdudyFUPxQwEG1dEadVnabQ==
X-Received: by 2002:a5e:980e:: with SMTP id s14mr23180258ioj.63.1617068213453;
        Mon, 29 Mar 2021 18:36:53 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i13sm10551696ilm.86.2021.03.29.18.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 18:36:53 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+a93fba6d384346a761e3@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: [PATCH 1/4] usbip: add sysfs_lock to synchronize sysfs code paths
Date:   Mon, 29 Mar 2021 19:36:48 -0600
Message-Id: <b6568f7beae702bbc236a545d3c020106ca75eac.1616807117.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1616807117.git.skhan@linuxfoundation.org>
References: <cover.1616807117.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fuzzing uncovered race condition between sysfs code paths in usbip
drivers. Device connect/disconnect code paths initiated through
sysfs interface are prone to races if disconnect happens during
connect and vice versa.

This problem is common to all drivers while it can be reproduced easily
in vhci_hcd. Add a sysfs_lock to usbip_device struct to protect the paths.

Use this in vhci_hcd to protect sysfs paths. For a complete fix, usip_host
and usip-vudc drivers and the event handler will have to use this lock to
protect the paths. These changes will be done in subsequent patches.

Reported-and-tested-by: syzbot+a93fba6d384346a761e3@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/usb/usbip/usbip_common.h |  3 +++
 drivers/usb/usbip/vhci_hcd.c     |  1 +
 drivers/usb/usbip/vhci_sysfs.c   | 30 +++++++++++++++++++++++++-----
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index d60ce17d3dd2..ea2a20e6d27d 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -263,6 +263,9 @@ struct usbip_device {
 	/* lock for status */
 	spinlock_t lock;
 
+	/* mutex for synchronizing sysfs store paths */
+	struct mutex sysfs_lock;
+
 	int sockfd;
 	struct socket *tcp_socket;
 
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index a20a8380ca0c..4ba6bcdaa8e9 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1101,6 +1101,7 @@ static void vhci_device_init(struct vhci_device *vdev)
 	vdev->ud.side   = USBIP_VHCI;
 	vdev->ud.status = VDEV_ST_NULL;
 	spin_lock_init(&vdev->ud.lock);
+	mutex_init(&vdev->ud.sysfs_lock);
 
 	INIT_LIST_HEAD(&vdev->priv_rx);
 	INIT_LIST_HEAD(&vdev->priv_tx);
diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index c4b4256e5dad..e2847cd3e6e3 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -185,6 +185,8 @@ static int vhci_port_disconnect(struct vhci_hcd *vhci_hcd, __u32 rhport)
 
 	usbip_dbg_vhci_sysfs("enter\n");
 
+	mutex_lock(&vdev->ud.sysfs_lock);
+
 	/* lock */
 	spin_lock_irqsave(&vhci->lock, flags);
 	spin_lock(&vdev->ud.lock);
@@ -195,6 +197,7 @@ static int vhci_port_disconnect(struct vhci_hcd *vhci_hcd, __u32 rhport)
 		/* unlock */
 		spin_unlock(&vdev->ud.lock);
 		spin_unlock_irqrestore(&vhci->lock, flags);
+		mutex_unlock(&vdev->ud.sysfs_lock);
 
 		return -EINVAL;
 	}
@@ -205,6 +208,8 @@ static int vhci_port_disconnect(struct vhci_hcd *vhci_hcd, __u32 rhport)
 
 	usbip_event_add(&vdev->ud, VDEV_EVENT_DOWN);
 
+	mutex_unlock(&vdev->ud.sysfs_lock);
+
 	return 0;
 }
 
@@ -349,30 +354,36 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 	else
 		vdev = &vhci->vhci_hcd_hs->vdev[rhport];
 
+	mutex_lock(&vdev->ud.sysfs_lock);
+
 	/* Extract socket from fd. */
 	socket = sockfd_lookup(sockfd, &err);
 	if (!socket) {
 		dev_err(dev, "failed to lookup sock");
-		return -EINVAL;
+		err = -EINVAL;
+		goto unlock_mutex;
 	}
 	if (socket->type != SOCK_STREAM) {
 		dev_err(dev, "Expecting SOCK_STREAM - found %d",
 			socket->type);
 		sockfd_put(socket);
-		return -EINVAL;
+		err = -EINVAL;
+		goto unlock_mutex;
 	}
 
 	/* create threads before locking */
 	tcp_rx = kthread_create(vhci_rx_loop, &vdev->ud, "vhci_rx");
 	if (IS_ERR(tcp_rx)) {
 		sockfd_put(socket);
-		return -EINVAL;
+		err = -EINVAL;
+		goto unlock_mutex;
 	}
 	tcp_tx = kthread_create(vhci_tx_loop, &vdev->ud, "vhci_tx");
 	if (IS_ERR(tcp_tx)) {
 		kthread_stop(tcp_rx);
 		sockfd_put(socket);
-		return -EINVAL;
+		err = -EINVAL;
+		goto unlock_mutex;
 	}
 
 	/* get task structs now */
@@ -397,7 +408,8 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 		 * Will be retried from userspace
 		 * if there's another free port.
 		 */
-		return -EBUSY;
+		err = -EBUSY;
+		goto unlock_mutex;
 	}
 
 	dev_info(dev, "pdev(%u) rhport(%u) sockfd(%d)\n",
@@ -423,7 +435,15 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 
 	rh_port_connect(vdev, speed);
 
+	dev_info(dev, "Device attached\n");
+
+	mutex_unlock(&vdev->ud.sysfs_lock);
+
 	return count;
+
+unlock_mutex:
+	mutex_unlock(&vdev->ud.sysfs_lock);
+	return err;
 }
 static DEVICE_ATTR_WO(attach);
 
-- 
2.27.0

