Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C5534B119
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 22:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhCZVMB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 Mar 2021 17:12:01 -0400
Received: from albireo.enyo.de ([37.24.231.21]:56226 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbhCZVLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:11:43 -0400
Received: from [172.17.203.2] (port=60777 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lPtk0-0004H1-VB; Fri, 26 Mar 2021 21:11:36 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1lPtk0-0000FD-K4; Fri, 26 Mar 2021 22:11:36 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "H. J. Lu" <hjl.tools@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>,
        libc-alpha <libc-alpha@sourceware.org>
Subject: Re: Why does glibc use AVX-512?
References: <CALCETrURmk4ZijJVUtJwouj=_0NPiUvUFr9XMvdniRRFqeU+fg@mail.gmail.com>
        <87a6qqi064.fsf@mid.deneb.enyo.de>
        <CALCETrUM1=Db3vmQAhPkt=SktL7+dtUrt5Ef6BP3T1Q6HY3Bmw@mail.gmail.com>
        <87blb5d7zx.fsf@mid.deneb.enyo.de>
        <CALCETrUXMnutTV=SEs6ot58j32_5=K5Z=G7_57gVZt_GFcuDiw@mail.gmail.com>
        <877dltd569.fsf@mid.deneb.enyo.de>
        <CALCETrW0jn1j9xO5Q+4y2gf71Ddb0R34KX1dWKAROhxS-yJwSA@mail.gmail.com>
Date:   Fri, 26 Mar 2021 22:11:36 +0100
In-Reply-To: <CALCETrW0jn1j9xO5Q+4y2gf71Ddb0R34KX1dWKAROhxS-yJwSA@mail.gmail.com>
        (Andy Lutomirski's message of "Fri, 26 Mar 2021 13:48:01 -0700")
Message-ID: <87pmzlboxj.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski:

> On Fri, Mar 26, 2021 at 1:35 PM Florian Weimer <fw@deneb.enyo.de> wrote:
>>
>> * Andy Lutomirski:
>>
>> > On Fri, Mar 26, 2021 at 12:34 PM Florian Weimer <fw@deneb.enyo.de> wrote:
>> >>   x86: Sporadic failures in tst-cpu-features-cpuinfo
>> >>   <https://sourceware.org/bugzilla/show_bug.cgi?id=27398#c3>
>> >
>> > It's worth noting that recent microcode updates have make RTM
>> > considerably less likely to actually work on many parts.  It's
>> > possible you should just disable it. :(
>>
>> Sorry, I'm not sure who should disable it.
>>
>> Let me sum up the situation:
>>
>> We have a request for a performance enhancement in glibc, so that
>> applications can use it on server parts where RTM actually works.
>>
>> For CPUs that support AVX-512, we may be able to meet that with a
>> change that uses the new 256-bit registers, t avoid the %xmm
>> transition penalty.  (This is the easy case, hopefully—there shouldn't
>> be any frequency issues associated with that, and if the kernel
>> doesn't optimize the context switch today, that's a nonissue as well.)
>
> I would make sure that the transition penalty actually works the way
> you think it does.  My general experience with the transition
> penalties is that the CPU is rather more aggressive about penalizing
> you than makes sense.

Do you mean the frequency/thermal budget?

I mean the immense slowdown you get if you use %xmm registers after
their %ymm counterparts (doesn't have to be %zmm, that issue is
present starting with AVX) and you have not issued VZEROALL or
VZEROUPPER between the two uses.

It's a bit like EMMS, I gues, only that you don't get corruption, just
really poor performance.

>> For CPUs that do not support AVX-512 but support RTM (and AVX2), we
>> need a dynamic run-time check whether the string function is invoked
>> in a transaction.  In that case, we need to use VZEROALL instead of
>> VZEROUPPER.  (It's apparently too costly to issue VZEROALL
>> unconditionally.)
>
> So VZEROALL works in a transaction and VZEROUPPER doesn't?  That's bizarre.

Apparently yes.

>> All this needs to work transparently without user intervention.  We
>> cannot require firmware upgrades to fix the incorrect RTM reporting
>> issue (the bug I referenced).  I think we can require software updates
>> which tell glibc when to use RTM-enabled string functions if the
>> dynamic selection does not work (either for performance reasons, or
>> because of the RTM reporting bug).
>>
>> I want to avoid a situation where one in eight processes fail to work
>> correctly because the CPUID checks ran on CPU 0, where RTM is reported
>> as available, and then we trap when executing XTEST on other CPUs.
>
> What kind of system has that problem?

It's a standard laptop after a suspend/resume cycle.  It's either a
kernel or firmware bug.

> If RTM reports as available, then it should work in the sense of not
> trapping.  (There is no guarantee that transactions will *ever*
> complete, and that part is no joke.)

XTEST doesn't abort transactions, but it traps without RTM support.
If CPU0 has RTM support and we enable XTEST use in glibc based on that
(because the startup code runs on CPU0), then the XTEST instruction
must not trap when running on other CPUs.

Currently, we do not use RTM for anything in glibc by default, even if
it is available according to CPUID.  (There are ways to opt in, unless
the CPU is on the disallow list due to the early Haswell bug.)  I'm
worried that if we start executing XTEST on all CPUs that indicate RTM
support, we will see lots of weird issues, along the lines of bug 27398.
