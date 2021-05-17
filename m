Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53621382729
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhEQIhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbhEQIhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:37:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26986C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:36:17 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id j12so4150812pgh.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RMDgH8NUsXdrAybpXac96tA5zmX/PfFeEJylm6gXF/Y=;
        b=0qusV1boVsPlX+7AgoQ18cI3Y8pm9LHdrDPY+UvTOqNWmZAwrDAimV2xeOmkzU9ZTX
         XWZKKxoJHfGkwdFrly/MA5VaGjiIt4L9LM2xnhOwnUpVta82Eht4vZxw1MxYZxozeS1u
         xO87SCpmc81u3ReYF8bHwh6xCzkL0ytb9osq8foMEM5WdhLu3bI2LnbUeSYVBVcGZGJA
         tGe1p9uSeAbckptj0gPYhwzg38V8l93mVXBUogxF65PUxhYRpZz9+wh/ga0HgfDsEZON
         Gr4XcdBwpq2HK9GVacGn5POCSx3GUHglrX9nB+e/iIo+2d8Dg8gQhnnY8kKDZ/h7Vabg
         oFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RMDgH8NUsXdrAybpXac96tA5zmX/PfFeEJylm6gXF/Y=;
        b=l3RMCFEra1jVPde+UJ+S3JsAvVPuLkqktRa6hjXUx2t/GOIjinkBHoh6Jn7ZgCWcws
         2EQmyYntn4xyVPTr4ScNOwRM8wLpNb20YSW2xO+i57tW1/+WN5jcXDUHkJX1rTAlqYXH
         eMEYQQXzOOOsGSITrz2uR8Z91iy2SVNLGfLnRWJ3tarafcETYwKx2K1r1DaUeTZg/Kts
         MbT8YBmzXHJi5n18HuenLq1DWlof9/X8x68tEa697sHdhJ9pj++GwkLCkNJwrRjNIVpY
         zjOp6Ot8pWUQz1H6IziayuKfXDr27c87vxOxdjVweedGIKRlc95U8QhXGfcWPmpccnNF
         /tng==
X-Gm-Message-State: AOAM533N+y2KgDgMGzAEwNmzwuYMMSn89UjMaE13tUqwdXp/RHL3otuY
        woMT9CC4P5Wxl5M5DGMzXqtiegEo0b/o
X-Google-Smtp-Source: ABdhPJxh6LSsPVIjPg3u3LKm/qBxwTfiyANDf+B1Xc5wCYehe5mn8WR70NAnjZHKmOrLfYusUyyFZQ==
X-Received: by 2002:a65:6a08:: with SMTP id m8mr59650783pgu.146.1621240576757;
        Mon, 17 May 2021 01:36:16 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id c16sm2400936pfd.206.2021.05.17.01.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 01:36:16 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] 9p/trans_virtio: Remove sysfs file on probe failure
Date:   Mon, 17 May 2021 16:35:57 +0800
Message-Id: <20210517083557.172-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ensures we don't leak the sysfs file if we failed to
allocate chan->vc_wq during probe.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 net/9p/trans_virtio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 93f2f8654882..0960ed1ad7ac 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -610,7 +610,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 	chan->vc_wq = kmalloc(sizeof(wait_queue_head_t), GFP_KERNEL);
 	if (!chan->vc_wq) {
 		err = -ENOMEM;
-		goto out_free_tag;
+		goto out_remove_file;
 	}
 	init_waitqueue_head(chan->vc_wq);
 	chan->ring_bufs_avail = 1;
@@ -628,6 +628,8 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 
 	return 0;
 
+out_remove_file:
+	sysfs_remove_file(&vdev->dev.kobj, &dev_attr_mount_tag.attr);
 out_free_tag:
 	kfree(tag);
 out_free_vq:
-- 
2.11.0

