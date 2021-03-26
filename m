Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB07034AF64
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCZTeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:34:36 -0400
Received: from albireo.enyo.de ([37.24.231.21]:54790 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230003AbhCZTec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:34:32 -0400
Received: from [172.17.203.2] (port=41575 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lPsDy-00017a-I1; Fri, 26 Mar 2021 19:34:26 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1lPsDy-0007IK-Bb; Fri, 26 Mar 2021 20:34:26 +0100
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
Date:   Fri, 26 Mar 2021 20:34:26 +0100
In-Reply-To: <CALCETrUM1=Db3vmQAhPkt=SktL7+dtUrt5Ef6BP3T1Q6HY3Bmw@mail.gmail.com>
        (Andy Lutomirski's message of "Fri, 26 Mar 2021 11:14:22 -0700")
Message-ID: <87blb5d7zx.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski:

>> > AVX-512 cleared, and programs need to explicitly request enablement.
>> > This would allow programs to opt into not saving/restoring across
>> > signals or to save/restore in buffers supplied when the feature is
>> > enabled.
>>
>> Isn't XSAVEOPT already able to handle that?
>>
>
> Yes, but we need a place to put the data, and we need to acknowledge
> that, with the current save-everything-on-signal model, the amount of
> time and memory used is essentially unbounded.  This isn't great.

The size has to have a known upper bound, but the save amount can be
dynamic, right?

How was the old lazy FPU initialization support for i386 implemented?

>> Assuming you can make XSAVEOPT work for you on the kernel side, my
>> instincts tell me that we should have markup for RTM, not for AVX-512.
>> This way, we could avoid use of the AVX-512 registers and keep using
>> VZEROUPPER, without run-time transaction checks, and deal with other
>> idiosyncrasies needed for transaction support that users might
>> encounter once this feature sees more use.  But the VZEROUPPER vs RTM
>> issues is currently stuck in some internal process issue on my end (or
>> two, come to think of it), which I hope to untangle next month.
>
> Can you elaborate on the issue?

This is the bug:

  vzeroupper use in AVX2 multiarch string functions cause HTM aborts 
  <https://sourceware.org/bugzilla/show_bug.cgi?id=27457>

Unfortunately we have a bug (outside of glibc) that makes me wonder if
we can actually roll out RTM transaction checks (or any RTM
instruction) on a large scale:

  x86: Sporadic failures in tst-cpu-features-cpuinfo 
  <https://sourceware.org/bugzilla/show_bug.cgi?id=27398#c3>

The dynamic RTM check might trap due to this bug.  (We have a bit more
information about the nature of the bug, currently missing from
Bugzilla.)

I'm also worried that the new dynamic RTM check in the string
functions has a performance impact.  Due to its nature, it will be
enabled for every program once running on RTM-capable hardware, not
just those that actually use RTM.
