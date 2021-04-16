Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721FB3627DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244624AbhDPSkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:40:35 -0400
Received: from mail.efficios.com ([167.114.26.124]:36108 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbhDPSke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:40:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D98F3339EA4;
        Fri, 16 Apr 2021 14:40:08 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MfEER9SYlT-k; Fri, 16 Apr 2021 14:40:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2624433A1B4;
        Fri, 16 Apr 2021 14:40:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2624433A1B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1618598408;
        bh=WCKBxmGTFBeDZ28R3kM5fNv86SBZcZ3ck6Twung5YT8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ktLdyLF6AvrGq+C+41wREeiPdB4ypB3ZWp8NOWQVioOyPUY55/P73+SPiAF67HVxV
         zudr3HcbJWyGze3vmNjieFQP9/JlM794qXUKQE+zpVvkFC+wFiW6UsvIqMp80VSd7b
         cRHzJ8biOfYBw4DPSgpDpoJUjNXDRSdI5YT/gHtqxIJ9Tq0PhVpx8gtkSGNM3+Y2ww
         qXHHfnbEunp9c2WqOw/3qMPY3CbUYOuQPT266G8jbn5Yi7NaIIFyCdrwrV4SrL+bsL
         A4sMX1ZFiBoQEHx5icfkz3wjx2Dt9zKA1uV8ENNulEWWqP8jmvJf5TiV3NlGkyNLD+
         OC3SxlsMTWs6A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DbH28hQ8dRPq; Fri, 16 Apr 2021 14:40:08 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1431033A202;
        Fri, 16 Apr 2021 14:40:08 -0400 (EDT)
Date:   Fri, 16 Apr 2021 14:40:08 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lttng-dev <lttng-dev@lists.lttng.org>, carlos <carlos@redhat.com>
Message-ID: <2089952450.84139.1618598408015.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210416160139.GF4212@paulmck-ThinkPad-P17-Gen-1>
References: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com> <YHmqd3BHwVmaUZHX@hirez.programming.kicks-ass.net> <20210416160139.GF4212@paulmck-ThinkPad-P17-Gen-1>
Subject: Re: liburcu: LTO breaking rcu_dereference on arm64 and possibly
 other architectures ?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: liburcu: LTO breaking rcu_dereference on arm64 and possibly other architectures ?
Thread-Index: GN3Gd8n4H94A1nWxv3DRudXtV0FXrQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 16, 2021, at 12:01 PM, paulmck paulmck@kernel.org wrote:

> On Fri, Apr 16, 2021 at 05:17:11PM +0200, Peter Zijlstra wrote:
>> On Fri, Apr 16, 2021 at 10:52:16AM -0400, Mathieu Desnoyers wrote:
>> > Hi Paul, Will, Peter,
>> > 
>> > I noticed in this discussion https://lkml.org/lkml/2021/4/16/118 that LTO
>> > is able to break rcu_dereference. This seems to be taken care of by
>> > arch/arm64/include/asm/rwonce.h on arm64 in the Linux kernel tree.
>> > 
>> > In the liburcu user-space library, we have this comment near rcu_dereference()
>> > in
>> > include/urcu/static/pointer.h:
>> > 
>> >  * The compiler memory barrier in CMM_LOAD_SHARED() ensures that
>> >  value-speculative
>> >  * optimizations (e.g. VSS: Value Speculation Scheduling) does not perform the
>> >  * data read before the pointer read by speculating the value of the pointer.
>> >  * Correct ordering is ensured because the pointer is read as a volatile access.
>> >  * This acts as a global side-effect operation, which forbids reordering of
>> >  * dependent memory operations. Note that such concern about dependency-breaking
>> >  * optimizations will eventually be taken care of by the "memory_order_consume"
>> >  * addition to forthcoming C++ standard.
>> > 
>> > (note: CMM_LOAD_SHARED() is the equivalent of READ_ONCE(), but was introduced in
>> > liburcu as a public API before READ_ONCE() existed in the Linux kernel)
>> > 
>> > Peter tells me the "memory_order_consume" is not something which can be used
>> > today.
>> > Any information on its status at C/C++ standard levels and implementation-wise ?
> 
> Actually, you really can use memory_order_consume.  All current
> implementations will compile it as if it was memory_order_acquire.
> This will work correctly, but may be slower than you would like on ARM,
> PowerPC, and so on.
> 
> On things like x86, the penalty is forgone optimizations, so less
> of a problem there.

OK

> 
>> > Pragmatically speaking, what should we change in liburcu to ensure we don't
>> > generate
>> > broken code when LTO is enabled ? I suspect there are a few options here:
>> > 
>> > 1) Fail to build if LTO is enabled,
>> > 2) Generate slower code for rcu_dereference, either on all architectures or only
>> >    on weakly-ordered architectures,
>> > 3) Generate different code depending on whether LTO is enabled or not. AFAIU
>> > this would only
>> >    work if every compile unit is aware that it will end up being optimized with
>> >    LTO. Not sure
>> >    how this could be done in the context of user-space.
>> > 4) [ Insert better idea here. ]
> 
> Use memory_order_consume if LTO is enabled.  That will work now, and
> might generate good code in some hoped-for future.

In the context of a user-space library, how does one check whether LTO is enabled with
preprocessor directives ? A quick test with gcc seems to show that both with and without
-flto cannot be distinguished from a preprocessor POV, e.g. the output of both

gcc --std=c11 -O2 -dM -E - < /dev/null
and
gcc --std=c11 -O2 -flto -dM -E - < /dev/null

is exactly the same. Am I missing something here ?

If we accept to use memory_order_consume all the time in both C and C++ code starting from
C11 and C++11, the following code snippet could do the trick:

#define CMM_ACCESS_ONCE(x) (*(__volatile__  __typeof__(x) *)&(x))
#define CMM_LOAD_SHARED(p) CMM_ACCESS_ONCE(p)

#if defined (__cplusplus)
# if __cplusplus >= 201103L
#  include <atomic>
#  define rcu_dereference(x)    ((std::atomic<__typeof__(x)>)(x)).load(std::memory_order_consume)
# else
#  define rcu_dereference(x)    CMM_LOAD_SHARED(x)
# endif
#else
# if (defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L)
#  include <stdatomic.h>
#  define rcu_dereference(x)    atomic_load_explicit(&(x), memory_order_consume)
# else
#  define rcu_dereference(x)    CMM_LOAD_SHARED(x)
# endif
#endif

This uses the volatile approach prior to C11/C++11, and moves to memory_order_consume
afterwards. This will bring a performance penalty on weakly-ordered architectures even
when -flto is not specified though.

Then the burden is pushed on the compiler people to eventually implement an efficient
memory_order_consume.

Is that acceptable ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
