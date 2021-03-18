Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E023402D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCRKK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhCRKKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:10:07 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A437AC06174A;
        Thu, 18 Mar 2021 03:10:07 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id 94so3642443qtc.0;
        Thu, 18 Mar 2021 03:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b+1Vnr8tb6LbM0SWY6J3IITj0EjR65jYOsFk4fahvOw=;
        b=PLPFyiEJkJZ7Rxv3qU5Ayb4zEEemc1K6MJBkLg++q6/n+V4syL97mamU4VSISRGAiu
         LfA/7pNzHEyAF8oPhni8ugRl10y3l+qxkZ065LM1nJSZeV+ObraCsN2ezURua9ulROST
         HaeF5uMpScMCeWA33r80DubP8ZFbj5gfFDRno4s/Klt7LF6DmniNNUV9PuXUjEEUztvu
         k1MkSCsnQLbDP8Wz3QUdIqx+Ect1PRKUePCpRsYQSzeY5IBkPaVMoeHN0vcHenliF0WO
         A8BY9+NE5XbAY3Z6VDPMoeUEmRT2fv2cTyg0xKhj2X2+1vhaXmg5PIhnIOEHMAdLFxqX
         pD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b+1Vnr8tb6LbM0SWY6J3IITj0EjR65jYOsFk4fahvOw=;
        b=lggeA4vRyrwWY/hJcUCxZtC35PZeI2uQ6FKWdDSth0biGu7m29xjYN+GFvLv/lxC3+
         hKZ8TocbECfeXtJn5CLtZt3wkHk9mC/ZptmncxHyBNMgMwiqtQHcG1FN3swbPXLD7dLu
         np0FD+gVmwOVo46tO13DyAKYa3IaC5GKhpTVvD9SCeu9PZKVQuEmEkEq9C42cwZC+IWF
         dqrrQel7dCYMmfgRBIkmHVXdL5IcqkbAoAV39hLMVJaAvLoXFkR8M4fYGUSb6SH2yU+W
         EDTyD09Pv9Fu61GHBFFGLGNZIOYC4fq+XOW7MTgnwasm72EIABTBr6wOQ4abSZeOPkZM
         UF9A==
X-Gm-Message-State: AOAM5338Ch4rNwno4TJnAEprYRxmXiNwOIefKIqQpJw4YXWJdw3XC4Bg
        AgKjWyXDHPulbz3RYv0W34o=
X-Google-Smtp-Source: ABdhPJxQPqiQ0ez72BN/OPtodE0O7Qb1AjwbKiFCi0+S/Aq/sldOShTumzfWEOto8cTi/scpsCeKwQ==
X-Received: by 2002:ac8:5bd1:: with SMTP id b17mr2964902qtb.53.1616062206866;
        Thu, 18 Mar 2021 03:10:06 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id d16sm1358101qka.43.2021.03.18.03.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:10:06 -0700 (PDT)
From:   sj38.park@gmail.com
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, gthelen@google.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, shakeelb@google.com,
        shuah@kernel.org, sj38.park@gmail.com, snu@amazon.de,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v25 03/13] mm/damon: Adaptively adjust regions
Date:   Thu, 18 Mar 2021 10:08:46 +0000
Message-Id: <20210318100856.34715-4-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210318100856.34715-1-sj38.park@gmail.com>
References: <20210318100856.34715-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Even somehow the initial monitoring target regions are well constructed
to fulfill the assumption (pages in same region have similar access
frequencies), the data access pattern can be dynamically changed.  This
will result in low monitoring quality.  To keep the assumption as much
as possible, DAMON adaptively merges and splits each region based on
their access frequency.

For each ``aggregation interval``, it compares the access frequencies of
adjacent regions and merges those if the frequency difference is small.
Then, after it reports and clears the aggregated access frequency of
each region, it splits each region into two or three regions if the
total number of regions will not exceed the user-specified maximum
number of regions after the split.

In this way, DAMON provides its best-effort quality and minimal overhead
while keeping the upper-bound overhead that users set.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
---
 include/linux/damon.h |  23 +++--
 mm/damon/core.c       | 214 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 227 insertions(+), 10 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 67db309ad61b..0bd5d6913a6c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -12,6 +12,9 @@
 #include <linux/time64.h>
 #include <linux/types.h>
 
