Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8820332AE06
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360381AbhCBWTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383415AbhCBVDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:03:24 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB51C061226
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 12:59:09 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id n16so16568515lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 12:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Go8ACEa3guLKAG5WpAxfwUSeU5KTsiXL4eCKtU7xHX4=;
        b=SqlnzmNR7VqUbnSjeSjQSy+fl81/apOARjyT3yBJGB24YYxlUWNGDtM6n7kLsyAhcF
         zVkcSyyAbeDsjO3jb8HtkeMapedp7Zvn+G4r3zmM7bSGAXzCKT5SgfMt2a7heWOrFIhJ
         cnSFr/RWo5i80ec4/pvUV7cnPnclj0GPfvXrF8PoFPO+bXFt0TjVeC0fd6Uy9NxinRH4
         1gamNl324XfQf99Xj8c4bMOVR1Aep5aNwsWcFzbbL1MB/zMha8Ct7rj34jB7VwLXBhor
         cqRThsL7ZbgWsrkXwzwm5cbYvIwU2ns+PEzm85AQuooWlzr7qTwrjCzJZrkD+S5Nh7XQ
         v0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Go8ACEa3guLKAG5WpAxfwUSeU5KTsiXL4eCKtU7xHX4=;
        b=XvUxhP0ymiZHDz0PEF4707Y3qbA1YoObjFUMNuSJiWpDBfiumHWxrxRWIAkcpZJPsd
         8qP3mV9/FyTvEOu6ma3y8I/LTJSyVu6g1W6kBo0FtzeFGh0kpyAQ0UpHsEc2apywuVW6
         0iqU3vVoVmToQmVwitsEv2finMozmW2JrYY8+Y26dMtHAlCFMmexit3GHk2YbgfRPfhv
         TrxmTDXuFUIrVIwso26IWztjizK32Iy1UfuBTssej6LcM/4BuB4atKETIF4/T4FdeiXt
         yEhq6/MBY94aSAzCEofCnwr0OTmpTNFot9COEi9X8S6H33Xsd37GGZzr2VmVHWRpGVsW
         u6Pg==
X-Gm-Message-State: AOAM532EZSfDr3virMdGTMOu6v4knP3wMLZwtlOSfqtc8hLoZu6c3oJF
        U+SySfuhax5e/lZ5xSEftCM=
X-Google-Smtp-Source: ABdhPJzfeK2YqHMCkmkNQFJKUVQVYpvyEV2d9qs1KFZ/bgksfncfxoLAF7bWK7z4qX2X3pISux4v8Q==
X-Received: by 2002:a05:6512:70:: with SMTP id i16mr10210098lfo.508.1614718747818;
        Tue, 02 Mar 2021 12:59:07 -0800 (PST)
Received: from rikard (h-98-128-229-129.NA.cust.bahnhof.se. [98.128.229.129])
        by smtp.gmail.com with ESMTPSA id d1sm2754464lfq.156.2021.03.02.12.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 12:59:07 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Tue, 2 Mar 2021 21:59:03 +0100
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [PATCH v1 1/5] mfd: intel_quark_i2c_gpio: revert "Constify
 static struct resources"
Message-ID: <YD6nF1oJVMeCzn6R@rikard>
References: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 03:56:16PM +0200, Andy Shevchenko wrote:
> The structures are used as place holders, so they are modified at run-time.
> Obviously they may not be constants.
> 
>   BUG: unable to handle page fault for address: d0643220
>   ...
>   CPU: 0 PID: 110 Comm: modprobe Not tainted 5.11.0+ #1
>   Hardware name: Intel Corp. QUARK/GalileoGen2, BIOS 0x01000200 01/01/2014
>   EIP: intel_quark_mfd_probe+0x93/0x1c0 [intel_quark_i2c_gpio]
> 
> This partially reverts the commit c4a164f41554d2899bed94bdcc499263f41787b4.
> 
> While at it, add a comment to avoid similar changes in the future.
> 
> Fixes: c4a164f41554 ("mfd: Constify static struct resources")
> Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_quark_i2c_gpio.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
> index 55a9e017edee..124c0ee84169 100644
> --- a/drivers/mfd/intel_quark_i2c_gpio.c
> +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> @@ -72,7 +72,8 @@ static const struct dmi_system_id dmi_platform_info[] = {
>  	{}
>  };
>  
> -static const struct resource intel_quark_i2c_res[] = {
> +/* This is used as a place holder and will be modified at run-time */
> +static struct resource intel_quark_i2c_res[] = {
>  	[INTEL_QUARK_IORES_MEM] = {
>  		.flags = IORESOURCE_MEM,
>  	},
> @@ -85,7 +86,8 @@ static struct mfd_cell_acpi_match intel_quark_acpi_match_i2c = {
>  	.adr = MFD_ACPI_MATCH_I2C,
>  };
>  
> -static const struct resource intel_quark_gpio_res[] = {
> +/* This is used as a place holder and will be modified at run-time */
> +static struct resource intel_quark_gpio_res[] = {
>  	[INTEL_QUARK_IORES_MEM] = {
>  		.flags = IORESOURCE_MEM,
>  	},
> -- 
> 2.30.1
> 

Sorry about that :(

Reviewed-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
