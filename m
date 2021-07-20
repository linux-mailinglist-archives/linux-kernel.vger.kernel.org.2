Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB023CFA77
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbhGTMkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbhGTMd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:33:59 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F86C061762;
        Tue, 20 Jul 2021 06:14:35 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id z25so15256914qto.12;
        Tue, 20 Jul 2021 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OTGTiZSl1O9O/Ean2SQx4cmBjaBEQg8/xZ0NCYTf44g=;
        b=W6C3k5x7UsbXKLJL0gC9dn0dduAtptG/v5QsLa6igKgcGs+Ed1SqHlNgnOToXPz77Z
         Uu8GIIQkz6wQLQxP3bf6YiMGXCrRcDKh4kI5We0HerXTutv88/xgHdTt2V/AghOz3We0
         bAAVBMO1+7NAIKAUwYJMkspP7ynShOlXx4Wm/18lXELx1ffUy0mUMPOWymP8Qu7VE+ZU
         e3jIMhLYBlkL5IGJacJrYbYDnqky/nF1Bx45DyFWCaDDIDd0AFLLh55KRZwiUcW8ytCM
         IoBkf9UenhQabTyFQpnkhTo8P4v07TdEyoDWDxNxLVfnCJS4UWL6va5LCSooJ0QEBbLj
         mM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OTGTiZSl1O9O/Ean2SQx4cmBjaBEQg8/xZ0NCYTf44g=;
        b=bXERaQ2IodjzRg0EjzorKT9EXykfGcSXYyOcWXXbz1zTtgVEuOBrBlCEBf/1rW0iRK
         TUb5eASKX89RDOfPvm80Hidvn242RrHiuFLcb2tzVcwJT6ia4Bu2KTj6hR19b+Q2SP2l
         yoSTgu/ANmNZAQj9YeJ/HpE/vp83t1d1tfucKMn+lJalBi4Wc0lBJ7EtSbskNiR4mWhf
         1AIEM1VVCKLLDKo27yaw7INMBOEMEzMd0lR2HD6wvOk46BOBMHt/r1fpKFp8qq+V1YV0
         vspyr2Vhet8aCePRKc25n6VFP9eDOyyr5oIiVOVeenfb3bGXxrLzDIAMbAkt/gM3+l17
         4jQw==
X-Gm-Message-State: AOAM53138xg9TR3S6rt03zDYyu6L3FOgYfH7fSJHol3qlWUUYdM/dZ6A
        XWb5SrCaR7yW/99hWDKhItE=
X-Google-Smtp-Source: ABdhPJwNcM1/z0EWqSKPmg8xNFXtFIOUqz7YJp0kh1NgNTE3y+RF1LpBKAJP+S3huxPL5H1oYCle4g==
X-Received: by 2002:a05:622a:310:: with SMTP id q16mr26438668qtw.168.1626786874645;
        Tue, 20 Jul 2021 06:14:34 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g17sm9701225qkm.34.2021.07.20.06.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:14:34 -0700 (PDT)
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
Subject: [RFC v3 11/15] mm/damon/schemes: Activate schemes based on a watermarks mechanism
Date:   Tue, 20 Jul 2021 13:13:05 +0000
Message-Id: <20210720131309.22073-12-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720131309.22073-1-sj38.park@gmail.com>
References: <20210720131309.22073-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON-based operation schemes need to be manually turned on and off.  In
some use cases, however, the condition for turning a scheme on and off
would depend on the system's situation.  For example, schemes for
proactive pages reclamation would need to be turned on when some memory
pressure is detected, and turned off when the system has enough free
memory.

For easier control of schemes activation based on the system situation,
this commit introduces a watermarks-based mechanism.  The client can
describe the watermark metric (e.g., amount of free memory in the
system), watermark check interval, and three watermarks, namely high,
mid, and low.  If the scheme is deactivated, it only gets the metric and
compare that to the three watermarks for every check interval.  If the
metric is higher than the high watermark, the scheme is deactivated.  If
the metric is between the mid watermark and the low watermark, the
scheme is activated.  If the metric is lower than the low watermark, the
scheme is deactivated again.  This is to allow users fall back to
traditional page-granularity mechanisms.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h | 52 ++++++++++++++++++++++-
 mm/damon/core.c       | 97 ++++++++++++++++++++++++++++++++++++++++++-
 mm/damon/dbgfs.c      |  5 ++-
 3 files changed, 151 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f56f04b63b1c..b33a5ee94f62 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -146,6 +146,45 @@ struct damos_quota {
 	unsigned int min_score;
 };
 
