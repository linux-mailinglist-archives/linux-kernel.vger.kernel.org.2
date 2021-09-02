Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D2B3FED81
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbhIBMJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:09:51 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:45283 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233831AbhIBMJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:09:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Un0Ri4b_1630584526;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Un0Ri4b_1630584526)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Sep 2021 20:08:46 +0800
Subject: Re: [PATCH 11/24] x86/entry: Replace the most of asm code of
 error_entry to C code
To:     Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-12-jiangshanlai@gmail.com>
 <YTCkgw/4v+mBBUIN@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <44ff16e6-21c8-dbd5-4393-0909162bd241@linux.alibaba.com>
Date:   Thu, 2 Sep 2021 20:08:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTCkgw/4v+mBBUIN@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/2 18:16, Peter Zijlstra wrote:
> On Wed, Sep 01, 2021 at 01:50:12AM +0800, Lai Jiangshan wrote:
>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> index 42d2918f5646..bc9e2f5ad370 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -972,83 +972,14 @@ SYM_CODE_START_LOCAL(error_entry)
>>   	cld
>>   	PUSH_AND_CLEAR_REGS save_ret=1
>>   	ENCODE_FRAME_POINTER 8
>>   
>>   	popq	%r12				/* save return addr in %12 */
>>   	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
>> +	call	do_error_entry
>>   	movq	%rax, %rsp			/* switch stack */
>>   	ENCODE_FRAME_POINTER
>>   	pushq	%r12
>>   	ret
> 
> There's only a single error_entry callsite, which is idtentry_body. One
> of the things I wanted to do is change this lot so we change to the
> task_stack in 'C', using an adaptation of call_on_irqstack() and
> basically don't return frrom C until we're done with \cfunc.
> 
> That is, once we call C, stay there, and don't do this back and forth
> between C and asm.

I haven't figured out how can an adaptation of call_on_irqstack() can do it.
The original stack need to be "free" for next task.  And we can't switch
the stack before error_entry() since the CR3 is not switched.

I believe the ASM code here can be simplified and clearer further. But I don't
think going back and forth between C and ASM is real issue if the ASM code is
short and simple enough.


> 
> As is, the resulting asm in error_entry is somewhat confusing given that
> we sometimes don't actually switch stacks.
> 
