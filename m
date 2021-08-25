Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE053F776D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbhHYOcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:32:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18040 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbhHYOce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:32:34 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GvpH001z6zbj5X;
        Wed, 25 Aug 2021 22:27:56 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 22:31:46 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 22:31:45 +0800
Subject: Re: [PATCH 3/4] ARM: Support KFENCE for ARM
To:     ownia <ownia.linux@gmail.com>
CC:     Russell King <linux@armlinux.org.uk>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kasan-dev@googlegroups.com>
References: <20210825092116.149975-1-wangkefeng.wang@huawei.com>
 <20210825092116.149975-4-wangkefeng.wang@huawei.com>
 <51b02ecd-0f3d-99b0-c943-1d4da26174d0@gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <8531455d-3198-96cd-e26b-03156f95ac80@huawei.com>
Date:   Wed, 25 Aug 2021 22:31:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <51b02ecd-0f3d-99b0-c943-1d4da26174d0@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/8/25 21:18, ownia wrote:
> On 2021/8/25 17:21, Kefeng Wang wrote:
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
>> +#endif /* __ASM_ARM_KFENCE_H */
>> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
>> index f7ab6dabe89f..9fa221ffa1b9 100644
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
>> @@ -131,10 +132,14 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
>>   	/*
>>   	 * No handler, we'll have to terminate things with extreme prejudice.
>>   	 */
>> -	if (addr < PAGE_SIZE)
>> +	if (addr < PAGE_SIZE) {
>>   		msg = "NULL pointer dereference";
>> -	else
>> +	} else {
>> +		if (kfence_handle_page_fault(addr, is_write_fault(fsr), regs))
>> +			return;
>> +
>>   		msg = "paging request";
>> +	}
>
> I think here should do some fixup to follow upstream mainline code.

Yes, the fixup is still there, as the cover-letter said,

NOTE:
The context of patch2/3 changes in arch/arm/mm/fault.c is based on link[1],
which make some refactor and cleanup about page fault.

...

[1]https://lore.kernel.org/linux-arm-kernel/20210610123556.171328-1-wangkefeng.wang@huawei.com/

>
>>   
>>   	die_kernel_fault(msg, mm, addr, fsr, regs);
>>   }
> .
>
