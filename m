Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1F53F908A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 01:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243671AbhHZWM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 18:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhHZWMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 18:12:55 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87923C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 15:12:07 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id z5so8781121ybj.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 15:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVcnpfqelprXusUWBTWhyR8bc4iZP7g4UmNmH8P05EA=;
        b=BT//sK3myuCW8lgwmsOHhvwUxIJfXLFEKePfUAWbYHLIatYx2C16orwd+hbH3uT5ng
         FaypAAk0NOC3mC8eQ7eaB0/bN8ofS7rLoUIVzH/FXa0c8YL1A0gqQSU46sJT4XwZLlNH
         pEPRWFHuzA+rCzOBWOE/niM3h9O4fBzwVRL2BTxYH+sGO+uDOO5C+TgaHsMslfXw24hm
         h3XDeMCeykretEj/KTin5kHRHf73Er8x8rJGWhcShpLuTpWioFjTvjABhZEBXoh0qtAL
         ZPhupjbwUH/acPwRWGtY1yW2/rxwrwqEgOmAPIwNzEJ+WjBwwlYm9tphCMEpFB+yd4MJ
         WUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVcnpfqelprXusUWBTWhyR8bc4iZP7g4UmNmH8P05EA=;
        b=HDM9Zcny8UWGSP7ZfkFurVQbFdkfTLxaqTT7IMIcMqD9IKFQdt3AopPJjm7MDAivFX
         Qj/4UX5QRIP4JgZqcsYsBCo8A2UtxMC+zlRQJcHcYNXwAAhsCVagP0I2VwINMSanhD9V
         LWUm/Ul858gKgl4jYL2odzvqNqUfqEy4+srckL/P8+iKYweNuD0J36v6gUgCEoX71m+k
         d8nbA5ZnsrykW2+Who+BSYtUZ+iIMjjuXG9/REfDIbRN4dXl/T4u29J1unNArxqKc72i
         rV3ZKQg3nYW+LhRH5x/XCWd1AdpxjfK6bPtp/acpUsngywBiLJqVssmoxwZg2l10/uMI
         JMLw==
X-Gm-Message-State: AOAM533ALunSn7xRmYHDS95uFWcwbNO7BfzEAjTRrp1krwFQYgMw1J9C
        T+p8L8PgavJ10WlKotGIiVK5gtd0c/CO1CeOCwjyBA==
X-Google-Smtp-Source: ABdhPJzFNa4m0CjHi6tDz1iU7f3R5QbXIyBk3vmKYkduAEw6zEWFRwqLA0nP9aCQ9mBTSYF4sxFVr3+b5nGFCYLaXqY=
X-Received: by 2002:a25:4f08:: with SMTP id d8mr1199603ybb.476.1630015926488;
 Thu, 26 Aug 2021 15:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
 <20210823171318.2801096-8-samitolvanen@google.com> <b2b0247a-39ad-097b-8fab-023ee378c806@kernel.org>
In-Reply-To: <b2b0247a-39ad-097b-8fab-023ee378c806@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 26 Aug 2021 15:11:55 -0700
Message-ID: <CABCJKueE=_WCLkVDmPss-Bo-1VWaX7W6SSNx33rQCO+eEv_Lzg@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] x86: Use an opaque type for functions not
 callable from C
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 9:54 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On 8/23/21 10:13 AM, Sami Tolvanen wrote:
> > The kernel has several assembly functions that are not directly callable
> > from C. Use an opaque type for these function prototypes to make misuse
> > harder, and to avoid the need to annotate references to these functions
> > for Clang's Control-Flow Integrity (CFI).
>
> You have:
>
> typedef const u8 *asm_func_t;
>
> This is IMO a bit confusing.  asm_func_t like this is an *address* of a
> function, not a function.
>
> To be fair, C is obnoxious, but I think this will lead to more confusion
> than is idea.  For example:
>
> > -extern void __fentry__(void);
> > +DECLARE_ASM_FUNC_SYMBOL(__fentry__);
>
> Okay, __fentry__ is the name of a symbol, and the expression __fentry__
> is a pointer (or an array that decays to a pointer, thanks C), which is
> at least somewhat sensible.  But:
>
> > -extern void (*paravirt_iret)(void);
> > +extern asm_func_t paravirt_iret;
>
> Now paravirt_iret is a global variable that points to an asm func.  I
> bet people will read this wrong and, worse, type it wrong.
>
> I think that there a couple ways to change this that would be a bit nicer.
>
> 1. typedef const u8 asm_func_t[];
>
> This is almost nice, but asm_func_t will still be accepted as a function
> argument, and the automatic decay rules will probably be confusing.
>
> 2. Rename asm_func_t to asm_func_ptr.  Then it's at least a bit more clear.
>
> 3. Use an incomplete struct:
>
> struct asm_func;
>
> typedef struct asm_func asm_func;
>
> extern asm_func some_func;
>
> void *get_ptr(void)
> {
>     return &some_func;
> }
>
> No macros required, and I think it's quite hard to misuse this by
> accident.  asm_func can't be passed as an argument or used as a variable
> because it has incomplete type, and there are no arrays so the decay
> rules aren't in effect.

I considered using an incomplete struct, but that would require an
explicit '&' when we take the address of these symbols, which I
thought would be unnecessary churn. Unless you strongly prefer this
one, I'll go with option 2 and rename asm_func_t to asm_func_ptr in
v3.

Sami
