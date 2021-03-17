Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A4A33EB08
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhCQIFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhCQIEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:04:46 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F33C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:04:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s17so2011537ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5UmE6rZVr5+jb7t1rTXILW6A7EIE1PrJSd4bUBeA8g0=;
        b=M2Bi5YJ2gQDhZHpUhimFb12NAbS57uzxkZ92QCelWM3gQgHI73NGagPsOgVxGuFqPV
         2FWmRZPyU6Hrx89TRmk0ec5YRrcssSxBx8inqlwA73BbFTY/YA+DT0IRqHmvamjQQhdw
         9eqz154ps3+rDHIf6U3CDJb1Z89vKJ2vS2p+MS99VDR72GEnIsF1E9VO570Fnzv0FQle
         7/dKaaSrRB0sjUeisogOZhI4sHf2Nw3GxzTu0ILtNgiAyJhoMBs3rFZA9wPUTbD5dkGO
         1PJ7GO5M8Uk8gi+n6xAB2jj0rWHHNC5cotYKL053T3doZoEN2EGhcM4Z4mNh5N9kDRs+
         MXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5UmE6rZVr5+jb7t1rTXILW6A7EIE1PrJSd4bUBeA8g0=;
        b=JKytG3sYDEmScrix1mYaHUyPBY05vVD/n6Y55RQRBogJNF/4nCgsiiqUuroRLKO5gv
         IzF+9+CeeNe+vUupO1AsA3WiyVoHx0HdRX7QO+R/Cz7sY6uuWeUynkBI1r2RMkiX73rK
         xBCCdiqhuovc5n1+sF9YjkgBQNufJ+0QOuRz67R6NEQ+DL4W5HC6pQ1Hzzejdf955K5C
         HOEmSfRGoj2CedgTvQ4FKtPE5SBbrStWsQtO2PHmKmVTynkwh66ozjhWkGeAdDv/LJzt
         Ty5fCIsRBXUDK2i7sBehO+eyanav7u9PihV2MbD5v1au8L5uW/GLQpDSV7R5fLAk7/U+
         G7SA==
X-Gm-Message-State: AOAM532LIHysUPWrH/k9tpu5LocjBT0YcC5Dnv/2pNKxypCgMy5f/+cc
        34XWnln3czMH3vzeoLI7Ld18JUjXwGV1RDmQ
X-Google-Smtp-Source: ABdhPJykRUdjuT9wQSOmASrgu+pBvzJH0Vr199W2A406VxU2Cx78kpRFCyyVSLua0Qkt4c0SANQTdg==
X-Received: by 2002:a2e:9f03:: with SMTP id u3mr1706414ljk.206.1615968284851;
        Wed, 17 Mar 2021 01:04:44 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id k13sm3307736lfg.192.2021.03.17.01.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:04:44 -0700 (PDT)
Date:   Wed, 17 Mar 2021 09:04:42 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Ran Wang <ran.wang_1@nxp.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] optee: enable apci support
Message-ID: <20210317080442.GA3018337@jade>
References: <20210312083653.38780-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210312083653.38780-1-ran.wang_1@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 04:36:53PM +0800, Ran Wang wrote:
> This patch add ACPI support for optee driver.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  drivers/tee/optee/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index cf4718c6d35d..8fb261f4b9db 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -5,6 +5,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/acpi.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/errno.h>
>  #include <linux/io.h>
> @@ -735,12 +736,21 @@ static const struct of_device_id optee_dt_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, optee_dt_match);
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id optee_acpi_match[] = {
> +	{ "OPTEE01",},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
> +#endif
> +
>  static struct platform_driver optee_driver = {
>  	.probe  = optee_probe,
>  	.remove = optee_remove,
>  	.driver = {
>  		.name = "optee",
>  		.of_match_table = optee_dt_match,
> +		.acpi_match_table = ACPI_PTR(optee_acpi_match),
>  	},
>  };
>  module_platform_driver(optee_driver);
> -- 
> 2.25.1
> 

This looks simple enough. Ard, is this what you had in mind earlier?

Thanks,
Jens
