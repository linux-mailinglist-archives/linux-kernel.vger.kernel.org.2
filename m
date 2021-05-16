Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A825381D40
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 09:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhEPHbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 03:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbhEPHa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 03:30:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CE8C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 00:29:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a25so3133131edr.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/HUKk7mjQjf5BkzJrrBMxFpKNDTkK0AS6gmsh6pkpy8=;
        b=oHjgqQfNw1kdQLN4qlKYo0NxRUOg/9H62NAqD1YYzIiASGQocazdq5fWIoujKU5MqC
         G03fApbLVoCPE8fR6uTTRvufMCyihYUd8S1OesbEe90gu3Ta3RG5DW5xL1oa4EoT+5pU
         NblP2lhdTeNS8U1RWSfalo/2IWU/fX6eDPWp+AeD8l2HleDzxMwFcCalYUkWqZEZNJQP
         a5yJoszKbEoibXFxpOwAFOdnkdHI2tnB5teVmBdwa+eHAUMfBr82Qayc99oAQS3bDPKj
         yrC4RpVwiO/AV0m2U8AShzmrqFK8ALsdhL5Gd6GG1nQSvocnpu3Y8HWI6f0eKc8bwApQ
         rNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/HUKk7mjQjf5BkzJrrBMxFpKNDTkK0AS6gmsh6pkpy8=;
        b=kTso+/RA/pUQjoYzxcf2f5ecD2gvyXjERC7Y0d7XtLb6WmQO2LlGMQ+2SUm9v/cuFP
         ejoGW3h6b1z75aULsouB4o2YAav/vQSbawxBhjBJNir3C2OoykBx1q8K0Dx9kR8DTXkM
         Z7dcsS0xMbjSZNOytMUWjrD7fvFRxtAI8JxLoT3NSzB5ifXDV/lgFE11HewII9Ur7tsa
         IkYwemLnzlJfTfcIu2lNE3+iNBUFnOK0z/mjaSZPZWdZ1bJ6nLYi2pOdcrnHaWx4rjZH
         OzwTuPTCFf6++TKZXngit8xTkCUc40wLINDZ2l/Uka+MbqUlzPGIyxJN8jzMh8RQoA1V
         eOwg==
X-Gm-Message-State: AOAM532x2heECd+fAxOucbP/crixbnfcD7YacLnCU+uvIiFG4R5gn2gJ
        dLk43YIdm2tG8vujTxx1SZE=
X-Google-Smtp-Source: ABdhPJwAXuxp4k+mPL2vnW9creYNuVoGGJio6ivxvwR5sfs469QgCr6b1r43YTjd6V5V1GHLyQoE2w==
X-Received: by 2002:a05:6402:10cc:: with SMTP id p12mr27623528edu.328.1621150182464;
        Sun, 16 May 2021 00:29:42 -0700 (PDT)
Received: from gmail.com (563BBFD3.dsl.pool.telekom.hu. [86.59.191.211])
        by smtp.gmail.com with ESMTPSA id p25sm6553506eja.35.2021.05.16.00.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 00:29:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 16 May 2021 09:29:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: Re: [GIT PULL] Stack randomization fix
Message-ID: <YKDJ40DUdY1Oy+FJ@gmail.com>
References: <20210515073453.GA78379@gmail.com>
 <CAHk-=whpKm_bCDui-VcRwJWVPDPCFKY_oqRACpTff5zXNr8MjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whpKm_bCDui-VcRwJWVPDPCFKY_oqRACpTff5zXNr8MjQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, May 15, 2021 at 12:35 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > --- a/include/linux/randomize_kstack.h
> > +++ b/include/linux/randomize_kstack.h
> > @@ -38,7 +38,7 @@ void *__builtin_alloca(size_t size);
> >                 /* Keep allocation even after "ptr" loses scope. */     \
> > -               asm volatile("" : "=o"(*ptr) :: "memory");              \
> > +               asm volatile("" :: "r"(ptr) : "memory");                \
> >         }                                                               \
> 
> Side note: at some point, a compiler will (correctly) decide that
> regardless of the inline asm here, the scope of that allocation is
> only that one block.
> 
> To be actually reliable, I suspect that add_random_kstack_offset()
> should return that pointer as a cookie, and then users should have a
> 
>      end_random_kstack_offset(cookie);
> 
> at the end of the function that did the add_random_kstack_offset().
> 
> And that end_random_kstack_offset() should have *another* "asm
> volatile" that uses the pointer.

Indeed.

> Note that you need both of the asm volatile barriers: without the first 
> one, the compiler might decide to move the allocation down, and without 
> the second one, the compiler might decide the allocation is out of scope 
> and can be undone before the actual system call or whatever is done.
>
> Honestly, I don't personally much care (I think this is all stupid 
> overhead, and think clearing the stack is much better), and I suspect 
> that current compilers always end up cleaning up alloca at function exit, 
> so this probably all _works_ as-is. But it's technically fragile and 
> wrong.

