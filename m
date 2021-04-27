Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086F936CF01
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 00:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239079AbhD0W7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 18:59:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51513 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236547AbhD0W7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 18:59:11 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 13RMw8s9941858
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 27 Apr 2021 15:58:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 13RMw8s9941858
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021032801; t=1619564293;
        bh=BKXnXbtnLAZiK4ZaeAicI6A/g8pOK30QDSs2ImWpeVQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M9JZEPiEXKQaxG0i128nVah5nnl2dSyxxAIZ2p5b3CY7sHSS3izuaHRWmbN9nscjq
         bSKxdpCAr7/Kf3Kl0+fQdIiFGkHCc0u9BtKmJeXZNznsJF9bjOKDvzXcxOsMb7XqX2
         hOe+uWW/UMOdGcsUIzd/vi/5j3yES46AWtvUlU1jBROXiea4567PNJWpLYoZMFqVgL
         NMq2J5zJlGm1UXU8D+4P9OvfHXbui5e/dqwEuSS2UJ/GtF2AnUjpobB7awcvvFRRIa
         ES5ti8RR6LeopN+oxl78/X8W0BVsZoLB2U25rzepimjXABo8RQGHyqoN5+CXbp11qq
         +xPVahT1CiYuA==
Subject: Re: pt_regs->ax == -ENOSYS
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        oleg@redhat.com, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
References: <f0240e15-223a-7600-4494-7a0a75155bdb@zytor.com>
 <F9F5E9D4-C1EE-455A-A6B1-4DF9D349BBAA@amacapital.net>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <06a5e088-b0e6-c65e-73e6-edc740aa4256@zytor.com>
Date:   Tue, 27 Apr 2021 15:58:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <F9F5E9D4-C1EE-455A-A6B1-4DF9D349BBAA@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/21 2:28 PM, Andy Lutomirski wrote:
> 
>> On Apr 27, 2021, at 2:15 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>>
>> ﻿Trying to stomp out some possible cargo cult programming?
>>
>> In the process of going through the various entry code paths, I have to admit to being a bit confused why pt_regs->ax is set to -ENOSYS very early in the system call path.
>>
> 
> It has to get set to _something_, and copying orig_ax seems perhaps silly.  There could also be code that relies on ptrace poking -1 into the nr resulting in -ENOSYS.
> 

Yeah. I obviously ran into this working on the common entry-exit code 
for FRED; the frame has annoyingly different formats because of this, 
and I wanted to avoid slowing down the system call path.

>> What is perhaps even more confusing is:
>>
>> __visible noinstr void do_syscall_64(struct pt_regs *regs, unsigned long nr)
>> {
>>         nr = syscall_enter_from_user_mode(regs, nr);
>>
>>         instrumentation_begin();
>>         if (likely(nr < NR_syscalls)) {
>>                 nr = array_index_nospec(nr, NR_syscalls);
>>                 regs->ax = sys_call_table[nr](regs);
>> #ifdef CONFIG_X86_X32_ABI
>>         } else if (likely((nr & __X32_SYSCALL_BIT) &&
>>                           (nr & ~__X32_SYSCALL_BIT) < X32_NR_syscalls)) {
>>                 nr = array_index_nospec(nr & ~__X32_SYSCALL_BIT,
>>                                         X32_NR_syscalls);
>>                 regs->ax = x32_sys_call_table[nr](regs);
>> #endif
>>         }
>>         instrumentation_end();
>>         syscall_exit_to_user_mode(regs);
>> }
>> #endif
>>
>> Now, unless I'm completely out to sea, it seems to me that if syscall_enter_from_user_mode() changes the system call number to an invalid number and pt_regs->ax to !-ENOSYS then the system call will return a different value(!) depending on if it is out of range for the table (whatever was poked into pt_regs->ax) or if it corresponds to a hole in the table. This seems to me at least to be The Wrong Thing.
> 
> I think you’re right.
> 
>>
>> Calling regs->ax = sys_ni_syscall() in an else clause would arguably be the right thing here, except possibly in the case where nr (or (int)nr, see below) == -1 or < 0.
> 
> I think the check should be -1 for 64 bit but (u32)nr == (u32)-1 for the 32-bit path. Does that seem reasonable?

I'm thinking overall that depending on 64-bit %rax is once again a 
mistake; I realize that the assembly code that did that kept breaking 
because people messed with it, but we still have:

/*
  * Only the low 32 bits of orig_ax are meaningful, so we return int.
  * This importantly ignores the high bits on 64-bit, so comparisons
  * sign-extend the low 32 bits.
  */
static inline int syscall_get_nr(struct task_struct *task, struct 
pt_regs *regs)
{
         return regs->orig_ax;
}

"Different interpretation of the same data" is a notorious security 
trap. Zero-extending orig_ax would cause different behavior on 32 and 64 
bits and differ from the above, so I'm thinking that just once and for 
all defining the system call number as a signed int for all the x86 ABIs 
would be the sanest.

It still doesn't really answer the question if "movq $-1,%rax; syscall" 
or "movl $-1,%eax; syscall" could somehow cause bad things to happen, 
though, which makes me a little bit nervous still.

	-hpa
