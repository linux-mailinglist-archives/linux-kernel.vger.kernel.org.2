Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367763BEFF8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhGGTCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 15:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhGGTCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:02:49 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FC4C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 12:00:08 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id i4so4828474ybe.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6yCm28WnoyNx3nRePoJett8yHbUw3QYAhUOWEwm4lQ=;
        b=hH6hFm63vuMyFoK8+hGoqoFO8Fh65M3Klc2NWtTh1joNH7eb4tJE3iBw/mwSt1cEYc
         PZ2HlWDO6gyMhGh6seGHoHog/c+KYZ2N4LvUOT4UQF2eljgD2EOE96jbjJvJplh3sC4q
         7x2+GYNtMCJADpdoVqcCSA45UjfeZrq1c/0qXNOrjVrY9XnxwlmpB1YZGAAgzAEeGhsS
         7FuiSIFIFwKAIhLh1E+YuRHwdzSpU/PXISM6wuPnItxKC//+Qdmhs4CyjjRZWvUCWfQk
         k7GDLcQdhNq6USeQR3dxL8S8XqKNPu/I+oAt8D1ZTpd/+qfbZHBfYvR5eh5QD0WuyTvW
         c8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6yCm28WnoyNx3nRePoJett8yHbUw3QYAhUOWEwm4lQ=;
        b=R42Jxz4/5f4PZbvgLSlkyJ6uSCPpfjJEHYBY6YdySAPjb434mw0f4ePZV8rkIqeN5c
         5suXM6x+aDPXO4FCB/P9bK3mAL6lPMQYozqtpKUcEq0ZO7rvFVMraVPV5Yjj4lO6wugJ
         +GmjW/F+nVg41EyKRRuLVpp0Skg9a4EZcLPHUwqS9z/4+cQjpziF+Zhc6WyAnAoOHZFY
         kkelBZ0VXLcaY+p3XFPMrAOmfuEgzfrg5gRhQxVAuTgaaJgmZCerfXX79KQv8ab9h514
         NS483AVkX5TgbHP8dMusJKtQ4wTKillsMXCTR2RZHXbOUyN+qfp8HIlRWM6FjG5tpfR/
         4zXw==
X-Gm-Message-State: AOAM530yzPXv9E3u0MF6pnsSgkPTW4gjVKQBfxm6gwAFA+og1VBrSP2h
        /yzlKPmzo2DytxWaUc9Ha+DEQMK6shycOdnQppdJrg==
X-Google-Smtp-Source: ABdhPJz26e2d1GkKb+V/LipLsD34ksQ67tXuNj+Cw74H7aKUj0SO3u3W3fk5wwDo+99vRvw0Yt+7Az4BWRx6nTCspcE=
X-Received: by 2002:a25:abcd:: with SMTP id v71mr32563199ybi.322.1625684407063;
 Wed, 07 Jul 2021 12:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <08a2e179-3f5f-639e-946f-54cd07ae12fa@kernel.org>
 <20210707181814.365496-1-ndesaulniers@google.com> <1fd40e80-283f-62e9-a0fa-84ad68047a23@kernel.org>
In-Reply-To: <1fd40e80-283f-62e9-a0fa-84ad68047a23@kernel.org>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Wed, 7 Jul 2021 11:59:55 -0700
Message-ID: <CAFP8O3JvFO-T1z94Y6271gKW111oFg45+F0u4TChDpxdh3Gg2Q@mail.gmail.com>
Subject: Re: [PATCH v4] kallsyms: strip LTO suffixes from static functions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "KE . LI" <like1@oppo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 11:34 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On 7/7/2021 11:18 AM, Nick Desaulniers wrote:
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
> > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Code looks fine, small comment about a comment below.
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> > ---
> > Changes v3 -> v4:
> > * Convert this function to use IS_ENABLED rather than provide multiple
> >    definitions based on preprocessor checks.
> > * Add Nathan's suggested-by.
> >
> > Changes v2 -> v3:
> > * Un-nest preprocessor checks, as per Nathan.
> >
> > Changes v1 -> v2:
> > * Both mangling schemes can occur for thinLTO + CFI, this new scheme can
> >    also occur for thinLTO without CFI. Split cleanup_symbol_name() into
> >    two function calls.
> > * Drop KE.LI's tested by tag.
> > * Do not carry Fangrui's Reviewed by tag.
> > * Drop the inline keyword; it is meaningless.
> >
> >   kernel/kallsyms.c | 43 ++++++++++++++++++++++++++++++-------------
> >   1 file changed, 30 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 4067564ec59f..a10dab216f4f 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -171,26 +171,43 @@ static unsigned long kallsyms_sym_address(int idx)
> >       return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
> >   }
> >
> > -#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
> > -/*
> > - * LLVM appends a hash to static function names when ThinLTO and CFI are
> > - * both enabled, i.e. foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
> > - * This causes confusion and potentially breaks user space tools, so we
> > - * strip the suffix from expanded symbol names.
> > - */
> > -static inline bool cleanup_symbol_name(char *s)
> > +static bool cleanup_symbol_name(char *s)
> >   {
> >       char *res;
> >
> > +     /*
> > +      * LLVM appends a suffix for local variables that must be promoted to
>
> This says local variables but the example uses a function? Is that correct?

local functions/variables.

Both functions and variables can have a .llvm.[0-9]+ suffix.


Aside from this, the updated description looks good to me

Reviewed-by: Fangrui Song <maskray@google.com>

> > +      * global scope as part of ThinLTO. foo() becomes
> > +      * foo.llvm.974640843467629774. This can break hooking of static
> > +      * functions with kprobes.
> > +      */
> > +     if (!IS_ENABLED(CONFIG_LTO_CLANG_THIN))
> > +             return false;
> > +
> > +     res = strstr(s, ".llvm.");
> > +     if (res) {
> > +             *res = '\0';
> > +             return true;
> > +     }
> > +
> > +     /*
> > +      * LLVM appends a hash to static function names when ThinLTO and CFI
> > +      * are both enabled, i.e. foo() becomes
> > +      * foo$707af9a22804d33c81801f27dcfe489b. This causes confusion and
> > +      * potentially breaks user space tools, so we strip the suffix from
> > +      * expanded symbol names.
> > +      */
> > +     if (!IS_ENABLED(CONFIG_CFI_CLANG))
> > +             return false;
> > +
> >       res = strrchr(s, '$');
> > -     if (res)
> > +     if (res) {
> >               *res = '\0';
> > +             return true;
> > +     }
> >
> > -     return res != NULL;
> > +     return false;
> >   }
> > -#else
> > -static inline bool cleanup_symbol_name(char *s) { return false; }
> > -#endif
> >
> >   /* Lookup the address for this symbol. Returns 0 if not found. */
> >   unsigned long kallsyms_lookup_name(const char *name)
> >
