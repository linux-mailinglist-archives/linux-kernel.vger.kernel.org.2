Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63C141CB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345771AbhI2SN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344188AbhI2SN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:13:26 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC781C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:11:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x27so14271616lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=darTaYjh/HzMyOnQZo4wZWaaX6Bde0YYCPhfvHaUrC4=;
        b=Q4P6sp3wdghNEbGf/cF3WEhwYpEiQ35+J9c0qa+e+KsXULo4Xnfb5/yMjqGq/Voo3+
         Z73qml5kv2ZIgBWSHLD7bpBcV9p5TryY/8rOwBQtKD0yktFkB/GV2SYbXSxhd5EAvA6/
         VKGJe48DVz5ndJ6v5hoGZT96oemsZo4tJ2xWUFVUMxAcrl1gUcHCbAxOGL/yeM1mxWer
         RkRlVdrSUD7AU6OoCTHhYQS5erzpon0+9QpUBP7mF4hbuP11BNAwICkNjjb7D3jsADfZ
         1hpSVkhtQBZdYEX9hx4uUttMXVfUWZgMOqWBsguwtUiLCXlrwBS8NbB0WsxPzbwGgYeI
         LwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=darTaYjh/HzMyOnQZo4wZWaaX6Bde0YYCPhfvHaUrC4=;
        b=VAom4UxayJXr7oxxo4QgZIM2cd3CvYIdybE0WhGZX4dC+4Yxe58rHnlkBdS4sr6TI8
         ZmwP+wa11sCP/MbidMA+HaOUVevgPYSSj8BnXn7S6GhIlUchCa1KKFEx1p5jbPNteuZ7
         cYhzsb2XP4pNVoFApyMF1PjJGWNzgblIQk+eV/WxznY23W4n8wT++y41O0m3KtPjDMm8
         IHCrpks8zVXj/U47cuqKPzQsjCeojlhWBXmTkkmQo6H91s7wQGZG/4eg5nIpM4ys3ZzI
         MDDvRoXvdUrNLPp6j5UxJS7t5U3EyGTthjf1ezTV+zUFWAY/Qsd4IOZGPbPcMQbUxKf0
         qMWQ==
X-Gm-Message-State: AOAM530b5ZGzisrqyYa2WX4SVxZe1zA5fQSrhE4fjUk14ogwHP+1O+5Z
        sJ8uQ+k/ZUjMitXCwFZzvNkq/3omcRKZz4TlQGYqrg==
X-Google-Smtp-Source: ABdhPJxN54u9xbSV0C3aMd0CIrJSvkgSpBk2vNGMUMH0M9qShmYqr+8aTnA8ZwGpHeRQwIZzuyirqa0PgDbNbIKuaMQ=
X-Received: by 2002:a2e:5059:: with SMTP id v25mr1400586ljd.128.1632939102990;
 Wed, 29 Sep 2021 11:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210928154143.2106903-1-arnd@kernel.org> <20210928154143.2106903-14-arnd@kernel.org>
 <CAKwvOd=U1PpmHk0emq23FhQyAv5YyOr9SOMkQ8d-q=uL=uebhg@mail.gmail.com> <CAK8P3a2LezhdCczGsgWrrkShvowXMYSSdhfPJqSHwHEBRv4PvQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2LezhdCczGsgWrrkShvowXMYSSdhfPJqSHwHEBRv4PvQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 29 Sep 2021 11:11:31 -0700
Message-ID: <CAKwvOdnWFvs9aa3vrb+HiitPYV7camzQ8b4g64efh6AOGU6Wdg@mail.gmail.com>
Subject: Re: [PATCH 13/14] ARM: use .arch directives instead of assembler
 command line flags
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 11:32 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Sep 28, 2021 at 7:10 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Tue, Sep 28, 2021 at 8:42 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > From: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > > Similar to commit a6c30873ee4a ("ARM: 8989/1: use .fpu assembler
> > > directives instead of assembler arguments").
> > >
> > > GCC and GNU binutils support setting the "sub arch" via -march=,
> > > -Wa,-march, target function attribute, and .arch assembler directive.
> > >
> > > Clang's integrated assembler does not support -Wa,-march (and the logic
> > > to overrule one when multiple of the above are used), and this can
> > > cause annoying warnings such as:
> > >
> > > clang: warning: argument unused during compilation: '-march=armv6k' [-Wunused-command-line-argument]
> > > clang: warning: argument unused during compilation: '-march=armv6k' [-Wunused-command-line-argument]
> > > clang: warning: argument unused during compilation: '-march=armv6k' [-Wunused-command-line-argument]
> >
> > Note, the above lack of support was fixed in clang-13. That said, both
> > Clang and GCC defer to -Wa,-march when -march is also present, so
> > clang is still correct that -march is ignored.  Thanks for resending;
> > this is still helpful for earlier releases of clang that we still
> > support.
>
> The -Wunused-command-line-argument warning also caused a build
> failure for me when building with 'make W=1', and I think there are
> cases where the flags from the command line are contradictory.

There's also -Werror now, which is hurting allmodconfig builds.

> Isn't the patch also needed for LTO? All I know is that with this
> applied it all builds, but without it I run into link failures.

We don't support LTO on 32b ARM, yet.  I would be interested in
getting that support working.

>  I can dig
> more into the specific failures, but overall I think this is the right
> thing to do anyway.

I agree.  I was just adding additional context to the commit message
via my initial reply.
-- 
Thanks,
~Nick Desaulniers
