Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5AB419DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbhI0SLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbhI0SLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:11:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066BBC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:09:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y8so16601548pfa.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ULgvFdc9nJC+zhcVB8sBdBKelrEYm9baRu32h8Ds15g=;
        b=mJjuxm9zDvUZPZyT4gO/zelAsoJS1yB16IqZtpIHPlpQ9FCKDLRWS9podAy43Bywyw
         BV1/uM+P0zTLwrMXRzvvYS13/GfADpqCD2JStMhgHv9lxyyTJTz3KUzR3MfTEyAeSWKs
         IGXMqi+uv2WBjmMh8VBbcgmEL9frGFXYup7Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ULgvFdc9nJC+zhcVB8sBdBKelrEYm9baRu32h8Ds15g=;
        b=el995q/NRhuSC/qfRDSHWTk5LAX8wvk/q7Hhzqgic35kQprm6oUDVw6ERggHUKV9VW
         /UO0SZCszH8LtGUOZheSuCFqPk4OQDY66rNFpgyDvBcO+pdRaoiCSpsV1LcLmwpr3Rbw
         ouIoobLotOtlS90d+vGLCw/OSspNrqjn8zpfNU+kMQ4rmD4zI8FZyWZlrFiuxxhKHnDt
         PCylg0Ty8O4asf4op8u9+dvQ87WcegGimNJttX5aMKwhhThg+dxKPnGILQCk1epf39m2
         p6ihw+k88XP558saSXsStyGBhflOO6MwL8TAfCskWpIK/w9dyvR6zKK+rWrwTTePRmFZ
         /WOQ==
X-Gm-Message-State: AOAM533+UauHc6YnIAY2Kk9X0/4QaBzlx6WNi0nzKttUdMQMdZxi1zOL
        fnvePCzBXib2OXn1BOdhSLd0rQ==
X-Google-Smtp-Source: ABdhPJy+6mgTuBbVm6l5nUFWRsUKPyO5/t8lIt4kz8Cakq9zwifcTeK/xEC0rdUnl7ocvi/omQ5wdQ==
X-Received: by 2002:a62:ddd8:0:b0:435:4de8:2652 with SMTP id w207-20020a62ddd8000000b004354de82652mr1305228pff.53.1632766176567;
        Mon, 27 Sep 2021 11:09:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e15sm12532294pfc.134.2021.09.27.11.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:09:36 -0700 (PDT)
Date:   Mon, 27 Sep 2021 11:09:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH V2 03/41] compiler_types.h: Add __noinstr_section() for
 noinstr
Message-ID: <202109271107.F02E36105@keescook>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
 <20210926150838.197719-4-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926150838.197719-4-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 11:08:00PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> And it will be extended for C entry code.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  include/linux/compiler_types.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index b6ff83a714ca..3c77631c68bd 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -208,10 +208,12 @@ struct ftrace_likely_data {
>  #endif
>  
>  /* Section for code which can't be instrumented at all */
> -#define noinstr								\
> -	noinline notrace __attribute((__section__(".noinstr.text")))	\
> +#define __noinstr_section(section)				\

bikeshed: this could be just __noinstr(section) instead
of __noinstr_section(section) just to avoid semi-redundant
information. *shrug*

Reviewed-by: Kees Cook <keescook@chromium.org>

> +	noinline notrace __attribute((__section__(section)))	\
>  	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
>  
> +#define noinstr __noinstr_section(".noinstr.text")
> +
>  #endif /* __KERNEL__ */
>  
>  #endif /* __ASSEMBLY__ */
> -- 
> 2.19.1.6.gb485710b
> 

-- 
Kees Cook
