Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E9C407595
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 10:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhIKI0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 04:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhIKI0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 04:26:38 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D90C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 01:25:26 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id w8so4110311pgf.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ykWxIjOCY4jSbazZ+Zw+qZbNl9PLlWPfWBJ6E/OK5bI=;
        b=bycI7GT4Jd+JuHzyth+nSnWtKAtFYGoGeFrURamaxVCgXgweylhTD+v37LcQJl9NuR
         Y2z3/DtHn7rVo7a6D1tNfXxhVWjbxzhZwfh6FJBqimtDXZVhbLbgFxkLyI2ldZHYnDwB
         KORdkI0x+grn6xpIn6vZzY4VLkabY8bdoE6ul636D5imtFOb1+6aPDHFso+PIOjUqCa1
         QrvJBeQKdcyhgv/HpCYxt2Q3oNDQltQsu7Tb6q8tcyPbizURUW2NkIIav5ydZkjx2Anb
         SBmlngyK2M4JvHwNLF/Dai3NGGF9AJZ5dTj1D5PSHhDwlaknr4F4MocDx7f2euG1uKOd
         wwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ykWxIjOCY4jSbazZ+Zw+qZbNl9PLlWPfWBJ6E/OK5bI=;
        b=rordtm8PepR4Tbr6IJ949qHShlDG0146pqYddMNaLnb2ZDG6Tx3e/xBsoQqi7G50zw
         OM/mEFyqHBbuuCLWRt/zmG/3nfwyY2VOI8WzyXlLA1rbIZ4rRCA/kAK9oy5teT4OHlTe
         t0/Y2me/rZBHYnaQqwhxqERfdLTlmNuRzE9G7T1EfrD8j/MQPHECGFnCBxO/j1vMOfh0
         QTLG69UzE8XtATehrdSyLaZdZNS1NsCxqx5aSXBl+0+Za6xaHf2UIsi0/dvisxF1t5C2
         MhClQxQuzTV4ai65REdt8BppLxhccxG2WbgNXyF0A7fFriIMi6jh0FMbleOAfIaltEPi
         O1SQ==
X-Gm-Message-State: AOAM532lVDm/xqijGqNfRGtOAtYo4ZgBCs8Wznw+uSRmXLv1aUAVoRIB
        9jJ+t2F/qn9Opgj77EDPOUo=
X-Google-Smtp-Source: ABdhPJybfJ9E9EelhNwYMxHf1sZS67cCn+OmGoNb35ykAr6rdbN7J3Es24l+6+r1z30u+j1f+c6BcQ==
X-Received: by 2002:a05:6a00:882:b0:416:3ddd:afae with SMTP id q2-20020a056a00088200b004163dddafaemr1763710pfj.72.1631348725408;
        Sat, 11 Sep 2021 01:25:25 -0700 (PDT)
Received: from localhost.localdomain ([141.164.38.246])
        by smtp.gmail.com with ESMTPSA id p62sm1174051pfg.25.2021.09.11.01.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 01:25:24 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     peterz@infradead.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH peterz-queue:sched/core] sched: fix build warning with W=1
Date:   Sat, 11 Sep 2021 08:25:05 +0000
Message-Id: <20210911082505.115758-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported some build warnings with W=1 as below,

kernel/sched/fair.c:892:34: warning: variable 'stats' set but not used
kernel/sched/core.c:10238:42: warning: variable 'stats' set but not used
kernel/sched/fair.c:893:29: warning: variable 'p' set but not used
kernel/sched/rt.c:1292:29: warning: variable 'p' set but not used
kernel/sched/deadline.c:1486:34: warning: variable 'stats' set but not used
arch/nds32/include/asm/current.h:10:13: warning: variable '$r25' set but not used

These warnings happen when CONFIG_SCHEDSTATS is not set, in which
case the schedstat_* functions will be none. We should add
'__maybe_unused' to fix it

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/core.c     |  4 ++--
 kernel/sched/deadline.c |  6 +++---
 kernel/sched/fair.c     | 12 ++++++------
 kernel/sched/rt.c       |  6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 85e212d3c7ff..7c3476f284d8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3462,7 +3462,7 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 static void
 ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 {
-	struct rq *rq;
+	struct rq __maybe_unused *rq;
 
 	if (!schedstat_enabled())
 		return;
@@ -10235,7 +10235,7 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 	seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
 
 	if (schedstat_enabled() && tg != &root_task_group) {
-		struct sched_statistics *stats;
+		struct sched_statistics __maybe_unused *stats;
 		u64 ws = 0;
 		int i;
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d2c072b0ef01..f6ececf11725 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1483,7 +1483,7 @@ __schedstats_from_dl_se(struct sched_dl_entity *dl_se)
 static inline void
 update_stats_wait_start_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 {
-	struct sched_statistics *stats;
+	struct sched_statistics __maybe_unused *stats;
 
 	if (!schedstat_enabled())
 		return;
@@ -1495,7 +1495,7 @@ update_stats_wait_start_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 static inline void
 update_stats_wait_end_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 {
-	struct sched_statistics *stats;
+	struct sched_statistics __maybe_unused *stats;
 
 	if (!schedstat_enabled())
 		return;
@@ -1507,7 +1507,7 @@ update_stats_wait_end_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 static inline void
 update_stats_enqueue_sleeper_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 {
-	struct sched_statistics *stats;
+	struct sched_statistics __maybe_unused *stats;
 
 	if (!schedstat_enabled())
 		return;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ea13d3d9e540..4d985d0364bc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -889,8 +889,8 @@ static void update_curr_fair(struct rq *rq)
 static inline void
 update_stats_wait_start_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	struct sched_statistics *stats;
-	struct task_struct *p = NULL;
+	struct sched_statistics __maybe_unused *stats;
+	struct task_struct __maybe_unused *p = NULL;
 
 	if (!schedstat_enabled())
 		return;
@@ -906,8 +906,8 @@ update_stats_wait_start_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static inline void
 update_stats_wait_end_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	struct sched_statistics *stats;
-	struct task_struct *p = NULL;
+	struct sched_statistics __maybe_unused *stats;
+	struct task_struct __maybe_unused *p = NULL;
 
 	if (!schedstat_enabled())
 		return;
@@ -932,8 +932,8 @@ update_stats_wait_end_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static inline void
 update_stats_enqueue_sleeper_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	struct sched_statistics *stats;
-	struct task_struct *tsk = NULL;
+	struct sched_statistics __maybe_unused *stats;
+	struct task_struct __maybe_unused *tsk = NULL;
 
 	if (!schedstat_enabled())
 		return;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index bb945f8faeca..e19d1e7190cc 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1288,8 +1288,8 @@ __schedstats_from_rt_se(struct sched_rt_entity *rt_se)
 static inline void
 update_stats_wait_start_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
 {
+	struct task_struct __maybe_unused *p = NULL;
 	struct sched_statistics *stats;
-	struct task_struct *p = NULL;
 
 	if (!schedstat_enabled())
 		return;
@@ -1307,8 +1307,8 @@ update_stats_wait_start_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
 static inline void
 update_stats_enqueue_sleeper_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
 {
+	struct task_struct __maybe_unused *p = NULL;
 	struct sched_statistics *stats;
-	struct task_struct *p = NULL;
 
 	if (!schedstat_enabled())
 		return;
@@ -1337,8 +1337,8 @@ update_stats_enqueue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
 static inline void
 update_stats_wait_end_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
 {
+	struct task_struct __maybe_unused *p = NULL;
 	struct sched_statistics *stats;
-	struct task_struct *p = NULL;
 
 	if (!schedstat_enabled())
 		return;
-- 
2.17.1

