Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF13D34E3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhC3JGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhC3JFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:05:53 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF69C061762;
        Tue, 30 Mar 2021 02:05:53 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id l6so3170791qtq.2;
        Tue, 30 Mar 2021 02:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eo3pqaFYDHE/AchRbjHb192sD13NhAxk8MLhFWpD8Eg=;
        b=mNCimRTIcHxJLOqtBF0yCt/QXw2LLeoch129mRHucMADx976TXJ+yi71cj0vBREwI9
         KWDnL4JVq3MIyYCTHWQECn/1Dw+TmQd12yYIrqhR4EC97/uQ//+dAU3xDXHKNWULNxMa
         SEvCxE7Tz0qBrGioShl0OI16nbE0w7YQk+Ffuyx2NoWPRniw0zehTlQuGaUpryYKS5K6
         jpeRnI16xhXfFDNZtl6IpuVcYpxvVl5EwEx+/ldD9iSVHwzGowzzGqAwp2yck6D66g0z
         g9yzHeKC004bjjmeqxLYqwkupF06P8Hd2bUrpgtYiaEpJTqD1Z8baMeRBCrx18fCKuvy
         ysdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eo3pqaFYDHE/AchRbjHb192sD13NhAxk8MLhFWpD8Eg=;
        b=B9g5Q9BK50r5ExT2Crk+y1DIVsbsuBoxUlH3y7Y3mE3I9XYC/xNjxmAGVwhjCyXkwE
         V16ZvcAOEYpduwgr0L73uV4SnV2v7MO7m4hO8vETXs3pkCUx4CUQyHzJ55wtw771XVg6
         UeecUxHILR9o6GwCyitn/7EPN4fuJP6kHr2nkwUjnXEN8v9jkniKlkwYQOzKgWzApz0K
         qYV8QYDMHbZvpYIfQ0F5Yn/TM9r8ALULWAslnGBqafH0s856bSsHtdDfM18ikGrVceqq
         4mT46pus/z0wtM0iuEam5Cy08JZyOgONPVV3jiAC+GYDX4u7g+MLJhOv58arL6FNeHRa
         xqhQ==
X-Gm-Message-State: AOAM531uRMBrHBETNwlMZTRvI8Oa76ZO4szy5+eLHH+syPQPjEoWqOF/
        KOBsRqb3pQZPwd6eSwXRp0Q=
X-Google-Smtp-Source: ABdhPJyR8+0kYabjIMaIo0ulTnoh/kmt3CCTG4ws4AG2HeWAe17tdSlwGRaofXaPQJsO+9xvR+YQ/g==
X-Received: by 2002:a05:622a:1744:: with SMTP id l4mr27138566qtk.75.1617095152142;
        Tue, 30 Mar 2021 02:05:52 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 8sm14630011qkc.32.2021.03.30.02.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:05:51 -0700 (PDT)
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
        sj38.park@gmail.com, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v26 01/13] mm: Introduce Data Access MONitor (DAMON)
Date:   Tue, 30 Mar 2021 09:05:25 +0000
Message-Id: <20210330090537.12143-2-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210330090537.12143-1-sj38.park@gmail.com>
References: <20210330090537.12143-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON is a data access monitoring framework for the Linux kernel.  The
core mechanisms of DAMON make it

 - accurate (the monitoring output is useful enough for DRAM level
   performance-centric memory management; It might be inappropriate for
   CPU cache levels, though),
 - light-weight (the monitoring overhead is normally low enough to be
   applied online), and
 - scalable (the upper-bound of the overhead is in constant range
   regardless of the size of target workloads).

Using this framework, hence, we can easily write efficient kernel space
data access monitoring applications.  For example, the kernel's memory
management mechanisms can make advanced decisions using this.
Experimental data access aware optimization works that incurring high
access monitoring overhead could again be implemented on top of this.

Due to its simple and flexible interface, providing user space interface
would be also easy.  Then, user space users who have some special
workloads can write personalized applications for better understanding
and optimizations of their workloads and systems.

