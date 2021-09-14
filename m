Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CBF40A307
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbhINCGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:06:08 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:57455 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229729AbhINCGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:06:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0UoJi.gK_1631585087;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UoJi.gK_1631585087)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Sep 2021 10:04:48 +0800
Subject: Re: [PATCH 25/24] x86/traps: Rewrite native_load_gs_index in C code
To:     Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210902105052.2842-1-jiangshanlai@gmail.com>
 <bfeb0b12-5b95-46c9-8ea3-6a4a5bf59076@www.fastmail.com>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <4ecf191a-6642-6d59-cf10-6fe51e261b28@linux.alibaba.com>
Date:   Tue, 14 Sep 2021 10:04:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <bfeb0b12-5b95-46c9-8ea3-6a4a5bf59076@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/14 04:01, Andy Lutomirski wrote:
> 
> 
> On Thu, Sep 2, 2021, at 3:50 AM, Lai Jiangshan wrote:
>> From: Lai Jiangshan <laijs@linux.alibaba.com>
>>
>> There is no constrain/limition to force native_load_gs_index() to be in
>> ASM code.
>>
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> 
>>   
>>   #ifdef CONFIG_X86_64
>> +
>> +/*
>> + * Reload gs selector with exception handling
>> + * selector:  new selector
>> + *
>> + * Is noinstr as it shouldn't be instrumented.
>> + */
>> +noinstr void native_load_gs_index(unsigned int selector)
>> +{
>> +	unsigned long flags;
>> +
>> +	local_irq_save(flags);
> 
> This patch would be a bit less alarming if you moved the swapgs into asm.  

Emmm, this patch is not so clean and persuadable in C.

I think Peter is still working on reworking the patchset and may be
including improving this patch.  I'm Okay if this patch is dropped.

> Also, this needs a comment explaining why skipping the swapgs back to kernel gs in the exception path is correct.
> 

I think it is all known that the exception handler in ASM_EXTABLE is running in kernel context where kernel gs is active.

It does need a comment explaining why the label asm_load_gs_index_gs_change is needed, how does it help the 
error_entry() restores back to the kernel gs.

Since the C-version error_entry() has to check asm_load_gs_index_gs_change, I think other way to handle the fault of 
"mov %gs" is just doing the %gs fixup in the C-version error_entry(). (see patch 11).  it would be more directly, 
simple, and self-documented.

Thank you for reviewing.

>> +	native_swapgs();
>> +	asm volatile(
>> +		".global asm_load_gs_index_gs_change \n"
>> +		"asm_load_gs_index_gs_change: \n"
>> +		"1: movl %0, %%gs \n"
>> +		"   swapgs \n"
>> +		"2: \n"
>> +		_ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_clear_gs)
>> +		:: "r" (selector) : "memory");
>> +	alternative("", "mfence", X86_BUG_SWAPGS_FENCE);
>> +	local_irq_restore(flags);
>> +}
>> +
