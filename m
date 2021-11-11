Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F378844D1D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 07:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhKKGKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 01:10:00 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52837 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhKKGJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 01:09:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uw.HkwB_1636610826;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Uw.HkwB_1636610826)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Nov 2021 14:07:07 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/4] mm/damon: Unified access_check function naming rules
Date:   Thu, 11 Nov 2021 14:07:01 +0800
Message-Id: <556ab139a12296744d25f76b99f4e6b7ccfaf131.1636610337.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1636610337.git.xhao@linux.alibaba.com>
References: <cover.1636610337.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In damon/paddr.c file, two functions names start with underscore,
	static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
			struct damon_region *r)
	static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
			struct damon_region *r)
In damon/vaddr.c file, there are also two functions with the same function,
	static void damon_va_prepare_access_check(struct damon_ctx *ctx,
			struct mm_struct *mm, struct damon_region *r)
	static void damon_va_check_access(struct damon_ctx *ctx,
			struct mm_struct *mm, struct damon_region *r)

It makes sense to keep consistent, and it is not easy to be confused with
the function that call them.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 35fe49080ee9..905e0fc8a8ec 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -409,7 +409,7 @@ static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
  * Functions for the access checking of the regions
  */

-static void damon_va_prepare_access_check(struct damon_ctx *ctx,
+static void __damon_va_prepare_access_check(struct damon_ctx *ctx,
 			struct mm_struct *mm, struct damon_region *r)
 {
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
@@ -428,7 +428,7 @@ void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 		if (!mm)
 			continue;
 		damon_for_each_region(r, t)
-			damon_va_prepare_access_check(ctx, mm, r);
+			__damon_va_prepare_access_check(ctx, mm, r);
 		mmput(mm);
 	}
 }
@@ -514,7 +514,7 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  * mm	'mm_struct' for the given virtual address space
  * r	the region to be checked
  */
-static void damon_va_check_access(struct damon_ctx *ctx,
+static void __damon_va_check_access(struct damon_ctx *ctx,
 			       struct mm_struct *mm, struct damon_region *r)
 {
 	static struct mm_struct *last_mm;
@@ -550,7 +550,7 @@ unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 		if (!mm)
 			continue;
 		damon_for_each_region(r, t) {
-			damon_va_check_access(ctx, mm, r);
+			__damon_va_check_access(ctx, mm, r);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 		}
 		mmput(mm);
--
2.31.0
