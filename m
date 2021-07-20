Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F6C3CFA7D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbhGTMnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbhGTMdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:33:46 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD743C0613E5;
        Tue, 20 Jul 2021 06:14:20 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id gh6so10053817qvb.3;
        Tue, 20 Jul 2021 06:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TVJbfwQeVmP57kGKh2Jm/+lhdbG5Ku1DhtHyjROhhmk=;
        b=Pdiy77ZG9jJof1KC+UVNQqgI+mCfBeV/zyt+MEZ6GvEw4D1OMt3LiHFKQG/dRZxhEY
         2FOyN52bTyGVzs2j7EBUgHEvXVtSJa83SguNvDda9E7cNxQSx+IBgw8IuuRsMxChKQtU
         +f6BizUuFlZ0o58BOWSrj823OvO0E+ZzbGWkf5pkNbkOTBVWXEQfLD/R2/mhjU6inAkv
         UVyjLAQKVlDRxpCqX2zhbmEyGFrw4GK+jUPowzUNDVHaKUR2ij34er2rb3vOMdoYvD0o
         RRG4P8d35s2f7y4OEE29kpsBp7S6Zfn0ioqmBaZacWS9D0Axg9TfVWeCQPYHgipjebzt
         Ha4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TVJbfwQeVmP57kGKh2Jm/+lhdbG5Ku1DhtHyjROhhmk=;
        b=JB6z34CUd9IxLtEKbDBli3trwPpCmVf6sZH/HQz5PZ/qcjtvdBxO4CMt5Z4Zh6WmP5
         yQDWTXIfeXVjiqcIPtAKFmzFroiEeKXGhZj+6Gtwj5Sb8mZFqLb48/C0mC9yhLaB/FXi
         y9O4duc3rIpLOHu73keDNsUXMPusoQDjKp9f8MmVkw5Ar9YUyurYTemqbvQDnFy/9yfh
         XyHY0L9IrkHDJn6Uhc/1BhdDuND6haxlJMms1wY1Db4jzeE1QqWWKuFo3dlwlFoEFcp0
         jSg41+QM8sY6IXc3EwdekaBrY7JsAf/sK/5TGMJJvSTDi7BNJHf9W8sWM6whzFnBdjNT
         5E+w==
X-Gm-Message-State: AOAM531fH6tWLXCrC9L+tXkFsBlxjCP4k/J8mNGmfCK1IY26q/vgGU2O
        2O208XQK1sojlWujZoH8GZA=
X-Google-Smtp-Source: ABdhPJyfpwlUWDGamTt4dKokvdEMonQWcrKIGMjq/B9Ap4tCF0T60jVU78KSzRZtI+M+A6bAzsg1/w==
X-Received: by 2002:a05:6214:184b:: with SMTP id d11mr30172069qvy.5.1626786859968;
        Tue, 20 Jul 2021 06:14:19 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g17sm9701225qkm.34.2021.07.20.06.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:14:19 -0700 (PDT)
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
Subject: [RFC v3 07/15] mm/damon/schemes: Prioritize regions within the quotas
Date:   Tue, 20 Jul 2021 13:13:01 +0000
Message-Id: <20210720131309.22073-8-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720131309.22073-1-sj38.park@gmail.com>
References: <20210720131309.22073-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit makes DAMON to apply schemes to regions having higher
priority first, if it cannot apply schemes to all regions due to the
quotas.

The prioritization function should be implemented in each monitoring
primitive.  Those would commonly calculate the priority of the region
using attributes of regions, namely 'size', 'nr_accesses', and 'age'.
For example, some primitive would calculate the priority of each region
using a weighted sum of 'nr_accesses' and 'age' of the region.

The optimal weights would depend on give environments, so this commit
allows it to be customizable.  Nevertheless, the score calculation
functions are only encouraged to respect the weights, not mandated.  So,
the customization might not work for some primitives.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h | 26 ++++++++++++++++++
 mm/damon/core.c       | 62 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d2dd36b9dd6c..ddea4b4f3bfa 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -14,6 +14,8 @@
 
 /* Minimal region size.  Every damon_region is aligned by this. */
 #define DAMON_MIN_REGION	PAGE_SIZE
