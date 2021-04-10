Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6342A35AFAD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 20:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhDJSq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 14:46:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57794 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhDJSqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 14:46:55 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618080399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=81INtAGsC5emch+UZjtildFjaOjpcYNUjjL1+Jl4OBo=;
        b=cPjup0S+cWnddfcBTiAKGigp/D6301ZML5Xh5TGOaWWwVoG6AjjXPaVppqzPFIFfkQALuB
        6wXpCPfp9Lnc5KbTJ8fgMbMCS1pfgqS/GlDoXVNtWotT59ijRb5Dv0eI6yUr9VO4lfYRAD
        1TxSNLb5POvPs1L7cMURJioXADF6R6AfRdli9+Sz9kx24zM2odttJk9OL3Y/9kaE7Vg8CD
        ZEDCA1Dz0RklgRIucluUBSC+Kx8QFo5ZOlfM+52CyBXVi9R4uon7zYWl8RaZjDaiGr1Wf/
        vyu0FRm6OZIyrZloOafpwNeHyWRU6HB1cmBGTWQPMGt8QM9t/fsK5Fk4GloEtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618080399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=81INtAGsC5emch+UZjtildFjaOjpcYNUjjL1+Jl4OBo=;
        b=qqltu/3HQiaFKH0kjwAv+4ayRAy7BPirx+zg0KLTic+z4pMHnd6iZZwOgrr0gyPu9zyU+P
        EGdJLMoX246BLLCw==
To:     Feng Tang <feng.tang@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, dave.hansen@intel.com, len.brown@intel.com
Subject: Re: [RFC 1/2] x86/tsc: add a timer to make sure tsc_adjust is always checked
In-Reply-To: <20210410143804.GB22054@shbuild999.sh.intel.com>
References: <1617092747-15769-1-git-send-email-feng.tang@intel.com> <87y2dq32xc.ffs@nanos.tec.linutronix.de> <20210410143804.GB22054@shbuild999.sh.intel.com>
Date:   Sat, 10 Apr 2021 20:46:38 +0200
Message-ID: <87blam2d0x.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feng,

On Sat, Apr 10 2021 at 22:38, Feng Tang wrote:
> On Sat, Apr 10, 2021 at 11:27:11AM +0200, Thomas Gleixner wrote:
>> > +static int __init start_sync_check_timer(void)
>> > +{
>> > +	if (!boot_cpu_has(X86_FEATURE_TSC_ADJUST))
>> > +		return 0;
>> > +
>> > +	timer_setup(&tsc_sync_check_timer, tsc_sync_check_timer_fn, 0);
>> > +	tsc_sync_check_timer.expires = jiffies + SYNC_CHECK_INTERVAL;
>> > +	add_timer(&tsc_sync_check_timer);
>> > +
>> > +	return 0;
>> > +}
>> > +late_initcall(start_sync_check_timer);
>> 
>> So right now, if someone adds 'tsc=reliable' on the kernel command line
>> then all of the watchdog checking, except for the idle enter TSC_ADJUST
>> check is disabled. The NOHZ full people are probably going to be pretty
>> unhappy about yet another unconditional timer they have to chase down.
>> 
>> So this needs some more thought.
>
> 'tsc=reliable' in cmdline will set 'tsc_clocksource_reliable' to 1, so
> we can skip starting this timer if 'tsc_clocksource_reliable==1' ?

Then we can just ignore that patch alltogether because of 2/2 doing:

+	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
+	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
+	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
+	    nr_online_nodes <= 2)
+		tsc_clocksource_reliable = 1;

....

I said for a reason:

>> So this needs some more thought.

Thanks,

        tglx
