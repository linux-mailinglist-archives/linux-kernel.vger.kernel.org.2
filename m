Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6663FEB1F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245339AbhIBJV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:21:29 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:60994 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245147AbhIBJV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:21:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Un-mOGW_1630574426;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Un-mOGW_1630574426)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Sep 2021 17:20:26 +0800
Subject: Re: [PATCH 04/24] x86/entry: Expose the address of .Lgs_change to
 traps.c
To:     Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-5-jiangshanlai@gmail.com>
 <YTCV7HbeoaD6rJP5@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <1a33582b-63ef-581e-07da-3e3b970df4ab@linux.alibaba.com>
Date:   Thu, 2 Sep 2021 17:20:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTCV7HbeoaD6rJP5@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/2 17:14, Peter Zijlstra wrote:
> On Wed, Sep 01, 2021 at 01:50:05AM +0800, Lai Jiangshan wrote:
> 
>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> index e38a4cf795d9..9164e85b36b8 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -729,6 +729,7 @@ _ASM_NOKPROBE(common_interrupt_return)
>>   SYM_FUNC_START(asm_load_gs_index)
>>   	FRAME_BEGIN
>>   	swapgs
>> +SYM_INNER_LABEL(asm_load_gs_index_gs_change, SYM_L_GLOBAL)
>>   .Lgs_change:
> 
> After all the patches, there's only a single .Lgs_change reference left.
> Can't we convert the _ASM_EXTABLE() entry to use the new label and
> totally remove it?

The label .Lgs_change is still needed in ASM code for extable.

I tried the way as you suggested, and the result is:

warning: objtool: __ex_table+0x0: don't know how to handle non-section reloc symbol asm_load_gs_index_gs_change

But never mind, I have already converted load_gs_index into C code.
I will send it later.

> 
>>   	movl	%edi, %gs
>>   2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
>> @@ -1011,7 +1012,7 @@ SYM_CODE_START_LOCAL(error_entry)
>>   	movl	%ecx, %eax			/* zero extend */
>>   	cmpq	%rax, RIP+8(%rsp)
>>   	je	.Lbstep_iret
>> -	cmpq	$.Lgs_change, RIP+8(%rsp)
>> +	cmpq	$asm_load_gs_index_gs_change, RIP+8(%rsp)
>>   	jne	.Lerror_entry_done_lfence