+/**
+ * enum damos_wmark_metric - Represents the watermark metric.
+ *
+ * @DAMOS_WMARK_NONE:		Ignore the watermarks of the given scheme.
+ * @DAMOS_WMARK_FREE_MEM_RATE:	Free memory rate of the system in [0,1000].
+ */
+enum damos_wmark_metric {
+	DAMOS_WMARK_NONE,
+	DAMOS_WMARK_FREE_MEM_RATE,
+};
+
+/**
+ * struct damos_watermarks - Controls when a given scheme should be activated.
+ * @metric:	Metric for the watermarks.
+ * @interval:	Watermarks check time interval in microseconds.
+ * @high:	High watermark.
+ * @mid:	Middle watermark.
+ * @low:	Low watermark.
+ *
+ * If &metric is &DAMOS_WMARK_NONE, the scheme is always active.  Being active
+ * means DAMON does monitoring and applying the action of the scheme to
+ * appropriate memory regions.  Else, DAMON checks &metric of the system for at
+ * least every &interval microseconds and works as below.
+ *
+ * If &metric is higher than &high, the scheme is inactivated.  If &metric is
+ * between &mid and &low, the scheme is activated.  If &metric is lower than
+ * &low, the scheme is inactivated.
+ */
+struct damos_watermarks {
+	enum damos_wmark_metric metric;
+	unsigned long interval;
+	unsigned long high;
+	unsigned long mid;
+	unsigned long low;
+
+/* private: */
+	bool activated;
+};
+
 /**
  * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
  * @min_sz_region:	Minimum size of target regions.
@@ -156,6 +195,7 @@ struct damos_quota {
  * @max_age_region:	Maximum age of target regions.
  * @action:		&damo_action to be applied to the target regions.
  * @quota:		Control the aggressiveness of this scheme.
+ * @wmarks:		Watermarks for automated (in)activation of this scheme.
  * @stat_count:		Total number of regions that this scheme is applied.
  * @stat_sz:		Total size of regions that this scheme is applied.
  * @list:		List head for siblings.
@@ -166,6 +206,14 @@ struct damos_quota {
  * those.  To avoid consuming too much CPU time or IO resources for the
  * &action, &quota is used.
  *
+ * To do the work only when needed, schemes can be activated for specific
+ * system situations using &wmarks.  If all schemes that registered to the
+ * monitoring context are inactive, DAMON stops monitoring either, and just
+ * repeatedly checks the watermarks.
+ *
+ * If all schemes that registered to a &struct damon_ctx are inactive, DAMON
+ * stops monitoring and just repeatedly checks the watermarks.
+ *
  * After applying the &action to each region, &stat_count and &stat_sz is
  * updated to reflect the number of regions and total size of regions that the
  * &action is applied.
@@ -179,6 +227,7 @@ struct damos {
 	unsigned int max_age_region;
 	enum damos_action action;
 	struct damos_quota quota;
+	struct damos_watermarks wmarks;
 	unsigned long stat_count;
 	unsigned long stat_sz;
 	struct list_head list;
@@ -412,7 +461,8 @@ struct damos *damon_new_scheme(
 		unsigned long min_sz_region, unsigned long max_sz_region,
 		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
 		unsigned int min_age_region, unsigned int max_age_region,
-		enum damos_action action, struct damos_quota *quota);
+		enum damos_action action, struct damos_quota *quota,
+		struct damos_watermarks *wmarks);
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
 void damon_destroy_scheme(struct damos *s);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4e8b44fe02a0..5b578f65c109 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -10,6 +10,7 @@
 #include <linux/damon.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/mm.h>
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -90,7 +91,8 @@ struct damos *damon_new_scheme(
 		unsigned long min_sz_region, unsigned long max_sz_region,
 		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
 		unsigned int min_age_region, unsigned int max_age_region,
-		enum damos_action action, struct damos_quota *quota)
+		enum damos_action action, struct damos_quota *quota,
+		struct damos_watermarks *wmarks)
 {
 	struct damos *scheme;
 
@@ -122,6 +124,13 @@ struct damos *damon_new_scheme(
 	scheme->quota.charge_target_from = NULL;
 	scheme->quota.charge_addr_from = 0;
 
+	scheme->wmarks.metric = wmarks->metric;
+	scheme->wmarks.interval = wmarks->interval;
+	scheme->wmarks.high = wmarks->high;
+	scheme->wmarks.mid = wmarks->mid;
+	scheme->wmarks.low = wmarks->low;
+	scheme->wmarks.activated = true;
+
 	return scheme;
 }
 
@@ -587,6 +596,9 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		unsigned long sz = r->ar.end - r->ar.start;
 		struct timespec64 begin, end;
 
+		if (!s->wmarks.activated)
+			continue;
+
 		/* Check the quota */
 		if (quota->esz && quota->charged_sz >= quota->esz)
 			continue;
