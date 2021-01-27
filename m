Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235103066EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 23:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbhA0V7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:59:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59160 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhA0V6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:58:09 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611784634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Zhp8BY1L3z20FaXq3p+9C072rkcpPPTDTAFJ4kLpqI=;
        b=xstBLvllXb0Nv7/5FTW3svXCS2e1HunqdK/J0WZxt6XSJbfPqpaxhoZ3y957u3jJQiBxFH
        gfDTR08Nbm/X5vW2Gpj+5clXLoa9jvJFtOB//Y/4dpUiXFQAaI8PuylpfD3LO4VhiPtLvf
        3NlI9+QFOK2AOle15BhlZj1G+OsYJYWuXFnhK1DXDXAbMq02KfTGZSuONtsWkWVSKBBTJL
        2pI+GZpFZGuQcvDybSGP6OKr1gapQcDZZ0RzKqayI+ECcR9jE1f1uoNo583PtihgLg5wT7
        VYgvJRky+BCwe6TzWSjMlxSrqp6geQQN+q7NaokjJKUXa7G1Hw2rCFT64Si5TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611784634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Zhp8BY1L3z20FaXq3p+9C072rkcpPPTDTAFJ4kLpqI=;
        b=CfHifbJzaWqq2XLgwoFm1k7CU7pdW4+fpnjBOcJ85Fp2Cgh2cIpYqsoaXKlUylRgXflVRb
        KMN1jApFXSB7eMAw==
To:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v4 3/4] x86/bus_lock: Set rate limit for bus lock
In-Reply-To: <20201124205245.4164633-4-fenghua.yu@intel.com>
References: <20201124205245.4164633-1-fenghua.yu@intel.com> <20201124205245.4164633-4-fenghua.yu@intel.com>
Date:   Wed, 27 Jan 2021 22:57:14 +0100
Message-ID: <87r1m6dow5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24 2020 at 20:52, Fenghua Yu wrote:
> To enforce user application throttling or mitigations, extend the
> existing split lock detect kernel parameter:
> 	split_lock_detect=ratelimit:N
>
> It limits bus lock rate to N per second for non-root users.

Yet another changelog which describes what it does without giving some
clue why. It also lacks the information that the ratelimiting is per UID
and not per task and why this was chosen to be per UID...

> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 35 ++++++++++++++++++++++++++++++-----
>  include/linux/sched/user.h  |  4 +++-
>  kernel/user.c               |  7 +++++++
>  3 files changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 77c3e33f41c7..5eb5822a446d 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -10,6 +10,9 @@
>  #include <linux/thread_info.h>
>  #include <linux/init.h>
>  #include <linux/uaccess.h>
> +#include <linux/cred.h>
> +#include <linux/delay.h>
> +#include <linux/sched/user.h>
>  
>  #include <asm/cpufeature.h>
>  #include <asm/msr.h>
> @@ -40,6 +43,7 @@ enum split_lock_detect_state {
>  	sld_off = 0,
>  	sld_warn,
>  	sld_fatal,
> +	sld_ratelimit,
>  };
>  
>  /*
> @@ -998,13 +1002,25 @@ static const struct {
>  	{ "off",	sld_off   },
>  	{ "warn",	sld_warn  },
>  	{ "fatal",	sld_fatal },
> +	{ "ratelimit:", sld_ratelimit },
>  };
>  
>  static inline bool match_option(const char *arg, int arglen, const char *opt)
>  {
> -	int len = strlen(opt);
>  
> -	return len == arglen && !strncmp(arg, opt, len);
> +	int len = strlen(opt), ratelimit;
> +
> +	if (strncmp(arg, opt, len))
> +		return false;
> +
> +	if (sscanf(arg, "ratelimit:%d", &ratelimit) == 1 && ratelimit > 0 &&
> +	    ratelimit_bl <= HZ / 2) {

That last part condition of the condition is always true because
ratelimit_bl is a global variable in the BSS and nothing else than the
below writes to it. So INT_MAX is a valid argument ....

> +		ratelimit_bl = ratelimit;

Can you please use consistent name spaces? bld_XXX all over the place?

>  static void split_lock_init(void)
>  {
>  	/*
> -	 * If supported, #DB for bus lock will handle warn
> +	 * If supported, #DB for bus lock will handle warn or ratelimit
>  	 * and #AC for split lock is disabled.
>  	 */
> -	if (bld && sld_state == sld_warn) {
> +	if ((bld && sld_state == sld_warn) || sld_state == sld_ratelimit) {

...

> -	if ((regs->flags & X86_EFLAGS_AC) || !sld || sld_state == sld_fatal)
> +	if ((regs->flags & X86_EFLAGS_AC) || !sld || sld_state == sld_fatal ||
> +	    sld_state == sld_ratelimit)

These conditions are uncomprehensible by now

>  		return false;
>  	split_lock_warn(regs->ip);
>  	return true;
> @@ -1168,6 +1185,10 @@ void handle_bus_lock(struct pt_regs *regs)
>  	case sld_fatal:
>  		force_sig_fault(SIGBUS, BUS_ADRALN, NULL);
>  		break;
> +	case sld_ratelimit:
> +		while (!__ratelimit(&get_current_user()->ratelimit_bl))
> +			msleep(1000 / ratelimit_bl);

Yikes. That's really creative abuse of the ratelimit mechanics of course
without any comment how this is supposed to work.

> diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
> index a8ec3b6093fc..79f95002a123 100644
> --- a/include/linux/sched/user.h
> +++ b/include/linux/sched/user.h
> @@ -40,8 +40,9 @@ struct user_struct {
>  	atomic_t nr_watches;	/* The number of watches this user currently has */
>  #endif
>  
> -	/* Miscellaneous per-user rate limit */
> +	/* Miscellaneous per-user rate limits */
>  	struct ratelimit_state ratelimit;
> +	struct ratelimit_state ratelimit_bl;

Why has every architecture to carry this if only one out of N uses it?

Thanks,

        tglx


