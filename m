Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A10354936
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbhDEX1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhDEX1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:27:04 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01548C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 16:26:57 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id o19so6288431qvu.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 16:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dgrgz6s6MuTmt3woCtx9DD4I5lovyoCGjc37MCiv5qA=;
        b=egq7hxnq9RPKsnMJc3urIAsaEK+XvjB6xArSWcgy0U8oSuzD4ANBsScIKCtxQHy49v
         t2M6OWgG+5wTyYESHOblGQarJDgOTBoDx0jD2aZEi2Smw5ZtlI+LTLh6o8b1aFUWyoMG
         ipoTVfbj1MFhCiwTT7/bnIQ4x3sQAwApZzHg7FLfb52uhTeAR8uHiLebKKZAmk01A5iS
         xY/PTN7z4sCHr8RF/LEnn0lXT8Hil6CpNDADEKSTe+2+boSEFicy78feVO20K0GZ3wP3
         XdlpPRrbhb2pQ6utRBd+Q9pN41CL7HTNEeqH8cPP6KGQ78Sj8p4ZS3uBPhFsJArCIfoJ
         WCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dgrgz6s6MuTmt3woCtx9DD4I5lovyoCGjc37MCiv5qA=;
        b=UNNKXhm5WF+F4oQOxIaD92nB3LUiShlX6Lplh+VQDpS+Mgr6alZfK8XhAXANgEndmo
         DxUkIgMevb5Xf8ZYstpXC3OhgWhQUpoloqLKEXbGtNMg8ehZFhU/YUYBblEDlLtReXrt
         LKbjOPldBWf6h3tBZIfXJQuIBg/APjvps+HO5iqoyIE3I7Emtqc9EtHtsbCM+iJHeuAZ
         qDIU41Ihrd78D7lA1iy9Ht1BsE1pqpDi66g45De9Q0FH+dDtixuIUedMSJ8yqwFjXgph
         bWtmknDirWos3VP0yVo+i8QdJ4FXBI7+udZhZmGasF9FCYLdytBeHkAQJ53wJmeZGjmC
         OrcQ==
X-Gm-Message-State: AOAM531nGCQBJqye7bddkEDXEFbsmC2jvGFIXDl3fbLoJ87dNP+T66yE
        AVFDA3f+HsZktxtJ7CIlRTA=
X-Google-Smtp-Source: ABdhPJyF6kzzgz/XDuuhxCvul3ZfMSvN+BXnaifSY57hyStOw7YdAwfjEQSCqdI4iq4Ho3hgHFGO+A==
X-Received: by 2002:a0c:d7ca:: with SMTP id g10mr25528734qvj.16.1617665217064;
        Mon, 05 Apr 2021 16:26:57 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id e14sm13154081qte.78.2021.04.05.16.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 16:26:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4886E27C0054;
        Mon,  5 Apr 2021 19:26:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 05 Apr 2021 19:26:56 -0400
X-ME-Sender: <xms:vpxrYOX_-sWeI6qWDETCVhJ0ghES7gs7fBaP_HzszP2V4xULDzFjsg>
    <xme:vpxrYKnO2JKI3ypAgyNSzFGP690werBoAafxyLAO4277TShJsbNZBRk786igRfNQk
    GUMR_VIaN2VQqPI8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejfedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvffukfhfgggtuggj
    sehttdortddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvg
    hnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepvdevteeludelffeitdef
    tdfgvddvheduueeuvdegvdfgkeeuledthedtudevveejnecuffhomhgrihhnpehshiiikh
    grlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhgohhoghhlvgdrtghomhenucfkphepudef
    uddruddtjedrudegjedruddvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:vpxrYCYsKFmW74SYBI2MmvrcE3fY9zBC5LC_J7LdkbjMVSH5WBm-RA>
    <xmx:vpxrYFVcsPnanReJRvrTSpwisuwJQlYOxf9HVqEbxdhzrpAMCSVX_Q>
    <xmx:vpxrYIlyq9OceY5vvpW0QJoOYbWoD3_Fx0F2BRq-G16aUApyCEFNaQ>
    <xmx:wJxrYCVVp_GnAsGGSwWQv4UWmDy18QJ8Tn6NA30jlQ9FEln_-3YpjyxeNTQ>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 233631080054;
        Mon,  5 Apr 2021 19:26:54 -0400 (EDT)
