Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F3D4339BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhJSPKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232813AbhJSPKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:10:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66CB96115A;
        Tue, 19 Oct 2021 15:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634656076;
        bh=ByvqifPgFEto66JEiyYk2/53Jz/4J13sSehCABtE1uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UhCDr6dvWjujod3djUv2+1FJoj9agErgOnoiP5UL150vNbA4mzARrg1vaZQp9h3CQ
         WUHGzMuDmOGfvbhLLdKEiQfjDXLjHgnHKSva6iKHIAqdoBxPVY3Y9ZRFxTHhVTAc9J
         cevNP99ZD1RIZ0lEB69xjN794YEZo8pLfR7bmndCF9lnHKMQtIQ1u8K5Ol5Ao5BFmT
         9e9dv82BUt6dB1SXqL2dkgM5NLL7J4RnvhIc3HB03utxCLccKWXY+1TyuLw6r0brOD
         dlBaZ+7i0vdmgTgp9tbT12ck1v9LIoaz3JAkSeCz2YN/hjKnfsvkU2X/E9jcjUEG1Q
         7HH2VU9Cae9pQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] mm/damon/schemes: Implement time quota
Date:   Tue, 19 Oct 2021 15:07:20 +0000
Message-Id: <20211019150731.16699-5-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019150731.16699-1-sj@kernel.org>
References: <20211019150731.16699-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size quota feature of DAMOS is useful for IO resource-critical
systems, but not so intuitive for CPU time-critical systems.  Systems
using zram or zswap-like swap device would be examples.

To provide another intuitive ways for such systems, this commit
implements time-based quota for DAMON-based Operation Schemes.  If the
quota is set, DAMOS tries to use only up to the user-defined quota of
CPU time within a given time window.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 25 +++++++++++++++++++-----
 mm/damon/core.c       | 45 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1fec32e18319..5347f940818e 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -91,20 +91,35 @@ enum damos_action {
 
 /**
  * struct damos_quota - Controls the aggressiveness of the given scheme.
+ * @ms:			Maximum milliseconds that the scheme can use.
  * @sz:			Maximum bytes of memory that the action can be applied.
  * @reset_interval:	Charge reset interval in milliseconds.
  *
  * To avoid consuming too much CPU time or IO resources for applying the
- * &struct damos->action to large memory, DAMON allows users to set a size
- * quota.  The quota can be set by writing non-zero values to &sz.  If the size
- * quota is set, DAMON tries to apply the action only up to &sz bytes within
- * &reset_interval.
+ * &struct damos->action to large memory, DAMON allows users to set time and/or
+ * size quotas.  The quotas can be set by writing non-zero values to &ms and
+ * &sz, respectively.  If the time quota is set, DAMON tries to use only up to
+ * &ms milliseconds within &reset_interval for applying the action.  If the
+ * size quota is set, DAMON tries to apply the action only up to &sz bytes
+ * within &reset_interval.
+ *
+ * Internally, the time quota is transformed to a size quota using estimated
+ * throughput of the scheme's action.  DAMON then compares it against &sz and
+ * uses smaller one as the effective quota.
  */
 struct damos_quota {
+	unsigned long ms;
 	unsigned long sz;
 	unsigned long reset_interval;
 
-/* private: For charging the quota */
+/* private: */
+	/* For throughput estimation */
+	unsigned long total_charged_sz;
+	unsigned long total_charged_ns;
+
+	unsigned long esz;	/* Effective size quota in bytes */
+
+	/* For charging the quota */
 	unsigned long charged_sz;
 	unsigned long charged_from;
 	struct damon_target *charge_target_from;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 693b75bc3450..d1da4bef96ed 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -107,8 +107,12 @@ struct damos *damon_new_scheme(
 	scheme->stat_sz = 0;
 	INIT_LIST_HEAD(&scheme->list);
 
+	scheme->quota.ms = quota->ms;
 	scheme->quota.sz = quota->sz;
 	scheme->quota.reset_interval = quota->reset_interval;
+	scheme->quota.total_charged_sz = 0;
+	scheme->quota.total_charged_ns = 0;
+	scheme->quota.esz = 0;
 	scheme->quota.charged_sz = 0;
 	scheme->quota.charged_from = 0;
 	scheme->quota.charge_target_from = NULL;
@@ -550,9 +554,10 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 	damon_for_each_scheme(s, c) {
 		struct damos_quota *quota = &s->quota;
 		unsigned long sz = r->ar.end - r->ar.start;
+		struct timespec64 begin, end;
 
 		/* Check the quota */
-		if (quota->sz && quota->charged_sz >= quota->sz)
+		if (quota->esz && quota->charged_sz >= quota->esz)
 			continue;
 
 		/* Skip previously charged regions */
@@ -597,16 +602,21 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 
 		/* Apply the scheme */
 		if (c->primitive.apply_scheme) {
-			if (quota->sz && quota->charged_sz + sz > quota->sz) {
-				sz = ALIGN_DOWN(quota->sz - quota->charged_sz,
+			if (quota->esz &&
+					quota->charged_sz + sz > quota->esz) {
+				sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
 						DAMON_MIN_REGION);
 				if (!sz)
 					goto update_stat;
 				damon_split_region_at(c, t, r, sz);
 			}
+			ktime_get_coarse_ts64(&begin);
 			c->primitive.apply_scheme(c, t, r, s);
+			ktime_get_coarse_ts64(&end);
+			quota->total_charged_ns += timespec64_to_ns(&end) -
+				timespec64_to_ns(&begin);
 			quota->charged_sz += sz;
-			if (quota->sz && quota->charged_sz >= quota->sz) {
+			if (quota->esz && quota->charged_sz >= quota->esz) {
 				quota->charge_target_from = t;
 				quota->charge_addr_from = r->ar.end + 1;
 			}
@@ -620,6 +630,29 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 	}
 }
 
+/* Shouldn't be called if quota->ms and quota->sz are zero */
+static void damos_set_effective_quota(struct damos_quota *quota)
+{
+	unsigned long throughput;
+	unsigned long esz;
+
+	if (!quota->ms) {
+		quota->esz = quota->sz;
+		return;
+	}
+
+	if (quota->total_charged_ns)
+		throughput = quota->total_charged_sz * 1000000 /
+			quota->total_charged_ns;
+	else
+		throughput = PAGE_SIZE * 1024;
+	esz = throughput * quota->ms;
+
+	if (quota->sz && quota->sz < esz)
+		esz = quota->sz;
+	quota->esz = esz;
+}
+
 static void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
@@ -629,15 +662,17 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	damon_for_each_scheme(s, c) {
 		struct damos_quota *quota = &s->quota;
 
-		if (!quota->sz)
+		if (!quota->ms && !quota->sz)
 			continue;
 
 		/* New charge window starts */
 		if (time_after_eq(jiffies, quota->charged_from +
 					msecs_to_jiffies(
 						quota->reset_interval))) {
+			quota->total_charged_sz += quota->charged_sz;
 			quota->charged_from = jiffies;
 			quota->charged_sz = 0;
+			damos_set_effective_quota(quota);
 		}
 	}
 
-- 
2.17.1

