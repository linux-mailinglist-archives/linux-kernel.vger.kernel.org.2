Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0405941EDF0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhJAM6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231624AbhJAM6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:58:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5466E61AA4;
        Fri,  1 Oct 2021 12:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633092980;
        bh=b5dNg2QG5vQQSavir5dDlxkUGFqt3lQCAaIEU3P+XpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z3yAaVu7rbmSLnaiwCckFIgVeU0la0qtmLXA2Giw+PLU5oNa8ylcUxlq/Ay2pF9Qt
         AS5JLKckk2wAaCLEnxr7l7RlmeOihzTNMkiq+bsxRA7dXjyvFDMP9cHubtt5Nf2Ffc
         56iQz75SDLbbS9EBOca8oZl9vx9KdU74WwXkmL8tVq4ZMkH4q+N5HyWUeOnev7yDWW
         1dN59PuwUjHlhA8ZbTiluuSjHXTy09u63rQgAjrP67Xpzo9DzKg0nARLenVWvWevUw
         Vdi+pQsD2mjoS/Jd0BE+eAo9oxFlRWlYwxayT35no910cTUpzqypb9OJbBDGzwykJi
         H5TaquavK0iCw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] mm/damon/core: Implement DAMON-based Operation Schemes (DAMOS)
Date:   Fri,  1 Oct 2021 12:55:59 +0000
Message-Id: <20211001125604.29660-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001125604.29660-1-sj@kernel.org>
References: <20211001125604.29660-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many cases, users might use DAMON for simple data access aware
memory management optimizations such as applying an operation scheme to
a memory region of a specific size having a specific access frequency
for a specific time.  For example, "page out a memory region larger than
100 MiB but having a low access frequency more than 10 minutes", or "Use
THP for a memory region larger than 2 MiB having a high access frequency
for more than 2 seconds".

Most simple form of the solution would be doing offline data access
pattern profiling using DAMON and modifying the application source code
or system configuration based on the profiling results.  Or, developing
a daemon constructed with two modules (one for access monitoring and the
other for applying memory management actions via mlock(), madvise(),
sysctl, etc) is imaginable.

To avoid users spending their time for implementation of such simple
data access monitoring-based operation schemes, this commit makes DAMON
to handle such schemes directly.  With this commit, users can simply
specify their desired schemes to DAMON.  Then, DAMON will automatically
apply the schemes to the user-specified target processes.

Each of the schemes is composed with conditions for filtering of the
target memory regions and desired memory management action for the
target.  Specifically, the format is::

    <min/max size> <min/max access frequency> <min/max age> <action>

The filtering conditions are size of memory region, number of accesses
to the region monitored by DAMON, and the age of the region.  The age of
region is incremented periodically but reset when its addresses or
access frequency has significantly changed or the action of a scheme was
applied.  For the action, current implementation supports a few of
madvise()-like hints, ``WILLNEED``, ``COLD``, ``PAGEOUT``, ``HUGEPAGE``,
and ``NOHUGEPAGE``.

Because DAMON supports various address spaces and application of the
actions to a monitoring target region is dependent to the type of the
target address space, the application code should be implemented by each
primitives and registered to the framework.  Note that this commit only
implements the framework part.  Following commit will implement the
action applications for virtual address spaces primitives.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  66 +++++++++++++++++++++++++
 mm/damon/core.c       | 109 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3e8215debbd4..dbe18b0fb795 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -69,6 +69,48 @@ struct damon_target {
 	struct list_head list;
 };
 
