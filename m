Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3454339631B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 17:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhEaPG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbhEaOID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:08:03 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96518C08C5F3;
        Mon, 31 May 2021 06:38:54 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c20so11216263qkm.3;
        Mon, 31 May 2021 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ygvuLtK2l+Yx1mw1REo1hwI+lDORYTPMl8fO1mx/S4=;
        b=DytsOIlOvLnGFzx7yvqkXzBB3urgZxz60nQLwnA17PZgHB61TPw5Clg2MY4zu/9qyV
         aOm0Z26AHyEmjbVEYT7Uzy4XFGkybQ1vZlQeGJTEkGMo6DsLNQsrQk23qfTuzbOk6goR
         kP5BLhIj+Q8XmRY1/qzq2GviUi1rnCPBKMYvlpHhcQC7OVtGN0U1zO7hVLbpJc01ZWbp
         MfBGldcQt1ufYEGc74IJHO9Pyr3PbZNHZ/+VDDYZbOurATGg0X+bGupSdHFLyJshrENt
         88eCniI5Le6RYCfzNShaN2GIeCYtrQCjilMTtwDlIXA7xFAjJZztZZ7KJgH5FBoxpuTm
         UoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6ygvuLtK2l+Yx1mw1REo1hwI+lDORYTPMl8fO1mx/S4=;
        b=L125TkYYH/KcEOGZf4Ix64gKMkdKT5AAoExkyvuI74EqGQiWoiM3lD85jPdCEC5Xan
         EcnAZdyfGwofNfo8LIdT54Vhlx/48hfnhPEqJTfO7m2gIGzMMR2hwC4f7UjkmhFtHfS2
         2oRiINaFkKRMnn8KQXFAi/V6e69T7mw9bHRoC/e6KRoOi8YOlhwhmCWR6zPo6cLw9zsi
         /DKzPRg7Hj1yOq7y4TGz7d5UFiGMLhKD74M4Ow4CMmwkUv8eSIBAmuQpg36A2jo6mYoh
         nJHWIPyRWz7U55pnPSR/y058yCLZHYtYBNH92ntqJmx1rZMVH/Fx14obqbnZE/KUsge0
         VHGQ==
X-Gm-Message-State: AOAM530jr8iqZ//z3Y5impxgMZwj1SXwfBA8Lf1DvoII6Ce0z0ndSpMS
        jOnBV21yJ1GB54ERcq8ogFQ=
