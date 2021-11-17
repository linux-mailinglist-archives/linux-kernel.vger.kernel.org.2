Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84437454DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 20:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbhKQT1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 14:27:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230400AbhKQT1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 14:27:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACFB261AFF;
        Wed, 17 Nov 2021 19:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637177088;
        bh=LC222xu+7xfflnayL11gn1WvsJC/DZjkauLm9wox4QU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBGaQK89STeJBz76SH+6SWvGWgf6ur9C78zONVOmuDdNTzX14Xd0xdQVLdwKDnhxI
         4okbhqg9ZeiRum+gdX+m6DCVj5aaJLIhiLPeWfCfXDNSwgz4F7kiGznidJY44IgFFe
         ApuZRh7SyXXSotY8sYiMvUIay7T9cnSyhfbFvwVZM1u6bqXXEItKfO3m18tiFa/A5P
         2buoD8IJoVaR3md2/IFBfS1XxdZWHL7RJDP4G9c2fBPXtcKMiuSMrEPbxmFmohKl0c
         4mrbb9CH877/VDN4GgUaXPxgKAOCESY0bi2n01mPZX+Q1gkLKOrhYG2yLJ+uELhrYI
         hvZB+n7pe8exw==
Date:   Wed, 17 Nov 2021 12:24:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] clocksource/drivers/arm_arch_timer: Force inlining of
 erratum_set_next_event_generic()
Message-ID: <YZVW+/4nbDtcU85h@archlinux-ax161>
References: <20211117113532.3895208-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117113532.3895208-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 11:35:32AM +0000, Marc Zyngier wrote:
> With some specific kernel configuration and Clang, the kernel fails
> to like with something like:

Specifically, CONFIG_CFI_CLANG=y from what I could tell from looking
into this: https://github.com/ClangBuiltLinux/linux/issues/1503

> ld.lld: error: undefined symbol: __compiletime_assert_200
> >>> referenced by arch_timer.h:156 (./arch/arm64/include/asm/arch_timer.h:156)
> >>>               clocksource/arm_arch_timer.o:(erratum_set_next_event_generic) in archive drivers/built-in.a
> 
> ld.lld: error: undefined symbol: __compiletime_assert_197
> >>> referenced by arch_timer.h:133 (./arch/arm64/include/asm/arch_timer.h:133)
> >>>               clocksource/arm_arch_timer.o:(erratum_set_next_event_generic) in archive drivers/built-in.a
> make: *** [Makefile:1161: vmlinux] Error 1
> 
> These are due to the BUILD_BUG() macros contained in the low-level
> accessors (arch_timer_reg_{write,read}_cp15) being emitted, as the
> access type wasn't known at compile time.
> 
> Fix this by making erratum_set_next_event_generic() __force_inline,
> resulting in the 'access' parameter to be resolved at compile time,
> similarly to what is already done for set_next_event().
> 
> Fixes: 4775bc63f880 ("Add build-time guards for unhandled register accesses")

It looks like the prefix was removed? Shouldn't it be:

Fixes: 4775bc63f880 ("clocksource/arm_arch_timer: Add build-time guards for unhandled register accesses")

> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/clocksource/arm_arch_timer.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 9a04eacc4412..1ecd52f903b8 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -394,8 +394,13 @@ EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
>  
>  static atomic_t timer_unstable_counter_workaround_in_use = ATOMIC_INIT(0);
>  
> -static void erratum_set_next_event_generic(const int access, unsigned long evt,
> -						struct clock_event_device *clk)
> +/*
> + * Force the inlining of this function so that the register accesses
> + * can be themselves correctly inlined.
> + */
> +static __always_inline
> +void erratum_set_next_event_generic(const int access, unsigned long evt,
> +				    struct clock_event_device *clk)
>  {
>  	unsigned long ctrl;
>  	u64 cval;
> -- 
> 2.30.2
> 
