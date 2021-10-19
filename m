Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E7B4339BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhJSPKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232813AbhJSPKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:10:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED5F361212;
        Tue, 19 Oct 2021 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634656073;
        bh=3morts9r87ok3AUYF173aInD64hgHZ2XGd+lDVCD26Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPYqCdcXL76NSDFaj/nRgl+9Olo/rj9sHX2ibbVjktrYUKEfoK007+YSIhTFDvPTb
         xl2h9vTwmb7xMum1iW/Lkh4S6zLKuvyVOkiuwNU/Hiwc0ZZD49I9oGR5aNkmAMZngx
         lA4OBS7QnoqY8eM3Yi1nfN00YspP0F7mr75lxbe5xVe9j3DlIT3J+0cs9wjrH0RoJS
         Jarb7yqFBF5NGmmMFwJWFPhPWHh2FHotHnkqWNJPhVZX2CseZkDL0oHCotJp+zESd/
         BlqONh2y1y5i2BQojQpR80pyTNPyboO1qrv7jf1qQ1jJS8qWJyN+lxgc6lRvc9QWKI
         gr5r9AIM+ZLng==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] mm/damon/schemes: Implement size quota for schemes application speed control
Date:   Tue, 19 Oct 2021 15:07:18 +0000
Message-Id: <20211019150731.16699-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019150731.16699-1-sj@kernel.org>
References: <20211019150731.16699-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be arbitrarily large memory regions fulfilling the target
data access pattern of a DAMON-based operation scheme.  In the case,
applying the action of the scheme could incur too high overhead.  To
provide an intuitive way for avoiding it, this commit implements a
feature called size quota.  If the quota is set, DAMON tries to apply
the action only up to the given amount of memory regions within a given
time window.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 36 +++++++++++++++++++++++---
 mm/damon/core.c       | 60 +++++++++++++++++++++++++++++++++++++------
 mm/damon/dbgfs.c      |  4 ++-
 3 files changed, 87 insertions(+), 13 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 715dadd21f7c..af8c2ada2655 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -89,6 +89,26 @@ enum damos_action {
 	DAMOS_STAT,		/* Do nothing but only record the stat */
 };
 
+/**
+ * struct damos_quota - Controls the aggressiveness of the given scheme.
+ * @sz:			Maximum bytes of memory that the action can be applied.
+ * @reset_interval:	Charge reset interval in milliseconds.
+ *
+ * To avoid consuming too much CPU time or IO resources for applying the
+ * &struct damos->action to large memory, DAMON allows users to set a size
+ * quota.  The quota can be set by writing non-zero values to &sz.  If the size
+ * quota is set, DAMON tries to apply the action only up to &sz bytes within
+ * &reset_interval.
+ */
+struct damos_quota {
+	unsigned long sz;
+	unsigned long reset_interval;
+
+/* private: For charging the quota */
+	unsigned long charged_sz;
+	unsigned long charged_from;
+};
+
 /**
  * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
  * @min_sz_region:	Minimum size of target regions.
@@ -98,13 +118,20 @@ enum damos_action {
  * @min_age_region:	Minimum age of target regions.
  * @max_age_region:	Maximum age of target regions.
  * @action:		&damo_action to be applied to the target regions.
+ * @quota:		Control the aggressiveness of this scheme.
  * @stat_count:		Total number of regions that this scheme is applied.
  * @stat_sz:		Total size of regions that this scheme is applied.
  * @list:		List head for siblings.
  *
- * For each aggregation interval, DAMON applies @action to monitoring target
- * regions fit in the condition and updates the statistics.  Note that both
- * the minimums and the maximums are inclusive.
+ * For each aggregation interval, DAMON finds regions which fit in the
+ * condition (&min_sz_region, &max_sz_region, &min_nr_accesses,
+ * &max_nr_accesses, &min_age_region, &max_age_region) and applies &action to
+ * those.  To avoid consuming too much CPU time or IO resources for the
+ * &action, &quota is used.
+ *
+ * After applying the &action to each region, &stat_count and &stat_sz is
+ * updated to reflect the number of regions and total size of regions that the
+ * &action is applied.
  */
 struct damos {
 	unsigned long min_sz_region;
@@ -114,6 +141,7 @@ struct damos {
 	unsigned int min_age_region;
 	unsigned int max_age_region;
 	enum damos_action action;
+	struct damos_quota quota;
 	unsigned long stat_count;
 	unsigned long stat_sz;
 	struct list_head list;
@@ -310,7 +338,7 @@ struct damos *damon_new_scheme(
 		unsigned long min_sz_region, unsigned long max_sz_region,
 		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
 		unsigned int min_age_region, unsigned int max_age_region,
-		enum damos_action action);
+		enum damos_action action, struct damos_quota *quota);
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
 void damon_destroy_scheme(struct damos *s);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2f6785737902..cce14a0d5c72 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -89,7 +89,7 @@ struct damos *damon_new_scheme(
 		unsigned long min_sz_region, unsigned long max_sz_region,
 		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
 		unsigned int min_age_region, unsigned int max_age_region,
-		enum damos_action action)
+		enum damos_action action, struct damos_quota *quota)
 {
 	struct damos *scheme;
 
@@ -107,6 +107,11 @@ struct damos *damon_new_scheme(
 	scheme->stat_sz = 0;
 	INIT_LIST_HEAD(&scheme->list);
 
+	scheme->quota.sz = quota->sz;
+	scheme->quota.reset_interval = quota->reset_interval;
+	scheme->quota.charged_sz = 0;
+	scheme->quota.charged_from = 0;
+
 	return scheme;
 }
 
@@ -530,15 +535,25 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	}
 }
 
