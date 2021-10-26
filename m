Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5222343B5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbhJZPdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbhJZPdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:33:06 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11F6C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:30:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d13so17484067wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6cpJtG+wTHrSrhs0lOFF/T+EZ1/Y2hk1uLFmtJtAfwM=;
        b=i2LbnmQPSPKXqN23DvcJWKtht0TaatbSLGQJJxhc5iy0TEgH4IMbRwBnB9Cnb1oh2l
         S4ZRcTEtQwBhLxdSy5QNkyUIRqTsJQwSmPH8EF8mx1xRrfWDEPjC+AzJxSkapzdk+JN6
         rpFc+ATgznln/pysuP5/BEB+h1MAnEDJLM7/OfW8lyzQZWNqNevXixm85nNya6mqpX07
         ilv5Zk1NXwR5oy/r3CD7kHB85mesdV288D7D7OT41uMg+bMWD3xocnBMQm0sCxPQS+e6
         3KrwrkyTn60kDZ9ahaZNvLVE0C/rEi9dAPqcuFIFpF0C9wpx93aVdl+UodKxXlGJiubr
         yWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6cpJtG+wTHrSrhs0lOFF/T+EZ1/Y2hk1uLFmtJtAfwM=;
        b=Hdd6u5fdrQkPPURrnc3TJQfe63/X7XLg0iv3a+teR58bUXtArO1aUf51zNsn81M43l
         YlYiajQXtcobz1Ho3VfrnGO7k/4yKQGfVRtUPGe+7eGO20a70k9f35WtrWWg/9+WFkda
         CsIwNpnAI84xFMcs8F4o0BeW62nqKI3Ijj6e51LJl8oPqV1l4eLheOwoLLHYP6TWU3Jp
         XbwR0/lcCkv9oyaT/BXW0BYkq7j0fGAnmKW5mGVknmNmC20RcfwffOmXPLyp+Cp62MrZ
         3zoPqxP38vjLkcoQ6UcDfh5/MEs8oYmHIevbhShgV6HslGxGgFgrqXg7hzTU6w/7A1J0
         T35A==
X-Gm-Message-State: AOAM533iXWZBXAKObxXKPJXgmOmZI3NZVOIkPW6mYO/a73UqsHLzqfaA
        q5Usqxcabj5PA39hUJogP4y1O2ZTMuE=
X-Google-Smtp-Source: ABdhPJxBNjs1ZZTCJEUsBCFwLsoJALG86R+WedYljNFCWFOIKNHE8ljqrQRnpJCK1hH9e45bRAl+OA==
X-Received: by 2002:adf:ef8f:: with SMTP id d15mr32682984wro.72.1635262241470;
        Tue, 26 Oct 2021 08:30:41 -0700 (PDT)
Received: from WRT-WX9.. ([95.179.207.30])
        by smtp.gmail.com with ESMTPSA id s3sm878189wmh.30.2021.10.26.08.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 08:30:40 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] mm/damon: simplify stop mechanism
Date:   Tue, 26 Oct 2021 23:30:33 +0800
Message-Id: <20211026153033.11140-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An kernel thread can exit gracefully with kthread_stop(). So we don't need
a new flag 'kdamond_stop'. And to make sure the task struct is not freed
when accessing it, get task struct on start and put it on stop.

And since the return value of 'before_terminate' callback is never used,
we make it have no return value.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 include/linux/damon.h |  3 +--
 mm/damon/core.c       | 59 +++++++++++++------------------------------
 mm/damon/dbgfs.c      |  5 ++--
 3 files changed, 20 insertions(+), 47 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a14b3cc54cab..041966786270 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -322,7 +322,7 @@ struct damon_callback {
 	int (*before_start)(struct damon_ctx *context);
 	int (*after_sampling)(struct damon_ctx *context);
 	int (*after_aggregation)(struct damon_ctx *context);
-	int (*before_terminate)(struct damon_ctx *context);
+	void (*before_terminate)(struct damon_ctx *context);
 };
 
 /**
@@ -381,7 +381,6 @@ struct damon_ctx {
 
 /* public: */
 	struct task_struct *kdamond;
