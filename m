Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588B738143F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 01:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhENXaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 19:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhENXaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 19:30:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A17C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 16:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y7a4SPe0zvQusCzCY460lWb6jydd+fit/blMzKvdMtY=; b=fFD3j5tDAADVDM6U8lQRsZnwZd
        BEV6+WXlHvbB+KgdcKbxcXXUEO+QQ6Hdw4e22m/fb/6PxVfuEV4oRWQurWlj9psrjboLQXV8Cj2h+
        MKsALrov2k94d1MWPotknby8nlqbqAjm9oqgETBXZyeqkA3QOMd/TkvfarIBiEKkJjfIIMBgIRgsw
        JWeIt2j2odZZT1M0FBm0oGmO+NJNltSipJ0EbedGyX0qWm+lddg7fZqgyiIa/7gBVSjvemO6fbaYk
        E7aZOQfulnhpIL04VlW7uCjLVb/xt+4LQcZTk4+xOleHPHgjfmIxuFizMWE1GJGc1mniepFOYgJ0c
        hks38/MA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhhEW-00Ap2Q-JW; Fri, 14 May 2021 23:28:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 412743001E1;
        Sat, 15 May 2021 01:28:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 297C7200C6D64; Sat, 15 May 2021 01:28:39 +0200 (CEST)
Date:   Sat, 15 May 2021 01:28:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [patch 7/8] hrtimer: Avoid unnecessary SMP function calls in
 clock_was_set()
Message-ID: <YJ8Hp0gTGwugxxFM@hirez.programming.kicks-ass.net>
References: <20210427082537.611978720@linutronix.de>
 <20210427083724.732437214@linutronix.de>
 <YJ0+6vfkC+LTPkkw@hirez.programming.kicks-ass.net>
 <87bl9d407i.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl9d407i.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 08:52:33PM +0200, Thomas Gleixner wrote:
> On Thu, May 13 2021 at 16:59, Peter Zijlstra wrote:
> > On Tue, Apr 27, 2021 at 10:25:44AM +0200, Thomas Gleixner wrote:
> >> -	/* Retrigger the CPU local events everywhere */
> >> -	on_each_cpu(retrigger_next_event, NULL, 1);
> >> +	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
> >> +		on_each_cpu(retrigger_next_event, NULL, 1);
> >
> > This will violate NOHZ_FULL;
> 
> Only if that allocation fails.

Right, which should be near to never I suppose.

> Aside of that any CPU which has an affected timer will get notified even
> on NOHZ_FULL.

Right; but if it's properly NOHZ_FULL -- the kind that wanted a signal
on any entry into the kernel -- when it won't have timers and this IPI
will trigger the signal and kill the program.

But yeah, you're right, that's not very likely.


> >> +	preempt_disable();
> >> +	smp_call_function_many(mask, retrigger_next_event, NULL, 1);
> >
> > The sane option is:
> >
> > 	smp_call_function_many_cond(cpu_online_mask, retrigger_next_event,
> > 				    NULL, SCF_WAIT, update_needs_ipi);
> >
> > Which does all of the above, but better.
> 
> With the difference that the for_each_cpu() loop runs with preemption
> disabled, while with this approach preemption is only disabled accross
> the function call.

Yeah, I'd forgotten that... I might put looking at that on the todo list
somewhere :/
