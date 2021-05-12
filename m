Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA19237EBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381710AbhELTfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:35:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50883 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350702AbhELRwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:52:00 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14CHoRb72810800
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 12 May 2021 10:50:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14CHoRb72810800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620841828;
        bh=HFBh/U57zwthpbNptPEHlAeAWP0RP0JChruPrvoVFIU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JnX2/67DwlRGouf+geKWL1tqYh7Tm84TNmHpNPth3JpYhIoWfj77741R0ee7K2KDc
         kwjnkDL0Dpr4jZTz3yKgTy270SuXABk+HrFTCjmOHrH/vcOJDiAfJbqYUFbF1idYuM
         ePI+odzJGKO1niIwEdqJUOCQRZ5umE5V2wTt+/FzSyinr1yUHD0r3iOiNUWlvr7KOM
         o8YUsjazU1jpPwVfZyp/thlgsABwasls+S/XfWRlvJFtBwTty/jpDoauri+YN/g+ZP
         x2uMWnC49hmgXDDnaAEWd8XKF28CYdcAPYDQDdJvvf10Ofx/GEjh2qCnlWA+oeS8T+
         0kCdOYn0q5HSQ==
Subject: Re: [RFC v2 PATCH 7/7] x86/entry: use int for syscall number; handle
 all invalid syscall nrs
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210510185316.3307264-1-hpa@zytor.com>
 <20210510185316.3307264-8-hpa@zytor.com> <YJuXCFAh0RR2+x25@gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <e2b4c397-629b-f2d2-38d0-15eaf481c792@zytor.com>
Date:   Wed, 12 May 2021 10:50:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJuXCFAh0RR2+x25@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 1:51 AM, Ingo Molnar wrote:
> 
> I've applied patches 1-6, thanks Peter!
> 
> Wrt. patch #7 - the changelog is hedging things a bit and the changes are
> non-trivial. Does this patch (intend to) change any actual observable
> behavior in the system call interface, and if yes, in which areas?
> 
> Or is this a pure cleanup with no observable changes expected?
> 

I'll clean up the comments a bit [including per tglx' review.] I'm 
writing this email in part to organize my own thoughts in how to better 
explain the motivation for the patch, and the extent of visible differences.

Right now, *some* code will treat e.g. 0x0000000100000001 as a system 
call and some will not. Some of the code, notably in ptrace, will treat 
0x000000018000000 as a system call and some will not. Finally, right 
now, e.g. 335 for x86-64 will force the exit code to be set to -ENOSYS 
even if poked by ptrace, but 548 will not, because there is an 
observable difference between an out of range system call and a system 
call number that falls outside the range of the table.

The use of a non-system-call number in a system call can come in in a 
few ways:

    1. Via ptrace;
    2. From seccomp;
    3. By explicitly passing %eax = -1 to a system call.

#3 isn't really a problem *unless* it for some reason confuses ptrace or 
seccomp users -- we could do an early-out for it.

For ptrace and seccomp, we enter with the return value (regs->ax) set to 
-ENOSYS, regardless of if the system call number is valid or not. 
ptrace/seccomp has the option of independently emulate a system call, 
then set regs->orig_ax to -1 and provide any chosen return value in 
regs->ax. In that case, we must *not* update regs->ax to -ENOSYS before 
returning.

The arch-independent code all assumes that a system call is "int" that 
the value -1 specifically and not just any negative value is used for a 
non-system call. This is the case on x86 as well when arch-independent 
code is involved. The arch-independent API is defined/documented (but 
not *implemented*!) in <asm-generic/syscall.h>, and what this patch is 
intended to do is to make the x86-specific code follow.

As everyone either does or should know, treating the same data in 
different ways in different flows is a security hole just waiting to 
happen.

Most of these are relatively recently introduced bugs in x86-64; the 
original assembly code version zero-extended %rax, compared it against 
the length of the system call table, and would unconditionally return 
-ENOSYS otherwise. Then *at least* on two separate occasions someone 
"optimized" it by removing "movl %eax, %eax" not understanding that this 
is not a noop in x86-64 but a zero-extend (perhaps gas ought to be able 
to allow movzlq as an alias...) introducing a critical security bug 
which was one of the motivators for the SMAP CPU feature.

On x86-64, the ABI is that the callee is responsible for extending 
parameters, so only examining the lower 32 bits is fully consistent with 
any "int" argument to any system call, e.g. regs->di for write(2).

Andy L. and I had a fairly long discussion about this, and some of this 
was updated after the first RFC, but I fully agree I'm not capturing it 
all that well. I hope the above points clear things up better and I'll 
rewrite this into a better patch description.

	-hpa
