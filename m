Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854F3409908
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhIMQ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhIMQ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:27:56 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64403C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:26:40 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f129so9952570pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vVZh4MCHii9RTsWAwJzzvhkJJB7eqF9Wlqiwcsfsd5A=;
        b=IFp6db6z5flQv5KvwMeluytmMACinEebhmMpTUIvac32Z2JVxbTPQElYhGgALDg2GH
         Lkyro0kcU9vQmc/s1mgXQZU/1pOWZ0POFRqIC/5xcPBREfVB++dHkiZGLl6OVbPZu+bt
         wqTVSigmTQyd66yVwVX+b0+p+G2mDUsvC1O/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vVZh4MCHii9RTsWAwJzzvhkJJB7eqF9Wlqiwcsfsd5A=;
        b=GG+05S+TchB/NZbCZPgfdfKB89Xx3CAdDkUSivrELhoMvVij1w6lm7m6wREI4TmUGS
         quo0hGzUT9heP+JcrEv7hZNLCWqHeJdNrnkdje5rXHylpIuezI0yROMnNF3OZqwZDtKC
         aAT6iTMAPWDJ4QzbpeA+kzsnbZ2fDgeEQGc3Y5q13e/LZ7q/WDQEcwkBvDGzR0/zLmn+
         bjkUBoSiJmXUkn4SryjG3KDrXlRZkSBjLr86VYFHopumbvkuA7ljKe19GuD4R7Pbioe6
         JbE3NpSGalkM9LzVzWh5rvqkaM79sa8enyrdS5oPO7B5F6HV9UwSn0yy9HT+O30LJQB1
         MaYQ==
X-Gm-Message-State: AOAM532FEq0dkW2wRa0q6TMRuq4oGkineTyCDgOEL8H+tsVGubkLAXvB
        vGa5/X2X7JZ8fcmhKjGL/UDlKA==
X-Google-Smtp-Source: ABdhPJx7XgLpvkSC/flgyeNbQbpq/4yeHX7epVqvfa/MPqlXRRH27EKSgqYBMgToUxDQoNJsUTBKNQ==
X-Received: by 2002:aa7:85d8:0:b0:408:78f4:a5fe with SMTP id z24-20020aa785d8000000b0040878f4a5femr397784pfn.2.1631550399978;
        Mon, 13 Sep 2021 09:26:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u10sm7423363pjf.46.2021.09.13.09.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:26:39 -0700 (PDT)
Date:   Mon, 13 Sep 2021 09:26:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] compiler-gcc.h: drop checks for older GCC versions
Message-ID: <202109130926.15C4D3486F@keescook>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-10-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910234047.1019925-10-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:40:46PM -0700, Nick Desaulniers wrote:
> Now that GCC 5.1 is the minimally supported default, drop the values we
> don't use.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  include/linux/compiler-gcc.h       | 4 +---
>  tools/include/linux/compiler-gcc.h | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 3f7f6fa0e051..fd82ce169ce9 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -98,10 +98,8 @@
>  
>  #if GCC_VERSION >= 70000
>  #define KASAN_ABI_VERSION 5
> -#elif GCC_VERSION >= 50000
> +#else
>  #define KASAN_ABI_VERSION 4
> -#elif GCC_VERSION >= 40902
> -#define KASAN_ABI_VERSION 3
>  #endif
>  
>  #if __has_attribute(__no_sanitize_address__)

Reviewed-by: Kees Cook <keescook@chromium.org>

> diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
> index a590a1dfafd9..43d9a46d36f0 100644
> --- a/tools/include/linux/compiler-gcc.h
> +++ b/tools/include/linux/compiler-gcc.h
> @@ -16,9 +16,7 @@
>  # define __fallthrough __attribute__ ((fallthrough))
>  #endif
>  
> -#if GCC_VERSION >= 40300
> -# define __compiletime_error(message) __attribute__((error(message)))
> -#endif /* GCC_VERSION >= 40300 */
> +#define __compiletime_error(message) __attribute__((error(message)))
>  
>  /* &a[0] degrades to a pointer: a different type from an array */
>  #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))

This part could be applied regardless (it's a missed 4.3 check, yes?)

-- 
Kees Cook
