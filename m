Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7815B396252
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 16:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhEaOyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 10:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbhEaODe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:03:34 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B930FC08C5C7;
        Mon, 31 May 2021 06:38:32 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id v8so11203266qkv.1;
        Mon, 31 May 2021 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t1F8jnQQ+LCF0fotUTe7jc79EOu+L4zKBGRAtX6U7cg=;
        b=rY0bnwHG6H5x/WYEEHlSas99makyxnwoAEa8yTNZx76lWQMsUPTjEX1FSQ6DnLdbDA
         CO6WaZWmk5PCDnwMb8h8W0KX+PaUENkcxoga8+pM8MIqqVkn+tB5vzRzzlE+HviFvbrN
         +PPVDPH9zxi7N83mL1+w1NcVCzynb4WVdsRtNQq/eiIOb4s6pDfnzRk/7U4fAbQJvudM
         83gnZYLw8mwB5svEKUAgz0Ecx73IX85ag1bdbiXfscdn7QiMfKkY9i6ql+z/aBEyqg27
         Z/dDttq1PKm4nr9DlA2kFrNcLCMBEFwCa0qqD2Zs3ETruq2323zI4iFCaPv9EHUHac0r
         +gsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t1F8jnQQ+LCF0fotUTe7jc79EOu+L4zKBGRAtX6U7cg=;
        b=cGNINvgk99X+TkwJTNFvAoXv54YytmadnXsPHyIGknlKiOo8bbllRL/SPU8u9ECEMO
         9X7+4Ldc2FISGP+yP9F+iY3rHobqPJjXxK9ivzB0uIqi7GP0KQ30EasUbfaGgzTcfqn7
         FEkczWGwhNzZKC4gzpbzM2cD8Hrymez5t8rKPaZcgbojGL70pHkvlDtLRSy2R/ihp+bp
         uSXgDiWFD9TR5jGUFsP00j/w3/AHxKnL+IWebNhw8RYKO+BxjOVl/pf2AKnCr3mGnm1/
         B4gfBY29gGDpzwJ9YQgYk2cMgzxVLLumkSSZ3bV8F+WGIXVmsb1aKtY1nJluWy9OIDZb
         F5Sg==
X-Gm-Message-State: AOAM531seyQIz+L6EGf3e2K5F8oSavyYNuM4wOsIATIeWdvrQFKRUMzb
        et4aXXfx2e17i0/0sgVLalg=
X-Google-Smtp-Source: ABdhPJy9tF0PaJ8UYRHDDHFAFxYARG89pX79r9lGYqa/+4eoWC+g61pS5wae8Fu8HOkwZiQikZgs2Q==
X-Received: by 2002:a37:a092:: with SMTP id j140mr16802567qke.382.1622468311855;
        Mon, 31 May 2021 06:38:31 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h8sm8293085qtp.46.2021.05.31.06.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 06:38:31 -0700 (PDT)
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
Subject: [RFC PATCH 02/13] mm/damon/damos: Make schemes aggressiveness controllable
Date:   Mon, 31 May 2021 13:38:05 +0000
Message-Id: <20210531133816.12689-3-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210531133816.12689-1-sj38.park@gmail.com>
References: <20210531133816.12689-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

If there are too large memory regions fulfilling the target data access
pattern of a DAMON-based operation scheme, applying the action of the
scheme could consume too much CPU.  To avoid that, this commit
implements a limit for the action application speed.  Using the feature,
the client can set up to how much amount of memory regions the action
could applied within specific time duration.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h | 34 +++++++++++++++++++++++++++----
 mm/damon/core.c       | 47 +++++++++++++++++++++++++++++++++++++------
 mm/damon/dbgfs.c      |  4 +++-
 3 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 684a3603ddac..35068b0ece6f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -87,6 +87,25 @@ enum damos_action {
 	DAMOS_STAT,		/* Do nothing but only record the stat */
 };
 
