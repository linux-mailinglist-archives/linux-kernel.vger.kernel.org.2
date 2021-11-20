Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD6E457FDA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 18:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbhKTRbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 12:31:03 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:58361 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237885AbhKTRbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 12:31:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UxSuoAS_1637429275;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UxSuoAS_1637429275)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 21 Nov 2021 01:27:57 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 2/2] mm/damon: move damon_rand definition into damon.h
Date:   Sun, 21 Nov 2021 01:27:54 +0800
Message-Id: <6a4a7e53c2ab99028d431e7dc5e3d7635adb8522.1637429074.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <fbf27c39e8f23d12d5474b9b659d3d45f8dd38ca.1637429074.git.xhao@linux.alibaba.com>
References: <fbf27c39e8f23d12d5474b9b659d3d45f8dd38ca.1637429074.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

damon_rand() is called in three files:damon/core.c, damon/
paddr.c, damon/vaddr.c, i think there is no need to redefine
this twice, So move it to damon.h will be a good choice.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 include/linux/damon.h   | 4 ++++
 mm/damon/core.c         | 4 ----
 mm/damon/prmtv-common.h | 4 ----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 8a73e825e0d5..8706b17a9acf 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -11,12 +11,16 @@
 #include <linux/mutex.h>
 #include <linux/time64.h>
 #include <linux/types.h>
+#include <linux/random.h>
 
 /* Minimal region size.  Every damon_region is aligned by this. */
 #define DAMON_MIN_REGION	PAGE_SIZE
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
 
+/* Get a random number in [l, r) */
+#define damon_rand(l, r) (l + prandom_u32_max(r - l))
+
 /**
  * struct damon_addr_range - Represents an address region of [@start, @end).
  * @start:	Start address of the region (inclusive).
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4d2c3a0c7c8a..bdec32ef78c0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -11,7 +11,6 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/mm.h>
-#include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 
@@ -23,9 +22,6 @@
 #define DAMON_MIN_REGION 1
 #endif
 
-/* Get a random number in [l, r) */
-#define damon_rand(l, r) (l + prandom_u32_max(r - l))
-
 static DEFINE_MUTEX(damon_lock);
 static int nr_running_ctxs;
 
diff --git a/mm/damon/prmtv-common.h b/mm/damon/prmtv-common.h
index 61f27037603e..e790cb5f8fe0 100644
--- a/mm/damon/prmtv-common.h
+++ b/mm/damon/prmtv-common.h
@@ -6,10 +6,6 @@
  */
 
 #include <linux/damon.h>
-#include <linux/random.h>
-
-/* Get a random number in [l, r) */
-#define damon_rand(l, r) (l + prandom_u32_max(r - l))
 
 struct page *damon_get_page(unsigned long pfn);
 
-- 
2.31.0

