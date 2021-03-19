Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991903427D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhCSVbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 17:31:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39724 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhCSVaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:30:52 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616189451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OIrn62Jabx8YZbo0dlW83NMOhEH+SN62wnApX+JD0MY=;
        b=q7iKvEKt1c96SW2RY8Jm+vOSsY1D+TSFDHyynDyr5hdXtPYMgzBh7oj+LG4DYz1SFTvLBA
        w89mg3gprHVeS9ph99TyTLwJOyxIyDnzV4OpyPF4sDbhTwfOBBB+WtkEiCjpBvwLcbX+gF
        Q+rWDPYpmkHiW86RyUsPF78m2aVb+GUVXIKYWejgJ5MNtTnHvEeLyRvCgsbJRwRqVD6kIP
        JPJsDOq+l/GSA/nY7LOf84nHeM5zuEwlO0Mpii9Htd64AKB3C5gHBNaPbCJj60s0Bb6h9G
        QW57a9mrcRdEemZ0Zd2gHWRPUyBZ46SqIeRYTtK7bSYTKoEkLTDP3nHo6cPImg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616189451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OIrn62Jabx8YZbo0dlW83NMOhEH+SN62wnApX+JD0MY=;
        b=9gnAbB34Dm65IukQxtCHjyVJ3gDded/uPVVIszucKjzJ2KVyscsAi3odbRHCVhb280UrIk
        8yXyIRRuQvq6OTDA==
To:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v5 2/3] x86/bus_lock: Handle #DB for bus lock
In-Reply-To: <20210313054910.2503968-3-fenghua.yu@intel.com>
References: <20210313054910.2503968-1-fenghua.yu@intel.com> <20210313054910.2503968-3-fenghua.yu@intel.com>
Date:   Fri, 19 Mar 2021 22:30:50 +0100
Message-ID: <871rca6dbp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13 2021 at 05:49, Fenghua Yu wrote:
> Change Log:
> v5:
> Address all comments from Thomas:
> - Merge patch 2 and patch 3 into one patch so all "split_lock_detect="
>   options are processed in one patch.

What? I certainly did not request that. I said:

 "Why is this seperate and an all in one thing? patch 2/4 changes the
  parameter first and 3/4 adds a new option...."

which means we want documentation for patch 2 and documentation for
patch 3? 

The ratelimit thing is clearly an extra functionality on top of that
buslock muck.

Next time I write it out..

> +	if (sscanf(arg, "ratelimit:%d", &ratelimit) == 1 && ratelimit > 0) {
> +		bld_ratelimit = ratelimit;

So any rate up to INTMAX/s is valid here, right?

> +	case sld_ratelimit:
> +		/* Enforce no more than bld_ratelimit bus locks/sec. */
> +		while (!__ratelimit(&get_current_user()->bld_ratelimit))
> +			msleep(1000 / bld_ratelimit);

which is cute because msleep() will always sleep until the next jiffie
increment happens.

What's not so cute here is the fact that get_current_user() takes a
reference on current's UID on every invocation, but nothing ever calls
free_uid(). I missed that last time over the way more obvious HZ division.

> +++ b/kernel/user.c
> @@ -103,6 +103,9 @@ struct user_struct root_user = {
>  	.locked_shm     = 0,
>  	.uid		= GLOBAL_ROOT_UID,
>  	.ratelimit	= RATELIMIT_STATE_INIT(root_user.ratelimit, 0, 0),
> +#ifdef CONFIG_CPU_SUP_INTEL
> +	.bld_ratelimit	= RATELIMIT_STATE_INIT(root_user.bld_ratelimit, 0, 0),
> +#endif
>  };
>  
>  /*
> @@ -172,6 +175,11 @@ void free_uid(struct user_struct *up)
>  		free_user(up, flags);
>  }
>  
> +#ifdef CONFIG_CPU_SUP_INTEL
> +/* Some Intel CPUs may set this for rate-limited bus locks. */
> +int bld_ratelimit;
> +#endif

Of course this variable is still required to be in the core kernel code
because?

While you decided to munge this all together, you obviously ignored the
following review comment:

  "It also lacks the information that the ratelimiting is per UID
   and not per task and why this was chosen to be per UID..."

There is still no reasoning neither in the changelog nor in the cover
letter nor in a reply to my review.

So let me repeat my question and make it more explicit:

  What is the justifucation for making this rate limit per UID and not
  per task, per process or systemwide?

>  struct user_struct *alloc_uid(kuid_t uid)
>  {
>  	struct hlist_head *hashent = uidhashentry(uid);
> @@ -190,6 +198,11 @@ struct user_struct *alloc_uid(kuid_t uid)
>  		refcount_set(&new->__count, 1);
>  		ratelimit_state_init(&new->ratelimit, HZ, 100);
>  		ratelimit_set_flags(&new->ratelimit, RATELIMIT_MSG_ON_RELEASE);
> +#ifdef CONFIG_CPU_SUP_INTEL
> +		ratelimit_state_init(&new->bld_ratelimit, HZ, bld_ratelimit);
> +		ratelimit_set_flags(&new->bld_ratelimit,
> +				    RATELIMIT_MSG_ON_RELEASE);
> +#endif

If this has a proper justification for being per user and having to add
40 bytes per UID for something which is mostly unused then there are
definitely better ways to do that than slapping #ifdefs into
architecture agnostic core code.

So if you instead of munging the code patches had split the
documentation, then I could apply the first 3 patches and we would only
have to sort out the ratelimiting muck.

Thanks,

        tglx
