Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CC744C054
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhKJLuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhKJLuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:50:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E08C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:47:17 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 133so1925759wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=umR5iBN7pjGiLsPcY9AMuKh/IuBTQ+X++uZcfgH2P9c=;
        b=eHievmFecTi+ZWGkI6KAA6oSiJJTfTvbeK29E+pT7hQlse6GTwpbWuvnlDWpuKDobJ
         QZdbCmktwHo6MeIMkfu+XK9RJzdMNKyieJvGxybWeAMML9oIG/IcYHf1EqfXzg2zp4kS
         gESV35Vji6P11cCAhTpgoMb+ul8xEEUffIG41wcu/LNHqNqAFMEG007KzdCbCmpe/MKW
         xP3wqiTSudEkIVsa0t7h5wX4i2apga7Md3aA79xmd1H/cSAAkiJP5HmtH+MO5sAThiVn
         1rEhy8zl5kCPBLCCsh9PDNl/rDs/hFq89qISa0LMh9f2i7d4uMcFGWOz0WinPiNSehO6
         +90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=umR5iBN7pjGiLsPcY9AMuKh/IuBTQ+X++uZcfgH2P9c=;
        b=s/Q7e6pIFAiyxn7SUR9Ph5mxmRo3KDnAu3DPAidHYrrVd39Fp0hZmZWyWGYPy/QjYI
         JwkxCsVmx5i/nh7wQ7//miDIO0tL1HIx7uz45DndGn4B+r8QhvIS/Xitbbp8aNBFGrGb
         hzPx9K4wgW3RrRf1Iz86fWNcdhGDEPKxwinJEIuns5KrpwF6dVY2JMv+uNl0Lf4tJBRn
         XW+UIdgCF4NtdpzrXvYo8wPX9nlKMs4jf5RnAH2aGgdNT/5rP0VuIfkmTnqunbM+fvos
         ucxddMnIIeIHitnYtVDb2LtRX58FVRuxqVeZjUyV+R63l+UCIhVf0mCQPSs+eY48yux6
         6gQg==
X-Gm-Message-State: AOAM532B0fvFgEkvipiUeNOMUu1iEDr7uqiwe5L50UXlI1uBO5ycHxw4
        xJS3YgIx5IW8qNRTsuqMzPA6EJD0IbWlSw==
X-Google-Smtp-Source: ABdhPJzdOKrPJrVkwKeuPM724zCfKUyPxmeSNkwyYfg1GE9tJnL1ywDHej/Vk4WrO9K+ZeKwJVTx8w==
X-Received: by 2002:a05:600c:ac2:: with SMTP id c2mr15489170wmr.118.1636544469458;
        Wed, 10 Nov 2021 03:41:09 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:5b79:8e57:35c2:52])
        by smtp.gmail.com with ESMTPSA id 4sm30999670wrz.90.2021.11.10.03.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:41:08 -0800 (PST)
Date:   Wed, 10 Nov 2021 12:41:03 +0100
From:   Marco Elver <elver@google.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] sched: Provide Kconfig support for default dynamic
 preempt mode
