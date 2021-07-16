Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856AF3CBFA3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 01:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbhGPXVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 19:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbhGPXVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 19:21:51 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE2EC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 16:18:55 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id g5so17392999ybu.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 16:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LCegWa0EbR5E+H26lAI/gNXNrN/GZQPQ9Xz7Y1nEaK0=;
        b=KSymXRh0XbMiAWoxMJSq+s5sBnfJeziQqRWTz6PbHu3An5QfD9eHFyZbGrbzwiL5bu
         8sm2ypsH1qObOia+D0NnMXw72HhxHKrHIa+7Ov5/60VIf8X39cHdtBEd9u1FjnPfGNeL
         47etscNyxp9duOq7tVtg8U177XG21+W/0TlycdgavKViPNn7MCBcpQRLslaFD75pTLU3
         LWmOszE0jQBaINoOZ2WPXXkTEkhET7ieQKrusD5DslpzTu6VQUNFCwTDJPEU81768nim
         VLi1myrEym63p75k53uzjdwXHIs2zw8TIoxObb6XBsXJ3EDh+Wrk5RqjGmiia4QZdGjO
         uZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LCegWa0EbR5E+H26lAI/gNXNrN/GZQPQ9Xz7Y1nEaK0=;
        b=tE7sGLcXhzzH6UBxyMZZN2Fo4Dm2glLhEf1GAlVSRwHmapHmau/UZbyyBsJrkYVWUV
         cHVkdq1cU+rhczTYtcCATqppT10b09YKR6DVbQpno6N/X9RP/1SskD4UShaoCL3UzlLI
         roMJeCTXpZh99IRF08t4qnbA9CFlrsyTeGYru7CzrUKrYTRB+WD2acQS8qJ9OVNi3Eqf
         /3bC0ZYetVwLbqMYszb2rSpgCT1FFN4Ed02Iv2IOFFSGnGNZI+81h0iIfrWu5ZQ4UyUJ
         4pGbDG4ffSbXcffvTfhtXsEUYiMMUBsQqcVqkGo6UCQVCRvAd3gda0N2fR8Qsnycm76J
         aGpA==
X-Gm-Message-State: AOAM530y7BV/bIM2T2/chdbEkEE+iQU6o7T/0kClOa9BXI8TtkWKZ7mC
        G7sjs3n93FWdUP/zgBYlthAvPF4dCBh0JC61waadEg==
X-Google-Smtp-Source: ABdhPJwxmX7mxsztP7uLyUcqRP8md2guvotbkAzbZhEcgDBle1svGkceojMfku530Byl2VZXCc5eHJ224dMbh0QZylY=
X-Received: by 2002:a25:3787:: with SMTP id e129mr15404370yba.459.1626477534089;
 Fri, 16 Jul 2021 16:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210716204545.3536354-1-samitolvanen@google.com> <20210716225245.67939-1-alobakin@pm.me>
In-Reply-To: <20210716225245.67939-1-alobakin@pm.me>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 16 Jul 2021 16:18:42 -0700
Message-ID: <CABCJKucqW6a8h55tUQ072QMZxzB5O4djjF+TN1-Btb=TY8KE=Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Fix TRIM_UNUSED_KSYMS with LTO_CLANG
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On Fri, Jul 16, 2021 at 4:00 PM Alexander Lobakin <alobakin@pm.me> wrote:
>
> From:   Sami Tolvanen <samitolvanen@google.com>
> Date:   Fri, 16 Jul 2021 13:45:45 -0700
>
> > With CONFIG_LTO_CLANG, we currently link modules into native
> > code just before modpost, which means with TRIM_UNUSED_KSYMS
> > enabled, we still look at the LLVM bitcode in the .o files when
> > generating the list of used symbols. As the bitcode doesn't
> > yet have calls to compiler intrinsics and llvm-nm doesn't see
> > function references that only exist in function-level inline
> > assembly, we currently need a whitelist for TRIM_UNUSED_KSYMS to
> > work with LTO.
> >
> > This change moves module LTO linking to happen earlier, and
> > thus avoids the issue with LLVM bitcode and TRIM_UNUSED_KSYMS
> > entirely, allowing us to also drop the whitelist from
> > gen_autoksyms.sh.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1369
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  scripts/Makefile.build    | 25 ++++++++++++++++++++++++-
> >  scripts/Makefile.lib      |  7 +++++++
> >  scripts/Makefile.modfinal | 21 ++-------------------
> >  scripts/Makefile.modpost  | 22 +++-------------------
> >  scripts/gen_autoksyms.sh  | 12 ------------
> >  5 files changed, 36 insertions(+), 51 deletions(-)
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 10b2f2380d6f..80e0fa810870 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -202,6 +202,7 @@ sub_cmd_record_mcount =                                   \
> >       if [ $(@) != "scripts/mod/empty.o" ]; then      \
> >               $(objtree)/scripts/recordmcount $(RECORDMCOUNT_FLAGS) "$(@)";   \
> >       fi;
> > +/
>
> Seems like a leftover or a random typo here.

Oops, indeed.

> >  recordmcount_source := $(srctree)/scripts/recordmcount.c \
> >                   $(srctree)/scripts/recordmcount.h
> >  else
> > @@ -271,12 +272,34 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) $$(objtool_dep) FORCE
> >       $(call if_changed_rule,cc_o_c)
> >       $(call cmd,force_checksrc)
> >
> > +ifdef CONFIG_LTO_CLANG
> > +# Module .o files may contain LLVM bitcode, compile them into native code
> > +# before ELF processing
> > +quiet_cmd_cc_lto_link_modules = LTO [M] $@
> > +cmd_cc_lto_link_modules =                                            \
> > +     $(LD) $(ld_flags) -r -o $@                                      \
> > +             $(shell [ -s $(@:.lto.o=.o.symversions) ] &&            \
> > +                     echo -T $(@:.lto.o=.o.symversions))             \
> > +             --whole-archive $^
> > +
> > +ifdef CONFIG_STACK_VALIDATION
> > +# objtool was skipped for LLVM bitcode, run it now that we have compiled
> > +# modules into native code
> > +cmd_cc_lto_link_modules += ;                                         \
> > +     $(objtree)/tools/objtool/objtool $(objtool_args)                \
>
> Now $(part-of-module) inside $(objtool_args) doesn't get expanded
> properly, because previously it was being called on x.ko, and now
> it's being called on x.lto.o. $(basename $@) returns "x.lto" instead
> of "x", and Make doesn't find "x.lto.o" in $(real-objs-m).
>
> An example of objtool args dump:
>
>   LTO [M] fs/btrfs/btrfs.lto.o
> Call: ./tools/objtool/objtool orc generate --no-fp --no-unreachable --retpoline --uaccess fs/btrfs/btrfs.lto.o
> fs/btrfs/btrfs.lto.o: warning: objtool: static_call: can't find static_call_key symbol: __SCK__might_resched

Curiously I didn't see objtool warnings when building allmodconfig,
but you're obviously correct here. I'll fix this in v2.

> As can be seen, objtools command line no longer contains "--module".
> And this warning about "can't find static_call_key" can appear only
> in case of !module -> no -m|--module param was given.
>
> As a result, modules get broken and the kernel panics after loading
> initramfs.

Thanks for taking a look!

Sami
