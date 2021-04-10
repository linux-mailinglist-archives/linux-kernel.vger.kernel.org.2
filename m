Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F9135AC71
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhDJJ12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:27:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55640 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDJJ11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:27:27 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618046832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IwPuSkQnJ9S7GXJ2SK5mhQXde3+d9AsuSdLUOcALXvk=;
        b=g+DswMMnFgfI6jEt7WLO+MhO2r6lakT75ecbFg5azoxJaX3odcUwrvssRXaWsP1yH7crEf
        pph3bFvjZIHQf+8i6tnUDcX0rizCSRHwLJMuYZJu36m/Goe/ShsmUGtcqecEhpekHdB2ur
        0M9Gxea4pNGWZzRvjlCYVKktgPPMSuPhRBfli+HyvbB5sghOMGbJDVhrHILtBuNCeOjbb9
        ju8tQ9sgKomdc66N4pnV8sKULJ+AI87m3hqTDSzFxNSfbOjeUn92sSUAfAPhyxGNKTYtbR
        GkaIfnjmJ3wUBc8XMOYLvTt9xwFvQoBHrqYUMneahl42iaStTe80kotCqSE4mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618046832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IwPuSkQnJ9S7GXJ2SK5mhQXde3+d9AsuSdLUOcALXvk=;
        b=YvcWrHFyPr2tGyNdWliTFUIzhTHbRp0Rtg+9ZDNnzBRVp+XWlCjLjSO8FL3aDUHemlrX8R
        6w54gFeholHIu3Bg==
To:     Feng Tang <feng.tang@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, andi.kleen@intel.com, dave.hansen@intel.com,
        len.brown@intel.com, Feng Tang <feng.tang@intel.com>
Subject: Re: [RFC 1/2] x86/tsc: add a timer to make sure tsc_adjust is always checked
In-Reply-To: <1617092747-15769-1-git-send-email-feng.tang@intel.com>
References: <1617092747-15769-1-git-send-email-feng.tang@intel.com>
Date:   Sat, 10 Apr 2021 11:27:11 +0200
Message-ID: <87y2dq32xc.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30 2021 at 16:25, Feng Tang wrote:
> Normally the tsc_sync will be checked every time system enters idle state,
> but there is still caveat that a system won't enter idle, either because
> it's too busy or configured purposely to not enter idle. Setup a periodic
> timer to make sure the check is always on.

Bah. I really hate the fact that we don't have a knob to disable writes
to the TSC/TSC_ADJUST msrs. That would spare this business alltogether.

> +/*
> + * Normally the tsc_sync will be checked every time system enters idle state,
> + * but there is still caveat that a system won't enter idle, either because
> + * it's too busy or configured purposely to not enter idle.
> + *
> + * So setup a periodic timer to make sure the check is always on.
> + */
> +
> +#define SYNC_CHECK_INTERVAL		(HZ * 600)
> +static void tsc_sync_check_timer_fn(struct timer_list *unused)

I've surely mentioned this before that glueing a define without an empty
newline to a function definition is horrible to read.

> +{
> +	int next_cpu;
> +
> +	tsc_verify_tsc_adjust(false);
> +
> +	/* Loop to do the check for all onlined CPUs */

I don't see a loop here.

> +	next_cpu = cpumask_next(raw_smp_processor_id(), cpu_online_mask);

Why raw_smp_processor_id()? What's wrong with smp_processor_id()?

> +	if (next_cpu >= nr_cpu_ids)
> +		next_cpu = cpumask_first(cpu_online_mask);
> +
> +	tsc_sync_check_timer.expires += SYNC_CHECK_INTERVAL;
> +	add_timer_on(&tsc_sync_check_timer, next_cpu);
> +}
> +
> +static int __init start_sync_check_timer(void)
> +{
> +	if (!boot_cpu_has(X86_FEATURE_TSC_ADJUST))
> +		return 0;
> +
> +	timer_setup(&tsc_sync_check_timer, tsc_sync_check_timer_fn, 0);
> +	tsc_sync_check_timer.expires = jiffies + SYNC_CHECK_INTERVAL;
> +	add_timer(&tsc_sync_check_timer);
> +
> +	return 0;
> +}
> +late_initcall(start_sync_check_timer);

So right now, if someone adds 'tsc=reliable' on the kernel command line
then all of the watchdog checking, except for the idle enter TSC_ADJUST
check is disabled. The NOHZ full people are probably going to be pretty
unhappy about yet another unconditional timer they have to chase down.

So this needs some more thought.

Thanks,

        tglx
