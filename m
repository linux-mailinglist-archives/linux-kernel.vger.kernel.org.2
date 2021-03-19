Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E38F34289A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 23:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhCSWTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 18:19:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:52513 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230297AbhCSWTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:19:10 -0400
IronPort-SDR: MpUJZph8jZoM+qv8jDkiTxgQ7/zGXkiUIKBwPguhMph2Elh1RAQXoGAzBkXfl6hlS4i2tc/Alu
 dCEsM6Uzr3uQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="189357253"
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="189357253"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 15:19:09 -0700
IronPort-SDR: lJdPNIJvVszJsBsoTrkgI8gX/cg13iaVNUwfAwsRfpCNx5FdtXyQqdWKkMK1cIYfuT3XRAiZB1
 PcU37/sICNPg==
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="413681559"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 15:19:09 -0700
Date:   Fri, 19 Mar 2021 22:19:03 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v5 2/3] x86/bus_lock: Handle #DB for bus lock
Message-ID: <YFUjVwBg133LN+kS@otcwcpicx3.sc.intel.com>
References: <20210313054910.2503968-1-fenghua.yu@intel.com>
 <20210313054910.2503968-3-fenghua.yu@intel.com>
 <871rca6dbp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rca6dbp.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On Fri, Mar 19, 2021 at 10:30:50PM +0100, Thomas Gleixner wrote:
> On Sat, Mar 13 2021 at 05:49, Fenghua Yu wrote:
> > Change Log:
> > v5:
> > Address all comments from Thomas:
> > - Merge patch 2 and patch 3 into one patch so all "split_lock_detect="
> >   options are processed in one patch.
> 
> What? I certainly did not request that. I said:
> 
>  "Why is this seperate and an all in one thing? patch 2/4 changes the
>   parameter first and 3/4 adds a new option...."
> 
> which means we want documentation for patch 2 and documentation for
> patch 3? 
> 
> The ratelimit thing is clearly an extra functionality on top of that
> buslock muck.
> 
> Next time I write it out..

Sorry for misunderstanding your comments. I will split the document patch
into two: one for patch 2 (warn and fatal) and one for patch 3 (ratelimit).

> 
> > +	if (sscanf(arg, "ratelimit:%d", &ratelimit) == 1 && ratelimit > 0) {
> > +		bld_ratelimit = ratelimit;
> 
> So any rate up to INTMAX/s is valid here, right?

Yes. I don't see smaller limitation than INTMX/s. Is that right?

> 
> > +	case sld_ratelimit:
> > +		/* Enforce no more than bld_ratelimit bus locks/sec. */
> > +		while (!__ratelimit(&get_current_user()->bld_ratelimit))
> > +			msleep(1000 / bld_ratelimit);
> 
> which is cute because msleep() will always sleep until the next jiffie
> increment happens.
> 
> What's not so cute here is the fact that get_current_user() takes a
> reference on current's UID on every invocation, but nothing ever calls
> free_uid(). I missed that last time over the way more obvious HZ division.

I will call free_uid().

> 
> > +++ b/kernel/user.c
> > @@ -103,6 +103,9 @@ struct user_struct root_user = {
> >  	.locked_shm     = 0,
> >  	.uid		= GLOBAL_ROOT_UID,
> >  	.ratelimit	= RATELIMIT_STATE_INIT(root_user.ratelimit, 0, 0),
> > +#ifdef CONFIG_CPU_SUP_INTEL
> > +	.bld_ratelimit	= RATELIMIT_STATE_INIT(root_user.bld_ratelimit, 0, 0),
> > +#endif
> >  };
> >  
> >  /*
> > @@ -172,6 +175,11 @@ void free_uid(struct user_struct *up)
> >  		free_user(up, flags);
> >  }
> >  
> > +#ifdef CONFIG_CPU_SUP_INTEL
> > +/* Some Intel CPUs may set this for rate-limited bus locks. */
> > +int bld_ratelimit;
> > +#endif
> 
> Of course this variable is still required to be in the core kernel code
> because?
> 
> While you decided to munge this all together, you obviously ignored the
> following review comment:
> 
>   "It also lacks the information that the ratelimiting is per UID
>    and not per task and why this was chosen to be per UID..."
> 
> There is still no reasoning neither in the changelog nor in the cover
> letter nor in a reply to my review.
> 
> So let me repeat my question and make it more explicit:
> 
>   What is the justifucation for making this rate limit per UID and not
>   per task, per process or systemwide?

Tony jut now answered the justification. If that's OK, I will add the
answer in the commit message.

> 
> >  struct user_struct *alloc_uid(kuid_t uid)
> >  {
> >  	struct hlist_head *hashent = uidhashentry(uid);
> > @@ -190,6 +198,11 @@ struct user_struct *alloc_uid(kuid_t uid)
> >  		refcount_set(&new->__count, 1);
> >  		ratelimit_state_init(&new->ratelimit, HZ, 100);
> >  		ratelimit_set_flags(&new->ratelimit, RATELIMIT_MSG_ON_RELEASE);
> > +#ifdef CONFIG_CPU_SUP_INTEL
> > +		ratelimit_state_init(&new->bld_ratelimit, HZ, bld_ratelimit);
> > +		ratelimit_set_flags(&new->bld_ratelimit,
> > +				    RATELIMIT_MSG_ON_RELEASE);
> > +#endif
> 
> If this has a proper justification for being per user and having to add
> 40 bytes per UID for something which is mostly unused then there are
> definitely better ways to do that than slapping #ifdefs into
> architecture agnostic core code.
> 
> So if you instead of munging the code patches had split the
> documentation, then I could apply the first 3 patches and we would only
> have to sort out the ratelimiting muck.

If I split this whole patch set into two patch sets:
1. Three patches in the first patch set: the enumeration patch, the warn
   and fatal patch, and the documentation patch.
2. Two patches in the second patch set: the ratelimit patch and the
   documentation patch.

Then I will send the two patch sets separately, you will accept them one
by one. Is that OK?

Or should I still send the 5 patches in one patch set so you will pick up
the first 3 patches and then the next 2 patches separately?

Thanks.

-Fenghua

