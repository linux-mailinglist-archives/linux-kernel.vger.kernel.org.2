Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2F436DC4F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbhD1Ps0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhD1PsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:48:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F23C0612A6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sMGmqfmRxgnUnc7FxlxA1CjtidgVAL/oIRDORQH7Bv0=; b=a10ieGhgIH9rZOgJ2iFa8Y4NFF
        TvuEGQ9WCtL/D7LyooHtwfqBJaYIuQ81J+mJJCjAS2nyXekxS60abKKdaGd64kxko2FDpIhmJ0jV6
        hApjuCd5DUafuMaz+LqPYT8J4s+1bGkOHsj5tkgya0EHL+Z92msGo2izrEFJ2SBHZtLTPPk8DLKv0
        65vgoECY0tLoY4BOlyUaavOCo1/x9PPB9aq88aPzQq4ml+Bt7mIARZS65nqHUEzZqljwmddGbpmw+
        oLxaQFeCBDwZDdse5uG6k4kBFxOOGDv61KFl0NRihhNF0O/+VgkWve99eBSuHbifiNc2g3jt8klB6
        uafzcIyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbmHI-008TLd-C0; Wed, 28 Apr 2021 15:40:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 092E63002F1;
        Wed, 28 Apr 2021 17:39:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E46F82CEAF0D1; Wed, 28 Apr 2021 17:39:01 +0200 (CEST)
Date:   Wed, 28 Apr 2021 17:39:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     paulmck@kernel.org, Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel-team@fb.com, neeraju@codeaurora.org,
        zhengjun.xing@intel.com, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [clocksource]  8c30ace35d:
 WARNING:at_kernel/time/clocksource.c:#clocksource_watchdog
Message-ID: <YImBlV8l7bjZ7Q6G@hirez.programming.kicks-ass.net>
References: <87y2d3mo2q.ffs@nanos.tec.linutronix.de>
 <87a6pimt1f.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6pimt1f.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 03:34:52PM +0200, Thomas Gleixner wrote:


>  3) CPU does advertise X86_FEATURE_CONSTANT_TSC and X86_FEATURE_NONSTOP_TSC
> 
>     That's the point where usable starts, which is around 2007/2008
> 
>  4) CPU has X86_FEATURE_CONSTANT_TSC, X86_FEATURE_NONSTOP_TSC and
>     TSC_ADJUST
> 
>     That's anything Intel starting from Haswell - not sure about the
>     ATOM parts though.
> 
>     Non-Intel CPUs lack this completely.
> 
>  5) CPU has X86_FEATURE_CONSTANT_TSC, X86_FEATURE_NONSTOP_TSC and
>     TSC_ADJUST and the not yet existing feature TSC_LOCKDOWN
> 
>     We're asking for this for at least 15 years now, but we also had to
>     wait 10+ years to get a halfways usable TSC, so why am I
>     complaining?
> 
> So we really care about #3 and #4.
> 
> #4 is the easy case because we can check MSR_TSC_ADJUST to figure out
>    whether something has written to MSR_TSC or MSR_TSC_ADJUST and undo
>    the damage in a sane way.

This is after the fact though; userspace (and kernel space) will have
observed non-linear time and things will be broken in various subtle and
hard to tell ways.

>    That's currently only done when a CPU goes idle, but there are
>    options to do that differently (timer, TIF flag ...)
> 
>    This allows to disable the clocksource watchdog completely and based
>    on Fengs work we are going to do so sooner than later.


> The problematic case is #3 because that affects any Non-Intel CPUs
> and the pre Haswell Intel ones.

Right, no clue what to do about all them AMD machines :/

> Unfortunately there is no other way than using the watchdog mechanism,
> simply because we need hardware assistance for detection and a reliable
> way to undo the damage, which is what we have with TSC_ADJUST. Of course
> the best case would be a mechanism to prevent writes to TSC/TSC_ADJUST
> completely after boot.

Yes, we needs us that TSC_LOCKDOWN thing, across all of x86.

> Now let's look at the cases which cause TSC problems in the real world:
> 
>     1) Boot time (or resume time) TSC inconsistency
> 
>        That's the major problem today, but that's not a watchdog issue.
> 
>        On TSC_ADJUST equipped machines we fix the wreckage up, on others
>        we give up. For the latter case we don't need a watchdog :)
> 
>     2) Runtime wreckage caused by BIOS/SMM
> 
>        That used to be a wide spread problem 10 years ago and today it's
>        only a sporadic issue, but it's not eliminated completely which
>        is why we have this discussion at all.
> 
> As we have no reliable indicator whether a BIOS can be trusted and
> history taught us that it can't be trusted, we need to have this
> trainwreck until hardware people actually come to senses and fix the
> root cause once and forever.

Also, realistically, people are actually still running modern kernels on
10 year old hardware :/

> The only other option to handle this mess is to declare the watchdog
> experiment as failed, rip it out completely and emit a fat warning on
> boot when a non-trustable TSC is detected:
> 
>      HARDWARE-BUG: Untrusted TSC detected. For further information see:
>      https://www.kernel.org/doc/html/latest/admin-guide/hw-trainwrecks/tsc.html
> 
> I can live with that and maybe we should have done that 15 years ago
> instead of trying to work around it at the symptom level.

Anybody that still has runtime BIOS wreckage will then silently suffer
nonlinear time, doubly so for anybody not having TSC_ADJUST. Are we sure
we can tell them all to bugger off and buy new hardware?

At the very least we need something like tsc=broken, to explicitly mark
TSC bad on machines, so that people that see TSC fail on their current
kernels can continue to use the new kernels. This requires a whole lot
of care on the part of users though, and will raise a ruckus, because I
bet a fair number of these people are not even currently aware we're
disabling TSC for them :/
