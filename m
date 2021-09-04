Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C24400958
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 04:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350806AbhIDCjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 22:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbhIDCjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 22:39:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C26CC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 19:38:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q21so611187plq.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 19:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3JPTdUwvyk1gA7gUvlVpOs/m2+cd0OzoZLCglRS429w=;
        b=EeDsTRAjbWKMy7c9STNLw837RR1O8FVXGJJ7fhmgcsMGU0q6dRrP/KY+FvlZwy4sSf
         4o64rhxRDWmsXShIHq92PaIHNCeBBNpInGATmmg+pYkM64LsRz9kXLhZ5WEHV+2DOSgY
         Lkf7Xkrl3FpJbrJ+Ob6dj8IfVsGvuXKuTy21kv4YJjJo+Qk9F9UenWVTNne1R+HR5KV6
         s7PYctM8lAcUGx+I7uHNp5IjTsilBE8k2NGRY2k224FpM5hvtNLCm7G6LA+VFfOiRss3
         EW3Y6TUu4DkToWXciDmiaIyAw+hfk/VpKgOHn2vpJ9TQWW6dfy9fhKk0HcBzwXkxwYWP
         ayMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3JPTdUwvyk1gA7gUvlVpOs/m2+cd0OzoZLCglRS429w=;
        b=ATNBztFxkAZdRm9clnsHqr+tlowBKKacwH3HtFIUHedsnjzAFs1S9UAUOBN27lQsqR
         jwevP2sQRlel0GKIWKmyyLV/mYuOvR1DlhwY+Ms7KMVcJhCwcmTw+QeFtX3UFjvpZmY/
         xVzzBj0Tu2zzAtJuI3mvkPpdBxRpwQSzTt8B1u8zs99VdBYzTWvGoKVm7iJzhZo7BpeD
         ENqVGp3MISsR1V7rkWBu2BngPx23/rQsZTziyKije2PVy+6bn0Kz873zlucdi9kO58js
         UXpTjsOc71oktbDVJ7NYnQzb0xb9wFxqhFHg1tcQQDBarOJIUj7Sq8kjfZev+Sbm2Bdo
         fVrw==
X-Gm-Message-State: AOAM532k5HBT1BbHAwHcEMPJ3M8WRvVyvlE4yYuyfg5pTt5BZqrHKipn
        8N8qTvE7cusCHBAmRNqoIus=
X-Google-Smtp-Source: ABdhPJzDBorMIDhxDqeSwnExGfafnpKI/eBSHxvQXTU+mBUkjwGScnrGMDx4FvSg+FxQnzICi+Jq9Q==
X-Received: by 2002:a17:90a:aa14:: with SMTP id k20mr2006370pjq.88.1630723093603;
        Fri, 03 Sep 2021 19:38:13 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.104])
        by smtp.gmail.com with ESMTPSA id g2sm600455pfr.35.2021.09.03.19.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 19:38:13 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Dave Kleikamp <shaggy@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2] JFS: fix memleak in jfs_mount
Date:   Sat,  4 Sep 2021 10:37:41 +0800
Message-Id: <20210904023800.1813036-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In jfs_mount, when diMount(ipaimap2) fails, it goes to errout35. However,
the following code does not free ipaimap2 allocated by diReadSpecial.

Fix this by refactoring the error handling code of jfs_mount. To be
specific, modify the lable name and free ipaimap2 when the above error
ocurrs.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
v1->v2: change "return rc" to "goto out"; fix one coding style
 fs/jfs/jfs_mount.c | 51 ++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index 5d7d7170c03c..aa4ff7bcaff2 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -81,14 +81,14 @@ int jfs_mount(struct super_block *sb)
 	 * (initialize mount inode from the superblock)
 	 */
 	if ((rc = chkSuper(sb))) {
-		goto errout20;
+		goto out;
 	}
 
 	ipaimap = diReadSpecial(sb, AGGREGATE_I, 0);
 	if (ipaimap == NULL) {
 		jfs_err("jfs_mount: Failed to read AGGREGATE_I");
 		rc = -EIO;
-		goto errout20;
+		goto out;
 	}
 	sbi->ipaimap = ipaimap;
 
