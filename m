Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1273231EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbhBWUML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbhBWUKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:10:54 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E79AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:10:14 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id e8so25781138ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ma6j2gSEFy1ka8BjM/M5fkCejmRsupkHNwcWTVj2T4E=;
        b=Nl7cOyBtfTdrP6UGznoXkBYxB0wTpXjOri61ZAWrS4HLaRDeByo1hbQEW4IYZf+rVT
         09F+0aDCEOjwW2FF4xWoaCiP9v1mQKxJUvYe7DbfCB0djrRi1ydx+CF65yu77CXAtk2D
         XyKNW9uUVCX2aagpdBrOf9oMzha5TF3h4v+m8+5ogMYoqs9lqsfUJRrzyKWskIGNvRlA
         ClGX1TAaOx7f90AmhPwAHpSPiPHF2fUBPuVo84HTrjrgNk7iY59OaZQhSxOJoGd2WSNz
         +8LfkFPBV3vZGPlFyGQgNaJKpCXn6YEc5lsLfAYm3QRCCGODap4q22oSVg5hrmkrPZP+
         MxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ma6j2gSEFy1ka8BjM/M5fkCejmRsupkHNwcWTVj2T4E=;
        b=kMul/zHuJ2IBQpotXsUFsmF5T9RDEo614q/7H4mnkyXfPlmHBYvusVAxO6DuNPMcFT
         Cb58Vgu53qRTbDpc5tG/oWOlgS0yEOmeRolv0ECbVqQLTCxiNm0PRXGhnTnx/BLXeQTx
         Fcn7RDTLK/W/Inv+yxn6TpIwBkPC05cvIAu7Q/a45NRhH7Gz/f9uROUNgGsEiaJ/rc0R
         Bv5B8BXNFj4WHWfJzXPsXqPIbJy1PQCs881N77EfBmKcIg+jRJ9BpysdWHaxJOiMCzoZ
         rJJWawjPYAwnPjVHxrSK3fT2ZhOHMSRpSIml7XibXYHAg/DnWo0nfp52Z/dxaem3Y/sQ
         1hlw==
X-Gm-Message-State: AOAM530xieXqNQsMRhxim9/b2EnWJlze7EL+UoePc/PnB7R6stsTjr1m
        w8pcrae9jnzLTsQ1kA3fUDbfdbc5EA5LmT1x0S9E5Q==
X-Google-Smtp-Source: ABdhPJz215ok2rJ4F+g+LxWLZNzv6ReaEYiGqshChgPpuuXofclZjDhLw4PFAF5f99gycg35saPqIcin14rAaD59ges=
X-Received: by 2002:a2e:2a83:: with SMTP id q125mr17502638ljq.244.1614111012374;
 Tue, 23 Feb 2021 12:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20210205220125.2931504-1-ndesaulniers@google.com> <CAK7LNARKHvjTcnic=ZKntH3NY5meehQbJuBr34y9_tn8b-Ym0w@mail.gmail.com>
In-Reply-To: <CAK7LNARKHvjTcnic=ZKntH3NY5meehQbJuBr34y9_tn8b-Ym0w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Feb 2021 12:10:01 -0800
Message-ID: <CAKwvOd=qh0=tU9fr60DxcJepUfg6+BkqScwifW4s8A2A=ofKpw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: reuse CC_VERSION_TEXT
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 5:49 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Feb 6, 2021 at 7:01 AM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > I noticed we're invoking $(CC) via $(shell) more than once to check the
> > version.  Let's reuse the first string captured in $CC_VERSION_TEXT.
> >
> > Fixes: 315bab4e972d ("kbuild: fix endless syncconfig in case arch Makefile sets CROSS_COMPILE")
>
>
> I did not touch this hunk because I have a plan
> for different refactoring, but I have never got
> around to do it.
>
> Anyway, you beat me, and I will pick this up.
> But, the Fixes tag is questionable because
> this is code refactoring.

Hi Masahiro,
A friendly reminder to please pick this up; I don't see it yet in
linux-next. I'm ok with you dropping the fixes tag when applied.

(Otherwise, I was about to use `grep -m1` instead of `| head -n1 | grep` here.)

>
>
>
>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  Makefile | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index a85535eb6a7d..70034d7c1051 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -557,7 +557,13 @@ ifdef building_out_of_srctree
> >         { echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
> >  endif
> >
> > -ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> > +# The expansion should be delayed until arch/$(SRCARCH)/Makefile is included.
> > +# Some architectures define CROSS_COMPILE in arch/$(SRCARCH)/Makefile.
> > +# CC_VERSION_TEXT is referenced from Kconfig (so it needs export),
> > +# and from include/config/auto.conf.cmd to detect the compiler upgrade.
> > +CC_VERSION_TEXT = $(shell $(CC) --version 2>/dev/null | head -n 1)
> > +
> > +ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
> >  ifneq ($(CROSS_COMPILE),)
> >  CLANG_FLAGS    += --target=$(notdir $(CROSS_COMPILE:%-=%))
> >  GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
> > @@ -576,12 +582,6 @@ KBUILD_AFLAGS      += $(CLANG_FLAGS)
> >  export CLANG_FLAGS
> >  endif
> >
> > -# The expansion should be delayed until arch/$(SRCARCH)/Makefile is included.
> > -# Some architectures define CROSS_COMPILE in arch/$(SRCARCH)/Makefile.
> > -# CC_VERSION_TEXT is referenced from Kconfig (so it needs export),
> > -# and from include/config/auto.conf.cmd to detect the compiler upgrade.
> > -CC_VERSION_TEXT = $(shell $(CC) --version 2>/dev/null | head -n 1)
> > -
> >  ifdef config-build
> >  # ===========================================================================
> >  # *config targets only - make sure prerequisites are updated, and descend
> > --


-- 
Thanks,
~Nick Desaulniers
