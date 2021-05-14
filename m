Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B26D380C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhENOpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhENOpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:45:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D333BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xHFnkk4XPlDxbE7l0rSbNKnkGQ/l0om42MVwwLN12jw=; b=K5vDcuRpc7qoSGMzGpY3rOUpZ9
        mcPHozFdl6h61cdDAS6oay100Zi5PmM8K/SEymZ6FNQ7pRPnnq7qq823GPpj7/zpJuiUduGM2VKPF
        6h+EXDeNv/esqzmAoNQYTy245uSXKtD83zVrDMSA8l8o6xWNEjCz8OacL78vW808CtT9NiVTN7GUG
        lrgeIslp/6wKp8AgnJ3otP9vvi4sOty6L2t+NHXflY6lSPW0MATuXgGl30Grc4hMYfskM7X8XPEQu
        Af169cbB+bC8WMOYHeudl4BfvpeZ0SkoI2fKPpqwHyJOxcQsJZb6GO1H643VlMsYLyv4B5QzJDtOR
        nrHR3L8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhZ32-008KXU-Fu; Fri, 14 May 2021 14:44:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1D5B130022A;
        Fri, 14 May 2021 16:44:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C57BD2B816063; Fri, 14 May 2021 16:44:14 +0200 (CEST)
Date:   Fri, 14 May 2021 16:44:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        ak@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        luto@amacapital.net, eranian@google.com, namhyung@kernel.org
Subject: Re: [PATCH V7 2/2] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
Message-ID: <YJ6MvvtovR6adufW@hirez.programming.kicks-ass.net>
References: <1620915782-50154-1-git-send-email-kan.liang@linux.intel.com>
 <1620915782-50154-2-git-send-email-kan.liang@linux.intel.com>
 <YJ0/bjek1ihh/2Ea@hirez.programming.kicks-ass.net>
 <de8b7f48-9242-c28f-ebaa-5c5137e6c102@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de8b7f48-9242-c28f-ebaa-5c5137e6c102@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 06:14:08PM -0400, Liang, Kan wrote:
> On 5/13/2021 11:02 AM, Peter Zijlstra wrote:
> > On Thu, May 13, 2021 at 07:23:02AM -0700, kan.liang@linux.intel.com wrote:
> > 
> > > +	if (x86_pmu.sched_task && event->hw.target) {
> > > +		atomic_inc(&event->pmu->sched_cb_usage);
> > > +		local_irq_save(flags);
> > > +		x86_pmu_clear_dirty_counters();
> > > +		local_irq_restore(flags);
> > > +	}
> > 
> > So what happens if our mmap() happens after we've already created two
> > (or more) threads in the process, all of who already have a counter (or
> > more) on?
> > 
> > Shouldn't this be something like?
> 
> That's not enough.
> 
> I implemented a test case as below:
> - The main thread A creates a new thread B.
> - Bind the thread A to CPU 0. Then the thread A opens a event, mmap, enable
> the event, and sleep.
> - Bind the thread B to CPU 1. Wait until the event in the thread A is
> enabled. Then RDPMC can read the counters on CPU 1.

This?

	A				B

	clone(CLONE_THREAD) --->	
	set_affine(0)
					set_affine(1)
					while (!event-enabled)
						;
	event = perf_event_open()
	mmap(event)
	ioctl(event, IOC_ENABLE); --->
					RDPMC

	sleep(n)
	  schedule(INTERRUPTIBLE)
	  /* idle */


> In the x86_pmu_event_mapped(), we do on_each_cpu_mask(mm_cpumask(mm),
> cr4_update_pce, NULL, 1);
> The RDPMC from thread B on CPU 1 is not forbidden.
> Since the counter is not created in thread B, the sched_task() never gets a
> chance to be invoked. The dirty counter is not cleared.

Per-task counters from CPU1 that ran before B ran?

> To fix it, I think we have to move the cr4_update_pce() to the context
> switch, and update it only when the RDPMC task is scheduled. But it probably
> brings some overhead.

We have CR4:PCE updates in the context switch path, see
switch_mm_irqs_off() -> cr4_update_pce_mm().

Doing the clear there might actually make sense and avoids this frobbing
of ->sched_task(). When we call cr4_update_pce_mm(), and @mm has rdpmc
on, clear dirty or something like that.

Worth a try.


