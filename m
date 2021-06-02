Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3682397D76
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 02:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhFBALM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 20:11:12 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:52033 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235034AbhFBALL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 20:11:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Ub-Yt2._1622592565;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Ub-Yt2._1622592565)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Jun 2021 08:09:26 +0800
Subject: Re: [RFC PATCH 1/4] x86/entry/nmi: Switch to the entry stack before
 switching to the thread stack
To:     Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>
References: <20210601065217.23540-1-jiangshanlai@gmail.com>
 <20210601065217.23540-2-jiangshanlai@gmail.com>
 <20210601130537.7b389804@oasis.local.home>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <6aa4a193-e596-9c01-6b36-0c25410ebb82@linux.alibaba.com>
Date:   Wed, 2 Jun 2021 08:09:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210601130537.7b389804@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/2 01:05, Steven Rostedt wrote:
> On Tue,  1 Jun 2021 14:52:14 +0800
> Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> 
>> From: Lai Jiangshan <laijs@linux.alibaba.com>
>>
>> Current kernel has no code to enforce data breakpoint not on the thread
>> stack.  If there is any data breakpoint on the top area of the thread
>> stack, there might be problem.
>>
>> For example, when NMI hits on userspace in this setting, the code copies
>> the exception frame from the NMI stack to the thread stack and it will
>> cause #DB and after #DB is handled, the not yet copied portion on the
>> NMI stack is in danger of corruption because the NMI is unmasked.
>>
>> Stashing the exception frame on the entry stack before touching the
>> entry stack can fix the problem.
>>
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>> ---
>>   arch/x86/entry/entry_64.S     | 22 ++++++++++++++++++++++
>>   arch/x86/kernel/asm-offsets.c |  1 +
>>   2 files changed, 23 insertions(+)
>>
>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> index a5f02d03c585..4190e668f346 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -1121,8 +1121,30 @@ SYM_CODE_START(asm_exc_nmi)
>>   	 *
>>   	 * We also must not push anything to the stack before switching
>>   	 * stacks lest we corrupt the "NMI executing" variable.
>> +	 *
>> +	 * Before switching to the thread stack, it switches to the entry
>> +	 * stack first lest there is any data breakpoint in the thread
>> +	 * stack and the iret of #DB will cause NMI unmasked before
>> +	 * finishing switching.
>>   	 */
>>   
>> +	/* Switch stack to entry stack */
>> +	movq	%rsp, %rdx
>> +	addq	$(+6*8			/* to NMI stack top */		\
>> +		  -EXCEPTION_STKSZ	/* to NMI stack bottom */	\
>> +		  -CPU_ENTRY_AREA_nmi_stack /* to entry area */		\
> 
> Just so that I understand this correctly. This "entry area" is not part
> of the NMI stack, but just at the bottom of it? That is, this part of
> the stack will never be touched by an NMI coming in from kernel space,
> correct?

This "entry area" is the pointer of current CPU's struct cpu_entry_area.

This instruction puts %rsp onto the top of the entry/trampoline stack
which is not touched by an NMI coming in from kernel space.

> 
> -- Steve
> 
> 
>> +		  +CPU_ENTRY_AREA_entry_stack /* to entry stack bottom */\
>> +		  +SIZEOF_entry_stack	/* to entry stack top */	\
>> +		), %rsp
>> +
>> +	/* Stash exception frame and %rdx to entry stack */
>> +	pushq	5*8(%rdx)	/* pt_regs->ss */
>> +	pushq	4*8(%rdx)	/* pt_regs->rsp */
>> +	pushq	3*8(%rdx)	/* pt_regs->flags */
>> +	pushq	2*8(%rdx)	/* pt_regs->cs */
>> +	pushq	1*8(%rdx)	/* pt_regs->rip */
>> +	pushq	0*8(%rdx)	/* %rdx */
>> +
>>   	swapgs
>>   	cld
>>   	FENCE_SWAPGS_USER_ENTRY
>> diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
>> index ecd3fd6993d1..dfafa0c7e887 100644
>> --- a/arch/x86/kernel/asm-offsets.c
>> +++ b/arch/x86/kernel/asm-offsets.c
>> @@ -88,6 +88,7 @@ static void __used common(void)
>>   	OFFSET(CPU_ENTRY_AREA_entry_stack, cpu_entry_area, entry_stack_page);
>>   	DEFINE(SIZEOF_entry_stack, sizeof(struct entry_stack));
>>   	DEFINE(MASK_entry_stack, (~(sizeof(struct entry_stack) - 1)));
>> +	OFFSET(CPU_ENTRY_AREA_nmi_stack, cpu_entry_area, estacks.NMI_stack);
>>   
>>   	/* Offset for fields in tss_struct */
>>   	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
