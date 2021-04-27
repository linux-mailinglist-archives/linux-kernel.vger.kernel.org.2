Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DB136CDA8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 23:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbhD0VE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 17:04:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43686 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239245AbhD0VEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:04:07 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619557402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SYoy2+HeogbYh4Q+jYD6A2aGrOUVl93Nospt2/SE0Sg=;
        b=LMrzudB/OdjcTxl99GtPq47WvCdtj9dZg1VAB0qVui6dFfSvFsa4nn3LdtFm5wbpux12Xv
        PW0QZWRmX2+wAud7QpF9Ug9GW+2Ina0Vx+ajMy40MjGnOGwDKlVzLh3ylzx/DPLD6ZMiAE
        HHOfSx8BluVRMqiVMXzstqaOO1hafjyx6gkX0EQgl5j7Tx5SqDtssaQjruF1Db2ugsE0gK
        eAt4TyngqXFHnqQapvTfCww4VIhPxHIKp6neaRR+O6qQjhZaaITG3cHBMr8QQW3kkmt8tJ
        5v7Sq56nTMl0wGy34h5kaoUKVeWV2oUr7WSuOri6qvs0rZ+PSdvZGjeGHO+27g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619557402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SYoy2+HeogbYh4Q+jYD6A2aGrOUVl93Nospt2/SE0Sg=;
        b=gFAUhPGt+liELWXY/YZe3hfTIwuHKGbih7Gnu7I792OPeM1/9kURApO05adg45M7dvmWdV
        Ydwnv8ebn2NNnwDQ==
To:     Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, zhengjun.xing@intel.com,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v10 clocksource 6/7] clocksource: Forgive tsc_early pre-calibration drift
In-Reply-To: <20210426150127.GB23119@shbuild999.sh.intel.com>
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1> <20210425224709.1312655-6-paulmck@kernel.org> <20210426150127.GB23119@shbuild999.sh.intel.com>
Date:   Tue, 27 Apr 2021 23:03:22 +0200
Message-ID: <871ravo2xx.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26 2021 at 23:01, Feng Tang wrote:
> On Sun, Apr 25, 2021 at 03:47:07PM -0700, Paul E. McKenney wrote:
> We've reported one case that tsc can be wrongly judged as 'unstable'
> by 'refined-jiffies' watchdog [1], while reducing the threshold could
> make it easier to be triggered.
>
> It could be reproduced on the a plaform with a 115200 serial console,
> and hpet been disabled (several x86 platforms has this), add 
> 'initcall_debug' cmdline parameter to get more debug message, we can
> see:
>
> [    1.134197] clocksource: timekeeping watchdog on CPU1: Marking clocksource 'tsc-early' as unstable because the skew is too large:
> [    1.134214] clocksource:                       'refined-jiffies' wd_nesc: 500000000 wd_now: ffff8b35 wd_last: ffff8b03 mask: ffffffff

refined-jiffies is the worst of all watchdogs and this obviously cannot
be fixed at all simply because we can lose ticks in that mode. And no,
we cannot compensate for lost ticks via TSC which we in turn "monitor"
via ticks.

Even if we hack around it and make it "work" then the TSC will never
become fully trusted because refined-jiffies cannot support NOHZ/HIGHRES
mode for obvious reasons either. So the system stays in periodic mode
forever.

If there is no independent timer to validate against then the TSC is
better stable and the BIOS/SMM code has to be trusted not to wreckage
TSC. There are no other options.

So TBH, I do not care about this case at all. It's pointless to even
think about it. Either the TSC works on these systems or it doesn't. If
it doesn't, then you have to keep the pieces.

I'm so dead tired of this especially since this is known forever. But
it's obviously better to waste our time than to fix the damned hardware.

Thanks,

        tglx
