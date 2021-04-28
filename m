Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5494836CFF7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 02:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbhD1AWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 20:22:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51429 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236026AbhD1AWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 20:22:01 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 13S0L0Hw954819
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 27 Apr 2021 17:21:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 13S0L0Hw954819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021032801; t=1619569267;
        bh=ZRfME0xaa5h3nNKOtMFXV4tw4BZwapnF65y+JWZ2Ar4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e4jlhbwIHXh2+1UhWXBiiI4ofmbh95WWUx/gnD3kNnqysKlGPpEfYz3K67bD6IW60
         CkyvV9SSzWAlZX9jzx4iwNIJ4XYI3Wn9bkiQMzkB6Wv4VXp/+U4fOW69Rplb345w41
         vwgF155AwLS9HiBPihRQKjx6MdNLUQQRcuM/Xn3cBkgOT05mEGifSeqVp/35qcklE8
         4VrZv6ifhvxJX4+KK6C3G8sCnlXIkt2ueXY6ntE1Bb12Ubj3ajZ2b/QxtCp6vjiZD9
         1aeq2FZQddkXHJ7XEfAkRZQ9vrHW8EpyivFmscmBDWJx3eO2sJGyBRpLpRJSr2Sxv7
         xicGw9GMKp/7w==
Subject: Re: pt_regs->ax == -ENOSYS
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
References: <f0240e15-223a-7600-4494-7a0a75155bdb@zytor.com>
 <F9F5E9D4-C1EE-455A-A6B1-4DF9D349BBAA@amacapital.net>
 <06a5e088-b0e6-c65e-73e6-edc740aa4256@zytor.com>
 <CALCETrW7Vu5ZU-Lv4RRG5DSGxMBJmDMqpvP7kqO16DwajproBQ@mail.gmail.com>
 <3626eea3-524e-4dbd-78dd-9ade5a346a08@zytor.com>
 <CALCETrWzL=jgnWd+6YuBo02GG8vTvsG22sXGaUQCc37vwQ6HdA@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <3a502aae-4124-5cb2-1dac-bc18b8158fbe@zytor.com>
Date:   Tue, 27 Apr 2021 17:20:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CALCETrWzL=jgnWd+6YuBo02GG8vTvsG22sXGaUQCc37vwQ6HdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/21 5:11 PM, Andy Lutomirski wrote:
> On Tue, Apr 27, 2021 at 5:05 PM H. Peter Anvin <hpa@zytor.com> wrote:
>>
>> On 4/27/21 4:23 PM, Andy Lutomirski wrote:
>>>
>>> I much prefer the model of saying that the bits that make sense for
>>> the syscall type (all 64 for 64-bit SYSCALL and the low 32 for
>>> everything else) are all valid.  This way there are no weird reserved
>>> bits, no weird ptrace() interactions, etc.  I'm a tiny bit concerned
>>> that this would result in a backwards compatibility issue, but not
>>> very.  This would involve changing syscall_get_nr(), but that doesn't
>>> seem so bad.  The biggest problem is that seccomp hardcoded syscall
>>> nrs to 32 bit.
>>>
>>> An alternative would be to declare that we always truncate to 32 bits,
>>> except that 64-bit SYSCALL with high bits set is an error and results
>>> in ENOSYS. The ptrace interaction there is potentially nasty.
>>>
>>> Basically, all choices here kind of suck, and I haven't done a real
>>> analysis of all the issues...
>>>
>>
>> OK, I really don't understand this. The *current* way of doing it causes
>> a bunch of ugly corner conditions, including in ptrace, which this would
>> get rid of. It isn't any different than passing any other argument which
>> is an int -- in fact we have this whole machinery to deal with that subcase.
>>
> 
> Let's suppose we decide to truncate the syscall nr.  What would the
> actual semantics be?  Would ptrace see the truncated value in orig_ax?
>   How about syscall user dispatch?  What happens if ptrace writes a
> value with high bits set to orig_ax?  Do we truncate it again?  Or do
> we say that ptrace *can't* write too large a value?
> 
> For better for worse, RAX is 64 bits, orig_ax is a 64-bit field, and
> it currently has nonsensical semantics.  Redefining orig_ax as a
> 32-bit field is surely possible, but doing so cleanly is not
> necessarily any easier than any other approach.  If it weren't for
> seccomp, I would say that the obviously correct answer is to just
> treat it everywhere as a 64-bit number.
> 

We *used* to truncate the system call number; that was unsigned. It 
causes massive headache to ptrace if a 32-bit ptrace wants to write -1, 
which is a bit hacky.

I would personally like to see orig_ax to be the register passed in and 
for the truncation to happen by syscall_get_nr().

I also note that kernel/seccomp.c and the tracing infrastructure all 
expect a signed int as the system call number. Yes, orig_ax is a 64-bit 
field, but so are the other register fields which doesn't necessarily 
directly reflect the value of an argument -- like, say, %rdi in the case 
of sys_write - it is an int argument so it gets sign extended; this is 
*not* reflected in ptrace.

	-hpa
