Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDDB3FCC42
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhHaRYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbhHaRYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:24:20 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E575C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:23:24 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s12so74431ljg.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzj2neslp3w1SKPWRlwTW/oYbxkynkhopGYYCVETIH0=;
        b=tytHVky8GaRjt8zFupHiN8BCrsvvlBw6Jc4dVL9ZhiMlY6di6akzuOciuS8ZDGAzRD
         xZOMM1FkOmS/dMV/zjuGhqeMQhf9neLi2JbSczU1jYWxMXKFk85NwsYHNK3E0IfGqR68
         iZWTsZT+07H0lDSmaFJhtECHNPfB5gm1L6D1Y4+PetP9GbDOlcxRjmY9BkmNoXxTV8Nt
         5/Sa9mFE1mgw+LiYRvCWK1kPakp5pASh5cP6HKCnJTkk0AufM8AU2Hpuv06yv42lE1Jv
         JYtEd95piNVpstFTadPrZsBKKCfsNXGDBZu/E2Vpjfd1X7b54CDiHF7av2IPxg/7eB24
         P/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzj2neslp3w1SKPWRlwTW/oYbxkynkhopGYYCVETIH0=;
        b=e/oFZgE9x3SXPmP0VWRza/dvBmnm7q8Ii+lOVfkPr2/hccMNzNln+aIjUt/XG5FpDV
         0uZphWoe/KUeK0VhmCsociE0yHK/Q1Nx3EIJyc8Vt803PWNZsgCTpwb3GSYaR+GRnYRo
         RaGL33C+SmB4bCKNp/PNuZ1H2W5yPyENN0HRav5MrwEHxDa555m+x6DlCPi+ljLFp+dD
         8H5f7rV0BESTMFx+JAJYmm8uUNikXS24nj1oJ2hfFm9TpE3hsgfQhOKbKSifcsMm6/5m
         5q2Of+U0oxLdiQjuFcpdS7yC6bpW6scagDTqqcxDfkJwnlmbpJmmHDURFWM/VnakxLiW
         3acA==
X-Gm-Message-State: AOAM532ITY80St4YS6ndlIRHKSlgjwoFI/mXBMC/Gstj9Q6f/aqOoIs1
        HZa6jK28NtTTTdnTznENyLgjryI5+Gfsp2lRB3uquMy7gKSv2g==
X-Google-Smtp-Source: ABdhPJxgu58VJGLZ8zAj2IwlRW/puoY8pu3yhoSJjoIv+mVIi+rWCWWiNrpATGfyWX+8mhuRHbS4DWDXTZdZjreU8hc=
X-Received: by 2002:a2e:a788:: with SMTP id c8mr26190863ljf.116.1630430602541;
 Tue, 31 Aug 2021 10:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210831074004.3195284-1-masahiroy@kernel.org> <20210831074004.3195284-4-masahiroy@kernel.org>
In-Reply-To: <20210831074004.3195284-4-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 Aug 2021 10:23:10 -0700
Message-ID: <CAKwvOd=dVBWFm_kvUc3K_9XNQKvVfNL8aUm70yU6HyG6cE-TvQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] kbuild: store the objtool command in *.cmd files
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 12:40 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> objtool_dep includes include/config/{ORC_UNWINDER,STACK_VALIDATION}
> so that all the objects are rebuilt when any of CONFIG_ORC_UNWINDER
> and CONFIG_STACK_VALIDATION is toggled.
>
> As you can see in 'objtool_args', there are more CONFIG options
> that affect the objtool command line.
>
> Adding more and more include/config/* is ugly and unmaintainable.
>
> Another issue is that non-standard objects are needlessly rebuilt.
> Objects specified as OBJECT_FILES_NON_STANDARD is not processed by
> objtool, but they are rebuilt anyway when CONFIG_ORC_UNWINDER or
> CONFIG_STACK_VALIDATION is toggled. This is not a big deal, but
> better to fix.
>
> A cleaner and more precise fix is to include the objtool command in
> *.cmd files so any command change is naturally detected by if_change.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/Makefile.build | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index e78096cd396b..021ae0146913 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -155,7 +155,7 @@ $(obj)/%.ll: $(src)/%.c FORCE
>  # (See cmd_cc_o_c + relevant part of rule_cc_o_c)
>
>  quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
> -      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
> +      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $< $(cmd_objtool)
>
>  ifdef CONFIG_MODVERSIONS
>  # When module versioning is enabled the following steps are executed:
> @@ -243,7 +243,7 @@ ifndef CONFIG_LTO_CLANG
>  # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
>  cmd_objtool = $(if $(patsubst y%,, \
>         $(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
> -       $(objtool) $(objtool_args) $@)
> +       ; $(objtool) $(objtool_args) $@)
>  objtool_obj = $(if $(patsubst y%,, \
>         $(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
>         $(objtool))
> @@ -251,10 +251,8 @@ objtool_obj = $(if $(patsubst y%,, \
>  endif # CONFIG_LTO_CLANG
>  endif # CONFIG_STACK_VALIDATION
>
> -# Rebuild all objects when objtool changes, or is enabled/disabled.
> -objtool_dep = $(objtool_obj)                                   \
> -             $(wildcard include/config/ORC_UNWINDER            \
> -                        include/config/STACK_VALIDATION)
> +# Rebuild all objects when objtool changes
> +objtool_dep = $(objtool_obj)
>
>  ifdef CONFIG_TRIM_UNUSED_KSYMS
>  cmd_gen_ksymdeps = \
> @@ -269,7 +267,6 @@ define rule_cc_o_c
>         $(call cmd,gen_ksymdeps)
>         $(call cmd,checksrc)
>         $(call cmd,checkdoc)
> -       $(call cmd,objtool)
>         $(call cmd,modversions_c)
>         $(call cmd,record_mcount)
>  endef
> @@ -277,7 +274,6 @@ endef
>  define rule_as_o_S
>         $(call cmd_and_fixdep,as_o_S)
>         $(call cmd,gen_ksymdeps)
> -       $(call cmd,objtool)
>         $(call cmd,modversions_S)
>  endef
>
> @@ -365,7 +361,7 @@ $(obj)/%.s: $(src)/%.S FORCE
>         $(call if_changed_dep,cpp_s_S)
>
>  quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
> -      cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
> +      cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $< $(cmd_objtool)
>
>  ifdef CONFIG_ASM_MODVERSIONS
>
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