===

Nevertheless, this commit is defining and implementing only basic access
check part without the overhead-accuracy handling core logic.  The basic
access check is as below.

The output of DAMON says what memory regions are how frequently accessed
for a given duration.  The resolution of the access frequency is
controlled by setting ``sampling interval`` and ``aggregation
interval``.  In detail, DAMON checks access to each page per ``sampling
interval`` and aggregates the results.  In other words, counts the
number of the accesses to each region.  After each ``aggregation
interval`` passes, DAMON calls callback functions that previously
registered by users so that users can read the aggregated results and
then clears the results.  This can be described in below simple
pseudo-code::

    init()
    while monitoring_on:
        for page in monitoring_target:
            if accessed(page):
                nr_accesses[page] += 1
        if time() % aggregation_interval == 0:
            for callback in user_registered_callbacks:
                callback(monitoring_target, nr_accesses)
            for page in monitoring_target:
                nr_accesses[page] = 0
        if time() % update_interval == 0:
            update()
        sleep(sampling interval)

The target regions constructed at the beginning of the monitoring and
updated after each ``regions_update_interval``, because the target
regions could be dynamically changed (e.g., mmap() or memory hotplug).
The monitoring overhead of this mechanism will arbitrarily increase as
the size of the target workload grows.

The basic monitoring primitives for actual access check and dynamic
target regions construction aren't in the core part of DAMON.  Instead,
it allows users to implement their own primitives that are optimized for
their use case and configure DAMON to use those.  In other words, users
cannot use current version of DAMON without some additional works.

Following commits will implement the core mechanisms for the
overhead-accuracy control and default primitives implementations.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
---
 include/linux/damon.h | 167 ++++++++++++++++++++++
 mm/Kconfig            |   3 +
 mm/Makefile           |   1 +
 mm/damon/Kconfig      |  15 ++
 mm/damon/Makefile     |   3 +
 mm/damon/core.c       | 318 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 507 insertions(+)
 create mode 100644 include/linux/damon.h
 create mode 100644 mm/damon/Kconfig
 create mode 100644 mm/damon/Makefile
 create mode 100644 mm/damon/core.c

