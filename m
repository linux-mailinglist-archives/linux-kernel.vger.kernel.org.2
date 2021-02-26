Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B2A32615A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhBZKeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:34:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12584 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhBZKb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:31:58 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dn5Vb42nhzMfKd;
        Fri, 26 Feb 2021 18:29:11 +0800 (CST)
Received: from [10.174.176.191] (10.174.176.191) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Feb 2021 18:31:07 +0800
Subject: Re: [PATCH v14 08/11] arm64: kdump: reimplement crashkernel=X
To:     Catalin Marinas <catalin.marinas@arm.com>, <bhe@redhat.com>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-9-chenzhou10@huawei.com>
 <20210224160408.GC28965@arm.com>
CC:     <mingo@redhat.com>, <tglx@linutronix.de>, <rppt@kernel.org>,
        <dyoung@redhat.com>, <will@kernel.org>, <nsaenzjulienne@suse.de>,
        <corbet@lwn.net>, <John.P.donnelly@oracle.com>,
        <bhsharma@redhat.com>, <prabhakar.pkin@gmail.com>,
        <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <james.morse@arm.com>, <xiexiuqi@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <94cc9191-4eff-355f-ff02-1c5da416960e@huawei.com>
Date:   Fri, 26 Feb 2021 18:31:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210224160408.GC28965@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.191]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/2/25 0:04, Catalin Marinas wrote:
> On Sat, Jan 30, 2021 at 03:10:22PM +0800, Chen Zhou wrote:
>> There are following issues in arm64 kdump:
>> 1. We use crashkernel=X to reserve crashkernel below 4G, which
>> will fail when there is no enough low memory.
>> 2. If reserving crashkernel above 4G, in this case, crash dump
>> kernel will boot failure because there is no low memory available
>> for allocation.
>>
>> To solve these issues, change the behavior of crashkernel=X and
>> introduce crashkernel=X,[high,low]. crashkernel=X tries low allocation
>> in DMA zone, and fall back to high allocation if it fails.
>> We can also use "crashkernel=X,high" to select a region above DMA zone,
>> which also tries to allocate at least 256M in DMA zone automatically.
>> "crashkernel=Y,low" can be used to allocate specified size low memory.
>>
>> Another minor change, there may be two regions reserved for crash
>> dump kernel, in order to distinct from the high region and make no
>> effect to the use of existing kexec-tools, rename the low region as
>> "Crash kernel (low)".
> I think we discussed this but I don't remember the conclusion. Is this
> only renamed conditionally so that we don't break current kexec-tools?
Yes.
>
> IOW, assuming that the full crashkernel region is reserved below 4GB,
> does the "(low)" suffix still appear or it's only if a high region is
> additionally reserved?
Suffix "low" only appear if a high region is additionally reserved.
>
>> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
>> index 3f6ecae0bc68..f0caed0cb5e1 100644
>> --- a/arch/arm64/include/asm/kexec.h
>> +++ b/arch/arm64/include/asm/kexec.h
>> @@ -96,6 +96,10 @@ static inline void crash_prepare_suspend(void) {}
>>  static inline void crash_post_resume(void) {}
>>  #endif
>>  
>> +#ifdef CONFIG_KEXEC_CORE
>> +extern void __init reserve_crashkernel(void);
>> +#endif
> Why not have this in some generic header?
>
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index c18aacde8bb0..69c592c546de 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -238,7 +238,18 @@ static void __init request_standard_resources(void)
>>  		    kernel_data.end <= res->end)
>>  			request_resource(res, &kernel_data);
>>  #ifdef CONFIG_KEXEC_CORE
>> -		/* Userspace will find "Crash kernel" region in /proc/iomem. */
>> +		/*
>> +		 * Userspace will find "Crash kernel" or "Crash kernel (low)"
>> +		 * region in /proc/iomem.
>> +		 * In order to distinct from the high region and make no effect
>> +		 * to the use of existing kexec-tools, rename the low region as
>> +		 * "Crash kernel (low)".
>> +		 */
>> +		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
>> +				crashk_low_res.end <= res->end) {
>> +			crashk_low_res.name = "Crash kernel (low)";
>> +			request_resource(res, &crashk_low_res);
>> +		}
>>  		if (crashk_res.end && crashk_res.start >= res->start &&
>>  		    crashk_res.end <= res->end)
>>  			request_resource(res, &crashk_res);
> My reading of the new generic reserve_crashkernel() is that
> crashk_low_res will only be populated if crask_res is above 4GB. If
> that's correct, I'm fine with the renaming here since current systems
> would not get a renamed low reservation (as long as they don't change
> the kernel cmdline).
>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 912f64f505f7..d20f5c444ebf 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -35,6 +35,7 @@
>>  #include <asm/fixmap.h>
>>  #include <asm/kasan.h>
>>  #include <asm/kernel-pgtable.h>
>> +#include <asm/kexec.h>
>>  #include <asm/memory.h>
>>  #include <asm/numa.h>
>>  #include <asm/sections.h>
>> @@ -61,66 +62,11 @@ EXPORT_SYMBOL(memstart_addr);
>>   */
>>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>  
>> -#ifdef CONFIG_KEXEC_CORE
>> -/*
>> - * reserve_crashkernel() - reserves memory for crash kernel
>> - *
>> - * This function reserves memory area given in "crashkernel=" kernel command
>> - * line parameter. The memory reserved is used by dump capture kernel when
>> - * primary kernel is crashing.
>> - */
>> +#ifndef CONFIG_KEXEC_CORE
>>  static void __init reserve_crashkernel(void)
>>  {
> [...]
>>  }
>> +#endif
> Can we not have the dummy reserve_crashkernel() in the generic code as
> well and avoid the #ifndef here?
You mean put the dummy reserve_crashkernel() and the relate function declaration in some generic header?
 
Baoquan also mentioned about this.
Now all the arch that support kdump have the dummy reserve_crashkernel() and
function declaration, such as arm/arm64/ppc/s390..

But currently different arch may have different CONFIG and different function declaration about this,
for example,

for s390,
static void __init reserve_crashkernel(void)
{                  
#ifdef CONFIG_CRASH_DUMP
...
#endif        
}

for ppc,
#ifdef CONFIG_KEXEC_CORE
extern void reserve_crashkernel(void);
#else
static inline void reserve_crashkernel(void) { ; }
#endif

If we move these to generic header we need think about:
1. the related config in different arch
2. function declaration(static/non static)

As Baoquan said in patch 9, how about leave with it for now and i try to solve this later?

>
>>  #ifdef CONFIG_CRASH_DUMP
>>  static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
>> @@ -446,6 +392,14 @@ void __init bootmem_init(void)
>>  	 * reserved, so do it here.
>>  	 */
>>  	reserve_crashkernel();
>> +#ifdef CONFIG_KEXEC_CORE
>> +	/*
>> +	 * The low region is intended to be used for crash dump kernel devices,
>> +	 * just mark the low region as "nomap" simply.
>> +	 */
>> +	if (crashk_low_res.end)
>> +		memblock_mark_nomap(crashk_low_res.start, resource_size(&crashk_low_res));
>> +#endif
> Do we do something similar for crashk_res?
Not. In the primary kernel(production kernel), we need to use crashk_res memory for crash kernel
elf core header, initrd...

Different with this, the crashk_low_res is only for crash dump kernel devices.
>
> Also, I can see we call crash_exclude_mem_range() only for crashk_res.
> Do we need to do this for crashk_low_res as well?
You are right, i missed about this. Will do in next version.

Thanks,
Chen Zhou
>

