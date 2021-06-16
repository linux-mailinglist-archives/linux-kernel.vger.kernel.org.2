Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464733A93FB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhFPHdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhFPHdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:33:41 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5817C061767;
        Wed, 16 Jun 2021 00:31:35 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c18so1605063qkc.11;
        Wed, 16 Jun 2021 00:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+lHzUkI6D8fn07PeAeiwRPaEGdKVbwPR/jp6/8aJdy8=;
        b=mpg/kUzlYTlFlEhg0MCa2aWsMkbRfdFwr80EozDk8SzMEty7E5GxQ1WKQ6HKGUmoEN
         Oi6C7C7tf85s5bbKtfe90DHgKMXO4MP713qBj+rIV2e+GWl3/UDvMgUzIqrcAL6vXUIJ
         XWkCfKFUJvFoEpPRLeNaDjC94PDUlVo1SxiccdcxLJY8UMzQ5OPR+rSlcnP0VYkUzjO9
         uNW2ikbOxABQkqVHu0oZQOzfXCSGHc71zboAUm8clD4MqjKJiGpC4HVIeZS+0kwMrivk
         qkGLAYph9GEVW4YWg2GHoJJVBJHoOwyaNxfpFVATuexnCknIFEO+wRgk+QqeI6bs2Pzh
         cAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+lHzUkI6D8fn07PeAeiwRPaEGdKVbwPR/jp6/8aJdy8=;
        b=gYsGc61lNc2tOXx8Y1JBBD73ywVB5nYdGvEdnU8U6ORrgT1Y9chG83gGxflkyr4lyl
         CP6Ft6UU6DO7/tsA61iRdf4hIRXlaYXbNYX/phW4sFI68BiJtZ0pt5RL0J9R9HPkRfZn
         Cy21iXMToXf4oyJ2FgdbkEmzUu30JPpV4PemaexWniDDkOAOCxyhtNDK7+p4HVhzvAVe
         SA19jUU/u5hsmTh+R9jX5XtmujLNEVyBvD5UFkuzC9IG57gM5aNoekxpLafioWDYgFIF
         jwiH66T3nRVAiBfDFftVxlIoqPcAu65ct4StCmMGnxr2FnH5SdPKPPRD9JPb+uCuWIMM
         Dv7A==
X-Gm-Message-State: AOAM532AQFzrSoLqQUsIUdl9O0tOdEap4y3rD+SLNbCACvB03oOpp+yC
        pcEKGlS2n2nf9KkgsXtrWrc=
X-Google-Smtp-Source: ABdhPJxQMrzKtzPXW4XjPy2SCXa/BtxEuul9oPhhCrm/t24pvnS1twnQ7wycrj0VsmE0EGyU1ct3rw==
X-Received: by 2002:a37:b947:: with SMTP id j68mr3818840qkf.486.1623828694973;
        Wed, 16 Jun 2021 00:31:34 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h5sm1080697qkg.122.2021.06.16.00.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:31:34 -0700 (PDT)
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
Subject: [PATCH v30 02/13] mm/damon/core: Implement region-based sampling
Date:   Wed, 16 Jun 2021 07:31:08 +0000
Message-Id: <20210616073119.16758-3-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210616073119.16758-1-sj38.park@gmail.com>
References: <20210616073119.16758-1-sj38.park@gmail.com>
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
index 693e51ebc05a..94db494dcf70 100644
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
 
 	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
 
@@ -289,6 +419,7 @@ static int kdamond_fn(void *data)
 			if (ctx->callback.after_aggregation &&
 					ctx->callback.after_aggregation(ctx))
 				set_kdamond_stop(ctx);
+			kdamond_reset_aggregated(ctx);
 			if (ctx->primitive.reset_aggregated)
 				ctx->primitive.reset_aggregated(ctx);
 		}
@@ -298,6 +429,10 @@ static int kdamond_fn(void *data)
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

