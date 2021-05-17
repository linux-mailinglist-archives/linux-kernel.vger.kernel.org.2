Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4E1382749
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhEQIpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhEQIpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:45:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A33C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:43:58 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f22so3217310pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8k/z57omIEnDUk11NgWGNydSJ6TOr4+Xzp32HB20Wyk=;
        b=mU5hZgEXDYGRG2VFnl1WtJGINvK7fV4M9KNwztIh+LSb73Cahin3HP8X+zGLWevW/J
         Z5yTFRB9Zk35CI7IJUqkBu4UDT5cPbTsYaH+vkNbGZzjTjBXYJBAxUWlTFuu+UMfYDK2
         2vFrX3R0yanNTHMjANjvlhoDh1XfTvzarmD8cibPqq9q3rT8+kHSgq4WgSSMUOLKN0wa
         VMQfOy698iCrzqHnlLfuvfu2fryHKiB9scq4+zS803CXfewS39vBoEQ9IVgKUfTQG07e
         O1wU9cAvmpFl5qKbq/DT3Ww6ix/ejyoC9BkRjVVMvhlmh5A+DTwWfTg3VUyQU2QEf58y
         9HjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8k/z57omIEnDUk11NgWGNydSJ6TOr4+Xzp32HB20Wyk=;
        b=Aq1D+PTsdr2pa5M0yrUF2BdtQHAfyo56YFXAY4i7wIubmbVI0EbC/DYgXyyLjxpgpP
         M4cDYDK4wGP+oNCT+AwejDQabXunXI9FJ3Yi9zbr8HPhWmDmAT2cfnoW0OqblzCp3fM3
         29TOhcGM0KdIGwn3fCnVkUnB0z3pZCiPKSjgXron2Iqt73r3MZtax33iK7NO//gBRp+r
         IzIros/baLG5etpJ1te8WxGwUOfZZrLGiyaEcE7llj+O/CUxjpHo7+LUqhJpu2MG+Bhf
         QHDv0wOgLvfCKivoAbRSJbS2qJjazIGWxR0u1ryeagrfqeMfKGbLsxHuklpEuEhib9rP
         nOng==
X-Gm-Message-State: AOAM533g1YgGIDry6uj664yTtpsrvOECVQr0Le4ttXYM39+bZH8CXVqU
        BALqN7PUm/GyiD8ioSYyBhpj
X-Google-Smtp-Source: ABdhPJxhiP3ppq7dG17UbKN/JSi9pNCMOYlwi3+WXCd6AvXH5ZinjVahGLR5QPt413ejst4/x9tHQw==
X-Received: by 2002:a63:490:: with SMTP id 138mr59721473pge.99.1621241037960;
        Mon, 17 May 2021 01:43:57 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id k7sm9612393pfc.16.2021.05.17.01.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 01:43:57 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virtio-blk: Fix memory leak among suspend/resume procedure
Date:   Mon, 17 May 2021 16:43:32 +0800
Message-Id: <20210517084332.280-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vblk->vqs should be freed before we call init_vqs()
in virtblk_restore().

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/virtio_blk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 367a1e929d7c..d24a8cea9aab 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -948,6 +948,8 @@ static int virtblk_freeze(struct virtio_device *vdev)
 	blk_mq_quiesce_queue(vblk->disk->queue);
 
 	vdev->config->del_vqs(vdev);
+	kfree(vblk->vqs);
+
 	return 0;
 }
 
-- 
2.11.0

