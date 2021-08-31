Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A373FCC67
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbhHaRg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbhHaRg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:36:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C59EC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:35:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q3so11074728plx.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zFaMu2sNRv+V3KA3jKCPARQc5wW0g1ezbq25T+FrX+A=;
        b=CJcVxB94cBu0KfWCRZRFyIAWe/YYDrVhIm2EZ0+KOYmz161+pmjleqYePf8EnrtFkP
         uJsgnQJeeu5s/UANwJSDEbygl1uMyyXueCJ/zKbGMrg9fMhiAmp3+kMLGVKM9tVG+9Zb
         cWfT+eOuYbqb87p8i0XyN7/FEhS7Vt3CtBh5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zFaMu2sNRv+V3KA3jKCPARQc5wW0g1ezbq25T+FrX+A=;
        b=HO3ElyH07aDxs+AzAe+EeRA8ZQRn97doFuPFkpqx4NWZJIqE9R6jhE7epKB1XFd6GM
         AH2oawgTBWqWkJhJTqrDGhuUtRfsDxIsw6lz4KjgoTNTskRcEOqDc4d2T3xH7QO6WohJ
         +s/hEFEIbzuB8e0SJm3UrKhnGrSrS67OeR2B6dlR7INvSfbPMmj27JvJLHP2bVXhQGOh
         7ye2qV0lY80R6s5gTwdRY+LiarQVeWhPZgHsWj+n43kDs4/cJrZ7P77CF42lOeVzR8+R
         KaPgKArQqSD+mcUpWc+yF2HXoSh8RyFzf5OT4RCypLegPlvgabXLNy3csM3dD+kcVvns
         pgKQ==
X-Gm-Message-State: AOAM532YKnTERHe45+hkS9nZN2Oc/ikMvflTqHTes3VAEIHf/Xe4qsbd
        28VTMBMik0PRIgbLAk9X1bZkvQ==
X-Google-Smtp-Source: ABdhPJxxBobqX14JN0kSgwykqoly1SD2goFOFtoe60Me1gVeAUqUnE9gLRM75UOV7/qHlGsbELi09w==
X-Received: by 2002:a17:90b:103:: with SMTP id p3mr6813846pjz.157.1630431330746;
        Tue, 31 Aug 2021 10:35:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t13sm3418724pjg.25.2021.08.31.10.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 10:35:30 -0700 (PDT)
Date:   Tue, 31 Aug 2021 10:35:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/13] kbuild: reuse $(cmd_objtool) for
 cmd_cc_lto_link_modules
Message-ID: <202108311034.D4B1410@keescook>
References: <20210831074004.3195284-1-masahiroy@kernel.org>
 <20210831074004.3195284-7-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831074004.3195284-7-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 04:39:57PM +0900, Masahiro Yamada wrote:
> For CONFIG_LTO_CLANG=y, the objtool processing is not possible at the
> compilation, hence postponed by the link time.
> 
> Reuse $(cmd_objtool) for CONFIG_LTO_CLANG=y by defining objtool-enabled
> properly.
> 
> For CONFIG_LTO_CLANG=y:
> 
>   objtool-enabled is off for %.o compilation
>   objtool-enabled is on  for %.lto link
> 
> For CONFIG_LTO_CLANG=n:
> 
>   objtool-enabled is on for %.o compilation
>       (but, it depends on OBJECT_FILE_NON_STANDARD)
> 
> Set part-of-module := y for %.lto.o to avoid repeating --module.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/Makefile.build | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 21b55f37a23f..afc906cd7256 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -236,20 +236,26 @@ objtool_args =								\
>  	$(if $(CONFIG_X86_SMAP), --uaccess)				\
>  	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)
>  
> -ifndef CONFIG_LTO_CLANG
> +cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
> +cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
> +
> +endif # CONFIG_STACK_VALIDATION
> +
> +ifdef CONFIG_LTO_CLANG
> +
> +# Skip objtool for LLVM bitcode
> +$(obj)/%o: objtool-enabled :=

Is this intentionally "%o" instead of "%.o"? (And it later overridden by
the "%.lto.o" rule?

> +
> +else
>  
>  # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
>  # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
>  # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
>  
> -objtool-enabled = $(if $(filter-out y%, \
> +$(obj)/%o: objtool-enabled = $(if $(filter-out y%, \
>  	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y)
>  
> -cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
> -cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
> -
> -endif # CONFIG_LTO_CLANG
> -endif # CONFIG_STACK_VALIDATION
> +endif
>  
>  ifdef CONFIG_TRIM_UNUSED_KSYMS
>  cmd_gen_ksymdeps = \
> @@ -289,13 +295,13 @@ cmd_cc_lto_link_modules =						\
>  	$(LD) $(ld_flags) -r -o $@					\
>  		$(shell [ -s $(@:.lto.o=.o.symversions) ] &&		\
>  			echo -T $(@:.lto.o=.o.symversions))		\
> -		--whole-archive $(filter-out FORCE,$^)
> +		--whole-archive $(filter-out FORCE,$^)			\
> +		$(cmd_objtool)
>  
> -ifdef CONFIG_STACK_VALIDATION
>  # objtool was skipped for LLVM bitcode, run it now that we have compiled
>  # modules into native code
> -cmd_cc_lto_link_modules += ; $(objtool) $(objtool_args) --module $@
> -endif
> +$(obj)/%.lto.o: objtool-enabled = y
> +$(obj)/%.lto.o: part-of-module := y
>  
>  $(obj)/%.lto.o: $(obj)/%.o FORCE
>  	$(call if_changed,cc_lto_link_modules)
> -- 
> 2.30.2
> 

-- 
Kees Cook
