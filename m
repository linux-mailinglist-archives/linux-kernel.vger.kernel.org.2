Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A851A35D83D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 08:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbhDMGwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbhDMGw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:52:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC55C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tEmP1NyP2fvLf3bqP4WDnCtXUH8t5KQQ1jISAOSshIY=; b=Mka9RpSFh2TtFKPYxVBmWRfLDM
        lBTeJBBo638QACtz+F0E2X8BKPUy+Sdo2pbNEcf3DynRA4K4fcxIXnUt5qEWzfnlwYTgtuEvTtbKz
        0V6eIbFdW7YqmnSop8Y3YQecxkPkmLO0G3LbXRuAKoahk5VFAuNyi41Mj0gr5tJBztcZbgt3keD4q
        AG3X2tK2L6IVsXVuHh4KOUfEy+dp4fTBMVUa16QoQx9KSsWvRgoICW6WUSqLaWgNHA6K1ST6Yk/4w
        6KBHTm/nYfUyE/AKy1228Ty8+AMfW2Au6w2IEu7WcgcweEwoHYCVjao/9P6CTpXurf3jtYpWRmXzd
        06R5PZyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWCtR-008R0J-HT; Tue, 13 Apr 2021 06:51:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 126EE300036;
        Tue, 13 Apr 2021 08:51:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9B89200CF8CA; Tue, 13 Apr 2021 08:51:23 +0200 (CEST)
Date:   Tue, 13 Apr 2021 08:51:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, qais.yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched: Use cpu_dying() to fix balance_push vs
 hotplug-rollback
Message-ID: <YHU/a9HvGLYpOLKZ@hirez.programming.kicks-ass.net>
References: <20210310145258.899619710@infradead.org>
 <20210310150109.259726371@infradead.org>
 <871rclu3jz.mognet@e113632-lin.i-did-not-set--mail-host-address--so-tickle-me>
 <YHQ3Iy7QfL+0UoM0@hirez.programming.kicks-ass.net>
 <87r1jfmn8d.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1jfmn8d.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 06:22:42PM +0100, Valentin Schneider wrote:
> On 12/04/21 14:03, Peter Zijlstra wrote:
> > On Thu, Mar 11, 2021 at 03:13:04PM +0000, Valentin Schneider wrote:
> >> Peter Zijlstra <peterz@infradead.org> writes:
> >> > @@ -7910,6 +7908,14 @@ int sched_cpu_deactivate(unsigned int cp
> >> >    }
> >> >    rq_unlock_irqrestore(rq, &rf);
> >> >
> >> > +	/*
> >> > +	 * From this point forward, this CPU will refuse to run any task that
> >> > +	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively
> >> > +	 * push those tasks away until this gets cleared, see
> >> > +	 * sched_cpu_dying().
> >> > +	 */
> >> > +	balance_push_set(cpu, true);
> >> > +
> >>
> >> AIUI with cpu_dying_mask being flipped before even entering
> >> sched_cpu_deactivate(), we don't need this to be before the
> >> synchronize_rcu() anymore; is there more than that to why you're punting it
> >> back this side of it?
> >
> > I think it does does need to be like this, we need to clearly separate
> > the active=true and balance_push_set(). If we were to somehow observe
> > both balance_push_set() and active==false, we'd be in trouble.
> >
> 
> I'm afraid I don't follow; we're replacing a read of rq->balance_push with
> cpu_dying(), and those are still written on the same side of the
> synchronize_rcu(). What am I missing?

Yeah, I'm not sure anymnore either; I tried to work out why I'd done
that but upon closer examination everything fell flat.

Let me try again today :-)

> Oooh, I can't read, only the boot CPU gets its callback uninstalled in
> sched_init()! So secondaries keep push_callback installed up until
> sched_cpu_activate(), but as you said it's not effective unless a rollback
> happens.
> 
> Now, doesn't that mean we should *not* uninstall the callback in
> sched_cpu_dying()? AFAIK it's possible for the initial secondary CPU
> boot to go fine, but the next offline+online cycle fails while going up -
> that would need to rollback with push_callback installed.

Quite; I removed that shortly after sending this; when I tried to write
a comment and found it.
