Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBF33962E2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 17:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhEaPCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 11:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbhEaOGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:06:33 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01F7C08C5EC;
        Mon, 31 May 2021 06:38:42 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id q6so5516126qvb.2;
        Mon, 31 May 2021 06:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+6bCyXjso+WpVBQaujE86WjgkNPOriN2PNEeNMasASY=;
        b=TW2KePUy0UIbJ3YZdsbRc/p+OprAHsNxx8eDrHBZ+1VI4oqAfMmsPA6BwUneijrk2t
         WKGSX58V0f/YtV+yEd3F3XWoGftGCtT2EewODJ3hEn9wsBd1KE9gHMW5BQPPe+AlyuVp
         QuGnT2tMR34oq52ANCzu701qrNL8OMnieZOcbheh4ncJ6cqWjK4Ew/qZdT1cg9HLi2R3
         5RlMWRuiGIiHBn1Z+XVPMesf5igOBGB1grF9COBzPT7uJLvvYtrLE+MBFY0FvNI18o0q
         AcwGlX2lmM6Zy031KNMVAPV1//AnZv8Mf6qcMK/qOLEIj2N81wnB5+M/rTD8pPoz/4m7
         ga9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+6bCyXjso+WpVBQaujE86WjgkNPOriN2PNEeNMasASY=;
        b=CpiWLq97dRaVMeKvdgSH3J41CRFkzKXnucdYs5ZY3jlptT1atZ5/66VKhTQ4+gX1Zw
         GfBsL7QVPPal+08+rK0i4A71vPYzibLigaOPIHrf2/zltD2MS53btUfE/uNNqWo4LkPq
         H3sBpUX+bBERbbZJd1UJYRHA2b5Z3zbGjOoHltGFKatADqztH7Bw6U7ruf98iprfrUtj
         iaewf00erKg06thAfPAuVdIbrRL+ynefCJ7BNPY257xqBex/rv6Zlv/uvynVVkrgiS4V
         gsIXDW+kiZKUBu86+XQ0lefw/r+T8bcS2B7H+ZdVrg9ungAhu6QsTHzMNFtspBTz2sua
         FCmQ==
X-Gm-Message-State: AOAM5338IUPm7BxeEXty0o4sR0YjZYMQlYtPrpPJ+poU0DMqkfVFW8v3
        PmHePyYJdl2TkUqC0k4RhNk=
X-Google-Smtp-Source: ABdhPJx3XngfcsYG6d8C1Hu99ZZq7CPM8TBDNhlRwRBOTOYK9XsaglNwd2WlGN/UVkGV+PeaOZRs/w==
X-Received: by 2002:a0c:ff03:: with SMTP id w3mr16935621qvt.6.1622468322026;
        Mon, 31 May 2021 06:38:42 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h8sm8293085qtp.46.2021.05.31.06.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 06:38:41 -0700 (PDT)
From:   sj38.park@gmail.com
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sj38.park@gmail.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/13] mm/damon/vaddr,paddr: Support pageout prioritization
Date:   Mon, 31 May 2021 13:38:10 +0000
Message-Id: <20210531133816.12689-8-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210531133816.12689-1-sj38.park@gmail.com>
References: <20210531133816.12689-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit makes the default monitoring primitives for virtual address
spaces and the physical address sapce to support memory regions
prioritization for 'PAGEOUT' DAMOS action.  It calculates hotness of
each region as weighted sum of 'nr_accesses' and 'age' of the region and
get the priority score as reverse of the hotness, so that cold regions
can be paged out first.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h   |  4 ++++
 mm/damon/paddr.c        | 14 +++++++++++++
 mm/damon/prmtv-common.c | 46 +++++++++++++++++++++++++++++++++++++++++
 mm/damon/prmtv-common.h |  3 +++
 mm/damon/vaddr.c        | 15 ++++++++++++++
 5 files changed, 82 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 8f35bd94fc2b..565f49d8ba44 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -428,6 +428,8 @@ bool damon_va_target_valid(void *t);
 void damon_va_cleanup(struct damon_ctx *ctx);
 int damon_va_apply_scheme(struct damon_ctx *context, struct damon_target *t,
 		struct damon_region *r, struct damos *scheme);
+int damon_va_scheme_score(struct damon_ctx *context, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme);
 void damon_va_set_primitives(struct damon_ctx *ctx);
 
 #endif	/* CONFIG_DAMON_VADDR */
@@ -438,6 +440,8 @@ void damon_va_set_primitives(struct damon_ctx *ctx);
 void damon_pa_prepare_access_checks(struct damon_ctx *ctx);
 unsigned int damon_pa_check_accesses(struct damon_ctx *ctx);
 bool damon_pa_target_valid(void *t);
+int damon_pa_scheme_score(struct damon_ctx *context, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme);
 void damon_pa_set_primitives(struct damon_ctx *ctx);
 
 #endif	/* CONFIG_DAMON_PADDR */
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 303db372e53b..99a579e8d046 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -121,6 +121,19 @@ int damon_pa_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
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
@@ -131,4 +144,5 @@ void damon_pa_set_primitives(struct damon_ctx *ctx)
 	ctx->primitive.target_valid = damon_pa_target_valid;
 	ctx->primitive.cleanup = NULL;
 	ctx->primitive.apply_scheme = damon_pa_apply_scheme;
+	ctx->primitive.get_scheme_score = damon_pa_scheme_score;
 }
diff --git a/mm/damon/prmtv-common.c b/mm/damon/prmtv-common.c
index 01c1c1b37859..ca637a2bf7d8 100644
--- a/mm/damon/prmtv-common.c
+++ b/mm/damon/prmtv-common.c
@@ -236,3 +236,49 @@ bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
 	*page_sz = result.page_sz;
 	return result.accessed;
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
+	unsigned int freq_weight = s->limit.weight_nr_accesses;
+	unsigned int age_weight = s->limit.weight_age;
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
index ba0c4eecbb79..b27c4e94917e 100644
--- a/mm/damon/prmtv-common.h
+++ b/mm/damon/prmtv-common.h
@@ -26,3 +26,6 @@ bool damon_va_young(struct mm_struct *mm, unsigned long addr,
 
 void damon_pa_mkold(unsigned long paddr);
 bool damon_pa_young(unsigned long paddr, unsigned long *page_sz);
+
+int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
+			struct damos *s);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index de54ca70955d..cc70991076be 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -525,6 +525,20 @@ int damon_va_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
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
@@ -535,6 +549,7 @@ void damon_va_set_primitives(struct damon_ctx *ctx)
 	ctx->primitive.target_valid = damon_va_target_valid;
 	ctx->primitive.cleanup = damon_va_cleanup;
 	ctx->primitive.apply_scheme = damon_va_apply_scheme;
+	ctx->primitive.get_scheme_score = damon_va_scheme_score;
 }
 
 #include "vaddr-test.h"
-- 
2.17.1

