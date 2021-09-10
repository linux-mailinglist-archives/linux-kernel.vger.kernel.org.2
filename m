Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1B9406789
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhIJHOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:14:22 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:57933 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231350AbhIJHOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:14:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UnsXbpu_1631257985;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UnsXbpu_1631257985)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Sep 2021 15:13:06 +0800
Subject: Re: [PATCH 17/24] x86/entry: Introduce struct ist_regs
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-18-jiangshanlai@gmail.com>
 <eb294b5d-82f2-be80-b3e3-db556c155d95@linux.alibaba.com>
 <9fe0e26b-5fb7-4521-a01e-8edd8d5cb74c@zytor.com>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <3729bc02-1e4b-d2db-aabb-cb3610d8fd7d@linux.alibaba.com>
Date:   Fri, 10 Sep 2021 15:13:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9fe0e26b-5fb7-4521-a01e-8edd8d5cb74c@zytor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/10 12:31, H. Peter Anvin wrote:
> Note: the examples in this email all compiled with:
> 
> gcc -O2 -mpreferred-stack-boundary=3 -mcmodel=kernel
> 
> The disassembly has been slightly simplified.

Saving results in registers is non-flexible no matter in ASM or hack in C like this.

Saving CR3 in ist_regs is not different than saving rax in pt_regs, and both of
ist_regs and embedded pt_regs can be moved when stack is required to switch.

I prefer to my original design.

> 
> 
> On 9/9/21 5:18 PM, Lai Jiangshan wrote:
>>
>> This patch was over designed.
>>
>> In ASM code, we can easily save results in the callee-saved registers.
>> For example, rc3 is saved in %r14, gsbase info is saved in %rbx.
>>
>> And in C code, we can't save results in registers.  And I thought there was
>> no place to save the results because the CR3 and gsbase are not kernel's.
>> So I extended the pt_regs to ist_regs to save the results.
>>
>> But it was incorrect.  The results can be saved in percpu data at the end of
>> paranoid_entry() after the CR3/gsbase are settled down.  And the results
>> can be read at the beginning of paranoid_exit() before the CR3/gsbase are
>> switched to the interrupted context's.
>>
> 
> OK, count me confused. Of course you can save results in caller-saved registers in C; it is kind of what they do:
> 
> 
> extern void bar(void);
> 
> unsigned long foo(unsigned long v)
> {
>      bar();
>      return v;
> }
> 
> 0000000000000000 <foo>:
>     0:   41 54                   push   %r12
>     2:   49 89 fc                mov    %rdi,%r12
>     5:   e8 00 00 00 00          callq  bar
>     a:   4c 89 e0                mov    %r12,%rax
>     d:   41 5c                   pop    %r12
>     f:   c3                      retq
> 
> Now, if you need to specify *which* registers, you have to declare them as global register variables - NOT local (which 
> have completely different semantics). This also means that you (probably) want to isolate this code into its own 
> compilation unit, because it will prevent any other code in the same .c file from using that register as well.
> 
> For example:
> 
> register unsigned long r14 asm("%r14");
> unsigned long foo(unsigned long v)
> {
>      r14 = v;
>      bar();
>      v = r14;
>      return v;
> }
> 
> 0000000000000000 <foo>:
>     0:   49 89 fe                mov    %rdi,%r14
>     3:   e8 00 00 00 00          callq  bar
>     8:   4c 89 f0                mov    %r14,%rax
>     b:   c3                      retq
> 
> WARNING: This also means that gcc will happily discard the old value in %r14, so if you need it preserved you have to do 
> so explicitly; if you are called direct from assembly and are happy to lose the value then the above code is fine -- and 
> it is even slightly more efficient!
> 
> For preserving the old r14, in this case:
> 
> register unsigned long r14 asm("%r14");
> unsigned long foo(unsigned long v)
> {
>      unsigned long saved_r14 = r14;
>      r14 = v;
>      bar();
>      v = r14;
>      r14 = saved_r14;
>      return v;
> }
> 
> 0000000000000000 <foo>:
>     0:   53                      push   %rbx
>     1:   4c 89 f3                mov    %r14,%rbx
>     4:   49 89 fe                mov    %rdi,%r14
>     7:   e8 00 00 00 00          callq  bar
>     c:   4c 89 f0                mov    %r14,%rax
>     f:   49 89 de                mov    %rbx,%r14
>    12:   5b                      pop    %rbx
>    13:   c3                      retq
> 
> 
> HOWEVER, if you are relying on not using the stack, then using C code is probably very much not a good idea. It is very 
> hard to guarantee that just because the C compiler is *currently* not using a stack, that it won't do so *in the future*.
> 
> Again, finally, local register variables DO NOT WORK, this does NOT do what you expect:
> 
> unsigned long foo(unsigned long v)
> {
>      register unsigned long r14 asm("%r14") = v;
>      bar();
>      return r14;
> }
> 
> 0000000000000000 <foo>:
>     0:   41 54                   push   %r12
>     2:   49 89 fc                mov    %rdi,%r12
>     5:   e8 00 00 00 00          callq  bar
>     a:   4c 89 e0                mov    %r12,%rax
>     d:   41 5c                   pop    %r12
>     f:   c3                      retq
> 
> 
