Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1265C440B6C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 21:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhJ3TKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 15:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhJ3TKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 15:10:38 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC6AC061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 12:08:08 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id d10so22412126ybe.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 12:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CD2RlII1WVp7MOTRa0mnhnUU9/NjsujY0FdiDhkiMRE=;
        b=qCPIOU9GxvfXvw4Mc7xnO0zT6yYKxzP06wsu9k2jfBIXScVg+Gxs6fIBAcHlQN0W2I
         rpD5DKkZgZ5p1g3scnrPOtX14ePFwPafNmX5Un0wQ5Y1+3438LQOYwKRNoP7HapoEJrf
         NnK7FOZGPnXclhkL6Hu2phBIrp9Ar6/+nlPhZjJH3wk1r3bITWiJbnWzInqmCadSY6dw
         qfc3L3PtHfX1a66ZKnAueG5cDhofYtawaZxeUqfzCg3G0q/UmBbUVuSJPTkI0ZpmRcHb
         Z8w0d9HY5hWtFj4zgGOkTCI9wUxi1vp9lf4jnLL+pV/HApMRaFYtdf6oNvUjvz17+uvL
         5p0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CD2RlII1WVp7MOTRa0mnhnUU9/NjsujY0FdiDhkiMRE=;
        b=0y8bXY0yqUmQGXwzO28dAsRB79OsyaWoMt3L5fdvTbRiSyzS+E7kXQhj8zd+Y7wW+p
         62eOHEIrwvDYooRAC5it45uvzGvNPqsY9d+cm91v/lx+23WzKCtTRLf+ZR+jKrFJZFi5
         QyjmpQyVzjdc0bFaY6WdAIpm22EnoDV7B5DDlnxWWj5idB6iOaj7VF7GGAvzHVFPWwFv
         snuvdaWFCEbJYivxxRGirVgb6LJrA9Jy1rLEE5S0ciFSyclS/6/pMbcNtjC3CrD/Fay8
         7FfYiGfsKbvi8Xl6lX3igqiQUfr8jQKhOaf82n4uQv7VUTYTGSSxl9BR+DHGI/RhC0zm
         OB3w==
X-Gm-Message-State: AOAM5310xRxqWcTPV1CrJpiji0OzNHEVnJIg1c5aRY/brM6qqJ1j2Fca
        SNsjhyj8EaqeHrv1eDbn4avFxD5ywCg5ptTi9ykfhQ==
X-Google-Smtp-Source: ABdhPJwCorOhaxiBsJrc7khwbBYNrQ8KwuFb6kQY80aUD8a35DXRG6noMdVjde3oMFCxOrugnlKMPA0CbEY8fahkgVE=
X-Received: by 2002:a25:2d66:: with SMTP id s38mr1787157ybe.527.1635620886905;
 Sat, 30 Oct 2021 12:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local> <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net> <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
 <YXlcMluaysPBF92J@hirez.programming.kicks-ass.net> <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
 <CABCJKufpS4jJxHqk8=bd1JCNbKfmLDKBbjbhjrar2+YQJFiprg@mail.gmail.com> <20211029200324.GR174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211029200324.GR174703@worktop.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Sat, 30 Oct 2021 12:07:56 -0700
Message-ID: <CABCJKudsK9cLx90yAUVE07fTSqt605fmmK=tOU2zPgggz-M-QA@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 1:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 27, 2021 at 08:50:17AM -0700, Sami Tolvanen wrote:
> > On Wed, Oct 27, 2021 at 7:18 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > > > /*
> > > >  * Turns a Clang CFI jump-table entry into an actual function pointer.
> > > >  * These jump-table entries are simply jmp.d32 instruction with their
> > > >  * relative offset pointing to the actual function, therefore decode the
> > > >  * instruction to find the real function.
> > > >  */
> > > > static __always_inline void *nocfi_ptr(void *func)
> > > > {
> > > >         union text_poke_insn insn = *(union text_poke_insn *)func;
> > > >
> > > >         return func + sizeof(insn) + insn.disp;
> > > > }
> > > >
> > > > But really, that wants to be a compiler intrinsic.
> > >
> > > Agreed. We could easily do something similar on arm64, but I'd prefer
> > > to avoid that too.
> >
> > I'll see what we can do. Note that the compiler built-in we previously
> > discussed would have semantics similar to function_nocfi(). It would
> > return the raw function address from a symbol name, but it wouldn't
> > decode the address from an arbitrary pointer, so this would require
> > something different.
>
> So I had a bit of a peek at what clang generates:
>
>     3fa4:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        3fa7: R_X86_64_32S      __SCK__x86_pmu_handle_irq
>     3fab:       48 c7 c6 00 00 00 00    mov    $0x0,%rsi        3fae: R_X86_64_32S      __SCT__x86_pmu_handle_irq.cfi_jt
>     3fb2:       e8 00 00 00 00          call   3fb7 <init_hw_perf_events+0x1dc> 3fb3: R_X86_64_PLT32    __static_call_update-0x4
>
> So this then gives the trampoline jump table entry to
> __static_call_update(), with the result that it will rewrite the
> jump-table entry, not the trampoline!
>
> Now it so happens that the trampoline looks *exactly* like the
> jump-table entry (one jmp.d32 instruction), so in that regards it'll
> again 'work'.

Ugh, good catch!

> But this is all really, as in *really*, wrong. And I'm really sad I'm
> the one to have to discover this, even though I've mentioned
> static_call()s being tricky in previous reviews.

My bad, I didn't realize Clang does this with a typeof(func)
declaration. I'll make sure we have a reasonable fix for this before
the next version.

Sami
