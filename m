Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE93A312205
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 07:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBGGhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 01:37:47 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:35253 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229445AbhBGGhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 01:37:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UO3JqNx_1612679822;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UO3JqNx_1612679822)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 07 Feb 2021 14:37:02 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] jfs: turn diLog(), dataLog() and txLog() into void functions
Date:   Sun,  7 Feb 2021 14:37:00 +0800
Message-Id: <1612679820-35163-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions always return '0' and no callers use the return value.
So make it a void function.

This eliminates the following coccicheck warning:
./fs/jfs/jfs_txnmgr.c:1365:5-7: Unneeded variable: "rc". Return "0" on
line 1414
./fs/jfs/jfs_txnmgr.c:1422:5-7: Unneeded variable: "rc". Return "0" on
line 1527

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/jfs/jfs_txnmgr.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index dca8edd..c42bf86 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -1365,9 +1365,8 @@ int txCommit(tid_t tid,		/* transaction identifier */
  *
  * RETURN :
  */
-static int txLog(struct jfs_log * log, struct tblock * tblk, struct commit * cd)
+static void txLog(struct jfs_log *log, struct tblock *tblk, struct commit *cd)
 {
-	int rc = 0;
 	struct inode *ip;
 	lid_t lid;
 	struct tlock *tlck;
@@ -1414,7 +1413,7 @@ static int txLog(struct jfs_log * log, struct tblock * tblk, struct commit * cd)
 		}
 	}
 
-	return rc;
+	return;
 }
 
 /*
@@ -1422,10 +1421,9 @@ static int txLog(struct jfs_log * log, struct tblock * tblk, struct commit * cd)
  *
  * function:	log inode tlock and format maplock to update bmap;
  */
-static int diLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
-		 struct tlock * tlck, struct commit * cd)
+static void diLog(struct jfs_log *log, struct tblock *tblk, struct lrd *lrd,
+		 struct tlock *tlck, struct commit *cd)
 {
-	int rc = 0;
 	struct metapage *mp;
 	pxd_t *pxd;
 	struct pxd_lock *pxdlock;
@@ -1527,7 +1525,7 @@ static int diLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
 	}
 #endif				/* _JFS_WIP */
 
-	return rc;
+	return;
 }
 
 /*
@@ -1535,8 +1533,8 @@ static int diLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
  *
  * function:	log data tlock
  */
-static int dataLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
-	    struct tlock * tlck)
+static void dataLog(struct jfs_log *log, struct tblock *tblk, struct lrd *lrd,
+	    struct tlock *tlck)
 {
 	struct metapage *mp;
 	pxd_t *pxd;
@@ -1562,7 +1560,7 @@ static int dataLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
 		metapage_homeok(mp);
 		discard_metapage(mp);
 		tlck->mp = NULL;
-		return 0;
+		return;
 	}
 
 	PXDaddress(pxd, mp->index);
@@ -1573,7 +1571,7 @@ static int dataLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
 	/* mark page as homeward bound */
 	tlck->flag |= tlckWRITEPAGE;
 
-	return 0;
+	return;
 }
 
 /*
-- 
1.8.3.1

