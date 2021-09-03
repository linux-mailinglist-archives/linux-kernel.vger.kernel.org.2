Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FDD3FFDDD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 12:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349050AbhICKGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 06:06:38 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:56336 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349041AbhICKG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 06:06:28 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1mM64b-0000nR-00; Fri, 03 Sep 2021 10:05:25 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1mM64Y-0007Ox-E7; Fri, 03 Sep 2021 11:05:24 +0100
Subject: Re: [PATCH] um: don't use CONFIG_X86_{32,64} symbols on x86
To:     Johannes Berg <johannes@sipsolutions.net>,
        David Laight <David.Laight@ACULAB.COM>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210902102750.1ddfef4c1915.Icb5c49998c55b87c8584d46894c01b114ae2e661@changeid>
 <f177f8b287f14c93b04542d7ab4a8dfd@AcuMS.aculab.com>
 <30ab717a9ba1c2bb17e2a6948ff61d26c4430772.camel@sipsolutions.net>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <f6759c9c-0c79-788b-7182-4519cd73008f@cambridgegreys.com>
Date:   Fri, 3 Sep 2021 11:05:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <30ab717a9ba1c2bb17e2a6948ff61d26c4430772.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2021 09:40, Johannes Berg wrote:
> On Fri, 2021-09-03 at 08:27 +0000, David Laight wrote:
>> From: Johannes Berg
>>> Sent: 02 September 2021 09:28
>>>
>>> The CONFIG_X86_32 and CONFIG_X86_64 symbols are used by
>>> both "real" x86 architecture builds and ARCH=um today.
>>> However, clearly most people and places in the code are
>>> treating it as the architecture Kconfig (technically
>>> that's just CONFIG_X86) and use it to indicate that the
>>> architecture is X86 in 32- or 64-bit flavour.
>>>
>>> This has caused a fair amount of issues in the past,
>>> for example drivers not building because use x86 macros
>>> or similar under CONFIG_X86_{32,64} ifdef, and then we
>>> find build reports and add "!UML" to their Kconfig etc.
>>>
>>> However, this is error-prone and a kind of whack-a-mole
>>> game, even with the build bots reporting things.
>> I suspect you've just changed the 'mole'.
> Yeah, that thought occurred to me too.
>
>
>> You've now got lots of lines like:
>>
>> #if defined(CONFIG_X86_64) || defined(CONFIG_X86_64_UML)
>>
>> Missing off the UML define is going to cause the 32bit code
>> to get compiled by mistake - which is likely to be more
>> confusing that the places where you need to do special 'stuff'
>> for UML
> I'm not sure I agree though.
>
> Yes, I agree that I have a number of lines. But looking through them, we
> have new ones:
>   - AFS, and it fundamentally wants to know the arch. If it misses one,
>     well, that can also happen with any other arch.
>   - XFS/falloc has arch-specific stuff again, and considers other
>     architectures too
>   - fs/ioctl.c is actually unnecessary since CONFIG_COMPAT doesn't exist
>     on UML
>   - same for blktrace
>   - BPF jit - not really sure about that one
BPF jit IIRC works. People are using UML as a verifier in testing environments for the "does it load and run on this kernel version" test.
>   - crypto Kconfig - but again already considers different architectures
>     there
>   - sound - ok that's a stupid one :)
>   - lzo - again stuff that already considers many architectures
>
> But on the other side removal we have
>   - sysctl
>   - netfilter
>   - security
>   - many fixes to driver Kconfig that you don't see here because they're
>     *missing* "depends on !UML" now
>
>
> So my gut feeling is that while we've indeed traded one mole for another
> in a sense, the somewhat surprising places (like sound and BPF) are much
> fewer, and most of the places that we now need it are places that are
> already considering different architectures.

+1. I'd rather fix all places the mole pops up once and for all.

>
> johannes
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

