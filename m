Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B29A3A983C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhFPK64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFPK6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:58:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55D1C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:56:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d184so1034864wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mqtav1p2eGIlCeDNxDamFiLQ9JvCJAp/NHn6HJDl7ws=;
        b=LlzzH0yU5cwrNRuXMp+gnZvXur5zIuR+/F0xNpCMqo2FISJ1SnJ3F0HglNiOJ68eZl
         /yf1Jh8wH8i0v3Y7qyqnzOK2tDjT1tJR0HlhPd3JhKFOGH7jP86Ok8onerY78VraNjwi
         6UPBV/Z+OoXEYff7V10depNkRJ52MFRthAjuPwl4BL/8evwEUM/zm2hD/VSc/UxNczl3
         Kpq6R3RM3wF/QlbX6JrVfSWUKczb8BL/kNA681yFvvqwc7TTWcdh7gK8Pl1Qd/5Nr7aD
         W8WBP1USj/eQ4cCthJBFSsMkwFT/DkqUff2HqDHee8yz4XRadhgvZsmRvjs85Iil2ZZg
         jK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mqtav1p2eGIlCeDNxDamFiLQ9JvCJAp/NHn6HJDl7ws=;
        b=tu37sqjbI8X5tlpU37YuolPAIJhqRJD9pPuG47Tr7ZcqFAH3fswPT0veAIZj6nW954
         1CxswA7FMSuLD5/ohZSaU3aRhxKmJv4g3uc89py8RvsChF/1OxKNKXqH/BRIQA8dr6j8
         62gZ5Il7HjIv9SvLwGh1IdDMeEMkGERCsXU3oVOZYZBgN5cuO9hqdWvgkvsfsqfx8m98
         PJIBkg8aR4jdEH2JqckFOEWa035+wey9BpOgQrHX5V9ICNLuq+EfO9flxhnRCDaRwcpc
         V6n2vYW8IVAn9n9wrNY4nGYQ+C5oVDgm8afNVAjz94xxYPooEneOM83EcRJV9OkvfJeb
         cJ+Q==
X-Gm-Message-State: AOAM531wTI0yPQnBKNm3uTW5cShjqNGkorq7pgmCaAWy905tE40cRjCt
        GVLx0xy4bZVRpTHO/4ByOZKhjA==
X-Google-Smtp-Source: ABdhPJz43wcN+FLt1QNVCY7/pOzZPKj17A5L08c7F8uqd/ykLmh3ES0OIGZZDa42Ir3V2A0UuiDZTQ==
X-Received: by 2002:a05:600c:4106:: with SMTP id j6mr4521594wmi.76.1623841008320;
        Wed, 16 Jun 2021 03:56:48 -0700 (PDT)
Received: from dell (109-170-177-105.xdsl.murphx.net. [109.170.177.105])
        by smtp.gmail.com with ESMTPSA id o18sm4587094wmh.38.2021.06.16.03.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 03:56:47 -0700 (PDT)
Date:   Wed, 16 Jun 2021 11:56:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v6 2/5] mfd: sy7636a: Initial commit
Message-ID: <YMnY7RLW6ml4Tq0g@dell>
References: <20210615103400.946-1-alistair@alistair23.me>
 <20210615103400.946-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210615103400.946-2-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021, Alistair Francis wrote:

> Initial support for the Silergy SY7636A Power Management chip.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/mfd/Kconfig         |  9 ++++
>  drivers/mfd/Makefile        |  1 +
>  drivers/mfd/sy7636a.c       | 82 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/sy7636a.h | 47 +++++++++++++++++++++
>  4 files changed, 139 insertions(+)
>  create mode 100644 drivers/mfd/sy7636a.c
>  create mode 100644 include/linux/mfd/sy7636a.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 5c7f2b100191..7d6cf32b1549 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1339,6 +1339,15 @@ config MFD_SYSCON
>  	  Select this option to enable accessing system control registers
>  	  via regmap.
>  
> +config MFD_SY7636A
> +	tristate "Silergy SY7636A Power Management chip"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	depends on I2C
> +	help
> +	  Select this option to enable support for the Silergy SY7636A
> +	  Power Management chip.
> +
>  config MFD_DAVINCI_VOICECODEC
>  	tristate
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 4f6d2b8a5f76..f95e1e725a95 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -265,6 +265,7 @@ obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>  obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
>  obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
>  
> +obj-$(CONFIG_MFD_SY7636A)	+= sy7636a.o
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
>  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
>  obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
> new file mode 100644
> index 000000000000..e08f29ea63f8
> --- /dev/null
> +++ b/drivers/mfd/sy7636a.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//

Only the SPDX with C++ style comments please.

> +// MFD parent driver for SY7636A chip

Drop the MFD part.  It's a Linuxisum that doesn't really exist.

> +// Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> +//
> +// Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> +//          Alistair Francis <alistair@alistair23.me>
> +//
> +// Based on the lp87565 driver by Keerthy <j-keerthy@ti.com>
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
> +	{ .name = "sy7636a-temperature", },
> +	{ .name = "sy7636a-thermal", },
> +};
> +
> +static const struct of_device_id of_sy7636a_match_table[] = {
> +	{ .compatible = "silergy,sy7636a", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, of_sy7636a_match_table);

Hold on.  This driver doesn't really do anything.  If you create OF
nodes for all the sub-devices, you can use simple-mfd-i2c.

Any reason you can't do that?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
