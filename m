Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890B34339C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhJSPKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233784AbhJSPKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:10:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47DE061260;
        Tue, 19 Oct 2021 15:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634656083;
        bh=d5N+IvBFRwmweN4/K8el4bMBqzn3uHNC4YRxVNrmxn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nyAiOfwr9xmb4qM9YX4g8xXVw3qQIQRDb2zPcwVCKzz/K0Ml3eOFhWHpZiv0wHuRW
         BEmMGs5EQMV1RbeC1Yic3t8J+RLfyEg5AuVMynrZpy03DNIN41x0fG3HlbbhLgGHgp
         CpO3/wlKDLsFezcd74vhxTHam/OkbfYLGC2k7E8flOMO3P/8oa66i5pNwf91h5jN/j
         B9Mcqi43GcWf/ZMhNmAH/EIQnkafiWBpYV2dbDxF4WRonadwPGOXJr/eljGzVNhHxM
         naDGDe3pttbIFFkAO8X9KH/mRDaA1RjH1cx7CXXbbrRcQ3ZMhD18OdhHPgFO70+Ny+
         ZPIUBF7jhn4Fw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] mm/damon/vaddr,paddr: Support pageout prioritization
Date:   Tue, 19 Oct 2021 15:07:24 +0000
Message-Id: <20211019150731.16699-9-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019150731.16699-1-sj@kernel.org>
References: <20211019150731.16699-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes the default monitoring primitives for virtual address
spaces and the physical address sapce to support memory regions
prioritization for 'PAGEOUT' DAMOS action.  It calculates hotness of
each region as weighted sum of 'nr_accesses' and 'age' of the region and
get the priority score as reverse of the hotness, so that cold regions
can be paged out first.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h   |  4 ++++
 mm/damon/paddr.c        | 14 +++++++++++++
 mm/damon/prmtv-common.c | 46 +++++++++++++++++++++++++++++++++++++++++
 mm/damon/prmtv-common.h |  3 +++
 mm/damon/vaddr.c        | 15 ++++++++++++++
 5 files changed, 82 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 999918a07444..bdbb70db5e86 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -421,6 +421,8 @@ bool damon_va_target_valid(void *t);
 void damon_va_cleanup(struct damon_ctx *ctx);
 int damon_va_apply_scheme(struct damon_ctx *context, struct damon_target *t,
 		struct damon_region *r, struct damos *scheme);
+int damon_va_scheme_score(struct damon_ctx *context, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme);
 void damon_va_set_primitives(struct damon_ctx *ctx);
 
 #endif	/* CONFIG_DAMON_VADDR */
@@ -431,6 +433,8 @@ void damon_va_set_primitives(struct damon_ctx *ctx);
 void damon_pa_prepare_access_checks(struct damon_ctx *ctx);
 unsigned int damon_pa_check_accesses(struct damon_ctx *ctx);
 bool damon_pa_target_valid(void *t);
+int damon_pa_scheme_score(struct damon_ctx *context, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme);
 void damon_pa_set_primitives(struct damon_ctx *ctx);
 
 #endif	/* CONFIG_DAMON_PADDR */
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 957ada55de77..a496d6f203d6 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -246,6 +246,19 @@ int damon_pa_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
 	return 0;
 }
 
+int damon_pa_scheme_score(struct damon_ctx *context, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme)
+{
+	switch (scheme->action) {
+	case DAMOS_PAGEOUT:
+		return damon_pageout_score(context, r, scheme);
+	default:
+		break;
+	}
+
+	return DAMOS_MAX_SCORE;
+}
+
 void damon_pa_set_primitives(struct damon_ctx *ctx)
 {
 	ctx->primitive.init = NULL;
@@ -256,4 +269,5 @@ void damon_pa_set_primitives(struct damon_ctx *ctx)
 	ctx->primitive.target_valid = damon_pa_target_valid;
 	ctx->primitive.cleanup = NULL;
 	ctx->primitive.apply_scheme = damon_pa_apply_scheme;
+	ctx->primitive.get_scheme_score = damon_pa_scheme_score;
 }
