Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4C53EED31
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbhHQNSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:18:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60492 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237615AbhHQNSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:18:17 -0400
Date:   Tue, 17 Aug 2021 15:17:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629206263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u3bt7TzW/938vZc/Mx6WF9QB04VmQHL6ysb80Oa7dCU=;
        b=rHUhQGamZA/XTF2+yWTJCtSqxRY02aDK/gmO1rKZenVH8IIhpft/EML9N9ceMRauqsMAZk
        O5hgHIWwc+HG1c6Y5isAvJ+wTTm/HQ8rOAtuepIY4nS6GEUxcJIdFGpNftqy+EjtammeQw
        B+5C8NUtjBHwgN21ooH0vigZvij79Dzacvr/kIrF2hHT5T/xA4CamQ5hGrK1tjcMpNtZGc
        iuGKJsto9RL9OfBxa2BIr1EJKy2I645Inp39ilJJHAgQ64cnO2sy07mDsY43uAVHpXpbjn
        Ja3r5Dn7hq/edYQr8jUnAKceBjjJHk283doB1mlO2ydOQycIJ0NJY4a1fg2APA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629206263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u3bt7TzW/938vZc/Mx6WF9QB04VmQHL6ysb80Oa7dCU=;
        b=e/qbVWtUO9Hb0fF4J3nTit/oOj4iNHDmmURhYHc471ibAr9MAo7vRtYus6cs0WDOgUMRkU
        H5zJq8vhbw4FrxDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v3 1/4] rcutorture: Don't disable softirqs with
 preemption disabled when PREEMPT_RT
Message-ID: <20210817131741.evduh4fw7vyv2dzt@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-2-valentin.schneider@arm.com>
 <20210817121345.5iyj5epemczn3a52@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210817121345.5iyj5epemczn3a52@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-17 14:13:47 [+0200], To Valentin Schneider wrote:
> > index eecd1caef71d..4f3db1d3170d 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -1548,6 +1548,8 @@ rcutorture_extend_mask(int oldmask, struct tortur=
e_random_state *trsp)
> >  	 * them on non-RT.
> >  	 */
> >  	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > +		/* Can't disable bh in atomic context under PREEMPT_RT */
> > +		mask &=3D ~(RCUTORTURE_RDR_ATOM_BH | RCUTORTURE_RDR_ATOM_RBH);
>=20
> Let me stare at this=E2=80=A6

I would fold this

--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1549,6 +1549,13 @@ rcutorture_extend_mask(int oldmask, stru
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		/*
+		 * Can't disable bh in atomic context if bh was already
+		 * disabled by another task on the same CPU. Instead of
+		 * attempting to track this, just avoid disabling bh in atomic
+		 * context.
+		 */
+		mask &=3D ~atomic_bhs;
+		/*
 		 * Can't release the outermost rcu lock in an irq disabled
 		 * section without preemption also being disabled, if irqs
 		 * had ever been enabled during this RCU critical section
@@ -1559,16 +1566,6 @@ rcutorture_extend_mask(int oldmask, stru
 		    !(mask & preempts))
 			mask |=3D RCUTORTURE_RDR_RCU;
=20
-		/* Can't modify atomic bh in non-atomic context */
-		if ((oldmask & atomic_bhs) && (mask & atomic_bhs) &&
-		    !(mask & preempts_irq)) {
-			mask |=3D oldmask & preempts_irq;
-			if (mask & RCUTORTURE_RDR_IRQ)
-				mask |=3D oldmask & tmp;
-		}
-		if ((mask & atomic_bhs) && !(mask & preempts_irq))
-			mask |=3D RCUTORTURE_RDR_PREEMPT;
-
 		/* Can't modify non-atomic bh in atomic context */
 		tmp =3D nonatomic_bhs;
 		if (oldmask & preempts_irq)

into the original patch and forward it upstream=E2=80=A6

Sebastian