diff --git a/include/linux/damon.h b/include/linux/damon.h
new file mode 100644
index 000000000000..2f652602b1ea
--- /dev/null
+++ b/include/linux/damon.h
@@ -0,0 +1,167 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DAMON api
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#ifndef _DAMON_H_
+#define _DAMON_H_
+
+#include <linux/mutex.h>
+#include <linux/time64.h>
+#include <linux/types.h>
+
+struct damon_ctx;
+
+/**
+ * struct damon_primitive	Monitoring primitives for given use cases.
+ *
+ * @init:			Initialize primitive-internal data structures.
+ * @update:			Update primitive-internal data structures.
+ * @prepare_access_checks:	Prepare next access check of target regions.
+ * @check_accesses:		Check the accesses to target regions.
+ * @reset_aggregated:		Reset aggregated accesses monitoring results.
+ * @target_valid:		Determine if the target is valid.
+ * @cleanup:			Clean up the context.
+ *
+ * DAMON can be extended for various address spaces and usages.  For this,
+ * users should register the low level primitives for their target address
+ * space and usecase via the &damon_ctx.primitive.  Then, the monitoring thread
+ * (&damon_ctx.kdamond) calls @init and @prepare_access_checks before starting
+ * the monitoring, @update after each &damon_ctx.primitive_update_interval, and
+ * @check_accesses, @target_valid and @prepare_access_checks after each
+ * &damon_ctx.sample_interval.  Finally, @reset_aggregated is called after each
+ * &damon_ctx.aggr_interval.
+ *
+ * @init should initialize primitive-internal data structures.  For example,
+ * this could be used to construct proper monitoring target regions and link
+ * those to @damon_ctx.target.
+ * @update should update the primitive-internal data structures.  For example,
+ * this could be used to update monitoring target regions for current status.
+ * @prepare_access_checks should manipulate the monitoring regions to be
+ * prepared for the next access check.
+ * @check_accesses should check the accesses to each region that made after the
+ * last preparation and update the number of observed accesses of each region.
+ * @reset_aggregated should reset the access monitoring results that aggregated
+ * by @check_accesses.
+ * @target_valid should check whether the target is still valid for the
+ * monitoring.
+ * @cleanup is called from @kdamond just before its termination.
+ */
+struct damon_primitive {
+	void (*init)(struct damon_ctx *context);
+	void (*update)(struct damon_ctx *context);
+	void (*prepare_access_checks)(struct damon_ctx *context);
+	void (*check_accesses)(struct damon_ctx *context);
+	void (*reset_aggregated)(struct damon_ctx *context);
+	bool (*target_valid)(void *target);
+	void (*cleanup)(struct damon_ctx *context);
+};
+
+/*
+ * struct damon_callback	Monitoring events notification callbacks.
+ *
+ * @before_start:	Called before starting the monitoring.
+ * @after_sampling:	Called after each sampling.
+ * @after_aggregation:	Called after each aggregation.
+ * @before_terminate:	Called before terminating the monitoring.
+ * @private:		User private data.
+ *
+ * The monitoring thread (&damon_ctx.kdamond) calls @before_start and
+ * @before_terminate just before starting and finishing the monitoring,
+ * respectively.  Therefore, those are good places for installing and cleaning
+ * @private.
+ *
+ * The monitoring thread calls @after_sampling and @after_aggregation for each
+ * of the sampling intervals and aggregation intervals, respectively.
+ * Therefore, users can safely access the monitoring results without additional
+ * protection.  For the reason, users are recommended to use these callback for
+ * the accesses to the results.
+ *
+ * If any callback returns non-zero, monitoring stops.
+ */
+struct damon_callback {
+	void *private;
+
+	int (*before_start)(struct damon_ctx *context);
+	int (*after_sampling)(struct damon_ctx *context);
+	int (*after_aggregation)(struct damon_ctx *context);
+	int (*before_terminate)(struct damon_ctx *context);
+};
+
+/**
+ * struct damon_ctx - Represents a context for each monitoring.  This is the
+ * main interface that allows users to set the attributes and get the results
+ * of the monitoring.
+ *
+ * @sample_interval:		The time between access samplings.
+ * @aggr_interval:		The time between monitor results aggregations.
+ * @primitive_update_interval:	The time between monitoring primitive updates.
+ *
+ * For each @sample_interval, DAMON checks whether each region is accessed or
+ * not.  It aggregates and keeps the access information (number of accesses to
+ * each region) for @aggr_interval time.  DAMON also checks whether the target
+ * memory regions need update (e.g., by ``mmap()`` calls from the application,
+ * in case of virtual memory monitoring) and applies the changes for each
+ * @primitive_update_interval.  All time intervals are in micro-seconds.
+ * Please refer to &struct damon_primitive and &struct damon_callback for more
+ * detail.
+ *
+ * @kdamond:		Kernel thread who does the monitoring.
+ * @kdamond_stop:	Notifies whether kdamond should stop.
+ * @kdamond_lock:	Mutex for the synchronizations with @kdamond.
+ *
+ * For each monitoring context, one kernel thread for the monitoring is
+ * created.  The pointer to the thread is stored in @kdamond.
+ *
+ * Once started, the monitoring thread runs until explicitly required to be
+ * terminated or every monitoring target is invalid.  The validity of the
+ * targets is checked via the &damon_primitive.target_valid of @primitive.  The
+ * termination can also be explicitly requested by writing non-zero to
+ * @kdamond_stop.  The thread sets @kdamond to NULL when it terminates.
+ * Therefore, users can know whether the monitoring is ongoing or terminated by
+ * reading @kdamond.  Reads and writes to @kdamond and @kdamond_stop from
+ * outside of the monitoring thread must be protected by @kdamond_lock.
+ *
+ * Note that the monitoring thread protects only @kdamond and @kdamond_stop via
+ * @kdamond_lock.  Accesses to other fields must be protected by themselves.
+ *
+ * @primitive:	Set of monitoring primitives for given use cases.
+ * @callback:	Set of callbacks for monitoring events notifications.
+ *
+ * @target:	Pointer to the user-defined monitoring target.
+ */
+struct damon_ctx {
+	unsigned long sample_interval;
+	unsigned long aggr_interval;
+	unsigned long primitive_update_interval;
+
+/* private: internal use only */
+	struct timespec64 last_aggregation;
+	struct timespec64 last_primitive_update;
+
+/* public: */
+	struct task_struct *kdamond;
+	bool kdamond_stop;
+	struct mutex kdamond_lock;
+
+	struct damon_primitive primitive;
+	struct damon_callback callback;
+
+	void *target;
+};
+
+#ifdef CONFIG_DAMON
+
+struct damon_ctx *damon_new_ctx(void);
+void damon_destroy_ctx(struct damon_ctx *ctx);
+int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
+		unsigned long aggr_int, unsigned long primitive_upd_int);
+
+int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
+int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
+
+#endif	/* CONFIG_DAMON */
+
+#endif	/* _DAMON_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index b20e2d6d9811..43d50f93789d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -896,4 +896,7 @@ config SECRETMEM
 # struct io_mapping based helper.  Selected by drivers that need them
 config IO_MAPPING
 	bool