+/* Minimal region size.  Every damon_region is aligned by this. */
+#define DAMON_MIN_REGION	PAGE_SIZE
+
 /**
  * struct damon_addr_range - Represents an address region of [@start, @end).
  * @start:	Start address of the region (inclusive).
@@ -85,6 +88,8 @@ struct damon_ctx;
  * prepared for the next access check.
  * @check_accesses should check the accesses to each region that made after the
  * last preparation and update the number of observed accesses of each region.
+ * It should also return max number of observed accesses that made as a result
+ * of its update.  The value will be used for regions adjustment threshold.
  * @reset_aggregated should reset the access monitoring results that aggregated
  * by @check_accesses.
  * @target_valid should check whether the target is still valid for the
@@ -95,7 +100,7 @@ struct damon_primitive {
 	void (*init)(struct damon_ctx *context);
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
-	void (*check_accesses)(struct damon_ctx *context);
+	unsigned int (*check_accesses)(struct damon_ctx *context);
 	void (*reset_aggregated)(struct damon_ctx *context);
 	bool (*target_valid)(void *target);
 	void (*cleanup)(struct damon_ctx *context);
@@ -172,7 +177,9 @@ struct damon_callback {
  * @primitive:	Set of monitoring primitives for given use cases.
  * @callback:	Set of callbacks for monitoring events notifications.
  *
- * @region_targets:	Head of monitoring targets (&damon_target) list.
+ * @min_nr_regions:	The minimum number of adaptive monitoring regions.
+ * @max_nr_regions:	The maximum number of adaptive monitoring regions.
+ * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
  */
 struct damon_ctx {
 	unsigned long sample_interval;
@@ -191,7 +198,9 @@ struct damon_ctx {
 	struct damon_primitive primitive;
 	struct damon_callback callback;
 
-	struct list_head region_targets;
+	unsigned long min_nr_regions;
+	unsigned long max_nr_regions;
+	struct list_head adaptive_targets;
 };
 
 #define damon_next_region(r) \
@@ -207,10 +216,10 @@ struct damon_ctx {
 	list_for_each_entry_safe(r, next, &t->regions_list, list)
 
 #define damon_for_each_target(t, ctx) \
-	list_for_each_entry(t, &(ctx)->region_targets, list)
+	list_for_each_entry(t, &(ctx)->adaptive_targets, list)
 
 #define damon_for_each_target_safe(t, next, ctx)	\
-	list_for_each_entry_safe(t, next, &(ctx)->region_targets, list)
+	list_for_each_entry_safe(t, next, &(ctx)->adaptive_targets, list)
 
 #ifdef CONFIG_DAMON
 
@@ -224,11 +233,13 @@ struct damon_target *damon_new_target(unsigned long id);
 void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
 void damon_free_target(struct damon_target *t);
 void damon_destroy_target(struct damon_target *t);
+unsigned int damon_nr_regions(struct damon_target *t);
 
 struct damon_ctx *damon_new_ctx(void);
 void damon_destroy_ctx(struct damon_ctx *ctx);
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
-		unsigned long aggr_int, unsigned long primitive_upd_int);
+		unsigned long aggr_int, unsigned long primitive_upd_int,
+		unsigned long min_nr_reg, unsigned long max_nr_reg);
 
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 94db494dcf70..b36b6bdd94e2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -10,8 +10,12 @@
 #include <linux/damon.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/random.h>
 #include <linux/slab.h>
 
+/* Get a random number in [l, r) */
+#define damon_rand(l, r) (l + prandom_u32_max(r - l))
+
 static DEFINE_MUTEX(damon_lock);
 static int nr_running_ctxs;
 
@@ -87,7 +91,7 @@ struct damon_target *damon_new_target(unsigned long id)
 
 void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
 {
-	list_add_tail(&t->list, &ctx->region_targets);
+	list_add_tail(&t->list, &ctx->adaptive_targets);
 }
 
 static void damon_del_target(struct damon_target *t)
@@ -110,6 +114,17 @@ void damon_destroy_target(struct damon_target *t)
 	damon_free_target(t);
 }
 
+unsigned int damon_nr_regions(struct damon_target *t)
+{
+	struct damon_region *r;
+	unsigned int nr_regions = 0;
+
+	damon_for_each_region(r, t)
+		nr_regions++;
+
+	return nr_regions;
+}
+
 struct damon_ctx *damon_new_ctx(void)
 {
 	struct damon_ctx *ctx;
@@ -127,7 +142,10 @@ struct damon_ctx *damon_new_ctx(void)
 
 	mutex_init(&ctx->kdamond_lock);
 
-	INIT_LIST_HEAD(&ctx->region_targets);
+	ctx->min_nr_regions = 10;
+	ctx->max_nr_regions = 1000;
+
+	INIT_LIST_HEAD(&ctx->adaptive_targets);
 
 	return ctx;
 }
