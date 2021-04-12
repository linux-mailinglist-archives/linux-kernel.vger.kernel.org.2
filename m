Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1382535C4CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbhDLLRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:17:22 -0400
Received: from foss.arm.com ([217.140.110.172]:47202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237930AbhDLLRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:17:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC06131B;
        Mon, 12 Apr 2021 04:17:01 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3D783F694;
        Mon, 12 Apr 2021 04:16:59 -0700 (PDT)
Date:   Mon, 12 Apr 2021 12:16:57 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     valentin.schneider@arm.com, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cpumask: Introduce DYING mask
Message-ID: <20210412111657.hu7hbaay2zxzdxm5@e107158-lin.cambridge.arm.com>
References: <20210310145258.899619710@infradead.org>
 <20210310150109.151441252@infradead.org>
 <20210321193037.7o3mqcmwjthbos7n@e107158-lin>
 <YHQnEgXFi3YAFvIP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHQnEgXFi3YAFvIP@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/21 12:55, Peter Zijlstra wrote:
> On Sun, Mar 21, 2021 at 07:30:37PM +0000, Qais Yousef wrote:
> > On 03/10/21 15:53, Peter Zijlstra wrote:
> > > --- a/kernel/cpu.c
> > > +++ b/kernel/cpu.c
> > > @@ -160,6 +160,9 @@ static int cpuhp_invoke_callback(unsigne
> > >  	int (*cb)(unsigned int cpu);
> > >  	int ret, cnt;
> > >  
> > > +	if (bringup != !cpu_dying(cpu))
> > 
> > nit: this condition is hard to read
> > 
> > > +		set_cpu_dying(cpu, !bringup);
> 
> How's:
> 
> 	if (cpu_dying(cpu) != !bringup)
> 		set_cpu_dying(cpu, !bringup);

Slightly better I suppose :)

> 
> > since cpu_dying() will do cpumask_test_cpu(), are we saving  much if we
> > unconditionally call set_cpu_dying(cpu, !bringup) which performs
> > cpumask_{set, clear}_cpu()?
> 
> This is hotplug, it's all slow, endlessly rewriting that bit shouldn't
> be a problem I suppose.

True. Beside I doubt there's a performance hit really, cpu_dying() will read
the bit in the cpumask anyway, unconditionally writing will be as fast since
both will fetch the cacheline anyway?

Regardless, not really a big deal. It's not really the hardest thing to stare
at here ;-)

Thanks

--
Qais Yousef