+
+source "mm/damon/Kconfig"
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index a9ad6122d468..e73edb328ef8 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -126,3 +126,4 @@ obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
 obj-$(CONFIG_IO_MAPPING) += io-mapping.o
+obj-$(CONFIG_DAMON) += damon/
diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
new file mode 100644
index 000000000000..d00e99ac1a15
--- /dev/null
+++ b/mm/damon/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "Data Access Monitoring"
+
+config DAMON
+	bool "DAMON: Data Access Monitoring Framework"
+	help
+	  This builds a framework that allows kernel subsystems to monitor
+	  access frequency of each memory region. The information can be useful
+	  for performance-centric DRAM level memory management.
+
+	  See https://damonitor.github.io/doc/html/latest-damon/index.html for
+	  more information.
+
+endmenu
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
new file mode 100644
index 000000000000..4fd2edb4becf
--- /dev/null
+++ b/mm/damon/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DAMON)		:= core.o
diff --git a/mm/damon/core.c b/mm/damon/core.c
new file mode 100644
index 000000000000..693e51ebc05a
--- /dev/null
+++ b/mm/damon/core.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Data Access Monitor
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#define pr_fmt(fmt) "damon: " fmt
+
+#include <linux/damon.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/slab.h>
+
+static DEFINE_MUTEX(damon_lock);
+static int nr_running_ctxs;
+
+struct damon_ctx *damon_new_ctx(void)
+{
+	struct damon_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	ctx->sample_interval = 5 * 1000;
+	ctx->aggr_interval = 100 * 1000;
+	ctx->primitive_update_interval = 1000 * 1000;
+
+	ktime_get_coarse_ts64(&ctx->last_aggregation);
+	ctx->last_primitive_update = ctx->last_aggregation;
+
+	mutex_init(&ctx->kdamond_lock);
+
+	ctx->target = NULL;
+
+	return ctx;
+}
+
+void damon_destroy_ctx(struct damon_ctx *ctx)
+{
+	if (ctx->primitive.cleanup)
+		ctx->primitive.cleanup(ctx);
+	kfree(ctx);
+}
+
+/**
+ * damon_set_attrs() - Set attributes for the monitoring.
+ * @ctx:		monitoring context
+ * @sample_int:		time interval between samplings
+ * @aggr_int:		time interval between aggregations
+ * @primitive_upd_int:	time interval between monitoring primitive updates
+ *
+ * This function should not be called while the kdamond is running.
+ * Every time interval is in micro-seconds.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
+		    unsigned long aggr_int, unsigned long primitive_upd_int)
+{
+	ctx->sample_interval = sample_int;
+	ctx->aggr_interval = aggr_int;
+	ctx->primitive_update_interval = primitive_upd_int;
+
+	return 0;
+}
+
+static bool damon_kdamond_running(struct damon_ctx *ctx)
+{
+	bool running;
+
+	mutex_lock(&ctx->kdamond_lock);
+	running = ctx->kdamond != NULL;
+	mutex_unlock(&ctx->kdamond_lock);
+
+	return running;
+}
+
+static int kdamond_fn(void *data);
+
+/*
+ * __damon_start() - Starts monitoring with given context.
+ * @ctx:	monitoring context
+ *
+ * This function should be called while damon_lock is hold.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int __damon_start(struct damon_ctx *ctx)
+{
+	int err = -EBUSY;
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (!ctx->kdamond) {
+		err = 0;
+		ctx->kdamond_stop = false;
+		ctx->kdamond = kthread_create(kdamond_fn, ctx, "kdamond.%d",
+				nr_running_ctxs);
+		if (IS_ERR(ctx->kdamond))
+			err = PTR_ERR(ctx->kdamond);
+		else
+			wake_up_process(ctx->kdamond);
+	}
+	mutex_unlock(&ctx->kdamond_lock);
+
+	return err;
+}
+
+/**
+ * damon_start() - Starts the monitorings for a given group of contexts.
+ * @ctxs:	an array of the pointers for contexts to start monitoring
+ * @nr_ctxs:	size of @ctxs
+ *
+ * This function starts a group of monitoring threads for a group of monitoring
+ * contexts.  One thread per each context is created and run in parallel.  The
+ * caller should handle synchronization between the threads by itself.  If a
+ * group of threads that created by other 'damon_start()' call is currently
+ * running, this function does nothing but returns -EBUSY.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
+{
+	int i;
+	int err = 0;
+
+	mutex_lock(&damon_lock);
+	if (nr_running_ctxs) {
+		mutex_unlock(&damon_lock);
+		return -EBUSY;
+	}
+
+	for (i = 0; i < nr_ctxs; i++) {
+		err = __damon_start(ctxs[i]);
+		if (err)
+			break;
+		nr_running_ctxs++;
+	}
+	mutex_unlock(&damon_lock);
+
+	return err;
+}
+
+/*
+ * __damon_stop() - Stops monitoring of given context.
+ * @ctx:	monitoring context
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int __damon_stop(struct damon_ctx *ctx)
+{
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		ctx->kdamond_stop = true;
+		mutex_unlock(&ctx->kdamond_lock);
+		while (damon_kdamond_running(ctx))
+			usleep_range(ctx->sample_interval,
+					ctx->sample_interval * 2);
+		return 0;
+	}
+	mutex_unlock(&ctx->kdamond_lock);
+
+	return -EPERM;
+}
+
+/**
+ * damon_stop() - Stops the monitorings for a given group of contexts.
+ * @ctxs:	an array of the pointers for contexts to stop monitoring
+ * @nr_ctxs:	size of @ctxs
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
+{
+	int i, err = 0;
+
+	for (i = 0; i < nr_ctxs; i++) {
+		/* nr_running_ctxs is decremented in kdamond_fn */
+		err = __damon_stop(ctxs[i]);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
+/*
+ * damon_check_reset_time_interval() - Check if a time interval is elapsed.
+ * @baseline:	the time to check whether the interval has elapsed since
+ * @interval:	the time interval (microseconds)
+ *
+ * See whether the given time interval has passed since the given baseline
+ * time.  If so, it also updates the baseline to current time for next check.
+ *
+ * Return:	true if the time interval has passed, or false otherwise.
+ */
+static bool damon_check_reset_time_interval(struct timespec64 *baseline,
+		unsigned long interval)
+{
+	struct timespec64 now;
+
+	ktime_get_coarse_ts64(&now);
+	if ((timespec64_to_ns(&now) - timespec64_to_ns(baseline)) <
+			interval * 1000)
+		return false;
+	*baseline = now;
+	return true;
+}
+
+/*
+ * Check whether it is time to flush the aggregated information
+ */
+static bool kdamond_aggregate_interval_passed(struct damon_ctx *ctx)
+{
+	return damon_check_reset_time_interval(&ctx->last_aggregation,
+			ctx->aggr_interval);
+}
+
+/*
+ * Check whether it is time to check and apply the target monitoring regions
+ *
+ * Returns true if it is.
+ */
+static bool kdamond_need_update_primitive(struct damon_ctx *ctx)
+{
+	return damon_check_reset_time_interval(&ctx->last_primitive_update,
+			ctx->primitive_update_interval);
+}
+
+/*
+ * Check whether current monitoring should be stopped
+ *
+ * The monitoring is stopped when either the user requested to stop, or all
+ * monitoring targets are invalid.
+ *
+ * Returns true if need to stop current monitoring.
+ */
+static bool kdamond_need_stop(struct damon_ctx *ctx)
+{
+	bool stop;
+
+	mutex_lock(&ctx->kdamond_lock);
+	stop = ctx->kdamond_stop;
+	mutex_unlock(&ctx->kdamond_lock);
+	if (stop)
+		return true;
+
+	if (!ctx->primitive.target_valid)
+		return false;
+
+	return !ctx->primitive.target_valid(ctx->target);
+}
+
+static void set_kdamond_stop(struct damon_ctx *ctx)
+{
+	mutex_lock(&ctx->kdamond_lock);
+	ctx->kdamond_stop = true;
+	mutex_unlock(&ctx->kdamond_lock);
+}
+
+/*
+ * The monitoring daemon that runs as a kernel thread
+ */
+static int kdamond_fn(void *data)
+{
+	struct damon_ctx *ctx = (struct damon_ctx *)data;
+
+	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
+
+	if (ctx->primitive.init)
+		ctx->primitive.init(ctx);
+	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
+		set_kdamond_stop(ctx);
+
+	while (!kdamond_need_stop(ctx)) {
+		if (ctx->primitive.prepare_access_checks)
+			ctx->primitive.prepare_access_checks(ctx);
+		if (ctx->callback.after_sampling &&
+				ctx->callback.after_sampling(ctx))
+			set_kdamond_stop(ctx);
+
+		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
+
+		if (ctx->primitive.check_accesses)
+			ctx->primitive.check_accesses(ctx);
+
+		if (kdamond_aggregate_interval_passed(ctx)) {
+			if (ctx->callback.after_aggregation &&
+					ctx->callback.after_aggregation(ctx))
+				set_kdamond_stop(ctx);
+			if (ctx->primitive.reset_aggregated)
+				ctx->primitive.reset_aggregated(ctx);
+		}
+
+		if (kdamond_need_update_primitive(ctx)) {
+			if (ctx->primitive.update)
+				ctx->primitive.update(ctx);
+		}
+	}
+
+	if (ctx->callback.before_terminate &&
+			ctx->callback.before_terminate(ctx))
+		set_kdamond_stop(ctx);
+	if (ctx->primitive.cleanup)
+		ctx->primitive.cleanup(ctx);
+
+	pr_debug("kdamond (%d) finishes\n", ctx->kdamond->pid);
+	mutex_lock(&ctx->kdamond_lock);
+	ctx->kdamond = NULL;
+	mutex_unlock(&ctx->kdamond_lock);
+
+	mutex_lock(&damon_lock);
+	nr_running_ctxs--;
+	mutex_unlock(&damon_lock);
+
+	do_exit(0);
+}
-- 
2.17.1

