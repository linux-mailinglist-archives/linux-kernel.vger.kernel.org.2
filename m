Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B853CFA75
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbhGTMjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238520AbhGTMeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:34:07 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6071BC061762;
        Tue, 20 Jul 2021 06:14:45 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id gh6so10054384qvb.3;
        Tue, 20 Jul 2021 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M4zJ88ccAMF8JuzRAtdnkdZF1CqPuLIAgD1DSEm1rbE=;
        b=YUUK8GhClXqWngv7zXnAZce2VwjbZ3dp9fx1Ejna0LHhId8H29J94+8VvtuoJPgmj3
         1HixAY3GBBmm2cnm93WjzgrlG+42J5dA8BTNomwhiBMDo1xIrgqP3wtkZTYOMw3QGWHg
         TFczcHREJI780XQGgjlIG/ns34DN6Vf/duf/J6ijsozFsDRVq+x5xvJHsRi7kF2Sp7/0
         o88NYfYq6WuKeuc77G15LAuicjY9J6WLM0cZtGrd+OHtJkh6IRMd9Mu+5O950RBi7Psl
         BMLKZ+bEQhb3WmqtWRZj45mM7pIC3OBxbUB00Ez7SWAkcI95uwt086k0uFxEZYaTxhtk
         fbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M4zJ88ccAMF8JuzRAtdnkdZF1CqPuLIAgD1DSEm1rbE=;
        b=JjwG1B12qERF18rlohXQhe+dsBIGDWgqNe326MySgmNJEa1Gg57xQwEdAR7Srukrwl
         9qnJE8q6yT7PHVk/jQpdgwIZkngTy3ltgWikGo+O2gI3BEbMNwcc4dRffOEBPM+2vUAb
         Jr4SMu5Bjfz+FIX6DSTys5+lR82d4vb3eRL42O7YPCmm2M7IISwnrAFmcmxs/cql+Jk8
         tpP+T1Qf2xk09CqmavwVJYS775P0vDMTugbxbXbSlaZUSZWkFopjAOdpK5wmTT+YKQlc
         fOHEUnLAqp8cxuarbzbHuHWSVOjWWq2s8ou6mkM4R4qUTM/Wsxne6PUnerLqD2qVLGo6
         ZpTQ==
X-Gm-Message-State: AOAM530wCzMg0o5e6tNDb0oCZz6FLZ+SV6222jFPtRWaTOFRzBMxSMdR
        6ld25c18qONSBsE38Pp4S5Y=
X-Google-Smtp-Source: ABdhPJxz/AR3LRboVuwsHGRuWmdfmxKoqde57fBaVus1XPErGIwYFDPfulYa/xSTzbAO+vQS4qh0pw==
X-Received: by 2002:ad4:4654:: with SMTP id y20mr29892806qvv.21.1626786884534;
        Tue, 20 Jul 2021 06:14:44 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g17sm9701225qkm.34.2021.07.20.06.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:14:44 -0700 (PDT)
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
Subject: [RFC v3 14/15] mm/damon: Introduce DAMON-based reclamation
Date:   Tue, 20 Jul 2021 13:13:08 +0000
Message-Id: <20210720131309.22073-15-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720131309.22073-1-sj38.park@gmail.com>
References: <20210720131309.22073-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit implements a new kernel subsystem that finds cold memory
regions using DAMON and reclaims those immediately.  It is intended to
be used as proactive lightweigh reclamation logic for light memory
pressure.  For heavy memory pressure, it could be inactivated and fall
back to the traditional page-scanning based reclamation.

It's implemented on top of DAMON framework to use the DAMON-based
Operation Schemes (DAMOS) feature.  It utilizes all the DAMOS features
including speed limit, prioritization, and watermarks.

It could be enabled and tuned in build time via the kernel
configuration, in boot time via the kernel boot parameter, and in run
time via its module parameter ('/sys/module/damon_reclaim/parameters/')
interface.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/Kconfig   |  12 ++
 mm/damon/Makefile  |   1 +
 mm/damon/reclaim.c | 354 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 367 insertions(+)
 create mode 100644 mm/damon/reclaim.c

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index eeefb5b633b6..d9cd88810279 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -84,4 +84,16 @@ config DAMON_DBGFS_KUNIT_TEST
 
 	  If unsure, say N.
 
