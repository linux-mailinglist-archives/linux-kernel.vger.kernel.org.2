Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852E4320380
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 04:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBTDXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 22:23:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12626 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhBTDXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 22:23:43 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DjDHp62tKz1695N;
        Sat, 20 Feb 2021 11:21:26 +0800 (CST)
Received: from [10.174.176.191] (10.174.176.191) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Sat, 20 Feb 2021 11:22:48 +0800
Subject: Re: [PATCH v14 09/11] x86, arm64: Add ARCH_WANT_RESERVE_CRASH_KERNEL
 config
To:     Baoquan He <bhe@redhat.com>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-10-chenzhou10@huawei.com>
 <20210218083428.GK2871@MiWiFi-R3L-srv>
CC:     <mingo@redhat.com>, <tglx@linutronix.de>, <rppt@kernel.org>,
        <dyoung@redhat.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <nsaenzjulienne@suse.de>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <prabhakar.pkin@gmail.com>,
        <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <james.morse@arm.com>, <xiexiuqi@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <785d0e3c-9540-44b3-0682-877510007977@huawei.com>
Date:   Sat, 20 Feb 2021 11:22:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210218083428.GK2871@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.191]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/2/18 16:35, Baoquan He wrote:
> On 01/30/21 at 03:10pm, Chen Zhou wrote:
>> We make the functions reserve_crashkernel[_low]() as generic for
>> x86 and arm64. Since reserve_crashkernel[_low]() implementations
>> are quite similar on other architectures as well, we can have more
>> users of this later.
>>
>> So have CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL in arch/Kconfig and
>> select this by X86 and ARM64.
> This looks much better with the help of
> CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL. And please take off the
> 'Suggested-by' tag from me, I just don't like the old CONFIG_X86 and
> CONFIG_ARM64 ifdeffery way in v13, Mike suggested this ARCH_WANT_
> option.
OK, i will delete this.
>
> And the two dummy function reserve_crashkernel() in x86 and arm64 looks
> not so good, but I don't have better idea. Maybe add
> CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL iddeffery in the call site of
> reserve_crashkernel() in each ARCH? Or just leave with it for now if no
> other people has concern or suggestion about it.
>
> Anyway, ack this one.
>
> Acked-by: Baoquan He <bhe@redhat.com>
>
> Thanks
> Baoquan
>
>
>> Suggested-by: Mike Rapoport <rppt@kernel.org>
>> Suggested-by: Baoquan He <bhe@redhat.com>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>  arch/Kconfig        | 3 +++
>>  arch/arm64/Kconfig  | 1 +
>>  arch/x86/Kconfig    | 2 ++
>>  kernel/crash_core.c | 7 ++-----
>>  4 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 24862d15f3a3..0ca1ff5bb157 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -24,6 +24,9 @@ config KEXEC_ELF
>>  config HAVE_IMA_KEXEC
>>  	bool
>>  
>> +config ARCH_WANT_RESERVE_CRASH_KERNEL
>> +	bool
>> +
>>  config SET_FS
>>  	bool
>>  
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index f39568b28ec1..09365c7ff469 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -82,6 +82,7 @@ config ARM64
>>  	select ARCH_WANT_FRAME_POINTERS
>>  	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>>  	select ARCH_WANT_LD_ORPHAN_WARN
>> +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
>>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>>  	select ARM_AMBA
>>  	select ARM_ARCH_TIMER
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 21f851179ff0..e6926fcb4a40 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -12,6 +12,7 @@ config X86_32
>>  	depends on !64BIT
>>  	# Options that are inherently 32-bit kernel only:
>>  	select ARCH_WANT_IPC_PARSE_VERSION
>> +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
>>  	select CLKSRC_I8253
>>  	select CLONE_BACKWARDS
>>  	select GENERIC_VDSO_32
>> @@ -28,6 +29,7 @@ config X86_64
>>  	select ARCH_HAS_GIGANTIC_PAGE
>>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>>  	select ARCH_USE_CMPXCHG_LOCKREF
>> +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
>>  	select HAVE_ARCH_SOFT_DIRTY
>>  	select MODULES_USE_ELF_RELA
>>  	select NEED_DMA_MAP_STATE
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 8479be270c0b..2c5783985db5 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -320,9 +320,7 @@ int __init parse_crashkernel_low(char *cmdline,
>>   * --------- Crashkernel reservation ------------------------------
>>   */
>>  
>> -#ifdef CONFIG_KEXEC_CORE
>> -
>> -#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
>> +#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
>>  static int __init reserve_crashkernel_low(void)
>>  {
>>  #ifdef CONFIG_64BIT
>> @@ -450,8 +448,7 @@ void __init reserve_crashkernel(void)
>>  	crashk_res.start = crash_base;
>>  	crashk_res.end   = crash_base + crash_size - 1;
>>  }
>> -#endif
>> -#endif /* CONFIG_KEXEC_CORE */
>> +#endif /* CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL */
>>  
>>  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>>  			  void *data, size_t data_len)
>> -- 
>> 2.20.1
>>
> .
>

