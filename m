Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE24365B97
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhDTO6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhDTO6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:58:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FE8C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4rDP3NIwCgKvJ81KQixmdbRgXZLMqSCXAWe05pIrqdc=; b=TNGV6fsCBFXhWgPKMaZikEODsi
        dxM2XJk4LBOd3iUYjxX0Bmz7d6Yi6jTG4sTMRmqxqEJHHUB9QciC3D7SpcpyM3jqfXqt5SfXoYSQr
        Yt6WLaBdNO22Un92BYQny+LIlZVpQBHCfvN2JAkFH/4lF6VpNi6LYPHhJAyoWmd9GwrMsLSYA3b9L
        7VgVr+lAEagBu1aSwTUW0aCLw/l3ZOWISDE60WyQ4V/Vu8GL3w7WSdjorf+DGD7j1UR9LxbW1LqYI
        Jk/Q4MMtbwmH/J6QcqLW5NvBdZtwL1CtnNDWF0Yd7/8DAXZhZoAW1cBjMDUs8aZIMkHcSx7VOlZVt
        kTMRXutA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYrpB-00CP1k-4U; Tue, 20 Apr 2021 14:58:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C86B30018E;
        Tue, 20 Apr 2021 16:58:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B3C72BCEDE6D; Tue, 20 Apr 2021 16:58:00 +0200 (CEST)
Date:   Tue, 20 Apr 2021 16:58:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, qais.yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched: Use cpu_dying() to fix balance_push vs
 hotplug-rollback
Message-ID: <YH7r+AoQEReSvxBI@hirez.programming.kicks-ass.net>
References: <871rclu3jz.mognet@e113632-lin.i-did-not-set--mail-host-address--so-tickle-me>
 <YHQ3Iy7QfL+0UoM0@hirez.programming.kicks-ass.net>
 <87r1jfmn8d.mognet@arm.com>
 <YHU/a9HvGLYpOLKZ@hirez.programming.kicks-ass.net>
 <YHgAYef83VQhKdC2@hirez.programming.kicks-ass.net>
 <87a6pzmxec.mognet@arm.com>
 <20210419105541.GA40111@e120877-lin.cambridge.arm.com>
 <20210420094632.GA165360@e120877-lin.cambridge.arm.com>
 <YH7jSPZx0BhyHoLe@hirez.programming.kicks-ass.net>
 <YH7niBZDWjsz+jBa@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH7niBZDWjsz+jBa@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 04:39:04PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 20, 2021 at 04:20:56PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 20, 2021 at 10:46:33AM +0100, Vincent Donnefort wrote:
> > 
> > > Found the issue:
> > > 
> > > $ cat hotplug/states:
> > > 219: sched:active
> > > 220: online
> > > 
> > > CPU0: 
> > > 
> > > $ echo 219 > hotplug/fail
> > > $ echo 0 > online
> > > 
> > > => cpu_active = 1 cpu_dying = 1
> > > 
> > > which means that later on, for another CPU hotunplug, in
> > > __balance_push_cpu_stop(), the fallback rq for a kthread can select that
> > > CPU0, but __migrate_task() would fail and we end-up in an infinite loop,
> > > trying to migrate that task to CPU0.
> > > 
> > > The problem is that for a failure in sched:active, as "online" has no callback,
> > > there will be no call to cpuhp_invoke_callback(). Hence, the cpu_dying bit would
> > > not be reset.
> > 
> > Urgh! Good find.

> I seem to have triggered the BUG() in select_fallback_rq() with your recipie.
> Have cpu0 fail on sched:active, then offline all other CPUs.
> 
> Now lemme add that patch.

(which obviously didn't actually build) seems to fix it.

---
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 838dcf238f92..e538518556f4 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -63,6 +63,7 @@ struct cpuhp_cpu_state {
 	bool			rollback;
 	bool			single;
 	bool			bringup;
+	int			cpu;
 	struct hlist_node	*node;
 	struct hlist_node	*last;
 	enum cpuhp_state	cb_state;
@@ -160,9 +161,6 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 	int (*cb)(unsigned int cpu);
 	int ret, cnt;
 
-	if (cpu_dying(cpu) != !bringup)
-		set_cpu_dying(cpu, !bringup);
-
 	if (st->fail == state) {
 		st->fail = CPUHP_INVALID;
 		return -EAGAIN;
@@ -467,13 +465,16 @@ static inline enum cpuhp_state
 cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
 {
 	enum cpuhp_state prev_state = st->state;
+	bool bringup = st->state < target;
 
 	st->rollback = false;
 	st->last = NULL;
 
 	st->target = target;
 	st->single = false;
-	st->bringup = st->state < target;
+	st->bringup = bringup;
+	if (cpu_dying(st->cpu) != !bringup)
+		set_cpu_dying(st->cpu, !bringup);
 
 	return prev_state;
 }
@@ -481,6 +482,8 @@ cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
 static inline void
 cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
 {
+	bool bringup = !st->bringup;
+
 	st->target = prev_state;
 
 	/*
@@ -503,7 +506,9 @@ cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
 			st->state++;
 	}
 
-	st->bringup = !st->bringup;
+	st->bringup = bringup;
+	if (cpu_dying(st->cpu) != !bringup)
+		set_cpu_dying(st->cpu, !bringup);
 }
 
 /* Regular hotplug invocation of the AP hotplug thread */
@@ -693,6 +698,7 @@ static void cpuhp_create(unsigned int cpu)
 
 	init_completion(&st->done_up);
 	init_completion(&st->done_down);
+	st->cpu = cpu;
 }
 
 static int cpuhp_should_run(unsigned int cpu)