@@ -157,6 +175,8 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
  * @sample_int:		time interval between samplings
  * @aggr_int:		time interval between aggregations
  * @primitive_upd_int:	time interval between monitoring primitive updates
+ * @min_nr_reg:		minimal number of regions
+ * @max_nr_reg:		maximum number of regions
  *
  * This function should not be called while the kdamond is running.
  * Every time interval is in micro-seconds.
@@ -164,15 +184,49 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
  * Return: 0 on success, negative error code otherwise.
  */
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
-		    unsigned long aggr_int, unsigned long primitive_upd_int)
+		    unsigned long aggr_int, unsigned long primitive_upd_int,
+		    unsigned long min_nr_reg, unsigned long max_nr_reg)
 {
+	if (min_nr_reg < 3) {
+		pr_err("min_nr_regions (%lu) must be at least 3\n",
+				min_nr_reg);
+		return -EINVAL;
+	}
+	if (min_nr_reg > max_nr_reg) {
+		pr_err("invalid nr_regions.  min (%lu) > max (%lu)\n",
+				min_nr_reg, max_nr_reg);
+		return -EINVAL;
+	}
+
 	ctx->sample_interval = sample_int;
 	ctx->aggr_interval = aggr_int;
 	ctx->primitive_update_interval = primitive_upd_int;
+	ctx->min_nr_regions = min_nr_reg;
+	ctx->max_nr_regions = max_nr_reg;
 
 	return 0;
 }
 
+/* Returns the size upper limit for each monitoring region */
+static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	unsigned long sz = 0;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t)
+			sz += r->ar.end - r->ar.start;
+	}
+
+	if (ctx->min_nr_regions)
+		sz /= ctx->min_nr_regions;
+	if (sz < DAMON_MIN_REGION)
+		sz = DAMON_MIN_REGION;
+
+	return sz;
+}
+
 static bool damon_kdamond_running(struct damon_ctx *ctx)
 {
 	bool running;
@@ -339,6 +393,149 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	}
 }
 
