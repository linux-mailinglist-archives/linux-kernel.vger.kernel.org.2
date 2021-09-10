Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0F840723D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 22:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhIJUB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhIJUBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:01:55 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7306C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:00:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso2253298pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jLVbiLZggCi52S5wMGdIycWkv+6kFF2k4AIKDP601aE=;
        b=PE8h30T+eDs6zj5Xzjhu4avSqb43xd3T8FhtMGZalQ+q4ItUvldAFc1PhU5bXpl81l
         EPMmo8HdANoNub1441z/t1eA1Cqn+F2wJGLTNikDwzmrNBPfh4NP3q8flrqKd9VB4zM+
         FngYjjo6H7EoiVvNlMuq8TMKeBst2qFgxrf1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jLVbiLZggCi52S5wMGdIycWkv+6kFF2k4AIKDP601aE=;
        b=k+1iuqCl711p8+icmA3bP4qq45Ikx/KJrX6tjiUC+Zp1v5Gh2Em1csUidwuYBLPH70
         eZNBtbsYKyeWUz33unlIVuy9rvWUDO/HylGA8wGkdHYC6lTNYUwpOZnRwcbZ35cc3zq9
         5ZFJ8p+dKD21ct4WVPnkjxGFdV2QyBsW+4/nvX90MhZ01AUe15/0FG4OFs8Jl9MpfE8Y
         OaNlq7Qmzm/mWfXwUiNzaLmMK5jvfNHocOEbiHFJY71ZE+Zf8buCEPxewUbHE46m0Vq4
         mIAaouNlesb/mdg4zK7rpsk0z7SE4BfWoXDZMhPAXfY2DheZ3or7KMwmiNCWALb2GrwE
         BHnQ==
X-Gm-Message-State: AOAM531GXOi+JRrZ8OOBAaU3BXGkX17zzSqxvuq4QTub+k3ROr3pXH/F
        ebr19O0JHYrybcpib1TEIHTMxA==
X-Google-Smtp-Source: ABdhPJxPzopBsIpgMnUL2olM2JET761gS8j3up3/1dBvu8wETXy8c+POrxMHQLmPlf1U/vs5ShGsBA==
X-Received: by 2002:a17:902:6b49:b0:136:3f21:7a9 with SMTP id g9-20020a1709026b4900b001363f2107a9mr9067756plt.81.1631304043325;
        Fri, 10 Sep 2021 13:00:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cq8sm5472383pjb.31.2021.09.10.13.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:00:42 -0700 (PDT)
Date:   Fri, 10 Sep 2021 13:00:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>, llvm@lists.linux.dev,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Compiler Attributes: Check GCC version for __alloc_size
 attribute
Message-ID: <202109101259.83E803E@keescook>
References: <20210910165851.3296624-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910165851.3296624-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 09:58:51AM -0700, Kees Cook wrote:
> Unfortunately, just version checking the use of -Wno-alloc-size-larger-than
> is not sufficient to make the __alloc_size attribute behave correctly
> under older GCC versions. The attribute itself must be disabled in those
> situations too, as there appears to be no way to reliably silence the
> SIZE_MAX constant expression cases for GCC versions less than 9.1:
> 
> In file included from ./include/linux/resource_ext.h:11,
>                  from ./include/linux/pci.h:40,
>                  from drivers/net/ethernet/intel/ixgbe/ixgbe.h:9,
>                  from drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c:4:
> In function 'kmalloc_node',
>     inlined from 'ixgbe_alloc_q_vector' at ./include/linux/slab.h:743:9:
> ./include/linux/slab.h:618:9: error: argument 1 value '18446744073709551615' exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
>   return __kmalloc_node(size, flags, node);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/slab.h: In function 'ixgbe_alloc_q_vector':
> ./include/linux/slab.h:455:7: note: in a call to allocation function '__kmalloc_node' declared here
>  void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_slab_alignment __malloc;
>        ^~~~~~~~~~~~~~
> 
> Specifically:
> -Wno-alloc-size-larger-than is not correctly handled by GCC < 9.1
>   https://godbolt.org/z/hqsfG7q84 (doesn't disable)
>   https://godbolt.org/z/P9jdrPTYh (doesn't admit to not knowing about option)
>   https://godbolt.org/z/465TPMWKb (only warns when other warnings appear)
> 
> -Walloc-size-larger-than=18446744073709551615 is not handled by GCC < 8
>   https://godbolt.org/z/73hh1EPxz (ignores numeric value)
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> I've been digging through older GCC build logs and found this needed to
> be fixed even harder than prior attempts from what Randy had been seeing.
> ---
>  include/linux/compiler-gcc.h        | 9 +++++++++
>  include/linux/compiler_attributes.h | 6 ------
>  include/linux/compiler_types.h      | 5 +++++
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 01985821944b..ffe0a7570d66 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -151,3 +151,12 @@
>  #else
>  #define __diag_GCC_8(s)
>  #endif
> +
> +/*
> + * https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alloc_005fsize-function-attribute
> + * However, prior to 9.1, -Wno-alloc-size-larger-than does not work,
> + * making this attribute unusable.
> + */
> +#if GCC_VERSION < 90100
> +#define __alloc_size		/**/

Argh, this needs to be:

#define __alloc_size(x, ...)	/**/

This attribute has been such a pain. :P

> +#endif
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 19f178e20e61..2487be0e7199 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -53,12 +53,6 @@
>  #define __aligned(x)                    __attribute__((__aligned__(x)))
>  #define __aligned_largest               __attribute__((__aligned__))
>  
> -/*
> - *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alloc_005fsize-function-attribute
> - * clang: https://clang.llvm.org/docs/AttributeReference.html#alloc-size
> - */
> -#define __alloc_size(x, ...)		__attribute__((__alloc_size__(x, ## __VA_ARGS__)))
> -
>  /*
>   * Note: users of __always_inline currently do not write "inline" themselves,
>   * which seems to be required by gcc to apply the attribute according
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index c43308b0a9a9..91de9bead40d 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -254,6 +254,11 @@ struct ftrace_likely_data {
>  #define asm_volatile_goto(x...) asm goto(x)
>  #endif
>  
> +/* If not specifically disabled, allow the use of __alloc_size attribute. */
> +#ifndef __alloc_size
> +# define __alloc_size(x, ...)		__attribute__((__alloc_size__(x, ## __VA_ARGS__)))
> +#endif
> +
>  #ifdef CONFIG_CC_HAS_ASM_INLINE
>  #define asm_inline asm __inline
>  #else
> -- 
> 2.30.2
> 

-- 
Kees Cook
