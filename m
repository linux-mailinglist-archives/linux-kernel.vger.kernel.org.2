Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6946E446CFD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 09:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhKFI0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 04:26:24 -0400
Received: from smtpbguseast3.qq.com ([54.243.244.52]:42249 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhKFI0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 04:26:23 -0400
X-QQ-mid: bizesmtp42t1636187009tfv3czrk
Received: from localhost.localdomain (unknown [218.94.48.178])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 06 Nov 2021 16:23:20 +0800 (CST)
X-QQ-SSF: 01400000000000Z0Z000000A0000000
X-QQ-FEAT: PiGp83eJkfylU46hdeyC/FtC94gproOiLDGpMY/C+3DkWRINGBskox7qsPNsE
        5YCiph5qH2NFWHrwtoAE6kRLXLdOvQvF+FMAB2in/q4Jqp0mc8uci6GO7JxitxQdG5QSdHI
        sG5VteqGwTzp41rhnOPRGm0PMH9caWhWgilpAICuZ/5ek4vqMEW87X70eVCu/RxkgK4YXyV
        pwzijCJN3ICkZF4e/sLAcvXOxytBcy5C0+XH6yJxsLCEsEE8z+qEtf/7Nre/OqJRLqTt110
        lTh+wCuhPJx9tg4Q6XE3pVeABREbB16PV/8LU8FDbcv4DAGmovc3xTD0F3KnZSRqU/7S/97
        BR0aiWgLjo7biVTAES12wm0JVQbiMoCdYGUbVn0zxc+BDm7Dbd3Y09DBbUxag==
X-QQ-GoodBg: 2
From:   Yue Hu <huyue2@yulong.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, zhangwen@yulong.com,
        geshifei@yulong.com, zbestahu@gmail.com, Yue Hu <huyue2@yulong.com>
Subject: [PATCH v2] erofs: remove useless cache strategy of DELAYEDALLOC
Date:   Sat,  6 Nov 2021 16:23:15 +0800
Message-Id: <20211106082315.25781-1-huyue2@yulong.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:yulong.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DELAYEDALLOC is not used at all, remove related dead code. Also,
remove the blank line at the end of zdata.h.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v2: remove the blank line at the end of zdata.h.

 fs/erofs/zdata.c | 20 --------------------
 fs/erofs/zdata.h |  1 -
 2 files changed, 21 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bcb1b91b234f..812c7c6ae456 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -96,16 +96,9 @@ static void z_erofs_free_pcluster(struct z_erofs_pcluster *pcl)
 	DBG_BUGON(1);
 }
 
-/*
- * a compressed_pages[] placeholder in order to avoid
- * being filled with file pages for in-place decompression.
- */
-#define PAGE_UNALLOCATED     ((void *)0x5F0E4B1D)
-
 /* how to allocate cached pages for a pcluster */
 enum z_erofs_cache_alloctype {
 	DONTALLOC,	/* don't allocate any cached pages */
-	DELAYEDALLOC,	/* delayed allocation (at the time of submitting io) */
 	/*
 	 * try to use cached I/O if page allocation succeeds or fallback
 	 * to in-place I/O instead to avoid any direct reclaim.
@@ -267,10 +260,6 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 			/* I/O is needed, no possible to decompress directly */
 			standalone = false;
 			switch (type) {
-			case DELAYEDALLOC:
-				t = tagptr_init(compressed_page_t,
-						PAGE_UNALLOCATED);
-				break;
 			case TRYALLOC:
 				newpage = erofs_allocpage(pagepool, gfp);
 				if (!newpage)
@@ -1089,15 +1078,6 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	if (!page)
 		goto out_allocpage;
 
-	/*
-	 * the cached page has not been allocated and
-	 * an placeholder is out there, prepare it now.
-	 */
-	if (page == PAGE_UNALLOCATED) {
-		tocache = true;
-		goto out_allocpage;
-	}
-
 	/* process the target tagged pointer */
 	t = tagptr_init(compressed_page_t, page);
 	justfound = tagptr_unfold_tags(t);
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 879df5362777..4a69515dea75 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -179,4 +179,3 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
 #define Z_EROFS_VMAP_GLOBAL_PAGES	2048
 
 #endif
-
-- 
2.17.1