+/**
+ * enum damos_action - Represents an action of a Data Access Monitoring-based
+ * Operation Scheme.
+ *
+ * @DAMOS_WILLNEED:	Call ``madvise()`` for the region with MADV_WILLNEED.
+ * @DAMOS_COLD:		Call ``madvise()`` for the region with MADV_COLD.
+ * @DAMOS_PAGEOUT:	Call ``madvise()`` for the region with MADV_PAGEOUT.
+ * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
+ * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
+ */
+enum damos_action {
+	DAMOS_WILLNEED,
+	DAMOS_COLD,
+	DAMOS_PAGEOUT,
+	DAMOS_HUGEPAGE,
+	DAMOS_NOHUGEPAGE,
+};
+
+/**
+ * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
+ * @min_sz_region:	Minimum size of target regions.
+ * @max_sz_region:	Maximum size of target regions.
+ * @min_nr_accesses:	Minimum ``->nr_accesses`` of target regions.
+ * @max_nr_accesses:	Maximum ``->nr_accesses`` of target regions.
+ * @min_age_region:	Minimum age of target regions.
+ * @max_age_region:	Maximum age of target regions.
+ * @action:		&damo_action to be applied to the target regions.
+ * @list:		List head for siblings.
+ *
+ * Note that both the minimums and the maximums are inclusive.
+ */
+struct damos {
+	unsigned long min_sz_region;
+	unsigned long max_sz_region;
+	unsigned int min_nr_accesses;
+	unsigned int max_nr_accesses;
+	unsigned int min_age_region;
+	unsigned int max_age_region;
+	enum damos_action action;
+	struct list_head list;
+};
+
 struct damon_ctx;
 
 /**
@@ -79,6 +121,7 @@ struct damon_ctx;
  * @prepare_access_checks:	Prepare next access check of target regions.
  * @check_accesses:		Check the accesses to target regions.
  * @reset_aggregated:		Reset aggregated accesses monitoring results.
+ * @apply_scheme:		Apply a DAMON-based operation scheme.
  * @target_valid:		Determine if the target is valid.
  * @cleanup:			Clean up the context.
  *
@@ -104,6 +147,9 @@ struct damon_ctx;
  * of its update.  The value will be used for regions adjustment threshold.
  * @reset_aggregated should reset the access monitoring results that aggregated
  * by @check_accesses.
+ * @apply_scheme is called from @kdamond when a region for user provided
+ * DAMON-based operation scheme is found.  It should apply the scheme's action
+ * to the region.  This is not used for &DAMON_ARBITRARY_TARGET case.
  * @target_valid should check whether the target is still valid for the
  * monitoring.
  * @cleanup is called from @kdamond just before its termination.
@@ -114,6 +160,8 @@ struct damon_primitive {
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
 	void (*reset_aggregated)(struct damon_ctx *context);
+	int (*apply_scheme)(struct damon_ctx *context, struct damon_target *t,
+			struct damon_region *r, struct damos *scheme);
 	bool (*target_valid)(void *target);
 	void (*cleanup)(struct damon_ctx *context);
 };
@@ -192,6 +240,7 @@ struct damon_callback {
  * @min_nr_regions:	The minimum number of adaptive monitoring regions.
  * @max_nr_regions:	The maximum number of adaptive monitoring regions.
  * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
+ * @schemes:		Head of schemes (&damos) list.
  */
 struct damon_ctx {
 	unsigned long sample_interval;
@@ -213,6 +262,7 @@ struct damon_ctx {
 	unsigned long min_nr_regions;
 	unsigned long max_nr_regions;
 	struct list_head adaptive_targets;
+	struct list_head schemes;
 };
 
 #define damon_next_region(r) \
@@ -233,6 +283,12 @@ struct damon_ctx {
 #define damon_for_each_target_safe(t, next, ctx)	\
 	list_for_each_entry_safe(t, next, &(ctx)->adaptive_targets, list)
 
+#define damon_for_each_scheme(s, ctx) \
+	list_for_each_entry(s, &(ctx)->schemes, list)
+
+#define damon_for_each_scheme_safe(s, next, ctx) \
+	list_for_each_entry_safe(s, next, &(ctx)->schemes, list)
+
 #ifdef CONFIG_DAMON
 
 struct damon_region *damon_new_region(unsigned long start, unsigned long end);
@@ -242,6 +298,14 @@ inline void damon_insert_region(struct damon_region *r,
 void damon_add_region(struct damon_region *r, struct damon_target *t);
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 
+struct damos *damon_new_scheme(
+		unsigned long min_sz_region, unsigned long max_sz_region,
+		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
+		unsigned int min_age_region, unsigned int max_age_region,
+		enum damos_action action);
+void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
+void damon_destroy_scheme(struct damos *s);
+
 struct damon_target *damon_new_target(unsigned long id);
 void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
 void damon_free_target(struct damon_target *t);
@@ -255,6 +319,8 @@ int damon_set_targets(struct damon_ctx *ctx,
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 		unsigned long aggr_int, unsigned long primitive_upd_int,
 		unsigned long min_nr_reg, unsigned long max_nr_reg);
+int damon_set_schemes(struct damon_ctx *ctx,
+			struct damos **schemes, ssize_t nr_schemes);
 int damon_nr_running_ctxs(void);
 
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3efbe80779db..0ed97b21cbb6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -85,6 +85,50 @@ void damon_destroy_region(struct damon_region *r, struct damon_target *t)
 	damon_free_region(r);
 }
 
+struct damos *damon_new_scheme(
+		unsigned long min_sz_region, unsigned long max_sz_region,
+		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
+		unsigned int min_age_region, unsigned int max_age_region,
+		enum damos_action action)
+{
+	struct damos *scheme;
+
+	scheme = kmalloc(sizeof(*scheme), GFP_KERNEL);
+	if (!scheme)
+		return NULL;
+	scheme->min_sz_region = min_sz_region;
+	scheme->max_sz_region = max_sz_region;
+	scheme->min_nr_accesses = min_nr_accesses;
+	scheme->max_nr_accesses = max_nr_accesses;
+	scheme->min_age_region = min_age_region;
+	scheme->max_age_region = max_age_region;
+	scheme->action = action;
+	INIT_LIST_HEAD(&scheme->list);
+
+	return scheme;
+}
+
+void damon_add_scheme(struct damon_ctx *ctx, struct damos *s)
+{
+	list_add_tail(&s->list, &ctx->schemes);
+}
+
+static void damon_del_scheme(struct damos *s)
+{
+	list_del(&s->list);
+}
+
+static void damon_free_scheme(struct damos *s)
+{
+	kfree(s);
+}
+
+void damon_destroy_scheme(struct damos *s)
+{
+	damon_del_scheme(s);
+	damon_free_scheme(s);
+}
+
 /*
  * Construct a damon_target struct
  *
@@ -156,6 +200,7 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->max_nr_regions = 1000;
 
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
+	INIT_LIST_HEAD(&ctx->schemes);
 
 	return ctx;
 }
@@ -175,7 +220,13 @@ static void damon_destroy_targets(struct damon_ctx *ctx)
 
 void damon_destroy_ctx(struct damon_ctx *ctx)
 {
+	struct damos *s, *next_s;
+
 	damon_destroy_targets(ctx);
+
+	damon_for_each_scheme_safe(s, next_s, ctx)
+		damon_destroy_scheme(s);
+
 	kfree(ctx);
 }
 
@@ -250,6 +301,30 @@ int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 	return 0;
 }
 
+/**
+ * damon_set_schemes() - Set data access monitoring based operation schemes.
+ * @ctx:	monitoring context
+ * @schemes:	array of the schemes
+ * @nr_schemes:	number of entries in @schemes
+ *
+ * This function should not be called while the kdamond of the context is
+ * running.
+ *
+ * Return: 0 if success, or negative error code otherwise.
+ */
+int damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
+			ssize_t nr_schemes)
+{
+	struct damos *s, *next;
+	ssize_t i;
+
+	damon_for_each_scheme_safe(s, next, ctx)
+		damon_destroy_scheme(s);
+	for (i = 0; i < nr_schemes; i++)
+		damon_add_scheme(ctx, schemes[i]);
+	return 0;
+}
+
 /**
  * damon_nr_running_ctxs() - Return number of currently running contexts.
  */
@@ -453,6 +528,39 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	}
 }
 
