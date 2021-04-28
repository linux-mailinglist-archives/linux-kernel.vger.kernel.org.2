Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F8A36DDBC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241432AbhD1RBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:01:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49288 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhD1RBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:01:02 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619629216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5uES+rTqUZ9pQ5unUa2AcUhQ/cbr0Z7u7rT0zVMi434=;
        b=yMXY13I8gO5OoJyetS5t4ak6Xy5OFYV+nHM+adLSa+4cb9tX0R0O5hz82iRfSnvnqaHQJI
        Z6hDhDr5n4HK+wQQ0b5XJD56Q9CLztTjrOag4reQNAZQC39hq845DlmbGMYeGcF809X0yl
        yAAOL3AhSR2heoyhdMTFybNA5uFNreXsPT4QFxHdSPafPr3ZujFYr6bhrMxoZpVBg7Wl2q
        1g9fmqfMquxeELR+EVRAJXQFFNU8e3O2g2gPPirHYqQ1gIY81WUUufJcU9G5i1pesLcc3W
        uuzxULHp4bg617srIqVWBn1rg19kwvdSLqWr/HiZX4g7ffgTAdL8tgRsVPofwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619629216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5uES+rTqUZ9pQ5unUa2AcUhQ/cbr0Z7u7rT0zVMi434=;
        b=XPSjCxz6k0LO55QbJQX5dNyBjeKy3Cxy4eecHSWjrRlqiGqkg1zPBTPsvS0mOq1/AQhsjH
        qN2yplt1kVzpavDQ==
To:     Peter Zijlstra <peterz@infradead.org>
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
Subject: Re: [clocksource]  8c30ace35d: WARNING:at_kernel/time/clocksource.c:#clocksource_watchdog
In-Reply-To: <YImBlV8l7bjZ7Q6G@hirez.programming.kicks-ass.net>
References: <87y2d3mo2q.ffs@nanos.tec.linutronix.de> <87a6pimt1f.ffs@nanos.tec.linutronix.de> <YImBlV8l7bjZ7Q6G@hirez.programming.kicks-ass.net>
Date:   Wed, 28 Apr 2021 19:00:15 +0200
Message-ID: <871raumjj4.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28 2021 at 17:39, Peter Zijlstra wrote:
> On Wed, Apr 28, 2021 at 03:34:52PM +0200, Thomas Gleixner wrote:
>> #4 is the easy case because we can check MSR_TSC_ADJUST to figure out
>>    whether something has written to MSR_TSC or MSR_TSC_ADJUST and undo
>>    the damage in a sane way.
>
> This is after the fact though; userspace (and kernel space) will have
> observed non-linear time and things will be broken in various subtle and
> hard to tell ways.

What I observed in the recent past is that _IF_ that happens it's a
small amount of cycles so it's not a given that this can be observed
accross CPUs. But yes, it's daft.

>> I can live with that and maybe we should have done that 15 years ago
>> instead of trying to work around it at the symptom level.
>
> Anybody that still has runtime BIOS wreckage will then silently suffer
> nonlinear time, doubly so for anybody not having TSC_ADJUST. Are we sure
> we can tell them all to bugger off and buy new hardware?
>
> At the very least we need something like tsc=broken, to explicitly mark
> TSC bad on machines, so that people that see TSC fail on their current
> kernels can continue to use the new kernels. This requires a whole lot
> of care on the part of users though, and will raise a ruckus, because I
> bet a fair number of these people are not even currently aware we're
> disabling TSC for them :/

I'm still allowed to dream, right? :)

Thanks,

        tglx
