Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E721382870
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhEQJiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbhEQJgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:36:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A2AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 69so2813223plc.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhT2oruqWOyUnDFHXgc4qBLIeLeeWvSX3CAEBFhznlI=;
        b=iA7Y2txEd2pgfIphtl6bQNpUVtIJiWwArsdRmTRUaP0HpBvgfzUGeV8grsWVnlepYj
         jIwK3AEFyaqlp9dBgQ6d9ahGongqOWA9KFyMFbEpx8R0K4pXglliKVTg/PyBDcFmgHrN
         bQYOJ4jG11axphWT2UhNq0/sN/Poz1VCPxvqvLX52Hoas9j+gGLwfbPhtUVMtoEV3Yz3
         kryYduzCFIpCZcCO5gCsOKA4fcwOdTUD1tKk9rnUyt0io8ZacFIyoPEqnr+9fgG2Iekc
         MW5m2gpQ63Y2f8b1XPpadiKDeDxbVjRYFOrdWEnHQ4h0HlbRd0xPWqLT/BmZneP4tMgK
         QU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhT2oruqWOyUnDFHXgc4qBLIeLeeWvSX3CAEBFhznlI=;
        b=Tdg1ApKOtSBrONjg6IfPsF6ku5V4F3mZkHAw0wuJSEv56hZ4TZkIfK9VojhOjp8c9G
         WmizCuAPfT8+cuJVR0ysS/VXEx0vtfXDhOp0EpOzSx004kzArCjhdDAVIir29IEaw8xl
         vdf8TpB6XVzTD1IzLG7Y2kwDo6IJccfv60oCMyu3lVWFB+A7r/+4CWtQk34h3lz7LUED
         Bk+K9kgcTYPDQYZmr/buGV/VaoVQvVQ38eC7HTcc8a2ED2UNDI7AYFS9DoTscjwKLsd0
         IdxWQsaHSd1MzFUvBst4o6E1GGB4vxHaNg38eKyG4lIsnMhN4NqRnGclUkZcUQQxJ4Am
         n7bQ==
X-Gm-Message-State: AOAM5329Z1piMQlZul/fLxJxAvSNyB9AFgXIx9Nbl2YHeLRLpIhpno5f
        gpMVe+t/Q1OvJuDfER9P4nO3
X-Google-Smtp-Source: ABdhPJwfd8FHInyqiNNHfVR5FHKoD54wbkMl0fjIgeVGdKc44r9K5zlr92W5s8woU3aOTUY01cTKKw==
X-Received: by 2002:a17:902:8bc3:b029:e9:9639:be21 with SMTP id r3-20020a1709028bc3b02900e99639be21mr59230213plo.59.1621244122022;
        Mon, 17 May 2021 02:35:22 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id t22sm11932801pjr.43.2021.05.17.02.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:35:21 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/15] virtio-net: Handle virtio_device_ready() failure
Date:   Mon, 17 May 2021 17:34:20 +0800
Message-Id: <20210517093428.670-8-xieyongji@bytedance.com>
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

