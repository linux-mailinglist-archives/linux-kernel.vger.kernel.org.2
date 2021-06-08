Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83B839F5AF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhFHLzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbhFHLzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:55:35 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EA8C061574;
        Tue,  8 Jun 2021 04:53:28 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id p21so3249405qtw.6;
        Tue, 08 Jun 2021 04:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+6bCyXjso+WpVBQaujE86WjgkNPOriN2PNEeNMasASY=;
        b=Z5y/g8TDzpDeUlu2xE8q86uL+v7AvXqMVqOPhy85ZrOfsposhhFmoDYqcr1j8ec3Eb
         QIdIWbxTEnqqLfMRrEfLHJvP+gcagLwfcrJLau9EBjixbCHcmTOTKAi1vNHwd3/YiwF4
         8xYlxLG1oyvZaoa1K7Clp3os9xxLmW3HlurRe730YQdmuW9Mkg6v7CE3IHjgx9CNqg+V
         XB41V6n4ts3VkO7dL7btbje0KmdVWsMWjvQzapMTEFYBnvc1loE5qC4VS/eXMCKC4p/7
         vZf9momFfZ8ZfGhEG1SPyYwB9GpdFCyCykX2JqNm0HtPEAGHe9OBijNCQcVVbnrSHuJ6
         lNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+6bCyXjso+WpVBQaujE86WjgkNPOriN2PNEeNMasASY=;
        b=bbzc6T4vu0jo++XpBXXrEdU96H5DNL9nGYEw57zx2uQB16v8/Y4ns1GI9TLNtAblU8
         reu5CL23xzPLU9q5n9yCg5JlwKlXTOMujOauDKnJXkKKjhsSHbAFgj6o0UIChWHsXn0O
         8JBdCpTiogXbDgPLzn0V4mz3DPpZczqemkZnDwp30lcF939wc3CTqNZMZnaUJV5O1Pp8
         XU2Pxlo/+ZqTICXj8M2A+A2WMvKVkgcsjIvWlwD/rsTLDk+UaMWfBuSyo4nvcKUopqEa
         ZcWftmM3KXAktefRSyVzmuFvW60qKQEgAw6acTf3Mmf7dS9JfB14mGdHLc1zDathpu8x
         dDrg==
X-Gm-Message-State: AOAM53196idqsh/Ep+6b8IBG8M7yrSXbHXSZQYEISErh2890OtbKyIDS
        UyKfnUpTagPQQtvHYJxwuO0=
X-Google-Smtp-Source: ABdhPJzXaV675n2DfDHG1S32dUgL3bTc/YEy+K40RwUoByCs65CoLTJ/Cd4bBQsty9S7vmVcDOiOfA==
X-Received: by 2002:ac8:670f:: with SMTP id e15mr20699929qtp.291.1623153207187;
        Tue, 08 Jun 2021 04:53:27 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h4sm2133927qth.66.2021.06.08.04.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:53:26 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, shakeelb@google.com,
        shuah@kernel.org, sj38.park@gmail.com, snu@zelle79.org,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 07/14] mm/damon/vaddr,paddr: Support pageout prioritization
Date:   Tue,  8 Jun 2021 11:52:47 +0000
Message-Id: <20210608115254.11930-8-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608115254.11930-1-sj38.park@gmail.com>
References: <20210608115254.11930-1-sj38.park@gmail.com>
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