+#define sz_damon_region(r) (r->ar.end - r->ar.start)
+
+/*
+ * Merge two adjacent regions into one region
+ */
+static void damon_merge_two_regions(struct damon_region *l,
+				struct damon_region *r)
+{
+	unsigned long sz_l = sz_damon_region(l), sz_r = sz_damon_region(r);
+
+	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
+			(sz_l + sz_r);
+	l->ar.end = r->ar.end;
+	damon_destroy_region(r);
+}
+
+#define diff_of(a, b) (a > b ? a - b : b - a)
+
+/*
+ * Merge adjacent regions having similar access frequencies
+ *
+ * t		target affected by this merge operation
+ * thres	'->nr_accesses' diff threshold for the merge
+ * sz_limit	size upper limit of each region
+ */
+static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
+				   unsigned long sz_limit)
+{
+	struct damon_region *r, *prev = NULL, *next;
+
+	damon_for_each_region_safe(r, next, t) {
+		if (prev && prev->ar.end == r->ar.start &&
+		    diff_of(prev->nr_accesses, r->nr_accesses) <= thres &&
+		    sz_damon_region(prev) + sz_damon_region(r) <= sz_limit)
+			damon_merge_two_regions(prev, r);
+		else
+			prev = r;
+	}
+}
+
+/*
+ * Merge adjacent regions having similar access frequencies
+ *
+ * threshold	'->nr_accesses' diff threshold for the merge
+ * sz_limit	size upper limit of each region
+ *
+ * This function merges monitoring target regions which are adjacent and their
+ * access frequencies are similar.  This is for minimizing the monitoring
+ * overhead under the dynamically changeable access pattern.  If a merge was
+ * unnecessarily made, later 'kdamond_split_regions()' will revert it.
+ */
+static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
+				  unsigned long sz_limit)
+{
+	struct damon_target *t;
+
+	damon_for_each_target(t, c)
+		damon_merge_regions_of(t, threshold, sz_limit);
+}
+
+/*
+ * Split a region in two
+ *
+ * r		the region to be split
+ * sz_r		size of the first sub-region that will be made
+ */
+static void damon_split_region_at(struct damon_ctx *ctx,
+				  struct damon_region *r, unsigned long sz_r)
+{
+	struct damon_region *new;
+
+	new = damon_new_region(r->ar.start + sz_r, r->ar.end);
+	if (!new)
+		return;
+
+	r->ar.end = new->ar.start;
+
+	damon_insert_region(new, r, damon_next_region(r));
+}
+
+/* Split every region in the given target into 'nr_subs' regions */
+static void damon_split_regions_of(struct damon_ctx *ctx,
+				     struct damon_target *t, int nr_subs)
+{
+	struct damon_region *r, *next;
+	unsigned long sz_region, sz_sub = 0;
+	int i;
+
+	damon_for_each_region_safe(r, next, t) {
+		sz_region = r->ar.end - r->ar.start;
+
+		for (i = 0; i < nr_subs - 1 &&
+				sz_region > 2 * DAMON_MIN_REGION; i++) {
+			/*
+			 * Randomly select size of left sub-region to be at
+			 * least 10 percent and at most 90% of original region
+			 */
+			sz_sub = ALIGN_DOWN(damon_rand(1, 10) *
+					sz_region / 10, DAMON_MIN_REGION);
+			/* Do not allow blank region */
+			if (sz_sub == 0 || sz_sub >= sz_region)
+				continue;
+
+			damon_split_region_at(ctx, r, sz_sub);
+			sz_region = sz_sub;
+		}
+	}
+}
+
+/*
+ * Split every target region into randomly-sized small regions
+ *
+ * This function splits every target region into random-sized small regions if
+ * current total number of the regions is equal or smaller than half of the
+ * user-specified maximum number of regions.  This is for maximizing the
+ * monitoring accuracy under the dynamically changeable access patterns.  If a
+ * split was unnecessarily made, later 'kdamond_merge_regions()' will revert
+ * it.
+ */
+static void kdamond_split_regions(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	unsigned int nr_regions = 0;
+	static unsigned int last_nr_regions;
+	int nr_subregions = 2;
+
+	damon_for_each_target(t, ctx)
+		nr_regions += damon_nr_regions(t);
+
+	if (nr_regions > ctx->max_nr_regions / 2)
+		return;
+
+	/* Maybe the middle of the region has different access frequency */
+	if (last_nr_regions == nr_regions &&
+			nr_regions < ctx->max_nr_regions / 3)
+		nr_subregions = 3;
+
+	damon_for_each_target(t, ctx)
+		damon_split_regions_of(ctx, t, nr_subregions);
+
+	last_nr_regions = nr_regions;
+}
+
 /*
  * Check whether it is time to check and apply the target monitoring regions
  *
@@ -395,6 +592,8 @@ static int kdamond_fn(void *data)
 	struct damon_ctx *ctx = (struct damon_ctx *)data;
 	struct damon_target *t;
 	struct damon_region *r, *next;
+	unsigned int max_nr_accesses = 0;
+	unsigned long sz_limit = 0;
 
 	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
 
@@ -403,6 +602,8 @@ static int kdamond_fn(void *data)
 	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
 		set_kdamond_stop(ctx);
 
+	sz_limit = damon_region_sz_limit(ctx);
+
 	while (!kdamond_need_stop(ctx)) {
 		if (ctx->primitive.prepare_access_checks)
 			ctx->primitive.prepare_access_checks(ctx);
@@ -413,13 +614,17 @@ static int kdamond_fn(void *data)
 		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
 
 		if (ctx->primitive.check_accesses)
-			ctx->primitive.check_accesses(ctx);
+			max_nr_accesses = ctx->primitive.check_accesses(ctx);
 
 		if (kdamond_aggregate_interval_passed(ctx)) {
+			kdamond_merge_regions(ctx,
+					max_nr_accesses / 10,
+					sz_limit);
 			if (ctx->callback.after_aggregation &&
 					ctx->callback.after_aggregation(ctx))
 				set_kdamond_stop(ctx);
 			kdamond_reset_aggregated(ctx);
+			kdamond_split_regions(ctx);
 			if (ctx->primitive.reset_aggregated)
 				ctx->primitive.reset_aggregated(ctx);
 		}
@@ -427,6 +632,7 @@ static int kdamond_fn(void *data)
 		if (kdamond_need_update_primitive(ctx)) {
 			if (ctx->primitive.update)
 				ctx->primitive.update(ctx);
+			sz_limit = damon_region_sz_limit(ctx);
 		}
 	}
 	damon_for_each_target(t, ctx) {
-- 
2.17.1

