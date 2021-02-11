Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9413192D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhBKTGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhBKTGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:06:11 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2B3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 11:05:30 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id x10so1536456oor.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 11:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDFyBCzQ/w2scwnDR1KimaJyc5DX1XbezjKjDgGDDbI=;
        b=lhYmgLGac7wmXlVRa/6bLo+0VEueioiEtkv/vVz6DcqJItDRHXzciz9m65j/LLRHT0
         3WmgvFZgXU3j2FRW9+LZOXG9uqAFkxn2Hna1snamNLuTwNvlGcZW5DmclfUf873Nuzoi
         NyWHTQIgCKToMlzv16dA1kUbxBf5EpWup+ecfK2Kl9SmVdCSQrQVTrqt52at/CYZj1TQ
         5CN2uPlg3ZMc2AWNtMnPonR6fWyMCt1f9zWHpbHVZENY1ZCzgopsAlBr92uffD+DNLqk
         x2Ll/jfLQOlflp0ABYekv41e3SbosuBoxPSe1qLFIlAfsFKgJ5zjs1er5NfdeJ70gNE4
         gk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDFyBCzQ/w2scwnDR1KimaJyc5DX1XbezjKjDgGDDbI=;
        b=UiEABLEjQCe8Nw+Ps/PL5CMuRBudK9F+qVQKDb0HK9VW8y9tDYgOnfyzMFuXEfPao6
         az6TiujYGRH9FnxGsIZld7vLSniAOr7cf99+fJh3EiIVJUXKPuxSSn6O97+J2N5Eiy3h
         iDy6Uq5HVCuH2Fve/bjGhE8H21u+NjAa25qzJlQ0lcu+FzbgdUIj7xAPBI3yE7tFeorv
         4sNGf/IY4qdmR7TOuOf6irwqQh9YHBpqLI1vFdDAUQiLylw4EfYKv8mdXO1qTLGOPmpA
         G9tQTpqeeRWPofjXnK4vypBuB13k7p+mTzTnNzGFE7jvoYXW5d7aCHFQ42mdAz3vS+H6
         ywCQ==
X-Gm-Message-State: AOAM533nfL/aRCz3As2pCFNCJgOrMC2Js4NvA4oZEbdzkVoXE9w4qNxM
        d7XdzMfIsP70ZM5HxI7Orq6oEK+94p54yHO7jwc6TA==
X-Google-Smtp-Source: ABdhPJyxelri917MzvEngiUhcZHB1F+wc9j4NagfOTdpdF/oQ/3vOHyVUzKmx1jzu59+Qt2GT+p9bZnm9xi9+OZXl58=
X-Received: by 2002:a4a:a22a:: with SMTP id m42mr6474615ool.22.1613070329249;
 Thu, 11 Feb 2021 11:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20210211025149.3544593-1-ndesaulniers@google.com>
 <20210211025149.3544593-2-ndesaulniers@google.com> <CAMj1kXH9-1=o+UYU0sdKUF1YGDJYyLDvNKExzqkcrWzLB0NWwg@mail.gmail.com>
In-Reply-To: <CAMj1kXH9-1=o+UYU0sdKUF1YGDJYyLDvNKExzqkcrWzLB0NWwg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Feb 2021 11:05:17 -0800
Message-ID: <CAKwvOdkduHO357SPzwtN5TAaa_NnJtcJJ89BEe-50WFbRFDdUA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] ARM: kprobes: fix UNPREDICTABLE warnings
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Smith <peter.smith@arm.com>,
        Renato Golin <rengolin@systemcall.eu>,
        David Spickett <david.spickett@linaro.org>,
        "kernelci . org bot" <bot@kernelci.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 12:15 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 11 Feb 2021 at 03:52, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > GNU as warns twice for this file:
> > Warning: using r15 results in unpredictable behaviour
> >
> > via the Arm ARM:
> > K1.1.1 Overview of the constraints on Armv7 UNPREDICTABLE behaviors
> >
> >   The term UNPREDICTABLE describes a number of cases where the
> >   architecture has a feature that software must not use.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1271
> > Link: https://reviews.llvm.org/D95586
> > Reported-by: kernelci.org bot <bot@kernelci.org>
> > Suggested-by: Peter Smith <peter.smith@arm.com>
> > Suggested-by: Renato Golin <rengolin@systemcall.eu>
> > Suggested-by: David Spickett <david.spickett@linaro.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>
> But can we add a bit more context to the commit log, please? It is not

Sure, that's a good idea.

> obvious to the casual reader why it is OK to emit UNPREDICTABLE
> opcodes, i.e., that these are selftests that aim to ensure that kprobe
> never attempts to replace the opcodes in question with a probe, but
> that they are not actually executed, or expected to occur in real
> code.

I'll add:

Ard notes:
  These are selftests that aim to ensure that kprobe
  never attempts to replace the opcodes in question with a probe, but
  they are not actually executed, or expected to occur in real
  code.

to the commit message, when submitting to RMK's queue.

Thanks for taking a look and the feedback.

>
> > ---
> >  arch/arm/probes/kprobes/test-arm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/probes/kprobes/test-arm.c b/arch/arm/probes/kprobes/test-arm.c
> > index 977369f1aa48..2543106a203e 100644
> > --- a/arch/arm/probes/kprobes/test-arm.c
> > +++ b/arch/arm/probes/kprobes/test-arm.c
> > @@ -166,10 +166,10 @@ void kprobe_arm_test_cases(void)
> >
> >         /* Data-processing with PC as a target and status registers updated */
> >         TEST_UNSUPPORTED("movs  pc, r1")
> > -       TEST_UNSUPPORTED("movs  pc, r1, lsl r2")
> > +       TEST_UNSUPPORTED(__inst_arm(0xe1b0f211) "       @movs   pc, r1, lsl r2")
> >         TEST_UNSUPPORTED("movs  pc, #0x10000")
> >         TEST_UNSUPPORTED("adds  pc, lr, r1")
> > -       TEST_UNSUPPORTED("adds  pc, lr, r1, lsl r2")
> > +       TEST_UNSUPPORTED(__inst_arm(0xe09ef211) "       @adds   pc, lr, r1, lsl r2")
> >         TEST_UNSUPPORTED("adds  pc, lr, #4")
> >
> >         /* Data-processing with SP as target */
> > --
> > 2.30.0.478.g8a0d178c01-goog
> >



-- 
Thanks,
~Nick Desaulniers
