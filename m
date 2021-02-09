Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92637314ED2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBIMR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:17:26 -0500
Received: from foss.arm.com ([217.140.110.172]:50716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhBIMRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:17:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3537CED1;
        Tue,  9 Feb 2021 04:16:27 -0800 (PST)
Received: from [10.37.8.18] (unknown [10.37.8.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E5F43F73B;
        Tue,  9 Feb 2021 04:16:25 -0800 (PST)
Subject: Re: [PATCH v12 7/7] kasan: don't run tests in async mode
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
References: <20210208165617.9977-1-vincenzo.frascino@arm.com>
 <20210208165617.9977-8-vincenzo.frascino@arm.com>
 <20210209120241.GF1435@arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <0e373526-0fa8-c5c0-fb41-5c17aa47f07c@arm.com>
Date:   Tue, 9 Feb 2021 12:20:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209120241.GF1435@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/21 12:02 PM, Catalin Marinas wrote:
> On Mon, Feb 08, 2021 at 04:56:17PM +0000, Vincenzo Frascino wrote:
>> From: Andrey Konovalov <andreyknvl@google.com>
>>
>> Asynchronous KASAN mode doesn't guarantee that a tag fault will be
>> detected immediately and causes tests to fail. Forbid running them
>> in asynchronous mode.
>>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> That's missing your SoB.
>

Yes, I will add it in the next iteration.

>> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
>> index 7285dcf9fcc1..f82d9630cae1 100644
>> --- a/lib/test_kasan.c
>> +++ b/lib/test_kasan.c
>> @@ -51,6 +51,10 @@ static int kasan_test_init(struct kunit *test)
>>  		kunit_err(test, "can't run KASAN tests with KASAN disabled");
>>  		return -1;
>>  	}
>> +	if (kasan_flag_async) {
>> +		kunit_err(test, "can't run KASAN tests in async mode");
>> +		return -1;
>> +	}
>>  
>>  	multishot = kasan_save_enable_multi_shot();
>>  	hw_set_tagging_report_once(false);
> 
> I think we can still run the kasan tests in async mode if we check the
> TFSR_EL1 at the end of each test by calling mte_check_tfsr_exit().
> 

IIUC this was the plan for the future. But I let Andrey comment for more details.

-- 
Regards,
Vincenzo
