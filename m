Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE93A37B9AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhELJyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:54:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50112 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhELJx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:53:59 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620813171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YSgWjXJsl5e5v6HMS/LXGmLpJgybhTkMWBQ/e0S1D5k=;
        b=2TgHK0ZWF8GjoT/w/w8T7F2wzHpFqRGFNa49w+f7m4+GmNKtpys2Z8o0mDCEegcsupTdnu
        4Ktqj5TRf4Z2dbSHMpgvv1ddViUWyzpOeayErGZ0RHgV5EzIk7lZCImbbo5IhTBik0lYAO
        boTG43V4LsZ2AdK8mQ60ZlE4CTM0nj5+eDipr608ZwrvutJDE3xQovsryGsMrj5OgR8dX+
        YnBWzmc6M/Y6nWrISsW2gjq4hwCmQLMWO/Qbri1Ld/P0Xt8c51NZl/vgLYwKkW+ve0Dvjc
        cPi3/C8MnhxLVcZQ+rE0WItjzkoTc3JnGjVaN0CMY4kDx409Vy/KppcpPukOQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620813171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YSgWjXJsl5e5v6HMS/LXGmLpJgybhTkMWBQ/e0S1D5k=;
        b=Bq3y4BCHNBSz0lpVXk3OLfQmCjt5KsMtnqc4bf8ZmrNVohuZlJn4pYWeIPeJFZmTOZnEKO
        Sv2BHmn4az1jwTBQ==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>
Subject: Re: [patch 1/2 v2] x86/cpu: Init AP exception handling from cpu_init_secondary()
In-Reply-To: <YJuWt16izc2toXIM@hirez.programming.kicks-ass.net>
References: <20210507110210.147106915@linutronix.de> <20210507114000.429303187@linutronix.de> <ccbd2f11-bb74-19bd-cf5c-d524625f9a0d@linux.alibaba.com> <87wns8ko48.ffs@nanos.tec.linutronix.de> <87k0o6gtvu.ffs@nanos.tec.linutronix.de> <YJuWt16izc2toXIM@hirez.programming.kicks-ass.net>
Date:   Wed, 12 May 2021 11:52:50 +0200
Message-ID: <87bl9gffd9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12 2021 at 10:49, Peter Zijlstra wrote:
> On Mon, May 10, 2021 at 11:29:25PM +0200, Thomas Gleixner wrote:
>> +#ifdef CONFIG_SMP
>> +void cpu_init_secondary(void)
>> +{
> 	/*
> 	 * Relies on the BP having set-up the IDT tables, which
> 	 * are loaded on this CPU in the below
> 	 * cpu_init_exception_handling().
> 	 */
>> +	cpu_init_exception_handling();
>> +	cpu_init();
>> +}
>> +#endif
>
> Or something along those lines? It took me a little to figure out why
> start_secondary() didn't have idt_setup_traps(), hopefully something
> like this will avoid a little future confusion.

I'll add something to that effect.
