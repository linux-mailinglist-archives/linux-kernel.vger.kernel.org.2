Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9CB43280E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhJRUAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 16:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbhJRUAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 16:00:11 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F1DC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:58:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f11so11703613pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=br6xKN+ewFquRu4Vdte2iE68fWUT3Vzo8bAwzpphWYM=;
        b=Qe/4DEObOXDBpcyLbPVGbzG9cDI5byJsrOmH5I/BpZguxLSWFkppRJFxYnC4GQpRjN
         DPK8vgPYeBYO5yrnhnvoc3a9mT12J05UjnulslchuN2W8icPUjA6s2AroO2SHpNobAPH
         A+HXhmqhm8Rn4yl10Q/MekIwgCYfFaFWAPX/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=br6xKN+ewFquRu4Vdte2iE68fWUT3Vzo8bAwzpphWYM=;
        b=cnvKCu2qysZ99o6l9Uy8aDfcnFd+c7SQ+kpvn5IjGs5NLTcheiDN8QrO59qQbTHSvQ
         jK9+ztqOt+mGEv4ZxH5yK/q4ZMPP06RMDmO0JH+1QctJX76GpY4Si6CA3CW8tTAu9Grn
         5P8r0qSI+lh12CwMlwtj3hhNpsf1gWPxds/n8YzfI9rF9DC2qa0zL5KdWpKFl+g6zytT
         T8C+WC1A8HLTps9ha87MwFwXJtk6KAEx5QjKV1Sdg+eoTs5RInMZCvcs3/8A2IB5tMjx
         Rm5OGdNsOr61Uprn23XntE7l5JVNsiW/FW4ob0lDtTiQ6CCijDxemdN9nk8+QfVhFPp4
         8OWA==
X-Gm-Message-State: AOAM533J3f4YhdQoYHrBwkGVRlQf4ivAqqu92EvmUFXKPCdexzw9qmsB
        b47rQWRjDaBPND8vlcusHGyf1w==
X-Google-Smtp-Source: ABdhPJzE3b07K04g4ttAYx8LaAzRQs4ekipn7fBotBs8KdMGzarYDcinwOMKEap+zIajS9zMqFVPTQ==
X-Received: by 2002:a63:5714:: with SMTP id l20mr25127176pgb.121.1634587079898;
        Mon, 18 Oct 2021 12:57:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bt5sm265293pjb.9.2021.10.18.12.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:57:59 -0700 (PDT)
Date:   Mon, 18 Oct 2021 12:57:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marco Elver <elver@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] kasan: use fortified strings for hwaddress sanitizer
Message-ID: <202110181247.8F53380@keescook>
References: <20211013150025.2875883-1-arnd@kernel.org>
 <20211013150025.2875883-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013150025.2875883-2-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 05:00:06PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> GCC has separate macros for -fsanitize=kernel-address and
> -fsanitize=kernel-hwaddress, and the check in the arm64 string.h
> gets this wrong, which leads to string functions not getting
> fortified with gcc. The newly added tests find this:
> 
> warning: unsafe memchr() usage lacked '__read_overflow' warning in /git/arm-soc/lib/test_fortify/read_overflow-memchr.c
> warning: unsafe memchr_inv() usage lacked '__read_overflow' symbol in /git/arm-soc/lib/test_fortify/read_overflow-memchr_inv.c
> warning: unsafe memcmp() usage lacked '__read_overflow' warning in /git/arm-soc/lib/test_fortify/read_overflow-memcmp.c
> warning: unsafe memscan() usage lacked '__read_overflow' symbol in /git/arm-soc/lib/test_fortify/read_overflow-memscan.c
> warning: unsafe memcmp() usage lacked '__read_overflow2' warning in /git/arm-soc/lib/test_fortify/read_overflow2-memcmp.c
> warning: unsafe memcpy() usage lacked '__read_overflow2' symbol in /git/arm-soc/lib/test_fortify/read_overflow2-memcpy.c
> warning: unsafe memmove() usage lacked '__read_overflow2' symbol in /git/arm-soc/lib/test_fortify/read_overflow2-memmove.c
> warning: unsafe memcpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-memcpy.c
> warning: unsafe memmove() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-memmove.c
> warning: unsafe memset() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-memset.c
> warning: unsafe strcpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strcpy-lit.c
> warning: unsafe strcpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strcpy.c
> warning: unsafe strlcpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strlcpy-src.c
> warning: unsafe strlcpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strlcpy.c
> warning: unsafe strncpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strncpy-src.c
> warning: unsafe strncpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strncpy.c
> warning: unsafe strscpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strscpy.c
> 

What is the build config that trips these warnings?

In trying to understand this, I see in arch/arm64/include/asm/string.h:

#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
        !defined(__SANITIZE_ADDRESS__)

other architectures (like arm32) do:

#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)

so it's okay because it's not getting touched by the hwaddress sanitizer?
e.g. I see:

config CC_HAS_KASAN_GENERIC
        def_bool $(cc-option, -fsanitize=kernel-address)

config CC_HAS_KASAN_SW_TAGS
        def_bool $(cc-option, -fsanitize=kernel-hwaddress)

> Add a workaround to include/linux/compiler_types.h so we always
> define __SANITIZE_ADDRESS__ for either mode, as we already do
> for clang.

Where is the clang work-around? (Or is this a statement that clang,
under -fsanitize=kernel-hwaddress, already sets __SANITIZE_ADDRESS__ by
default?

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/compiler_types.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index aad6f6408bfa..2f2776fffefe 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -178,6 +178,13 @@ struct ftrace_likely_data {
>   */
>  #define noinline_for_stack noinline
>  
> +/*
> + * Treat __SANITIZE_HWADDRESS__ the same as __SANITIZE_ADDRESS__ in the kernel
> + */
> +#ifdef __SANITIZE_HWADDRESS__
> +#define __SANITIZE_ADDRESS__
> +#endif

Should this go into compiler-gcc.h instead?

> +
>  /*
>   * Sanitizer helper attributes: Because using __always_inline and
>   * __no_sanitize_* conflict, provide helper attributes that will either expand
> -- 
> 2.29.2
> 

-- 
Kees Cook
