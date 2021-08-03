Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F0C3DEEEF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbhHCNQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbhHCNQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:16:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31040C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 06:16:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j2so25218033wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 06:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LY4ajhYYjBKNdvsHnzBXr58vU15+CDEnGQoQuQpIjrY=;
        b=Bo3krVhGkUb9iZzYD0LaPXEd677pZRw4pcUbpAy1L7wJiwJY++nLFBkXKEc4Hq5SMp
         3lOHGOlgdTqZHFk+lzT58stF2g7kcuzOpLXpvalxe9M2x4kcwVxHRc78nf0n4TJorPgI
         9NDNMlmGYNlEBh1k6mYJAiSWr2aGbhryQsCZWH3OxX94w8qFuoT+kjyifvKy9rpQxcnO
         xVLKJ3T3LF1NjCTNNWrf5894BHWt4RIozT5+oaZARyPmTWpPy4dRaAtzj3Z7n4Kvu62M
         4QepXSRg9SuTzFRI0yAE7ExCHdi7bCWv1XVQva0dsJ4hqGh2Hh4rapCtxKKdLlT3GF0h
         2OMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LY4ajhYYjBKNdvsHnzBXr58vU15+CDEnGQoQuQpIjrY=;
        b=qkpdYMxthmLbGZcSERQb2WuYMwlcjFpXKI3sbPGQCc9NKI2eNFzxyymmMFPaTNpObQ
         gh+Iwu4wq33onDF35rBPkERRidF7r9ajCJJsetdkC79kKK+5nwJXuWJ0FK8ej5mLYBzt
         H2sNwe5trYh3Qv6K9jIEqMGh9ZBFgCwLaomEkwy5t4N6Hx901u14wY3JV0sE8M/iTLyF
         1SJ23JXuLYLAvojjXhVpmwx+ycjBuQRFnmR20oluFWvAaQkw8YrWxTln1bTYuEBMn/00
         Z0FIhfkKm9IT6fvx7aapuzhto6M7z+37i0UFitN4y0EUHnGAhtpDnl578rQbKtJSHiyg
         ksRw==
X-Gm-Message-State: AOAM531HQENZyRoXSsdgwAncnwqvyYCLnq3F6QVku6zYr7zX7vRaccI7
        8AQ29PvzEabZjGwc6wf5dEUW7A==
X-Google-Smtp-Source: ABdhPJzU/OufZtp4hvQqfr8/P1Mac8bTSvwq0I8OeJ0OSDvThVu99FhN0auH+PrAGbUsSzQrv6la0w==
X-Received: by 2002:adf:f046:: with SMTP id t6mr23699153wro.266.1627996599750;
        Tue, 03 Aug 2021 06:16:39 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id c12sm14820845wrm.29.2021.08.03.06.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 06:16:39 -0700 (PDT)
Date:   Tue, 3 Aug 2021 14:16:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v8 02/11] mfd: sy7636a: Initial commit
Message-ID: <YQlBtQDrVHqh3N5D@google.com>
References: <20210803084456.198-1-alistair@alistair23.me>
 <20210803084456.198-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210803084456.198-2-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Aug 2021, Alistair Francis wrote:

> Initial support for the Silergy SY7636A Power Management chip.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/mfd/Kconfig         |  9 +++++
>  drivers/mfd/Makefile        |  1 +
>  drivers/mfd/sy7636a.c       | 72 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/sy7636a.h | 45 +++++++++++++++++++++++
>  4 files changed, 127 insertions(+)
>  create mode 100644 drivers/mfd/sy7636a.c
>  create mode 100644 include/linux/mfd/sy7636a.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 6a3fd2d75f96..b82208f0c79c 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1352,6 +1352,15 @@ config MFD_SYSCON
>  	  Select this option to enable accessing system control registers
>  	  via regmap.
>  
> +config MFD_SY7636A
> +	tristate "Silergy SY7636A Power Management IC"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	depends on I2C
> +	help
> +	  Select this option to enable support for the Silergy SY7636A
> +	  Power Management IC.
> +
>  config MFD_DAVINCI_VOICECODEC
>  	tristate
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 8116c19d5fd4..cbe581e87fa9 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -266,6 +266,7 @@ obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
>  obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
>  obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
>  
> +obj-$(CONFIG_MFD_SY7636A)	+= sy7636a.o
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
>  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
>  obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
> new file mode 100644
> index 000000000000..f3ff93c7395d
> --- /dev/null
> +++ b/drivers/mfd/sy7636a.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MFD parent driver for SY7636A chip
> + *
> + * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> + *
> + * Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> + *          Alistair Francis <alistair@alistair23.me>
> + *
> + * Based on the lp87565 driver by Keerthy <j-keerthy@ti.com>
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +
> +#include <linux/mfd/sy7636a.h>
> +
> +static const struct regmap_config sy7636a_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static const struct mfd_cell sy7636a_cells[] = {
> +	{ .name = "sy7636a-regulator", },

What kind of regulator is 'vcom'? LDO? DCDC?

> +	{ .name = "sy7636a-temperature", },
> +	{ .name = "sy7636a-thermal", },
> +};

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
