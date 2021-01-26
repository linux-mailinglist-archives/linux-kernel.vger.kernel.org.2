Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0D730500E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbhA0DnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:43:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728291AbhAZWSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:18:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03B8F2065D;
        Tue, 26 Jan 2021 22:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611699476;
        bh=avnb89epXY17wmd58T7YmnHAkYv1wezl3UZyJ0MdJCI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EDU6iWaNswXQd25X5iZE9xQy4uqCObI8/PiaEuU/UyNkT3fx0g5zvEE5IgTExDedX
         Y/JTemd+0nYC4XLtHhIKm/oPVkbS7dKeV5gBSj9j4gs1f/EffabVn895dmlEQJ3xKL
         n+cZMARkSwBGJoRObsJ9ESE7MRrsHcPPlidimdgZ5XEYhj6BqCxi4T1Y9iIdDyEh3m
         SFlj7PyanqUS7NWMBYjNVZWfI/TDzQ2Bk7+DeYc5nrbllGAMJRP+t0cAv+iBhKlAiJ
         SYJHW/xpglJC8TDdNr+nP276JTUGiMIBg8xHcPRJzm62j9wr73Odm7V3qHkQohXM+G
         MgTvKez7Cx0OQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B71AB352268C; Tue, 26 Jan 2021 14:17:55 -0800 (PST)
Date:   Tue, 26 Jan 2021 14:17:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lizefan@huawei.com, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, josh@joshtriplett.org,
        Peter Zijlstra <peterz@infradead.org>, fweisbec@gmail.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 8/8] rcu: deprecate "all" option to rcu_nocbs=
Message-ID: <20210126221755.GH2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-9-paul.gortmaker@windriver.com>
 <CAAH8bW_kiReeYrXmFp=2o_YkOitsSrtN9evKaR6SWdZk8TNuoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW_kiReeYrXmFp=2o_YkOitsSrtN9evKaR6SWdZk8TNuoQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 01:36:23PM -0800, Yury Norov wrote:
> On Tue, Jan 26, 2021 at 9:12 AM Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> >
> > With the core bitmap support now accepting "N" as a placeholder for
> > the end of the bitmap, "all" can be represented as "0-N" and has the
> > advantage of not being specific to RCU (or any other subsystem).
> >
> > So deprecate the use of "all" by removing documentation references
> > to it.  The support itself needs to remain for now, since we don't
> > know how many people out there are using it currently, but since it
> > is in an __init area anyway, it isn't worth losing sleep over.
> >
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 4 +---
> >  kernel/rcu/tree_plugin.h                        | 6 ++----
> >  2 files changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index a10b545c2070..a116c0ff0a91 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4037,9 +4037,7 @@
> >                                 see CONFIG_RAS_CEC help text.
> >
> >         rcu_nocbs=      [KNL]
> > -                       The argument is a cpu list, as described above,
> > -                       except that the string "all" can be used to
> > -                       specify every CPU on the system.
> > +                       The argument is a cpu list, as described above.
> >
> >                         In kernels built with CONFIG_RCU_NOCB_CPU=y, set
> >                         the specified list of CPUs to be no-callback CPUs.
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 7e291ce0a1d6..56788dfde922 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -1463,14 +1463,12 @@ static void rcu_cleanup_after_idle(void)
> >
> >  /*
> >   * Parse the boot-time rcu_nocb_mask CPU list from the kernel parameters.
> > - * The string after the "rcu_nocbs=" is either "all" for all CPUs, or a
> > - * comma-separated list of CPUs and/or CPU ranges.  If an invalid list is
> > - * given, a warning is emitted and all CPUs are offloaded.
> > + * If the list is invalid, a warning is emitted and all CPUs are offloaded.
> >   */
> >  static int __init rcu_nocb_setup(char *str)
> >  {
> >         alloc_bootmem_cpumask_var(&rcu_nocb_mask);
> > -       if (!strcasecmp(str, "all"))
> > +       if (!strcasecmp(str, "all"))            /* legacy: use "0-N" instead */
> 
> I think 'all' and 'none' is a good idea. It's simple and convenient.
> But if you don't
> like it, can you please at least put this comment in system log using
> WARN_ON_ONCE(). It's quite possible that Linux users don't read source code
> comments.

Please leave it silent.  This has been available to RCU users for
quite some time, so suddenly spewing warnings at all of them is a bit
unfriendly.  The extra code is negligible, and the documentation will
guide people more gently in the right direction.  Plus I am the one who
would end up receiving complaints about the warnings, and I have much
better things to do with my time.

							Thanx, Paul

> >                 cpumask_setall(rcu_nocb_mask);
> >         else
> >                 if (cpulist_parse(str, rcu_nocb_mask)) {
> > --
> > 2.17.1
> >
