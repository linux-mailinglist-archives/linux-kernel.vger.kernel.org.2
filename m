Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD3F3C705B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 14:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbhGMMhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 08:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbhGMMhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 08:37:03 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC010C0613F0;
        Tue, 13 Jul 2021 05:34:13 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g8so16435964qth.10;
        Tue, 13 Jul 2021 05:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qv+/OYZvIuKPEwXDXefC8UgsteoySwk9Wv3Pxza1fEw=;
        b=Z9GVhcbL6S2ZMCCoGYyG2M9tmVSAab0vUgQa17YB4FNylKhPnmPwguRGfMMx2zw39u
         Hbb7hEtFaYKkbPrZCq4mPfja61Os2WKVdJ/ZF66y/a+Cq/XpZ4wWzf8UXocHG7WH1565
         tW0mPbWsj18Cmeq97rOjQIpp/iEvl/GX/rAFR4qJlTU2bwCU5T2BySlUCUrSD9l0baUT
         Y3x5TBLRK3m4qelB/S7/q6W+oQrPi5pQsgV3vgsT7QiQMXpOW04RRHqSfXsJjCOopJkj
         DC0f4oZay4QaQ4feHWyUchDuqZz1/RpaZgE5H96hcESQX3AeK6DbZnOLjnxCI7p74+2r
         sr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qv+/OYZvIuKPEwXDXefC8UgsteoySwk9Wv3Pxza1fEw=;
        b=NsdM05IP7Ua5RKTkDNrRbCN1EfjfKhB6TLzaLfW7BWe15J/Cpz+f9qcWW3VDA345F6
         Ka12D2+AS/4aqiW9eskmQ/vIe5GjJmo8LhvjjrHDzTXaUvN3B7X0pDF/S+S2GeYMoPqq
         oayq/G+4DTq9YfshtN0rq/hHa6OKifsLJT5qoWI3yMDDl9oODaWm+EIL6RlyVMWoYTeO
         Zv6s82rCjgnlok33JuWm619tdGQZ2dm1B98Z9gGwYmE8JjiJyOZlpzpQQ4zH72uPCHrF
         yDebZ0Re95cCcYdJ6FmPPJoALBZOSR+uX1DciePqMB9dvUFOtJJ9Bt+3flXXJaC3aD2L
         ZwaQ==
X-Gm-Message-State: AOAM533shNXT/7hbeYG/kTwRqjUTl0VyTXGaRtEOv43FuKs+FvrgLAuO
        AFjX0Oz3i+eXHvpCDnxlclg=
X-Google-Smtp-Source: ABdhPJz429Ev+OsXhOzPf4nxPbZp2AuVLMGFuwT7HGmQLI3P7DBLqYGKb9fw/QGjF83uhmDIQRqicA==
X-Received: by 2002:ac8:6bd3:: with SMTP id b19mr3899374qtt.88.1626179652905;
        Tue, 13 Jul 2021 05:34:12 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id k14sm6849327qtm.18.2021.07.13.05.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 05:34:12 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, mgorman@suse.de,
        mheyne@amazon.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        shakeelb@google.com, shuah@kernel.org, sieberf@amazon.com,
        sj38.park@gmail.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v33 02/13] mm/damon/core: Implement region-based sampling
Date:   Tue, 13 Jul 2021 12:33:45 +0000
Message-Id: <20210713123356.6924-3-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210713123356.6924-1-sj38.park@gmail.com>
References: <20210713123356.6924-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

To avoid the unbounded increase of the overhead, DAMON groups adjacent
pages that are assumed to have the same access frequencies into a
region.  As long as the assumption (pages in a region have the same
access frequencies) is kept, only one page in the region is required to
be checked.  Thus, for each ``sampling interval``,

 1. the 'prepare_access_checks' primitive picks one page in each region,
 2. waits for one ``sampling interval``,
 3. checks whether the page is accessed meanwhile, and
 4. increases the access count of the region if so.

Therefore, the monitoring overhead is controllable by adjusting the
number of regions.  DAMON allows both the underlying primitives and user
callbacks to adjust regions for the trade-off.  In other words, this
commit makes DAMON to use not only time-based sampling but also
space-based sampling.

This scheme, however, cannot preserve the quality of the output if the
assumption is not guaranteed.  Next commit will address this problem.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
Reviewed-by: Fernand Sieber <sieberf@amazon.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/damon.h |  77 ++++++++++++++++++++++-
 mm/damon/core.c       | 143 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 213 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 2f652602b1ea..67db309ad61b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -12,6 +12,48 @@
 #include <linux/time64.h>
 #include <linux/types.h>
 
