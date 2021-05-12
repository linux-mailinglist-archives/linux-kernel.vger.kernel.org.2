Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67F237BFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhELORb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231529AbhELORR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:17:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3365613F7;
        Wed, 12 May 2021 14:16:00 +0000 (UTC)
Subject: Re: [PATCH 20/33] locking/atomic: m68k: move to ARCH_ATOMIC
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Brian Cain <bcain@codeaurora.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>, Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Henderson <rth@twiddle.net>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20210510093753.40683-1-mark.rutland@arm.com>
 <20210510093753.40683-21-mark.rutland@arm.com>
 <CAMuHMdVFOvyQYBn45QSb-jHA3G5Guv0hRb-LO1n8L_gWzcZm8w@mail.gmail.com>
 <20210511100022.GD6152@C02TD0UTHF1T.local>
 <CAMuHMdV5LpRbDcbmQHP4gzXv6JiLzKNP8dAiMOa0GsfE5KgJzA@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <2501f556-1326-f09c-baa2-464057ea100c@linux-m68k.org>
Date:   Thu, 13 May 2021 00:15:58 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdV5LpRbDcbmQHP4gzXv6JiLzKNP8dAiMOa0GsfE5KgJzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Geert,

On 11/5/21 8:27 pm, Geert Uytterhoeven wrote:
> Hi Mark,
> 
> CC Greg
> 
> On Tue, May 11, 2021 at 12:00 PM Mark Rutland <mark.rutland@arm.com> wrote:
>> On Tue, May 11, 2021 at 11:27:45AM +0200, Geert Uytterhoeven wrote:
>>> On Mon, May 10, 2021 at 11:42 AM Mark Rutland <mark.rutland@arm.com> wrote:
>>>> We'd like all architectures to convert to ARCH_ATOMIC, as once all
>>>> architectures are converted it will be possible to make significant
>>>> cleanups to the atomics headers, and this will make it much easier to
>>>> generically enable atomic functionality (e.g. debug logic in the
>>>> instrumented wrappers).
>>>>
>>>> As a step towards that, this patch migrates m68k to ARCH_ATOMIC. The
>>>> arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
>>>> code wraps these with optional instrumentation to provide the regular
>>>> functions.
>>>>
>>>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>>>
>>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>
>>> I even gave this series a spin on ARAnyM and QEMU, and everything
>>> seems to be fine.
>>
>> Thanks! That's much appreciated; I was able to build-test, but didn't
>> have a suitable setup for boot testing.
>>
>> The Kbuild test robot noticed I broke one configuration by renaming
>> atomic_dec_and_test_lt(), since it's not part of the common atomic API,
>> and is used in get_mmu_context() in <asm/mmu_context.h>.
> 
> Ah, that's in the part for Coldfire, so I (and my builds) didn't notice.
> 
>> On the primciple of keeping the common atomic API separate from
>> arch-specific bits, I've kept the `arch_` prefix and updated the caller.
>> Does that sound good to you?
> 
> That's fine for me, but as this is Coldfire, I'd like to defer to Greg.

Looks fine to me too.

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg

