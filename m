Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E00362513
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbhDPQCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239082AbhDPQCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:02:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9CE8610FA;
        Fri, 16 Apr 2021 16:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618588899;
        bh=0kkU6ruB+B5tmqdmpmWo8MqCwanloOcftf2AY9LU19A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Z3qaaMpexJDlMAhHgb5Njui7vwklUTOGVJDyAJ/o8Q671qw1wV7RK02mGGVHAtTsB
         7tbV00OIajmG7Jr9eAuBRMIWGStPAw6Tm9Jam8dGORZNGkezePlmCLuC5MAUIPjl1w
         GDbcLEOGMHBI1F/3zxesbC/eB/Rj8Oi6jlJM/ejJ94paz7DNhgJEXBjFePC5O6JvtE
         tNtuSY9FcnGCO3N2EX2rpQvUQ1OPa/QgYfL3+FLYjbrf9kYj7ENq99vPnm8ze2BVYv
         9/56T6dVNXk4JddiKlQZpJjKL86imt1d2cDv/RZ2QBkcKsulSEZl2Ah/bM6rBO6phe
         H1KdUfHrs7rXw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8877E5C0253; Fri, 16 Apr 2021 09:01:39 -0700 (PDT)
Date:   Fri, 16 Apr 2021 09:01:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: liburcu: LTO breaking rcu_dereference on arm64 and possibly
 other architectures ?
Message-ID: <20210416160139.GF4212@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
 <YHmqd3BHwVmaUZHX@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHmqd3BHwVmaUZHX@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 05:17:11PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 16, 2021 at 10:52:16AM -0400, Mathieu Desnoyers wrote:
> > Hi Paul, Will, Peter,
> > 
> > I noticed in this discussion https://lkml.org/lkml/2021/4/16/118 that LTO
> > is able to break rcu_dereference. This seems to be taken care of by
> > arch/arm64/include/asm/rwonce.h on arm64 in the Linux kernel tree.
> > 
> > In the liburcu user-space library, we have this comment near rcu_dereference() in
> > include/urcu/static/pointer.h:
> > 
> >  * The compiler memory barrier in CMM_LOAD_SHARED() ensures that value-speculative
> >  * optimizations (e.g. VSS: Value Speculation Scheduling) does not perform the
> >  * data read before the pointer read by speculating the value of the pointer.
> >  * Correct ordering is ensured because the pointer is read as a volatile access.
> >  * This acts as a global side-effect operation, which forbids reordering of
> >  * dependent memory operations. Note that such concern about dependency-breaking
> >  * optimizations will eventually be taken care of by the "memory_order_consume"
> >  * addition to forthcoming C++ standard.
> > 
> > (note: CMM_LOAD_SHARED() is the equivalent of READ_ONCE(), but was introduced in
> > liburcu as a public API before READ_ONCE() existed in the Linux kernel)
> > 
> > Peter tells me the "memory_order_consume" is not something which can be used today.
> > Any information on its status at C/C++ standard levels and implementation-wise ?

Actually, you really can use memory_order_consume.  All current
implementations will compile it as if it was memory_order_acquire.
This will work correctly, but may be slower than you would like on ARM,
PowerPC, and so on.

On things like x86, the penalty is forgone optimizations, so less
of a problem there.

> > Pragmatically speaking, what should we change in liburcu to ensure we don't generate
> > broken code when LTO is enabled ? I suspect there are a few options here:
> > 
> > 1) Fail to build if LTO is enabled,
> > 2) Generate slower code for rcu_dereference, either on all architectures or only
> >    on weakly-ordered architectures,
> > 3) Generate different code depending on whether LTO is enabled or not. AFAIU this would only
> >    work if every compile unit is aware that it will end up being optimized with LTO. Not sure
> >    how this could be done in the context of user-space.
> > 4) [ Insert better idea here. ]

Use memory_order_consume if LTO is enabled.  That will work now, and
might generate good code in some hoped-for future.

> > Thoughts ?
> 
> Using memory_order_acquire is safe; and is basically what Will did for
> ARM64.
> 
> The problematic tranformations are possible even without LTO, although
> less likely due to less visibility, but everybody agrees they're
> possible and allowed.
> 
> OTOH we do not have a positive sighting of it actually happening (I
> think), we're all just being cautious and not willing to debug the
> resulting wreckage if it does indeed happen.

And yes, you can also use memory_order_acquire.

							Thanx, Paul
