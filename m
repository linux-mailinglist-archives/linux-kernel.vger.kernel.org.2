Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D88E362A92
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbhDPVuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhDPVuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:50:01 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82B5C061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:49:35 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v72so10976518ybe.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KvvOpfTc4a7owgj9qx4TrZM/bIZMtNXq+vl9JoXOzqI=;
        b=nuw2AQJBvaPpIDkYxZ/NyiGn3Xw6BAmH4ZACrt503WkvveO2ZmrQs/l6tkL2yvPVOs
         ZfcRm33b3c9vz4ZxWDxFUqbT+sQQ6IsdNl+w3TxlNYqQsTT3RRW4HyOIZU5pSBODCmS7
         Q7lSFc+1pQ77Sf9LxHdw4amSSaWYCK8Zo7nZBvru2a8ueqopVz5Evp3DMTn7ugiyrIuq
         egnoGaWRynQP8dCEVHpHHJC4VP0ylIco0Aky6JicnvJXX0G0t3Jm1FOt4ySjIEGKPAmF
         vKKfcVX/FD245FrBxXtFFXQ5HqG63Xe+H9MLVOj8HV2l6oXmpR+Wo27tqSQHVtUg51t9
         /w0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KvvOpfTc4a7owgj9qx4TrZM/bIZMtNXq+vl9JoXOzqI=;
        b=ttF0EJdxJVj79J43D+ic2rLMwj5FaODDd1UjZLUOST9ssTUGNUKYQXzfY1qac5jMEu
         /lZh9Jf1bwlA3JmU8/UsP9jpyhntRG83RtNIsWtlA+OWBHU7Mvlc7VeygiMBiqOB0/Ek
         TLp48/gb+p/oM3q8b+ChWNckttvG1Uebr0r2WjXcy1QWMSsi9N0ZpxBqubV8+3E5QZ0c
         QYRGRt6t0DAdkEAci79/hTl7NFcq1m7gBafJypXdJPb/OzK/u063n8LLR5cBMvceQz9g
         UlysAZiVD4/Xb5KD57IQ5ZWrm79CZ0aens79iQoCkQ52TpW1QRtTVMnzz5HXUzEAKYGp
         g67w==
X-Gm-Message-State: AOAM533WUIjK0pVuCpa3Wj72R+1bxY/pudK2tuYxV2DKPewfYnbPhjrD
        eBZKJ6c5RfhlgyLzEjZy2x9DrbNDyGTaV7+wG7vPlg==
X-Google-Smtp-Source: ABdhPJyGYpjOg00219ebxlH56/gPiRksAFiaDeydaENh/F85nsRvUUalNMPmatmdM4Yz8VaiLMg3G0Bt7IjUko3hY/U=
X-Received: by 2002:a25:7085:: with SMTP id l127mr1733643ybc.293.1618609774803;
 Fri, 16 Apr 2021 14:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com> <20210416211855.GD22348@zn.tnic>
In-Reply-To: <20210416211855.GD22348@zn.tnic>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 16 Apr 2021 14:49:23 -0700
Message-ID: <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
To:     Borislav Petkov <bp@alien8.de>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 2:18 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Apr 16, 2021 at 01:38:34PM -0700, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG, the compiler replaces function addresses in
> > instrumented C code with jump table addresses. This change implements
> > the function_nocfi() macro, which returns the actual function address
> > instead.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/x86/include/asm/page.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
> > index 7555b48803a8..5499a05c44fc 100644
> > --- a/arch/x86/include/asm/page.h
> > +++ b/arch/x86/include/asm/page.h
> > @@ -71,6 +71,20 @@ static inline void copy_user_page(void *to, void *fr=
om, unsigned long vaddr,
> >  extern bool __virt_addr_valid(unsigned long kaddr);
> >  #define virt_addr_valid(kaddr)       __virt_addr_valid((unsigned long)=
 (kaddr))
> >
> > +#ifdef CONFIG_CFI_CLANG
>
> Almost every patch is talking about this magical config symbol but it
> is nowhere to be found. How do I disable it, is there a Kconfig entry
> somewhere, etc, etc?

As I mentioned in the cover letter, this series is based on
linux-next. I forgot to include a link to the original patch series
that adds CONFIG_CFI_CLANG, but I'll be sure to point to it in the
next version. Sorry about the confusion.

> > +/*
> > + * With CONFIG_CFI_CLANG, the compiler replaces function address
> > + * references with the address of the function's CFI jump table
> > + * entry. The function_nocfi macro always returns the address of the
> > + * actual function instead.
> > + */
> > +#define function_nocfi(x) ({                                         \
> > +     void *addr;                                                     \
> > +     asm("leaq " __stringify(x) "(%%rip), %0\n\t" : "=3Dr" (addr));   =
 \
> > +     addr;                                                           \
> > +})
>
> Also, eww.
>
> It seems all these newfangled things we get, mean obfuscating code even
> more. What's wrong with using __nocfi instead? That's nicely out of the
> way so slap that in front of functions.

__nocfi only disables CFI checking in a function, the compiler still
changes function addresses to point to the CFI jump table, which is
why we need function_nocfi().

> Also, did you even build this on, say, 32-bit allmodconfig?
>
> Oh well.
>
> In file included from ./include/linux/ftrace.h:22:0,
>                  from ./include/linux/init_task.h:9,
>                  from init/init_task.c:2:
> ./include/linux/ftrace.h: In function =E2=80=98ftrace_init_nop=E2=80=99:
> ./arch/x86/include/asm/ftrace.h:9:40: error: implicit declaration of func=
tion =E2=80=98function_nocfi=E2=80=99 [-Werror=3Dimplicit-function-declarat=
ion]

This is defined in linux-next, but I do see another issue, which I'll
fix in v2. Note that CFI_CLANG itself cannot be selected on 32-bit
x86.

Sami
