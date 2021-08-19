Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281333F1080
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 04:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhHSCoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 22:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbhHSCoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 22:44:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EE1C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 19:43:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so3839164pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 19:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d6RN6WWjU7+yVROO0IeFQjWnV4RpGxTCLGpJ+nNfASA=;
        b=m9SVEKkXfVpcrJUqNcwUAyDXNVFqtQxwDtPuguaxMcic3tIpFrx+Nd2vGQx4IGBXs6
         7ojxnwhu5eUIGeLZWDChrm6GiLUeK0jwOalxNRCDIKlfFR008DnCKYnyaErdOvITFFOo
         csd3yWqQK753e4LW2A6+gTYy5SsE4KLNGYv48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d6RN6WWjU7+yVROO0IeFQjWnV4RpGxTCLGpJ+nNfASA=;
        b=VSkz8PNV3gvTSRGT+oMONDZ6MavPgKAN5jbgq3bQyllhyJAVgvHE3j8h8gyFKbHD5a
         mP7jbWUwNcb4HtZKjlVMwNP14P9urTpRQrhm1+hqvOpjtMSXmfE6na/frVDgk8LLkANC
         wX4HECHudPMCKChmFQAW5qyZB+c6EcRVColzcmKabl6ufGoFHrgRNra51yZ7QOM0XOYg
         HPKRKMy3ZdNKKUSSkPVeyV6YnU+QptXZowAZbGwFzWjGUycNhRq3mbB3Q64gh52HXqXu
         eRZWPLdF/t30wnwS50d0797wRQwu1KWEFTCPIii9mMaonM0akXNkhrtwv/k+TsVgu1WE
         Tmmg==
X-Gm-Message-State: AOAM532yOMpVADU9La2KhJ0hMaj94k85MVwG+9QTZr6AylgkFQX6mXFh
        /J2RUreRGxs2yowq/jQ3ZPcgCg==
X-Google-Smtp-Source: ABdhPJxtugWwRKOhljUXXr5aL90+y+pf1GNgIy/wrxr9ddBvgcMDkPZ54Vk9yox14FqX0kky8B0MPQ==
X-Received: by 2002:a17:90b:fd2:: with SMTP id gd18mr12521668pjb.155.1629341010405;
        Wed, 18 Aug 2021 19:43:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o10sm1279305pgp.68.2021.08.18.19.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 19:43:29 -0700 (PDT)
Date:   Wed, 18 Aug 2021 19:43:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 08/13] kbuild: merge vmlinux_link() between ARCH=um and
 other architectures
Message-ID: <202108181942.1B116E786@keescook>
References: <20210819005744.644908-1-masahiroy@kernel.org>
 <20210819005744.644908-9-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819005744.644908-9-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 09:57:39AM +0900, Masahiro Yamada wrote:
> For ARCH=um, ${CC} is used as the linker driver. Hence, the linker
> options are prefixed with -Wl, .
> 
> Merge the similar code.
> 
> I replaced the -T option with the long option --script= so that it
> works well with/without ${wl}.

And same for this one. So much better!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/link-vmlinux.sh | 56 +++++++++++++++++------------------------
>  1 file changed, 23 insertions(+), 33 deletions(-)
> 
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 7b9c62e4d54a..d74cee5c4326 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -149,13 +149,12 @@ objtool_link()
>  # ${2}, ${3}, ... - optional extra .o files
>  vmlinux_link()
>  {
> -	local lds="${objtree}/${KBUILD_LDS}"
>  	local output=${1}
> -	local objects
> -	local strip_debug
> -	local map_option
>  	local objs
>  	local libs
> +	local ld
> +	local ldflags
> +	local ldlibs
>  
>  	info LD ${output}
>  
> @@ -171,42 +170,33 @@ vmlinux_link()
>  		libs="${KBUILD_VMLINUX_LIBS}"
>  	fi
>  
> +	if [ "${SRCARCH}" = "um" ]; then
> +		wl=-Wl,
> +		ld="${CC}"
> +		ldflags="${CFLAGS_vmlinux}"
> +		ldlibs="-lutil -lrt -lpthread"
> +	else
> +		wl=
> +		ld="${LD}"
> +		ldflags="${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux}"
> +		ldlibs=
> +	fi
> +
> +	ldflags="${ldflags} ${wl}--script=${objtree}/${KBUILD_LDS}"
> +
>  	# The kallsyms linking does not need debug symbols included.
>  	if [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
> -		strip_debug=-Wl,--strip-debug
> +		ldflags="${ldflags} ${wl}--strip-debug"
>  	fi
>  
>  	if [ -n "${CONFIG_VMLINUX_MAP}" ]; then
> -		map_option="-Map=${output}.map"
> +		ldflags="${ldflags} ${wl}-Map=${output}.map"
>  	fi
>  
> -	if [ "${SRCARCH}" != "um" ]; then
> -		objects="--whole-archive ${objs} --no-whole-archive	\
> -			 --start-group ${libs} --end-group		\
> -			 $@"
> -
> -		${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux}	\
> -			${strip_debug#-Wl,}			\
> -			-o ${output}				\
> -			${map_option}				\
> -			-T ${lds} ${objects}
> -	else
> -		objects="-Wl,--whole-archive			\
> -			${KBUILD_VMLINUX_OBJS}			\
> -			-Wl,--no-whole-archive			\
> -			-Wl,--start-group			\
> -			${KBUILD_VMLINUX_LIBS}			\
> -			-Wl,--end-group				\
> -			${@}"
> -
> -		${CC} ${CFLAGS_vmlinux}				\
> -			${strip_debug}				\
> -			-o ${output}				\
> -			${map_option:+-Wl,${map_option}}	\
> -			-Wl,-T,${lds}				\
> -			${objects}				\
> -			-lutil -lrt -lpthread
> -	fi
> +	${ld} ${ldflags} -o ${output}					\
> +		${wl}--whole-archive ${objs} ${wl}--no-whole-archive	\
> +		${wl}--start-group ${libs} ${wl}--end-group		\
> +		$@ ${ldlibs}
>  }
>  
>  # generate .BTF typeinfo from DWARF debuginfo
> -- 
> 2.30.2
> 

-- 
Kees Cook
