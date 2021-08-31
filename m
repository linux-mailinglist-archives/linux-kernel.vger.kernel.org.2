Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3403FCC63
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbhHaReY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbhHaReX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:34:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725D1C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:33:27 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g13so329917lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZrI18LgS1AdjStd1TKHBE3FrFTsYJzmFcPjKcirCd0=;
        b=GPXZdvpwt6jtEOn3JFvQvlIzVUPyhg/+Cg9AB6JRZHVzFTtM3OOe1q2+0g1mXDAvx4
         YXvwXFaqehzLP6LXJWykKY39RmpHTcHGVJfWNChZie4bK93oW5bEDIfvUKzoUZ5YgXR8
         caPv+ZJUdLm4GFMo6uPvQ9zpK86a1gwrVcwO6RuegspPWVJtCsSBy2bfM/RzuGT+1gKN
         d/qxwCIwzb2vH3I7lq9peXTtgMbnyNEDh7tOOoksmwaSEixrS7HuALczmAqOH8Xrl0Ds
         vyTtF1STL2KW+2A0bKgjAbt6U5TVzLhX4INQ/8pOcDmCMUUBr3FV90URn4G1552+4TlM
         mqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZrI18LgS1AdjStd1TKHBE3FrFTsYJzmFcPjKcirCd0=;
        b=GX2Xzrhl086ene0LRrdXl20X71zjOXd9La8pFY0/AdmP1iq/PLms3NaGCOubQUbPAW
         oB5BFnzYul9MMqiYvAqN6KlTZ1+0ZZODWlGNqMugRIuVIHlJCng0h7uAl/EDdX9B0qk7
         FcE5YskHPnMpGM9N/eWxtHcWRddIwmhGbtFhOg5AH6UWky+U/l0I/CUrJKX37WSMbitr
         cFnIQFbjumyF02NNcJMhORz9NkLNYaxgeewCG49VFuZXYp8LUdjiBR0SAbyghE2Xjfpy
         FDS/a5ptIhyPQI9I6jAv2r3VP6qAWhXI7tg/90Bd3A28OoOxsQ8AIzC7x1OVL8XbikhA
         Tl0w==
X-Gm-Message-State: AOAM5305BPFhXggJvujooa1kb+YPXznMIx+z2CezKlGLSorspQVV+bF1
        g5g5evIi+oOfD1pTc9JEynCm2oiROcDNZinMgIvozA==
X-Google-Smtp-Source: ABdhPJyN8F39mi4Qm2/KOgSNBQR20dPHngD1OzWbSHKWRDp82Be0xe7biQ5MmCf9/ONK6p2xBWyIz++PMrvfMk3uIhQ=
X-Received: by 2002:a05:6512:3e22:: with SMTP id i34mr22560264lfv.374.1630431205487;
 Tue, 31 Aug 2021 10:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210831074004.3195284-1-masahiroy@kernel.org> <20210831074004.3195284-6-masahiroy@kernel.org>
In-Reply-To: <20210831074004.3195284-6-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 Aug 2021 10:33:14 -0700
Message-ID: <CAKwvOdmsnuv6qa5USKqqhg419FGD55U2zGw_KngmBcz_UDOOcg@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] kbuild: detect objtool update without using .SECONDEXPANSION
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 12:40 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Redo commit 8852c5524029 ("kbuild: Fix objtool dependency for
> 'OBJECT_FILES_NON_STANDARD_<obj> := n'") to add the objtool
> dependency in a cleaner way.
>
> Using .SECONDEXPANSION ends up with unreadable code due to escaped
> dollars. Also, it is not efficient because the second half of
> Makefile.build is parsed twice every time.
>
> Append the objtool dependency to the *.cmd files at the build time.
>
> This is what fixdep and gen_ksymdeps.sh already do. So, following the
> same pattern seems a natural solution.
>
> This allows us to drop $$(objtool_deps) entirely.

s/objtool_deps/objtool_dep/

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

You and Josh should be cc'ing each other explicitly on these kind of changes.

> ---
>
>  scripts/Makefile.build | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 720a86642f48..21b55f37a23f 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -246,14 +246,11 @@ objtool-enabled = $(if $(filter-out y%, \
>         $(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y)
>
>  cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
> -objtool_obj = $(if $(objtool-enabled), $(objtool))
> +cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
>
>  endif # CONFIG_LTO_CLANG
>  endif # CONFIG_STACK_VALIDATION
>
> -# Rebuild all objects when objtool changes
> -objtool_dep = $(objtool_obj)
> -
>  ifdef CONFIG_TRIM_UNUSED_KSYMS
>  cmd_gen_ksymdeps = \
>         $(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
> @@ -267,6 +264,7 @@ define rule_cc_o_c
>         $(call cmd,gen_ksymdeps)
>         $(call cmd,checksrc)
>         $(call cmd,checkdoc)
> +       $(call cmd,gen_objtooldep)
>         $(call cmd,modversions_c)
>         $(call cmd,record_mcount)
>  endef
> @@ -274,12 +272,12 @@ endef
>  define rule_as_o_S
>         $(call cmd_and_fixdep,as_o_S)
>         $(call cmd,gen_ksymdeps)
> +       $(call cmd,gen_objtooldep)
>         $(call cmd,modversions_S)
>  endef
>
>  # Built-in and composite module parts
> -.SECONDEXPANSION:
> -$(obj)/%.o: $(src)/%.c $(recordmcount_source) $$(objtool_dep) FORCE
> +$(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
>         $(call if_changed_rule,cc_o_c)
>         $(call cmd,force_checksrc)
>
> @@ -380,7 +378,7 @@ cmd_modversions_S =                                                         \
>         fi
>  endif
>
> -$(obj)/%.o: $(src)/%.S $$(objtool_dep) FORCE
> +$(obj)/%.o: $(src)/%.S FORCE
>         $(call if_changed_rule,as_o_S)
>
>  targets += $(filter-out $(subdir-builtin), $(real-obj-y))
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
