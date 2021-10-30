Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178F04407DF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 09:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhJ3Hev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 03:34:51 -0400
Received: from mx316.baidu.com ([180.101.52.236]:16904 "EHLO
        njjs-sys-mailin02.njjs.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230365AbhJ3Heu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 03:34:50 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Oct 2021 03:34:49 EDT
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by njjs-sys-mailin02.njjs.baidu.com (Postfix) with ESMTP id CEA8916542866;
        Sat, 30 Oct 2021 15:25:59 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id ACE5CD9932;
        Sat, 30 Oct 2021 15:25:59 +0800 (CST)
From:   Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Simplify task_numa_find_cpu()
Date:   Sat, 30 Oct 2021 15:25:59 +0800
Message-Id: <1635578759-32343-1-git-send-email-yuanzhaoxiong@baidu.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine the 'cpumask_of_node()' with 'env->p->cpus_ptr' and drop the
cpumask_test_cpu().

Signed-off-by: Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
---
 kernel/sched/fair.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f6a05d9..dc064d7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1950,11 +1950,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		maymove = !load_too_imbalanced(src_load, dst_load, env);
 	}
 
-	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
-		/* Skip this CPU if the source task cannot migrate */
-		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
-			continue;
-
+	for_each_cpu_and(cpu, cpumask_of_node(env->dst_nid), env->p->cpus_ptr) {
 		env->dst_cpu = cpu;
 		if (task_numa_compare(env, taskimp, groupimp, maymove))
 			break;
-- 
1.8.3.1

