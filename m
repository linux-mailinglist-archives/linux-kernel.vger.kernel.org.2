Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E548D42E71D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 05:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhJODOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 23:14:15 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:40478 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhJODOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 23:14:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Us2T59N_1634267522;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Us2T59N_1634267522)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Oct 2021 11:12:03 +0800
Subject: Re: [RFC] crypto/sm4: Fix objtool/libelf warning
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
References: <20211007202204.GT174703@worktop.programming.kicks-ass.net>
 <8e35ba6d-f876-4726-a8e7-a0d80b0186f2@linux.alibaba.com>
 <YWhFC6AMutE+a1oK@hirez.programming.kicks-ass.net>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <6759f51a-4f35-5a68-4934-24947f07e85b@linux.alibaba.com>
Date:   Fri, 15 Oct 2021 11:12:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YWhFC6AMutE+a1oK@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 10/14/21 10:56 PM, Peter Zijlstra wrote:
> On Thu, Oct 14, 2021 at 06:29:55PM +0800, Tianjia Zhang wrote:
>> Hi Peter,
>>
>> On 10/8/21 4:22 AM, Peter Zijlstra wrote:
>>> Hi,
>>>
>>> objtool is yielding the obscure libelf warning:
>>>
>>>     vmlinux.o: warning: objtool: elf_update: invalid section entry size
>>>
>>> Which I tracked down to section:
>>>
>>>     [3023] .rodata.cst164    PROGBITS        0000000000000000 1ab501e0 000154 a4  AM  0   0 16
>>>
>>> Which has a section size of 0x154 (340) and an entry size of 0xa4 (164).
>>> An obvious mis-match.
>>>
>>>   From there, git-grep quickly yields:
>>>
>>>     arch/x86/crypto/sm4-aesni-avx-asm_64.S:.section .rodata.cst164, "aM", @progbits, 164
>>>     arch/x86/crypto/sm4-aesni-avx2-asm_64.S:.section        .rodata.cst164, "aM", @progbits, 164
>>>
>>> So those files create this .rodata section with an explicit entry size,
>>> but then don't respect it themselves. Removing the entry size makes the
>>> warning go away, but I can't tell if that's right or not, given there is
>>> zero clue as to why that entry size was specified to begin with.
>>>
>>> Please explain...
>>>
>>> ---
>>> diff --git a/arch/x86/crypto/sm4-aesni-avx-asm_64.S b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
>>> index 18d2f5199194..d089cccf4db7 100644
>>> --- a/arch/x86/crypto/sm4-aesni-avx-asm_64.S
>>> +++ b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
>>> @@ -78,7 +78,7 @@
>>>    	vpxor tmp0, x, x;
>>> -.section	.rodata.cst164, "aM", @progbits, 164
>>> +.section	.rodata.cst164, "aM", @progbits
>>>    .align 16
>>>    /*
>>> diff --git a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
>>> index d2ffd7f76ee2..a0f7541c2246 100644
>>> --- a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
>>> +++ b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
>>> @@ -93,7 +93,7 @@
>>>    	vpxor tmp0, x, x;
>>> -.section	.rodata.cst164, "aM", @progbits, 164
>>> +.section	.rodata.cst164, "aM", @progbits
>>>    .align 16
>>>    /*
>>>
>>
>> Thanks for pointing it out, We have also reproduced this error. If the M
>> flag is specified, the entry_size argument is required.
> 
> Correct.
> 
>> We also need to
>> consider the clang compiler. This requires a more thorough method to fix it.
>> I will post another patch later.
> 
> If the purpose is to share the whole section, such that there is only a
> single copy of those tables between the two sm4 implementations, then
> you need to set the entry size to the total size of the section.
> 
> Otoh, almost every entry (with exception of the very last one) seems to
> be 16 bytes, so you might just get away with setting the entry size to
> 16.
> 
> Given this is only a very small data table, why the need to share? Any
> one machine will only use a single one of these implementations at any
> one time.
> 

The main purpose is not to share the whole section, but to prevent clang 
from causing errors. It seems that the clang compiler has stricter 
restrictions on this entry_size.

Best regards,
Tianjia
