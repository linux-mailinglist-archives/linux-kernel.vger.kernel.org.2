Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE1311762
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhBEXo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:44:27 -0500
Received: from foss.arm.com ([217.140.110.172]:35096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232502AbhBEOSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:18:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 514AA11B3;
        Fri,  5 Feb 2021 07:56:08 -0800 (PST)
Received: from [10.37.8.15] (unknown [10.37.8.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 726743F719;
        Fri,  5 Feb 2021 07:56:06 -0800 (PST)
Subject: Re: [PATCH v11 2/5] kasan: Add KASAN mode kernel parameter
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
References: <20210130165225.54047-1-vincenzo.frascino@arm.com>
 <20210130165225.54047-3-vincenzo.frascino@arm.com>
 <CAAeHK+y=t4c5FfVx3r3Rvwg3GTYN_q1xme=mwk51hgQfJX9MZw@mail.gmail.com>
 <CAAeHK+wdPDZkUSu+q1zb=YWxVD68mXqde9c+gYB4bb=zCsvbZw@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <96163fa8-c093-8c2f-e085-8c2148882748@arm.com>
Date:   Fri, 5 Feb 2021 16:00:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+wdPDZkUSu+q1zb=YWxVD68mXqde9c+gYB4bb=zCsvbZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/21 3:49 PM, Andrey Konovalov wrote:
> On Mon, Feb 1, 2021 at 9:04 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>>
>> On Sat, Jan 30, 2021 at 5:52 PM Vincenzo Frascino
>> <vincenzo.frascino@arm.com> wrote:
>>>
>>> @@ -45,6 +52,9 @@ static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
>>>  DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
>>>  EXPORT_SYMBOL(kasan_flag_enabled);
>>>
>>> +/* Whether the asynchronous mode is enabled. */
>>> +bool kasan_flag_async __ro_after_init;
>>
>> Just noticed that we need EXPORT_SYMBOL(kasan_flag_async) here.
> 
> Hi Vincenzo,
> 
> If you post a new version of this series, please include
> EXPORT_SYMBOL(kasan_flag_async).
>

I can do that, no problem.

> Thanks!
> 
>>
>> There are also a few arm64 mte functions that need to be exported, but
>> I've addressed that myself here:
>>
>> https://lore.kernel.org/linux-arm-kernel/cover.1612208222.git.andreyknvl@google.com/T/#m4746d3c410c3f6baddb726fc9ea9dd1496a4a788

-- 
Regards,
Vincenzo
