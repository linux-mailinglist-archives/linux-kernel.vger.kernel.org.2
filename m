Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A448C41A6F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 07:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhI1FRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 01:17:13 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49]:36837 "EHLO
        esa3.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233279AbhI1FRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 01:17:10 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 01:17:10 EDT
IronPort-SDR: vAXMU8Lph1mycuOlgfP+UIz54OQqBp6U/viMBpNMCzrQQ2o6UF7g9ePOhVDNWQESW7UGNUUPVe
 2tNkYrV/r/RlqPBjpkNRE1H1xBPyUZymmi0gudNaU3EWiDVZw7ehcoHE3FIic3qSA6mNV+7MVf
 WDkM6uAWqWrDWLwp4KCWykZwiE41lP1P3g5+RdTslEllO4EMWhfnhfqxjpS9voOjnZJpiuShJr
 QHueNdvg+jUJTs/Ov6/NNfajYlIeICQEEqO52sWzI4pBOErPCjh9FZ7Ke1KPkzPAmATG0GOd7I
 zMIyDxcUNnyiRjkoesga9AXq
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="46691967"
X-IronPort-AV: E=Sophos;i="5.85,328,1624287600"; 
   d="scan'208";a="46691967"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 28 Sep 2021 14:08:17 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5F3D6ECC26
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:08:16 +0900 (JST)
Received: from yto-om2.fujitsu.com (yto-om2.o.css.fujitsu.com [10.128.89.163])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 90ABC661CA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:08:15 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-om2.fujitsu.com (Postfix) with ESMTP id 807824007DEFB;
        Tue, 28 Sep 2021 14:08:15 +0900 (JST)
From:   Hasegawa Hitomi <hasegawa-hitomi@fujitsu.com>
To:     frederic@kernel.org
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        fweisbec@gmail.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@kernel.org,
        peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
        vincent.guittot@linaro.org,
        Hasegawa Hitomi <hasegawa-hitomi@fujitsu.com>
Subject: [PATCH 1/1] sched/cputime: Improve getrusage(RUSAGE_THREAD) with nohz_full
Date:   Tue, 28 Sep 2021 14:08:04 +0900
Message-Id: <20210928050804.4156102-2-hasegawa-hitomi@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210928050804.4156102-1-hasegawa-hitomi@fujitsu.com>
References: <20210928050804.4156102-1-hasegawa-hitomi@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The getrusage(RUSAGE_THREAD) with nohz_full returns shorter utime/stime
than the actual time.

In the current implementation, task_cputime_adjusted() calls task_cputime()
to get the "current" utime and stime, then calls cputime_adjust () to
adjust the sum of utime and stime to be equal to cputime.sum_exec_runtime.
In nohz_full, sum_exec_runtime is not updated regularly, which is the cause
of this discrepancy.

This patch add a process to update sum_exec_runtime.
This addition applies only when run with nohz_full.

Signed-off-by: Hasegawa Hitomi <hasegawa-hitomi@fujitsu.com>
---
 include/linux/sched/cputime.h |  5 +++--
 kernel/sched/cputime.c        | 12 +++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
index 6c9f19a33865..ce3c58286062 100644
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -18,15 +18,16 @@
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-extern void task_cputime(struct task_struct *t,
+extern bool task_cputime(struct task_struct *t,
 			 u64 *utime, u64 *stime);
 extern u64 task_gtime(struct task_struct *t);
 #else
-static inline void task_cputime(struct task_struct *t,
+static inline bool task_cputime(struct task_struct *t,
 				u64 *utime, u64 *stime)
 {
 	*utime = t->utime;
 	*stime = t->stime;
+	return false;
 }
 
 static inline u64 task_gtime(struct task_struct *t)
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 872e481d5098..9392aea1804e 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -615,7 +615,8 @@ void task_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st)
 		.sum_exec_runtime = p->se.sum_exec_runtime,
 	};
 
-	task_cputime(p, &cputime.utime, &cputime.stime);
+	if (task_cputime(p, &cputime.utime, &cputime.stime))
+		cputime.sum_exec_runtime = task_sched_runtime(p);
 	cputime_adjust(&cputime, &p->prev_cputime, ut, st);
 }
 EXPORT_SYMBOL_GPL(task_cputime_adjusted);
@@ -828,19 +829,21 @@ u64 task_gtime(struct task_struct *t)
  * add up the pending nohz execution time since the last
  * cputime snapshot.
  */
-void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
+bool task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 {
 	struct vtime *vtime = &t->vtime;
 	unsigned int seq;
 	u64 delta;
+	int ret;
 
 	if (!vtime_accounting_enabled()) {
 		*utime = t->utime;
 		*stime = t->stime;
-		return;
+		return false;
 	}
 
 	do {
+		ret = false;
 		seq = read_seqcount_begin(&vtime->seqcount);
 
 		*utime = t->utime;
@@ -850,6 +853,7 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 		if (vtime->state < VTIME_SYS)
 			continue;
 
+		ret = true;
 		delta = vtime_delta(vtime);
 
 		/*
@@ -861,6 +865,8 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 		else
 			*utime += vtime->utime + delta;
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
+
+	return ret;
 }
 
 static int vtime_state_fetch(struct vtime *vtime, int cpu)
-- 
2.25.1

