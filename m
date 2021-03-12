Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090D6339222
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhCLPpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:45:46 -0500
Received: from foss.arm.com ([217.140.110.172]:55982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232375AbhCLPoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:44:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF6851FB;
        Fri, 12 Mar 2021 07:44:20 -0800 (PST)
Received: from [10.37.8.6] (unknown [10.37.8.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02E3A3F7D7;
        Fri, 12 Mar 2021 07:44:18 -0800 (PST)
Subject: Re: [PATCH v15 5/8] arm64: mte: Enable TCO in functions that can read
 beyond buffer limits
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210312142210.21326-1-vincenzo.frascino@arm.com>
 <20210312142210.21326-6-vincenzo.frascino@arm.com>
 <20210312151259.GB24210@arm.com>
 <31b7a388-4c57-cb25-2d30-da7c37e2b4d6@arm.com>
 <20210312152927.GD24210@arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <a47c2109-844d-1435-2b01-3d985d942514@arm.com>
Date:   Fri, 12 Mar 2021 15:44:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210312152927.GD24210@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/21 3:29 PM, Catalin Marinas wrote:
> On Fri, Mar 12, 2021 at 03:23:44PM +0000, Vincenzo Frascino wrote:
>> On 3/12/21 3:13 PM, Catalin Marinas wrote:
>>> On Fri, Mar 12, 2021 at 02:22:07PM +0000, Vincenzo Frascino wrote:
>>>> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
>>>> index 9b557a457f24..8603c6636a7d 100644
>>>> --- a/arch/arm64/include/asm/mte.h
>>>> +++ b/arch/arm64/include/asm/mte.h
>>>> @@ -90,5 +90,20 @@ static inline void mte_assign_mem_tag_range(void *addr, size_t size)
>>>>  
>>>>  #endif /* CONFIG_ARM64_MTE */
>>>>  
>>>> +#ifdef CONFIG_KASAN_HW_TAGS
>>>> +/* Whether the MTE asynchronous mode is enabled. */
>>>> +DECLARE_STATIC_KEY_FALSE(mte_async_mode);
>>>> +
>>>> +static inline bool system_uses_mte_async_mode(void)
>>>> +{
>>>> +	return static_branch_unlikely(&mte_async_mode);
>>>> +}
>>>> +#else
>>>> +static inline bool system_uses_mte_async_mode(void)
>>>> +{
>>>> +	return false;
>>>> +}
>>>> +#endif /* CONFIG_KASAN_HW_TAGS */
>>>
>>> You can write this with fewer lines:
>>>
>>> DECLARE_STATIC_KEY_FALSE(mte_async_mode);
>>>
>>> static inline bool system_uses_mte_async_mode(void)
>>> {
>>> 	return IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&
>>> 		static_branch_unlikely(&mte_async_mode);
>>> }
>>>
>>> The compiler will ensure that mte_async_mode is not referred when
>>> !CONFIG_KASAN_HW_TAGS and therefore doesn't need to be defined.
>>
>> Yes, I agree, but I introduce "#ifdef CONFIG_KASAN_HW_TAGS" in the successive
>> patch anyway, according to me the overall code looks more uniform like this. But
>> I do not have a strong opinion or preference on this.
> 
> Ah, yes, I didn't look at patch 6 again as it was already reviewed and I
> forgot the context. Leave it as it is then, my reviewed-by still stands.
> 

Ok, thanks.

-- 
Regards,
Vincenzo
