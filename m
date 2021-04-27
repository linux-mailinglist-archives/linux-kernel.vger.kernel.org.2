Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AB736CDC1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 23:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbhD0VRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 17:17:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50945 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237057AbhD0VQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:16:58 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 13RLFkI1925360
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 27 Apr 2021 14:15:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 13RLFkI1925360
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021032801; t=1619558148;
        bh=OH6Ee28eLwng9NYWF9RLVZIFXvtSO6Pwr8F3RrF9GlY=;
        h=To:From:Subject:Date:From;
        b=Uw7v2h3EZN0hAByfXfQ8XoYHYhJJuNog0vbYT4rVplgAKQwOmnarEEgHAZfL0zH2W
         bW0ndvcZtdJ1T5ZSDX49A2zC4kIU3eVR0yE8+FIlh+EJCNcnRScOlJ/X4UFyOUq3U6
         OJOncIDGsrNDDcOzzCpJA3vWsxYfjYzfMGlFuVlggyg6KJBu8jP/+VWTgQtOWDpMJ4
         Z1TTdlMgOvA9ArNivwStWxkxacleOqqmCC/BIazPMGvqb9nXutfSgaCf6YbaeJ58hz
         xuabJOpU2mDs5ZQF9xCBaA443vuH6ny7xF1V3zq7ecBGGyhlEQLSFGKPpJqVuIljOF
         cnZwghlWsv2MQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        oleg@redhat.com, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Subject: pt_regs->ax == -ENOSYS
Message-ID: <f0240e15-223a-7600-4494-7a0a75155bdb@zytor.com>
Date:   Tue, 27 Apr 2021 14:15:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to stomp out some possible cargo cult programming?

In the process of going through the various entry code paths, I have to 
admit to being a bit confused why pt_regs->ax is set to -ENOSYS very 
early in the system call path.

What is perhaps even more confusing is:

__visible noinstr void do_syscall_64(struct pt_regs *regs, unsigned long nr)
{
         nr = syscall_enter_from_user_mode(regs, nr);

         instrumentation_begin();
         if (likely(nr < NR_syscalls)) {
                 nr = array_index_nospec(nr, NR_syscalls);
                 regs->ax = sys_call_table[nr](regs);
#ifdef CONFIG_X86_X32_ABI
         } else if (likely((nr & __X32_SYSCALL_BIT) &&
                           (nr & ~__X32_SYSCALL_BIT) < X32_NR_syscalls)) {
                 nr = array_index_nospec(nr & ~__X32_SYSCALL_BIT,
                                         X32_NR_syscalls);
                 regs->ax = x32_sys_call_table[nr](regs);
#endif
         }
         instrumentation_end();
         syscall_exit_to_user_mode(regs);
}
#endif

Now, unless I'm completely out to sea, it seems to me that if 
syscall_enter_from_user_mode() changes the system call number to an 
invalid number and pt_regs->ax to !-ENOSYS then the system call will 
return a different value(!) depending on if it is out of range for the 
table (whatever was poked into pt_regs->ax) or if it corresponds to a 
hole in the table. This seems to me at least to be The Wrong Thing.

Calling regs->ax = sys_ni_syscall() in an else clause would arguably be 
the right thing here, except possibly in the case where nr (or (int)nr, 
see below) == -1 or < 0.

Now, syscall_get_nr() returns the low 32 bits of the system call number 
unconditionally. There are places where we look at the sign of this 
number, which means that 0xffffffff7fffffff is "positive" and 
0x7fffffffffffffff is "negative". We have gone back and forth more than 
once on if we should look at %rax or just %eax on a system call... I 
have to admit that the current design makes me a bit nervous.

Finally, can anything bad happen in some weird corner case inside one of 
the syscall_*_mode() calls or after an interrupt if someone tries to 
call syscall(-1) or another negative number?

Food for thought or just my not being up to date?

Thanks,

	-hpa

