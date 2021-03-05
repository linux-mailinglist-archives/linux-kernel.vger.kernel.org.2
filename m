Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D07032E7A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 13:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhCEMFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 07:05:40 -0500
Received: from foss.arm.com ([217.140.110.172]:52376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhCEMF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 07:05:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F22531B;
        Fri,  5 Mar 2021 04:05:27 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.47.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B046D3F766;
        Fri,  5 Mar 2021 04:05:24 -0800 (PST)
Date:   Fri, 5 Mar 2021 12:04:53 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        broonie@kernel.org, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v1] powerpc: Include running function as first entry in
 save_stack_trace() and friends
Message-ID: <20210305120453.GA74705@C02TD0UTHF1T.local>
References: <1802be3e-dc1a-52e0-1754-a40f0ea39658@csgroup.eu>
 <YD+o5QkCZN97mH8/@elver.google.com>
 <20210304145730.GC54534@C02TD0UTHF1T.local>
 <CANpmjNOSpFbbDaH9hNucXrpzG=HpsoQpk5w-24x8sU_G-6cz0Q@mail.gmail.com>
 <20210304165923.GA60457@C02TD0UTHF1T.local>
 <YEEYDSJeLPvqRAHZ@elver.google.com>
 <20210304180154.GD60457@C02TD0UTHF1T.local>
 <CANpmjNOZWuhqXATDjH3F=DMbpg2xOy0XppVJ+Wv2XjFh_crJJg@mail.gmail.com>
 <20210304185148.GE60457@C02TD0UTHF1T.local>
 <CANpmjNMQNWBtWS7O_aaCfbMWvQUnzWTPXoxgD8DzqNzKfL_2Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMQNWBtWS7O_aaCfbMWvQUnzWTPXoxgD8DzqNzKfL_2Dg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 08:01:29PM +0100, Marco Elver wrote:
> On Thu, 4 Mar 2021 at 19:51, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Mar 04, 2021 at 07:22:53PM +0100, Marco Elver wrote:

> > > I was having this problem with KCSAN, where the compiler would
> > > tail-call-optimize __tsan_X instrumentation.
> >
> > Those are compiler-generated calls, right? When those are generated the
> > compilation unit (and whatever it has included) might not have provided
> > a prototype anyway, and the compiler has special knowledge of the
> > functions, so it feels like the compiler would need to inhibit TCO here
> > for this to be robust. For their intended usage subjecting them to TCO
> > doesn't seem to make sense AFAICT.
> >
> > I suspect that compilers have some way of handling that; otherwise I'd
> > expect to have heard stories of mcount/fentry calls getting TCO'd and
> > causing problems. So maybe there's an easy fix there?
> 
> I agree, the compiler builtins should be handled by the compiler
> directly, perhaps that was a bad example. But we also have "explicit
> instrumentation", e.g. everything that's in <linux/instrumented.h>.

True -- I agree for those we want similar, and can see a case for a
no-tco-calls-to-me attribute on functions as with noreturn.

Maybe for now it's worth adding prevent_tail_call_optimization() to the
instrument_*() call wrappers in <linux/instrumented.h>? As those are
__always_inline, that should keep the function they get inlined in
around. Though we probably want to see if we can replace the mb() in
prevent_tail_call_optimization() with something that doesn't require a
real CPU barrier.

[...]

> > I reckon for basically any instrumentation we don't want calls to be
> > TCO'd, though I'm not immediately sure of cases beyond sanitizers and
> > mcount/fentry.
> 
> Thinking about this more, I think it's all debugging tools. E.g.
> lockdep, if you lock/unlock at the end of a function, you might tail
> call into lockdep. If the compiler applies TCO, and lockdep determines
> there's a bug and then shows a trace, you'll have no idea where the
> actual bug is. The kernel has lots of debugging facilities that add
> instrumentation in this way. So perhaps it's a general debugging-tool
> problem (rather than just sanitizers).

This makes sense to me.

Thanks,
Mark.
