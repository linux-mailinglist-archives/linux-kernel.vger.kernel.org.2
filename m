Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312833AB94B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 18:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhFQQP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 12:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbhFQQNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:13:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5953AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 09:11:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v13so3184197ple.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 09:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ax6cETdinXWixOBfa2JXuuJreyz/2EakPhTszPVNovE=;
        b=i2QXD0vhjVadbjwCmRdyNJqmCJfF+D+qzE+5On//JOZFpoHUgMErQ2ApsO0fvPgBrh
         WB0J16l5X7WlSWdjxiYJPOKw5I3EWB990vCX8td+8KS8DcuNK64Fufah0VfpTZB974ut
         F1zqdkpTJXa/XRMpt2nkaZ6DrDW5y2qblxKoNcQWrPpVx2TaFULd4vJd09aBovLSir80
         KqgIBeu9fB9/8aGrWyTYmiOjQn6oUAudcN17lDi9OXG2KyeqX9MkERC3sLhTEHeZRt+J
         p/JpjX4ALsoqTASC5bZvSmcETVpAm4voc7uT7gegQ6EJ+yvf6+F/vYtqbL7OfIl8UxtX
         DTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ax6cETdinXWixOBfa2JXuuJreyz/2EakPhTszPVNovE=;
        b=j2c7mht6bWJ3dK8PZ7Ue2Ro6Ml2SWZDiyeZ+3UI9qU+o+Kce9/R6+6h7gO9Suf7Ghv
         PN4IkOC4QFjinF0bnQNwNoWs3xQS3fq45XNUNWD3DVtYVFxLHotXisZi1GF9GLemEdGH
         oGhkPjGUXX25pvvRYrdWJoE7GeCJZIs3SZHq4V0QwUC4CxD1+G8V8+wD18DHBOxTRKZv
         hddOlu/P5t0SPmapG9BUxEI2YPFAXHtEnWrCfxek579ZAQ69cyUlekrOg7kKnoxPq8xL
         epbgZJHWYh1/fYoCfJ3GnmqQzKDhrvLmIx8dnKknZ3m1q7NoDTuSJsknHxV8tBBc7KwM
         9F7A==
X-Gm-Message-State: AOAM532BxkG/t38d8ey2DAjr+xg4tjJ/FbL7UjLyKpaE8Kn7J1S0H84H
        551UvTfsM1TzWIBRLJff24Q=
X-Google-Smtp-Source: ABdhPJxA7oUNbFsGjhbNIo746b9a5E8ZEjnY31bzeD1lZjEFk7hoeAfcyTpUfGXFvil2uefPLd8A/A==
X-Received: by 2002:a17:902:be10:b029:109:7460:cc41 with SMTP id r16-20020a170902be10b02901097460cc41mr612469pls.4.1623946286013;
        Thu, 17 Jun 2021 09:11:26 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id 4sm8090293pjg.30.2021.06.17.09.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 09:11:25 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] mtd: break circular locks in register_mtd_blktrans
Date:   Fri, 18 Jun 2021 00:09:04 +0800
Message-Id: <20210617160904.570111-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported a circular locking dependency:
https://syzkaller.appspot.com/bug?id=7bd106c28e846d1023d4ca915718b1a0905444cb

This happens because of the following lock dependencies:

1. loop_ctl_mutex -> bdev->bd_mutex (when loop_control_ioctl calls
loop_remove, which then calls del_gendisk; this also happens in
loop_exit which eventually calls loop_remove)

2. bdev->bd_mutex -> mtd_table_mutex (when blkdev_get_by_dev calls
__blkdev_get, which then calls blktrans_open)

3. mtd_table_mutex -> major_names_lock (when register_mtd_blktrans
calls __register_blkdev)

4. major_names_lock -> loop_ctl_mutex (when blk_request_module calls
loop_probe)

Hence there's an overall dependency of:

loop_ctl_mutex   ----------> bdev->bd_mutex
      ^                            |
      |                            |
      |                            v
major_names_lock <---------  mtd_table_mutex

We can break this circular dependency by holding mtd_table_mutex only
for the required critical section in register_mtd_blktrans. This
avoids the mtd_table_mutex -> major_names_lock dependency.

Reported-and-tested-by: syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com
Co-developed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---

Changes in v1 -> v2:

Break the circular dependency in register_mtd_blktrans instead of blk_request_module, as suggested by Christoph Hellwig.

 drivers/mtd/mtd_blkdevs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index fb8e12d590a1..7d26cfe24d05 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -528,14 +528,10 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
 	if (!blktrans_notifier.list.next)
 		register_mtd_user(&blktrans_notifier);
 
-
-	mutex_lock(&mtd_table_mutex);
-
 	ret = register_blkdev(tr->major, tr->name);
 	if (ret < 0) {
 		printk(KERN_WARNING "Unable to register %s block device on major %d: %d\n",
 		       tr->name, tr->major, ret);
-		mutex_unlock(&mtd_table_mutex);
 		return ret;
 	}
 
@@ -545,12 +541,12 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
 	tr->blkshift = ffs(tr->blksize) - 1;
 
 	INIT_LIST_HEAD(&tr->devs);
-	list_add(&tr->list, &blktrans_majors);
 
+	mutex_lock(&mtd_table_mutex);
+	list_add(&tr->list, &blktrans_majors);
 	mtd_for_each_device(mtd)
 		if (mtd->type != MTD_ABSENT)
 			tr->add_mtd(tr, mtd);
-
 	mutex_unlock(&mtd_table_mutex);
 	return 0;
 }
-- 
2.25.1

