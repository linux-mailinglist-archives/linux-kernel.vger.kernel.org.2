Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321AA3E06A0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbhHDRSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239891AbhHDRSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:18:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C775C061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 10:17:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id x11so4793652ejj.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 10:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Qo9QHnK3biCSTh8bimTB9CTycQIbbuDw05aJ2yEchU=;
        b=Zi+J54b61qNJKO3sahowtmeG1rTakq9aSxnXnCOwW070cpE1Pi8O7iJTIKbyDWcmQS
         sMH/JvSW70s1k9HkyKIlqXgPYwcVJj7AKqOvwCmANruYgldJ7T1fAjcjhEJWvppsF9FB
         BAZSz9Fshv0+3WUlD8WQQD/0ZvmtjZbnMRwPAdfCg74qDyc9Op+ar0UqkjR8mB96cSid
         zPH37kw886pPvcO4SBRVfDPLw/nfAq/fgRCg3X1edkutMseFEI5ZIBF7ldYfL0fnItkI
         pKizeD/j32K7p0W0rdspqfk/hTJFy+10yvoGdmGyRcKVwKDrSgPEZzYpO8biIJHSMb0m
         1aYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Qo9QHnK3biCSTh8bimTB9CTycQIbbuDw05aJ2yEchU=;
        b=pqoPmVGLnNQiPILPAICfJVCYz3/C6zHGhmKCta1ppoTP9sHdwGe9YuyQV3myGhb7e0
         5p1YZS2uVEuYkXSKz0iN1ipx6D08M/aYzErDZXh6iWnBPidYWfDSJ17R6IQRd1Mkz6Nz
         u7M5fM/OTdQjymAXxq2tDBNwIfacBwzhPUNjsXttsQLfY3W5673R1q1kgCf9+FHUwCmP
         cZSzI2MJHhPhI6/9Zms5MjkBwQBWlcBwE7FC/ONZmuO06v3ozgcJgxY3D7LAek5UMrXK
         OiW/tq2fTx+cGGzBtHAREEgaDdqc+oXv2E7K41aGzXP4WU9U6d0mwM36lTYqU9DVW5lQ
         UEOg==
X-Gm-Message-State: AOAM531KwaKbjYwjLYE0PhhtzWD+/tfVjaTVZYhpuKNJzPVepKZCO9e9
        wsMcOqyBcUuiS8jUogplqkE=
X-Google-Smtp-Source: ABdhPJwySmrRG1DxPw4UBG1spFOqlziSjLLZNWW6428++ZFBFL88YuQp0byYtOKc/uBuIwapjG0OnQ==
X-Received: by 2002:a17:906:d153:: with SMTP id br19mr302615ejb.166.1628097470629;
        Wed, 04 Aug 2021 10:17:50 -0700 (PDT)
Received: from pswork ([62.96.250.75])
        by smtp.gmail.com with ESMTPSA id u4sm835516eje.81.2021.08.04.10.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 10:17:50 -0700 (PDT)
Date:   Wed, 4 Aug 2021 19:17:49 +0200
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Stephen Boyd <swboyd@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v3] kallsyms: strip CLANG CFI postfix ".cfi_jt"
Message-ID: <20210804171749.GA5563@pswork>
References: <CABCJKudYRiK0KcMHGHeBFcr+Smwa9EM+NFeBpMo_ePqK+zHz0w@mail.gmail.com>
 <20210729205317.25685-1-treasure4paddy@gmail.com>
 <CABCJKuei==gaaKw0qH1WkshcRyUbqdS_WGRWr6anYAew1HHT2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKuei==gaaKw0qH1WkshcRyUbqdS_WGRWr6anYAew1HHT2w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 09:28:23AM -0700, Sami Tolvanen wrote:
> Hi,
> 
> On Thu, Jul 29, 2021 at 1:54 PM Padmanabha Srinivasaiah
> <treasure4paddy@gmail.com> wrote:
> >
> > Clang CFI adds a postfix ".cfi_jt" to a symbols of extern functions.
> > For example this breaks syscall tracer that doesn't expect such postfix,
> > so strip out the postfix from the expanded symbol.
> >
> > Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
> > ---
> >
> > Change in v3:
> >   - Modified commit message to indicate fix is for Clang CFI postfix
> >   - Rebased on recent patch from ndesaulniers@google.com.
> >   - Fix is enabled even for CONFIG_LTO_CLANG
> >
> > Change in v2:
> >   - Use existing routine in kallsyms to strip postfix ".cfi_jt" from
> >     extern function name.
> >   - Modified the commit message accordingly
> >
> >  kernel/kallsyms.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 5cabe4dd3ff4..67d015854cbd 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -174,7 +174,8 @@ static bool cleanup_symbol_name(char *s)
> >          * foo.llvm.974640843467629774. This can break hooking of static
> >          * functions with kprobes.
> >          */
> > -       if (!IS_ENABLED(CONFIG_LTO_CLANG_THIN))
> > +       if (!(IS_ENABLED(CONFIG_LTO_CLANG) ||
> > +             IS_ENABLED(CONFIG_LTO_CLANG_THIN)))
> 
> This is redundant. LTO_CLANG is selected for both LTO modes, so
> there's no need to also check for LTO_CLANG_THIN here.
>

As my setup is little endian, couldn't verify for below condition and 
was the reason to add such check. Sure will remove it.

       " select ARCH_SUPPORTS_LTO_CLANG if CPU_LITTLE_ENDIAN
	 select ARCH_SUPPORTS_LTO_CLANG_THIN"

> >                 return false;
> >
> >         res = strstr(s, ".llvm.");
> 
> However, we should probably check for ".llvm." only with LTO_CLANG_THIN.
>

Thank you for the input, will regenrate the patch with suggested check

> > @@ -184,16 +185,24 @@ static bool cleanup_symbol_name(char *s)
> >         }
> >
> >         /*
> > -        * LLVM appends a hash to static function names when ThinLTO and CFI
> > -        * are both enabled, i.e. foo() becomes
> > -        * foo$707af9a22804d33c81801f27dcfe489b. This causes confusion and
> > -        * potentially breaks user space tools, so we strip the suffix from
> > -        * expanded symbol names.
> > +        * LLVM appends a hash to static function names when both
> > +        * (Thin/FULL) LTO and CFI are enabled, i.e. foo() becomes
> > +        * foo$707af9a22804d33c81801f27dcfe489b.
> 
> That's not quite right, the hash is only appended with ThinLTO. I
> would leave this comment untouched.
>

sure, will revert it.

> > +        *
> > +        * In case of non static function symbol <funcsym>,
> > +        * the local jump table will have entry as <funcsym>.cfi_jt.
> > +        *
> > +        * This causes confusion and potentially breaks
> > +        * user space tools and some built-in components.
> > +        * So we strip the suffix from expanded symbol names.
> >          */
> >         if (!IS_ENABLED(CONFIG_CFI_CLANG))
> >                 return false;
> >
> >         res = strrchr(s, '$');
> > +       if (!res)
> > +               res = strstr(s, ".cfi_jt");
> 
> And add a comment about stripping .cfi_jt from jump table symbols
> before this part.
>

sure, will add it

> > +
> >         if (res) {
> >                 *res = '\0';
> >                 return true;
> > --
> > 2.17.1
> >
> 
> Sami
