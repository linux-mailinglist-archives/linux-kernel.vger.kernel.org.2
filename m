Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028B0365B16
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhDTOYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhDTOYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:24:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23AAC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 07:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HaQi9MTF9iUS9s/cCVbzybU/c0rgI9mA1EokPCwprLs=; b=PKWOQ9NIzA1G9YK9bNNrePGSmR
        6UtPw6+9qmURcyuh0Ef4feQmDnGBeQM80C31f+eDaQ9u9q0ozy7vFUiT1TCKD87jMgTBCLSP51g3K
        drVnn4nMNrDavs0Uv829E23z8NJemJAE7bfhLvxKzE8A5QYus/S2G2pkpKEtKuDu+ILCqLVSrQz6W
        n6WvpTXhZMxTil/ac8rC+dfowKjpM7Doe6kuUuR3zQluXj7bsoGQbge7xUTtE8ABuDUeJBbh/Aid9
        iy5gmSSoYux43UcC7R5shWFxCQ4jbzO3wCTzz21wnbzLZuswahx3XMgGHPr/rH/pd13fyEi6FFK1j
        N5S9zsDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYrFK-00FGAG-Nu; Tue, 20 Apr 2021 14:21:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC05430018E;
        Tue, 20 Apr 2021 16:20:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 970A82BCEDE78; Tue, 20 Apr 2021 16:20:56 +0200 (CEST)
Date:   Tue, 20 Apr 2021 16:20:56 +0200
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
Message-ID: <YH7jSPZx0BhyHoLe@hirez.programming.kicks-ass.net>
References: <20210310145258.899619710@infradead.org>
 <20210310150109.259726371@infradead.org>
 <871rclu3jz.mognet@e113632-lin.i-did-not-set--mail-host-address--so-tickle-me>
 <YHQ3Iy7QfL+0UoM0@hirez.programming.kicks-ass.net>
 <87r1jfmn8d.mognet@arm.com>
 <YHU/a9HvGLYpOLKZ@hirez.programming.kicks-ass.net>
 <YHgAYef83VQhKdC2@hirez.programming.kicks-ass.net>
 <87a6pzmxec.mognet@arm.com>
 <20210419105541.GA40111@e120877-lin.cambridge.arm.com>
 <20210420094632.GA165360@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420094632.GA165360@e120877-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 10:46:33AM +0100, Vincent Donnefort wrote:

> Found the issue:
> 
> $ cat hotplug/states:
> 219: sched:active
> 220: online
> 
> CPU0: 
> 
> $ echo 219 > hotplug/fail
> $ echo 0 > online
> 
> => cpu_active = 1 cpu_dying = 1
> 
> which means that later on, for another CPU hotunplug, in
> __balance_push_cpu_stop(), the fallback rq for a kthread can select that
> CPU0, but __migrate_task() would fail and we end-up in an infinite loop,
> trying to migrate that task to CPU0.
> 
> The problem is that for a failure in sched:active, as "online" has no callback,
> there will be no call to cpuhp_invoke_callback(). Hence, the cpu_dying bit would
> not be reset.

Urgh! Good find.

> Maybe cpuhp_reset_state() and cpuhp_set_state() would then be a better place to
> switch the dying bit?

Yes, except now cpuhp_invoke_ap_callback() makes my head hurt, that runs
the callbacks out of order. I _think_ we can ignore it, but ....

Something like the below, let me see if I can reproduce and test.

---
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 838dcf238f92..05272bae953d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -160,9 +160,6 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 	int (*cb)(unsigned int cpu);
 	int ret, cnt;
 
-	if (cpu_dying(cpu) != !bringup)
-		set_cpu_dying(cpu, !bringup);
-
 	if (st->fail == state) {
 		st->fail = CPUHP_INVALID;
 		return -EAGAIN;
@@ -467,13 +464,16 @@ static inline enum cpuhp_state
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
+	if (cpu_dying(cpu) != !bringup)
+		set_cpu_dying(cpu, !bringup);
 
 	return prev_state;
 }
@@ -481,6 +481,8 @@ cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
 static inline void
 cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
 {
+	bool bringup = !st->bringup;
+
 	st->target = prev_state;
 
 	/*
@@ -503,7 +505,9 @@ cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
 			st->state++;
 	}
 
-	st->bringup = !st->bringup;
+	st->bringup = bringup;
+	if (cpu_dying(cpu) != !bringup)
+		set_cpu_dying(cpu, !bringup);
 }
 
 /* Regular hotplug invocation of the AP hotplug thread */
