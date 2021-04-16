Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C41362830
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 21:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhDPTDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 15:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233606AbhDPTDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 15:03:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1069611AF;
        Fri, 16 Apr 2021 19:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618599764;
        bh=YhNF1u7eDPJyBXGgiBHEF7QjgMTCBzvbSfgXtlmK2eg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pFeqwQ/ca8tRABmm/N0sDdf82MfmJZQBKIp2hKi/eMbzQm+u2LM50LE71TiPujQHq
         musH2AQU8wwGYCwvcLM8fK+FlYE21MO+EAlHbXEQi32o8ti/Ebl96WojnqWj2vxBY+
         Cjrn9nZKXvBdIkRRy/j1g34CLr54deBHEnNMvkw87azrnz9oGnyKd/pnMtr8hA6RFf
         uelrFyoyUIk4ZV5XMpACUW2b2yGjqZqP6zkUpKIzyIQ0X3YSe29vSPDast9LaR0V4D
         ZmKrmkq0KT3eh2nubhR5OBbLVUek0AurQnD/R+3Li9bPQyy8AGgMd9FTVckpPRjOi7
         wFZumHz/C6ZiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 61AB15C0253; Fri, 16 Apr 2021 12:02:44 -0700 (PDT)
Date:   Fri, 16 Apr 2021 12:02:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lttng-dev <lttng-dev@lists.lttng.org>, carlos <carlos@redhat.com>
Subject: Re: liburcu: LTO breaking rcu_dereference on arm64 and possibly
 other architectures ?
Message-ID: <20210416190244.GJ4212@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
 <YHmqd3BHwVmaUZHX@hirez.programming.kicks-ass.net>
 <20210416160139.GF4212@paulmck-ThinkPad-P17-Gen-1>
 <2089952450.84139.1618598408015.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2089952450.84139.1618598408015.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 02:40:08PM -0400, Mathieu Desnoyers wrote:
> ----- On Apr 16, 2021, at 12:01 PM, paulmck paulmck@kernel.org wrote:
> 
> > On Fri, Apr 16, 2021 at 05:17:11PM +0200, Peter Zijlstra wrote:
> >> On Fri, Apr 16, 2021 at 10:52:16AM -0400, Mathieu Desnoyers wrote:
> >> > Hi Paul, Will, Peter,
> >> > 
> >> > I noticed in this discussion https://lkml.org/lkml/2021/4/16/118 that LTO
> >> > is able to break rcu_dereference. This seems to be taken care of by
> >> > arch/arm64/include/asm/rwonce.h on arm64 in the Linux kernel tree.
> >> > 
> >> > In the liburcu user-space library, we have this comment near rcu_dereference()
> >> > in
> >> > include/urcu/static/pointer.h:
> >> > 
> >> >  * The compiler memory barrier in CMM_LOAD_SHARED() ensures that
> >> >  value-speculative
> >> >  * optimizations (e.g. VSS: Value Speculation Scheduling) does not perform the
> >> >  * data read before the pointer read by speculating the value of the pointer.
> >> >  * Correct ordering is ensured because the pointer is read as a volatile access.
> >> >  * This acts as a global side-effect operation, which forbids reordering of
> >> >  * dependent memory operations. Note that such concern about dependency-breaking
> >> >  * optimizations will eventually be taken care of by the "memory_order_consume"
> >> >  * addition to forthcoming C++ standard.
> >> > 
> >> > (note: CMM_LOAD_SHARED() is the equivalent of READ_ONCE(), but was introduced in
> >> > liburcu as a public API before READ_ONCE() existed in the Linux kernel)
> >> > 
> >> > Peter tells me the "memory_order_consume" is not something which can be used
> >> > today.
> >> > Any information on its status at C/C++ standard levels and implementation-wise ?
> > 
> > Actually, you really can use memory_order_consume.  All current
> > implementations will compile it as if it was memory_order_acquire.
> > This will work correctly, but may be slower than you would like on ARM,
> > PowerPC, and so on.
> > 
> > On things like x86, the penalty is forgone optimizations, so less
> > of a problem there.
> 
> OK
> 
> > 
> >> > Pragmatically speaking, what should we change in liburcu to ensure we don't
> >> > generate
> >> > broken code when LTO is enabled ? I suspect there are a few options here:
> >> > 
> >> > 1) Fail to build if LTO is enabled,
> >> > 2) Generate slower code for rcu_dereference, either on all architectures or only
> >> >    on weakly-ordered architectures,
> >> > 3) Generate different code depending on whether LTO is enabled or not. AFAIU
> >> > this would only
> >> >    work if every compile unit is aware that it will end up being optimized with
> >> >    LTO. Not sure
> >> >    how this could be done in the context of user-space.
> >> > 4) [ Insert better idea here. ]
> > 
> > Use memory_order_consume if LTO is enabled.  That will work now, and
> > might generate good code in some hoped-for future.
> 
> In the context of a user-space library, how does one check whether LTO is enabled with
> preprocessor directives ? A quick test with gcc seems to show that both with and without
> -flto cannot be distinguished from a preprocessor POV, e.g. the output of both
> 
> gcc --std=c11 -O2 -dM -E - < /dev/null
> and
> gcc --std=c11 -O2 -flto -dM -E - < /dev/null
> 
> is exactly the same. Am I missing something here ?

No idea.  ;-)

> If we accept to use memory_order_consume all the time in both C and C++ code starting from
> C11 and C++11, the following code snippet could do the trick:
> 
> #define CMM_ACCESS_ONCE(x) (*(__volatile__  __typeof__(x) *)&(x))
> #define CMM_LOAD_SHARED(p) CMM_ACCESS_ONCE(p)
> 
> #if defined (__cplusplus)
> # if __cplusplus >= 201103L
> #  include <atomic>
> #  define rcu_dereference(x)    ((std::atomic<__typeof__(x)>)(x)).load(std::memory_order_consume)
> # else
> #  define rcu_dereference(x)    CMM_LOAD_SHARED(x)
> # endif
> #else
> # if (defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L)
> #  include <stdatomic.h>
> #  define rcu_dereference(x)    atomic_load_explicit(&(x), memory_order_consume)
> # else
> #  define rcu_dereference(x)    CMM_LOAD_SHARED(x)
> # endif
> #endif
> 
> This uses the volatile approach prior to C11/C++11, and moves to memory_order_consume
> afterwards. This will bring a performance penalty on weakly-ordered architectures even
> when -flto is not specified though.
> 
> Then the burden is pushed on the compiler people to eventually implement an efficient
> memory_order_consume.
> 
> Is that acceptable ?

That makes sense to me!

If it can be done reasonably, I suggest also having some way for the
person building userspace RCU to say "I know what I am doing, so do
it with volatile rather than memory_order_consume."

							Thanx, Paul
