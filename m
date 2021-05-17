Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9CA382872
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbhEQJiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbhEQJgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:36:46 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A06C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t21so2821093plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VRworSM7SSq166sAfcl/fQNvSz+WlTwkV9pcOtbl76g=;
        b=MGDbSzIbwR/guG9K1eDKX+2P5oBpz4loIwH1OtroBQR5yw/Hzd3+wjUx4uvBNBiW3f
         QE5FJX/4dygBE45ooOkAEFv03cB5SMBStezeUhu0FiCiqsaVAPg7K32D8dl148z60BT8
         VOgk3OSZj2RXV4N2k4M1Xml4nDj6ffEJ/SSfF7GzLxovcC0LaDzT/iws6So65tbCs47P
         H1OIKg9Gi4PuevUyyvjRbY1q0pKZgdzJO+rvoCAdGfoYNHB3UEv19jEZPEYzElLL2yhz
         PUFv15OdWgoD1vV5m+wj8cSQ4qUrPF8aZmNOWzQl6CddPVrGXIea/hkBAkdNSNYwtgg7
         cm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRworSM7SSq166sAfcl/fQNvSz+WlTwkV9pcOtbl76g=;
        b=E7VP8qiINf3Oqnmf3/ed7xye0WaIEoKVZAZQnXuyc+kVVyVImYsmL+zwfwARejyM2T
         bWEd3JhD/pC6p8GGpYORzu0IA95FSQPZmdampv8HFqHbdjnLv/PUYOh13VVR6CSokTnS
         f+crlPKMCIR3jMmYqgnJDnaMN0EohCaYf3Mtzaz18WWYfm5xqVQpcz5Xmb3zVdxclRoD
         X/FwlUOw/6ykE0GYcgL1+ruer5HEnidYQlhJMKV/gmo3MFHWe9KK3lx6jBuNvGTX2irO
         Td15t6EIG9vWQOVlhKJJlazJOi79w+j3LkfmpvtUdUwJJrhQ2hivyQyZh9Qw5FeW/KLv
         Ao2A==
X-Gm-Message-State: AOAM530i1JSSMXlOTX6ZnNROBDi4ERfxAL7iDFdeuqF6dNzw0uaMETPo
        X5xvsouwaNeVeN7meH/PCOe+
X-Google-Smtp-Source: ABdhPJzYUI9JGxHa84CrEBThnC4jSehotmZbcKagHa04mAMN7naoVYmxyUlbkBTAy/Fm+nDzJnswjw==
X-Received: by 2002:a17:90a:549:: with SMTP id h9mr26696158pjf.158.1621244129739;
        Mon, 17 May 2021 02:35:29 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id o10sm10271075pjl.2.2021.05.17.02.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:35:29 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/15] rpmsg: virtio: Handle virtio_device_ready() failure
Date:   Mon, 17 May 2021 17:34:22 +0800
Message-Id: <20210517093428.670-10-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517093428.670-1-xieyongji@bytedance.com>
References: <20210517093428.670-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now virtio_device_ready() will return error if we get
invalid status. Let's handle this case on probe.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 10df8bc0c3e1..6a8eb8c74bca 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -812,6 +812,19 @@ static void rpmsg_xmit_done(struct virtqueue *svq)
 	wake_up_interruptible(&vrp->sendq);
 }
 
+static int rpmsg_remove_device(struct device *dev, void *data)
+{
+	device_unregister(dev);
+
+	return 0;
+}
+
+static void virtio_rpmsg_remove_device(struct virtio_device *vdev)
+{
+	if (device_for_each_child(&vdev->dev, NULL, rpmsg_remove_device))
+		dev_warn(&vdev->dev, "can't remove rpmsg device: %d\n", ret);
+}
+
 static int rpmsg_probe(struct virtio_device *vdev)
 {
 	vq_callback_t *vq_cbs[] = { rpmsg_recv_done, rpmsg_xmit_done };
@@ -924,7 +937,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	notify = virtqueue_kick_prepare(vrp->rvq);
 
 	/* From this point on, we can notify and get callbacks. */
-	virtio_device_ready(vdev);
+	err = virtio_device_ready(vdev);
+	if (err)
+		goto remove_rpmsg_dev;
 
 	/* tell the remote processor it can start sending messages */
 	/*
@@ -937,7 +952,8 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	dev_info(&vdev->dev, "rpmsg host is online\n");
 
 	return 0;
-
+remove_rpmsg_dev:
+	virtio_rpmsg_remove_device(vdev);
 free_coherent:
 	kfree(vch);
 	dma_free_coherent(vdev->dev.parent, total_buf_space,
@@ -949,13 +965,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	return err;
 }
 
-static int rpmsg_remove_device(struct device *dev, void *data)
-{
-	device_unregister(dev);
-
-	return 0;
-}
-
 static void rpmsg_remove(struct virtio_device *vdev)
 {
 	struct virtproc_info *vrp = vdev->priv;
@@ -964,9 +973,7 @@ static void rpmsg_remove(struct virtio_device *vdev)
 
 	vdev->config->reset(vdev);
 
-	ret = device_for_each_child(&vdev->dev, NULL, rpmsg_remove_device);
-	if (ret)
-		dev_warn(&vdev->dev, "can't remove rpmsg device: %d\n", ret);
+	virtio_rpmsg_remove_device(vdev);
 
 	idr_destroy(&vrp->endpoints);
 
-- 
2.11.0