@@ -99,7 +99,7 @@ int jfs_mount(struct super_block *sb)
 	 */
 	if ((rc = diMount(ipaimap))) {
 		jfs_err("jfs_mount: diMount(ipaimap) failed w/rc = %d", rc);
-		goto errout21;
+		goto err_ipaimap;
 	}
 
 	/*
@@ -108,7 +108,7 @@ int jfs_mount(struct super_block *sb)
 	ipbmap = diReadSpecial(sb, BMAP_I, 0);
 	if (ipbmap == NULL) {
 		rc = -EIO;
-		goto errout22;
+		goto err_umount_ipaimap;
 	}
 
 	jfs_info("jfs_mount: ipbmap:0x%p", ipbmap);
@@ -120,7 +120,7 @@ int jfs_mount(struct super_block *sb)
 	 */
 	if ((rc = dbMount(ipbmap))) {
 		jfs_err("jfs_mount: dbMount failed w/rc = %d", rc);
-		goto errout22;
+		goto err_ipbmap;
 	}
 
 	/*
@@ -139,7 +139,7 @@ int jfs_mount(struct super_block *sb)
 		if (!ipaimap2) {
 			jfs_err("jfs_mount: Failed to read AGGREGATE_I");
 			rc = -EIO;
-			goto errout35;
+			goto err_umount_ipbmap;
 		}
 		sbi->ipaimap2 = ipaimap2;
 
@@ -151,7 +151,7 @@ int jfs_mount(struct super_block *sb)
 		if ((rc = diMount(ipaimap2))) {
 			jfs_err("jfs_mount: diMount(ipaimap2) failed, rc = %d",
 				rc);
-			goto errout35;
+			goto err_ipaimap2;
 		}
 	} else
 		/* Secondary aggregate inode table is not valid */
@@ -168,7 +168,7 @@ int jfs_mount(struct super_block *sb)
 		jfs_err("jfs_mount: Failed to read FILESYSTEM_I");
 		/* open fileset secondary inode allocation map */
 		rc = -EIO;
-		goto errout40;
+		goto err_umount_ipaimap2;
 	}
 	jfs_info("jfs_mount: ipimap:0x%p", ipimap);
 
@@ -178,41 +178,34 @@ int jfs_mount(struct super_block *sb)
 	/* initialize fileset inode allocation map */
 	if ((rc = diMount(ipimap))) {
 		jfs_err("jfs_mount: diMount failed w/rc = %d", rc);
-		goto errout41;
+		goto err_ipimap;
 	}
 
-	goto out;
+	return rc;
 
 	/*
 	 *	unwind on error
 	 */
-      errout41:		/* close fileset inode allocation map inode */
+err_ipimap:
+	/* close fileset inode allocation map inode */
 	diFreeSpecial(ipimap);
-
-      errout40:		/* fileset closed */
-
+err_umount_ipaimap2:
 	/* close secondary aggregate inode allocation map */
-	if (ipaimap2) {
+	if (ipaimap2)
 		diUnmount(ipaimap2, 1);
+err_ipaimap2:
+	/* close aggregate inodes */
+	if (ipaimap2)
 		diFreeSpecial(ipaimap2);
-	}
-
-      errout35:
-
-	/* close aggregate block allocation map */
+err_umount_ipbmap:	/* close aggregate block allocation map */
 	dbUnmount(ipbmap, 1);
+err_ipbmap:		/* close aggregate inodes */
 	diFreeSpecial(ipbmap);
-
-      errout22:		/* close aggregate inode allocation map */
-
+err_umount_ipaimap:	/* close aggregate inode allocation map */
 	diUnmount(ipaimap, 1);
-
-      errout21:		/* close aggregate inodes */
+err_ipaimap:		/* close aggregate inodes */
 	diFreeSpecial(ipaimap);
-      errout20:		/* aggregate closed */
-
-      out:
-
+out:
 	if (rc)
 		jfs_err("Mount JFS Failure: %d", rc);
 
-- 
2.25.1

