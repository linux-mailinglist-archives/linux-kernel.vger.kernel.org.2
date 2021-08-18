Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3FC3F0192
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 12:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhHRK1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 06:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhHRK1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 06:27:07 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BD1C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 03:26:32 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id c17so1778150pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 03:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CIWpHyvhjM0v5hQGy4X7aU8xDXyHu3qVpUT347taFHQ=;
        b=EXvhJ9Nu2nrBbZ6Kanq7eyBFqYWQXpGM8xkALu2XfED/27p+Qdi133Et62KZ/DzHRb
         TqwgZhrIttVm/05nWTZ6rB+8vnGrIi+rgaG3nwStlHVoJdOSIN2ZpfAh8TB6ASZq3sJw
         hQJX1LdAz/RgcgVaor/da3Or9X33Nkt8BU9uRiYpHJOQ6e/BKcoOm9BLAibYFkAYgqIG
         K38BAVmotQm4KpKIgnJo2faCP5Dlu/Y5drsLnA4jCNFbg9WNUUf54j79XrUdtSHukh+q
         WRDEegQijaTjtJ/77c+JdA6zlYmAmhHC4B9F8hhfdgNGPv0FJFw7WdxQ/yCY4N4NAtJN
         0nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CIWpHyvhjM0v5hQGy4X7aU8xDXyHu3qVpUT347taFHQ=;
        b=lTLCeQxLMV8Vt5vu42Yn78BOPpEyAaRaC/r2vGqOglbVDU3LatLBeHoUDLXaPY/DF0
         LlG/m86NTm/Xhrbg6WztONeWO6FEOg5yFcG4qAEGqQLkmTikxd5RATriu7x+xwKSRrjk
         uo7y6jSyBcvMS9pXMEWI42ml22GeSgDJgyHNOXO7o58HNlkHj46XTJZXbxZBuyuRwr5N
         5UGNhH1EhMpn0SnJathxGDJu4D28c9vbmHc/A45wQ5ei2QDToTOQzsHC3m9gt2jPCL0m
         W8em5Lj1I7yiNwO9Z8Da9pC1+DKrnzav7ZXNd+bUy9Sxk0ilWw1VPlRXO6cLbIrVy0UG
         PTkw==
X-Gm-Message-State: AOAM5322muvduWsuzWD0ieo2XN3f+cqKIvBOmjmpgzQSu5Z7+S+zPPJv
        nLXqTy6spJ6skM9QOEXVslo=
X-Google-Smtp-Source: ABdhPJyelo8/aD3dOcCAmMFcIhm2DX/Do78AVsOE0x/pYJKj7o2q1NfZJcGkIEYuIPxBErdd4ZTe7g==
X-Received: by 2002:a62:65c7:0:b029:3c3:4eff:1b26 with SMTP id z190-20020a6265c70000b02903c34eff1b26mr8345347pfb.48.1629282391731;
        Wed, 18 Aug 2021 03:26:31 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.182])
        by smtp.gmail.com with ESMTPSA id c12sm5396258pfl.56.2021.08.18.03.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 03:26:31 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Dave Kleikamp <shaggy@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] JFS: fix memleak in jfs_mount
Date:   Wed, 18 Aug 2021 18:25:58 +0800
Message-Id: <20210818102612.864127-1-mudongliangabcd@gmail.com>
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
 fs/jfs/jfs_mount.c | 53 +++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index 5d7d7170c03c..638a4ecc4069 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -81,14 +81,14 @@ int jfs_mount(struct super_block *sb)
 	 * (initialize mount inode from the superblock)
 	 */
 	if ((rc = chkSuper(sb))) {
-		goto errout20;
+		return rc;
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
 
@@ -178,41 +178,32 @@ int jfs_mount(struct super_block *sb)
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
-		diUnmount(ipaimap2, 1);
-		diFreeSpecial(ipaimap2);
-	}
-
-      errout35:
-
-	/* close aggregate block allocation map */
+	if (ipaimap2) diUnmount(ipaimap2, 1);
+err_ipaimap2:
+	/* close aggregate inodes */
+	if (ipaimap2) diFreeSpecial(ipaimap2);
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

