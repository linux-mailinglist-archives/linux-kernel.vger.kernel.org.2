Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1509366E86
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243643AbhDUOxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239698AbhDUOxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:53:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77127613B6;
        Wed, 21 Apr 2021 14:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619016782;
        bh=TBLTasWDGVHVnz/cnpO+ER8U/9x/LrlBvhFJ3Xsy59M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d9Yfkhq2e8rxGbqc+eMaDrhBxGtWhGz1jt4qPblmzqSrQeGstgF61DLijsCve5EvW
         x0eRbFygqRaSDdw9s/9+PiqgFO673bGIyGJ4UGzcQZxcE2q6IcDEnVcAPs1OD6BHc9
         utNpSTmkfHfQql0PBkMt86m+cR+xFEj/JyBps82oUX3gXkrmB42Nmi60NI1/FCQbGw
         5l8cS1kzww4iVSREHUT/0IYqw2verLCxdHNAxlQqu0BStHt+dUPKuK/DVvQwmKTJtE
         EEHW810PVjGVlMpxwcCLS+HmVmxCXxgeGLjTVT7njJ1oN32JrwMMxpeUx3Ctc+F1Qg
         0f6uSOkZwKMZg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 23F335C0267; Wed, 21 Apr 2021 07:53:02 -0700 (PDT)
Date:   Wed, 21 Apr 2021 07:53:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, David Gow <davidgow@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] kcsan: fix printk format string
Message-ID: <20210421145302.GS975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210421135059.3371701-1-arnd@kernel.org>
 <CANpmjNM81K-3GhDmzUVdY32kZ_5XOwrT-4zSUDeRHpCs30fa1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM81K-3GhDmzUVdY32kZ_5XOwrT-4zSUDeRHpCs30fa1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:59:40PM +0200, Marco Elver wrote:
> On Wed, 21 Apr 2021 at 15:51, Arnd Bergmann <arnd@kernel.org> wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Printing a 'long' variable using the '%d' format string is wrong
> > and causes a warning from gcc:
> >
> > kernel/kcsan/kcsan_test.c: In function 'nthreads_gen_params':
> > include/linux/kern_levels.h:5:25: error: format '%d' expects argument of type 'int', but argument 3 has type 'long int' [-Werror=format=]
> >
> > Use the appropriate format modifier.
> >
> > Fixes: f6a149140321 ("kcsan: Switch to KUNIT_CASE_PARAM for parameterized tests")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Marco Elver <elver@google.com>
> 
> Thank you!
> 
> Normally KCSAN patches go through -rcu, but perhaps in this instance
> it should be picked up into -tip/locking/core directly, so it goes out
> with "kcsan: Switch to KUNIT_CASE_PARAM for parameterized tests".
> Paul, Ingo, do you have a preference?

I am good either way.  I have queued it for the moment, but will remove
it if Ingo takes it.

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> Thanks,
> -- Marco
> 
> > ---
> >  kernel/kcsan/kcsan_test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> > index 9247009295b5..a29e9b1a30c8 100644
> > --- a/kernel/kcsan/kcsan_test.c
> > +++ b/kernel/kcsan/kcsan_test.c
> > @@ -981,7 +981,7 @@ static const void *nthreads_gen_params(const void *prev, char *desc)
> >                 const long min_required_cpus = 2 + min_unused_cpus;
> >
> >                 if (num_online_cpus() < min_required_cpus) {
> > -                       pr_err_once("Too few online CPUs (%u < %d) for test\n",
> > +                       pr_err_once("Too few online CPUs (%u < %ld) for test\n",
> >                                     num_online_cpus(), min_required_cpus);
> >                         nthreads = 0;
> >                 } else if (nthreads >= num_online_cpus() - min_unused_cpus) {
> > --
> > 2.29.2
