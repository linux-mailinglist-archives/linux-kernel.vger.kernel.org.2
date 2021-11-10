Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4617644C55C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 17:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhKJQwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 11:52:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231209AbhKJQwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 11:52:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1003A610D2;
        Wed, 10 Nov 2021 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636562985;
        bh=VZR23cB0KazqK9dPSux52fA97e7fIHVv1rwqlMDOH/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q/K33bjG7Fn1vT3S0jTVCN/FvjMMthE2IyEKcfyGHDQmeXvLv+LytzIKPi8b5aBeR
         Hwwkf+YlPx5ZiTh87kxkChjSP9E1Sl922dYI9gzPwW7zEKco0kb3KmG41Jm2D3oPkN
         CmTCCNXYEAIgB4Ep3k+O9f7KiZj7mP1rUqBxc0GxG7lhp3bHJnsPICcsRpUGZp7r0i
         6Kf8O3X4OyCAOntfRwB3nilgkMO+zkqJBY7sK0C4IuhQyeTyHHEmM2TuYclOyOQK28
         Pr7+n+BUTYeqvtqUlVYz1Z0udM/i+vMPEd2RtJhUneMQXErLzBTBWblDFzgb2ec0Vd
         yrIBa/bpk2Dgg==
Date:   Wed, 10 Nov 2021 17:49:42 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Mike Galbraith <efault@gmx.de>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched: Split preemption model selection between DYNAMIC
 & !DYNAMIC
Message-ID: <20211110164942.GA300656@lothringen>
References: <20211109151057.3489223-1-valentin.schneider@arm.com>
 <20211110011738.GD288354@lothringen>
 <beec14cee84de7a4bedd7a63c2acdf150a82bc09.camel@gmx.de>
 <87h7cks16n.mognet@arm.com>
 <87bl2srrvq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl2srrvq.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 02:45:45PM +0000, Valentin Schneider wrote:
> On 10/11/21 11:24, Valentin Schneider wrote:
> > Following Frederic's _STATIC suggestion, I got to the below. The nice thing
> > is if a defconfig picks say PREEMPT_VOLUNTARY and the arch supports
> > PREEMPT_DYNAMIC, then it'll pick PREEMPT_VOLUNTARY_BEHAVIOUR. The less nice
> > thing is that we end up selecting PREEMPT_STATIC for PREEMPT_DYNAMIC
> > kernels, naming's hard... Maybe _BUILD rather than _STATIC?
> >
> 
> And now without a legacy compatibility layer crud...
> 
> ---
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 2776423a587e..9c7d774ef809 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -88,7 +88,7 @@
>  struct completion;
>  struct user;
>  
> -#ifdef CONFIG_PREEMPT_VOLUNTARY
> +#ifdef CONFIG_PREEMPT_VOLUNTARY_BUILD
>  
>  extern int __cond_resched(void);
>  # define might_resched() __cond_resched()
> diff --git a/include/linux/vermagic.h b/include/linux/vermagic.h
> index 1eaaa93c37bf..f2b71920024c 100644
> --- a/include/linux/vermagic.h
> +++ b/include/linux/vermagic.h
> @@ -15,7 +15,7 @@
>  #else
>  #define MODULE_VERMAGIC_SMP ""
>  #endif
> -#ifdef CONFIG_PREEMPT
> +#ifdef CONFIG_PREEMPT_BUILD
>  #define MODULE_VERMAGIC_PREEMPT "preempt "
>  #elif defined(CONFIG_PREEMPT_RT)
>  #define MODULE_VERMAGIC_PREEMPT "preempt_rt "
> @@ -39,9 +39,9 @@
>  #define MODULE_RANDSTRUCT_PLUGIN
>  #endif
>  
> -#define VERMAGIC_STRING 						\
> +#define VERMAGIC_STRING							\
>  	UTS_RELEASE " "							\
> -	MODULE_VERMAGIC_SMP MODULE_VERMAGIC_PREEMPT 			\
> +	MODULE_VERMAGIC_SMP MODULE_VERMAGIC_PREEMPT			\
>  	MODULE_VERMAGIC_MODULE_UNLOAD MODULE_VERMAGIC_MODVERSIONS	\
>  	MODULE_ARCH_VERMAGIC						\
>  	MODULE_RANDSTRUCT_PLUGIN
> diff --git a/init/Makefile b/init/Makefile
> index 2846113677ee..04eeee12c076 100644
> --- a/init/Makefile
> +++ b/init/Makefile
> @@ -30,7 +30,7 @@ $(obj)/version.o: include/generated/compile.h
>  quiet_cmd_compile.h = CHK     $@
>        cmd_compile.h = \
>  	$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@	\
> -	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT)"	\
> +	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT_BUILD)"	\
>  	"$(CONFIG_PREEMPT_RT)" $(CONFIG_CC_VERSION_TEXT) "$(LD)"
>  
>  include/generated/compile.h: FORCE
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index 60f1bfc3c7b2..ce77f0265660 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -1,12 +1,23 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
> +config PREEMPT_NONE_BUILD
> +	bool
> +
> +config PREEMPT_VOLUNTARY_BUILD
> +	bool
> +
> +config PREEMPT_BUILD
> +	bool
> +	select PREEMPTION
> +	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
> +
>  choice
>  	prompt "Preemption Model"
> -	default PREEMPT_NONE_BEHAVIOUR
> +	default PREEMPT_NONE
>  
> -config PREEMPT_NONE_BEHAVIOUR
> +config PREEMPT_NONE
>  	bool "No Forced Preemption (Server)"
> -	select PREEMPT_NONE if !PREEMPT_DYNAMIC
> +	select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
>  	help
>  	  This is the traditional Linux preemption model, geared towards
>  	  throughput. It will still provide good latencies most of the
> @@ -18,10 +29,10 @@ config PREEMPT_NONE_BEHAVIOUR
>  	  raw processing power of the kernel, irrespective of scheduling
>  	  latencies.
>  
> -config PREEMPT_VOLUNTARY_BEHAVIOUR
> +config PREEMPT_VOLUNTARY
>  	bool "Voluntary Kernel Preemption (Desktop)"
>  	depends on !ARCH_NO_PREEMPT
> -	select PREEMPT_VOLUNTARY if !PREEMPT_DYNAMIC
> +	select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
>  	help
>  	  This option reduces the latency of the kernel by adding more
>  	  "explicit preemption points" to the kernel code. These new
> @@ -37,10 +48,10 @@ config PREEMPT_VOLUNTARY_BEHAVIOUR
>  
>  	  Select this if you are building a kernel for a desktop system.
>  
> -config PREEMPT_BEHAVIOUR
> +config PREEMPT
>  	bool "Preemptible Kernel (Low-Latency Desktop)"
>  	depends on !ARCH_NO_PREEMPT
> -	select PREEMPT
> +	select PREEMPT_BUILD
>  	help
>  	  This option reduces the latency of the kernel by making
>  	  all kernel code (that is not executing in a critical section)

Looks nicer that way!

But don't forget to also update preempt_dynamic_init().
