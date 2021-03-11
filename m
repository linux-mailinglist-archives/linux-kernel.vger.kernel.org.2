Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4483379C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhCKQn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhCKQn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:43:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3579C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5BEgHPKkD8RrihWjfK9Erdgnj54632jc0KBx8eAembs=; b=IzH9+ClqSCbQumC6CAaqAkNX3Y
        uQLsgKB9rk16+mUSOdJGTR6NGN+gTyGBdf70be1u3K+YdYiq1286MSAhpq4ZWrz4A1sqGQ9XjnTSP
        jC8bgkU+06tynOH0r9J2Tb/bkvZazm8JJaSkHUgbg11sIN+YdFP8ezGlxaNHzEOPXdGkvCfmJs7vD
        4NNYjoaR+dMOq1MK+hab7LHfLUyP8+7F6PXNi/Y4hEJIiijO8FNqkug/SJdvePejGpHYUJHdB7S3O
        GQ3tGf0I7EMGKHnDcmhGHj+Fa1zd+Lw074qpNvAL4dGmo9+AZp9F1iYzTQAF9DcNF7sf8iJ0hRcK+
        9Simsf8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKOOd-007nBm-S4; Thu, 11 Mar 2021 16:42:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 065C63010CF;
        Thu, 11 Mar 2021 17:42:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DFCEB29CB84C4; Thu, 11 Mar 2021 17:42:46 +0100 (CET)
Date:   Thu, 11 Mar 2021 17:42:46 +0100
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
Message-ID: <YEpIhliozfznj9rY@hirez.programming.kicks-ass.net>
References: <20210310145258.899619710@infradead.org>
 <20210310150109.259726371@infradead.org>
 <871rclu3jz.mognet@e113632-lin.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rclu3jz.mognet@e113632-lin.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 03:13:04PM +0000, Valentin Schneider wrote:

> >  #ifdef CONFIG_SCHED_SMT
> >  	/*
> >  	 * When going down, decrement the number of cores with SMT present.
> 
> > @@ -8206,7 +8212,7 @@ void __init sched_init(void)
> >  		rq->sd = NULL;
> >  		rq->rd = NULL;
> >  		rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
> > -		rq->balance_callback = NULL;
> > +		rq->balance_callback = &balance_push_callback;
> >  		rq->active_balance = 0;
> >  		rq->next_balance = jiffies;
> >  		rq->push_cpu = 0;
> > @@ -8253,6 +8259,7 @@ void __init sched_init(void)
> >  
> >  #ifdef CONFIG_SMP
> >  	idle_thread_set_boot_cpu();
> > +	balance_push_set(smp_processor_id(), false);
> >  #endif
> >  	init_sched_fair_class();
> >
> 
> I don't get what these two changes do - the end result is the same as
> before, no?

IIRC the idea was to initialize the offline CPUs to the same state as if
they'd been offlined.
