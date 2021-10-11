Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61E428BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbhJKLEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236128AbhJKLEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:04:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B41460EB1;
        Mon, 11 Oct 2021 11:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633950169;
        bh=Oi1WJOMEIm5nh0AAd4dmHC8O35/60euaedtnJCwMV7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/WGpwMN9duErrEx9Z7StzfvIWALhqdOvDhkFkspt04zOct5qTvWSHRCTc5R1/KN+
         B8TgFUUPbnYFb5Jbjim7tlk/Y4P0Cow2udEufTl2h1YItt1cD04icaeHkI0VXrsvit
         Z5dIi9wrTlE/QKOTDw9cBlA5YEOJGY82ONlFqPBJWnKtWzulivDOgN47z9G//tM73l
         aIxRGfGzbfnNS6AA1Ceu79ljfvWUY+sSsswMfzFHbw8gtN8DKct9QARKk1TMFQc3TN
         2T2/XSBYOOxVKjBxCViLpJO7kkxjWMvQu5jFq3UEoKPQMOuVVGJUkthbXV8/M/JNso
         Rt5zdq5YCvHjw==
Date:   Mon, 11 Oct 2021 12:02:44 +0100
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 00/17] clocksource/arm_arch_timer: Add basic ARMv8.6
 support
Message-ID: <20211011110243.GB4068@willie-the-truck>
References: <20211010114306.2910453-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010114306.2910453-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 12:42:49PM +0100, Marc Zyngier wrote:
> This is v3 of the series enabling ARMv8.6 support for timer subsystem,
> and was prompted by a discussion with Oliver around the fact that an
> ARMv8.6 implementation must have a 1GHz counter, which leads to a
> number of things to break in the timer code:
> 
> - the counter rollover can come pretty quickly as we only advertise a
>   56bit counter,
> - the maximum timer delta can be remarkably small, as we use the
>   countdown interface which is limited to 32bit...
> 
> Thankfully, there is a way out: we can compute the minimal width of
> the counter based on the guarantees that the architecture gives us,
> and we can use the 64bit comparator interface instead of the countdown
> to program the timer.
> 
> Finally, we start making use of the ARMv8.6 ECV features by switching
> accesses to the counters to a self-synchronising register, removing
> the need for an ISB. Hopefully, implementations will *not* just stick
> an invisible ISB there...
> 
> A side effect of the switch to CVAL is that XGene-1 breaks. I have
> added a workaround to keep it alive.
> 
> I have added Oliver's original patch[0] to the series and tweaked a
> couple of things. Blame me if I broke anything.
> 
> The whole things has been tested on Juno (sysreg + MMIO timers),
> XGene-1 (broken sysreg timers), FVP (FEAT_ECV, CNT*CTSS_EL0).

The arm64 bits look pretty good to me (I left some minor comments).

How do you want to merge this series? It would be nice to have the arch
bits in the arm64 tree, if possible, as we'll be tripping over the cpucaps
stuff otherwise.

Will
