Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6D643CA4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 15:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242083AbhJ0NHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242082AbhJ0NHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:07:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F5DC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 06:05:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m22so4153959wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 06:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OiCX8D31pPbHnzvf2oaw3Vd7y+KKNl/DTKEL0iqAa3o=;
        b=ENSl3WDByEE48jaQ6uANo5ZFCux4iaCaQEe+bJ/MLf93uVEov/ydZgcutP1xBeh1sy
         TsA4EEeFe5jNr12X4/BDoXpnSCVbxKabPm/gdQweQ6vej1jAKjyWH/GcW2FKaC2olRZG
         xNgfI/hkxkTjrA06pIOe5CH4pD+CI0xTZyO23GDXy52u/YCtx9auw4AvcIjQ687azct9
         wj11kDuKxtcHteZxxsz656mZRWs9GJs4GOWDQ+OMPxmlwTrXZDxi+Zd8Mjp/Rqo9KFVH
         1jIy/RtbHneEoJ3g7OwK2fjMtqaqM+xuUNfNPsYnW/Ui8LsJr9EcGisq2Y6EfxvhQPua
         9IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OiCX8D31pPbHnzvf2oaw3Vd7y+KKNl/DTKEL0iqAa3o=;
        b=0cS/W+kb2960IHfR4dwupPAMIDkYL1Bxdc3KkYuvQzqt8BCGYpH22khfQLrVmal5hT
         eaLgJQA/pbW145jxn93dfc6D58h4S4+aAEz1dqYxVVB/74roF47v7AT6QhyZE7GTBQ+2
         kGtfBHoZ3Rq/J2W8iaZCwHZAKcWCHPIQsKTGfDjRVPNVH2fODYghrzqsjYbGdwZkSLOy
         NfKTZImLFd5XwJvk9nc8dDByU8LxHhGXqzk7uJUMquwjfQHehRwmxX547khnYw4uAtqK
         8YVhf7031pugZkR4UN6aaLax7szVKB39L2+HiRS1sVb+L0k763PyZZ6oVeK22JQHJdU5
         TCQA==
X-Gm-Message-State: AOAM5328T2PL7dO8mlKO2FdWSqKEFrcUU8g6V6KpCANk9mxwqLHowTgD
        yI60Wi3HtBdgaLU7iDWEBRsSfF0+nUs=
X-Google-Smtp-Source: ABdhPJwrexgWGIaXV2EAye0Q7dfKIR5P9x2Nvmh1cjyBrWQzH9s9xZ6VrRQN2KpWoEZrETKwnb8e3g==
X-Received: by 2002:adf:ed89:: with SMTP id c9mr42032701wro.268.1635339924403;
        Wed, 27 Oct 2021 06:05:24 -0700 (PDT)
Received: from WRT-WX9.. ([95.179.207.30])
        by smtp.gmail.com with ESMTPSA id v191sm3449104wme.36.2021.10.27.06.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 06:05:23 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2] mm/damon: simplify stop mechanism
Date:   Wed, 27 Oct 2021 21:05:17 +0800
Message-Id: <20211027130517.4404-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An kernel thread can exit gracefully with kthread_stop(). So we don't need
a new flag 'kdamond_stop'. And to make sure the task struct is not freed
when accessing it, get reference of it before termination.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 include/linux/damon.h |  1 -
 mm/damon/core.c       | 51 +++++++++++++------------------------------
 2 files changed, 15 insertions(+), 37 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a14b3cc54cab..50c6eb0dee1f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -381,7 +381,6 @@ struct damon_ctx {
 
 /* public: */
 	struct task_struct *kdamond;
-	bool kdamond_stop;
 	struct mutex kdamond_lock;
 
 	struct damon_primitive primitive;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 46a6afea3030..f37c17b53814 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -390,17 +390,6 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 	return sz;
 }
 
