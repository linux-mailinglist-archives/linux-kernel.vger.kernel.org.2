Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E7D428ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbhJKKfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235871AbhJKKfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:35:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F36A460E0C;
        Mon, 11 Oct 2021 10:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633948396;
        bh=T6/qFqZUSY5CllfD3YHlAaFEA/wh2WZXwj3EP40ZDDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ToTs/yyNFcBw+mTBM6VNtNB41jxEyY+acsOBWqp1kLI5eEIYIHBYBgmkG3W5xADLM
         3oSgkHwjcgI7KZ7WFjP9qy32UoyjwfKCkEDNw/38X3/Wdd8BTkEbThrSthO7JoTxAl
         NEsh1CK7719bFMP+UXqjM2xKREjt38k54NT5V6b++ZB9wxQMhr5zs3whKom9JoXq7N
         cECYIaxWXBEUjATp/tv3HdG9YTkvxtZXaAvKOj3z+ZFK1I2IqORz9Qmpk1EkRtYDhG
         BDIxS5X2btBdUGT2Omh8i6yeYGnoZC/n71t5YOerkCrSTTs370zyrZEFtSCCD9JQ/W
         DVJHU3/Js/drA==
Date:   Mon, 11 Oct 2021 11:33:09 +0100
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
Subject: Re: [PATCH v3 15/17] arm64: Add CNT{P,V}CTSS_EL0 alternatives to
 cnt{p,v}ct_el0
Message-ID: <20211011103308.GE3681@willie-the-truck>
References: <20211010114306.2910453-1-maz@kernel.org>
 <20211010114306.2910453-16-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010114306.2910453-16-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 12:43:04PM +0100, Marc Zyngier wrote:
> CNTPCTSS_EL0 and CNTVCTSS_EL0 are alternatives to the usual
> CNTPCT_EL0 and CNTVCT_EL0 that do not require a previous ISB
> to be synchronised (SS stands for Self-Synchronising).
> 
> Use the ARM64_HAS_ECV capability to control alternative sequences
> that switch to these low(er)-cost primitives. Note that the
> counter access in the VDSO is for now left alone until we decide
> whether we want to allow this.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/arch_timer.h | 32 +++++++++++++++++++++--------
>  arch/arm64/include/asm/sysreg.h     |  3 +++
>  2 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 519ac1f7f859..33a08fff0f06 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -64,14 +64,26 @@ DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
>  
>  static inline notrace u64 arch_timer_read_cntpct_el0(void)
>  {
> -	isb();
> -	return read_sysreg(cntpct_el0);
> +	u64 cnt;
> +
> +	asm volatile(ALTERNATIVE("isb\n mrs %x0, cntpct_el0",
> +				 "nop\n" __mrs_s("%x0", SYS_CNTPCTSS_EL0),
> +				 ARM64_HAS_ECV)
> +		     : "=r" (cnt));
> +
> +	return cnt;

Why do you need to use %x0 instead of just %0 here? Similarly for the other
functions you're changing in this file.

Will