+/**
+ * struct damos_speed_limit - Controls the aggressiveness of the given scheme.
+ * @sz:			Scheme action amount limit in bytes.
+ * @ms:			Scheme action amount charge duration.
+ *
+ * To avoid consuming too much CPU time for applying the &struct damos->action
+ * to large memory, DAMON applies it to only up to &sz bytes within &ms.
+ *
+ * If &sz is 0, the limit is disabled.
+ */
+struct damos_speed_limit {
+	unsigned long sz;
+	unsigned long ms;
+
+/* private: for limit accounting */
+	unsigned long charged_sz;
+	unsigned long charged_from;
+};
+
 /**
  * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
  * @min_sz_region:	Minimum size of target regions.
@@ -96,13 +115,19 @@ enum damos_action {
  * @min_age_region:	Minimum age of target regions.
  * @max_age_region:	Maximum age of target regions.
  * @action:		&damo_action to be applied to the target regions.
+ * @limit:		Control the aggressiveness of this scheme.
  * @stat_count:		Total number of regions that this scheme is applied.
  * @stat_sz:		Total size of regions that this scheme is applied.
  * @list:		List head for siblings.
  *
- * For each aggregation interval, DAMON applies @action to monitoring target
- * regions fit in the condition and updates the statistics.  Note that both
- * the minimums and the maximums are inclusive.
+ * For each aggregation interval, DAMON finds regions which fit in the
+ * condition (&min_sz_region, &max_sz_region, &min_nr_accesses,
+ * &max_nr_accesses, &min_age_region, &max_age_region) and applies &action to
+ * those.  To avoid consuming too much CPU for the &action, &limit is used.
+ *
+ * After applying the &action to each region, &stat_count and &stat_sz is
+ * updated to reflect the number of regions and total size of regions that the
+ * &action is applied.
  */
 struct damos {
 	unsigned long min_sz_region;
@@ -112,6 +137,7 @@ struct damos {
 	unsigned int min_age_region;
 	unsigned int max_age_region;
 	enum damos_action action;
+	struct damos_speed_limit limit;
 	unsigned long stat_count;
 	unsigned long stat_sz;
 	struct list_head list;
@@ -335,7 +361,7 @@ struct damos *damon_new_scheme(
 		unsigned long min_sz_region, unsigned long max_sz_region,
 		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
 		unsigned int min_age_region, unsigned int max_age_region,
-		enum damos_action action);
+		enum damos_action action, struct damos_speed_limit *limit);
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
 void damon_destroy_scheme(struct damos *s);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index a33b3a3b9e57..df784c72ea80 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -85,7 +85,7 @@ struct damos *damon_new_scheme(
 		unsigned long min_sz_region, unsigned long max_sz_region,
 		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
 		unsigned int min_age_region, unsigned int max_age_region,
-		enum damos_action action)
+		enum damos_action action, struct damos_speed_limit *limit)
 {
 	struct damos *scheme;
 
@@ -103,6 +103,11 @@ struct damos *damon_new_scheme(
 	scheme->stat_sz = 0;
 	INIT_LIST_HEAD(&scheme->list);
 
+	scheme->limit.sz = limit->sz;
+	scheme->limit.ms = limit->ms;
+	scheme->limit.charged_sz = 0;
+	scheme->limit.charged_from = 0;
+
 	return scheme;
 }
 
@@ -536,6 +541,9 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	}
 }
 
+static void damon_split_region_at(struct damon_ctx *ctx,
+				  struct damon_region *r, unsigned long sz_r);
+
 static void damon_do_apply_schemes(struct damon_ctx *c,
 				   struct damon_target *t,
 				   struct damon_region *r)
@@ -544,7 +552,14 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 	unsigned long sz;
 
 	damon_for_each_scheme(s, c) {
+		struct damos_speed_limit *limit = &s->limit;
+
+		/* Check the limit */
+		if (limit->sz && limit->charged_sz >= limit->sz)
+			continue;
+
 		sz = r->ar.end - r->ar.start;
+		/* Check the target regions condition */
 		if (sz < s->min_sz_region || s->max_sz_region < sz)
 			continue;
 		if (r->nr_accesses < s->min_nr_accesses ||
@@ -552,22 +567,42 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			continue;
 		if (r->age < s->min_age_region || s->max_age_region < r->age)
 			continue;
-		s->stat_count++;
-		s->stat_sz += sz;
-		if (c->primitive.apply_scheme)
+
+		/* Apply the scheme */
+		if (c->primitive.apply_scheme) {
+			if (limit->sz && limit->charged_sz + sz > limit->sz) {
+				sz = limit->sz - limit->charged_sz;
+				damon_split_region_at(c, r, sz);
+			}
 			c->primitive.apply_scheme(c, t, r, s);
+			limit->charged_sz += sz;
+		}
 		if (s->action != DAMOS_STAT)
 			r->age = 0;
+
+		/* Update stat */
+		s->stat_count++;
+		s->stat_sz += sz;
 	}
 }
 
 static void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
-	struct damon_region *r;
+	struct damon_region *r, *next_r;
+	struct damos *s;
+
+	damon_for_each_scheme(s, c) {
+		/* Reset charge window if the duration passed */
+		if (time_after_eq(jiffies, s->limit.charged_from +
+					msecs_to_jiffies(s->limit.ms))) {
+			s->limit.charged_from = jiffies;
+			s->limit.charged_sz = 0;
+		}
+	}
 
 	damon_for_each_target(t, c) {
-		damon_for_each_region(r, t)
+		damon_for_each_region_safe(r, next_r, t)
 			damon_do_apply_schemes(c, t, r);
 	}
 }
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 5b254eccdb43..4b45b69db697 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -310,6 +310,8 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 
 	*nr_schemes = 0;
 	while (pos < len && *nr_schemes < max_nr_schemes) {
+		struct damos_speed_limit limit = {};
+
 		ret = sscanf(&str[pos], "%lu %lu %u %u %u %u %u%n",
 				&min_sz, &max_sz, &min_nr_a, &max_nr_a,
 				&min_age, &max_age, &action, &parsed);
@@ -322,7 +324,7 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 
 		pos += parsed;
 		scheme = damon_new_scheme(min_sz, max_sz, min_nr_a, max_nr_a,
-				min_age, max_age, action);
+				min_age, max_age, action, &limit);
 		if (!scheme)
 			goto fail;
 
-- 
2.17.1

