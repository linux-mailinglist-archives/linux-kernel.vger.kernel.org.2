Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26D93B6AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 00:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbhF1WFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 18:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbhF1WEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 18:04:55 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C611C061760
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 15:02:02 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bp27so10307498lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 15:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ld79rQjtbYJbqjVTRO7UGOY87DxJGaKTkW2E/mZ4R2E=;
        b=oXcIv1+b+m9nbsVkXvnzrqE+QwQ8K7cAqnnEfCLXqwKwo46GbdBo0Jbtr2xL2/4Cv+
         f1Lt1uUN6P2zm1We42Y7JAitJef2yT9p6/glCnsvVBKc4iuu3ZzfvP8FiQm1NVBoBhd4
         iRBwn9itICpvIhr9v+19p0hdpzGwCgDddI0nG1y7Kz01W3JKg1LzJNfSx9y8SgyDe1Ms
         EdkYtHCZwNpTMvWNj84Qem5M+Zlji3frczx8gW8IEcDfuw3gphxI1ohtjVAGgs/p/M1Q
         tt4clc2XU9IQY5u+zJAZOup23nZ8hkOQgVQSuY/CqFiVYewWgrPlTd1v8S9MRAQ7o4aw
         TjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ld79rQjtbYJbqjVTRO7UGOY87DxJGaKTkW2E/mZ4R2E=;
        b=HO9NA0plnskiKG72fia4yw77FE7fldyT+YfcC4cq+rdTFvurEkHyX2h87Lx0qO5Dxf
         kivuubzu5SXQnWqgRcWDRBugXBU+mWVf5W9fAryuIJTsKZEoSNOU4cM5mJWmDABIEgz8
         AAngUqVB+2i+aWTOcKQIIOiD3whtmm4vksB27UqApcNAqPVyRUHZuzLBO5e8RSXxzURH
         7+o38NzjVHwDeq+iYMQaGTAyKM9tn0Z1i1URP9bum44f4R8FuwtG9ygwfA09k3SeADDf
         fSxEfVpxK5cgiH2qVkBRJe6mp1sYskFodZ1+GtVLim3JkizhNYElKzo+7Xs4J++jKDSM
         +IRw==
X-Gm-Message-State: AOAM530+tcm2ROfp3o77WtHKlqw+mOgMnO0V7xNbCwYIlF76+H7g8Vau
        XfJiRwPXo9cjl5+GFcRRSsj1xMlEG+HqXwh3uBm90w==
X-Google-Smtp-Source: ABdhPJzlY9YJ1zRH+7oS6WkPRdxcTlJ0sfvinym2ogxMsBEcjk5Gy8TS0jvoLHc9krnbrO4CyebeuqSrZBdM/zuRYjc=
X-Received: by 2002:a05:6512:3884:: with SMTP id n4mr20321135lft.547.1624917720175;
 Mon, 28 Jun 2021 15:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <a970613b-014f-be76-e342-4a51e792b56d@kernel.org>
 <20210628203109.2501792-1-ndesaulniers@google.com> <YNo8+PWPu5ssAcau@archlinux-ax161>
