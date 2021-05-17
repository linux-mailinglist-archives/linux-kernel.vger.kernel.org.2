Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E72E38286F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbhEQJiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbhEQJgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:36:42 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529ABC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:26 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 69so2813311plc.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhT2oruqWOyUnDFHXgc4qBLIeLeeWvSX3CAEBFhznlI=;
        b=TX+GMbXIrrPtgOG2AE3TEXIy17+ENDzDbHNynziVieS2QyYEJKiaXgRh/zPV85qFwy
         s/niTFQuTBUpM59l+b2Oc7IhU4rIK2crQ33Sc2uSU42MLkTRDTzj8sNJjcqRm3ZQ18ph
         sRE9v3+lRC+RSr5miXlmKHXRue+nBAuvhjUcIJ67p2nueURG7tWLQrPiBoXGCvMN/RJw
         GY95Mykc5G45xJfCLycIctyLbnViEqcXnfjgeKLhIRgeA4wlWkxYCuJ24mdpI/Fd4YaV
         PwhO204xme7mShE3iswDiST6E6pPhac2/bzOc535QIl0Hkba3egSJgQ0YV0DF1f7mXsl
         jcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhT2oruqWOyUnDFHXgc4qBLIeLeeWvSX3CAEBFhznlI=;
        b=NmxRE+fbf22K16ojjJC/m0YPM51LMCIoLjrwXXmGK9yQr1k5tgGx7tFwNhQs88UrUn
         4sTBQHPRM1GNUF3EujyRF0i0RVe0D0rBDYX8luhcGWIxLuBaC7CT+ykBKK2N5bRq7uok
         jrVjPzboPFfZO0c2FUjp241S0dLgNB7oPCBl+kEfxi03XH9+i2yhyizxXBNUFpRvXUjC
         jUNc2J+Ukyl9NkkUi5hmSXQUGemShRRHmhDaUvBNj1G0/dLXRFmMnVhcOxNx8XzDyCvb
         4CXHyNgxU1x/toN1ARrsQSvHkitCrUvZQvg6CSt/4UFQpZKyu7npW8I9oPECDphEJ9Qk
         8vTQ==
X-Gm-Message-State: AOAM530YeZq3lJB/Uoll6KKySdarJ3Z3UX/LRK06CmSmqe06KSJXFhQM
        EclOSvuzNlcPdJJu1V8sEYLa
X-Google-Smtp-Source: ABdhPJxo+Nvqe2iZGj5qVhoXU8RDT8ZI7XMHZodr4A2fbcZAZ2CNR07p3ge9lzW+g8yHSA6cwPr9Hg==
X-Received: by 2002:a17:902:ea06:b029:f1:9082:3ddc with SMTP id s6-20020a170902ea06b02900f190823ddcmr3308206plg.43.1621244125930;
        Mon, 17 May 2021 02:35:25 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id f14sm10735404pjq.50.2021.05.17.02.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:35:25 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/15] virtio-net: Handle virtio_device_ready() failure
Date:   Mon, 17 May 2021 17:34:21 +0800
Message-Id: <20210517093428.670-9-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517093428.670-1-xieyongji@bytedance.com>
References: <20210517093428.670-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now virtio_device_ready() will return error if we get
invalid status. Let's handle this case in both probe
and resume paths.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/net/virtio_net.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 01e54e99cae6..c4711e23af88 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2341,6 +2341,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 }
 
 static int init_vqs(struct virtnet_info *vi);
+static void virtnet_del_vqs(struct virtnet_info *vi);
 
 static int virtnet_restore_up(struct virtio_device *vdev)
 {
@@ -2351,7 +2352,11 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 	if (err)
 		return err;
 
-	virtio_device_ready(vdev);
+	err = virtio_device_ready(vdev);
+	if (err) {
+		virtnet_del_vqs(vi);
+		return err;
+	}
 
 	if (netif_running(vi->dev)) {
 		for (i = 0; i < vi->curr_queue_pairs; i++)
@@ -3148,12 +3153,16 @@ static int virtnet_probe(struct virtio_device *vdev)
 		goto free_failover;
 	}
 
-	virtio_device_ready(vdev);
+	err = virtio_device_ready(vdev);
+	if (err) {
+		pr_debug("virtio_net: enable virtio device failed\n");
+		goto free_unregister_netdev;
+	}
 
 	err = virtnet_cpu_notif_add(vi);
 	if (err) {
 		pr_debug("virtio_net: registering cpu notifier failed\n");
-		goto free_unregister_netdev;
+		goto reset_virtio_device;
 	}
 
 	virtnet_set_queues(vi, vi->curr_queue_pairs);
@@ -3179,9 +3188,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	return 0;
 
-free_unregister_netdev:
+reset_virtio_device:
 	vi->vdev->config->reset(vdev);
-
+free_unregister_netdev:
 	unregister_netdev(dev);
 free_failover:
 	net_failover_destroy(vi->failover);
-- 
2.11.0