+/**
+ * struct damon_addr_range - Represents an address region of [@start, @end).
+ * @start:	Start address of the region (inclusive).
+ * @end:	End address of the region (exclusive).
+ */
+struct damon_addr_range {
+	unsigned long start;
+	unsigned long end;
+};
+
+/**
+ * struct damon_region - Represents a monitoring target region.
+ * @ar:			The address range of the region.
+ * @sampling_addr:	Address of the sample for the next access check.
+ * @nr_accesses:	Access frequency of this region.
+ * @list:		List head for siblings.
+ */
+struct damon_region {
+	struct damon_addr_range ar;
+	unsigned long sampling_addr;
+	unsigned int nr_accesses;
+	struct list_head list;
+};
+
+/**
+ * struct damon_target - Represents a monitoring target.
+ * @id:			Unique identifier for this target.
+ * @regions_list:	Head of the monitoring target regions of this target.
+ * @list:		List head for siblings.
+ *
+ * Each monitoring context could have multiple targets.  For example, a context
+ * for virtual memory address spaces could have multiple target processes.  The
+ * @id of each target should be unique among the targets of the context.  For
+ * example, in the virtual address monitoring context, it could be a pidfd or
+ * an address of an mm_struct.
+ */
+struct damon_target {
+	unsigned long id;
+	struct list_head regions_list;
+	struct list_head list;
+};
+
 struct damon_ctx;
 
 /**
@@ -36,7 +78,7 @@ struct damon_ctx;
  *
  * @init should initialize primitive-internal data structures.  For example,
  * this could be used to construct proper monitoring target regions and link
- * those to @damon_ctx.target.
+ * those to @damon_ctx.adaptive_targets.
  * @update should update the primitive-internal data structures.  For example,
  * this could be used to update monitoring target regions for current status.
  * @prepare_access_checks should manipulate the monitoring regions to be
@@ -130,7 +172,7 @@ struct damon_callback {
  * @primitive:	Set of monitoring primitives for given use cases.
  * @callback:	Set of callbacks for monitoring events notifications.
  *
- * @target:	Pointer to the user-defined monitoring target.
+ * @region_targets:	Head of monitoring targets (&damon_target) list.
  */
 struct damon_ctx {
 	unsigned long sample_interval;
@@ -149,11 +191,40 @@ struct damon_ctx {
 	struct damon_primitive primitive;
 	struct damon_callback callback;
 
-	void *target;
+	struct list_head region_targets;
 };
 
+#define damon_next_region(r) \
+	(container_of(r->list.next, struct damon_region, list))
+
+#define damon_prev_region(r) \
+	(container_of(r->list.prev, struct damon_region, list))
+
+#define damon_for_each_region(r, t) \
+	list_for_each_entry(r, &t->regions_list, list)
+
+#define damon_for_each_region_safe(r, next, t) \
+	list_for_each_entry_safe(r, next, &t->regions_list, list)
+
+#define damon_for_each_target(t, ctx) \
+	list_for_each_entry(t, &(ctx)->region_targets, list)
+
+#define damon_for_each_target_safe(t, next, ctx)	\
+	list_for_each_entry_safe(t, next, &(ctx)->region_targets, list)
+
 #ifdef CONFIG_DAMON
 
+struct damon_region *damon_new_region(unsigned long start, unsigned long end);
+inline void damon_insert_region(struct damon_region *r,
+		struct damon_region *prev, struct damon_region *next);
+void damon_add_region(struct damon_region *r, struct damon_target *t);
+void damon_destroy_region(struct damon_region *r);
+
+struct damon_target *damon_new_target(unsigned long id);
+void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
+void damon_free_target(struct damon_target *t);
+void damon_destroy_target(struct damon_target *t);
+
 struct damon_ctx *damon_new_ctx(void);
 void damon_destroy_ctx(struct damon_ctx *ctx);
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 651590bf49b1..947486a150ce 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -15,6 +15,101 @@
 static DEFINE_MUTEX(damon_lock);
 static int nr_running_ctxs;
 
+/*
+ * Construct a damon_region struct
+ *
+ * Returns the pointer to the new struct if success, or NULL otherwise
+ */
+struct damon_region *damon_new_region(unsigned long start, unsigned long end)
+{
+	struct damon_region *region;
+
+	region = kmalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return NULL;
+
+	region->ar.start = start;
+	region->ar.end = end;
+	region->nr_accesses = 0;
+	INIT_LIST_HEAD(&region->list);
+
+	return region;
+}
+
+/*
+ * Add a region between two other regions
+ */
+inline void damon_insert_region(struct damon_region *r,
+		struct damon_region *prev, struct damon_region *next)
+{
+	__list_add(&r->list, &prev->list, &next->list);
+}
+
+void damon_add_region(struct damon_region *r, struct damon_target *t)
+{
+	list_add_tail(&r->list, &t->regions_list);
+}
+
+static void damon_del_region(struct damon_region *r)
+{
+	list_del(&r->list);
+}
+
+static void damon_free_region(struct damon_region *r)
+{
+	kfree(r);
+}
+
+void damon_destroy_region(struct damon_region *r)
+{
+	damon_del_region(r);
+	damon_free_region(r);
+}
+
+/*
+ * Construct a damon_target struct
+ *
+ * Returns the pointer to the new struct if success, or NULL otherwise
+ */
+struct damon_target *damon_new_target(unsigned long id)
+{
+	struct damon_target *t;
+
+	t = kmalloc(sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return NULL;
+
+	t->id = id;
+	INIT_LIST_HEAD(&t->regions_list);
+
+	return t;
+}
+
+void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
+{
+	list_add_tail(&t->list, &ctx->region_targets);
+}
+
+static void damon_del_target(struct damon_target *t)
+{
+	list_del(&t->list);
+}
+
+void damon_free_target(struct damon_target *t)
+{
+	struct damon_region *r, *next;
+
+	damon_for_each_region_safe(r, next, t)
+		damon_free_region(r);
+	kfree(t);
+}
+
+void damon_destroy_target(struct damon_target *t)
+{
+	damon_del_target(t);
+	damon_free_target(t);
+}
+
 struct damon_ctx *damon_new_ctx(void)
 {
 	struct damon_ctx *ctx;
@@ -32,15 +127,27 @@ struct damon_ctx *damon_new_ctx(void)
 
 	mutex_init(&ctx->kdamond_lock);
 
-	ctx->target = NULL;
+	INIT_LIST_HEAD(&ctx->region_targets);
 
 	return ctx;
 }
 
-void damon_destroy_ctx(struct damon_ctx *ctx)
+static void damon_destroy_targets(struct damon_ctx *ctx)
 {
-	if (ctx->primitive.cleanup)
+	struct damon_target *t, *next_t;
+
+	if (ctx->primitive.cleanup) {
 		ctx->primitive.cleanup(ctx);
+		return;
+	}
+
+	damon_for_each_target_safe(t, next_t, ctx)
+		damon_destroy_target(t);
+}
+
+void damon_destroy_ctx(struct damon_ctx *ctx)
+{
+	damon_destroy_targets(ctx);
 	kfree(ctx);
 }
 
@@ -217,6 +324,21 @@ static bool kdamond_aggregate_interval_passed(struct damon_ctx *ctx)
 			ctx->aggr_interval);
 }
 
