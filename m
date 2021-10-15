Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AD042FD0B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 22:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbhJOUjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 16:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243008AbhJOUjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 16:39:21 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A706DC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 13:37:14 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id w10so25539466ybt.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 13:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z2Z6TcutLquQxgwJbTrOGD74JMdndTacT9sFEHD/Z2k=;
        b=KNtfYJP0iOHu3iO5mE49+6U3MFrK+J/qy6VSm54pBpTJjZAv9c9KQuqCRaeyG1mKG6
         z6fye6KdQtdHTDVqNFBnm7EUCVgnRfhhR6NzdeSYZEQ48roYJMN+NrbJpQaUXCVE0rFt
         /LZgxiEbROnUd1uVvmtDtSnWbST9qUAEGJpxgcvz+KJYPB1/EP73cS3h+qJLKSJE/pfI
         g5FIGDlhk5c/iqX0FvuJIYW5Sewq0P/ZpPPnfPCA40LvAdLy7V8GBWYX3NMo6vaZRPiU
         /2RZL3tbDetA0H0dAqFJNagvRyI1OsKEMbqRG3Nt9UpLs9DJUjkcD24M0wsbHnTJPBzR
         TrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z2Z6TcutLquQxgwJbTrOGD74JMdndTacT9sFEHD/Z2k=;
        b=K1/EFN2/6tzjPwCg6XwIKZOFmqy6sjeJ4KCvQF5YucKCHWtzqy809ndboRgTcbJEPz
         XDdZX3Fa19qVqbXuMsPVJgSFAk8OK6VBSxThE5JKfbjLZpjNxOv8u3gmbERjcOHtV8sp
         OBLNRZ4tuKNcJsHQlLLScklUfu4QRCFEoQ+B6ro7I3LGbDhfrG6h2jzwM4XSzd5UsuYg
         VmpBljB24WMn8SzOQUNTGbLoC4Sa9wZ/xYMyH2JoPPO4QZ4fezXa3uFuIhzPmhLEQDY4
         M3TilxvjzQZPRC6wmBtnRXAyrqnUJgVbSjHOPn2tF6lqOMiWRqzBDDs1CbA2bipKRRt7
         03Bw==
X-Gm-Message-State: AOAM532mKGmhFCnA8Ytios9QGEpzw3TjsrsLsyTLItVrQCSjqZExpoyp
        HwQZpWaREJl2WneBSaH82socpIneSa3T6vRgfd7rYw==
X-Google-Smtp-Source: ABdhPJx//mMGXISTjk7mPjmp+nL7+HmtFu3RdAymL5KcUIurwLGvimpIQvqSqvpEt1z+H5sVWnAUKpHotfH6PfQ5zMg=
X-Received: by 2002:a25:1c45:: with SMTP id c66mr16404021ybc.133.1634330233565;
 Fri, 15 Oct 2021 13:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-4-samitolvanen@google.com> <7377e6b9-7130-4c20-a0c8-16de4620c995@www.fastmail.com>
 <8735p25llh.ffs@tglx> <87zgra41dh.ffs@tglx> <CABCJKuc+mN4vw_sanZQKcb1=SyfT4h3JK2wpBuaB2qZH3Croxg@mail.gmail.com>
 <ecbe49c8-b30b-456c-931a-cc65647b0958@www.fastmail.com>
In-Reply-To: <ecbe49c8-b30b-456c-931a-cc65647b0958@www.fastmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 15 Oct 2021 13:37:02 -0700
Message-ID: <CABCJKucuun-n8w3=U6i43kVGkCgYL7kmz5wx8nYxsxUOCfzBFw@mail.gmail.com>
Subject: Re: [PATCH v5 03/15] linkage: Add DECLARE_NOT_CALLED_FROM_C
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 12:36 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Fri, Oct 15, 2021, at 11:42 AM, Sami Tolvanen wrote:
> >>   https://lore.kernel.org/lkml/alpine.LFD.2.00.1001251002430.3574@loca=
lhost.localdomain/
> >>
> >> That said, I still want to have a coherent technical explanation why t=
he
> >> compiler people cannot come up with a sensible annotation for these
> >> things.
> >
> > I can only assume they didn't think about this specific use case.
>
> I must be missing something here.  Linux is full of C-ABI functions imple=
mented in asm.  Just off of a quick grep:
>
> asm_load_gs_index, memset, memmove, basically everything in arch/x86/lib/=
*.S
>
> If they're just declared and called directly from C, it should just work.=
  But an *indirect* call needs some sort of special handling.  How does thi=
s work in your patchset?

Making indirect calls to functions implemented in assembly doesn't
require special handling. The type is inferred from the C function
declaration.

> Then we get to these nasty cases where, for some reason, we need to expli=
citly grab the actual entry point or we need to grab the actual literal add=
ress that we can call indirectly.  This might be alternative_call, where we=
're trying to be fast and we want to bypass the CFI magic because, despite =
what the compiler might try to infer, we are doing a direct call (so it can=
't be the wrong address due a runtime attack, ENDBR isn't needed, etc).  An=
d I can easily believe that the opposite comes to mind.  And there are thin=
gs like exception entries, where C calls make no sense, CFI makes no sense,=
 and they should be totally opaque.

Correct, this is the main issue we're trying to solve. For low-level
entry points, we want the actual symbol address instead of the CFI
magic, both because of performance and because CFI jump tables may not
be mapped into memory with KPTI. Using an opaque type cleanly
accomplishes the goal for symbols that are not callable from C code.

> So I tend to think that tglx is right *and* we need an attribute, because=
 there really are multiple things going on here.
>
> SYM_FUNC_START(c_callable_func)
>   ...
>   ret
> SYM_FUNC_END
>
> extern __magic int c_callable_func(whatever);
>
> Surely *something* needs to go where __magic is to tell the compiler that=
 we have a function that wasn't generated by a CFI-aware compiler and that =
it's just a C ABI function.  (Or maybe this is completely implicit?  I can'=
t keep track of exactly which thing generates which code in clang CFI.)

This is implicit. Nothing is needed for this case.

> But we *also* have the read-the-address thing:
>
> void something(void)
> {
>   /* actual C body */
> }
> alternative_call(something, someotherthing, ...);
>
> That wants to expand to assembly code that does:
>
> CALL [target]
>
> where [target] is the actual first instruction of real code and not a CFI=
 prologue.

Yes, here we would ideally want to avoid the CFI stub for better
performance, but nothing actually breaks even if we don't.

> Or, inversely, we want:
>
> void (*ptr)(void) =3D something;
>
> which (I presume -- correct me if I'm wrong) wants the CFI landing pad.  =
It's not the same address.

Correct.

> And this all wants to work both for asm-defined functions and C-defined f=
unctions.  This really is orthogonal to the is-it-asm-or-is-it-C things.  A=
ll four combinations are possible.
>
> Does this make any sense?  I kind of thing we want the attributes and the=
 builtin, along the lines of:
>
> asm("call %m", function_nocfi_address(something));
>
> or however else we wire it up.
>
> (And, of course, the things that aren't C functions at all, like exceptio=
n entries, should be opaque.)

I agree, there are cases where having a function attribute and/or a
built-in to stop the compiler from interfering would be useful. I'll
dust off my patch series and see how the LLVM folks feel about it.

Sami
