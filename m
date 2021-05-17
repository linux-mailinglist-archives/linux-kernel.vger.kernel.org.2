Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07DE3827EB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhEQJNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbhEQJLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:11:01 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CE6C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:45 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x18so204362pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TD6DazTCPRTB4jlTy5HHPgtblfK1yNsEqCrm4hiu5J4=;
        b=hQgmHqviBsawhHJoMeKTzv2eita3hpurtUqCgGIR5RfsNjqfqCkfaeWJGTE9ty+bpb
         YHCjQ3SNEyQ79agLHa8p0ITadC93XC5kwH4aUgdH9x4tQs7ILczn68vqiGgZMEQsK8LB
         d9iAJHG9u79rxkmvqBo0Ka53xyR9zCdSUvKCsAEN8LY/x3lFLDg04I5u6fSliwZfNAm8
         p00wuBF5OdMnO0xO/Ssri8ieJvWRhuYQ0DeUvI62WK5BcgGmgzAMHbg3GOnapt1Swgh/
         BTkOO02fXVnxx7nh1b0q0s197I+UDWZgqUWlyLumTXWV9HBE7IQtsM21LCFlpzc+y9Fm
         KegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TD6DazTCPRTB4jlTy5HHPgtblfK1yNsEqCrm4hiu5J4=;
        b=iTn3Cgfec32f0ywjKfqd+gsF4lQiUi7DTaBRDI21Rn9ZKMxqzv1n3jY4U64y4BqpoN
         B9gXLIWo5ThlofKxxZJOPFs4Kc6lABxwJK/5L5VvURtue8DMZUoEvbG1hiK7gxW0c9tI
         7MzkkS1M/tdAK/X+8V+n/xWYld/tgIBOEJ4FJFSAtPMCYK9Ob2Y67kZpxgnZ6UtkbSIX
         afCFL9ACD6Fu/5FttQHghJLowsHA172rYfeSGPJOSSnv1bwEcUzvICzr2RzPoMryytLm
         Kt8B12rY4uuoZ4fTyqLrDhcch3ddnv6NURMPNmgVR5YVQX+3/yQB4vHkmUIzfpi8acB6
         qeFA==
X-Gm-Message-State: AOAM531EJFuGTMvO7VIy6GlQIi4yA+tNnBIVm3iMKhnTX+/aYAYOGcdt
        bbj4kuutxCZNmmS/6uHih8Qf
X-Google-Smtp-Source: ABdhPJy6+0u3kxs3ejNTK+HkEaMFw4H/tt1XIN9eqiv44Zdcy+KA/RIEsnpsLu/z28E859Ye5q2Amg==
X-Received: by 2002:aa7:8c59:0:b029:28e:9093:cd4d with SMTP id e25-20020aa78c590000b029028e9093cd4dmr58064179pfd.25.1621242585155;
        Mon, 17 May 2021 02:09:45 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id c16sm2469628pfd.206.2021.05.17.02.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:44 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 12/17] virtio_balloon: Remove unused used length
Date:   Mon, 17 May 2021 17:08:31 +0800
Message-Id: <20210517090836.533-13-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517090836.533-1-xieyongji@bytedance.com>
References: <20210517090836.533-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The used length is not used. Let's drop it and
pass NULL to virtqueue_get_buf() instead.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio_balloon.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 510e9318854d..7565970c3901 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -152,7 +152,6 @@ static void balloon_ack(struct virtqueue *vq)
 static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 {
 	struct scatterlist sg;
-	unsigned int len;
 
 	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
 
@@ -161,7 +160,7 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 	virtqueue_kick(vq);
 
 	/* When host has read buffer, this completes via balloon_ack */
-	wait_event(vb->acked, virtqueue_get_buf(vq, &len));
+	wait_event(vb->acked, virtqueue_get_buf(vq, NULL));
 
 }
 
@@ -171,7 +170,7 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	struct virtio_balloon *vb =
 		container_of(pr_dev_info, struct virtio_balloon, pr_dev_info);
 	struct virtqueue *vq = vb->reporting_vq;
-	unsigned int unused, err;
+	unsigned int err;
 
 	/* We should always be able to add these buffers to an empty queue. */
 	err = virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT | __GFP_NOWARN);
@@ -187,7 +186,7 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	virtqueue_kick(vq);
 
 	/* When host has read buffer, this completes via balloon_ack */
-	wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
+	wait_event(vb->acked, virtqueue_get_buf(vq, NULL));
 
 	return 0;
 }
@@ -386,7 +385,7 @@ static void stats_handle_request(struct virtio_balloon *vb)
 	num_stats = update_balloon_stats(vb);
 
 	vq = vb->stats_vq;
-	if (!virtqueue_get_buf(vq, &len))
+	if (!virtqueue_get_buf(vq, NULL))
 		return;
 	sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
 	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
@@ -586,10 +585,10 @@ static int send_cmd_id_start(struct virtio_balloon *vb)
 {
 	struct scatterlist sg;
 	struct virtqueue *vq = vb->free_page_vq;
-	int err, unused;
+	int err;
 
 	/* Detach all the used buffers from the vq */
-	while (virtqueue_get_buf(vq, &unused))
+	while (virtqueue_get_buf(vq, NULL))
 		;
 
 	vb->cmd_id_active = cpu_to_virtio32(vb->vdev,
@@ -605,10 +604,10 @@ static int send_cmd_id_stop(struct virtio_balloon *vb)
 {
 	struct scatterlist sg;
 	struct virtqueue *vq = vb->free_page_vq;
-	int err, unused;
+	int err;
 
 	/* Detach all the used buffers from the vq */
-	while (virtqueue_get_buf(vq, &unused))
+	while (virtqueue_get_buf(vq, NULL))
 		;
 
 	sg_init_one(&sg, &vb->cmd_id_stop, sizeof(vb->cmd_id_stop));
@@ -623,11 +622,11 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
 	struct virtqueue *vq = vb->free_page_vq;
 	struct page *page;
 	struct scatterlist sg;
-	int err, unused;
+	int err;
 	void *p;
 
 	/* Detach all the used buffers from the vq */
-	while (virtqueue_get_buf(vq, &unused))
+	while (virtqueue_get_buf(vq, NULL))
 		;
 
 	page = alloc_pages(VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG,
-- 
2.11.0

