Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F9B406683
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 06:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhIJEd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 00:33:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33173 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbhIJEd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 00:33:26 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 18A4VZlt313082
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 9 Sep 2021 21:31:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 18A4VZlt313082
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631248297;
        bh=VzBwLrZoO8zu+QwMUjqACChLuOtyyjkMLz3kn2TvzsQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GOp+qoMw0BJ61rLxZKZsYaWy1uDNzIlZNy2w+BCHhfsOu5tsJIDWxZC0AlOT6wn+X
         3GF2XFmwcF6AYYTTbgsEiHuBldJpFjbLkUSX5G3Kc2PknuzNJm27ErADs87T/QMX7B
         24hquS632RV21MI8vx5QgYMcJSMjurUoVxANlGVRLJjMQnvDpHIdUz5AvMahx5NFlI
         sdpxnHsOePpY5Zu4cU3s15HpilQVuW0AxNa9nzueBUPI3wAhKYySpxYH/Q7zpUi7DG
         h7GvaqAHlrwmJlZuUcbP3hairp6x0rKVoKZrTGEyVWOQuYGBd/cbiuoR/sYzIGGk52
         x9IpLTiZ8Ssig==
Subject: Re: [PATCH 17/24] x86/entry: Introduce struct ist_regs
To:     Lai Jiangshan <laijs@linux.alibaba.com>,
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
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <9fe0e26b-5fb7-4521-a01e-8edd8d5cb74c@zytor.com>
Date:   Thu, 9 Sep 2021 21:31:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <eb294b5d-82f2-be80-b3e3-db556c155d95@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: the examples in this email all compiled with:

gcc -O2 -mpreferred-stack-boundary=3 -mcmodel=kernel

The disassembly has been slightly simplified.


On 9/9/21 5:18 PM, Lai Jiangshan wrote:
> 
> This patch was over designed.
> 
> In ASM code, we can easily save results in the callee-saved registers.
> For example, rc3 is saved in %r14, gsbase info is saved in %rbx.
> 
> And in C code, we can't save results in registers.  And I thought there was
> no place to save the results because the CR3 and gsbase are not kernel's.
> So I extended the pt_regs to ist_regs to save the results.
> 
> But it was incorrect.  The results can be saved in percpu data at the 
> end of
> paranoid_entry() after the CR3/gsbase are settled down.  And the results
> can be read at the beginning of paranoid_exit() before the CR3/gsbase are
> switched to the interrupted context's.
> 

OK, count me confused. Of course you can save results in caller-saved 
registers in C; it is kind of what they do:


extern void bar(void);

unsigned long foo(unsigned long v)
{
	bar();
	return v;
}

0000000000000000 <foo>:
    0:   41 54                   push   %r12
    2:   49 89 fc                mov    %rdi,%r12
    5:   e8 00 00 00 00          callq  bar
    a:   4c 89 e0                mov    %r12,%rax
    d:   41 5c                   pop    %r12
    f:   c3                      retq

Now, if you need to specify *which* registers, you have to declare them 
as global register variables - NOT local (which have completely 
different semantics). This also means that you (probably) want to 
isolate this code into its own compilation unit, because it will prevent 
any other code in the same .c file from using that register as well.

For example:

register unsigned long r14 asm("%r14");
unsigned long foo(unsigned long v)
{
	r14 = v;
	bar();
	v = r14;
	return v;
}

0000000000000000 <foo>:
    0:   49 89 fe                mov    %rdi,%r14
    3:   e8 00 00 00 00          callq  bar
    8:   4c 89 f0                mov    %r14,%rax
    b:   c3                      retq

WARNING: This also means that gcc will happily discard the old value in 
%r14, so if you need it preserved you have to do so explicitly; if you 
are called direct from assembly and are happy to lose the value then the 
above code is fine -- and it is even slightly more efficient!

For preserving the old r14, in this case:

register unsigned long r14 asm("%r14");
unsigned long foo(unsigned long v)
{
	unsigned long saved_r14 = r14;
	r14 = v;
	bar();
	v = r14;
	r14 = saved_r14;
	return v;
}

0000000000000000 <foo>:
    0:   53                      push   %rbx
    1:   4c 89 f3                mov    %r14,%rbx
    4:   49 89 fe                mov    %rdi,%r14
    7:   e8 00 00 00 00          callq  bar
    c:   4c 89 f0                mov    %r14,%rax
    f:   49 89 de                mov    %rbx,%r14
   12:   5b                      pop    %rbx
   13:   c3                      retq


HOWEVER, if you are relying on not using the stack, then using C code is 
probably very much not a good idea. It is very hard to guarantee that 
just because the C compiler is *currently* not using a stack, that it 
won't do so *in the future*.

Again, finally, local register variables DO NOT WORK, this does NOT do 
what you expect:

unsigned long foo(unsigned long v)
{
	register unsigned long r14 asm("%r14") = v;
	bar();
	return r14;
}

0000000000000000 <foo>:
    0:   41 54                   push   %r12
    2:   49 89 fc                mov    %rdi,%r12
    5:   e8 00 00 00 00          callq  bar
    a:   4c 89 e0                mov    %r12,%rax
    d:   41 5c                   pop    %r12
    f:   c3                      retq