+config DAMON_RECLAIM
+	bool "Build DAMON-based reclaim (DAMON_RECLAIM)"
+	depends on DAMON_PADDR
+	help
+	  This builds the DAMON-based reclamation subsystem.  It finds pages
+	  that not accessed for a long time (cold) using DAMON and reclaim
+	  those if enabled.
+
+	  This is suggested to be used as a proactive and lightweight
+	  reclamation under light memory pressure, while the traditional page
+	  scanning-based reclamation is used for heavy pressure.
+
 endmenu
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index 017799e5670a..39433e7d570c 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_DAMON_VADDR)	+= prmtv-common.o vaddr.o
 obj-$(CONFIG_DAMON_PADDR)	+= prmtv-common.o paddr.o
 obj-$(CONFIG_DAMON_PGIDLE)	+= prmtv-common.o pgidle.o
 obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
+obj-$(CONFIG_DAMON_RECLAIM)	+= reclaim.o
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
new file mode 100644
index 000000000000..147fd1304b7b
--- /dev/null
+++ b/mm/damon/reclaim.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DAMON-based page reclamation
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#define pr_fmt(fmt) "damon-reclaim: " fmt
+
+#include <linux/damon.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/workqueue.h>
+
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "damon_reclaim."
+
+/*
+ * Enable or disable DAMON_RECLAIM.
+ *
+ * You can enable DAMON_RCLAIM by setting the value of this parameter as ``Y``.
+ * Setting it as ``N`` disables DAMON_RECLAIM.  Note that DAMON_RECLAIM could
+ * do no real monitoring and reclamation due to the watermarks-based activation
+ * condition.  Refer to below descriptions for the watermarks parameter for
+ * this.
+ */
+static bool enabled __read_mostly;
+module_param(enabled, bool, 0600);
+
+/*
+ * Time threshold for cold memory regions identification in microseconds.
+ *
+ * If a memory region is not accessed for this or longer time, DAMON_RECLAIM
+ * identifies the region as cold, and reclaims.  5 seconds by default.
+ */
+static unsigned long min_age __read_mostly = 5000000;
+module_param(min_age, ulong, 0600);
+
+/*
+ * Limit of time for trying the reclamation in milliseconds.
+ *
+ * DAMON_RECLAIM tries to use only up to this time within a time window
+ * (quota_reset_interval_ms) for trying reclamation of cold pages.  This can be
+ * used for limiting CPU consumption of DAMON_RECLAIM.  If the value is zero,
+ * the limit is disabled.
+ *
+ * 100 ms by default.
+ */
+static unsigned long quota_ms __read_mostly = 100;
+module_param(quota_ms, ulong, 0600);
+
+/*
+ * Limit of size of memory for the reclamation in bytes.
+ *
+ * DAMON_RECLAIM charges amount of memory which it tried to reclaim within a
+ * time window (quota_reset_interval_ms) and makes no more than this limit is
+ * tried.  This can be used for limiting consumption of CPU and IO.  If this
+ * value is zero, the limit is disabled.
+ *
+ * 1 GiB by default.
+ */
+static unsigned long quota_sz __read_mostly = 1024 * 1024 * 1024;
+module_param(quota_sz, ulong, 0600);
+
+/*
+ * The time/size quota charge reset interval in milliseconds.
+ *
+ * The charge reset interval for the quota of time (quota_ms) and size
+ * (quota_sz).  That is, DAMON_RECLAIM does not try reclamation for more than
+ * quota_ms milliseconds or quota_sz bytes within quota_reset_interval_ms
+ * milliseconds.
+ *
+ * 1 second by default.
+ */
+static unsigned long quota_reset_interval_ms __read_mostly = 1000;
+module_param(quota_reset_interval_ms, ulong, 0600);
+
+/*
+ * The watermarks check time interval in microseconds.
+ *
+ * Minimal time to wait before checking the watermarks, when DAMON_RECLAIM is
+ * enabled but inactive due to its watermarks rule.  5 seconds by default.
+ */
+static unsigned long wmarks_interval __read_mostly = 5000000;
+module_param(wmarks_interval, ulong, 0600);
+
+/*
+ * Free memory rate (per thousand) for the high watermark.
+ *
+ * If free memory of the system in bytes per thousand bytes is higher than
+ * this, DAMON_RECLAIM becomes inactive, so it does nothing but periodically
+ * checks the watermarks.  500 (50%) by default.
+ */
+static unsigned long wmarks_high __read_mostly = 500;
+module_param(wmarks_high, ulong, 0600);
+
+/*
+ * Free memory rate (per thousand) for the middle watermark.
+ *
+ * If free memory of the system in bytes per thousand bytes is between this and
+ * the low watermark, DAMON_RECLAIM becomes active, so starts the monitoring
+ * and the reclaiming.  400 (40%) by default.
+ */
+static unsigned long wmarks_mid __read_mostly = 400;
+module_param(wmarks_mid, ulong, 0600);
+
+/*
+ * Free memory rate (per thousand) for the low watermark.
+ *
+ * If free memory of the system in bytes per thousand bytes is lower than this,
+ * DAMON_RECLAIM becomes inactive, so it does nothing but periodically checks
+ * the watermarks.  In the case, the system falls back to the LRU-based page
+ * granularity reclamation logic.  200 (20%) by default.
+ */
+static unsigned long wmarks_low __read_mostly = 200;
+module_param(wmarks_low, ulong, 0600);
+
+/*
+ * Sampling interval for the monitoring in microseconds.
+ *
+ * The sampling interval of DAMON for the cold memory monitoring.  Please refer
+ * to the DAMON documentation for more detail.  5 ms by default.
+ */
+static unsigned long sample_interval __read_mostly = 5000;
+module_param(sample_interval, ulong, 0600);
+
+/*
+ * Aggregation interval for the monitoring in microseconds.
+ *
+ * The aggregation interval of DAMON for the cold memory monitoring.  Please
+ * refer to the DAMON documentation for more detail.  100 ms by default.
+ */
+static unsigned long aggr_interval __read_mostly = 100000;
+module_param(aggr_interval, ulong, 0600);
+
+/*
+ * Minimum number of monitoring regions.
+ *
+ * The minimal number of monitoring regions of DAMON for the cold memory
+ * monitoring.  This can be used to set lower-bound of the monitoring quality.
+ * But, setting this too high could result in increased monitoring overhead.
+ * Please refer to the DAMON documentation for more detail.  10 by default.
+ */
+static unsigned long min_nr_regions __read_mostly = 10;
+module_param(min_nr_regions, ulong, 0600);
+
+/*
+ * Maximum number of monitoring regions.
+ *
+ * The maximum number of monitoring regions of DAMON for the cold memory
+ * monitoring.  This can be used to set upper-bound of the monitoring overhead.
+ * However, setting this too low could result in bad monitoring quality.
+ * Please refer to the DAMON documentation for more detail.  1000 by default.
+ */
+static unsigned long max_nr_regions __read_mostly = 1000;
+module_param(max_nr_regions, ulong, 0600);
+
+/*
+ * Start of the target memory region in physical address.
+ *
+ * The start physical address of memory region that DAMON_RECLAIM will do work
+ * against.  By default, biggest System RAM is used as the region.
+ */
+static unsigned long monitor_region_start __read_mostly;
+module_param(monitor_region_start, ulong, 0600);
+
+/*
+ * End of the target memory region in physical address.
+ *
+ * The end physical address of memory region that DAMON_RECLAIM will do work
+ * against.  By default, biggest System RAM is used as the region.
+ */
+static unsigned long monitor_region_end __read_mostly;
+module_param(monitor_region_end, ulong, 0600);
+
+/*
+ * PID of the DAMON thread
+ *
+ * If DAMON_RECLAIM is enabled, this becomes the PID of the worker thread.
+ * Else, -1.
+ */
+static int kdamond_pid __read_mostly = -1;
+module_param(kdamond_pid, int, 0400);
+
+static struct damon_ctx *ctx;
+static struct damon_target *target;
+
+struct damon_reclaim_ram_walk_arg {
+	unsigned long start;
+	unsigned long end;
+};
+
+static int walk_system_ram(struct resource *res, void *arg)
+{
+	struct damon_reclaim_ram_walk_arg *a = arg;
+
+	if (a->end - a->start < res->end - res->start) {
+		a->start = res->start;
+		a->end = res->end;
+	}
+	return 0;
+}
+
+/*
+ * Find biggest 'System RAM' resource and store its start and end address in
+ * @start and @end, respectively.  If no System RAM is found, returns false.
+ */
+static bool get_monitoring_region(unsigned long *start, unsigned long *end)
+{
+	struct damon_reclaim_ram_walk_arg arg = {};
+
+	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
+	if (arg.end <= arg.start)
+		return false;
+
+	*start = arg.start;
+	*end = arg.end;
+	return true;
+}
+
+static struct damos *damon_reclaim_new_scheme(void)
+{
+	struct damos_watermarks wmarks = {
+		.metric = DAMOS_WMARK_FREE_MEM_RATE,
+		.interval = wmarks_interval,
+		.high = wmarks_high,
+		.mid = wmarks_mid,
+		.low = wmarks_low,
+	};
+	struct damos_quota quota = {
+		/*
+		 * Do not try reclamation for more than quota_ms milliseconds
+		 * or quota_sz bytes within quota_reset_interval_ms.
+		 */
+		.ms = quota_ms,
+		.sz = quota_sz,
+		.reset_interval = quota_reset_interval_ms,
+		/* Within the quota, page out older regions first. */
+		.weight_sz = 0,
+		.weight_nr_accesses = 0,
+		.weight_age = 1
+	};
+	struct damos *scheme = damon_new_scheme(
+			/* Find regions having PAGE_SIZE or larger size */
+			PAGE_SIZE, ULONG_MAX,
+			/* and not accessed at all */
+			0, 0,
+			/* for min_age or more micro-seconds, and */
+			min_age / aggr_interval, UINT_MAX,
+			/* page out those, as soon as found */
+			DAMOS_PAGEOUT,
+			/* under the quota. */
+			&quota,
+			/* (De)activate this according to the watermarks. */
+			&wmarks);
+
+	return scheme;
+}
+
+static int damon_reclaim_turn(bool on)
+{
+	struct damon_region *region;
+	struct damos *scheme;
+	int err;
+
+	if (!on) {
+		err = damon_stop(&ctx, 1);
+		if (!err)
+			kdamond_pid = -1;
+		return err;
+	}
+
+	err = damon_set_attrs(ctx, sample_interval, aggr_interval, 0,
+			min_nr_regions, max_nr_regions);
+	if (err)
+		return err;
+
+	if (monitor_region_start > monitor_region_end)
+		return -EINVAL;
+	if (!monitor_region_start && !monitor_region_end &&
+			!get_monitoring_region(&monitor_region_start,
+				&monitor_region_end))
+		return -EINVAL;
+	/* DAMON will free this on its own when finish monitoring */
+	region = damon_new_region(monitor_region_start, monitor_region_end);
+	if (!region)
+		return -ENOMEM;
+	damon_add_region(region, target);
+
+	/* Will be freed by 'damon_set_schemes()' below */
+	scheme = damon_reclaim_new_scheme();
+	if (!scheme)
+		goto free_region_out;
+	err = damon_set_schemes(ctx, &scheme, 1);
+	if (err)
+		goto free_scheme_out;
+
+	err = damon_start(&ctx, 1);
+	if (!err) {
+		kdamond_pid = ctx->kdamond->pid;
+		return 0;
+	}
+
+free_scheme_out:
+	damon_destroy_scheme(scheme);
+free_region_out:
+	damon_destroy_region(region, target);
+	return err;
+}
+
+#define ENABLE_CHECK_INTERVAL_MS	1000
+static struct delayed_work damon_reclaim_timer;
+static void damon_reclaim_timer_fn(struct work_struct *work)
+{
+	static bool last_enabled;
+	bool now_enabled;
+
+	now_enabled = enabled;
+	if (last_enabled != now_enabled) {
+		if (!damon_reclaim_turn(now_enabled))
+			last_enabled = now_enabled;
+		else
+			enabled = last_enabled;
+	}
+
+	schedule_delayed_work(&damon_reclaim_timer,
+			msecs_to_jiffies(ENABLE_CHECK_INTERVAL_MS));
+}
+static DECLARE_DELAYED_WORK(damon_reclaim_timer, damon_reclaim_timer_fn);
+
+static int __init damon_reclaim_init(void)
+{
+	ctx = damon_new_ctx(DAMON_ADAPTIVE_TARGET);
+	if (!ctx)
+		return -ENOMEM;
+
+	damon_pa_set_primitives(ctx);
+
+	/* 4242 means nothing but fun */
+	target = damon_new_target(4242);
+	if (!target) {
+		damon_destroy_ctx(ctx);
+		return -ENOMEM;
+	}
+	damon_add_target(ctx, target);
+
+	schedule_delayed_work(&damon_reclaim_timer, 0);
+	return 0;
+}
+
+module_init(damon_reclaim_init);
-- 
2.17.1

