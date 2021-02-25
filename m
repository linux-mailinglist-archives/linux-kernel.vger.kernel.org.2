Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9367D325870
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhBYVLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhBYVCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:02:04 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94431C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:01:17 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 2so3567134ljr.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bPn1CTU2aFElE/GlnQTS2oN7n5wO4Fs2imlJntYkTw=;
        b=EruuQTwqE3lqMBIPcITdvKno7SehJMpApPb/pZBloV8AeuWgS9dxXFa6S4CP4mZ8HL
         A+tb06UdX2iUYozJx3n+oi47NwcNF7GDkUne5DiViTr597HVoysxV3C7wouzWE2dOfcS
         cFzQSoYBl9ccSrQNoOMVsxd6sFLL30yoKSSan1RODGpFPCSnKGeM9vzneAVkuZlyLzRh
         cYK8t4kzn5/jw7C34l0RDZswrCnO0E+IFiGa3MppykDoLR3yPJNi6+R8sCfI6ZPLZHLH
         k/ey0/m9jFHolcEH1Zu8vZq+pEpIHLwFGCnk+82CvgzG8cfOeD2L1N521s91kcAU5Kry
         v6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bPn1CTU2aFElE/GlnQTS2oN7n5wO4Fs2imlJntYkTw=;
        b=TS3XS8RuiXwYS5phYocEvLFUjPxduRPuzDVffI32LOJijqW9KWLJSIXn3R0QebpP2B
         xtS1gL9ocO3WvIPI2zQvIkpSGSt40dNFGRETMdQ1ICxOzuAvwso00K1NuCaex8bbRlWj
         sJIKKPeeD0qo6TD6VBkE5MeZUqZwGcnoa+B+eMIabG/fXiB4lsr2BETl5cx7DIalwk34
         UUg26awsWZw3CKK7LAy1FshsYIz1ColT3Y9dX2ei4/qqdpJKEeWAVxbXTcQZjTld2TfA
         l69PR54c3i7bgRO1Q5PtlwU2txl3mJcUQmAJgz5oSOWPsXi4HuEIB5P7IDnttN9w2H6V
         ha0g==
X-Gm-Message-State: AOAM530gWMwFC2cGJkSpgbXOvLJuYt30OOdfgn5I7z4IC2yMG3LvjMhJ
        0rGZUrq4JoQsI//Ino8TcSqoqF0P+jzlfVcGv8/i6g==
X-Google-Smtp-Source: ABdhPJy7eeRazFH/rVJHDxRwOUgQEHaxudPSRiK9Via/RVV1Cb4qT+kTMEiqV0YlhjqK0Sfrlv9ZGlnDsn5I87Dwxis=
X-Received: by 2002:a05:651c:2112:: with SMTP id a18mr2618568ljq.341.1614286875687;
 Thu, 25 Feb 2021 13:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20210225164513.3667778-1-arnd@kernel.org> <202102251203.03762F77@keescook>
 <20210225120637.8e2a234f192952829fc5f471@linux-foundation.org>
In-Reply-To: <20210225120637.8e2a234f192952829fc5f471@linux-foundation.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Feb 2021 13:01:04 -0800
Message-ID: <CAKwvOdmHSgDMMgwowTWyvy4voyD_TtTY811jtKsZR+kUciittg@mail.gmail.com>
Subject: Re: [PATCH] linux/compiler-clang.h: define HAVE_BUILTIN_BSWAP*
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Marco Elver <elver@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:06 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 25 Feb 2021 12:03:48 -0800 Kees Cook <keescook@chromium.org> wrote:
>
> > On Thu, Feb 25, 2021 at 05:45:09PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Separating compiler-clang.h from compiler-gcc.h inadventently dropped the
> > > definitions of the three HAVE_BUILTIN_BSWAP macros, which requires falling
> > > back to the open-coded version and hoping that the compiler detects it.
> > >
> > > Since all versions of clang support the __builtin_bswap interfaces,
> > > add back the flags and have the headers pick these up automatically.
> > >
> > > This results in a 4% improvement of compilation speed for arm defconfig.
> > >
> > > Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Cc: stable@vger.kernel.org
>
> I figured 4% better compile time isn't significant enough to justify a
> backport.  Thoughts?

If I made a mistake in 815f0ddb346c, then it would be important to
correct it since 815f0ddb346c has existed for a few stable branches
(first landed in v4.19-rc1).
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
>


-- 
Thanks,
~Nick Desaulniers