Message-ID: <YYuvzzZPuIZPe2iU@elver.google.com>
References: <20210914103134.11309-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914103134.11309-1-frederic@kernel.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:31PM +0200, Frederic Weisbecker wrote:
> Currently the boot defined preempt behaviour (aka dynamic preempt)
> selects full preemption by default when the "preempt=" boot parameter
> is omitted. However distros may rather want to default to either
> no preemption or voluntary preemption.
> 
> To provide with this flexibility, make dynamic preemption a visible
> Kconfig option and adapt the preemption behaviour selected by the user
> to either static or dynamic preemption.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/Kconfig.preempt | 32 +++++++++++++++++++++++---------
>  kernel/sched/core.c    | 29 ++++++++++++++++++++++++++---
>  2 files changed, 49 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index 5876e30c5740..60f1bfc3c7b2 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -2,10 +2,11 @@
>  
>  choice
>  	prompt "Preemption Model"
> -	default PREEMPT_NONE
> +	default PREEMPT_NONE_BEHAVIOUR
>  
> -config PREEMPT_NONE
> +config PREEMPT_NONE_BEHAVIOUR
>  	bool "No Forced Preemption (Server)"
> +	select PREEMPT_NONE if !PREEMPT_DYNAMIC
>  	help
>  	  This is the traditional Linux preemption model, geared towards
>  	  throughput. It will still provide good latencies most of the
> @@ -17,9 +18,10 @@ config PREEMPT_NONE
>  	  raw processing power of the kernel, irrespective of scheduling
>  	  latencies.
>  
> -config PREEMPT_VOLUNTARY
> +config PREEMPT_VOLUNTARY_BEHAVIOUR
>  	bool "Voluntary Kernel Preemption (Desktop)"
>  	depends on !ARCH_NO_PREEMPT
> +	select PREEMPT_VOLUNTARY if !PREEMPT_DYNAMIC
>  	help
>  	  This option reduces the latency of the kernel by adding more
>  	  "explicit preemption points" to the kernel code. These new
> @@ -35,12 +37,10 @@ config PREEMPT_VOLUNTARY
>  
>  	  Select this if you are building a kernel for a desktop system.
>  
> -config PREEMPT
> +config PREEMPT_BEHAVIOUR
>  	bool "Preemptible Kernel (Low-Latency Desktop)"
>  	depends on !ARCH_NO_PREEMPT
> -	select PREEMPTION
> -	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
> -	select PREEMPT_DYNAMIC if HAVE_PREEMPT_DYNAMIC
> +	select PREEMPT
>  	help
>  	  This option reduces the latency of the kernel by making
>  	  all kernel code (that is not executing in a critical section)
> @@ -58,7 +58,7 @@ config PREEMPT
>  
>  config PREEMPT_RT
>  	bool "Fully Preemptible Kernel (Real-Time)"
> -	depends on EXPERT && ARCH_SUPPORTS_RT
> +	depends on EXPERT && ARCH_SUPPORTS_RT && !PREEMPT_DYNAMIC
>  	select PREEMPTION
>  	help
>  	  This option turns the kernel into a real-time kernel by replacing
> @@ -75,6 +75,17 @@ config PREEMPT_RT
>  
>  endchoice
>  
> +config PREEMPT_NONE
> +	bool
> +
> +config PREEMPT_VOLUNTARY
> +	bool
> +
> +config PREEMPT
> +	bool
> +	select PREEMPTION
> +	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK

This change landed in mainline, and I only noticed this because I've
been staring at configs too much and the preemption of some test kernels
(syzbot) has changed.

Those are "just" test kernels for now, but I expect this to proliferate
to a significant number of other configs with automated scripts
accepting new default config values or inattentive humans.

My bet is that some major distros will accidentally configure the
defaults and instead of 'full'/'voluntary' preemption will end up with
'none' as the default.

The main problem is that PREEMPT_NONE/PREEMPT_VOLUNATRY/PREEMPT are no
longer user-settable and are only selectable by other config options.
Because the *_BEHAVIOUR configs are new, the default will be
PREEMPT_NONE_BEHAVIOUR.

For example, an old 5.15 config has:

	$ grep PREEMPT .config
	# CONFIG_PREEMPT_NONE is not set
	CONFIG_PREEMPT_VOLUNTARY=y
	# CONFIG_PREEMPT is not set
	CONFIG_HAVE_PREEMPT_DYNAMIC=y
	# CONFIG_PREEMPTIRQ_DELAY_TEST is not set

A new 5.16 config with this patch, after migrating the old config:

	$ yes '' | make oldconfig
	$ grep PREEMPT .config
	CONFIG_PREEMPT_NONE_BEHAVIOUR=y
	# CONFIG_PREEMPT_VOLUNTARY_BEHAVIOUR is not set
	# CONFIG_PREEMPT_BEHAVIOUR is not set
	CONFIG_PREEMPT=y
	CONFIG_PREEMPT_COUNT=y
	CONFIG_PREEMPTION=y
	CONFIG_PREEMPT_DYNAMIC=y
	CONFIG_PREEMPT_RCU=y
	CONFIG_HAVE_PREEMPT_DYNAMIC=y
	CONFIG_DEBUG_PREEMPT=y
	# CONFIG_PREEMPT_TRACER is not set
	# CONFIG_PREEMPTIRQ_DELAY_TEST is not set

Is there some way to avoid introducing *_BEHAVIOUR and keep the old
user-settable config options?

That would make the transition more seamless and avoid this predictable
issue when 5.16 is released.

Thanks,
-- Marco
