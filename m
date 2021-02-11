Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13639318296
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 01:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhBKAX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 19:23:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229983AbhBKAXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 19:23:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D25B64E31;
        Thu, 11 Feb 2021 00:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613002989;
        bh=PTT6ky04EJ9/t3h3wg4Vxk/mjQTZfuTYXD4lx+Mq7e8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KVi1giFbr8DsKGW5O2kJoT4vSN8nm+WB4OwFKBwFYucIwI25TzjPfoqA7oA6rC1vs
         QHVzhNQOOrFfBNItLdrVXgFS6QUlqP02LClJ9QFDHYA28xtXdiZbGzMRldVdhbZHgv
         7j6c4rLbB7em2XPPlDA5+bF+euwTsoGeYeOk4t7ChsflH8TrNKB1PyICAYt2f7+j2n
         twPSqHoRqjcw5JXHK1C1Mt3bNczcHmGvkFBBe2m25QVyRnvZkn4lSkTCSuxIOKm7wv
         WGGhDJXFAYd0f5Pn15cvjWL+bLGAJnQQi88fsvOhGdwdMJAgsHfE3osaMz9X6+XSA/
         JsYPoFUJYcrXg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0DBD235238B1; Wed, 10 Feb 2021 16:23:09 -0800 (PST)
Date:   Wed, 10 Feb 2021 16:23:09 -0800
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
Message-ID: <20210211002309.GL2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
 <YCQJToq1d63BU55S@smile.fi.intel.com>
 <20210210175751.GH2743@paulmck-ThinkPad-P72>
 <CAAH8bW-oZG_h3F-d9Rc4wUwSZxNPR+sdeY41yZ+BpwAjXSCXWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW-oZG_h3F-d9Rc4wUwSZxNPR+sdeY41yZ+BpwAjXSCXWw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 03:50:07PM -0800, Yury Norov wrote:
> On Wed, Feb 10, 2021 at 9:57 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Feb 10, 2021 at 06:26:54PM +0200, Andy Shevchenko wrote:
> > > On Tue, Feb 09, 2021 at 05:58:59PM -0500, Paul Gortmaker wrote:
> > > > The basic objective here was to add support for "nohz_full=8-N" and/or
> > > > "rcu_nocbs="4-N" -- essentially introduce "N" as a portable reference
> > > > to the last core, evaluated at boot for anything using a CPU list.
> > >
> > > I thought we kinda agreed that N is confusing and L is better.
> > > N to me is equal to 32 on 32 core system as *number of cores / CPUs*. While L
> > > sounds better as *last available CPU number*.
> >
> > The advantage of "N" is that people will automatically recognize it as
> > "last thing" or number of things" because "N" has long been used in
> > both senses.  In contrast, someone seeing "0-L" for the first time is
> > likely to go "What???".
> >
> > Besides, why would someone interpret "N" as "number of CPUs" when doing
> > that almost always gets you an invalid CPU number?
> >
> >                                                         Thanx, Paul
> 
> I have no strong opinion about a letter, but I like Andy's idea to make it
> case-insensitive.
> 
> There is another comment from the previous iteration not addressed so far.
> 
> This idea of the N notation is to make the bitmap list interface more robust
> when we share the configs between different machines. What we have now
> is definitely a good thing, but not completely portable except for cases
> 'N', '0-N' and 'N-N'.
> 
> For example, if one user adds rcu_nocbs= '4-N', and it works perfectly fine for
> him, another user with s NR_CPUS == 2 will fail to boot with such a config.
> 
> This is not a problem of course in case of absolute values because nobody
> guaranteed robustness. But this N feature would be barely useful in practice,
> except for 'N', '0-N' and 'N-N' as I mentioned before, because there's always
> a chance to end up with a broken config.
> 
> We can improve on robustness a lot if we take care about this case.For me,
> the more reliable interface would look like this:
> 1. chunks without N work as before.
> 2. if 'a-N' is passed where a>=N, we drop chunk and print warning message
> 3. if 'a-N' is passed where a>=N together with a control key, we set last bit
> and print warning.
> 
> For example, on 2-core CPU:
> "4-2" --> error
> "4-4" --> error
> "4-N" --> drop and warn
> "X, 4-N" --> set last bit and warn
> 
> Any comments?

We really don't know the user's intent, and we cannot have complete
portability without knowing the user's intent.  For example, "4-N" means
"all but the first four CPUs", in which case an error is appropriate
because "4-N" makes no more sense on a 2-CPU system than does "4-1".
I could see a potential desire for some notation for "the last two CPUs",
but let's please have a real need for such a thing before overengineering
this patch series any further.

To get the level of portability you seem to be looking for, we need some
higher-level automation that knows how many CPUs there are and what
the intent is.  That automation can then generate the cpumasks for a
given system.  But for more typical situations, what Paul has now will
work fine.

Paul Gortmaker's patch series is doing something useful.  We should
not let potential future desires prevent us from taking a very useful
step forward.

							Thanx, Paul
