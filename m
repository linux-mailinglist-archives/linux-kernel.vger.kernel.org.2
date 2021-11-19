Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3375B456781
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 02:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhKSBlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 20:41:24 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:52251 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229754AbhKSBlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 20:41:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UxFU.g4_1637285897;
Received: from 30.47.195.12(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UxFU.g4_1637285897)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Nov 2021 09:38:19 +0800
Message-ID: <d74f249a-5dba-e45b-0779-65fad1b63ba6@linux.alibaba.com>
Date:   Fri, 19 Nov 2021 09:38:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH V5 03/50] x86/traps: Remove stack-protector from traps.c
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
 <20211110115736.3776-4-jiangshanlai@gmail.com>
 <20211118195504.GM174703@worktop.programming.kicks-ass.net>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
In-Reply-To: <20211118195504.GM174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/19 03:55, Peter Zijlstra wrote:
> On Wed, Nov 10, 2021 at 07:56:49PM +0800, Lai Jiangshan wrote:
>> From: Lai Jiangshan <laijs@linux.alibaba.com>
>>
>> When stack-protector is enabled, the compiler adds some instrument code
>> at the beginning and the end of some functions. Many functions in traps.c
>> are non-instrumentable.  Moreover, stack-protector code in the beginning
>> of the affected function accesses the canary that might be watched by
>> hardware breakpoints which also violate the non-instrumentable
>> nature of some functions and might cause infinite recursive #DB because
>> the canary is accessed before resetting the dr7.
>>
>> So it is better to remove stack-protector from traps.c.
>>
>> It is also prepared for later patches that move some entry code into
>> traps.c, some of which can NOT use percpu register until gsbase is
>> properly switched.  And stack-protector depends on the percpu register
>> to work.
>>
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>> ---
>>   arch/x86/kernel/Makefile | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
>> index 2ff3e600f426..8ac45801ba8b 100644
>> --- a/arch/x86/kernel/Makefile
>> +++ b/arch/x86/kernel/Makefile
>> @@ -50,6 +50,7 @@ KCOV_INSTRUMENT		:= n
>>   
>>   CFLAGS_head$(BITS).o	+= -fno-stack-protector
>>   CFLAGS_cc_platform.o	+= -fno-stack-protector
>> +CFLAGS_traps.o		+= -fno-stack-protector
> 
> Well, there's a lot more noinstr than just in traps. 

Although it is stupid to put hardware break point on the stack canary,
it is fatal only in traps.c when the canary is accessed before
resetting the dr7 in #DB handler.

And this only happens when the administer of the system is deliberately
hurting the system, so the fix is not strongly required in this problem.

The best way is to disallow hw_breakpoint to watch the stack canary.

The later patch (patch39) puts __entry_code into traps.c which makes
no_stack_protector is strongly required, so this patch just simply puts
the -fno-stack-protector on traps.c.

> There's also real C
> code in traps. This isn't really a solution.

This patch focuses "hardware break point on the stack canary" only.

It is not a full solution [for other unhappiness when noistr is watching
by stack protector].

I will switch to disallow hw_breakpoint to watch the stack canary.

> 
> I think GCC has recently grown __attribute__((no_stack_protector)),
> which should be added to noinstr (GCC-11 and above).
> 
> Additionally we could add code to objtool to detect this problem.
> 
