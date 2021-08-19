Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215333F112A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhHSDGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbhHSDGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:06:38 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490F0C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:06:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so10371014pjr.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WLjcg2NhXmOHlNCRN9Rxm54WSU/BcCVx6+P+obykn8A=;
        b=Ajq76RcFv3UewQN9KqW1ZtlFGqJf9sND6dcA2w4CIfWxjabiqTVzzpB0Aqdf37k3yC
         LFaE6absGWtrTwuzlAf1m4wGZSwE+vClK5yrkx6cyy/0eTMKrS6pb9D1IF0SeUAIXYA0
         N1ibzaH72sA1MLuXp/dxdgn78owcX0j+wlRJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WLjcg2NhXmOHlNCRN9Rxm54WSU/BcCVx6+P+obykn8A=;
        b=LOvQJqU6qMiRb150OgfqSGrSC/SKaXd1ULW5Toe0V4jX9QNaOqna4+L7eMjC2G5MdY
         xHC7/0DHZn/BcgQBV7A/NsSJLHBnDN2WB7dtWsvUOlVvQ+w4HmJZWNYrWMmlKGjr4MSv
         QHLmRcK/YN+7W3/g47OORuYfOt+WbXvrT8tpRlRqsI5GvFnvcJrM4FqsLCnyjDGNgTwd
         Y84eAISunQ2EsWy9bF280X/4mikb23E99HtbMgRoT4Jq1coPsi+n9qEyphufjgbdcSuT
         x6xko1YW60Nb4jXKL84WjEnd4cWB+FfNCx2Ktri47kmizNmqbHSj8ho0CxpwyGGOI1X8
         XxAg==
X-Gm-Message-State: AOAM5319QZC24tIFYdaFYV7YkSiXkflu+UItfnCZg083rEPQFG98xwDw
        R/lbex7qfjah6tyPeeB2DY1nog==
X-Google-Smtp-Source: ABdhPJzWPzAMB4JLWb7nkclcrUjCXlPb8jJRYLCEDAH7KCNxsRiEKVB8s7Qgc0Ii5oxZyavrImT9+g==
X-Received: by 2002:a17:90b:4b12:: with SMTP id lx18mr12866499pjb.121.1629342361851;
        Wed, 18 Aug 2021 20:06:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x14sm1200296pfa.127.2021.08.18.20.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 20:06:01 -0700 (PDT)
Date:   Wed, 18 Aug 2021 20:06:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 12/13] kbuild: merge cmd_modversions_c and
 cmd_modversions_S
Message-ID: <202108182005.AD31690E@keescook>
References: <20210819005744.644908-1-masahiroy@kernel.org>
 <20210819005744.644908-13-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819005744.644908-13-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 09:57:43AM +0900, Masahiro Yamada wrote:
> Now cmd_modversions_c and cmd_modversions_S are similar.
> 
> The latter uses $(OBJDUMP) -h, but it can be replaced with $(NM).
> 
> $(NM) works for both ELF and LLVM bitcode (if $(NM) is llvm-nm).
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Ah yeah. That's nice consolidation.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> 
>  scripts/Makefile.build | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 874e84a1f3fc..97392c26ebd7 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -166,13 +166,16 @@ ifdef CONFIG_MODVERSIONS
>  
>  # Generate .o.symversions files for each .o with exported symbols, and link these
>  # to the kernel and/or modules at the end.
> -cmd_modversions_c =								\
> +cmd_modversions =								\
>  	if $(NM) $@ 2>/dev/null | grep -q __ksymtab; then			\
> -		$(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
> +		$(call cmd_gensymtypes_$(1),$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) \
>  		    > $@.symversions;						\
>  	else									\
>  		rm -f $@.symversions;						\
>  	fi;
> +
> +cmd_modversions_c = $(call cmd_modversions,c)
> +
>  endif
>  
>  ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
> @@ -327,14 +330,8 @@ ifdef CONFIG_ASM_MODVERSIONS
>  
>  # versioning matches the C process described above, with difference that
>  # we parse asm-prototypes.h C header to get function definitions.
> +cmd_modversions_S = $(call cmd_modversions,S)
>  
> -cmd_modversions_S =								\
> -	if $(OBJDUMP) -h $@ | grep -q __ksymtab; then				\
> -		$(call cmd_gensymtypes_S,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
> -		    > $@.symversions;						\
> -	else									\
> -		rm -rf $@.symversions;						\
> -	fi
>  endif
>  
>  $(obj)/%.o: $(src)/%.S $(objtool_dep) FORCE
> -- 
> 2.30.2
> 

-- 
Kees Cook
