Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2644308C37
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhA2SN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:13:26 -0500
Received: from foss.arm.com ([217.140.110.172]:52498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhA2SNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:13:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B969913A1;
        Fri, 29 Jan 2021 10:12:37 -0800 (PST)
Received: from [10.37.12.11] (unknown [10.37.12.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F5033F885;
        Fri, 29 Jan 2021 10:12:35 -0800 (PST)
Subject: Re: [PATCH v9 3/4] kasan: Add report for async mode
To:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
References: <20210126134603.49759-1-vincenzo.frascino@arm.com>
 <20210126134603.49759-4-vincenzo.frascino@arm.com>
 <CAAeHK+xAbsX9Zz4aKXToNTrbgrrYck23ohGJHXvgeSTyZy=Odg@mail.gmail.com>
 <e5582f87-2987-a258-350f-1fac61822657@arm.com>
 <CAAeHK+x5O595yU9q03G8xPvwpU_3Y6bQhW=+09GziOuTPZNVHw@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <f1ad988d-6385-45e0-d683-048bfca0b9c0@arm.com>
Date:   Fri, 29 Jan 2021 18:16:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+x5O595yU9q03G8xPvwpU_3Y6bQhW=+09GziOuTPZNVHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/21 6:09 PM, Andrey Konovalov wrote:
> On Fri, Jan 29, 2021 at 6:56 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> Hi Andrey,
>>
>> On 1/29/21 5:40 PM, Andrey Konovalov wrote:
>>> I suggest to call end_report(&flags, 0) here and check addr !=0 in
>>> end_report() before calling trace_error_report_end().
>>>
>>
>> Probably this is better as:
>>
>> if (!IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>>
>> Because that condition passes always addr == 0.
> 
> Not sure I understand. Call report_end(&flags, 0) and then there do:
> 
> if (addr) trace_error_report_end(...);
> 
> Although maybe it makes sense to still trace all async bugs to address
> 0. Or to some magic address.
> 
> Alex, WDYT?
> 

What I meant is instead of:

if (addr) trace_error_report_end(...);

you might want to do:

if (!IS_ENABLED(CONFIG_KASAN_HW_TAGS)) trace_error_report_end(...);

because, could make sense to trace 0 in other cases?

I could not find the implementation of trace_error_report_end() hence I am not
really sure on what it does.

-- 
Regards,
Vincenzo