diff --git a/mm/damon/prmtv-common.c b/mm/damon/prmtv-common.c
index 7e62ee54fb54..92a04f5831d6 100644
--- a/mm/damon/prmtv-common.c
+++ b/mm/damon/prmtv-common.c
@@ -85,3 +85,49 @@ void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
 	put_page(page);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 }
+
+#define DAMON_MAX_SUBSCORE	(100)
+#define DAMON_MAX_AGE_IN_LOG	(32)
+
+int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
+			struct damos *s)
+{
+	unsigned int max_nr_accesses;
+	int freq_subscore;
+	unsigned int age_in_sec;
+	int age_in_log, age_subscore;
+	unsigned int freq_weight = s->quota.weight_nr_accesses;
+	unsigned int age_weight = s->quota.weight_age;
+	int hotness;
+
+	max_nr_accesses = c->aggr_interval / c->sample_interval;
+	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE / max_nr_accesses;
+
+	age_in_sec = (unsigned long)r->age * c->aggr_interval / 1000000;
+	for (age_in_log = 0; age_in_log < DAMON_MAX_AGE_IN_LOG && age_in_sec;
+			age_in_log++, age_in_sec >>= 1)
+		;
+
+	/* If frequency is 0, higher age means it's colder */
+	if (freq_subscore == 0)
+		age_in_log *= -1;
+
+	/*
+	 * Now age_in_log is in [-DAMON_MAX_AGE_IN_LOG, DAMON_MAX_AGE_IN_LOG].
+	 * Scale it to be in [0, 100] and set it as age subscore.
+	 */
+	age_in_log += DAMON_MAX_AGE_IN_LOG;
+	age_subscore = age_in_log * DAMON_MAX_SUBSCORE /
+		DAMON_MAX_AGE_IN_LOG / 2;
+
+	hotness = (freq_weight * freq_subscore + age_weight * age_subscore);
+	if (freq_weight + age_weight)
+		hotness /= freq_weight + age_weight;
+	/*
+	 * Transform it to fit in [0, DAMOS_MAX_SCORE]
+	 */
+	hotness = hotness * DAMOS_MAX_SCORE / DAMON_MAX_SUBSCORE;
+
+	/* Return coldness of the region */
+	return DAMOS_MAX_SCORE - hotness;
+}
diff --git a/mm/damon/prmtv-common.h b/mm/damon/prmtv-common.h
index 7093d19e5d42..61f27037603e 100644
--- a/mm/damon/prmtv-common.h
+++ b/mm/damon/prmtv-common.h
@@ -15,3 +15,6 @@ struct page *damon_get_page(unsigned long pfn);
 
 void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
+
+int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
+			struct damos *s);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 758501b8d97d..675cd8c7df9b 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -633,6 +633,20 @@ int damon_va_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
 	return damos_madvise(t, r, madv_action);
 }
 
+int damon_va_scheme_score(struct damon_ctx *context, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme)
+{
+
+	switch (scheme->action) {
+	case DAMOS_PAGEOUT:
+		return damon_pageout_score(context, r, scheme);
+	default:
+		break;
+	}
+
+	return DAMOS_MAX_SCORE;
+}
+
 void damon_va_set_primitives(struct damon_ctx *ctx)
 {
 	ctx->primitive.init = damon_va_init;
@@ -643,6 +657,7 @@ void damon_va_set_primitives(struct damon_ctx *ctx)
 	ctx->primitive.target_valid = damon_va_target_valid;
 	ctx->primitive.cleanup = NULL;
 	ctx->primitive.apply_scheme = damon_va_apply_scheme;
+	ctx->primitive.get_scheme_score = damon_va_scheme_score;
 }
 
 #include "vaddr-test.h"
-- 
2.17.1

