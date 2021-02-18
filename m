Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AEA31E720
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 08:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhBRHvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 02:51:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12552 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhBRHH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 02:07:29 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dh5LC29zhzMTBb;
        Thu, 18 Feb 2021 15:04:35 +0800 (CST)
Received: from [10.174.176.191] (10.174.176.191) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Thu, 18 Feb 2021 15:06:23 +0800
Subject: Re: [PATCH v14 06/11] x86/elf: Move vmcore_elf_check_arch_cross to
 arch/x86/include/asm/elf.h
To:     Baoquan He <bhe@redhat.com>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-7-chenzhou10@huawei.com>
 <20210218062508.GH2871@MiWiFi-R3L-srv>
CC:     <mingo@redhat.com>, <tglx@linutronix.de>, <rppt@kernel.org>,
        <dyoung@redhat.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <nsaenzjulienne@suse.de>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <prabhakar.pkin@gmail.com>,
        <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <james.morse@arm.com>, <xiexiuqi@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        kernel test robot <lkp@intel.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <e59d88ad-7523-01aa-e1c3-f2fe6a695f0b@huawei.com>
Date:   Thu, 18 Feb 2021 15:05:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210218062508.GH2871@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.191]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/2/18 14:31, Baoquan He wrote:
> On 01/30/21 at 03:10pm, Chen Zhou wrote:
>> Move macro vmcore_elf_check_arch_cross from arch/x86/include/asm/kexec.h
>> to arch/x86/include/asm/elf.h to fix the following compiling warning:
>>
>> make ARCH=i386
>> In file included from arch/x86/kernel/setup.c:39:0:
>> ./arch/x86/include/asm/kexec.h:77:0: warning: "vmcore_elf_check_arch_cross" redefined
>>  # define vmcore_elf_check_arch_cross(x) ((x)->e_machine == EM_X86_64)
>>
>> In file included from arch/x86/kernel/setup.c:9:0:
>> ./include/linux/crash_dump.h:39:0: note: this is the location of the previous definition
>>  #define vmcore_elf_check_arch_cross(x) 0
>>
>> The root cause is that vmcore_elf_check_arch_cross under CONFIG_CRASH_CORE
>> depend on CONFIG_KEXEC_CORE. Commit 2db65f1db17d ("x86: kdump: move
>> reserve_crashkernel[_low]() into crash_core.c") triggered the issue.
>>
>> Suggested by Mike, simply move vmcore_elf_check_arch_cross from
>> arch/x86/include/asm/kexec.h to arch/x86/include/asm/elf.h to fix
>> the warning.
>>
>> Fixes: 2db65f1db17d ("x86: kdump: move reserve_crashkernel[_low]() into crash_core.c")
> Where does this commit id '2db65f1db17d' come from? Here you are fixing
> another pathc in the same patchset. Please merge this with patch 05/11.
Yeah, the commit id is invalid, i will merge this patch with patch 05/11.

Thanks,
Chen Zhou
>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Suggested-by: Mike Rapoport <rppt@kernel.org>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>  arch/x86/include/asm/elf.h   | 3 +++
>>  arch/x86/include/asm/kexec.h | 3 ---
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
>> index 66bdfe838d61..5333777cc758 100644
>> --- a/arch/x86/include/asm/elf.h
>> +++ b/arch/x86/include/asm/elf.h
>> @@ -94,6 +94,9 @@ extern unsigned int vdso32_enabled;
>>  
>>  #define elf_check_arch(x)	elf_check_arch_ia32(x)
>>  
>> +/* We can also handle crash dumps from 64 bit kernel. */
>> +# define vmcore_elf_check_arch_cross(x) ((x)->e_machine == EM_X86_64)
>> +
>>  /* SVR4/i386 ABI (pages 3-31, 3-32) says that when the program starts %edx
>>     contains a pointer to a function which might be registered using `atexit'.
>>     This provides a mean for the dynamic linker to call DT_FINI functions for
>> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
>> index 2b18f918203e..6fcae01a9cca 100644
>> --- a/arch/x86/include/asm/kexec.h
>> +++ b/arch/x86/include/asm/kexec.h
>> @@ -72,9 +72,6 @@ struct kimage;
>>  
>>  /* The native architecture */
>>  # define KEXEC_ARCH KEXEC_ARCH_386
>> -
>> -/* We can also handle crash dumps from 64 bit kernel. */
>> -# define vmcore_elf_check_arch_cross(x) ((x)->e_machine == EM_X86_64)
>>  #else
>>  /* Maximum physical address we can use pages from */
>>  # define KEXEC_SOURCE_MEMORY_LIMIT      (MAXMEM-1)
>> -- 
>> 2.20.1
>>
> .
>

