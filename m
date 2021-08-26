Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D033F9113
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 01:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243866AbhHZXq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 19:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243860AbhHZXq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 19:46:56 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF6DC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 16:46:08 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id n15so9101337ybm.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 16:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJVh8U7H1D0AP9Coqw4pJN8m0+s+/ZBxKNZaTaJtBCs=;
        b=Xqhk5PzMZ8HwiFHy1j3KgSqIUsuesqOgAYxTqG+gg3IKh74p9Lc0qmnQIbPJPadJAH
         s+1b84DrufWYCarVbavP9HYs1l8Mf23WhxGnhLc5NHwM1aZV3QxyitPT6qcUoWO8cAsJ
         IkFkpkg8zh6EAkS0DtVSs8zlXq/GYP0uYYWtAX0RSYArNp3r1FHd21C4QeZib06amuht
         bOvIKFCoa21xDnN85hwIw/+lTqhUzpz5fGCFdVf93eqjXTNqP/lgPmC1vAKcQ295+tq0
         DnNFCGq44tKL6Z3R8VloEQWQffjm59guTFxGbEtXxMX0D+WvRsZpfEQmQT9BtOZkTgzz
         hypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJVh8U7H1D0AP9Coqw4pJN8m0+s+/ZBxKNZaTaJtBCs=;
        b=tH0MNKCLfF2cIR4gy99urRhkgi87iKVAc8zW8gilHzNLZdY37tjzeCclbyaM8QYG3o
         Xga388Kr08M3HzlS7TujPQo2hGPx8WyoXSO30GqVg9s1xTxi1BYb5wxCcFEQrtIgM0F+
         9c3ZZSRvurUkuP3PHduHmycgbxp8Uz51YF7tar2Fw2B9lbBq4L17xBsxS3gkWT/yNmpx
         ILLVLojJTXKjlsY6mgoWS3dVDOM6wilKqOy2hzxcZxLO66lKjUH1Q1DMPFqlVJEsDJa0
         wmIKhM7wxXpEs4CttNf0+2zLnZy3tu8Z1e+7xeJ2irM+Xl0hw8oRVB9zaO7MFvj1XxYR
         PrJQ==
X-Gm-Message-State: AOAM530Ga+eXdbeeAzRX3+H7hRV0zottY3F2YO+ajbX/1VjpgtQXDAkR
        GzKrGKvwAhQQwBnCFLYoxuHp2jeEgQ+ot+lcYl+fAg==
X-Google-Smtp-Source: ABdhPJxAOEGBwm8gjuZ5VtjQ9bngsTCVz4sLCbftexa9Obb7SZdCWz6S38c+wzpRgFDk6IG6atpQjye9P0dszmTioTg=
X-Received: by 2002:a25:1b09:: with SMTP id b9mr1576338ybb.293.1630021567153;
 Thu, 26 Aug 2021 16:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
 <20210823171318.2801096-8-samitolvanen@google.com> <b2b0247a-39ad-097b-8fab-023ee378c806@kernel.org>
 <CABCJKueE=_WCLkVDmPss-Bo-1VWaX7W6SSNx33rQCO+eEv_Lzg@mail.gmail.com> <959b3e65-97c9-4e00-87c5-f4a31c6739de@www.fastmail.com>
In-Reply-To: <959b3e65-97c9-4e00-87c5-f4a31c6739de@www.fastmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 26 Aug 2021 16:45:56 -0700
Message-ID: <CABCJKud4auwY50rO0UzH721eRyyvJ8+43+Xt9vcLgw-SMYtHEw@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] x86: Use an opaque type for functions not
 callable from C
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 4:24 PM Andy Lutomirski <luto@kernel.org> wrote:
>
>
>
> On Thu, Aug 26, 2021, at 3:11 PM, Sami Tolvanen wrote:
> > On Thu, Aug 26, 2021 at 9:54 AM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > On 8/23/21 10:13 AM, Sami Tolvanen wrote:
> > > > The kernel has several assembly functions that are not directly callable
> > > > from C. Use an opaque type for these function prototypes to make misuse
> > > > harder, and to avoid the need to annotate references to these functions
> > > > for Clang's Control-Flow Integrity (CFI).
> > >
> > > You have:
> > >
> > > typedef const u8 *asm_func_t;
> > >
> > > This is IMO a bit confusing.  asm_func_t like this is an *address* of a
> > > function, not a function.
> > >
> > > To be fair, C is obnoxious, but I think this will lead to more confusion
> > > than is idea.  For example:
> > >
> > > > -extern void __fentry__(void);
> > > > +DECLARE_ASM_FUNC_SYMBOL(__fentry__);
> > >
> > > Okay, __fentry__ is the name of a symbol, and the expression __fentry__
> > > is a pointer (or an array that decays to a pointer, thanks C), which is
> > > at least somewhat sensible.  But:
> > >
> > > > -extern void (*paravirt_iret)(void);
> > > > +extern asm_func_t paravirt_iret;
> > >
> > > Now paravirt_iret is a global variable that points to an asm func.  I
> > > bet people will read this wrong and, worse, type it wrong.
> > >
> > > I think that there a couple ways to change this that would be a bit nicer.
> > >
> > > 1. typedef const u8 asm_func_t[];
> > >
> > > This is almost nice, but asm_func_t will still be accepted as a function
> > > argument, and the automatic decay rules will probably be confusing.
> > >
> > > 2. Rename asm_func_t to asm_func_ptr.  Then it's at least a bit more clear.
> > >
> > > 3. Use an incomplete struct:
> > >
> > > struct asm_func;
> > >
> > > typedef struct asm_func asm_func;
> > >
> > > extern asm_func some_func;
> > >
> > > void *get_ptr(void)
> > > {
> > >     return &some_func;
> > > }
> > >
> > > No macros required, and I think it's quite hard to misuse this by
> > > accident.  asm_func can't be passed as an argument or used as a variable
> > > because it has incomplete type, and there are no arrays so the decay
> > > rules aren't in effect.
> >
> > I considered using an incomplete struct, but that would require an
> > explicit '&' when we take the address of these symbols, which I
> > thought would be unnecessary churn. Unless you strongly prefer this
> > one, I'll go with option 2 and rename asm_func_t to asm_func_ptr in
> > v3.
> >
>
> Do you have a sense for how many occurrences there are that would need an &?

Quick grepping suggests there are ~80 occurrences in arch/x86. ~40 of
these are in kernel/idt.c.

Sami
