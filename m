Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB336446CF9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 09:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhKFIOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 04:14:16 -0400
Received: from smtpbguseast3.qq.com ([54.243.244.52]:36703 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhKFIOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 04:14:15 -0400
X-QQ-mid: bizesmtp33t1636186279tvwp0k76
Received: from localhost.localdomain (unknown [218.94.48.178])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 06 Nov 2021 16:11:06 +0800 (CST)
X-QQ-SSF: 01400000000000Z0Z000B00A0000000
X-QQ-FEAT: 3uawQE1sH+2vGgiHXOOPTcN3eogYudOGeZ0/H+BgLJlyaPqdCmMa2YMLCjtuy
        BrK06CwiB08EFMShwuVeJhFKsnCaL8cPiR39E4EVeP2+IvShdggsaudzG/BTkq3oht7orpo
        2i5Dd9+22wVsRGKcCvinhtGS71ON1gHEGbdYO1/Fjh80lvUEVb7w6ljR82YvPTyJGLUapbS
        Qg9Lh0DkydHpS0cGPdySs0QegZxJIKvaBgUqHHdciNTGGcY5Nx05u4e+u8ZsZTVn5vFFSLm
        FU3USSDoBRihjGiCJLyvtSq4JvyBuLAtPqgYDWOeRP9nvB2pM6p30qO+9yX1FZm9zR8rlDG
        x9cBUrLFMj9RgCcHplp97bKElp5piXPwp/+f+Aw
X-QQ-GoodBg: 2
From:   Yue Hu <huyue2@yulong.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, zhangwen@yulong.com,
        geshifei@yulong.com, zbestahu@gmail.com, Yue Hu <huyue2@yulong.com>
Subject: [PATCH] erofs: remove useless cache strategy of DELAYEDALLOC
Date:   Sat,  6 Nov 2021 16:11:00 +0800
Message-Id: <20211106081100.21478-1-huyue2@yulong.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:yulong.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DELAYEDALLOC is not used at all, remove related dead code.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/zdata.c | 20 --------------------
 1 file changed, 20 deletions(-)

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
-- 
2.17.1



