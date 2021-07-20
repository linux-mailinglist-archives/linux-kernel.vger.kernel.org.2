Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE96D3CFA8F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbhGTMto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbhGTMd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:33:28 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772EBC061574;
        Tue, 20 Jul 2021 06:14:06 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id k4so8985039qkj.13;
        Tue, 20 Jul 2021 06:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YceUl9gK1f+DUw5lLJnUOuiqygVMuUWiniuXFoUnVS4=;
        b=Ieb+Cvc3zbFZSyAoPxvbLvuq08w5aQSh69ss+eMxt4RYknpj0ExKOY/oKTfWFturrB
         E43GJ5eaTG976f21rtJ2nnBi/lEBxkiGThyU+u5BRB2pt7lbhLThFDtmOfkK68KXQqZG
         59Lr+XBFW7kK5PtlDmyapxVAAzXxTyH4Do5B6vxse4+xuC0N3XzrxvXZafCr8CTJiTPb
         i1rh9+JKUi10lC7hDFaX9Weh/nO48gwFA0LEAwbt1aSOClkYCVQFQFWTjGBJy3EkuOIz
         ISttkTcsq1km+U9TyI8B447iB6Qpwy1KRklTgzmdyNNnj8WjdAkhmTzO1Jjv/kxxvD3W
         tAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YceUl9gK1f+DUw5lLJnUOuiqygVMuUWiniuXFoUnVS4=;
        b=r4mDmHkKRwcWsd/I8qEzQ53dFUq7/60yYVJpY9cKEg2nA/orHBKYgYOYtqKiGJJlox
         9vCbtfSQlpw0dPmi7FVO7bMPiH8yehQBIjU+yd2sWzjj3wUdpsrPuOcsBLFav+MP9g/a
         GnxMSj6Qbvi+/rPWGhXFIbjnvh0MLMMZV012CP8PKafwzA8QGuCvfgxUiieRtZLndDFb
         707vnHUQnxpNVa/Dqp0joXzcyfR0EZoRK0tIdCgoqBJizkJOkEqDkaYR9Pg881t7ViCr
         sBoQHbI2ce8bfaWmPSCo/iX63uBIgXgN+3s60G1+LE8jtoyLDSHg9KGRNOPGBsaFOUZl
         HhoA==
X-Gm-Message-State: AOAM533EtsXIQhHqhulGG7uAO2320vqLCfKBE3W9bMp86HMnZEFW53Na
        Qym5zmdPmMfznDQbfhbbzhU=
X-Google-Smtp-Source: ABdhPJzdTEEl3SbX2pZcS9sDsNYjQP7I8ks/LX6G+x/G+B90qTjGmlMr22grI2h627KFW3x/REOsyQ==
X-Received: by 2002:a05:620a:629:: with SMTP id 9mr15185106qkv.501.1626786845624;
        Tue, 20 Jul 2021 06:14:05 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g17sm9701225qkm.34.2021.07.20.06.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:14:05 -0700 (PDT)
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
Subject: [RFC v3 04/15] mm/damon/schemes: Implement time quota
Date:   Tue, 20 Jul 2021 13:12:58 +0000
Message-Id: <20210720131309.22073-5-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720131309.22073-1-sj38.park@gmail.com>
References: <20210720131309.22073-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit implements time-based quota for DAMON-based Operation
Schemes.  If the quota is set, DAMOS tries to use only up to the
user-defined quota within the 'reset_interval' milliseconds.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h | 25 +++++++++++++++++++-----
 mm/damon/core.c       | 45 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7b1fa506e7a6..d2dd36b9dd6c 100644
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
index a41eb9d885bb..321523604ef6 100644
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
@@ -555,9 +559,10 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 	damon_for_each_scheme(s, c) {
 		struct damos_quota *quota = &s->quota;
 		unsigned long sz = r->ar.end - r->ar.start;
+		struct timespec64 begin, end;
 
 		/* Check the quota */
-		if (quota->sz && quota->charged_sz >= quota->sz)
+		if (quota->esz && quota->charged_sz >= quota->esz)
 			continue;
 
 		/* Skip previously charged regions */
@@ -602,16 +607,21 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 
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
@@ -625,6 +635,29 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
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
@@ -634,15 +667,17 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
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