+/*
+ * Reset the aggregated monitoring results ('nr_accesses' of each region).
+ */
+static void kdamond_reset_aggregated(struct damon_ctx *c)
+{
+	struct damon_target *t;
+
+	damon_for_each_target(t, c) {
+		struct damon_region *r;
+
+		damon_for_each_region(r, t)
+			r->nr_accesses = 0;
+	}
+}
+
 /*
  * Check whether it is time to check and apply the target monitoring regions
  *
@@ -238,6 +360,7 @@ static bool kdamond_need_update_primitive(struct damon_ctx *ctx)
  */
 static bool kdamond_need_stop(struct damon_ctx *ctx)
 {
+	struct damon_target *t;
 	bool stop;
 
 	mutex_lock(&ctx->kdamond_lock);
@@ -249,7 +372,12 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 	if (!ctx->primitive.target_valid)
 		return false;
 
-	return !ctx->primitive.target_valid(ctx->target);
+	damon_for_each_target(t, ctx) {
+		if (ctx->primitive.target_valid(t))
+			return false;
+	}
+
+	return true;
 }
 
 static void set_kdamond_stop(struct damon_ctx *ctx)
@@ -265,6 +393,8 @@ static void set_kdamond_stop(struct damon_ctx *ctx)
 static int kdamond_fn(void *data)
 {
 	struct damon_ctx *ctx = (struct damon_ctx *)data;
+	struct damon_target *t;
+	struct damon_region *r, *next;
 
 	mutex_lock(&ctx->kdamond_lock);
 	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
@@ -291,6 +421,7 @@ static int kdamond_fn(void *data)
 			if (ctx->callback.after_aggregation &&
 					ctx->callback.after_aggregation(ctx))
 				set_kdamond_stop(ctx);
+			kdamond_reset_aggregated(ctx);
 			if (ctx->primitive.reset_aggregated)
 				ctx->primitive.reset_aggregated(ctx);
 		}
@@ -300,6 +431,10 @@ static int kdamond_fn(void *data)
 				ctx->primitive.update(ctx);
 		}
 	}
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region_safe(r, next, t)
+			damon_destroy_region(r);
+	}
 
 	if (ctx->callback.before_terminate &&
 			ctx->callback.before_terminate(ctx))
-- 
2.17.1

