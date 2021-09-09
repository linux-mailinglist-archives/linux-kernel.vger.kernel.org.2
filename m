Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1044405CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 20:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243931AbhIISLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 14:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243881AbhIISLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:11:17 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32487C061757
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 11:10:07 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id m4so4345783ljq.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 11:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZfipCwxhRp6Ie3Aw8psddkQkoxd2J2YHBmheHWPB+M=;
        b=kUOdeKUqJMNDgRmus6zXohIAtzc233o7W3lzXHUGyl7zkndtyB1FgmVsbZ1tYyw3JX
         yGZSFenrNgMzFjZJXwIFR7OQrrMEXwGejegAqaxSDpidIazAr2bcGhzDktfxORMpEmhF
         bFeKINoyNFY4RxaFhruu4Z3nSppUxIGbaE7rBx03TaxLNPRp7QVLYCh1YF5s8FfvTWs5
         4HQ/HyOVPcAzLWIx4T7c7PSuwE574hTC30z5MD+gboo8ZO1swEL/2p9JfqiGYeKk0nal
         5MIIwE/VHw96JJNeZqcZJEgr0zCCr/1J8UUPeTbSnHDSRHz+Ov1XXdXPt3UBy22shYth
         mdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZfipCwxhRp6Ie3Aw8psddkQkoxd2J2YHBmheHWPB+M=;
        b=2o9TH03cL9gzAnCF0zek+S3FEw/H64LKBk+ae0IlAr3I1S7QLUjD34oenwstK6+gM4
         MNqYGLLj4AEO/VVjsFW2knJ9OluX+cE6Ndj81MM1pm+YpQKfZLUFH/fZ7tmce0PV2xm2
         55uYV7+/u2mWfYk1jR+P1Hqom6PFoDj/N7G9tBT+7+taD0ogwoGqtBoiVi1xze7hBvI1
         2zqXTFeeJAN+xAWPXqqpFNgntvhA5D+hfW5hpGIvsYpUDRj8o3LHuTTK8+AnRU+JqBvt
         klBAVccfzJHfjUeNi8DmZyXnc9vy5C1QvJofoCAGd6e+GSOxSKCFQcXFd37XB8JPuNBO
         mj8w==
X-Gm-Message-State: AOAM5301JM+XUdFkf01lWN+8QmQ9qgJkl5YMSw3tHGIOs5I13NuaHNgb
        PFm9OEtVmLXjyFHRiyyLygY=
X-Google-Smtp-Source: ABdhPJyn837DBOaFhkhzPWGxsycV4Lg3toh+2C3DTacAM0aHhoiatj1djqfd+KoygA+AGcZDLU1nqg==
X-Received: by 2002:a05:651c:54d:: with SMTP id q13mr949179ljp.526.1631211005502;
        Thu, 09 Sep 2021 11:10:05 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id u2sm270276lff.238.2021.09.09.11.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:10:05 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 10/11] fs/ntfs3: Initialize pointer before use place in fill_super
Date:   Thu,  9 Sep 2021 21:09:41 +0300
Message-Id: <20210909180942.8634-11-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210909180942.8634-1-kari.argillander@gmail.com>
References: <20210909180942.8634-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initializing should be as close as possible when we use it so that
we do not need to scroll up to see what is happening.

Also bdev_get_queue() can never return NULL so we do not need to check
for !rq.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 9a096be32fb2..321fcfce64e1 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -877,7 +877,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	int err;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	struct block_device *bdev = sb->s_bdev;
-	struct request_queue *rq = bdev_get_queue(bdev);
+	struct request_queue *rq;
 	struct inode *inode;
 	struct ntfs_inode *ni;
 	size_t i, tt;
@@ -906,9 +906,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		return -EINVAL;
 	}
 
-	if (!rq || !blk_queue_discard(rq) || !rq->limits.discard_granularity) {
-		;
-	} else {
+	rq = bdev_get_queue(bdev);
+	if (blk_queue_discard(rq) && rq->limits.discard_granularity) {
 		sbi->discard_granularity = rq->limits.discard_granularity;
 		sbi->discard_granularity_mask_inv =
 			~(u64)(sbi->discard_granularity - 1);
-- 
2.25.1

