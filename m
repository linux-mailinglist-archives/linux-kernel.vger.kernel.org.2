Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C4F34B037
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 21:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhCZUfn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 Mar 2021 16:35:43 -0400
Received: from albireo.enyo.de ([37.24.231.21]:55738 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230003AbhCZUfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 16:35:34 -0400
Received: from [172.17.203.2] (port=40449 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lPtB0-00038H-F0; Fri, 26 Mar 2021 20:35:26 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1lPtB0-0008Aa-CB; Fri, 26 Mar 2021 21:35:26 +0100
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
Date:   Fri, 26 Mar 2021 21:35:26 +0100
In-Reply-To: <CALCETrUXMnutTV=SEs6ot58j32_5=K5Z=G7_57gVZt_GFcuDiw@mail.gmail.com>
        (Andy Lutomirski's message of "Fri, 26 Mar 2021 12:47:42 -0700")
Message-ID: <877dltd569.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski:

> On Fri, Mar 26, 2021 at 12:34 PM Florian Weimer <fw@deneb.enyo.de> wrote:
>>   x86: Sporadic failures in tst-cpu-features-cpuinfo
>>   <https://sourceware.org/bugzilla/show_bug.cgi?id=27398#c3>
>
> It's worth noting that recent microcode updates have make RTM
> considerably less likely to actually work on many parts.  It's
> possible you should just disable it. :(

Sorry, I'm not sure who should disable it.

Let me sum up the situation:

We have a request for a performance enhancement in glibc, so that
applications can use it on server parts where RTM actually works.

For CPUs that support AVX-512, we may be able to meet that with a
change that uses the new 256-bit registers, t avoid the %xmm
transition penalty.  (This is the easy case, hopefully—there shouldn't
be any frequency issues associated with that, and if the kernel
doesn't optimize the context switch today, that's a nonissue as well.)

For CPUs that do not support AVX-512 but support RTM (and AVX2), we
need a dynamic run-time check whether the string function is invoked
in a transaction.  In that case, we need to use VZEROALL instead of
VZEROUPPER.  (It's apparently too costly to issue VZEROALL
unconditionally.)

All this needs to work transparently without user intervention.  We
cannot require firmware upgrades to fix the incorrect RTM reporting
issue (the bug I referenced).  I think we can require software updates
which tell glibc when to use RTM-enabled string functions if the
dynamic selection does not work (either for performance reasons, or
because of the RTM reporting bug).

I want to avoid a situation where one in eight processes fail to work
correctly because the CPUID checks ran on CPU 0, where RTM is reported
as available, and then we trap when executing XTEST on other CPUs.
