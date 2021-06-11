Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAB63A3EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhFKJTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:19:36 -0400
Received: from foss.arm.com ([217.140.110.172]:52752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231229AbhFKJTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:19:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 202D114BF;
        Fri, 11 Jun 2021 02:17:37 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.8.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64C8D3F719;
        Fri, 11 Jun 2021 02:17:32 -0700 (PDT)
Date:   Fri, 11 Jun 2021 10:17:24 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>, jonas@southpole.se,
        juri.lelli@redhat.com,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <rth@twiddle.net>, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi,
        Thomas Gleixner <tglx@linutronix.de>,
        vincent.guittot@linaro.org, Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH 01/10] thread_info: add helpers to snapshot thread
 flags
Message-ID: <20210611091724.GA78056@C02TD0UTHF1T.local>
References: <20210609122001.18277-1-mark.rutland@arm.com>
 <20210609122001.18277-2-mark.rutland@arm.com>
 <CANpmjNOvnqE29mMU++K0VMibF8xMixJXRDqbDKXjXuxobAfM1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOvnqE29mMU++K0VMibF8xMixJXRDqbDKXjXuxobAfM1Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 11:01:34AM +0200, Marco Elver wrote:
> On Wed, 9 Jun 2021 at 14:20, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > We have common helpers to manipulate individual thread flags, but where
> > code wants to check several flags at once, it must open code reading
> > current_thread_info()->flags and operating on a snapshot.
> >
> > As some flags can be set remotely it's necessary to use READ_ONCE() to
> > get a consistent snapshot even when IRQs are disabled, but some code
> > forgets to do this. Generally this is unlike to cause a problem in
> > practice, but it is somewhat unsound, and KCSAN will legitimately warn
> > that there is a data race.
> >
> > To make it easier to do the right thing, and to highlight that
> > concurrent modification is possible, let's add a new helpers to snapshot
> > the flags, which should be used in preference to plain reads.
> > Subsequent patches will move existing code to use the new helpers.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will@kernel.org>
> 
> Acked-by: Marco Elver <elver@google.com>

Thanks!

> > ---
> >  include/linux/thread_info.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> > index 157762db9d4b..f3769842046d 100644
> > --- a/include/linux/thread_info.h
> > +++ b/include/linux/thread_info.h
> > @@ -117,6 +117,11 @@ static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
> >         return test_bit(flag, (unsigned long *)&ti->flags);
> >  }
> >
> > +static inline unsigned long read_ti_thread_flags(struct thread_info *ti)
> > +{
> > +       return READ_ONCE(ti->flags);
> > +}
> > +
> 
> Are some of the callers 'noinstr'? I haven't seen it in this series
> yet, but if yes, then not inlining (which some compilers may do with
> heavier instrumentation) might cause issues and this could be
> __always_inline.

That's a very good point; I agree it should be __always_inline, and I'll
fix that up for the next spin.

Thanks,
Mark.
