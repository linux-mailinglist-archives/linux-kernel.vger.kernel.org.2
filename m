Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31624358856
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhDHP0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:26:45 -0400
Received: from foss.arm.com ([217.140.110.172]:51488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhDHP0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:26:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1A68D6E;
        Thu,  8 Apr 2021 08:26:27 -0700 (PDT)
Received: from [10.37.8.4] (unknown [10.37.8.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE7E93F694;
        Thu,  8 Apr 2021 08:26:26 -0700 (PDT)
Subject: Re: [PATCH] arm64: mte: Move MTE TCF0 check in entry-common
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20210408143723.13024-1-vincenzo.frascino@arm.com>
 <20210408151837.GB37165@C02TD0UTHF1T.local>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <cff8d16e-c1a9-3f10-7c7f-06fb569741ce@arm.com>
Date:   Thu, 8 Apr 2021 16:26:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210408151837.GB37165@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/21 4:18 PM, Mark Rutland wrote:
> Hi Vincenzo,
> 
> On Thu, Apr 08, 2021 at 03:37:23PM +0100, Vincenzo Frascino wrote:
>> The check_mte_async_tcf macro sets the TIF flag non-atomically. This can
>> race with another CPU doing a set_tsk_thread_flag() and the flag can be
>> lost in the process.
>>
>> Move the tcf0 check to enter_from_user_mode() and clear tcf0 in
>> exit_to_user_mode() to address the problem.
> 
> Beware that these are called at critical points of the entry sequence,
> so we need to take care that nothing is instrumented (e.g. we can only
> safely use noinstr functions here).
> 

Sure, I will add noinstr in the next version of the patch.

>> Note: Moving the check in entry-common allows to use set_thread_flag()
>> which is safe.
>>
>> Fixes: 637ec831ea4f ("arm64: mte: Handle synchronous and asynchronous
>> tag check faults")
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Reported-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  arch/arm64/include/asm/mte.h     |  8 ++++++++
>>  arch/arm64/kernel/entry-common.c |  6 ++++++
>>  arch/arm64/kernel/entry.S        | 30 ------------------------------
>>  arch/arm64/kernel/mte.c          | 25 +++++++++++++++++++++++--
>>  4 files changed, 37 insertions(+), 32 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
>> index 9b557a457f24..188f778c6f7b 100644
>> --- a/arch/arm64/include/asm/mte.h
>> +++ b/arch/arm64/include/asm/mte.h
>> @@ -31,6 +31,8 @@ void mte_invalidate_tags(int type, pgoff_t offset);
>>  void mte_invalidate_tags_area(int type);
>>  void *mte_allocate_tag_storage(void);
>>  void mte_free_tag_storage(char *storage);
>> +void check_mte_async_tcf0(void);
>> +void clear_mte_async_tcf0(void);
>>  
>>  #ifdef CONFIG_ARM64_MTE
>>  
>> @@ -83,6 +85,12 @@ static inline int mte_ptrace_copy_tags(struct task_struct *child,
>>  {
>>  	return -EIO;
>>  }
>> +void check_mte_async_tcf0(void)
>> +{
>> +}
>> +void clear_mte_async_tcf0(void)
>> +{
>> +}
> 
> Were these meant to be static inline?
> 

Agree, it definitely needs static inline here.

>>  static inline void mte_assign_mem_tag_range(void *addr, size_t size)
>>  {
>> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
>> index 9d3588450473..837d3624a1d5 100644
>> --- a/arch/arm64/kernel/entry-common.c
>> +++ b/arch/arm64/kernel/entry-common.c
>> @@ -289,10 +289,16 @@ asmlinkage void noinstr enter_from_user_mode(void)
>>  	CT_WARN_ON(ct_state() != CONTEXT_USER);
>>  	user_exit_irqoff();
>>  	trace_hardirqs_off_finish();
>> +
>> +	/* Check for asynchronous tag check faults in user space */
>> +	check_mte_async_tcf0();
>>  }
>>  
>>  asmlinkage void noinstr exit_to_user_mode(void)
>>  {
>> +	/* Ignore asynchronous tag check faults in the uaccess routines */
>> +	clear_mte_async_tcf0();
>> +
>>  	trace_hardirqs_on_prepare();
>>  	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
>>  	user_enter_irqoff();
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index a31a0a713c85..fafd74ae5021 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -147,32 +147,6 @@ alternative_cb_end
>>  .L__asm_ssbd_skip\@:
>>  	.endm
>>  
>> -	/* Check for MTE asynchronous tag check faults */
>> -	.macro check_mte_async_tcf, flgs, tmp
>> -#ifdef CONFIG_ARM64_MTE
>> -alternative_if_not ARM64_MTE
>> -	b	1f
>> -alternative_else_nop_endif
>> -	mrs_s	\tmp, SYS_TFSRE0_EL1
>> -	tbz	\tmp, #SYS_TFSR_EL1_TF0_SHIFT, 1f
>> -	/* Asynchronous TCF occurred for TTBR0 access, set the TI flag */
>> -	orr	\flgs, \flgs, #_TIF_MTE_ASYNC_FAULT
>> -	str	\flgs, [tsk, #TSK_TI_FLAGS]
>> -	msr_s	SYS_TFSRE0_EL1, xzr
>> -1:
>> -#endif
>> -	.endm
>> -
>> -	/* Clear the MTE asynchronous tag check faults */
>> -	.macro clear_mte_async_tcf
>> -#ifdef CONFIG_ARM64_MTE
>> -alternative_if ARM64_MTE
>> -	dsb	ish
>> -	msr_s	SYS_TFSRE0_EL1, xzr
>> -alternative_else_nop_endif
>> -#endif
>> -	.endm
>> -
>>  	.macro mte_set_gcr, tmp, tmp2
>>  #ifdef CONFIG_ARM64_MTE
>>  	/*
>> @@ -243,8 +217,6 @@ alternative_else_nop_endif
>>  	ldr	x19, [tsk, #TSK_TI_FLAGS]
>>  	disable_step_tsk x19, x20
>>  
>> -	/* Check for asynchronous tag check faults in user space */
>> -	check_mte_async_tcf x19, x22
>>  	apply_ssbd 1, x22, x23
>>  
>>  	ptrauth_keys_install_kernel tsk, x20, x22, x23
>> @@ -775,8 +747,6 @@ SYM_CODE_START_LOCAL(ret_to_user)
>>  	cbnz	x2, work_pending
>>  finish_ret_to_user:
>>  	user_enter_irqoff
>> -	/* Ignore asynchronous tag check faults in the uaccess routines */
>> -	clear_mte_async_tcf
>>  	enable_step_tsk x19, x2
>>  #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>>  	bl	stackleak_erase
>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index b3c70a612c7a..e759b0eca47e 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -166,14 +166,35 @@ static void set_gcr_el1_excl(u64 excl)
>>  	 */
>>  }
>>  
>> +void check_mte_async_tcf0(void)
> 
> As above, this'll need to be noinstr. I also reckon we should put this
> in the header so that it can be inlined.
> 

Yes, I agree.

>> +{
>> +	/*
>> +	 * dsb(ish) is not required before the register read
>> +	 * because the TFSRE0_EL1 is automatically synchronized
>> +	 * by the hardware on exception entry as SCTLR_EL1.ITFSB
>> +	 * is set.
>> +	 */
>> +	u64 tcf0 = read_sysreg_s(SYS_TFSRE0_EL1);
> 
> Shouldn't we have an MTE feature check first?
> 

Indeed, I will add it in the next version.

>> +
>> +	if (tcf0 & SYS_TFSR_EL1_TF0)
>> +		set_thread_flag(TIF_MTE_ASYNC_FAULT);
>> +
>> +	write_sysreg_s(0, SYS_TFSRE0_EL1);
>> +}
>> +
>> +void clear_mte_async_tcf0(void)
>> +{
>> +	dsb(ish);
>> +	write_sysreg_s(0, SYS_TFSRE0_EL1);
>> +}
> 
> Likewise here on all counts.
> 

I will add noinstr and the check in the next version.

> Thanks,
> Mark.
> 
>>  void flush_mte_state(void)
>>  {
>>  	if (!system_supports_mte())
>>  		return;
>>  
>>  	/* clear any pending asynchronous tag fault */
>> -	dsb(ish);
>> -	write_sysreg_s(0, SYS_TFSRE0_EL1);
>> +	clear_mte_async_tcf0();
>>  	clear_thread_flag(TIF_MTE_ASYNC_FAULT);
>>  	/* disable tag checking */
>>  	set_sctlr_el1_tcf0(SCTLR_EL1_TCF0_NONE);
>> -- 
>> 2.30.2
>>

-- 
Regards,
Vincenzo
