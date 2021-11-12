Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9664944EAFE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbhKLQFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:05:49 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:50423 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235371AbhKLQFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:05:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UwDEbXc_1636732963;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UwDEbXc_1636732963)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 13 Nov 2021 00:02:47 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/4] mm/damon: Remove some no need func definitions in damon.h file
Date:   Sat, 13 Nov 2021 00:02:42 +0800
Message-Id: <d66fa6d5d19d9a4e7ff814c729f96b9c2d443f40.1636732449.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1636732449.git.xhao@linux.alibaba.com>
References: <cover.1636732449.git.xhao@linux.alibaba.com>
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
 1 file changed, 2 insertions(+), 23 deletions(-)

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
--
2.31.0
