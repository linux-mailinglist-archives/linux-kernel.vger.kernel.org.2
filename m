Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD53941EDF4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhJAM6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231629AbhJAM6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:58:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C1FD61A58;
        Fri,  1 Oct 2021 12:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633092983;
        bh=ciIFTH+koshisobAk175OpnbuDhfObQoj2NYbacEtPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mlcPA86d6LOknLEz/KXa0fCtlU6p+1EKEK4vYdj2c3Z60ljt9KammdIVajHTXWZ3P
         Gor4B5xZk8XVr3vwJb0pSx/I014iAjIL9gvarNflJNqewQ1uRfB4l7JaTfdMT7vLiB
         wiHKH7rjJrOkuSaKziHlUYv2HbLuuWC95ROOttKVfc1YKkr8lnBXTKWtnKOo87eTpt
         ml/mGnf9PS4OiCHihZxjmS37BYK9v7K3qQJU4NivuyQl7N4YXrTQ60GGmJ8fSgkOx0
         b5J5eg0HezA/s6t//zOS5bCEjCCD6oT2RdYCrrMDJY7vOV9A490s3hznS1rnZuGDfo
         hfA5i7tMWa2Zw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] mm/damon/vaddr: Support DAMON-based Operation Schemes
Date:   Fri,  1 Oct 2021 12:56:00 +0000
Message-Id: <20211001125604.29660-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001125604.29660-1-sj@kernel.org>
References: <20211001125604.29660-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes DAMON's default primitives for virtual address spaces
to support DAMON-based Operation Schemes (DAMOS) by implementing actions
application functions and registering it to the monitoring context.  The
implementation simply links 'madvise()' for related DAMOS actions.  That
is, 'madvise(MADV_WILLNEED)' is called for 'WILLNEED' DAMOS action and
similar for other actions ('COLD', 'PAGEOUT', 'HUGEPAGE', 'NOHUGEPAGE').

So, the kernel space DAMON users can now use the DAMON-based
optimizations with only small amount of code.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/vaddr.c      | 56 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index dbe18b0fb795..be6b6e81e8ee 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -337,6 +337,8 @@ void damon_va_prepare_access_checks(struct damon_ctx *ctx);
 unsigned int damon_va_check_accesses(struct damon_ctx *ctx);
 bool damon_va_target_valid(void *t);
 void damon_va_cleanup(struct damon_ctx *ctx);
+int damon_va_apply_scheme(struct damon_ctx *context, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme);
 void damon_va_set_primitives(struct damon_ctx *ctx);
 
 #endif	/* CONFIG_DAMON_VADDR */
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 58c1fb2aafa9..3e1c74d36bab 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) "damon-va: " fmt
 
+#include <asm-generic/mman-common.h>
 #include <linux/damon.h>
 #include <linux/hugetlb.h>
 #include <linux/mm.h>
@@ -658,6 +659,60 @@ bool damon_va_target_valid(void *target)
 	return false;
 }
 
+#ifndef CONFIG_ADVISE_SYSCALLS
+static int damos_madvise(struct damon_target *target, struct damon_region *r,
+			int behavior)
+{
+	return -EINVAL;
+}
+#else
+static int damos_madvise(struct damon_target *target, struct damon_region *r,
+			int behavior)
+{
+	struct mm_struct *mm;
+	int ret = -ENOMEM;
+
+	mm = damon_get_mm(target);
+	if (!mm)
+		goto out;
+
+	ret = do_madvise(mm, PAGE_ALIGN(r->ar.start),
+			PAGE_ALIGN(r->ar.end - r->ar.start), behavior);
+	mmput(mm);
+out:
+	return ret;
+}
+#endif	/* CONFIG_ADVISE_SYSCALLS */
+
+int damon_va_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme)
+{
+	int madv_action;
+
+	switch (scheme->action) {
+	case DAMOS_WILLNEED:
+		madv_action = MADV_WILLNEED;
+		break;
+	case DAMOS_COLD:
+		madv_action = MADV_COLD;
+		break;
+	case DAMOS_PAGEOUT:
+		madv_action = MADV_PAGEOUT;
+		break;
+	case DAMOS_HUGEPAGE:
+		madv_action = MADV_HUGEPAGE;
+		break;
+	case DAMOS_NOHUGEPAGE:
+		madv_action = MADV_NOHUGEPAGE;
+		break;
+	default:
+		pr_warn("Wrong action %d\n", scheme->action);
+		return -EINVAL;
+	}
+
+	return damos_madvise(t, r, madv_action);
+}
+
 void damon_va_set_primitives(struct damon_ctx *ctx)
 {
 	ctx->primitive.init = damon_va_init;
@@ -667,6 +722,7 @@ void damon_va_set_primitives(struct damon_ctx *ctx)
 	ctx->primitive.reset_aggregated = NULL;
 	ctx->primitive.target_valid = damon_va_target_valid;
 	ctx->primitive.cleanup = NULL;
+	ctx->primitive.apply_scheme = damon_va_apply_scheme;
 }
 
 #include "vaddr-test.h"
-- 
2.17.1

