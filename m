Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2B244AAFC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 10:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbhKIJ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 04:56:01 -0500
Received: from foss.arm.com ([217.140.110.172]:59294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241704AbhKIJzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 04:55:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F836ED1;
        Tue,  9 Nov 2021 01:53:03 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 930A53F7F5;
        Tue,  9 Nov 2021 01:53:02 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] sched: Tweak default dynamic preempt mode selection
In-Reply-To: <a8540176424035960b12529c06d5a3dcedd57c77.camel@gmx.de>
References: <20211105104035.3112162-1-valentin.schneider@arm.com> <ff53a94401f8d6abe0303ee381f86bfb475ad354.camel@gmx.de> <8735o6uca5.mognet@arm.com> <5543627ee8ac5337a74de4b9671240d617273607.camel@gmx.de> <87zgqesmej.mognet@arm.com> <a8540176424035960b12529c06d5a3dcedd57c77.camel@gmx.de>
Date:   Tue, 09 Nov 2021 09:52:54 +0000
Message-ID: <87wnlhsljd.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/21 06:30, Mike Galbraith wrote:
> Not seeing your v2 land yet, I grabbed my mallet and had a go at goal
> reconciliation over morning java.  Non-lovely result seems to work.
>

Yeah so I went down a debatable path, gave up on that and started something
different, and gave up on that because it was late :-)

Now interestingly my second attempt is pretty close to what you have
below.

> sched, Kconfig: Fix preemption model selection
>
> Switch PREEMPT_DYNAMIC/PREEMPT_RT dependency around so PREEMPT_RT
> can be selected during the initial preemption model selection.
> Further, since PREEMPT_DYNAMIC requires PREEMPT, make it depend
> upon it instead of selecting it, and add a menu to allow selection
> of the boot time behavior, this to allow arches that do not support
> PREEMPT_DYNAMIC to retain their various configs untouched.
>

Have some nits below, but otherwise where I stand right now I think it's
the least ugly way of tackling this :)

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
>  kernel/Kconfig.preempt |   46 +++++++++++++++++++++++++---------------
> ------
>  1 file changed, 25 insertions(+), 21 deletions(-)
>
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -2,11 +2,10 @@
>
>  choice
>       prompt "Preemption Model"
> -	default PREEMPT_NONE_BEHAVIOUR
> +	default PREEMPT_NONE
>
> -config PREEMPT_NONE_BEHAVIOUR
> +config PREEMPT_NONE
>       bool "No Forced Preemption (Server)"
> -	select PREEMPT_NONE if !PREEMPT_DYNAMIC
>       help
>         This is the traditional Linux preemption model, geared
> towards
>         throughput. It will still provide good latencies most of the
> @@ -18,10 +17,9 @@ config PREEMPT_NONE_BEHAVIOUR
>         raw processing power of the kernel, irrespective of
> scheduling
>         latencies.
>
> -config PREEMPT_VOLUNTARY_BEHAVIOUR
> +config PREEMPT_VOLUNTARY
>       bool "Voluntary Kernel Preemption (Desktop)"
>       depends on !ARCH_NO_PREEMPT
> -	select PREEMPT_VOLUNTARY if !PREEMPT_DYNAMIC
>       help
>         This option reduces the latency of the kernel by adding more
>         "explicit preemption points" to the kernel code. These new
> @@ -37,10 +35,11 @@ config PREEMPT_VOLUNTARY_BEHAVIOUR
>
>         Select this if you are building a kernel for a desktop
> system.
>
> -config PREEMPT_BEHAVIOUR
> +config PREEMPT
>       bool "Preemptible Kernel (Low-Latency Desktop)"
>       depends on !ARCH_NO_PREEMPT
> -	select PREEMPT
> +	select PREEMPTION
> +	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
>       help
>         This option reduces the latency of the kernel by making
>         all kernel code (that is not executing in a critical
> section)
> @@ -58,7 +57,7 @@ config PREEMPT_BEHAVIOUR
>
>  config PREEMPT_RT
>       bool "Fully Preemptible Kernel (Real-Time)"
> -	depends on EXPERT && ARCH_SUPPORTS_RT && !PREEMPT_DYNAMIC
> +	depends on EXPERT && ARCH_SUPPORTS_RT
>       select PREEMPTION
>       help
>         This option turns the kernel into a real-time kernel by
> replacing

This we can't get away from IMO - it's pretty much the same issue as

  b8d3349803ba ("sched/rt, Kconfig: Unbreak def/oldconfig with CONFIG_PREEMPT=y")

IOW we can't really touch those preempt configs, but rather add stuff
around them.

> @@ -75,17 +74,6 @@ config PREEMPT_RT
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
>
> @@ -95,8 +83,7 @@ config PREEMPTION
>
>  config PREEMPT_DYNAMIC
>       bool "Preemption behaviour defined on boot"
> -	depends on HAVE_PREEMPT_DYNAMIC
> -	select PREEMPT
> +	depends on HAVE_PREEMPT_DYNAMIC && PREEMPT

I got there too. If we look at x86 defconfig, it selects
PREEMPT_VOLUNTARY. I initially tried making it so PREEMPT_VOLUNTARY means
both:

  - VOLUNTARY model if !PREEMPT_DYNAMIC
  - VOLUNTARY model as default boot-time mode if PREEMPT_DYNAMIC
  (& similar for other preemption modes)

which, now that I've played with it, is a sad wreck. Having PREEMPT_DYNAMIC
depend on PREEMPT at least makes things clear, and defconfig choices remain
respected (they just won't get PREEMPT_DYNAMIC if they didn't pick
PREEMPT).

>       default y
>       help
>         This option allows to define the preemption model on the
> kernel
> @@ -114,6 +101,23 @@ config PREEMPT_DYNAMIC
>         Interesting if you want the same pre-built kernel should be
> used for
>         both Server and Desktop workloads.
>
> +if PREEMPT_DYNAMIC

AFAICT that should be

  depends on PREEMPT_DYNAMIC

within the choice itself. See e.g. "Kernel compression mode" choice in
init/Kconfig.

> +choice
> +	prompt "Boot Time Preemption Model"

Default boot-time [...]? This is only used if the cmdline parameter is
missing. Also a help-text wouldn't hurt. I had:

          This option defines the default preemption model of the kernel
          if it hasn't been specified by the command line parameter.

> +	default PREEMPT_NONE_BEHAVIOR
> +
> +config PREEMPT_NONE_BEHAVIOR
> +	bool "No Forced Preemption (Server)"
> +
> +config PREEMPT_VOLUNTARY_BEHAVIOR
> +	bool "Voluntary Kernel Preemption (Desktop)"
> +
> +config PREEMPT_BEHAVIOR
> +	bool "Preemptible Kernel (Low-Latency Desktop)"
> +
> +endchoice
> +endif # PREEMPT_DYNAMIC
> +
>  config SCHED_CORE
>       bool "Core Scheduling for SMT"
>       depends on SCHED_SMT