+static void damon_do_apply_schemes(struct damon_ctx *c,
+				   struct damon_target *t,
+				   struct damon_region *r)
+{
+	struct damos *s;
+	unsigned long sz;
+
+	damon_for_each_scheme(s, c) {
+		sz = r->ar.end - r->ar.start;
+		if (sz < s->min_sz_region || s->max_sz_region < sz)
+			continue;
+		if (r->nr_accesses < s->min_nr_accesses ||
+				s->max_nr_accesses < r->nr_accesses)
+			continue;
+		if (r->age < s->min_age_region || s->max_age_region < r->age)
+			continue;
+		if (c->primitive.apply_scheme)
+			c->primitive.apply_scheme(c, t, r, s);
+		r->age = 0;
+	}
+}
+
+static void kdamond_apply_schemes(struct damon_ctx *c)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+
+	damon_for_each_target(t, c) {
+		damon_for_each_region(r, t)
+			damon_do_apply_schemes(c, t, r);
+	}
+}
+
 #define sz_damon_region(r) (r->ar.end - r->ar.start)
 
 /*
@@ -693,6 +801,7 @@ static int kdamond_fn(void *data)
 			if (ctx->callback.after_aggregation &&
 					ctx->callback.after_aggregation(ctx))
 				set_kdamond_stop(ctx);
+			kdamond_apply_schemes(ctx);
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
 			if (ctx->primitive.reset_aggregated)
-- 
2.17.1

