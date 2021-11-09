Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9797C44AB71
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 11:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245303AbhKIK1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 05:27:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239354AbhKIK1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 05:27:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA2F36115B;
        Tue,  9 Nov 2021 10:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636453505;
        bh=rGE10HIXZmbhxN+IHzposILO92jVkMCYBAB1nviliUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmICFbtlbMar/OkMVCGEg/xP8jorTnUovsyN4nNPTAhbaJpFvyXRsZF/zY7l6Vomg
         53/kfLbjO+r+oIRMCJt2ZXdjEp2F00kRl5KdDRefgMt6xh9tgoPwDBQuO8pbnOniyK
         Zt3hB+M8t8udZpIfF0KTyLNHt2X8kUZGATvjwm+imP/dtgiFe/mUjLoTKAPrN2Z27o
         QyfA93Rrvlr4MhVZoYZLvbwXC130myqDxpWAbzWVgs/HBCiGNqqJJ+YU+87FyvQ3x4
         nOXIJSEGy+wf171I+rFrV+lt0XeDv8RTPiWeGnuCiaXKHgZVWSNyHl68J/LwxB6Vk1
         WjoOuPcbG3HVQ==
Date:   Tue, 9 Nov 2021 11:25:02 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] sched: Tweak default dynamic preempt mode selection
Message-ID: <20211109102502.GA288354@lothringen>
References: <20211105104035.3112162-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105104035.3112162-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 10:40:35AM +0000, Valentin Schneider wrote:
> Commit c597bfddc9e9 ("sched: Provide Kconfig support for default dynamic
> preempt mode") changed the selectable config names for the preemption
> model. This means a config file must now select
> 
>   CONFIG_PREEMPT_BEHAVIOUR=y
> 
> rather than
> 
>   CONFIG_PREEMPT=y
> 
> to get a preemptible kernel. This means all arch config files need to be
> updated - right now arm64 defconfig selects CONFIG_PREEMPT=y but ends up
> with CONFIG_PREEMPT_NONE_BEHAVIOUR=y.
> 
> Instead, have CONFIG_*PREEMPT be the selectable configs again, and make
> them select their _BEHAVIOUR equivalent if CONFIG_PREEMPT_DYNAMIC is set.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/Kconfig.preempt | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index 60f1bfc3c7b2..25e8d6a3d9fa 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -1,12 +1,21 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
> +config PREEMPT_NONE_BEHAVIOUR
> +	bool
> +
> +config PREEMPT_VOLUNTARY_BEHAVIOUR
> +	bool
> +
> +config PREEMPT_BEHAVIOUR
> +	bool
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
> +	select PREEMPT_NONE_BEHAVIOUR if PREEMPT_DYNAMIC
>  	help
>  	  This is the traditional Linux preemption model, geared towards
>  	  throughput. It will still provide good latencies most of the
> @@ -18,10 +27,10 @@ config PREEMPT_NONE_BEHAVIOUR
>  	  raw processing power of the kernel, irrespective of scheduling
>  	  latencies.
>  
> -config PREEMPT_VOLUNTARY_BEHAVIOUR
> +config PREEMPT_VOLUNTARY
>  	bool "Voluntary Kernel Preemption (Desktop)"
>  	depends on !ARCH_NO_PREEMPT
> -	select PREEMPT_VOLUNTARY if !PREEMPT_DYNAMIC
> +	select PREEMPT_VOLUNTARY_BEHAVIOUR if PREEMPT_DYNAMIC
>  	help
>  	  This option reduces the latency of the kernel by adding more
>  	  "explicit preemption points" to the kernel code. These new
> @@ -37,10 +46,12 @@ config PREEMPT_VOLUNTARY_BEHAVIOUR
>  
>  	  Select this if you are building a kernel for a desktop system.
>  
> -config PREEMPT_BEHAVIOUR
> +config PREEMPT
>  	bool "Preemptible Kernel (Low-Latency Desktop)"
>  	depends on !ARCH_NO_PREEMPT
> -	select PREEMPT
> +	select PREEMPTION
> +	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
> +	select PREEMPT_BEHAVIOUR if PREEMPT_DYNAMIC
>  	help
>  	  This option reduces the latency of the kernel by making
>  	  all kernel code (that is not executing in a critical section)
> @@ -75,17 +86,6 @@ config PREEMPT_RT
>  
>  endchoice
>  
> -config PREEMPT_NONE
> -	bool
> -
> -config PREEMPT_VOLUNTARY
> -	bool
> -
> -config PREEMPT
> -	bool
> -	select PREEMPTION
> -	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
> -
>  config PREEMPT_COUNT
>         bool

This must be breaking cond_resched() and might_resched() definitions.

Since CONFIG_PREEMPT_NONE, CONFIG_PREEMPT_VOLUNTARY and CONFIG_PREEMPT aren't too widely
spread around within ifdefferies, you can:

1) Rename CONFIG_PREEMPT_NONE to CONFIG_PREEMPT_NONE_STATIC
   Rename CONFIG_PREEMPT_VOLUNTARY to CONFIG_PREEMPT_VOLUNTARY_STATIC
   Rename CONFIG_PREEMPT to CONFIG_PREEMPT_STATIC

2) Keep the old CONFIG_PREEMPT_NONE, CONFIG_PREEMPT_VOLUNTARY,
   CONFIG_PREEMPT around for compatibility and make them select their
   corresponding BEHAVIOUR entries.

Thanks.
   
