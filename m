Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4A5411071
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbhITHrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:47:45 -0400
Received: from foss.arm.com ([217.140.110.172]:43928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhITHro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:47:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B4B41FB;
        Mon, 20 Sep 2021 00:46:17 -0700 (PDT)
Received: from [192.168.1.131] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B9283F59C;
        Mon, 20 Sep 2021 00:46:14 -0700 (PDT)
Subject: Re: [PATCH 5/5] kasan: Extend KASAN mode kernel parameter
To:     Marco Elver <elver@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210913081424.48613-1-vincenzo.frascino@arm.com>
 <20210913081424.48613-6-vincenzo.frascino@arm.com>
 <CANpmjNN5atO1u6+Y71EiEvr9V8+WhdOGzC_8gvviac+BDkP+sA@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <f789ede2-3fa2-8a50-3d82-8b2dc2f12386@arm.com>
Date:   Mon, 20 Sep 2021 09:46:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNN5atO1u6+Y71EiEvr9V8+WhdOGzC_8gvviac+BDkP+sA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On 9/16/21 12:43 PM, Marco Elver wrote:
>> +       case KASAN_ARG_MODE_ASYMM:
>> +               /* Asymm mode enabled. */
>> +               kasan_flag_asymm = true;
>> +               break;
>>         }
>>
>>         switch (kasan_arg_stacktrace) {
>> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
>> index 3639e7c8bb98..a8be62058d32 100644
>> --- a/mm/kasan/kasan.h
>> +++ b/mm/kasan/kasan.h
> Shouldn't kasan.h also define kasan_asymm_mode_enabled() similar to
> kasan_async_mode_enabled()?
> 
> And based on that, also use it where kasan_async_mode_enabled() is
> used in tests to ensure the tests do not fail. Otherwise, there is no
> purpose for kasan_flag_asymm.
>

I was not planning to have the tests shipped as part of this series, they will
come in a future one.

For what concerns kasan_flag_asymm, I agree with you it is meaningful only if
the tests are implemented hence I will remove it in v2.

Thanks for pointing this out.

> Thanks,
> -- Marco
> 

-- 
Regards,
Vincenzo
