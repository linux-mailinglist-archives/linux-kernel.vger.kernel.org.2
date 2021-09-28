Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EB541B662
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 20:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242416AbhI1Sex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 14:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232723AbhI1SeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:34:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26B8A6137D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 18:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632853944;
        bh=2Cj4UNam1DG/TfnGcPZjXfeZcarvPrxFJFfENW16COM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c8vbNT1bkHV+TQ5VOlKOa9e/ZAIcGImKnfw1tcmr8ToDLZEnD/E75J4DbFrCrfbyq
         YR1AsYOFD8+X+absvEesJKUW4ncKI2jQ3ixy7r2Jg58tlZ5svSHuPl5pI4OqfJhYpU
         VOysgQWo+o3F/pgJDc9pgz1ds0AocRKtColKM73AzFQfV7tLWOhsB97nnwxClbr6PT
         jMagx1rZbYuGrepZjJpJtkLvwX0Apm3g5o6NN34XEoDJxxs9Fl2+GxlJ6Abm1oYLS4
         hyHOdrJz0KN66oale8aRrIGDuqsIom7cjKvciNxnff+NYYglNoI3OY7L3lg7IWftSD
         x4pOjC2DfaiNw==
Received: by mail-wm1-f52.google.com with SMTP id b192-20020a1c1bc9000000b0030cfaf18864so3441171wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 11:32:24 -0700 (PDT)
X-Gm-Message-State: AOAM532nNwndALSGEPkdu9towKDSwEzwGvwvJ8vipCjwAu/L4wqUnDqp
        BUrHo/IxqYgwAooGBPK5lPKp6AFJS8LsrKgCEqY=
X-Google-Smtp-Source: ABdhPJz5lXy16llMMIxh4I9yEJ3Nc4i+amXIzKy8vDqbZxLLeY1Q7PxyhFCr40sDfwHjtg+ieWuoDrHvhyA9PGSC1Oc=
X-Received: by 2002:a1c:7413:: with SMTP id p19mr6359970wmc.98.1632853942677;
 Tue, 28 Sep 2021 11:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210928154143.2106903-1-arnd@kernel.org> <20210928154143.2106903-14-arnd@kernel.org>
 <CAKwvOd=U1PpmHk0emq23FhQyAv5YyOr9SOMkQ8d-q=uL=uebhg@mail.gmail.com>
In-Reply-To: <CAKwvOd=U1PpmHk0emq23FhQyAv5YyOr9SOMkQ8d-q=uL=uebhg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 28 Sep 2021 20:32:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2LezhdCczGsgWrrkShvowXMYSSdhfPJqSHwHEBRv4PvQ@mail.gmail.com>
Message-ID: <CAK8P3a2LezhdCczGsgWrrkShvowXMYSSdhfPJqSHwHEBRv4PvQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] ARM: use .arch directives instead of assembler
 command line flags
To:     Nick Desaulniers <ndesaulniers@google.com>
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

On Tue, Sep 28, 2021 at 7:10 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Sep 28, 2021 at 8:42 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Similar to commit a6c30873ee4a ("ARM: 8989/1: use .fpu assembler
> > directives instead of assembler arguments").
> >
> > GCC and GNU binutils support setting the "sub arch" via -march=,
> > -Wa,-march, target function attribute, and .arch assembler directive.
> >
> > Clang's integrated assembler does not support -Wa,-march (and the logic
> > to overrule one when multiple of the above are used), and this can
> > cause annoying warnings such as:
> >
> > clang: warning: argument unused during compilation: '-march=armv6k' [-Wunused-command-line-argument]
> > clang: warning: argument unused during compilation: '-march=armv6k' [-Wunused-command-line-argument]
> > clang: warning: argument unused during compilation: '-march=armv6k' [-Wunused-command-line-argument]
>
> Note, the above lack of support was fixed in clang-13. That said, both
> Clang and GCC defer to -Wa,-march when -march is also present, so
> clang is still correct that -march is ignored.  Thanks for resending;
> this is still helpful for earlier releases of clang that we still
> support.

The -Wunused-command-line-argument warning also caused a build
failure for me when building with 'make W=1', and I think there are
cases where the flags from the command line are contradictory.

Isn't the patch also needed for LTO? All I know is that with this
applied it all builds, but without it I run into link failures. I can dig
more into the specific failures, but overall I think this is the right
thing to do anyway.

       Arnd
