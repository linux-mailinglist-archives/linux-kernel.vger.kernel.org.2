Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261AF398E0B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhFBPPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:15:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3517 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhFBPPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:15:01 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FwCBv15T3zYq3W;
        Wed,  2 Jun 2021 23:10:31 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 23:13:15 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 23:13:15 +0800
Subject: Re: [PATCH v2 7/7] ARM: mm: Fix PXN process with LPAE feature
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>
References: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
 <20210602070246.83990-8-wangkefeng.wang@huawei.com>
 <20210602105255.GK30436@shell.armlinux.org.uk>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <62f08378-85e7-2a07-3fd0-b287047ce1b5@huawei.com>
Date:   Wed, 2 Jun 2021 23:13:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210602105255.GK30436@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/6/2 18:52, Russell King (Oracle) wrote:
> Hi,
>
> On Wed, Jun 02, 2021 at 03:02:46PM +0800, Kefeng Wang wrote:
>> When user code execution with privilege mode, it will lead to
>> infinite loop in the page fault handler if ARM_LPAE enabled,
>>
>> The issue could be reproduced with
>>    "echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT"
>>
>> Lets' fix it by adding the check in do_page_fault() and panic
>> when ARM_LPAE enabled.
>>
>> Fixes: 1d4d37159d01 ("ARM: 8235/1: Support for the PXN CPU feature on ARMv7")
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   arch/arm/mm/fault.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
>> index 7cfa9a59d3ec..279bbeb33b48 100644
>> --- a/arch/arm/mm/fault.c
>> +++ b/arch/arm/mm/fault.c
>> @@ -257,8 +257,14 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>>   		vm_flags = VM_WRITE;
>>   	}
>>   
>> -	if (fsr & FSR_LNX_PF)
>> +	if (fsr & FSR_LNX_PF) {
>>   		vm_flags = VM_EXEC;
>> +#ifdef CONFIG_ARM_LPAE
>> +		if (addr && addr < TASK_SIZE && !user_mode(regs))
>> +			die_kernel_fault("execution of user memory",
>> +					 addr, fsr, regs);
>> +#endif
>> +	}
> Do we need to do this test here?
>
> Also, is this really LPAE specific? We have similar protection on 32-bit
> ARM using domains to disable access to userspace except when the user
> accessors are being used, so I would expect kernel-mode execution to
> also cause a fault there.
   IFSR format when using the Short-descriptor translation table format

     Domain fault      01001            First level   01011     Second level

     Permission fault 01101            First level   01111     Second level

   IFSR format when using the Long-descriptor translation table format

    0011LL Permission fault. LL bits indicate levelb.

After check the ARM spec, I think for the permission fault,  we should panic

with or without LPAE, will change to

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 7cfa9a59d3ec..dd97d9b19dec 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -257,8 +257,11 @@ do_page_fault(unsigned long addr, unsigned int fsr, 
struct pt_regs *regs)
                 vm_flags = VM_WRITE;
         }

-       if (fsr & FSR_LNX_PF)
+       if (fsr & FSR_LNX_PF) {
                 vm_flags = VM_EXEC;
+               if (!user_mode(regs))
+                       die_kernel_fault("execution of memory", addr, 
fsr, regs);
+       }

         perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);

If no object, I will send all patches with updates to  patch system,  
thanks.

>
