Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D9C3F5BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbhHXKSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:18:48 -0400
Received: from out1.migadu.com ([91.121.223.63]:61860 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235933AbhHXKSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:18:46 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629800281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=coF2UljFE8rDsrWi34y6jxCzCxj/fWB6DzykIuG23bY=;
        b=dPTi5iQ7g5vvneVmk/0V/QUhR2OaSCM682GYwCnfRYyYxGa4M0Vhz2AYe4peajkenggAZ8
        w8YybFk3tPqB3q/ZfAvE9XcJMMMtrJzxQJUlYR+aJSvBE4SQI9eao3Gic+uMDSvzif99K1
        htKKqEIg8PSgY/dmq0QC8GLfgXVBdmE=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH linux-next] sched: stop: Remove unnecessary CONFIG_SMP
Date:   Tue, 24 Aug 2021 18:17:47 +0800
Message-Id: <20210824101747.6350-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file only compiled when enable CONFIG_SMP, so there is no need
add CONFIG_SMP inside the file.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/stop_task.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index f988ebe3febb..8c9f9313df31 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -9,7 +9,6 @@
  */
 #include "sched.h"
 
-#ifdef CONFIG_SMP
 static int
 select_task_rq_stop(struct task_struct *p, int cpu, int flags)
 {
@@ -21,7 +20,6 @@ balance_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	return sched_stop_runnable(rq);
 }
-#endif /* CONFIG_SMP */
 
 static void
 check_preempt_curr_stop(struct rq *rq, struct task_struct *p, int flags)
@@ -130,12 +128,10 @@ DEFINE_SCHED_CLASS(stop) = {
 	.put_prev_task		= put_prev_task_stop,
 	.set_next_task          = set_next_task_stop,
 
-#ifdef CONFIG_SMP
 	.balance		= balance_stop,
 	.pick_task		= pick_task_stop,
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
-#endif
 
 	.task_tick		= task_tick_stop,
 
-- 
2.32.0