Agreed.

What probably saves this sequence in practice is that it's:

 - Rare & localized to syscall entry points.

 - Freeing of stack allocation can usually be merged with the freeing of 
   the local stack at function epilogue at zero cost, on most platforms:

    - on x86 with frame pointers, LEAVE will clean up automatically

    - on x86 without frame pointers, the offset of the allocation can be 
      added to the stack fixup addition.

 - On x86 we actually use -fno-omit-frame-pointer for the entry code 
   explicitly, but it also appears from a couple of quick tests that GCC 
   will use frame pointers and LEAVE cleanup when alloca is used in a 
   function - even with -fomit-frame-pointers:

I tried to coax GCC into breaking the stack with:

   void dummy_dummy(void)
   {
	u32 offset = raw_cpu_read(kstack_offset);
	u8 *ptr = __builtin_alloca(KSTACK_OFFSET_MAX(offset));

	asm volatile("" :: "r"(ptr) : "memory");
   }

But GCC switched to frame pointers:

ffffffff810850f0 <dummy_dummy>:
ffffffff810850f0:       55                      push   %rbp
ffffffff810850f1:       48 89 e5                mov    %rsp,%rbp
ffffffff810850f4:       48 83 ec 08             sub    $0x8,%rsp
ffffffff810850f8:       65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
ffffffff810850ff:       00 00 
ffffffff81085101:       48 89 45 f8             mov    %rax,-0x8(%rbp)
ffffffff81085105:       31 c0                   xor    %eax,%eax
ffffffff81085107:       65 8b 05 b2 c4 f8 7e    mov    %gs:0x7ef8c4b2(%rip),%eax        # 115c0 <kstack_offset>
ffffffff8108510e:       25 ff 03 00 00          and    $0x3ff,%eax
ffffffff81085113:       48 83 c0 0f             add    $0xf,%rax
ffffffff81085117:       25 f8 07 00 00          and    $0x7f8,%eax
ffffffff8108511c:       48 29 c4                sub    %rax,%rsp
ffffffff8108511f:       48 8d 44 24 0f          lea    0xf(%rsp),%rax
ffffffff81085124:       48 83 e0 f0             and    $0xfffffffffffffff0,%rax
ffffffff81085128:       48 8b 45 f8             mov    -0x8(%rbp),%rax
ffffffff8108512c:       65 48 2b 04 25 28 00    sub    %gs:0x28,%rax
ffffffff81085133:       00 00 
ffffffff81085135:       75 02                   jne    ffffffff81085139 <dummy_dummy+0x49>
ffffffff81085137:       c9                      leave  
ffffffff81085138:       c3                      ret    
ffffffff81085139:       e8 a2 b2 b2 00          call   ffffffff81bb03e0 <__stack_chk_fail>
ffffffff8108513e:       66 90                   xchg   %ax,%ax

... side note: the overhead of this whole sequence is rather horrible, 
executed for every system call. :-/ This is made worse by 
CONFIG_STACKPROTECTOR_STRONG=y - which most big Linux distros have enabled.

Without stackprotector we get:

ffffffff81080330 <dummy_dummy>:
ffffffff81080330:       55                      push   %rbp
ffffffff81080331:       65 8b 05 88 12 f9 7e    mov    %gs:0x7ef91288(%rip),%eax        # 115c0 <kstack_offset>
ffffffff81080338:       25 ff 03 00 00          and    $0x3ff,%eax
ffffffff8108033d:       48 83 c0 0f             add    $0xf,%rax
ffffffff81080341:       48 89 e5                mov    %rsp,%rbp
ffffffff81080344:       25 f8 07 00 00          and    $0x7f8,%eax
ffffffff81080349:       48 29 c4                sub    %rax,%rsp
ffffffff8108034c:       48 8d 44 24 0f          lea    0xf(%rsp),%rax
ffffffff81080351:       48 83 e0 f0             and    $0xfffffffffffffff0,%rax
ffffffff81080355:       c9                      leave  
ffffffff81080356:       c3                      ret    

Which is still quite a bit longer than it probably should be, IMO. Since we 
are relying on assembly anyway, we don't we force frame pointers explicitly 
and do this in assembly? The key sequence should only be something like:

       65 8b 05 88 12 f9 7e    mov    %gs:0x7ef91288(%rip),%eax        # 115c0 <kstack_offset>
       48 29 c4                sub    %rax,%rsp

There's no fundamental reason for all the masking games IMO.

Anyway, in terms of fragility, the 'usually' and 'most' qualifiers & our 
reliance on compiler handling of alloca() are not guarantees & increase the 
fragility of this sequence...

Should be straightforward to switch this to a begin/end sequence, and 
shouldn't impact code generation, in principle.

Thanks,

	Ingo
