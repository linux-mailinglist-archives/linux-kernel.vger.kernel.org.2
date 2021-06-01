Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FC0397B08
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 22:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbhFAUQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 16:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbhFAUQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 16:16:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9E1C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 13:15:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o5so89805edc.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 13:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tP5u+ISjsaq73D6nmuIT4za8n4Lwg8QUjtoaeR5RI/0=;
        b=lN7/RTkgJyhf9kYPyCJDjPB5sCmzXRmv9rOXMYC5+ej6Bt6UY5Sgp2xt5dE9qGcxzi
         y4OHe/woE3IBYkNQxt2tSGzRbCReJtVUu+IAK0OWEZLR1nuUxju/Q4Tcvljvoc/YtT9K
         h+kz5sYLIg/juxxlgEKLdyd9vsLA+iAwEZdxhAgayYpbjo21K2agDc0BLU1M4hTXnBe/
         eIuljYdTNKs6Jwhi6P3HxhAMklGzpyneD5d4ZOD75SBwktw2UyvFsJkEU8sfGL2bAcMT
         fBpR96TaoO2BTekq4+ZXfHRMNYclLVPwkE5/Os+oupsRWNFXu8AgbPjAITBwgs5GNSiW
         jOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tP5u+ISjsaq73D6nmuIT4za8n4Lwg8QUjtoaeR5RI/0=;
        b=ja2i3s9wdah2xEf7aaXwfA8epDGkfNgrPlWZ1uNWAgqZ52Wa3wAj8kY+RTOlNSXKlZ
         jpvX5RPDWb9tsWcquNT0BT+9rsv7NmQ5R9BA4/y7GJ1ireu8cYCnIkqAtsbC/S+qbZ74
         pZkKgjsXn9SGgWqSmrg/eIm2ClBTJFp+l626HSmKlDUX88kj54WTaTUgrPjVS74dQg0H
         1UUvFY/2dSGJ5pzmpSRYH5TJwQjAlPIj+Y+yZ5q6Kmaq2r732nTS8/c4eGZ8uqKQzSHL
         J6LNCTWJJGCWrr4KKD3n/oI4/oZKaIihf3+J2tnCRAd9ir6pP2wQxA/B6rn1NX/OXWcj
         LTfw==
X-Gm-Message-State: AOAM530w2onZ1gCRmTDJdVE+aKn/3B1mPD6bASSoQRQbK9zJQy/eTaMB
        v9KaG48TkwRdKUPU9Z6dEq70sIPJ5OUgPBIwGk3x
X-Google-Smtp-Source: ABdhPJzDDvnI0vdoWVPtiDrS2m3G0MKm4Jfe9Uxc5PEZbi7O0fMlrnBTDIzquEjdljRPxovY/5vTWFY4cM2R7SRENv4=
X-Received: by 2002:aa7:c782:: with SMTP id n2mr34883171eds.77.1622578500766;
 Tue, 01 Jun 2021 13:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210601190541.1446239-1-keescook@chromium.org> <75a5aefd-084f-ef59-ceff-0f3856dcce71@kernel.org>
In-Reply-To: <75a5aefd-084f-ef59-ceff-0f3856dcce71@kernel.org>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 1 Jun 2021 13:14:49 -0700
Message-ID: <CAGG=3QV2HpVtBmm90dGdJqq-=Ygzp8FHc76Y7T06EB3pXsWYgQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Expand and relocate PGO entry
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 12:07 PM Nathan Chancellor <nathan@kernel.org> wrote:
> On 6/1/2021 12:05 PM, Kees Cook wrote:
> > This expands the "PGO" acronym and adds additional metadata to help have
> > patches get directed correctly.
> >
> > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Bill Wendling <wcw@google.com>
> > Cc: clang-built-linux@googlegroups.com
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Acked-by: Nathan Chancellor <nathan@kernel.org>
>
Acked-by: Bill Wendling <wcw@google.com>

> > ---
> > as seen in: https://lore.kernel.org/lkml/YLVRTilQ5k5n+Vmz@archlinux-ax161/
> > ---
> >   MAINTAINERS | 22 +++++++++++++---------
> >   1 file changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fd7d34fcd95c..2030cd9593cf 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4448,6 +4448,19 @@ T:     git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/cla
> >   F:  include/linux/cfi.h
> >   F:  kernel/cfi.c
> >
> > +CLANG PROFILE GUIDED OPTIMIZATION SUPPORT
> > +M:   Sami Tolvanen <samitolvanen@google.com>
> > +M:   Bill Wendling <wcw@google.com>
> > +M:   Kees Cook <keescook@chromium.org>
> > +R:   Nathan Chancellor <nathan@kernel.org>
> > +R:   Nick Desaulniers <ndesaulniers@google.com>
> > +L:   clang-built-linux@googlegroups.com
> > +S:   Supported
> > +B:   https://github.com/ClangBuiltLinux/linux/issues
> > +T:   git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/clang/features
> > +F:   Documentation/dev-tools/pgo.rst
> > +F:   kernel/pgo/
> > +
> >   CLEANCACHE API
> >   M:  Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> >   L:  linux-kernel@vger.kernel.org
> > @@ -14387,15 +14400,6 @@ S:   Maintained
> >   F:  include/linux/personality.h
> >   F:  include/uapi/linux/personality.h
> >
> > -PGO BASED KERNEL PROFILING
> > -M:   Sami Tolvanen <samitolvanen@google.com>
> > -M:   Bill Wendling <wcw@google.com>
> > -R:   Nathan Chancellor <nathan@kernel.org>
> > -R:   Nick Desaulniers <ndesaulniers@google.com>
> > -S:   Supported
> > -F:   Documentation/dev-tools/pgo.rst
> > -F:   kernel/pgo/
> > -
> >   PHOENIX RC FLIGHT CONTROLLER ADAPTER
> >   M:  Marcus Folkesson <marcus.folkesson@gmail.com>
> >   L:  linux-input@vger.kernel.org
> >
>
