Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAECD318F17
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 16:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhBKPrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 10:47:06 -0500
Received: from foss.arm.com ([217.140.110.172]:53282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhBKPRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:17:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EC95113E;
        Thu, 11 Feb 2021 07:06:23 -0800 (PST)
Received: from [10.37.8.13] (unknown [10.37.8.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D20EA3F73D;
        Thu, 11 Feb 2021 07:06:21 -0800 (PST)
Subject: Re: [PATCH] arm64: Fix warning in mte_get_random_tag()
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
References: <20210211125602.44248-1-vincenzo.frascino@arm.com>
 <CAMj1kXHED=O4uXzRAKiD8kE1Vb3Dr=oU-shLQ8UBBDn2N-1nuA@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <49a080e6-4482-0d8a-2360-eba698b92457@arm.com>
Date:   Thu, 11 Feb 2021 15:10:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHED=O4uXzRAKiD8kE1Vb3Dr=oU-shLQ8UBBDn2N-1nuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/21 1:35 PM, Ard Biesheuvel wrote:
> On Thu, 11 Feb 2021 at 13:57, Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> The simplification of mte_get_random_tag() caused the introduction of the
>> warning below:
>>
>> In file included from arch/arm64/include/asm/kasan.h:9,
>>                  from include/linux/kasan.h:16,
>>                  from mm/kasan/common.c:14:
>> mm/kasan/common.c: In function ‘mte_get_random_tag’:
>> arch/arm64/include/asm/mte-kasan.h:45:9: warning: ‘addr’ is used
>>                                          uninitialized [-Wuninitialized]
>>    45 |         asm(__MTE_PREAMBLE "irg %0, %0"
>>       |
>>
>> Fix the warning initializing the address to NULL.
>>
>> Note: mte_get_random_tag() returns a tag and it never dereferences the address,
>> hence 'addr' can be safely initialized to NULL.
>>
>> Fixes: c8f8de4c0887 ("arm64: kasan: simplify and inline MTE functions")
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Andrey Konovalov <andreyknvl@google.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>
>> This patch is based on linux-next/akpm
>>
>>  arch/arm64/include/asm/mte-kasan.h | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
>> index 3d58489228c0..b2850b750726 100644
>> --- a/arch/arm64/include/asm/mte-kasan.h
>> +++ b/arch/arm64/include/asm/mte-kasan.h
>> @@ -40,7 +40,12 @@ static inline u8 mte_get_mem_tag(void *addr)
>>  /* Generate a random tag. */
>>  static inline u8 mte_get_random_tag(void)
>>  {
>> -       void *addr;
>> +       /*
>> +        * mte_get_random_tag() returns a tag and it
>> +        * never dereferences the address, hence addr
>> +        * can be safely initialized to NULL.
>> +        */
>> +       void *addr = NULL;
>>
>>         asm(__MTE_PREAMBLE "irg %0, %0"
>>                 : "+r" (addr));
>> --
>> 2.30.0
>>
> 
> Might it be better to simply change the asm constraint to "=r" ?
> 

Indeed, did not notice the "+r". I will change it accordingly and post v2.

Thanks!

-- 
Regards,
Vincenzo
