Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827904331CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhJSJJA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Oct 2021 05:09:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:25616 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229930AbhJSJI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:08:59 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-250-8TNOiqasOU63UmYEpcjisA-1; Tue, 19 Oct 2021 10:06:41 +0100
X-MC-Unique: 8TNOiqasOU63UmYEpcjisA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 19 Oct 2021 10:06:40 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Tue, 19 Oct 2021 10:06:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Matz' <matz@suse.de>, Willy Tarreau <w@1wt.eu>
CC:     Borislav Petkov <bp@alien8.de>,
        Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
Thread-Topic: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
Thread-Index: AQHXwE7LTncX5QIgaEymHCfZB5yMpqvaDgyA
Date:   Tue, 19 Oct 2021 09:06:40 +0000
Message-ID: <01650203956e4f13adf1feed85fc36a3@AcuMS.aculab.com>
References: <YWXwQ2P0M0uzHo0o@zn.tnic>
 <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
 <YWbUbSUVLy/tx7Zu@zn.tnic> <20211013125142.GD5485@1wt.eu>
 <YWbZz7gHBV18QJC3@zn.tnic> <20211013140723.GE5485@1wt.eu>
 <YWbrR1BqI1CxneN/@zn.tnic> <20211013142433.GB8557@1wt.eu>
 <alpine.LSU.2.20.2110131601000.26294@wotan.suse.de>
In-Reply-To: <alpine.LSU.2.20.2110131601000.26294@wotan.suse.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Matz
> Sent: 13 October 2021 17:24
> 
> Hello,
> 
> On Wed, 13 Oct 2021, Willy Tarreau wrote:
> 
> > On Wed, Oct 13, 2021 at 04:20:55PM +0200, Borislav Petkov wrote:
> > > On Wed, Oct 13, 2021 at 04:07:23PM +0200, Willy Tarreau wrote:
> > > > Yes I agree with the "potentially" here. If it can potentially be (i.e.
> > > > the kernel is allowed by contract to later change the way it's currently
> > > > done) then we have to save them even if it means lower code efficiency.
> > > >
> > > > If, however, the kernel performs such savings on purpose because it is
> > > > willing to observe a stricter saving than the AMD64 ABI, we can follow
> > > > it but only once it's written down somewhere that it is by contract and
> > > > will not change.
> > >
> > > Right, and Micha noted that such a change to the document can be done.
> >
> > great.
> >
> > > And we're basically doing that registers restoring anyway, in POP_REGS.
> >
> > That's what I based my analysis on when I wanted to verify Ammar's
> > finding. I would tend to think that if we're burning cycles popping
> > plenty of registers it's probably for a reason, maybe at least a good
> > one, which is that it's the only way to make sure we're not leaking
> > internal kernel data! This is not a concern for kernel->kernel nor
> > user->user calls but for user->kernel calls it definitely is one, and
> > I don't think we could relax that series of pop without causing leaks
> > anyway.
> 
> It might also be interesting to know that while the wording of the psABI
> was indeed intended to imply that all argument registers are potentially
> clobbered (like with normal calls) glibc's inline assembler to call
> syscalls relies on most registers to actually be preserved:
> 
> # define REGISTERS_CLOBBERED_BY_SYSCALL "cc", "r11", "cx"
> ...
> #define internal_syscall6(number, arg1, arg2, arg3, arg4, arg5, arg6) \
> ({                                                                      \
>     unsigned long int resultvar;                                        \
>     TYPEFY (arg6, __arg6) = ARGIFY (arg6);                              \
>     TYPEFY (arg5, __arg5) = ARGIFY (arg5);                              \
>     TYPEFY (arg4, __arg4) = ARGIFY (arg4);                              \
>     TYPEFY (arg3, __arg3) = ARGIFY (arg3);                              \
>     TYPEFY (arg2, __arg2) = ARGIFY (arg2);                              \
>     TYPEFY (arg1, __arg1) = ARGIFY (arg1);                              \
>     register TYPEFY (arg6, _a6) asm ("r9") = __arg6;                    \
>     register TYPEFY (arg5, _a5) asm ("r8") = __arg5;                    \
>     register TYPEFY (arg4, _a4) asm ("r10") = __arg4;                   \
>     register TYPEFY (arg3, _a3) asm ("rdx") = __arg3;                   \
>     register TYPEFY (arg2, _a2) asm ("rsi") = __arg2;                   \
>     register TYPEFY (arg1, _a1) asm ("rdi") = __arg1;                   \
>     asm volatile (                                                      \
>     "syscall\n\t"                                                       \
>     : "=a" (resultvar)                                                  \
>     : "0" (number), "r" (_a1), "r" (_a2), "r" (_a3), "r" (_a4),         \
>       "r" (_a5), "r" (_a6)                                              \
>     : "memory", REGISTERS_CLOBBERED_BY_SYSCALL);                        \
>     (long int) resultvar;                                               \
> })
> 
> 
> Note in particular the missing clobbers or outputs of any of the argument
> regs.

What about all the AVX registers?
These are normally caller-saved - so are unlikely to be live in a gcc stub.
But glibc is unlikely to keep the clobber list up do date - even if they
were ever added.

While the kernel can't return 'junk' in the AVX registers, it may be
significantly cheaper to zero the registers on at least some code paths.

The same is true for the rxx registers.
Executing 'xor %rxx,%rxx' is faster than 'pop $rxx'.
Especially since the xor cam all be execute in parallel.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