X-Google-Smtp-Source: ABdhPJwE64vx6b6yyM8KuVqgNyO487evVs5DNOz2T/eR1pkzUpbEBX81ZBEdOf3II1uMygzZDcv8Nw==
X-Received: by 2002:a05:620a:3c8:: with SMTP id r8mr16510443qkm.204.1622468333635;
        Mon, 31 May 2021 06:38:53 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h8sm8293085qtp.46.2021.05.31.06.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 06:38:53 -0700 (PDT)
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
Subject: [RFC PATCH 13/13] mm/damon: Introduce DAMON-based reclamation
Date:   Mon, 31 May 2021 13:38:16 +0000
Message-Id: <20210531133816.12689-14-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210531133816.12689-1-sj38.park@gmail.com>
References: <20210531133816.12689-1-sj38.park@gmail.com>
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
 mm/damon/Kconfig   | 128 +++++++++++++++++++++++++
 mm/damon/Makefile  |   1 +
 mm/damon/reclaim.c | 230 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 359 insertions(+)
 create mode 100644 mm/damon/reclaim.c

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index eeefb5b633b6..f629818e4793 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -84,4 +84,132 @@ config DAMON_DBGFS_KUNIT_TEST
 
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
+config DAMON_RECLAIM_ENABLE
+	bool "Enable DAMON-based reclaim"
+	depends on DAMON_RECLAIM
+	help
+	  Make DAMON_RECLAIM starts work after booting.  If this is not set,
+	  user could enable it using its runtime interface.
+
+config DAMON_RECLAIM_MIN_AGE
+	int "Minimal microseconds of region to not accessed to be cold"
+	depends on DAMON_RECLAIM
+	default 5000000
+	help
+	  If a memory region has not accessed for this or longer time,
+	  DAMON_RECLAIM identifies the region as cold and reclaim.
+	  5 seconds by default.
+
+config DAMON_RECLAIM_LIMIT_SZ
+	int "Maximum bytes of memory to be reclaimed in each charging window"
+	depends on DAMON_RECLAIM
+	default 1073741824
+	help
+	  DAMON_RECLAIM charges amount of memory reclaimed within each charging
+	  time window and limits no more than this limit is charged.  This
+	  could be useful for limiting CPU usage of DAMON_RECLAIM.
+	  1 GiB by default.
+
+config DAMON_RECLAIM_LIMIT_MS
+	int "The reclaimed memory charging window in milliseconds"
+	depends on DAMON_RECLAIM
+	default 1000
+	help
+	  The charge window for DAMON_RECLAIM_LIMIT_SZ.
+	  1 second by default.
+
+config DAMON_RECLAIM_WATERMARK_CHECK_INTERVAL
+	int "DAMON_RECLAIM watermarks check time interval in microseconds"
+	depends on DAMON_RECLAIM
+	default 5000000
+	help
+	  Minimal time to wait before checking the watermarks, when
+	  DAMON_RECLAIM is enabled but inactive due to its watermarks rule.
+	  5 seconds by default.
+
+config DAMON_RECLAIM_WATERMARK_HIGH
+	int "Free memory rate (per thousand) for the high watermark"
+	range 0 1000
+	depends on DAMON_RECLAIM
+	default 500
+	help
+	  If free memory of the system in bytes per thousand bytes is higher
+	  than this, DAMON_RECLAIM becomes inactive, so it does nothing but
+	  periodically checks the watermarks.  500 by default.
+
+config DAMON_RECLAIM_WATERMARK_MID
+	int "Free memory rate (per thousand) for the middle watermark"
+	range 0 1000
+	depends on DAMON_RECLAIM
+	default 400
+	help
+	  If free memory of the system in bytes per thousand bytes is between
+	  this and the low watermark, DAMON_RECLAIM becomes active, so starts
+	  the work.
+	  400 by default.
+
+config DAMON_RECLAIM_WATERMARK_LOW
+	int "Free memory rate (per thousand) for the low watermark"
+	range 0 1000
+	depends on DAMON_RECLAIM
+	default 200
+	help
+	  If free memory of the system in bytes per thousand bytes is lower
+	  than this, DAMON_RECLAIM becomes inactive, so does nothing but
+	  periodically checks the watermarks.  So, in this case, we fall back
+	  to the traditional page scanning-based reclamation logic.
+	  200 by default.
+
+config DAMON_RECLAIM_SAMPLING_INTERVAL
+	int "Sampling interval for the monitoring in microseconds"
+	depends on DAMON_RECLAIM
+	default 5000
+	help
+	  The sampling interval of DAMON for the DAMON_RECLAIM.  Please refer
+	  to the DAMON documentation for more detail.
+	  5 ms by default.
+
+config DAMON_RECLAIM_AGGREGATION_INTERVAL
+	int "Aggregation interval for the monitoring in microseconds"
+	depends on DAMON_RECLAIM
+	default 100000
+	help
+	  The aggregation interval of DAMON for the DAMON_RECLAIM.  Please
+	  refer to the DAMON documentation for more detail.
+	  reclaim.  100 ms by default.
+
+config DAMON_RECLAIM_MIN_NR_REGIONS
+	int "Minimum number of monitoring regions"
+	depends on DAMON_RECLAIM
+	default 10
+	help
+	  The minimal number of monitoring regions for DAMON_RECLAIM.  Can be
+	  used to set lower-bound of the monitoring's quality.  But setting
+	  this too high could result in increased monitoring overhead.  Please
+	  refer to the DAMON documentation for more detail.
+	  10 by default.
+
+config DAMON_RECLAIM_MAX_NR_REGIONS
+	int "Maximum number of monitoring regions"
+	depends on DAMON_RECLAIM
+	default 1000
+	help
+	  The maximum number of monitoring regions for DAMON-based reclaim.
+	  Can be used to set upper-bound of the monitoring overhead.  However,
+	  setting this too low could result in bad monitoring quality.  Please
+	  refer to the DAMON documentation for more detail.
+	  1000 by default.
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
index 000000000000..a95131038377
--- /dev/null
+++ b/mm/damon/reclaim.c
@@ -0,0 +1,230 @@
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
+#include <linux/workqueue.h>
+
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "damon_reclaim."
+
+#ifndef CONFIG_DAMON_RECLAIM_ENABLE
+static bool enabled __read_mostly;
+#else
+static bool enabled __read_mostly = CONFIG_DAMON_RECLAIM_ENABLE;
+#endif
+module_param(enabled, bool, 0600);
+
+static unsigned long min_age __read_mostly = CONFIG_DAMON_RECLAIM_MIN_AGE;
+module_param(min_age, ulong, 0600);
+
+static unsigned long limit_sz __read_mostly = CONFIG_DAMON_RECLAIM_LIMIT_SZ;
+module_param(limit_sz, ulong, 0600);
+
+static unsigned long limit_ms __read_mostly = CONFIG_DAMON_RECLAIM_LIMIT_MS;
+module_param(limit_ms, ulong, 0600);
+
+static unsigned long wmarks_interval __read_mostly =
+		CONFIG_DAMON_RECLAIM_WATERMARK_CHECK_INTERVAL;
+module_param(wmarks_interval, ulong, 0600);
+
+static unsigned long wmarks_high __read_mostly =
+		CONFIG_DAMON_RECLAIM_WATERMARK_HIGH;
+module_param(wmarks_high, ulong, 0600);
+
+static unsigned long wmarks_mid __read_mostly =
+		CONFIG_DAMON_RECLAIM_WATERMARK_MID;
+module_param(wmarks_mid, ulong, 0600);
+
+static unsigned long wmarks_low __read_mostly =
+		CONFIG_DAMON_RECLAIM_WATERMARK_LOW;
+module_param(wmarks_low, ulong, 0600);
+
+static unsigned long sample_interval __read_mostly =
+		CONFIG_DAMON_RECLAIM_SAMPLING_INTERVAL;
+module_param(sample_interval, ulong, 0600);
+
+static unsigned long aggr_interval __read_mostly =
+		CONFIG_DAMON_RECLAIM_AGGREGATION_INTERVAL;
+module_param(aggr_interval, ulong, 0600);
+
+static unsigned long min_nr_regions __read_mostly =
+		CONFIG_DAMON_RECLAIM_MIN_NR_REGIONS;
+module_param(min_nr_regions, ulong, 0600);
+
+static unsigned long max_nr_regions __read_mostly =
+		CONFIG_DAMON_RECLAIM_MAX_NR_REGIONS;
+module_param(max_nr_regions, ulong, 0600);
+
+static unsigned long monitor_region_start;
+module_param(monitor_region_start, ulong, 0400);
+
+static unsigned long monitor_region_end;
+module_param(monitor_region_end, ulong, 0400);
+
+static struct damon_ctx *ctx;
+static struct damon_target *target;
+
+struct damon_reclaim_ram_walk_arg {
+	unsigned long start;
+	unsigned long end;
+};
+
+int walk_system_ram(struct resource *res, void *arg)
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
+
+	if (arg.end > arg.start) {
+		*start = arg.start;
+		*end = arg.end;
+		return true;
+	}
+
+
+	return false;
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
+	struct damos_speed_limit limit = {
+		.sz = limit_sz,
+		.ms = limit_ms,
+		/* Within the limit, page out older regions first. */
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
+			&limit,
+			/* Activate this based on the watermarks. */
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
+	if (!on)
+		return damon_stop(&ctx, 1);
+
+	err = damon_set_attrs(ctx, READ_ONCE(sample_interval),
+			READ_ONCE(aggr_interval),
+			READ_ONCE(aggr_interval) * 100,
+			min_nr_regions, max_nr_regions);
+	if (err)
+		return err;
+
+	if (!get_monitoring_region(&monitor_region_start, &monitor_region_end))
+		return -EINVAL;
+	/* DAMON will free this on its own when finish monitoring */
+	region = damon_new_region(monitor_region_start, monitor_region_end);
+	if (!region)
+		return -ENOMEM;
+	damon_add_region(region, target);
+
+	/* Will be freed by later 'damon_set_schemes()' */
+	scheme = damon_reclaim_new_scheme();
+	if (!scheme)
+		goto free_region_out;
+	err = damon_set_schemes(ctx, &scheme, 1);
+	if (err)
+		goto free_scheme_out;
+
+	err = damon_start(&ctx, 1);
+	if (err)
+		goto free_scheme_out;
+	goto out;
+
+free_scheme_out:
+	damon_destroy_scheme(scheme);
+free_region_out:
+	damon_destroy_region(region);
+out:
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