-static bool damon_kdamond_running(struct damon_ctx *ctx)
-{
-	bool running;
-
-	mutex_lock(&ctx->kdamond_lock);
-	running = ctx->kdamond != NULL;
-	mutex_unlock(&ctx->kdamond_lock);
-
-	return running;
-}
-
 static int kdamond_fn(void *data);
 
 /*
@@ -418,7 +407,6 @@ static int __damon_start(struct damon_ctx *ctx)
 	mutex_lock(&ctx->kdamond_lock);
 	if (!ctx->kdamond) {
 		err = 0;
-		ctx->kdamond_stop = false;
 		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond.%d",
 				nr_running_ctxs);
 		if (IS_ERR(ctx->kdamond)) {
@@ -474,13 +462,15 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
  */
 static int __damon_stop(struct damon_ctx *ctx)
 {
+	struct task_struct *tsk;
+
 	mutex_lock(&ctx->kdamond_lock);
-	if (ctx->kdamond) {
-		ctx->kdamond_stop = true;
+	tsk = ctx->kdamond;
+	if (tsk) {
+		get_task_struct(tsk);
 		mutex_unlock(&ctx->kdamond_lock);
-		while (damon_kdamond_running(ctx))
-			usleep_range(ctx->sample_interval,
-					ctx->sample_interval * 2);
+		kthread_stop(tsk);
+		put_task_struct(tsk);
 		return 0;
 	}
 	mutex_unlock(&ctx->kdamond_lock);
@@ -925,12 +915,8 @@ static bool kdamond_need_update_primitive(struct damon_ctx *ctx)
 static bool kdamond_need_stop(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
-	bool stop;
 
-	mutex_lock(&ctx->kdamond_lock);
-	stop = ctx->kdamond_stop;
-	mutex_unlock(&ctx->kdamond_lock);
-	if (stop)
+	if (kthread_should_stop())
 		return true;
 
 	if (!ctx->primitive.target_valid)
@@ -1021,13 +1007,6 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 	return -EBUSY;
 }
 
-static void set_kdamond_stop(struct damon_ctx *ctx)
-{
-	mutex_lock(&ctx->kdamond_lock);
-	ctx->kdamond_stop = true;
-	mutex_unlock(&ctx->kdamond_lock);
-}
-
 /*
  * The monitoring daemon that runs as a kernel thread
  */
@@ -1038,17 +1017,18 @@ static int kdamond_fn(void *data)
 	struct damon_region *r, *next;
 	unsigned int max_nr_accesses = 0;
 	unsigned long sz_limit = 0;
+	bool done = false;
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
 
 	if (ctx->primitive.init)
 		ctx->primitive.init(ctx);
 	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
-		set_kdamond_stop(ctx);
+		done = true;
 
 	sz_limit = damon_region_sz_limit(ctx);
 
-	while (!kdamond_need_stop(ctx)) {
+	while (!kdamond_need_stop(ctx) && !done) {
 		if (kdamond_wait_activation(ctx))
 			continue;
 
@@ -1056,7 +1036,7 @@ static int kdamond_fn(void *data)
 			ctx->primitive.prepare_access_checks(ctx);
 		if (ctx->callback.after_sampling &&
 				ctx->callback.after_sampling(ctx))
-			set_kdamond_stop(ctx);
+			done = true;
 
 		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
 
@@ -1069,7 +1049,7 @@ static int kdamond_fn(void *data)
 					sz_limit);
 			if (ctx->callback.after_aggregation &&
 					ctx->callback.after_aggregation(ctx))
-				set_kdamond_stop(ctx);
+				done = true;
 			kdamond_apply_schemes(ctx);
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
@@ -1088,9 +1068,8 @@ static int kdamond_fn(void *data)
 			damon_destroy_region(r, t);
 	}
 
-	if (ctx->callback.before_terminate &&
-			ctx->callback.before_terminate(ctx))
-		set_kdamond_stop(ctx);
+	if (ctx->callback.before_terminate)
+		ctx->callback.before_terminate(ctx);
 	if (ctx->primitive.cleanup)
 		ctx->primitive.cleanup(ctx);
 
-- 
2.32.0

