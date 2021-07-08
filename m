Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3FB3BF860
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 12:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhGHK32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 06:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhGHK31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 06:29:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D84C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 03:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W6daYrP8Mv2FprAvKbzd+kl8kAFrmodDnM6Y2UgE6zs=; b=LGrhXEsYfyPCIkU5Lhlbt3mzrD
        nPYY0+/5sDwdJPwG58wKYZPDFGLezlg3zHxn8fC4X3clhB6TD7fcQI8ou1fBX3dbf/J/t3rvbukOl
        Jlk8J5GTwtFNI/Qn61q3yjZCkgeANb9diAjzU1EmawY5VRwYW5GLcZg2w5m4tn3Yh0lfk4T1jgd09
        vNpmcNWlNz1F3q6eYZ1G3AgY4efkh1EOiaFcadjeyFYhOy/fDXK/2vm76Bg8g3Z3tQUwYbctOAATS
        lIBq5OWzvWmi3/ANeFHSyUgpwtA//2HzRLJhRzJijJheD0u5ipDoytUBjn3Lv2VhnUJdHrwb2xlhY
        +uwvrPcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1REo-00FbhV-EJ; Thu, 08 Jul 2021 10:26:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A059300233;
        Thu,  8 Jul 2021 12:26:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 384992CB6EA9B; Thu,  8 Jul 2021 12:26:33 +0200 (CEST)
Date:   Thu, 8 Jul 2021 12:26:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bristot@redhat.com, bsegall@google.com,
        mgorman@suse.de, Mark Simmons <msimmons@redhat.com>
Subject: Re: [PATCH] sched/rt: Fix double enqueue caused by rt_effective_prio
Message-ID: <YObS2Rudg4osS7Ic@hirez.programming.kicks-ass.net>
References: <20210701091431.256457-1-juri.lelli@redhat.com>
 <YObOIwH7MbfagklQ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YObOIwH7MbfagklQ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 12:06:27PM +0200, Peter Zijlstra wrote:
> Slightly larger patch, but perhaps a little cleaner.. still pondering if
> we can share a little more between __sched_setscheduler() and
> rt_mutex_setprio().

Best I can seem to come up with...

---
 kernel/sched/core.c | 45 +++++++++++++++++----------------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ede10642612c..c686f0c70656 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6341,6 +6341,18 @@ int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flag
 }
 EXPORT_SYMBOL(default_wake_function);
 
+static void __setscheduler_prio(struct task_struct *p, int prio)
+{
+	if (dl_prio(prio))
+		p->sched_class = &dl_sched_class;
+	else if (rt_prio(prio))
+		p->sched_class = &rt_sched_class;
+	else
+		p->sched_class = &fair_sched_class;
+
+	p->prio = prio;
+}
+
 #ifdef CONFIG_RT_MUTEXES
 
 static inline int __rt_effective_prio(struct task_struct *pi_task, int prio)
@@ -6456,22 +6468,19 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 		} else {
 			p->dl.pi_se = &p->dl;
 		}
-		p->sched_class = &dl_sched_class;
 	} else if (rt_prio(prio)) {
 		if (dl_prio(oldprio))
 			p->dl.pi_se = &p->dl;
 		if (oldprio < prio)
 			queue_flag |= ENQUEUE_HEAD;
-		p->sched_class = &rt_sched_class;
 	} else {
 		if (dl_prio(oldprio))
 			p->dl.pi_se = &p->dl;
 		if (rt_prio(oldprio))
 			p->rt.timeout = 0;
-		p->sched_class = &fair_sched_class;
 	}
 
-	p->prio = prio;
+	__setscheduler_prio(p, prio);
 
 	if (queued)
 		enqueue_task(rq, p, queue_flag);
@@ -6824,29 +6833,6 @@ static void __setscheduler_params(struct task_struct *p,
 	set_load_weight(p, true);
 }
 
-/* Actually do priority change: must hold pi & rq lock. */
-static void __setscheduler(struct rq *rq, struct task_struct *p,
-			   const struct sched_attr *attr, int newprio)
-{
-	/*
-	 * If params can't change scheduling class changes aren't allowed
-	 * either.
-	 */
-	if (attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)
-		return;
-
-	__setscheduler_params(p, attr);
-
-	p->prio = newprio;
-
-	if (dl_prio(p->prio))
-		p->sched_class = &dl_sched_class;
-	else if (rt_prio(p->prio))
-		p->sched_class = &rt_sched_class;
-	else
-		p->sched_class = &fair_sched_class;
-}
-
 /*
  * Check the target process has a UID that matches the current process's:
  */
@@ -7089,7 +7075,10 @@ static int __sched_setscheduler(struct task_struct *p,
 
 	prev_class = p->sched_class;
 
-	__setscheduler(rq, p, attr, newprio);
+	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
+		__setscheduler_params(p, attr);
+		__setscheduler_prio(p, newprio);
+	}
 	__setscheduler_uclamp(p, attr);
 
 	if (queued) {