@@ -689,6 +701,9 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		unsigned long cumulated_sz;
 		unsigned int score, max_score = 0;
 
+		if (!s->wmarks.activated)
+			continue;
+
 		if (!quota->ms && !quota->sz)
 			continue;
 
@@ -932,6 +947,83 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 	return true;
 }
 
+static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
+{
+	struct sysinfo i;
+
+	switch (metric) {
+	case DAMOS_WMARK_FREE_MEM_RATE:
+		si_meminfo(&i);
+		return i.freeram * 1000 / i.totalram;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+/*
+ * Returns zero if the scheme is active.  Else, returns time to wait for next
+ * watermark check in micro-seconds.
+ */
+static unsigned long damos_wmark_wait_us(struct damos *scheme)
+{
+	unsigned long metric;
+
+	if (scheme->wmarks.metric == DAMOS_WMARK_NONE)
+		return 0;
+
+	metric = damos_wmark_metric_value(scheme->wmarks.metric);
+	/* higher than high watermark or lower than low watermark */
+	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
+		if (scheme->wmarks.activated)
+			pr_info("inactivate a scheme (%d) for %s wmark\n",
+					scheme->action,
+					metric > scheme->wmarks.high ?
+					"high" : "low");
+		scheme->wmarks.activated = false;
+		return scheme->wmarks.interval;
+	}
+
+	/* inactive and higher than middle watermark */
+	if ((scheme->wmarks.high >= metric && metric >= scheme->wmarks.mid) &&
+			!scheme->wmarks.activated)
+		return scheme->wmarks.interval;
+
+	if (!scheme->wmarks.activated)
+		pr_info("activate a scheme (%d)\n", scheme->action);
+	scheme->wmarks.activated = true;
+	return 0;
+}
+
+static void kdamond_usleep(unsigned long usecs)
+{
+	if (usecs > 100 * 1000)
+		schedule_timeout_interruptible(usecs_to_jiffies(usecs));
+	else
+		usleep_range(usecs, usecs + 1);
+}
+
+/* Returns negative error code if it's not activated but should return */
+static int kdamond_wait_activation(struct damon_ctx *ctx)
+{
+	struct damos *s;
+	unsigned long wait_time;
+	unsigned long min_wait_time = 0;
+
+	while (!kdamond_need_stop(ctx)) {
+		damon_for_each_scheme(s, ctx) {
+			wait_time = damos_wmark_wait_us(s);
+			if (!min_wait_time || wait_time < min_wait_time)
+				min_wait_time = wait_time;
+		}
+		if (!min_wait_time)
+			return 0;
+
+		kdamond_usleep(min_wait_time);
+	}
+	return -EBUSY;
+}
+
 static void set_kdamond_stop(struct damon_ctx *ctx)
 {
 	mutex_lock(&ctx->kdamond_lock);
@@ -962,6 +1054,9 @@ static int kdamond_fn(void *data)
 	sz_limit = damon_region_sz_limit(ctx);
 
 	while (!kdamond_need_stop(ctx)) {
+		if (kdamond_wait_activation(ctx))
+			continue;
+
 		if (ctx->primitive.prepare_access_checks)
 			ctx->primitive.prepare_access_checks(ctx);
 		if (ctx->callback.after_sampling &&
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 93ac15cb5786..2509c0b634b4 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -317,6 +317,9 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 	*nr_schemes = 0;
 	while (pos < len && *nr_schemes < max_nr_schemes) {
 		struct damos_quota quota = {};
+		struct damos_watermarks wmarks = {
+			.metric = DAMOS_WMARK_NONE,
+		};
 
 		ret = sscanf(&str[pos],
 				"%lu %lu %u %u %u %u %u %lu %lu %lu %u %u %u%n",
@@ -334,7 +337,7 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 
 		pos += parsed;
 		scheme = damon_new_scheme(min_sz, max_sz, min_nr_a, max_nr_a,
-				min_age, max_age, action, &quota);
+				min_age, max_age, action, &quota, &wmarks);
 		if (!scheme)
 			goto fail;
 
-- 
2.17.1

