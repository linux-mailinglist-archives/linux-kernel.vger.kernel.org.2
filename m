Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB36C382868
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhEQJgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbhEQJgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:36:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEEAC061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t4so2810916plc.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWVzxiwXjnZyHxGUl4Nr8QHSNTuXhX6z5VjHv5kydcg=;
        b=w3bEVJaW2YDk3zjNY2JKwAIukcw60wgTSfyuc5UBiN+Y5Z5vQQCls61BPV0Y7Pvans
         KHpn3mz1rFIDYe/SXMYNNhx16ZvHbEhtPd2i0S8bML048xtwSFcGpNRKiilS/HFDODM1
         q9zBtjB4tricl4TKBl55ITnvOxpTVrJldB9SYupAIxwVaDkAD3nw5+wKmcuBJr9bch75
         YtfVEYutGccbdGHuziDVxTgaEb86qZFOn2o2dtdH7hgGlSuNVr7bRYcgyjAlheeQS9C9
         w7D/YlQQBpB95rJ8igdfqVueRqf3w/Gtto8b7TsKZFf5CR021SK8USpkyDqxljfwycu3
         6JCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWVzxiwXjnZyHxGUl4Nr8QHSNTuXhX6z5VjHv5kydcg=;
        b=Su2+RAws4LWM/85Kto1kiyaSFmuftMT6g0L/APj2IYDiU8puOtKSq8SM8hX6DDPt3v
         VOn9Bmzvl5Ox5pJqr4FnV+EGcH2OwvqqcAXM3mG6emYaWCqVKheM5OBZ69G/DHeY1aJ7
         a5KUvVrQoBd8QCBHWCyijx9zZWRnNvmO6NIflX8LLCk36k4cr75vGzna18t5URh4NJXq
         x7rPF+2YajA5TwYdGEyPjxJ/6E2M63gnkGdgGvIYo6EsUS2J9ghqsH7W+xqaj5QIq2Ov
         HHQUZD1L6D3XsnS9vLQ622yyOVkziQYpn+e520ejFV+SDREZieRWjaJQTC8mRgaPD78a
         iCWg==
X-Gm-Message-State: AOAM531e6+PIr9ryx4y7Xixeyz9FKSeqlyV8/TvVFus7+rAnHFex4WfM
        jHSsbSZNvfRSNNTvNxpTQgy7
X-Google-Smtp-Source: ABdhPJyBGPw0zuJoMHPAqGEOh4bK4MgYzAKvyADs7EN2tmW/HyQtOseqJ67IZ4KC+Vv9tmKewCPfFA==
X-Received: by 2002:a17:90a:6682:: with SMTP id m2mr67825609pjj.90.1621244102332;
        Mon, 17 May 2021 02:35:02 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 25sm7475969pfh.39.2021.05.17.02.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:35:02 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/15] virtio-blk: Handle virtio_device_ready() failure
Date:   Mon, 17 May 2021 17:34:15 +0800
Message-Id: <20210517093428.670-3-xieyongji@bytedance.com>
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
 drivers/block/virtio_blk.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 255adb7a768c..ebb4d3fe803f 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -884,11 +884,15 @@ static int virtblk_probe(struct virtio_device *vdev)
 	}
 
 	virtblk_update_capacity(vblk, false);
-	virtio_device_ready(vdev);
+	err = virtio_device_ready(vdev);
+	if (err)
+		goto out_cleanup_queue;
 
 	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
 	return 0;
 
+out_cleanup_queue:
+	blk_cleanup_queue(vblk->disk->queue);
 out_free_tags:
 	blk_mq_free_tag_set(&vblk->tag_set);
 out_put_disk:
@@ -961,7 +965,12 @@ static int virtblk_restore(struct virtio_device *vdev)
 	if (ret)
 		return ret;
 
-	virtio_device_ready(vdev);
+	ret = virtio_device_ready(vdev);
+	if (ret) {
+		vdev->config->del_vqs(vdev);
+		kfree(vblk->vqs);
+		return ret;
+	}
 
 	blk_mq_unquiesce_queue(vblk->disk->queue);
 	return 0;
-- 
2.11.0

