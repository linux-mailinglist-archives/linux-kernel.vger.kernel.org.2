Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72494405BA9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 19:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbhIIRDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 13:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240716AbhIIRC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 13:02:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD33C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 10:01:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g22so3557784edy.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZAGO3iBrhQAq7cxABN7v0YxXWtGf0YiblsBwMfWyrc=;
        b=OWJMz8LLr85sFM8RFy9k59A+OTyiaRWf0ZZ0n6Rcq7tOz8KHuQoirSrp+zkJs09eDI
         qXHOeRQalPKLdGml0NfQEcoEgcJ4RTyh7hAsLCSL/ndaFI7PDIP4NyPdrC6LqlqN47u+
         Tal0cn+jttYnbxNfFIYPgA5YVSh9fCfn1aRs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZAGO3iBrhQAq7cxABN7v0YxXWtGf0YiblsBwMfWyrc=;
        b=xSV6eYL8vD7lumN5ISeOVHpfalV8Zq7RjZWr4zN4Z5wiT6SUfcuCxSc1RcgcHum+sC
         M0+PzyrDsZFmGgqDIJkbV3VMrU2neUYibncbFm991JJy7JMR6aCg1vmof74O8mnsBdwF
         RuB8cXkHTjABauH3KLBm0QZI166GyyVbZYjBSOCpw1xIu3o1rsCG4v60kMc4Q3h+H44v
         meV6B+wjsEKiDolCfQSN6bl92rmvzG/UYms6jYP1u95VcWy4Hke+VtUB7T1hrBtUf16b
         bj3mkJW36QqiOsOis6kLvXkID9b/9jwHJWKg6YaOfZ7dNdEUDRvkpG4XQSd4X8K6PR0w
         4Sig==
X-Gm-Message-State: AOAM530PT6vnUW2YDOXSpWuBxbnUx6iti/Lmln5FtB3DnoKiob6UYdQZ
        tmGYeioEY1bepbIS1yJQXuGco+93qMYWXXEQqE4=
X-Google-Smtp-Source: ABdhPJz1ocXqvWwTxyGMqEXxZaXCktKYgc9UbgKtCmx4CnQrvvPTYN9PPOVS2ra5dLVpd5wrhDMH9Q==
X-Received: by 2002:aa7:c649:: with SMTP id z9mr4210636edr.304.1631206906192;
        Thu, 09 Sep 2021 10:01:46 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id i26sm895562edj.88.2021.09.09.10.01.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 10:01:46 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id q26so3537856wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 10:01:46 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr583246lfv.655.1631206431030;
 Thu, 09 Sep 2021 09:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain> <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161> <75a10e8b-9f11-64c4-460b-9f3ac09965e2@roeck-us.net>
 <YTkyIAevt7XOd+8j@elver.google.com> <YTmidYBdchAv/vpS@infradead.org>
 <CANpmjNNCVu8uyn=8=5_8rLeKM5t3h7-KzVg1aCJASxF8u_6tEQ@mail.gmail.com>
 <CAK8P3a1W-13f-qCykaaAiXAr+P_F+VhjsU-9Uu=kTPUeB4b26Q@mail.gmail.com> <CANpmjNPBdx4b7bp=reNJPMzSNetdyrk+503_1LLoxNMYwUhSHg@mail.gmail.com>
In-Reply-To: <CANpmjNPBdx4b7bp=reNJPMzSNetdyrk+503_1LLoxNMYwUhSHg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Sep 2021 09:53:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZqRFx6Oh8ZBer2THTMcjdbwZb5X3fCLBHmyuC9jPDhA@mail.gmail.com>
Message-ID: <CAHk-=wiZqRFx6Oh8ZBer2THTMcjdbwZb5X3fCLBHmyuC9jPDhA@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 4:43 AM Marco Elver <elver@google.com> wrote:
>
> Sure, but the reality is that the real stack size is already doubled
> for KASAN. And that should be reflected in Wframe-larger-than.

I don't think that's true.

Quite the reverse, in fact.

Yes, the *dynamic* stack size is doubled due to KASAN, because it will
cause much deeper callchains.

But the individual frames don't grow that much apart from compilers
doing stupid things (ie apparently clang and KASAN_STACK), and if
anything, the deeper dynamic call chains means that the individual
frame size being small is even *more* important, but we do compensate
for the deeper stacks by making THREAD_SIZE_ORDER bigger at least on
x86.

Honestly, I am not even happy with the current "2048 bytes for
64-bit". The excuse has been that 64-bit needs more stack, but all it
ever did was clearly to just allow people to just do bad things.

Because a 1kB stack frame is horrendous even in 64-bit. That's not
"spill some registers" kind of stack frame. That's "put a big
structure on the stack" kind of stack frame regardless of any other
issues.

And no, "but we have 16kB of stack and we'll switch stacks on
interrupts" is not an excuse for one single level to use up 1kB, much
less 2kB.  Does anybody seriously believe that we don't quite normally
have stacks that are easily tens of frames deep?

Without having some true "this is the full callchain" information, the
best we can do is just limit individual stack frames. And 2kB is
*excessive*.

                     Linus
