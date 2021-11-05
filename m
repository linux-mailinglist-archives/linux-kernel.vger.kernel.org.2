Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D077F445E14
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 03:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhKECyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 22:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhKECyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 22:54:37 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D05BC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 19:51:58 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id bl27so9610934oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 19:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rmahxTkcmLTTUsDx1Lk4JadyLl4Uj+83r4z6uZU3XFs=;
        b=A/2YuRQiluZrxEIaHsOQFWi/K/GvPb0UFK1t9GW8yKz2hJna+Aqy/J4hR9Ygf+xDB3
         OeVHDAm4LD5+jMd6rUa9yvh7RgHb7AFtDcBuRLqFS1yFnbZm5tw4TnHS3fpyUuS9j/2v
         lAgejIhGQJIPJF7N65IIcYAopIbIt2z9MM26VS3/t6AIWsNtMusvF2m0Jw0jPOmv7OW7
         M0u/rRovcJlk7uMKMw9UtU9wDjmrbc567IlVQxrAb+AYkZeBd40xaYf9LDN5M8JeKW1q
         W6PgmMBHIjrQEZ/sikrwQSBdrCGQyo8L08Jd8ZPqPRsNn7E/raNDn32OB5ssP6IPaxZy
         Q5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rmahxTkcmLTTUsDx1Lk4JadyLl4Uj+83r4z6uZU3XFs=;
        b=RfDlZsb8SL1brBmdu6AESibjnOgia4/UQ0awx3wnGAwu+MDz0BMI5wD5XQFsrXGCMR
         io6/zfWTMIFVEANSDvDUM3ayzcb3TVZlt6MVf4nJbhKh2pCQG6Hf38dQ+2CA0FgF7WhR
         M9hmWF9JNY4vwbhXnmpva6lwCTZR8LJjjxPpWZahqkWbPeu8HyyADv4oA9xOQEJw3ji0
         oH+/CdDvM68WV/VKwV3Qt6xzzfvDKtlw6l7gbjPfkx+GZxO+YtmFGThJ+i8qMHVH4isz
         Vfk6eDcsK86Jdx+jz9cMY1jsTrzD2Ks3At7dDc+fsZEJGRhniSTmyY1Dnu3jNv059ely
         saBg==
X-Gm-Message-State: AOAM5300tUanv4E9zKucsFYFBIfBpwmhhm5iXmA3hKdjPKEfCIzV4IhV
        OeSWp3BHf7XGEEwxralM/Km9c9XuEms=
X-Google-Smtp-Source: ABdhPJyDFxYMVOtiRtft75YlF0cogHcG/uGRvl5sP+t1qmyDomW/q60sd2WZuuEZ60pIRVkx8RyjpA==
X-Received: by 2002:aca:41d5:: with SMTP id o204mr19518908oia.41.1636080717716;
        Thu, 04 Nov 2021 19:51:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v130sm1908932oie.34.2021.11.04.19.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 19:51:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 4 Nov 2021 19:51:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@lists.infradead.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] bus: brcmstb_gisb: Allow building as module
Message-ID: <20211105025155.GA2922689@roeck-us.net>
References: <20210924191035.1032106-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924191035.1032106-1-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 12:10:34PM -0700, Florian Fainelli wrote:
> Allow building the Broadcom STB GISB arbiter driver as a module, however
> similar to interrupt controller drivers, don't allow its unbind/removal
> since it is not quite prepared for that and we want it to catch bus
> errors all the time.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Hmm, did you actually test that ?

Building mips:allmodconfig ... failed
--------------
Error log:
<stdin>:1559:2: warning: #warning syscall futex_waitv not implemented [-Wcpp]
ERROR: modpost: "board_be_handler" [drivers/bus/brcmstb_gisb.ko] undefined!

Guenter

>  drivers/bus/Kconfig        | 2 +-
>  drivers/bus/brcmstb_gisb.c | 7 ++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index a5b96f3aad67..9cfeae3fc244 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -30,7 +30,7 @@ config ARM_INTEGRATOR_LM
>  	  found on the ARM Integrator AP (Application Platform)
>  
>  config BRCMSTB_GISB_ARB
> -	bool "Broadcom STB GISB bus arbiter"
> +	tristate "Broadcom STB GISB bus arbiter"
>  	depends on ARM || ARM64 || MIPS
>  	default ARCH_BRCMSTB || BMIPS_GENERIC
>  	help
> diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
> index 6551286a60cc..4c2f7d61cb9b 100644
> --- a/drivers/bus/brcmstb_gisb.c
> +++ b/drivers/bus/brcmstb_gisb.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (C) 2014-2017 Broadcom
> + * Copyright (C) 2014-2021 Broadcom
>   */
>  
>  #include <linux/init.h>
> @@ -536,6 +536,7 @@ static struct platform_driver brcmstb_gisb_arb_driver = {
>  		.name	= "brcm-gisb-arb",
>  		.of_match_table = brcmstb_gisb_arb_of_match,
>  		.pm	= &brcmstb_gisb_arb_pm_ops,
> +		.suppress_bind_attrs = true,
>  	},
>  };
>  
> @@ -546,3 +547,7 @@ static int __init brcm_gisb_driver_init(void)
>  }
>  
>  module_init(brcm_gisb_driver_init);
> +
> +MODULE_AUTHOR("Broadcom");
> +MODULE_DESCRIPTION("Broadcom STB GISB arbiter driver");
> +MODULE_LICENSE("GPL v2");
