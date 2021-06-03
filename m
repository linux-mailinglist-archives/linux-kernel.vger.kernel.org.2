Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26D439AD60
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 00:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhFCWBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 18:01:46 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:36600 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhFCWBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 18:01:46 -0400
Received: by mail-pg1-f180.google.com with SMTP id 27so6214296pgy.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 15:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bvlEqGWQS/mWxIPH9jHaX3vWyQoNnaB5BXBZR+ZVMms=;
        b=QHO+8GpQPY/r6sesfT4vQwl/4pnfALlnxhPtz5ED3qRuJrY2Wmu4d6xW2AD0sgleJ7
         J2kFpXNRl/RulVThNYbtuc4A5xrKcEZ3UQ5MUYCunXxDjvFQ5TIKTpV9AkIgjcVPQ6Nn
         whpkNyqG8ic/ILf0Gc1bk6qdur5+x3JmUlK3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bvlEqGWQS/mWxIPH9jHaX3vWyQoNnaB5BXBZR+ZVMms=;
        b=P019arl3ikkhj7BmWAlFHbxsto+tK8RuaGStaEz9uYweziRXI/JEGPwVkjsOh+dUuO
         om6lL4Dl5QkAw6JGGr2Ibpiwe28+ZOW8+Ux2zUGWHIUuN8QtyYdDa7ID63Q3WJiypGbw
         MhV0bPgjbyOC5eD/TOZIl4taQLgXfFcTMarMuDsVm99Ttmx3WSqFsvyf4do97Yn8v+N6
         WQoC2XaJCdxkK+B8aDm9TujgxCGA7pRmrAKRW/P+Kh/nW/nre8C2MeVanZqq2X7P48b1
         4MAmVRh4EQSQpzgFXIB+hZZvQZMIpcEkJVgk1UiBswtrY27ZI/FvVaqVGvopUn0jkHrU
         J51w==
X-Gm-Message-State: AOAM531T18YG9cpokqofb4ewg2k9ODMz3gIzS90SYQoqa5Vp404vJpba
        djs7A/40NIzW8r5uJyd7feSLZQ==
X-Google-Smtp-Source: ABdhPJw5M2Zfob07VpqFw8nR1AmRecmSTqx7m5d7TwVAdZST9TFmGluMzs3vqOfrDZPvsOLS23nYlw==
X-Received: by 2002:a63:ff43:: with SMTP id s3mr1588011pgk.86.1622757540838;
        Thu, 03 Jun 2021 14:59:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 18sm52372pfx.71.2021.06.03.14.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 14:59:00 -0700 (PDT)
Date:   Thu, 3 Jun 2021 14:58:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     kernel test robot <lkp@intel.com>, Rob Herring <robh@kernel.org>,
        Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/pl111: Fix CONFIG_VEXPRESS_CONFIG depend
Message-ID: <202106031458.DCF675EF7@keescook>
References: <20210603213412.3903724-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603213412.3903724-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 02:34:12PM -0700, Kees Cook wrote:
> Avoid randconfig build failures by requiring VEXPRESS_CONFIG either be
> missing, built-in, or modular when pl111 is modular. Fixing this warning
> when:
> 
> CONFIG_VEXPRESS_CONFIG=m
> CONFIG_DRM_PL111=y
> 
> aarch64-linux-gnu-ld: drivers/gpu/drm/pl111/pl111_versatile.o: in function `pl111_vexpress_clcd_init':
> pl111_versatile.c:(.text+0x220): undefined reference to `devm_regmap_init_vexpress_config'

Please ignore this in favor of:
https://lore.kernel.org/lkml/20210603215819.3904733-1-keescook@chromium.org

Thanks!

-Kees

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202105300926.fX0MYySp-lkp@intel.com/
> Fixes: 826fc86b5903 ("drm: pl111: Move VExpress setup into versatile init")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: avoid forcing VEXPRESS_CONFIG be enabled
> v1: https://lore.kernel.org/lkml/20210602215252.695994-4-keescook@chromium.org
> ---
>  drivers/gpu/drm/pl111/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
> index 80f6748055e3..b84879ca430d 100644
> --- a/drivers/gpu/drm/pl111/Kconfig
> +++ b/drivers/gpu/drm/pl111/Kconfig
> @@ -3,6 +3,7 @@ config DRM_PL111
>  	tristate "DRM Support for PL111 CLCD Controller"
>  	depends on DRM
>  	depends on ARM || ARM64 || COMPILE_TEST
> +	depends on !VEXPRESS_CONFIG || VEXPRESS_CONFIG=DRM
>  	depends on COMMON_CLK
>  	select DRM_KMS_HELPER
>  	select DRM_KMS_CMA_HELPER
> -- 
> 2.25.1
> 

-- 
Kees Cook