In-Reply-To: <YNo8+PWPu5ssAcau@archlinux-ax161>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Jun 2021 15:01:48 -0700
Message-ID: <CAKwvOdks4o8A1o7Q49Pa43ZyY5Zh6+s-u67FL-fp=16FP-Y7yw@mail.gmail.com>
Subject: Re: [PATCH v3] kallsyms: strip LTO suffixes from static functions
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>, "KE . LI" <like1@oppo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 2:20 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Jun 28, 2021 at 01:31:06PM -0700, Nick Desaulniers wrote:
> > Similar to:
> > commit 8b8e6b5d3b01 ("kallsyms: strip ThinLTO hashes from static
> > functions")
> >
> > It's very common for compilers to modify the symbol name for static
> > functions as part of optimizing transformations. That makes hooking
> > static functions (that weren't inlined or DCE'd) with kprobes difficult.
> >
> > LLVM has yet another name mangling scheme used by thin LTO.  Strip off
> > these suffixes so that we can continue to hook such static functions.
> >
> > Reported-by: KE.LI(Lieke) <like1@oppo.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Changes v2 -> V3:
> > * Un-nest preprocessor checks, as per Nathan.
> >
> > Changes v1 -> v2:
> > * Both mangling schemes can occur for thinLTO + CFI, this new scheme can
> >   also occur for thinLTO without CFI. Split cleanup_symbol_name() into
> >   two function calls.
> > * Drop KE.LI's tested by tag.
> > * Do not carry Fangrui's Reviewed by tag.
> > * Drop the inline keyword; it is meaningless.
> >  kernel/kallsyms.c | 32 +++++++++++++++++++++++++++++---
> >  1 file changed, 29 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 4067564ec59f..143c69e7e75d 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -171,6 +171,26 @@ static unsigned long kallsyms_sym_address(int idx)
> >       return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
> >  }
> >
> > +#ifdef CONFIG_LTO_CLANG_THIN
> > +/*
> > + * LLVM appends a suffix for local variables that must be promoted to global
> > + * scope as part of thin LTO. foo() becomes foo.llvm.974640843467629774. This
> > + * can break hooking of static functions with kprobes.
> > + */
> > +static bool cleanup_symbol_name_thinlto(char *s)
> > +{
> > +     char *res;
> > +
> > +     res = strstr(s, ".llvm.");
> > +     if (res)
> > +             *res = '\0';
> > +
> > +     return res != NULL;
> > +}
> > +#else
> > +static bool cleanup_symbol_name_thinlto(char *s) { return false; }
> > +#endif /* CONFIG_LTO_CLANG_THIN */
> > +
> >  #if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
> >  /*
> >   * LLVM appends a hash to static function names when ThinLTO and CFI are
> > @@ -178,7 +198,7 @@ static unsigned long kallsyms_sym_address(int idx)
> >   * This causes confusion and potentially breaks user space tools, so we
> >   * strip the suffix from expanded symbol names.
> >   */
> > -static inline bool cleanup_symbol_name(char *s)
> > +static bool cleanup_symbol_name_thinlto_cfi(char *s)
> >  {
> >       char *res;
> >
> > @@ -189,8 +209,14 @@ static inline bool cleanup_symbol_name(char *s)
> >       return res != NULL;
> >  }
> >  #else
> > -static inline bool cleanup_symbol_name(char *s) { return false; }
> > -#endif
> > +static bool cleanup_symbol_name_thinlto_cfi(char *s) { return false; }
> > +#endif /* CONFIG_CFI_CLANG && CONFIG_LTO_CLANG_THIN */
> > +
> > +static bool cleanup_symbol_name(char *s)
> > +{
> > +     return cleanup_symbol_name_thinlto(s) &&
> > +             cleanup_symbol_name_thinlto_cfi(s);
> > +}
> >
> >  /* Lookup the address for this symbol. Returns 0 if not found. */
> >  unsigned long kallsyms_lookup_name(const char *name)
> > --
> > 2.32.0.93.g670b81a890-goog
> >
>
> Is there any reason that we cannot eliminate the stubs and combine the
> functions, or am I missing something? Completely untested diff.
>
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index c851ca0ed357..014b59ad68a3 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -161,26 +161,36 @@ static unsigned long kallsyms_sym_address(int idx)
>         return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
>  }
>
> -#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
> -/*
> - * LLVM appends a hash to static function names when ThinLTO and CFI are
> - * both enabled, i.e. foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
> - * This causes confusion and potentially breaks user space tools, so we
> - * strip the suffix from expanded symbol names.
> - */
> -static inline bool cleanup_symbol_name(char *s)
> +static inline bool cleanup_symbol_name_thinlto(char *s)

Drop inline while touching this line.

>  {
>         char *res;
>
> -       res = strrchr(s, '$');
> +       if (!IS_ENABLED(CONFIG_LTO_CLANG_THIN))
> +               return false;
> +
> +       /*
> +        * LLVM appends a suffix for local variables that must be promoted to global
> +        * scope as part of ThinLTO. foo() becomes foo.llvm.974640843467629774. This
> +        * can break hooking of static functions with kprobes.
> +        */
> +       res = strstr(s, ".llvm.");
>         if (res)
>                 *res = '\0';

Sure, this is nicer though within the true block we should `return
true;` early rather than additionally check the $ mangling, I suppose.

>
> +       /*
> +        * LLVM appends a hash to static function names when ThinLTO and CFI are
> +        * both enabled, i.e. foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
> +        * This causes confusion and potentially breaks user space tools, so we
> +        * strip the suffix from expanded symbol names.
> +        */
> +       if (IS_ENABLED(CONFIG_CFI_CLANG)) {
> +               res = strrchr(s, '$');
> +               if (res)
> +                       *res = '\0';
> +       }
> +
>         return res != NULL;
>  }
> -#else
> -static inline bool cleanup_symbol_name(char *s) { return false; }
> -#endif
>
>  /* Lookup the address for this symbol. Returns 0 if not found. */
>  unsigned long kallsyms_lookup_name(const char *name)
> @@ -195,7 +205,7 @@ unsigned long kallsyms_lookup_name(const char *name)
>                 if (strcmp(namebuf, name) == 0)
>                         return kallsyms_sym_address(i);
>
> -               if (cleanup_symbol_name(namebuf) && strcmp(namebuf, name) == 0)
> +               if (cleanup_symbol_name_thinlto(namebuf) && strcmp(namebuf, name) == 0)
>                         return kallsyms_sym_address(i);
>         }
>         return module_kallsyms_lookup_name(name);



-- 
Thanks,
~Nick Desaulniers
