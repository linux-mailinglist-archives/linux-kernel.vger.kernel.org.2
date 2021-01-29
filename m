Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F05308C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhA2SPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:15:10 -0500
Received: from foss.arm.com ([217.140.110.172]:52546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhA2SPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:15:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26ECA13A1;
        Fri, 29 Jan 2021 10:14:22 -0800 (PST)
Received: from [10.37.12.11] (unknown [10.37.12.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FF9F3F885;
        Fri, 29 Jan 2021 10:14:19 -0800 (PST)
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
 <7da762df-6df3-e526-bec1-dc770709c00c@arm.com>
 <CAAeHK+zrkLpOe2aJjWVMPHbvSFMXAEP2+fJVZ-3O4E--4-2KfQ@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <bbcdc4e0-29a7-d064-123d-a2f7d7dc223d@arm.com>
Date:   Fri, 29 Jan 2021 18:18:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+zrkLpOe2aJjWVMPHbvSFMXAEP2+fJVZ-3O4E--4-2KfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/21 6:10 PM, Andrey Konovalov wrote:
> On Fri, Jan 29, 2021 at 6:57 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>>>>> +#ifdef CONFIG_KASAN_HW_TAGS
>>>>>> +void kasan_report_async(void)
>>>>>> +{
>>>>>> +       unsigned long flags;
>>>>>> +
>>>>>> +       start_report(&flags);
>>>>>> +       pr_err("BUG: KASAN: invalid-access\n");
>>>>>> +       pr_err("Asynchronous mode enabled: no access details available\n");
>>>
>>> Could you also add an empty line here before the stack trace while at it?
>>>
>>
>> Sure no problem.
> 
> Just to be clear: I mean adding an empty line into the report itself
> via pr_err("\n") :)
> 

Yes I got it ;) It is late here but I am not completely asleep yet ;)

-- 
Regards,
Vincenzo