Date:   Tue, 6 Apr 2021 07:25:44 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com>,
        john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in get_timespec64
Message-ID: <YGuceETAscvhhnqT@boqun-archlinux>
References: <0000000000000e025b05bf2a430b@google.com>
 <87mtud4wfi.ffs@nanos.tec.linutronix.de>
 <20210404214030.GB2696@paulmck-ThinkPad-P72>
 <20210405030855.GG2531743@casper.infradead.org>
 <20210405040125.GF2696@paulmck-ThinkPad-P72>
 <20210405043038.GA31091@paulmck-ThinkPad-P72>
 <YGqe0tRRpibv3/Bd@boqun-archlinux>
 <20210405172752.GK2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405172752.GK2696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 10:27:52AM -0700, Paul E. McKenney wrote:
> On Mon, Apr 05, 2021 at 01:23:30PM +0800, Boqun Feng wrote:
> > On Sun, Apr 04, 2021 at 09:30:38PM -0700, Paul E. McKenney wrote:
> > > On Sun, Apr 04, 2021 at 09:01:25PM -0700, Paul E. McKenney wrote:
> > > > On Mon, Apr 05, 2021 at 04:08:55AM +0100, Matthew Wilcox wrote:
> > > > > On Sun, Apr 04, 2021 at 02:40:30PM -0700, Paul E. McKenney wrote:
> > > > > > On Sun, Apr 04, 2021 at 10:38:41PM +0200, Thomas Gleixner wrote:
> > > > > > > On Sun, Apr 04 2021 at 12:05, syzbot wrote:
> > > > > > > 
> > > > > > > Cc + ...
> > > > > > 
> > > > > > And a couple more...
> > > > > > 
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > syzbot found the following issue on:
> > > > > > > >
> > > > > > > > HEAD commit:    5e46d1b7 reiserfs: update reiserfs_xattrs_initialized() co..
> > > > > > > > git tree:       upstream
> > > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1125f831d00000
> > > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=78ef1d159159890
> > > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=88e4f02896967fe1ab0d
> > > > > > > >
> > > > > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > > > > >
> > > > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > > > Reported-by: syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com
> > > > > > > >
> > > > > > > > =============================
> > > > > > > > WARNING: suspicious RCU usage
> > > > > > > > 5.12.0-rc5-syzkaller #0 Not tainted
> > > > > > > > -----------------------------
> > > > > > > > kernel/sched/core.c:8294 Illegal context switch in RCU-sched read-side critical section!
> > > > > > > >
> > > > > > > > other info that might help us debug this:
> > > > > > > >
> > > > > > > >
> > > > > > > > rcu_scheduler_active = 2, debug_locks = 0
> > > > > > > > 3 locks held by syz-executor.4/8418:
> > > > > > > >  #0: 
> > > > > > > > ffff8880751d2b28
> > > > > > > >  (
> > > > > > > > &p->pi_lock
> > > > > > > > ){-.-.}-{2:2}
> > > > > > > > , at: try_to_wake_up+0x98/0x14a0 kernel/sched/core.c:3345
> > > > > > > >  #1: 
> > > > > > > > ffff8880b9d35258
> > > > > > > >  (
> > > > > > > > &rq->lock
> > > > > > > > ){-.-.}-{2:2}
> > > > > > > > , at: rq_lock kernel/sched/sched.h:1321 [inline]
> > > > > > > > , at: ttwu_queue kernel/sched/core.c:3184 [inline]
> > > > > > > > , at: try_to_wake_up+0x5e6/0x14a0 kernel/sched/core.c:3464
> > > > > > > >  #2: ffff8880b9d1f948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_change+0x142/0x220 kernel/sched/psi.c:807
> > > > > > 
> > > > > > This looks similar to syzbot+dde0cc33951735441301@syzkaller.appspotmail.com
> > > > > > in that rcu_sleep_check() sees an RCU lock held, but the later call to
> > > > > > lockdep_print_held_locks() does not.  Did something change recently that
> > > > > > could let the ->lockdep_depth counter get out of sync with the actual
> > > > > > number of locks held?
> > > > > 
> > > > > Dmitri had a different theory here:
> > > > > 
> > > > > https://groups.google.com/g/syzkaller-bugs/c/FmYvfZCZzqA/m/nc2CXUgsAgAJ
> > > > 
> > > > There is always room for more than one bug.  ;-)
> > > > 
> > > > He says "one-off false positives".  I was afraid of that...
> > > 
> > > And both the examples I have been copied on today are consistent with
> > > debug_locks getting zeroed (e.g., via a call to __debug_locks_off())
> > > in the midst of a call to rcu_sleep_check().  But I would expect to see
> > > a panic or another splat if that were to happen.
> > > 
> > > Dmitry's example did have an additional splat, but I would expect the
> > > RCU-related one to come second.  Again, there is always room for more
> > > than one bug.
> > > 
> > > On the other hand, there are a lot more callers to debug_locks_off()
> > > than there were last I looked into this.  And both of these splats
> > > are consistent with an interrupt in the middle of rcu_sleep_check(),
> > > and that interrupt's handler invoking debug_locks_off(), but without
> > > printing anything to the console.  Does that sequence of events ring a
> > > bell for anyone?
> > > 
> > > If this is the new normal, I could make RCU_LOCKDEP_WARN() recheck
> > > debug_lockdep_rcu_enabled() after evaluating the condition, but with
> > > a memory barrier immediately before the recheck.  But I am not at all
> > > excited by doing this on speculation.  Especially given that doing
> > > so might be covering up some other bug.
> > > 
> > 
> > Just check the original console log and find:
> > 
> > [  356.696686][ T8418] =============================
> > [  356.696692][ T8418] WARNING: suspicious RCU usage
> > [  356.700193][T14782] ====================================
> > [  356.704548][ T8418] 5.12.0-rc5-syzkaller #0 Not tainted
> > [  356.729981][ T8418] -----------------------------
> > [  356.732473][T14782] WARNING: iou-sqp-14780/14782 still has locks held!
> > 
> > , so there are two warnnings here, one is from lockdep_rcu_suspisous()
> > and the other is from print_held_locks_bug(). I think this is what
> > happened:
> > 
> > in RCU_LOCKDEP_WARN():
> > 
> > 	if (debug_lockdep_rcu_enabled() // this is true and at this time debug_locks = 1
> > 	<interrupted>
> > 	// lockdep detects a lock bug, set debug_locks = 0
> > 	<swicth back>
> > 	    && !__warned // true
> > 	    && (c))      // "c" is a lock_is_held(), which will always returns true if debug_locks == 0!
> > 
> > the cause of the problem is that RCU_LOCKDEP_WARN() in fact read
> > debug_locks twice and get different values.
> > 
> > But if you change the ordering of two reads, probably can avoid the
> > problem:
> > 	
> > First read:
> > 	lock_is_held(); // true if 1) lock is really held or 2) lockdep is off
> > 
> > Second read:
> > 	debug_lockdep_rcu_enabled(); // if lockdep is not off, we know
> > 				     // that the first read got correct
> > 				     // value, otherwise we just ignore
> > 				     // the first read, because either
> > 				     // there is a bug reported between
> > 				     // two reads, or lockdep is already
> > 				     // off when the first read happens.
> > 
> > So maybe something below:
> > 
> > Regards,
> > Boqun
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index bd04f722714f..d11bee5d9347 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -315,7 +315,7 @@ static inline int rcu_read_lock_any_held(void)
> >  #define RCU_LOCKDEP_WARN(c, s)						\
> >  	do {								\
> >  		static bool __section(".data.unlikely") __warned;	\
> > -		if (debug_lockdep_rcu_enabled() && !__warned && (c)) {	\
> > +		if ((c) && debug_lockdep_rcu_enabled() && !__warned) {	\
> >  			__warned = true;				\
> >  			lockdep_rcu_suspicious(__FILE__, __LINE__, s);	\
> >  		}							\
> 
> Good point -- if we check debug_lockdep_rcu_enabled() after the condition,
> then we will reject false positives in cases where debug_locks was switched
> to zero out from under us.
> 
> However, we do need ordering.  The "c" usually contains lock_is_held(),
> which also checks debug_locks, but from some other translation unit.
> Back in the day, the translation-unit boundaries would provide the needed
> ordering, but LTO...
> 
> In addition, the "debug_locks = 0" was originally supposed to be a hint
> that the report might be a false positive.  It is clear that this needs
> to be made explicit.
> 
> Taking all this together, how about the following?  (The intent is
> that the changes to lockdep_rcu_suspicious() will be in a separate
> commit.)
> 

Looks good to me ;-)

Regards,
Boqun

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 9455476..1199ffd 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -315,7 +315,7 @@ static inline int rcu_read_lock_any_held(void)
>  #define RCU_LOCKDEP_WARN(c, s)						\
>  	do {								\
>  		static bool __section(".data.unlikely") __warned;	\
> -		if (debug_lockdep_rcu_enabled() && !__warned && (c)) {	\
> +		if ((c) && debug_lockdep_rcu_enabled() && !__warned) {	\
>  			__warned = true;				\
>  			lockdep_rcu_suspicious(__FILE__, __LINE__, s);	\
>  		}							\
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index c6d0c1dc..80065cd 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -6387,6 +6387,7 @@ asmlinkage __visible void lockdep_sys_exit(void)
>  void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
>  {
>  	struct task_struct *curr = current;
> +	int dl = READ_ONCE(debug_locks);
>  
>  	/* Note: the following can be executed concurrently, so be careful. */
>  	pr_warn("\n");
> @@ -6396,11 +6397,12 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
>  	pr_warn("-----------------------------\n");
>  	pr_warn("%s:%d %s!\n", file, line, s);
>  	pr_warn("\nother info that might help us debug this:\n\n");
> -	pr_warn("\n%srcu_scheduler_active = %d, debug_locks = %d\n",
> +	pr_warn("\n%srcu_scheduler_active = %d, debug_locks = %d\n%s",
>  	       !rcu_lockdep_current_cpu_online()
>  			? "RCU used illegally from offline CPU!\n"
>  			: "",
> -	       rcu_scheduler_active, debug_locks);
> +	       rcu_scheduler_active, dl,
> +	       dl ? "" : "Possible false positive due to lockdep disabling via debug_locks = 0\n");
>  
>  	/*
>  	 * If a CPU is in the RCU-free window in idle (ie: in the section
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index b95ae86..dd94a60 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -277,7 +277,7 @@ EXPORT_SYMBOL_GPL(rcu_callback_map);
>  
>  noinstr int notrace debug_lockdep_rcu_enabled(void)
>  {
> -	return rcu_scheduler_active != RCU_SCHEDULER_INACTIVE && debug_locks &&
> +	return rcu_scheduler_active != RCU_SCHEDULER_INACTIVE && READ_ONCE(debug_locks) &&
>  	       current->lockdep_recursion == 0;
>  }
>  EXPORT_SYMBOL_GPL(debug_lockdep_rcu_enabled);
