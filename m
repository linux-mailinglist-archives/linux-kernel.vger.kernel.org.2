Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194474067AF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhIJHbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:31:35 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:38408 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231364AbhIJHbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:31:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UnshV9X_1631259019;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UnshV9X_1631259019)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Sep 2021 15:30:20 +0800
Subject: Re: [PATCH 24/24] x86/syscall/64: Move the checking for sysret to C
 code
To:     Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-25-jiangshanlai@gmail.com>
 <0801d530-9a86-fbc8-9c27-6beae1f114f3@gmail.com>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <74bde1d9-8e77-5e26-9c8c-0c527b5ccc6d@linux.alibaba.com>
Date:   Fri, 10 Sep 2021 15:30:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0801d530-9a86-fbc8-9c27-6beae1f114f3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/10 15:20, Nikolay Borisov wrote:
> 
> 
> On 31.08.21 г. 20:50, Lai Jiangshan wrote:
>> From: Lai Jiangshan <laijs@linux.alibaba.com>
>>
>> Like do_fast_syscall_32() which checks whether it can return to userspace
>> via fast instructions before the function returns, do_syscall_64()
>> also checks whether it can use sysret to return to userspace before
>> do_syscall_64() returns via C code.  And a bunch of ASM code can be removed.
>>
>> No functional change intended.
>>
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> <snip>
> 
>> +/*
>> + * Check if it can use SYSRET.
>> + *
>> + * Try to use SYSRET instead of IRET if we're returning to
>> + * a completely clean 64-bit userspace context.
>> + *
>> + * Returns 0 to return using IRET or 1 to return using SYSRET.
>> + */
>> +static __always_inline int can_sysret(struct pt_regs *regs)
> 
> nit: Since this is a predicate function why not simply return bool ?

I don't have any preference.

The choice came from my limitation of the needed knowledge.

I followed the design of do_fast_syscall_32() which returns a 4-byte word
to indicate if it can fast return to userspace,  and I know how to test the
result in ASM for a 4-byte word.  If it was a bool, I don't know how to
test the result in ASM.

> 
>> +{
>> +	/* In the Xen PV case we must use iret anyway. */
>> +	if (static_cpu_has(X86_FEATURE_XENPV))
>> +		return 0;
>> +
>> +	/* SYSRET requires RCX == RIP && R11 == RFLAGS */
>> +	if (regs->ip != regs->cx || regs->flags != regs->r11)
>> +		return 0;
>> +
>> +	/* CS and SS must match SYSRET */
>> +	if (regs->cs != __USER_CS || regs->ss != __USER_DS)
>> +		return 0;
>> +
>> +	/*
>> +	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
>> +	 * in kernel space.  This essentially lets the user take over
>> +	 * the kernel, since userspace controls RSP.
>> +	 */
>> +	if (regs->cx != canonical_address(regs->cx))
>> +		return 0;
>> +
>> +	/*
>> +	 * SYSCALL clears RF when it saves RFLAGS in R11 and SYSRET cannot
>> +	 * restore RF properly. If the slowpath sets it for whatever reason, we
>> +	 * need to restore it correctly.
>> +	 *
>> +	 * SYSRET can restore TF, but unlike IRET, restoring TF results in a
>> +	 * trap from userspace immediately after SYSRET.  This would cause an
>> +	 * infinite loop whenever #DB happens with register state that satisfies
>> +	 * the opportunistic SYSRET conditions.  For example, single-stepping
>> +	 * this user code:
>> +	 *
>> +	 *           movq	$stuck_here, %rcx
>> +	 *           pushfq
>> +	 *           popq %r11
>> +	 *   stuck_here:
>> +	 *
>> +	 * would never get past 'stuck_here'.
>> +	 */
>> +	if (regs->r11 & (X86_EFLAGS_RF | X86_EFLAGS_TF))
>> +		return 0;
>> +
>> +	return 1;
>> +}
>> +
>> +/* Returns 0 to return using IRET or 1 to return using SYSRET. */
>> +__visible noinstr int do_syscall_64(struct pt_regs *regs, int nr)
> 
> nit: Ditto about bool
> 
>>   {
>>   	add_random_kstack_offset();
>>   	nr = syscall_enter_from_user_mode(regs, nr);
>> @@ -84,6 +154,7 @@ __visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
>>   
>>   	instrumentation_end();
>>   	syscall_exit_to_user_mode(regs);
>> +	return can_sysret(regs);
>>   }
>>   #endif
>>   
> 
> <snip>
> 
