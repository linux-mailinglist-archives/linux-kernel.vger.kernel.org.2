Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C8E3CC29A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 12:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhGQKWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 06:22:39 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:45377
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S233074AbhGQKWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 06:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=csHolcubn9N81o0+mDQBqCw5dpseCZ5PZKV23CkCt9M=; b=O
        g96D50FotJgIaepXmrCNZZMz7voK4CSGgFHqEobH3y9o2Y4MNvOv1Q69Berh3wf/
        s8AKZ6/Vz5W5PUewR+lJp0q2VtB+9wL62GKb84c1U3oKxOLfoLu4273qQsQcR5Mn
        /unrzw4lzr85BI+m+8ZfOrS3G4T3quT34BG018r2SE=
Received: from localhost.localdomain (unknown [39.144.44.130])
        by app2 (Coremail) with SMTP id XQUFCgBXHGtLrvJgx7vYBA--.38653S3;
        Sat, 17 Jul 2021 18:17:48 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] sched: Convert from atomic_t to refcount_t on root_domain->refcount
Date:   Sat, 17 Jul 2021 18:17:45 +0800
Message-Id: <1626517066-42760-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgBXHGtLrvJgx7vYBA--.38653S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry3tF17ZFyfWFyfJrW5Wrg_yoW5JryDpF
        4qvrW5JFZ5GryxJrnrC3yDZrWrW34xA34fKay5JwsxJr93Jws0g3WvvFy3CryUCrnxAr1a
        vF429342yFsFvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
        Y4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
        AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGjg7UUUUU==
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refcount_t type and corresponding API can protect refcounters from
accidental underflow and overflow and further use-after-free situations.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 kernel/sched/sched.h    |  3 ++-
 kernel/sched/topology.c | 12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14a41a243f7b..8197738a615a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3,6 +3,7 @@
  * Scheduler internal types and methods:
  */
 #include <linux/sched.h>
+#include <linux/refcount.h>
 
 #include <linux/sched/autogroup.h>
 #include <linux/sched/clock.h>
@@ -784,7 +785,7 @@ struct perf_domain {
  *
  */
 struct root_domain {
-	atomic_t		refcount;
+	refcount_t		refcount;
 	atomic_t		rto_count;
 	struct rcu_head		rcu;
 	cpumask_var_t		span;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b77ad49dc14f..5d7d767e62ed 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -482,11 +482,11 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 		 * set old_rd to NULL to skip the freeing later
 		 * in this function:
 		 */
-		if (!atomic_dec_and_test(&old_rd->refcount))
+		if (!refcount_dec_and_test(&old_rd->refcount))
 			old_rd = NULL;
 	}
 
-	atomic_inc(&rd->refcount);
+	refcount_inc(&rd->refcount);
 	rq->rd = rd;
 
 	cpumask_set_cpu(rq->cpu, rd->span);
@@ -501,12 +501,12 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 
 void sched_get_rd(struct root_domain *rd)
 {
-	atomic_inc(&rd->refcount);
+	refcount_inc(&rd->refcount);
 }
 
 void sched_put_rd(struct root_domain *rd)
 {
-	if (!atomic_dec_and_test(&rd->refcount))
+	if (!refcount_dec_and_test(&rd->refcount))
 		return;
 
 	call_rcu(&rd->rcu, free_rootdomain);
@@ -562,7 +562,7 @@ void init_defrootdomain(void)
 {
 	init_rootdomain(&def_root_domain);
 
-	atomic_set(&def_root_domain.refcount, 1);
+	refcount_set(&def_root_domain.refcount, 1);
 }
 
 static struct root_domain *alloc_rootdomain(void)
@@ -1419,7 +1419,7 @@ static void __free_domain_allocs(struct s_data *d, enum s_alloc what,
 {
 	switch (what) {
 	case sa_rootdomain:
-		if (!atomic_read(&d->rd->refcount))
+		if (!refcount_read(&d->rd->refcount))
 			free_rootdomain(&d->rd->rcu);
 		fallthrough;
 	case sa_sd:
-- 
2.7.4

