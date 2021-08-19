Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4AC3F13B9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 08:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhHSGoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 02:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhHSGoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 02:44:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C5CC061575
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 23:43:35 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so6704733pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 23:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6ocG6XyycPlZ0PSnoxWYAbBlz8cQ7/a5UO+EORskNvg=;
        b=iDB1lKNzIDNEYiCrBTUeTXKMVqm9oCxdwIMXu6ktll39eJLEJqkpSOdrxR/MNSnwbn
         gc/7DOtCK2hIAjcUzW4pkUQuj/U9aYCj0h21Q3dBubwgBRfGUmHSMNt4VD6q8ocmNajO
         RhJ8NH/6VQc85qJKpSHbuVFs8HRsVFy/BDZrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ocG6XyycPlZ0PSnoxWYAbBlz8cQ7/a5UO+EORskNvg=;
        b=T22hpZFybPxoLzVrwXqenytFUi7g25nBqeF9XIosD5XP+sKTZAjLmTdC5ZF3EgWeog
         r50kOljH03U1Hp2I/zdIPBQJm4HwnaisJx2/XuEOudnF8eiSms71qFXodNYKJn1vcwMi
         Y08a4/GaWG6aXxzSu5oHDgT+NzVivuQm59z30Xd4krfU/nAx8dctYFC0HYFBunE21qYp
         XVlkoWAoVsm/VwZmaqqiYnSmVgax68GzPS7zvtpgNz+cKqU6OXmYq9CNe6z+lA+gBORE
         ptkSRrhCvQaWC3YsMOqeqw/e7AoJ59tXYSQA7xzY/tmwNQiUlYNpWOBw8Zt2Y/kkLLiU
         lOIg==
X-Gm-Message-State: AOAM5339tiby+IJVHcHA50x9jebP53oJMX+Dq9lTJ1tTqtfLpr2gMdfB
        IHX5WZecDIjB77aBFvfB/uo5Fw==
X-Google-Smtp-Source: ABdhPJwuNJ7GLbbIbtO7Su+tI7zEwg07g8ng9DCF7FZ3bqueTiATmnVw6jCcyTqGGhZwF05iLG1sLA==
X-Received: by 2002:a17:90a:9b0b:: with SMTP id f11mr13419781pjp.120.1629355415223;
        Wed, 18 Aug 2021 23:43:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w186sm2038277pfw.78.2021.08.18.23.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 23:43:34 -0700 (PDT)
Date:   Wed, 18 Aug 2021 23:43:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 11/13] kbuild: always postpone CRC links for module
 versioning
Message-ID: <202108182342.F24979957@keescook>
References: <20210819005744.644908-1-masahiroy@kernel.org>
 <20210819005744.644908-12-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819005744.644908-12-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 09:57:42AM +0900, Masahiro Yamada wrote:
> When CONFIG_MODVERSIONS=y, the CRCs of EXPORT_SYMBOL are linked into
> *.o files in-place.
> 
> It is impossible for Clang LTO because *.o files are not ELF, but LLVM
> bitcode. The CRCs are stored in separate *.symversions files, and then
> supplied to the modpost link.
> 
> Let's do so for CONFIG_LTO_CLANG=n is possible, and unify the module
> versioning code.

