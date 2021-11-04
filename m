Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE63D444CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 02:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhKDBRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 21:17:00 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14712 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhKDBQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 21:16:57 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hl5G43Y0vzZckx;
        Thu,  4 Nov 2021 09:12:12 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 09:14:18 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 09:14:17 +0800
Message-ID: <7e52f57a-2ff8-736e-d6ea-1e61e5f79375@huawei.com>
Date:   Thu, 4 Nov 2021 09:14:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] ARM: Support KFENCE for ARM
Content-Language: en-US
To:     Alexander Potapenko <glider@google.com>
CC:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Marco Elver" <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20211103133845.78528-1-wangkefeng.wang@huawei.com>
 <20211103133845.78528-4-wangkefeng.wang@huawei.com>
 <CAG_fn=WT9DzGmXrw97AhgCnyREQaACcgHg-3i62D-qNhUZ0xzg@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAG_fn=WT9DzGmXrw97AhgCnyREQaACcgHg-3i62D-qNhUZ0xzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/4 0:22, Alexander Potapenko wrote:
> On Wed, Nov 3, 2021 at 2:26 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>> Add architecture specific implementation details for KFENCE and enable
>> KFENCE on ARM. In particular, this implements the required interface in
>>   <asm/kfence.h>.
>>
>> KFENCE requires that attributes for pages from its memory pool can
>> individually be set. Therefore, force the kfence pool to be mapped
>> at page granularity.
>>
>> Testing this patch using the testcases in kfence_test.c and all passed
>> with or without ARM_LPAE.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
...
>> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
>> index f7ab6dabe89f..49148b675b43 100644
>> --- a/arch/arm/mm/fault.c
>> +++ b/arch/arm/mm/fault.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/sched/debug.h>
>>   #include <linux/highmem.h>
>>   #include <linux/perf_event.h>
>> +#include <linux/kfence.h>
>>
>>   #include <asm/system_misc.h>
>>   #include <asm/system_info.h>
>> @@ -99,6 +100,11 @@ void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
>>   { }
>>   #endif                                 /* CONFIG_MMU */
>>
>> +static inline bool is_write_fault(unsigned int fsr)
>> +{
>> +       return (fsr & FSR_WRITE) && !(fsr & FSR_CM);
>> +}
> 
> Please don't increase the diff by moving the code around. Consider
> putting is_write_fault() in the right place in "ARM: mm: Provide
> is_write_fault()" instead.
Sure. Let's wait some time to see whether there are any other comments,
and resend, thanks.
> .
> 