-	bool kdamond_stop;
 	struct mutex kdamond_lock;
 
 	struct damon_primitive primitive;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 46a6afea3030..46401c56bfb2 100644
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
@@ -418,13 +407,13 @@ static int __damon_start(struct damon_ctx *ctx)
 	mutex_lock(&ctx->kdamond_lock);
 	if (!ctx->kdamond) {
 		err = 0;
-		ctx->kdamond_stop = false;
 		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond.%d",
 				nr_running_ctxs);
 		if (IS_ERR(ctx->kdamond)) {
 			err = PTR_ERR(ctx->kdamond);
 			ctx->kdamond = NULL;
-		}
+		} else
+			get_task_struct(ctx->kdamond);
 	}
 	mutex_unlock(&ctx->kdamond_lock);
 
@@ -474,18 +463,18 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
  */
 static int __damon_stop(struct damon_ctx *ctx)
 {
+	int ret = -EPERM;
+
 	mutex_lock(&ctx->kdamond_lock);
 	if (ctx->kdamond) {
-		ctx->kdamond_stop = true;
-		mutex_unlock(&ctx->kdamond_lock);
-		while (damon_kdamond_running(ctx))
-			usleep_range(ctx->sample_interval,
-					ctx->sample_interval * 2);
-		return 0;
+		kthread_stop(ctx->kdamond);
+		put_task_struct(ctx->kdamond);
+		ctx->kdamond = NULL;
+		ret = 0;
 	}
 	mutex_unlock(&ctx->kdamond_lock);
 
-	return -EPERM;
+	return ret;
 }
 
 /**
@@ -925,12 +914,8 @@ static bool kdamond_need_update_primitive(struct damon_ctx *ctx)
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
@@ -1021,13 +1006,6 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
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
@@ -1038,17 +1016,18 @@ static int kdamond_fn(void *data)
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
 
@@ -1056,7 +1035,7 @@ static int kdamond_fn(void *data)
 			ctx->primitive.prepare_access_checks(ctx);
 		if (ctx->callback.after_sampling &&
 				ctx->callback.after_sampling(ctx))
-			set_kdamond_stop(ctx);
+			done = true;
 
 		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
 
@@ -1069,7 +1048,7 @@ static int kdamond_fn(void *data)
 					sz_limit);
 			if (ctx->callback.after_aggregation &&
 					ctx->callback.after_aggregation(ctx))
-				set_kdamond_stop(ctx);
+				done = true;
 			kdamond_apply_schemes(ctx);
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
@@ -1088,16 +1067,12 @@ static int kdamond_fn(void *data)
 			damon_destroy_region(r, t);
 	}
 
-	if (ctx->callback.before_terminate &&
-			ctx->callback.before_terminate(ctx))
-		set_kdamond_stop(ctx);
+	if (ctx->callback.before_terminate)
+		ctx->callback.before_terminate(ctx);
 	if (ctx->primitive.cleanup)
 		ctx->primitive.cleanup(ctx);
 
 	pr_debug("kdamond (%d) finishes\n", current->pid);
-	mutex_lock(&ctx->kdamond_lock);
-	ctx->kdamond = NULL;
-	mutex_unlock(&ctx->kdamond_lock);
 
 	mutex_lock(&damon_lock);
 	nr_running_ctxs--;
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index befb27a29aab..eccc14b34901 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -645,18 +645,17 @@ static void dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
 		debugfs_create_file(file_names[i], 0600, dir, ctx, fops[i]);
 }
 
-static int dbgfs_before_terminate(struct damon_ctx *ctx)
+static void dbgfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
 
 	if (!targetid_is_pid(ctx))
-		return 0;
+		return;
 
 	damon_for_each_target_safe(t, next, ctx) {
 		put_pid((struct pid *)t->id);
 		damon_destroy_target(t);
 	}
-	return 0;
 }
 
 static struct damon_ctx *dbgfs_new_ctx(void)
-- 
2.32.0

