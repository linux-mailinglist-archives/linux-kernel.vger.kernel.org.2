Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0FB3CFA67
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbhGTMgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238614AbhGTMds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:33:48 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E55AC061574;
        Tue, 20 Jul 2021 06:14:25 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id p10so10055235qvk.7;
        Tue, 20 Jul 2021 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JHj2ZHEcS9mBmBj4jaozpyE80ZCeNHUxWZ52QHE8I0I=;
        b=XCcGcB1VWhx+FVmMWzQW+oKjCj63Hi3DokARapYCmKWY+d72h1cIyuWtouMTmekjqv
         35a/dfYZ57s0A1y2Kg57mYgt9Y7ZIh81KVCfJ7CGneylbt07Xt+xKtAf6RrfLLhJhsMu
         y9zBfzj0l9Y12GMvh+hJO1b+z8T01IyFM+RjVLG5FJksl4GXgbfRo7WXgeQZM3gRsBIQ
         osWqpQ0MYTo4THRVj5km6R+MIpZaiPOp7UC9TP9ljqZ9SdEsVy+yrBhlIZvaPJ/xeKED
         uQoYQXvVUMRoA5Zv1VYGt/E6frXOXYqHGcIisFjYLIbjj37vzK3K+AsQ48gciPKs5Q+K
         C/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JHj2ZHEcS9mBmBj4jaozpyE80ZCeNHUxWZ52QHE8I0I=;
        b=WzYLOvAMfBRY5scD6ZPAoe3Qa72M4MkitrkyGjOZiswkyAoPBE8+LvzmuBZVtVujrc
         Hc8gOfFgTP+v5AldxJtlwp63sL7cOWGpu493TVMTj3DcGZhB5sCxD+9WTL908Ol3N6Lb
         Ua4zb8pSoFzgH0UqHFDRKJFVirYB2UQloiWSqDSl/Z6WW7XhqVeGe+brzmu9YC7i5HsB
         /bXodC2Za1yKxHMPHih2qPfxlNbfDBRbNQzX6ua62nF7VZAHiD+HZVGgplVJaiAtDAxj
         GoLxa5HERX8AH2+7gXLQsl/4JirU6owKdnzjSSLPsjAFnDx/Xl04a6lHgrShSwmvpVSq
         vNtg==
X-Gm-Message-State: AOAM532gFMvGoUCFCm7c5OhZqumuNGrPAA1DvY0WhhxMft9IgIj9HbY+
        AdiuBfICy8rp0Vuz67gkdVs=
X-Google-Smtp-Source: ABdhPJwlwW4Oth3j8RLu6cIQkn4HCGL7sOwB7VQUf8JwQ2A7MK/6BNtR8TdBjcVwRh7YofvDLnOjSw==
X-Received: by 2002:a05:6214:242b:: with SMTP id gy11mr30339892qvb.9.1626786864225;
        Tue, 20 Jul 2021 06:14:24 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g17sm9701225qkm.34.2021.07.20.06.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:14:23 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, joe@perches.com,
        mgorman@suse.de, mheyne@amazon.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sieberf@amazon.com, sj38.park@gmail.com, snu@zelle79.org,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v3 08/15] mm/damon/vaddr,paddr: Support pageout prioritization
Date:   Tue, 20 Jul 2021 13:13:02 +0000
Message-Id: <20210720131309.22073-9-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720131309.22073-1-sj38.park@gmail.com>
References: <20210720131309.22073-1-sj38.park@gmail.com>
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
index ddea4b4f3bfa..f56f04b63b1c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -449,6 +449,8 @@ bool damon_va_target_valid(void *t);
 void damon_va_cleanup(struct damon_ctx *ctx);
 int damon_va_apply_scheme(struct damon_ctx *context, struct damon_target *t,
 		struct damon_region *r, struct damos *scheme);
+int damon_va_scheme_score(struct damon_ctx *context, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme);
 void damon_va_set_primitives(struct damon_ctx *ctx);
 
 #endif	/* CONFIG_DAMON_VADDR */
@@ -459,6 +461,8 @@ void damon_va_set_primitives(struct damon_ctx *ctx);
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
index 01c1c1b37859..1df31d1f8590 100644
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
index ee4cbe12ac30..38d5434315e4 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -515,6 +515,20 @@ int damon_va_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
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
@@ -525,6 +539,7 @@ void damon_va_set_primitives(struct damon_ctx *ctx)
 	ctx->primitive.target_valid = damon_va_target_valid;
 	ctx->primitive.cleanup = NULL;
 	ctx->primitive.apply_scheme = damon_va_apply_scheme;
+	ctx->primitive.get_scheme_score = damon_va_scheme_score;
 }
 
 #include "vaddr-test.h"
-- 
2.17.1

