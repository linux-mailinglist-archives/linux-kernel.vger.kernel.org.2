Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5E5325E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 08:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBZHs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 02:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhBZHs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 02:48:27 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85335C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 23:47:47 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id u20so13183560ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 23:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4DN+A5hkNrzxN+WZsFV8KY0Vzh1Hlgt+doIBF7EMR7I=;
        b=OoI1pL7li43evyqmtnhBTd2iXlFkyRAtJhv0UsbG4sZLfAyi/0E8XbDi7CnfngA1Fb
         EGbtX2gv6++FtCuAjoDpPQ1IYU7OoF5/Un1UtUwuyOHqnXLUpZk5dc9eAqRdY0ltJ74k
         4pgIrvMRednWCeZd3/VXFtHGBWobptY3IRVGstcv9YFU2D4ySf87tegWKAWVMLAy8+hN
         kWHT6uPCm0aYkMk+S3xSFj/yunSaZcE+rajXHiTKOEBk3CjT8OeFziRWhyWdwBjl5dZH
         Fvt+rt7S7haJJnRpFTKXKI/1r7bafqK7NOZ1KOo+/yGia4FwyXIRjkTOyOLpbUMTtIAF
         Ry9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4DN+A5hkNrzxN+WZsFV8KY0Vzh1Hlgt+doIBF7EMR7I=;
        b=fGwibIPlViqSmt92atqAPKkf1TDM5x7YxuKcwvRwLxfhUdSgsVhJxt2gmKJcTt3GlN
         T0lc1mFJy7G5HMBuO8Bm+onzcP1FGxhGBwsRDXFogTfmOkvgTnE+Oh+yGAdHzO2lC2d1
         mb5CYTO2cSSucxEA+93I/QIBEEC68bIxjnhBgBFCTHLRj3ziEdZ0cxSm+/sKWkq+2ORx
         hOF/Cw62Jm8Vy1Rih4WUVliolT0xoWV2XNL6pSw1vrRkQKNFI4ZpKCOCwcSy8wclbXCB
         FC06h1XBl810xzl8Jmu8frn+nes+kvREXNOM+Q2tPuts0SheLif569T6Ly667ghE3IfZ
         vRQQ==
X-Gm-Message-State: AOAM533uToEhXGKrFYeKSMgllvc3P5BrjoWwrWUhdgxu7B7k3P+ryOKc
        TrATIdaj6rtP3u4KYOry3Pc=
X-Google-Smtp-Source: ABdhPJwrW0FJ/RaJDt5EhWCuNgGElTt9wm1O5HSJXbKCjzjKNlNnU7H9Yku4RgjqsySPL+sbBlfaHg==
X-Received: by 2002:a17:906:4f96:: with SMTP id o22mr1846571eju.511.1614325666360;
        Thu, 25 Feb 2021 23:47:46 -0800 (PST)
Received: from mail ([2a02:a03f:b7fe:f700:b14f:9a2a:80ff:1887])
        by smtp.gmail.com with ESMTPSA id t27sm4650257ejc.62.2021.02.25.23.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 23:47:45 -0800 (PST)
Date:   Fri, 26 Feb 2021 08:47:43 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/compiler-clang.h: define HAVE_BUILTIN_BSWAP*
Message-ID: <20210226074743.krd3cixaf7bt5vsp@mail>
References: <20210225164513.3667778-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225164513.3667778-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 05:45:09PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/compiler-clang.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 6478bff6fcc2..bbfa9ff6a2ec 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -33,6 +33,16 @@
>  #define __no_sanitize_thread
>  #endif
>  
> +/*
> + * sparse (__CHECKER__) pretends to be gcc, but can't do constant
> + * folding in __builtin_bswap*() (yet), so don't set these for it.
> + */

This is not true anymore since 2017. Also, a much recent version of
Sparse is needed for _Generic(), for example).

Can you remove the comment and the test for __CHECKER__?

Best regards,
-- Luc
