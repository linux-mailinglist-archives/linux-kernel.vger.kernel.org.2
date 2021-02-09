Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3C5315529
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhBIReE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:34:04 -0500
Received: from foss.arm.com ([217.140.110.172]:54554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233035AbhBIRdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:33:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3B90ED1;
        Tue,  9 Feb 2021 09:33:05 -0800 (PST)
Received: from [10.37.8.18] (unknown [10.37.8.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBEB83F73B;
        Tue,  9 Feb 2021 09:33:02 -0800 (PST)
Subject: Re: [PATCH v12 7/7] kasan: don't run tests in async mode
To:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210208165617.9977-1-vincenzo.frascino@arm.com>
 <20210208165617.9977-8-vincenzo.frascino@arm.com>
 <20210209120241.GF1435@arm.com>
 <0e373526-0fa8-c5c0-fb41-5c17aa47f07c@arm.com>
 <CAAeHK+yj9PR2Tw_xrpKKh=8GyNwgOaEu1pK8L6XL4zz0NtVs3A@mail.gmail.com>
 <20210209170654.GH1435@arm.com>
 <CAAeHK+wz1LWQmDgem8ts30gXc=SkwZ-HM507=a+iiNpOYM-ssw@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <79183efe-ef9e-0a31-cdfa-e1bfae39b015@arm.com>
Date:   Tue, 9 Feb 2021 17:37:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+wz1LWQmDgem8ts30gXc=SkwZ-HM507=a+iiNpOYM-ssw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 2/9/21 5:26 PM, Andrey Konovalov wrote:
> On Tue, Feb 9, 2021 at 6:07 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>>
>> On Tue, Feb 09, 2021 at 04:02:25PM +0100, Andrey Konovalov wrote:
>>> On Tue, Feb 9, 2021 at 1:16 PM Vincenzo Frascino
>>> <vincenzo.frascino@arm.com> wrote:
>>>> On 2/9/21 12:02 PM, Catalin Marinas wrote:
>>>>> On Mon, Feb 08, 2021 at 04:56:17PM +0000, Vincenzo Frascino wrote:
>>>>>> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
>>>>>> index 7285dcf9fcc1..f82d9630cae1 100644
>>>>>> --- a/lib/test_kasan.c
>>>>>> +++ b/lib/test_kasan.c
>>>>>> @@ -51,6 +51,10 @@ static int kasan_test_init(struct kunit *test)
>>>>>>              kunit_err(test, "can't run KASAN tests with KASAN disabled");
>>>>>>              return -1;
>>>>>>      }
>>>>>> +    if (kasan_flag_async) {
>>>>>> +            kunit_err(test, "can't run KASAN tests in async mode");
>>>>>> +            return -1;
>>>>>> +    }
>>>>>>
>>>>>>      multishot = kasan_save_enable_multi_shot();
>>>>>>      hw_set_tagging_report_once(false);
>>>>>
>>>>> I think we can still run the kasan tests in async mode if we check the
>>>>> TFSR_EL1 at the end of each test by calling mte_check_tfsr_exit().
>>>>>
>>>>
>>>> IIUC this was the plan for the future. But I let Andrey comment for more details.
>>>
>>> If it's possible to implement, then it would be good to have. Doesn't
>>> have to be a part of this series though.
>>
>> I think it can be part of this series but after the 5.12 merging window
>> (we are a few days away from final 5.11 and I don't think we should
>> rush the MTE kernel async support in).
>>
>> It would be nice to have the kasan tests running with async by the time
>> we merge the patches (at a quick look, I think it's possible but, of
>> course, we may hit some blockers when implementing it).
> 
> OK, sounds good.
> 
> If it's possible to put an explicit check for tag faults at the end of
> each test, then adding async support shouldn't be hard.
> 
> Note, that some of the tests trigger bugs that are detected via
> explicit checks within KASAN. For example, KASAN checks that a pointer
> that's being freed points to a start of a slab object, or that the
> object is accessible when it gets freed, etc. I don't see this being a
> problem, so just FYI.
> 

Once you have your patches ready please send them to me and I will repost
another version. In the meantime I will address the remaining comments.

> Thanks!
> 

-- 
Regards,
Vincenzo
