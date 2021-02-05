Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6943111AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhBESR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:17:29 -0500
Received: from foss.arm.com ([217.140.110.172]:36746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233104AbhBEPU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:20:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27E7731B;
        Fri,  5 Feb 2021 08:51:20 -0800 (PST)
Received: from [10.37.8.15] (unknown [10.37.8.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5420C3F718;
        Fri,  5 Feb 2021 08:51:18 -0800 (PST)
Subject: Re: [PATCH v11 2/5] kasan: Add KASAN mode kernel parameter
To:     Will Deacon <will@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
References: <20210130165225.54047-1-vincenzo.frascino@arm.com>
 <20210130165225.54047-3-vincenzo.frascino@arm.com>
 <CAAeHK+y=t4c5FfVx3r3Rvwg3GTYN_q1xme=mwk51hgQfJX9MZw@mail.gmail.com>
 <CAAeHK+wdPDZkUSu+q1zb=YWxVD68mXqde9c+gYB4bb=zCsvbZw@mail.gmail.com>
 <96163fa8-c093-8c2f-e085-8c2148882748@arm.com>
 <20210205164822.GB22665@willie-the-truck>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <2d039894-708d-6bac-df45-fc68098c2ce9@arm.com>
Date:   Fri, 5 Feb 2021 16:55:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205164822.GB22665@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/21 4:48 PM, Will Deacon wrote:
> On Fri, Feb 05, 2021 at 04:00:07PM +0000, Vincenzo Frascino wrote:
>>
>>
>> On 2/5/21 3:49 PM, Andrey Konovalov wrote:
>>> On Mon, Feb 1, 2021 at 9:04 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>>>>
>>>> On Sat, Jan 30, 2021 at 5:52 PM Vincenzo Frascino
>>>> <vincenzo.frascino@arm.com> wrote:
>>>>>
>>>>> @@ -45,6 +52,9 @@ static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
>>>>>  DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
>>>>>  EXPORT_SYMBOL(kasan_flag_enabled);
>>>>>
>>>>> +/* Whether the asynchronous mode is enabled. */
>>>>> +bool kasan_flag_async __ro_after_init;
>>>>
>>>> Just noticed that we need EXPORT_SYMBOL(kasan_flag_async) here.
>>>
>>> Hi Vincenzo,
>>>
>>> If you post a new version of this series, please include
>>> EXPORT_SYMBOL(kasan_flag_async).
>>>
>>
>> I can do that, no problem.
> 
> EXPORT_SYMBOL_GPL, please :)
> 

Thanks Will, I will :)

> Will
> 

-- 
Regards,
Vincenzo