I worry about this also now being "unparallelized", but it is a nice
cleanup.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/Makefile.build  | 32 ++++++--------------------------
>  scripts/link-vmlinux.sh | 22 ++++++++++++++--------
>  2 files changed, 20 insertions(+), 34 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 957addea830b..874e84a1f3fc 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -158,17 +158,12 @@ quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
>  ifdef CONFIG_MODVERSIONS
>  # When module versioning is enabled the following steps are executed:
>  # o compile a <file>.o from <file>.c
> -# o if <file>.o doesn't contain a __ksymtab version, i.e. does
> -#   not export symbols, it's done.
> +# o if <file>.o doesn't contain __ksymtab* symbols, i.e. does
> +#   not export symbols, create an empty *.symversions
>  # o otherwise, we calculate symbol versions using the good old
>  #   genksyms on the preprocessed source and postprocess them in a way
>  #   that they are usable as a linker script
> -# o generate .tmp_<file>.o from <file>.o using the linker to
> -#   replace the unresolved symbols __crc_exported_symbol with
> -#   the actual value of the checksum generated by genksyms
> -# o remove .tmp_<file>.o to <file>.o
>  
> -ifdef CONFIG_LTO_CLANG
>  # Generate .o.symversions files for each .o with exported symbols, and link these
>  # to the kernel and/or modules at the end.
>  cmd_modversions_c =								\
> @@ -178,18 +173,6 @@ cmd_modversions_c =								\
>  	else									\
>  		rm -f $@.symversions;						\
>  	fi;
> -else
> -cmd_modversions_c =								\
> -	if $(OBJDUMP) -h $@ | grep -q __ksymtab; then				\
> -		$(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
> -		    > $(@D)/.tmp_$(@F:.o=.ver);					\
> -										\
> -		$(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@ 		\
> -			-T $(@D)/.tmp_$(@F:.o=.ver);				\
> -		mv -f $(@D)/.tmp_$(@F) $@;					\
> -		rm -f $(@D)/.tmp_$(@F:.o=.ver);					\
> -	fi
> -endif
>  endif
>  
>  ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
> @@ -348,12 +331,9 @@ ifdef CONFIG_ASM_MODVERSIONS
>  cmd_modversions_S =								\
>  	if $(OBJDUMP) -h $@ | grep -q __ksymtab; then				\
>  		$(call cmd_gensymtypes_S,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
> -		    > $(@D)/.tmp_$(@F:.o=.ver);					\
> -										\
> -		$(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@ 		\
> -			-T $(@D)/.tmp_$(@F:.o=.ver);				\
> -		mv -f $(@D)/.tmp_$(@F) $@;					\
> -		rm -f $(@D)/.tmp_$(@F:.o=.ver);					\
> +		    > $@.symversions;						\
> +	else									\
> +		rm -rf $@.symversions;						\
>  	fi
>  endif
>  
> @@ -424,7 +404,7 @@ $(obj)/lib.a: $(lib-y) FORCE
>  # Rule to prelink modules
>  #
>  
> -ifeq ($(CONFIG_LTO_CLANG) $(CONFIG_MODVERSIONS),y y)
> +ifdef CONFIG_MODVERSIONS
>  
>  cmd_merge_symver =					\
>  	rm -f $@;					\
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 17976609c2d8..66ced6ff8e65 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -59,8 +59,7 @@ append_symversion()
>  	fi
>  }
>  
> -# If CONFIG_LTO_CLANG is selected, collect generated symbol versions into
> -# .tmp_symversions.lds
> +# Collect generated symbol versions into .tmp_symversions.lds
>  gen_symversions()
>  {
>  	info GEN .tmp_symversions.lds
> @@ -94,14 +93,13 @@ modpost_link()
>  		${KBUILD_VMLINUX_LIBS}				\
>  		--end-group"
>  
> +	if [ -n "${CONFIG_MODVERSIONS}" ]; then
> +		lds="${lds} -T .tmp_symversions.lds"
> +	fi
> +
>  	if [ -n "${CONFIG_LTO_CLANG}" ]; then
>  		gen_initcalls
> -		lds="-T .tmp_initcalls.lds"
> -
> -		if [ -n "${CONFIG_MODVERSIONS}" ]; then
> -			gen_symversions
> -			lds="${lds} -T .tmp_symversions.lds"
> -		fi
> +		lds="${lds} -T .tmp_initcalls.lds"
>  
>  		# This might take a while, so indicate that we're doing
>  		# an LTO link
> @@ -198,6 +196,10 @@ vmlinux_link()
>  
>  	ldflags="${ldflags} ${wl}--script=${objtree}/${KBUILD_LDS}"
>  
> +	if [ -n "${CONFIG_MODVERSIONS}" ]; then
> +		ldflags="${ldflags} ${wl}--script=.tmp_symversions.lds"
> +	fi
> +
>  	# The kallsyms linking does not need debug symbols included.
>  	if [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
>  		ldflags="${ldflags} ${wl}--strip-debug"
> @@ -351,6 +353,10 @@ fi;
>  # final build of init/
>  ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init need-builtin=1
>  
> +if [ -n "${CONFIG_MODVERSIONS}" ]; then
> +	gen_symversions
> +fi
> +
>  #link vmlinux.o
>  modpost_link vmlinux.o
>  objtool_link vmlinux.o
> -- 
> 2.30.2
> 

-- 
Kees Cook
