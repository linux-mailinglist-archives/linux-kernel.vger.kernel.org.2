Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897C94339C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhJSPKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233717AbhJSPKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:10:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89B2B61360;
        Tue, 19 Oct 2021 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634656082;
        bh=kZndi607CH3nUEl45FMdeTTlp4/UorvIx4U9McUBa4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ax2M7pBeW2o4A08yRq27DhS5tFJfrYO7rm0hNr+typ5EyBJTGfK+TA7EER5YK70og
         KD5m+WCpJumnEMP3vg8Ioqim1Q8MqqNofvh7/oxX8WGHq/PWlEvLqpBJA6MP88JaUb
         o+Hvj+KijH9mHxLijQcZQJLQecifWbLay17vNtVuMy0WspM8UjLEt5vvxHGVoM45Rp
         nX0gfhG5olwDVN9vD/tRe8CERPbS64k+hwJEYRNroD91UIQHwWMVffwlZugQBi+Bmz
         6XS86fZP6J97TUEsXjmuJmMDxOFCp1FUImnsol/IL8IbO8T1/+jzpBgOsZxXpBcLAc
         v0mcOfCRZE/0w==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] mm/damon/schemes: Prioritize regions within the quotas
Date:   Tue, 19 Oct 2021 15:07:23 +0000
Message-Id: <20211019150731.16699-8-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019150731.16699-1-sj@kernel.org>
References: <20211019150731.16699-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes DAMON apply schemes to regions having higher priority
first, if it cannot apply schemes to all regions due to the quotas.

The prioritization function should be implemented in the monitoring
primitives.  Those would commonly calculate the priority of the region
using attributes of regions, namely 'size', 'nr_accesses', and 'age'.
For example, some primitive would calculate the priority of each region
using a weighted sum of 'nr_accesses' and 'age' of the region.

The optimal weights would depend on give environments, so this commit
makes those customizable.  Nevertheless, the score calculation functions
are only encouraged to respect the weights, not mandated.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 26 ++++++++++++++++++
 mm/damon/core.c       | 62 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5347f940818e..999918a07444 100644
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
@@ -200,6 +221,8 @@ struct damon_ctx;
  * of its update.  The value will be used for regions adjustment threshold.
  * @reset_aggregated should reset the access monitoring results that aggregated
  * by @check_accesses.
+ * @get_scheme_score should return the priority score of a region for a scheme
+ * as an integer in [0, &DAMOS_MAX_SCORE].
  * @apply_scheme is called from @kdamond when a region for user provided
  * DAMON-based operation scheme is found.  It should apply the scheme's action
  * to the region.  This is not used for &DAMON_ARBITRARY_TARGET case.
@@ -213,6 +236,9 @@ struct damon_primitive {
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
index d1da4bef96ed..fad25778e2ec 100644
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
@@ -545,6 +549,28 @@ static void damon_split_region_at(struct damon_ctx *ctx,
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
@@ -591,13 +617,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
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
@@ -661,6 +681,8 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 
 	damon_for_each_scheme(s, c) {
 		struct damos_quota *quota = &s->quota;
+		unsigned long cumulated_sz;
+		unsigned int score, max_score = 0;
 
 		if (!quota->ms && !quota->sz)
 			continue;
@@ -674,6 +696,32 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
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

