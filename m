Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F88B3E43BE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhHIKSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 06:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbhHIKSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 06:18:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEEAC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 03:18:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a20so15886395plm.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jkLLkAaCMrvGSGnk9HYHVtNB7W5aNoh0CfrV/y19IQw=;
        b=R6IYedkFb9YhTOOqxkyzltIgx8LAstXCcDLzOCVIIwwnr/cO9OhWeGxOgspAQY+p+t
         dQ4mvdAbqc+HKIDbpHvex3AWtIyFzqsnzHtlgamPpGPdZnKWLjc8qITx54zqtpNbCAaf
         pvE5irUlEtVrHrwDmXmPr3MEc05n3b9W7bY0tUFnjWWDvEjtNGEls+bhEs+ilsjeV9Vh
         Pr6guNaa60J+evo7bMqJIQEA+SykeJQu9QOuXLSLmm6czRi2SgbegMJTvHg629agnrMN
         bPWVpm2W4pgfZdIb4NCQD4CTFI+UY8NiuJxRUAO+pRaHFF/9IzzOGFnTP4E87CTldqNA
         57kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jkLLkAaCMrvGSGnk9HYHVtNB7W5aNoh0CfrV/y19IQw=;
        b=ELRGgKY2WHr3ej7i4vNypSdcgViyQN9Tm3wH3rIRhNEY6N3z2O+leyUca2jzEzCMKl
         09kCiWaDDD+SggCJ1HZI55KriDgAgIt9nyWJlGicpQG00YCb0c7f/gad9RwbeNmPQK1m
         C0MweJbkWms7gcmNo6UrfT7NDWqGSgcpzHXwDRSPuqD/hlF2in+mPumYPKDICra3GYuF
         e8v1QR4vhxU73e1Ir+597vIg3JnXaQx5FStIRoWtdIqmUOZgNdZFuejBSbiH7VYD2MUF
         V+YLtuTfHp2IbKCw/2iDT7z307BjUzdibsrryhhPM2CtJfhEXyaoAyQhXlasNbNZtgr/
         yQvA==
X-Gm-Message-State: AOAM531T2+WIAuaR5XcqPkgbwlHDBZd/FjXkJBxBJM79ITYzSXpx7jOT
        +SjyO0Ta6QiSmfVzcJXfHC8z
X-Google-Smtp-Source: ABdhPJw53UyF6YJcipsF/HNnSD+fg9LmBDc9iBipK+yx3VckpcCmFaTDCcoWLKVhhuW+kg6cYe+mLg==
X-Received: by 2002:a63:5815:: with SMTP id m21mr32030pgb.363.1628504308562;
        Mon, 09 Aug 2021 03:18:28 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id e7sm7039789pfc.145.2021.08.09.03.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 03:18:28 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] virtio-blk: Add validation for block size in config space
Date:   Mon,  9 Aug 2021 18:16:09 +0800
Message-Id: <20210809101609.148-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An untrusted device might presents an invalid block size
in configuration space. This tries to add validation for it
in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
feature bit if the value is out of the supported range.

And we also double check the value in virtblk_probe() in
case that it's changed after the validation.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/virtio_blk.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 4b49df2dfd23..afb37aac09e8 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -692,6 +692,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
 static unsigned int virtblk_queue_depth;
 module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
 
+static int virtblk_validate(struct virtio_device *vdev)
+{
+	u32 blk_size;
+
+	if (!vdev->config->get) {
+		dev_err(&vdev->dev, "%s failure: config access disabled\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
+		return 0;
+
+	blk_size = virtio_cread32(vdev,
+			offsetof(struct virtio_blk_config, blk_size));
+
+	if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
+		__virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
+
+	return 0;
+}
+
 static int virtblk_probe(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk;
@@ -703,12 +725,6 @@ static int virtblk_probe(struct virtio_device *vdev)
 	u8 physical_block_exp, alignment_offset;
 	unsigned int queue_depth;
 
-	if (!vdev->config->get) {
-		dev_err(&vdev->dev, "%s failure: config access disabled\n",
-			__func__);
-		return -EINVAL;
-	}
-
 	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
 			     GFP_KERNEL);
 	if (err < 0)
@@ -823,6 +839,14 @@ static int virtblk_probe(struct virtio_device *vdev)
 	else
 		blk_size = queue_logical_block_size(q);
 
+	if (unlikely(blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)) {
+		dev_err(&vdev->dev,
+			"block size is changed unexpectedly, now is %u\n",
+			blk_size);
+		err = -EINVAL;
+		goto err_cleanup_disk;
+	}
+
 	/* Use topology information if available */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
 				   struct virtio_blk_config, physical_block_exp,
@@ -881,6 +905,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
 	return 0;
 
+err_cleanup_disk:
+	blk_cleanup_disk(vblk->disk);
 out_free_tags:
 	blk_mq_free_tag_set(&vblk->tag_set);
 out_free_vq:
@@ -983,6 +1009,7 @@ static struct virtio_driver virtio_blk = {
 	.driver.name			= KBUILD_MODNAME,
 	.driver.owner			= THIS_MODULE,
 	.id_table			= id_table,
+	.validate			= virtblk_validate,
 	.probe				= virtblk_probe,
 	.remove				= virtblk_remove,
 	.config_changed			= virtblk_config_changed,
-- 
2.11.0