+/* Max priority score for DAMON-based operation schemes */
+#define DAMOS_MAX_SCORE		(99)
 
 /**
  * struct damon_addr_range - Represents an address region of [@start, @end).
@@ -95,6 +97,10 @@ enum damos_action {
  * @sz:			Maximum bytes of memory that the action can be applied.
  * @reset_interval:	Charge reset interval in milliseconds.
  *
+ * @weight_sz:		Weight of the region's size for prioritization.
+ * @weight_nr_accesses:	Weight of the region's nr_accesses for prioritization.
+ * @weight_age:		Weight of the region's age for prioritization.
+ *
  * To avoid consuming too much CPU time or IO resources for applying the
  * &struct damos->action to large memory, DAMON allows users to set time and/or
  * size quotas.  The quotas can be set by writing non-zero values to &ms and
@@ -106,12 +112,22 @@ enum damos_action {
  * Internally, the time quota is transformed to a size quota using estimated
  * throughput of the scheme's action.  DAMON then compares it against &sz and
  * uses smaller one as the effective quota.
+ *
+ * For selecting regions within the quota, DAMON prioritizes current scheme's
+ * target memory regions using the &struct damon_primitive->get_scheme_score.
+ * You could customize the prioritization logic by setting &weight_sz,
+ * &weight_nr_accesses, and &weight_age, because monitoring primitives are
+ * encouraged to respect those.
  */
 struct damos_quota {
 	unsigned long ms;
 	unsigned long sz;
 	unsigned long reset_interval;
 
+	unsigned int weight_sz;
+	unsigned int weight_nr_accesses;
+	unsigned int weight_age;
+
 /* private: */
 	/* For throughput estimation */
 	unsigned long total_charged_sz;
@@ -124,6 +140,10 @@ struct damos_quota {
 	unsigned long charged_from;
 	struct damon_target *charge_target_from;
 	unsigned long charge_addr_from;
+
+	/* For prioritization */
+	unsigned long histogram[DAMOS_MAX_SCORE + 1];
+	unsigned int min_score;
 };
 
 /**
@@ -174,6 +194,7 @@ struct damon_ctx;
  * @prepare_access_checks:	Prepare next access check of target regions.
  * @check_accesses:		Check the accesses to target regions.
  * @reset_aggregated:		Reset aggregated accesses monitoring results.
+ * @get_scheme_score:		Get the score of a region for a scheme.
  * @apply_scheme:		Apply a DAMON-based operation scheme.
  * @target_valid:		Determine if the target is valid.
  * @cleanup:			Clean up the context.
@@ -201,6 +222,8 @@ struct damon_ctx;
  * of its update.  The value will be used for regions adjustment threshold.
  * @reset_aggregated should reset the access monitoring results that aggregated
  * by @check_accesses.
+ * @get_scheme_score should return the priority score of a region for a scheme
+ * as an integer in [0, &DAMOS_MAX_SCORE].
  * @apply_scheme is called from @kdamond when a region for user provided
  * DAMON-based operation scheme is found.  It should apply the scheme's action
  * to the region.  This is not used for &DAMON_ARBITRARY_TARGET case.
@@ -215,6 +238,9 @@ struct damon_primitive {
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
 	void (*reset_aggregated)(struct damon_ctx *context);
+	int (*get_scheme_score)(struct damon_ctx *context,
+			struct damon_target *t, struct damon_region *r,
+			struct damos *scheme);
 	int (*apply_scheme)(struct damon_ctx *context, struct damon_target *t,
 			struct damon_region *r, struct damos *scheme);
 	bool (*target_valid)(void *target);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 321523604ef6..4e8b44fe02a0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -12,6 +12,7 @@
 #include <linux/kthread.h>
 #include <linux/random.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/damon.h>
@@ -110,6 +111,9 @@ struct damos *damon_new_scheme(
 	scheme->quota.ms = quota->ms;
 	scheme->quota.sz = quota->sz;
 	scheme->quota.reset_interval = quota->reset_interval;
+	scheme->quota.weight_sz = quota->weight_sz;
+	scheme->quota.weight_nr_accesses = quota->weight_nr_accesses;
+	scheme->quota.weight_age = quota->weight_age;
 	scheme->quota.total_charged_sz = 0;
 	scheme->quota.total_charged_ns = 0;
 	scheme->quota.esz = 0;
@@ -550,6 +554,28 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		unsigned long sz_r);
 
+static bool __damos_valid_target(struct damon_region *r, struct damos *s)
+{
+	unsigned long sz;
+
+	sz = r->ar.end - r->ar.start;
+	return s->min_sz_region <= sz && sz <= s->max_sz_region &&
+		s->min_nr_accesses <= r->nr_accesses &&
+		r->nr_accesses <= s->max_nr_accesses &&
+		s->min_age_region <= r->age && r->age <= s->max_age_region;
+}
+
+static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
+		struct damon_region *r, struct damos *s)
+{
+	bool ret = __damos_valid_target(r, s);
+
+	if (!ret || !s->quota.esz || !c->primitive.get_scheme_score)
+		return ret;
+
+	return c->primitive.get_scheme_score(c, t, r, s) >= s->quota.min_score;
+}
+
 static void damon_do_apply_schemes(struct damon_ctx *c,
 				   struct damon_target *t,
 				   struct damon_region *r)
@@ -596,13 +622,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			quota->charge_addr_from = 0;
 		}
 
-		/* Check the target regions condition */
-		if (sz < s->min_sz_region || s->max_sz_region < sz)
-			continue;
-		if (r->nr_accesses < s->min_nr_accesses ||
-				s->max_nr_accesses < r->nr_accesses)
-			continue;
-		if (r->age < s->min_age_region || s->max_age_region < r->age)
+		if (!damos_valid_target(c, t, r, s))
 			continue;
 
 		/* Apply the scheme */
@@ -666,6 +686,8 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 
 	damon_for_each_scheme(s, c) {
 		struct damos_quota *quota = &s->quota;
+		unsigned long cumulated_sz;
+		unsigned int score, max_score = 0;
 
 		if (!quota->ms && !quota->sz)
 			continue;
@@ -679,6 +701,32 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 			quota->charged_sz = 0;
 			damos_set_effective_quota(quota);
 		}
+
+		if (!c->primitive.get_scheme_score)
+			continue;
+
+		/* Fill up the score histogram */
+		memset(quota->histogram, 0, sizeof(quota->histogram));
+		damon_for_each_target(t, c) {
+			damon_for_each_region(r, t) {
+				if (!__damos_valid_target(r, s))
+					continue;
+				score = c->primitive.get_scheme_score(
+						c, t, r, s);
+				quota->histogram[score] +=
+					r->ar.end - r->ar.start;
+				if (score > max_score)
+					max_score = score;
+			}
+		}
+
+		/* Set the min score limit */
+		for (cumulated_sz = 0, score = max_score; ; score--) {
+			cumulated_sz += quota->histogram[score];
+			if (cumulated_sz >= quota->esz || !score)
+				break;
+		}
+		quota->min_score = score;
 	}
 
 	damon_for_each_target(t, c) {
-- 
2.17.1

