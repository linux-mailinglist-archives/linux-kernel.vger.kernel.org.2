Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112CF42C644
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbhJMQ0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:26:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37596 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhJMQ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:26:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 982A821A23;
        Wed, 13 Oct 2021 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634142268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lx+5wzFLRZqiTb+Uhg/iGQ2TCpoSNAvjoBnIgV2vO3M=;
        b=GeQRnnufRM9AV36kt5B0pHuaYeCHNLzKT1FxhEsHTOGiESfqfFCZM49yZEaylWxZVDRJDy
        3jCDlmqaqNcRGtFUt5SYyeEWh4dP7fE0GHBlh7/FopROz7JXenw7liIJDhgMtzGKm+Zo/o
        aGuSFbxwFezOwCTKQy5ZQTNuTrK7tQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634142268;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lx+5wzFLRZqiTb+Uhg/iGQ2TCpoSNAvjoBnIgV2vO3M=;
        b=78WoZBrHk++fou7WWCKvkqM/mM1ROfej2zhFnWy25WOfar+xQg8eMcSF+kpTOZ++OISK2V
        IROGd27+EU/dbnAw==
Received: from wotan.suse.de (wotan.suse.de [10.160.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2DBA6A3B85;
        Wed, 13 Oct 2021 16:24:28 +0000 (UTC)
Received: by wotan.suse.de (Postfix, from userid 10510)
        id 230006443; Wed, 13 Oct 2021 16:24:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by wotan.suse.de (Postfix) with ESMTP id 2118F6349;
        Wed, 13 Oct 2021 16:24:28 +0000 (UTC)
Date:   Wed, 13 Oct 2021 16:24:28 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     Willy Tarreau <w@1wt.eu>
cc:     Borislav Petkov <bp@alien8.de>,
        Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
In-Reply-To: <20211013142433.GB8557@1wt.eu>
Message-ID: <alpine.LSU.2.20.2110131601000.26294@wotan.suse.de>
References: <YWXwQ2P0M0uzHo0o@zn.tnic> <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id> <YWbUbSUVLy/tx7Zu@zn.tnic> <20211013125142.GD5485@1wt.eu> <YWbZz7gHBV18QJC3@zn.tnic> <20211013140723.GE5485@1wt.eu> <YWbrR1BqI1CxneN/@zn.tnic>
 <20211013142433.GB8557@1wt.eu>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 13 Oct 2021, Willy Tarreau wrote:

> On Wed, Oct 13, 2021 at 04:20:55PM +0200, Borislav Petkov wrote:
> > On Wed, Oct 13, 2021 at 04:07:23PM +0200, Willy Tarreau wrote:
> > > Yes I agree with the "potentially" here. If it can potentially be (i.e.
> > > the kernel is allowed by contract to later change the way it's currently
> > > done) then we have to save them even if it means lower code efficiency.
> > >
> > > If, however, the kernel performs such savings on purpose because it is
> > > willing to observe a stricter saving than the AMD64 ABI, we can follow
> > > it but only once it's written down somewhere that it is by contract and
> > > will not change.
> > 
> > Right, and Micha noted that such a change to the document can be done.
> 
> great.
> 
> > And we're basically doing that registers restoring anyway, in POP_REGS.
> 
> That's what I based my analysis on when I wanted to verify Ammar's
> finding. I would tend to think that if we're burning cycles popping
> plenty of registers it's probably for a reason, maybe at least a good
> one, which is that it's the only way to make sure we're not leaking
> internal kernel data! This is not a concern for kernel->kernel nor
> user->user calls but for user->kernel calls it definitely is one, and
> I don't think we could relax that series of pop without causing leaks
> anyway.

It might also be interesting to know that while the wording of the psABI 
was indeed intended to imply that all argument registers are potentially 
clobbered (like with normal calls) glibc's inline assembler to call 
syscalls relies on most registers to actually be preserved:

# define REGISTERS_CLOBBERED_BY_SYSCALL "cc", "r11", "cx"
...
#define internal_syscall6(number, arg1, arg2, arg3, arg4, arg5, arg6) \
({                                                                      \
    unsigned long int resultvar;                                        \
    TYPEFY (arg6, __arg6) = ARGIFY (arg6);                              \
    TYPEFY (arg5, __arg5) = ARGIFY (arg5);                              \
    TYPEFY (arg4, __arg4) = ARGIFY (arg4);                              \
    TYPEFY (arg3, __arg3) = ARGIFY (arg3);                              \
    TYPEFY (arg2, __arg2) = ARGIFY (arg2);                              \
    TYPEFY (arg1, __arg1) = ARGIFY (arg1);                              \
    register TYPEFY (arg6, _a6) asm ("r9") = __arg6;                    \
    register TYPEFY (arg5, _a5) asm ("r8") = __arg5;                    \
    register TYPEFY (arg4, _a4) asm ("r10") = __arg4;                   \
    register TYPEFY (arg3, _a3) asm ("rdx") = __arg3;                   \
    register TYPEFY (arg2, _a2) asm ("rsi") = __arg2;                   \
    register TYPEFY (arg1, _a1) asm ("rdi") = __arg1;                   \
    asm volatile (                                                      \
    "syscall\n\t"                                                       \
    : "=a" (resultvar)                                                  \
    : "0" (number), "r" (_a1), "r" (_a2), "r" (_a3), "r" (_a4),         \
      "r" (_a5), "r" (_a6)                                              \
    : "memory", REGISTERS_CLOBBERED_BY_SYSCALL);                        \
    (long int) resultvar;                                               \
})


Note in particular the missing clobbers or outputs of any of the argument 
regs.

So, even though the psABI (might have) meant something else, as glibc is 
doing the above we in fact have a de-facto standard that the kernel can't 
clobber any of the argument regs.  The wording and the linux x86-64 
syscall implementation (and use in glibc) all come from the same time in 
2001, so there never was a time when the kernel was not saving/restoring 
the arg registers, so it can't stop now.

In effect this means the psABI should be clarified to explicitely say the 
the arg registers aren't clobbered, i.e. that the mentioned list of 
clobbered regs isn't inclusive but exclusive.  I will do that.

When I was discussing this with Boris earlier I hadn't yet looked at glibc 
use but only gave my interpretation from memory and reading.  Obviously 
reality trumps anything like that :-)

In short:  Ammars initial claim:

> Linux x86-64 syscall only clobbers rax, rcx and r11 (and "memory").
> 
>   - rax for the return value.
>   - rcx to save the return address.
>   - r11 to save the rflags.
> 
> Other registers are preserved.

is accurate and I will clarify the psABI to make that explicit.


Ciao,
Michael.
