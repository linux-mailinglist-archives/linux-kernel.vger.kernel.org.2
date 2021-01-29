Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44BD308C04
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhA2R60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:58:26 -0500
Received: from foss.arm.com ([217.140.110.172]:52228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231246AbhA2R6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:58:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD3C913A1;
        Fri, 29 Jan 2021 09:57:38 -0800 (PST)
Received: from [10.37.12.11] (unknown [10.37.12.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 956A93F885;
        Fri, 29 Jan 2021 09:57:36 -0800 (PST)
Subject: Re: [PATCH v9 3/4] kasan: Add report for async mode
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
References: <20210126134603.49759-1-vincenzo.frascino@arm.com>
 <20210126134603.49759-4-vincenzo.frascino@arm.com>
 <CAAeHK+xAbsX9Zz4aKXToNTrbgrrYck23ohGJHXvgeSTyZy=Odg@mail.gmail.com>
 <77de8e48-6f68-bf27-0bed-02e49b69a12d@arm.com>
 <CAAeHK+xMWXpfLs6HuKN73e0p61nm+QrZO1-oXphJpjZprKQVKg@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <7da762df-6df3-e526-bec1-dc770709c00c@arm.com>
Date:   Fri, 29 Jan 2021 18:01:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xMWXpfLs6HuKN73e0p61nm+QrZO1-oXphJpjZprKQVKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/21 5:56 PM, Andrey Konovalov wrote:
> On Fri, Jan 29, 2021 at 6:44 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>>
>>
>> On 1/29/21 5:40 PM, Andrey Konovalov wrote:
>>> On Tue, Jan 26, 2021 at 2:46 PM Vincenzo Frascino
>>> <vincenzo.frascino@arm.com> wrote:
>>>>
>>>> KASAN provides an asynchronous mode of execution.
>>>>
>>>> Add reporting functionality for this mode.
>>>>
>>>> Cc: Dmitry Vyukov <dvyukov@google.com>
>>>> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
>>>> Cc: Alexander Potapenko <glider@google.com>
>>>> Cc: Andrey Konovalov <andreyknvl@google.com>
>>>> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
>>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>>> ---
>>>>  include/linux/kasan.h |  6 ++++++
>>>>  mm/kasan/report.c     | 13 +++++++++++++
>>>>  2 files changed, 19 insertions(+)
>>>>
>>>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>>>> index bb862d1f0e15..b6c502dad54d 100644
>>>> --- a/include/linux/kasan.h
>>>> +++ b/include/linux/kasan.h
>>>> @@ -360,6 +360,12 @@ static inline void *kasan_reset_tag(const void *addr)
>>>>
>>>>  #endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS*/
>>>>
>>>> +#ifdef CONFIG_KASAN_HW_TAGS
>>>> +
>>>> +void kasan_report_async(void);
>>>> +
>>>> +#endif /* CONFIG_KASAN_HW_TAGS */
>>>> +
>>>>  #ifdef CONFIG_KASAN_SW_TAGS
>>>>  void __init kasan_init_sw_tags(void);
>>>>  #else
>>>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>>>> index 87b271206163..69bad9c01aed 100644
>>>> --- a/mm/kasan/report.c
>>>> +++ b/mm/kasan/report.c
>>>> @@ -360,6 +360,19 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>>>>         end_report(&flags, (unsigned long)object);
>>>>  }
>>>>
>>>> +#ifdef CONFIG_KASAN_HW_TAGS
>>>> +void kasan_report_async(void)
>>>> +{
>>>> +       unsigned long flags;
>>>> +
>>>> +       start_report(&flags);
>>>> +       pr_err("BUG: KASAN: invalid-access\n");
>>>> +       pr_err("Asynchronous mode enabled: no access details available\n");
> 
> Could you also add an empty line here before the stack trace while at it?
> 

Sure no problem.

>>>> +       dump_stack();
>>>> +       end_report(&flags);
>>>
>>> This conflicts with "kasan: use error_report_end tracepoint" that's in mm.
>>>
>>> I suggest to call end_report(&flags, 0) here and check addr !=0 in
>>> end_report() before calling trace_error_report_end().
>>>
>>
>> I just noticed and about to post a rebased version with end_report(&flags, 0).
>>
>>
>>>> +}
>>>> +#endif /* CONFIG_KASAN_HW_TAGS */
>>>> +
>>>>  static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>>>>                                 unsigned long ip)
>>>>  {
>>>> --
>>>> 2.30.0
>>>>
>>
>> --
>> Regards,
>> Vincenzo

-- 
Regards,
Vincenzo
