Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCCF3F0780
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbhHRPGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbhHRPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:06:48 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFAEC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 08:06:13 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id a93so5936578ybi.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 08:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYJwSm6eCcwSwyminZRoSw8P5cz5zWYev61l8HFaS3A=;
        b=ZVq8iO+uckPOD9FvTvEYE4mUDy8Ejl5KoV9LVDV8uLfdwt5zB4pojw8fKAvHmbjWKz
         vPAAU/vAc/B0uq1YKn1JvBhhsReFIi8AfL/uv0tNfu3pUYeCK2DViliZSZQo09R7MExT
         nx67enUXn0TMnH8vgRoBx1+2WusV86lc/Nr8Lqg72QnpOc6aVw7fQGx6Mklr/xzyp3JB
         CqAD+Uwb1svUuSOrApC9QaSVHw0MnIC1HVtELveawZ01FrwzAAsbmXu9ED5fI9ko45KN
         kKTqlvrANXf7pfbflSkUKhn/4gT/Ci/2ekBXUAjbgnXm0n5xWTcU4vEOu9Tupt6Jn61u
         cpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYJwSm6eCcwSwyminZRoSw8P5cz5zWYev61l8HFaS3A=;
        b=LCFVphS/QVp7VDNP27ZrYbFzdDsh8qv4gG4Pt/GKH6aoSTCtWDP8j2EafUFCfybr0M
         3iI0yN2L8DH43CjcVVnBlBUc3gfrnFFkU7zj8JngkE41iwsowuoDxKXrPAB6jPSZ29bx
         Su3Gr6C4oVWo5cHNWV6F8XUN1edZn7v+oFJV11+L7KUNy/kxA2IuGHAkiPTcVaBwqeyP
         mu5LDrBagm5y8jZRHMzSPbE0Cv0ZfkYU4CqoreZcsv74QMm5lZINXrHyCb91UU+4fQeK
         SjBSTo/fF24FufqDnFeftF/i4vB1kgMx5F2h4iPR7xVNkwF/2avQ6OvT5qcRTQ2w6osm
         i8tQ==
X-Gm-Message-State: AOAM530q5fhSb/lK7D9Sna2rSDYtbfe+QMK+6F7mlLUPFM9iUUqwICBj
        wD+6hoYw266NtGPTkOPs6nfJkPaTuHAOSahuq0bROA7IbFk=
X-Google-Smtp-Source: ABdhPJy3kL6U2SIXU5UKwKHqeTBXGJsXc7NewkgI9xpOKlqzoMSqGg01ZiJ2wgDLNSr41LX6krBMIqKNdTB5K8pceoI=
X-Received: by 2002:a25:cc52:: with SMTP id l79mr11563745ybf.459.1629299172676;
 Wed, 18 Aug 2021 08:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210816180519.1021311-1-samitolvanen@google.com> <CAK7LNASAHN=-uj73Uwk10aXbsR8AkUM_P=3NX_dq2SiFTqUctg@mail.gmail.com>
In-Reply-To: <CAK7LNASAHN=-uj73Uwk10aXbsR8AkUM_P=3NX_dq2SiFTqUctg@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 18 Aug 2021 08:06:01 -0700
Message-ID: <CABCJKudQhagwdb-UfGE2JQN8H29NSpMd5PgVoftJYRp5ZwpRrA@mail.gmail.com>
Subject: Re: [PATCH v4] kbuild: Fix TRIM_UNUSED_KSYMS with LTO_CLANG
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Alexander Lobakin <alobakin@pm.me>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 7:34 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, Aug 17, 2021 at 3:05 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
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
> > Reviewed-by: Alexander Lobakin <alobakin@pm.me>
> > Tested-by: Alexander Lobakin <alobakin@pm.me>
> > ---
> > Changes in v4:
> > - Added .lto.o to targets to actually fix the use of if_changed.
> > - Replaced an unnecessary mod-prelink-ext with .lto.
> >
> > Changes in v3:
> > - Added missing FORCE.
> >
> > Changes in v2:
> > - Fixed a couple of typos.
> > - Fixed objtool arguments for .lto.o to always include --module.
> >
> > ---
> >  scripts/Makefile.build    | 28 +++++++++++++++++++++++++++-
> >  scripts/Makefile.lib      |  7 +++++++
> >  scripts/Makefile.modfinal | 21 ++-------------------
> >  scripts/Makefile.modpost  | 22 +++-------------------
> >  scripts/gen_autoksyms.sh  | 12 ------------
> >  5 files changed, 39 insertions(+), 51 deletions(-)
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 02197cb8e3a7..a6f43afd09bb 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -88,6 +88,10 @@ endif
> >
> >  targets-for-modules := $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
> >
> > +ifdef CONFIG_LTO_CLANG
> > +targets-for-modules += $(patsubst %.o, %.lto.o, $(filter %.o, $(obj-m)))
> > +endif
> > +
> >  ifdef need-modorder
> >  targets-for-modules += $(obj)/modules.order
> >  endif
> > @@ -271,12 +275,34 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) $$(objtool_dep) FORCE
> >         $(call if_changed_rule,cc_o_c)
> >         $(call cmd,force_checksrc)
> >
> > +ifdef CONFIG_LTO_CLANG
> > +# Module .o files may contain LLVM bitcode, compile them into native code
> > +# before ELF processing
> > +quiet_cmd_cc_lto_link_modules = LTO [M] $@
> > +cmd_cc_lto_link_modules =                                              \
> > +       $(LD) $(ld_flags) -r -o $@                                      \
> > +               $(shell [ -s $(@:.lto.o=.o.symversions) ] &&            \
> > +                       echo -T $(@:.lto.o=.o.symversions))             \
> > +               --whole-archive $(filter-out FORCE,$^)
> > +
> > +ifdef CONFIG_STACK_VALIDATION
> > +# objtool was skipped for LLVM bitcode, run it now that we have compiled
> > +# modules into native code
> > +cmd_cc_lto_link_modules += ;                                           \
> > +       $(objtree)/tools/objtool/objtool $(objtool_args) --module       \
> > +               $(@:.ko=.lto.o)
>
>
> What is this "$(@:.ko=.lto.o)" doing ?
>
> The target is already suffixed with .lto.o
> so $(@:.ko=.lto.o) should be the same as $@

Good catch, probably a leftover from an earlier iteration.

> Shall I fix it locally unless
> I find more questionable code?

Please do.

Sami
