Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBCA450855
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 16:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbhKOPdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 10:33:16 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:55040 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236407AbhKOPbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 10:31:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UwkTWPf_1636990097;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UwkTWPf_1636990097)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Nov 2021 23:28:21 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 4/4] mm/damon: Remove some no need func definitions in damon.h file
Date:   Mon, 15 Nov 2021 23:26:15 +0800
Message-Id: <45fd5b3ef6cce8e28dbc1c92f9dc845ccfc949d7.1636989871.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1636989871.git.xhao@linux.alibaba.com>
References: <cover.1636989871.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the damon.h header file, some func definitions about VA & PA
can only be used in its own file, so there no need to define in
the header file, and the header file will looks cleaner.

If other files later call these functions, then put them to the
header file will not be late.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 25 ++-----------------------
 mm/damon/paddr.c      |  8 ++++----
 mm/damon/vaddr.c      | 12 ++++++------
 3 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 321de9d72360..8a73e825e0d5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -461,34 +461,13 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 #endif	/* CONFIG_DAMON */

 #ifdef CONFIG_DAMON_VADDR
-
-/* Monitoring primitives for virtual memory address spaces */
-void damon_va_init(struct damon_ctx *ctx);
-void damon_va_update(struct damon_ctx *ctx);
-void damon_va_prepare_access_checks(struct damon_ctx *ctx);
-unsigned int damon_va_check_accesses(struct damon_ctx *ctx);
-bool damon_va_target_valid(void *t);
-void damon_va_cleanup(struct damon_ctx *ctx);
-int damon_va_apply_scheme(struct damon_ctx *context, struct damon_target *t,
-		struct damon_region *r, struct damos *scheme);
-int damon_va_scheme_score(struct damon_ctx *context, struct damon_target *t,
-		struct damon_region *r, struct damos *scheme);
 void damon_va_set_primitives(struct damon_ctx *ctx);
-
+bool damon_va_target_valid(void *t);
 #endif	/* CONFIG_DAMON_VADDR */

 #ifdef CONFIG_DAMON_PADDR
-
-/* Monitoring primitives for the physical memory address space */
-void damon_pa_prepare_access_checks(struct damon_ctx *ctx);
-unsigned int damon_pa_check_accesses(struct damon_ctx *ctx);
-bool damon_pa_target_valid(void *t);
-int damon_pa_apply_scheme(struct damon_ctx *context, struct damon_target *t,
-		struct damon_region *r, struct damos *scheme);
-int damon_pa_scheme_score(struct damon_ctx *context, struct damon_target *t,
-		struct damon_region *r, struct damos *scheme);
 void damon_pa_set_primitives(struct damon_ctx *ctx);
-
+bool damon_pa_target_valid(void *t);
 #endif	/* CONFIG_DAMON_PADDR */

 #endif	/* _DAMON_H */
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index a496d6f203d6..5c3a29d32638 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -73,7 +73,7 @@ static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
 	damon_pa_mkold(r->sampling_addr);
 }

-void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
+static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	struct damon_region *r;
@@ -192,7 +192,7 @@ static void __damon_pa_check_access(struct damon_ctx *ctx,
 	last_addr = r->sampling_addr;
 }

-unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
+static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	struct damon_region *r;
@@ -213,7 +213,7 @@ bool damon_pa_target_valid(void *t)
 	return true;
 }

-int damon_pa_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
+static int damon_pa_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos *scheme)
 {
 	unsigned long addr;
@@ -246,7 +246,7 @@ int damon_pa_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
 	return 0;
 }

-int damon_pa_scheme_score(struct damon_ctx *context, struct damon_target *t,
+static int damon_pa_scheme_score(struct damon_ctx *context, struct damon_target *t,
 		struct damon_region *r, struct damos *scheme)
 {
 	switch (scheme->action) {
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 905e0fc8a8ec..eb1e955b5aba 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -271,7 +271,7 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 }

 /* Initialize '->regions_list' of every target (task) */
-void damon_va_init(struct damon_ctx *ctx)
+static void damon_va_init(struct damon_ctx *ctx)
 {
 	struct damon_target *t;

@@ -355,7 +355,7 @@ static void damon_va_apply_three_regions(struct damon_target *t,
 /*
  * Update regions for current memory mappings
  */
-void damon_va_update(struct damon_ctx *ctx)
+static void damon_va_update(struct damon_ctx *ctx)
 {
 	struct damon_addr_range three_regions[3];
 	struct damon_target *t;
@@ -417,7 +417,7 @@ static void __damon_va_prepare_access_check(struct damon_ctx *ctx,
 	damon_va_mkold(mm, r->sampling_addr);
 }

-void damon_va_prepare_access_checks(struct damon_ctx *ctx)
+static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	struct mm_struct *mm;
@@ -538,7 +538,7 @@ static void __damon_va_check_access(struct damon_ctx *ctx,
 	last_addr = r->sampling_addr;
 }

-unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
+static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	struct mm_struct *mm;
@@ -602,7 +602,7 @@ static int damos_madvise(struct damon_target *target, struct damon_region *r,
 }
 #endif	/* CONFIG_ADVISE_SYSCALLS */

-int damon_va_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
+static int damon_va_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos *scheme)
 {
 	int madv_action;
@@ -633,7 +633,7 @@ int damon_va_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
 	return damos_madvise(t, r, madv_action);
 }

-int damon_va_scheme_score(struct damon_ctx *context, struct damon_target *t,
+static int damon_va_scheme_score(struct damon_ctx *context, struct damon_target *t,
 		struct damon_region *r, struct damos *scheme)
 {

--
2.31.0
