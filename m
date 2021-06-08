Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E6C39F5C2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhFHL4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:56:49 -0400
Received: from mail-qv1-f50.google.com ([209.85.219.50]:37381 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhFHL4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:56:43 -0400
Received: by mail-qv1-f50.google.com with SMTP id x6so5669281qvx.4;
        Tue, 08 Jun 2021 04:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WVonKJ4i5Mlrmmds3qLXuhbIENuPVaS0OBd/5Gs8AtA=;
        b=EtGtB2ASZxNFwo6uJCfR+SVHMMDFBUSjSDeogPB22aA4Hn1nTbYYcpyFg/2p1w6ERB
         itebYa0De9syGtSRM39U6UwNhoDo3arFpRqKYM5Z+360VypubR7yRR+DFBJgLdJT7BDW
         zpFpjPGclqC+p2OhduAYWQUepFjscecAXBkci76RR0XbRQRZ0d+FBNGaEd2tU7xciDCn
         qDBjHg+n1ksx2pKk85yTqcaACDgkwqO0wc/zyEjEYwgC1eQDu/k4cB5DUZ9KtdHpR2bt
         b0Z4DjXWopNfYuIK+/FDX13bhk3uuLj5USuUKzsFEPNgonXQvRndrGbiPG2a1PLgva8v
         i9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WVonKJ4i5Mlrmmds3qLXuhbIENuPVaS0OBd/5Gs8AtA=;
        b=eq02PmkxqNqVoYRIkub/4nj36nRim5R4m9emFrEg+7r6HV6UKMr6SvLTilBVaRi/0x
         vyCgozoLQakgVFnkgalwGOQXILqGNjcB/FuDEkTLRqcJf1MimA6vl1y2YOZ3vT1VnoEX
         NqP3NLj7KvEwNKH2/yKQ0pW+NHCoHaJZy+9sDopwcmfSjdM+pLJDS35qKkZo9l3wsTi2
         p7mIAI9dcDnT+pEdqi88vwCI4e8CFRnc97Mgn1xFi5T2DuT7Vgv69tK24SzGXHo+c3WO
         5fcvmNdWqiijfXt8wN77uAYj9AqLHiji5FCaWR5BQJJewse+wS/Ikc4W6/70eAptdP1r
         qHow==
X-Gm-Message-State: AOAM533HAbn/9nvVA6UEPl5jN85qf8ZLav5ZwEMwNuf4w8Pux6KWryoN
        Zio/mZxDEcQ/EmtarMH+JW8=
X-Google-Smtp-Source: ABdhPJxVwq/GfwJZCOSdbHXBj13HB+PhiYpZM43LqrxUExQowmLT9j5y33BSt64hZjEkLnDZHo/+PQ==
X-Received: by 2002:ad4:4084:: with SMTP id l4mr18117248qvp.37.1623153213794;
        Tue, 08 Jun 2021 04:53:33 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h4sm2133927qth.66.2021.06.08.04.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:53:33 -0700 (PDT)
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
Subject: [RFC v2 10/14] mm/damon/schemes: Activate schemes based on a watermarks mechanism
Date:   Tue,  8 Jun 2021 11:52:50 +0000
Message-Id: <20210608115254.11930-11-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608115254.11930-1-sj38.park@gmail.com>
References: <20210608115254.11930-1-sj38.park@gmail.com>
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
 mm/damon/core.c       | 98 ++++++++++++++++++++++++++++++++++++++++++-
 mm/damon/dbgfs.c      |  5 ++-
 3 files changed, 152 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 565f49d8ba44..2edd84e98056 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -127,6 +127,45 @@ struct damos_speed_limit {
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
@@ -137,6 +176,7 @@ struct damos_speed_limit {
  * @max_age_region:	Maximum age of target regions.
  * @action:		&damo_action to be applied to the target regions.
  * @limit:		Control the aggressiveness of this scheme.
+ * @wmarks:		Watermarks for automated (in)activation of this scheme.
  * @stat_count:		Total number of regions that this scheme is applied.
  * @stat_sz:		Total size of regions that this scheme is applied.
  * @list:		List head for siblings.
@@ -146,6 +186,14 @@ struct damos_speed_limit {
  * &max_nr_accesses, &min_age_region, &max_age_region) and applies &action to
  * those.  To avoid consuming too much CPU for the &action, &limit is used.
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
@@ -159,6 +207,7 @@ struct damos {
 	unsigned int max_age_region;
 	enum damos_action action;
 	struct damos_speed_limit limit;
+	struct damos_watermarks wmarks;
 	unsigned long stat_count;
 	unsigned long stat_sz;
 	struct list_head list;
@@ -391,7 +440,8 @@ struct damos *damon_new_scheme(
 		unsigned long min_sz_region, unsigned long max_sz_region,
 		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
 		unsigned int min_age_region, unsigned int max_age_region,
-		enum damos_action action, struct damos_speed_limit *limit);
+		enum damos_action action, struct damos_speed_limit *limit,
+		struct damos_watermarks *wmarks);
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
 void damon_destroy_scheme(struct damos *s);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 15bcd05670d1..a754dd1f539d 100644
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
@@ -86,7 +87,8 @@ struct damos *damon_new_scheme(
 		unsigned long min_sz_region, unsigned long max_sz_region,
 		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
 		unsigned int min_age_region, unsigned int max_age_region,
-		enum damos_action action, struct damos_speed_limit *limit)
+		enum damos_action action, struct damos_speed_limit *limit,
+		struct damos_watermarks *wmarks)
 {
 	struct damos *scheme;
 
@@ -113,6 +115,14 @@ struct damos *damon_new_scheme(
 	scheme->limit.charged_from = 0;
 	scheme->limit.charge_target_from = NULL;
 	scheme->limit.charge_addr_from = 0;
+
+	scheme->wmarks.metric = wmarks->metric;
+	scheme->wmarks.interval = wmarks->interval;
+	scheme->wmarks.high = wmarks->high;
+	scheme->wmarks.mid = wmarks->mid;
+	scheme->wmarks.low = wmarks->low;
+	scheme->wmarks.activated = true;
+
 	return scheme;
 }
 
@@ -581,6 +591,9 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 	damon_for_each_scheme(s, c) {
 		struct damos_speed_limit *limit = &s->limit;
 
+		if (!s->wmarks.activated)
+			continue;
+
 		/* Check the limit */
 		if (limit->sz && limit->charged_sz >= limit->sz)
 			continue;
@@ -637,6 +650,9 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		unsigned long cumulated_sz;
 		unsigned int score, max_score = 0;
 
+		if (!s->wmarks.activated)
+			continue;
+
 		if (!limit->sz)
 			continue;
 
@@ -876,6 +892,83 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
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
@@ -904,6 +997,9 @@ static int kdamond_fn(void *data)
 	sz_limit = damon_region_sz_limit(ctx);
 
 	while (!kdamond_need_stop(ctx)) {
+		if (kdamond_wait_activation(ctx))
+			continue;
+
 		if (ctx->primitive.prepare_access_checks)
 			ctx->primitive.prepare_access_checks(ctx);
 		if (ctx->callback.after_sampling &&
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index b90287b1e576..1680fb1be8e1 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -315,6 +315,9 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 	*nr_schemes = 0;
 	while (pos < len && *nr_schemes < max_nr_schemes) {
 		struct damos_speed_limit limit = {};
+		struct damos_watermarks wmarks = {
+			.metric = DAMOS_WMARK_NONE,
+		};
 
 		ret = sscanf(&str[pos],
 				"%lu %lu %u %u %u %u %u %lu %lu %u %u %u%n",
@@ -332,7 +335,7 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 
 		pos += parsed;
 		scheme = damon_new_scheme(min_sz, max_sz, min_nr_a, max_nr_a,
-				min_age, max_age, action, &limit);
+				min_age, max_age, action, &limit, &wmarks);
 		if (!scheme)
 			goto fail;
 
-- 
2.17.1