+static void damon_split_region_at(struct damon_ctx *ctx,
+		struct damon_target *t, struct damon_region *r,
+		unsigned long sz_r);
+
 static void damon_do_apply_schemes(struct damon_ctx *c,
 				   struct damon_target *t,
 				   struct damon_region *r)
 {
 	struct damos *s;
-	unsigned long sz;
 
 	damon_for_each_scheme(s, c) {
-		sz = r->ar.end - r->ar.start;
+		struct damos_quota *quota = &s->quota;
+		unsigned long sz = r->ar.end - r->ar.start;
+
+		/* Check the quota */
+		if (quota->sz && quota->charged_sz >= quota->sz)
+			continue;
+
+		/* Check the target regions condition */
 		if (sz < s->min_sz_region || s->max_sz_region < sz)
 			continue;
 		if (r->nr_accesses < s->min_nr_accesses ||
@@ -546,22 +561,51 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			continue;
 		if (r->age < s->min_age_region || s->max_age_region < r->age)
 			continue;
-		s->stat_count++;
-		s->stat_sz += sz;
-		if (c->primitive.apply_scheme)
+
+		/* Apply the scheme */
+		if (c->primitive.apply_scheme) {
+			if (quota->sz && quota->charged_sz + sz > quota->sz) {
+				sz = ALIGN_DOWN(quota->sz - quota->charged_sz,
+						DAMON_MIN_REGION);
+				if (!sz)
+					goto update_stat;
+				damon_split_region_at(c, t, r, sz);
+			}
 			c->primitive.apply_scheme(c, t, r, s);
+			quota->charged_sz += sz;
+		}
 		if (s->action != DAMOS_STAT)
 			r->age = 0;
+
+update_stat:
+		s->stat_count++;
+		s->stat_sz += sz;
 	}
 }
 
 static void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
-	struct damon_region *r;
+	struct damon_region *r, *next_r;
+	struct damos *s;
+
+	damon_for_each_scheme(s, c) {
+		struct damos_quota *quota = &s->quota;
+
+		if (!quota->sz)
+			continue;
+
+		/* New charge window starts */
+		if (time_after_eq(jiffies, quota->charged_from +
+					msecs_to_jiffies(
+						quota->reset_interval))) {
+			quota->charged_from = jiffies;
+			quota->charged_sz = 0;
+		}
+	}
 
 	damon_for_each_target(t, c) {
-		damon_for_each_region(r, t)
+		damon_for_each_region_safe(r, next_r, t)
 			damon_do_apply_schemes(c, t, r);
 	}
 }
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index c90988a20fa4..a04bd50cc4c4 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -188,6 +188,8 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 
 	*nr_schemes = 0;
 	while (pos < len && *nr_schemes < max_nr_schemes) {
+		struct damos_quota quota = {};
+
 		ret = sscanf(&str[pos], "%lu %lu %u %u %u %u %u%n",
 				&min_sz, &max_sz, &min_nr_a, &max_nr_a,
 				&min_age, &max_age, &action, &parsed);
@@ -200,7 +202,7 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 
 		pos += parsed;
 		scheme = damon_new_scheme(min_sz, max_sz, min_nr_a, max_nr_a,
-				min_age, max_age, action);
+				min_age, max_age, action, &quota);
 		if (!scheme)
 			goto fail;
 
-- 
2.17.1

