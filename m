Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB13D31978D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 01:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBLAjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 19:39:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhBLAjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 19:39:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 695FA61493;
        Fri, 12 Feb 2021 00:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613090302;
        bh=WcNPuJnmk5vyURXYl4skxvJr55pfhPAMsl6062FOmFo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tArgsQL/B1R0XDiuFVacP9amj2196ZK+/Zc4leJpmnIxSAlti1D2sawqLQEyaH+4+
         zaZktbG0OvaoP4+nLqBUWw3m6N5ayZ7e7ECoCRI1GEYRRV8RsckN1x+x8G5nJTagLY
         T1Hwyf3OrvKKdm0IqrqBL0FvKOXebePa8zRaAzBYTSeZ5MfLfkWC/GJfbQNclkSuz0
         fkQn+rsw0hHLUpvAeMPWWgLfzyLRMi4O9lC4j/GbI/Vj/FMRggE7OEwtMeV+e642xP
         h+STIpxuNZ4BWgiASh0CaiUjtXt1O24YVnD7eUjZJZzYHq6zIdSsi3UG15wSPETRVh
         gtu26YvVrZVOA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3409D3522694; Thu, 11 Feb 2021 16:38:22 -0800 (PST)
Date:   Thu, 11 Feb 2021 16:38:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 0/8] support for bitmap (and hence CPU) list "N"
 abbreviation
Message-ID: <20210212003822.GN2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
 <YCQJToq1d63BU55S@smile.fi.intel.com>
 <20210210175751.GH2743@paulmck-ThinkPad-P72>
 <CAAH8bW-oZG_h3F-d9Rc4wUwSZxNPR+sdeY41yZ+BpwAjXSCXWw@mail.gmail.com>
 <20210211002309.GL2743@paulmck-ThinkPad-P72>
 <20210212002339.GA167389@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212002339.GA167389@yury-ThinkPad>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 04:23:39PM -0800, Yury Norov wrote:
> On Wed, Feb 10, 2021 at 04:23:09PM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 10, 2021 at 03:50:07PM -0800, Yury Norov wrote:
> > > On Wed, Feb 10, 2021 at 9:57 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Wed, Feb 10, 2021 at 06:26:54PM +0200, Andy Shevchenko wrote:
> > > > > On Tue, Feb 09, 2021 at 05:58:59PM -0500, Paul Gortmaker wrote:
> > > > > > The basic objective here was to add support for "nohz_full=8-N" and/or
> > > > > > "rcu_nocbs="4-N" -- essentially introduce "N" as a portable reference
> > > > > > to the last core, evaluated at boot for anything using a CPU list.
> > > > >
> > > > > I thought we kinda agreed that N is confusing and L is better.
> > > > > N to me is equal to 32 on 32 core system as *number of cores / CPUs*. While L
> > > > > sounds better as *last available CPU number*.
> > > >
> > > > The advantage of "N" is that people will automatically recognize it as
> > > > "last thing" or number of things" because "N" has long been used in
> > > > both senses.  In contrast, someone seeing "0-L" for the first time is
> > > > likely to go "What???".
> > > >
> > > > Besides, why would someone interpret "N" as "number of CPUs" when doing
> > > > that almost always gets you an invalid CPU number?
> > > >
> > > >                                                         Thanx, Paul
> > > 
> > > I have no strong opinion about a letter, but I like Andy's idea to make it
> > > case-insensitive.
> > > 
> > > There is another comment from the previous iteration not addressed so far.
> > > 
> > > This idea of the N notation is to make the bitmap list interface more robust
> > > when we share the configs between different machines. What we have now
> > > is definitely a good thing, but not completely portable except for cases
> > > 'N', '0-N' and 'N-N'.
> > > 
> > > For example, if one user adds rcu_nocbs= '4-N', and it works perfectly fine for
> > > him, another user with s NR_CPUS == 2 will fail to boot with such a config.
> > > 
> > > This is not a problem of course in case of absolute values because nobody
> > > guaranteed robustness. But this N feature would be barely useful in practice,
> > > except for 'N', '0-N' and 'N-N' as I mentioned before, because there's always
> > > a chance to end up with a broken config.
> > > 
> > > We can improve on robustness a lot if we take care about this case.For me,
> > > the more reliable interface would look like this:
> > > 1. chunks without N work as before.
> > > 2. if 'a-N' is passed where a>=N, we drop chunk and print warning message
> > > 3. if 'a-N' is passed where a>=N together with a control key, we set last bit
> > > and print warning.
> > > 
> > > For example, on 2-core CPU:
> > > "4-2" --> error
> > > "4-4" --> error
> > > "4-N" --> drop and warn
> > > "X, 4-N" --> set last bit and warn
> > > 
> > > Any comments?
> > 
> > We really don't know the user's intent, and we cannot have complete
> > portability without knowing the user's intent.  For example, "4-N" means
> > "all but the first four CPUs", in which case an error is appropriate
> > because "4-N" makes no more sense on a 2-CPU system than does "4-1".
> > I could see a potential desire for some notation for "the last two CPUs",
> > but let's please have a real need for such a thing before overengineering
> > this patch series any further.
> > 
> > To get the level of portability you seem to be looking for, we need some
> > higher-level automation that knows how many CPUs there are and what
> > the intent is.  That automation can then generate the cpumasks for a
> > given system.  But for more typical situations, what Paul has now will
> > work fine.
> > 
> > Paul Gortmaker's patch series is doing something useful.  We should
> > not let potential future desires prevent us from taking a very useful
> > step forward.
> > 
> > 							Thanx, Paul
> 
> No problem, we can do it later if it will become a real concern. 
> 
> Can you please remove this series from linux-next unless we finish
> the review? It prevents me from applying the series from the LKML.

That will happen shortly, but in the meantime, just do the following on
top of -next before applying Paul's latest series:

	git revert b3c314b ed78166 1e792c4 e831c73

							Thanx, Paul
