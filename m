Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA8372B96
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhEDOGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:06:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44968 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhEDOGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:06:39 -0400
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1ldvgF-0002j8-Tr
        for linux-kernel@vger.kernel.org; Tue, 04 May 2021 14:05:44 +0000
Received: by mail-qt1-f198.google.com with SMTP id g21-20020ac858150000b02901ba6163708bso3615486qtg.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 07:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d1Bg21TA2Y/XVBe2Xz6NvEf8Q9YHqIlZi+voDC9dIkU=;
        b=Z0Tun7WQ75EQR5bNPRMyuD/LRxksyymqGZA9A6Q2h0/aImBCMP9yGh20JRXwLLEZN0
         7A+xTmM46Ws/RJM3ahAHQo1/pZtvXAnAcPx9CH9gdSpTxwfc1RSSQOTfqySsR2txbj70
         fwfmZ4VyKCvwj/NeScGqff/5O+WKHdBAx4EiqBcC1CieJv3Ip7bw91OGce/YBUfRybVi
         cvoP/n5qhuWyO0eFVTsiMVInUOMpR8bekvTiHlwuUk4jVFK0syzrahKr3ZpVn8qRiayS
         hQNA1o1a0f/s/YcEQN36ZTp3DIqbLYDkf48q+mKw5vhG5iPHJBgg/2f46WOQ6f5yE88J
         V1Hw==
X-Gm-Message-State: AOAM533Tbgbh3OcX3M9eGN33Yyx1Ebvw/9c1a7FK23F8Lp5p5AP1fWgD
        FRldgb6/MuNO51nWF9qVdI5Oo+QnSXEYO+REAmlE7i3kaU3fFT1yop7WgcEBk4Vei2xrXX/KmFQ
        65Xv8G6OkMnJbhlX6zAn9BRFpP1c3HvaWBn64d1aphw==
X-Received: by 2002:a05:620a:12f3:: with SMTP id f19mr24609801qkl.214.1620137142628;
        Tue, 04 May 2021 07:05:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxV4MzmdYFEJ07rYueLywhsQ0lTRCYL70XhmxTt9vr5KUOS3gbBkBykA4ex5zwtjWF0SpRwvg==
X-Received: by 2002:a05:620a:12f3:: with SMTP id f19mr24609778qkl.214.1620137142398;
        Tue, 04 May 2021 07:05:42 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.49.3])
        by smtp.gmail.com with ESMTPSA id h65sm11173774qkd.112.2021.05.04.07.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 07:05:41 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] memory: mediatek: add DRAM controller driver
To:     Po-Kai Chi <pk.chi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        CC Hwang <cc.hwang@mediatek.com>
References: <1618565538-6972-1-git-send-email-pk.chi@mediatek.com>
 <1618565538-6972-3-git-send-email-pk.chi@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6f7472a2-3be2-e1dc-8e0f-83f6b1cdf61f@canonical.com>
Date:   Tue, 4 May 2021 10:05:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1618565538-6972-3-git-send-email-pk.chi@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2021 05:32, Po-Kai Chi wrote:
> MediaTek DRAM controller (DRAMC) driver provides cross-platform features
> as below:
> 
> 1. provide APIs for low power feature queries
> 2. create sysfs to pass the DRAM information to user-space
> 
> Signed-off-by: Po-Kai Chi <pk.chi@mediatek.com>
> ---
>  drivers/memory/Kconfig              |    1 +
>  drivers/memory/Makefile             |    1 +
>  drivers/memory/mediatek/Kconfig     |    9 +
>  drivers/memory/mediatek/Makefile    |    3 +
>  drivers/memory/mediatek/mtk-dramc.c |  711 +++++++++++++++++++++++++++++++++++
>  include/memory/mediatek/dramc.h     |   18 +
>  6 files changed, 743 insertions(+)
>  create mode 100644 drivers/memory/mediatek/Kconfig
>  create mode 100644 drivers/memory/mediatek/Makefile
>  create mode 100644 drivers/memory/mediatek/mtk-dramc.c
>  create mode 100644 include/memory/mediatek/dramc.h
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 72c0df1..056e906 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -225,6 +225,7 @@ config STM32_FMC2_EBI
>  	  devices (like SRAM, ethernet adapters, FPGAs, LCD displays, ...) on
>  	  SOCs containing the FMC2 External Bus Interface.
>  
> +source "drivers/memory/mediatek/Kconfig"

Please first group existing Mediatek driver there. It's messy.

>  source "drivers/memory/samsung/Kconfig"
>  source "drivers/memory/tegra/Kconfig"
>  
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index bc7663e..cd4f8cf 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_PL353_SMC)		+= pl353-smc.o
>  obj-$(CONFIG_RENESAS_RPCIF)	+= renesas-rpc-if.o
>  obj-$(CONFIG_STM32_FMC2_EBI)	+= stm32-fmc2-ebi.o
>  
> +obj-$(CONFIG_MTK_DRAMC)		+= mediatek/
>  obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
>  obj-$(CONFIG_TEGRA_MC)		+= tegra/
>  obj-$(CONFIG_TI_EMIF_SRAM)	+= ti-emif-sram.o
> diff --git a/drivers/memory/mediatek/Kconfig b/drivers/memory/mediatek/Kconfig
> new file mode 100644
> index 0000000..a1618b0
> --- /dev/null
> +++ b/drivers/memory/mediatek/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config MTK_DRAMC
> +	tristate "MediaTek DRAMC driver"
> +	help
> +	  This selects the MediaTek(R) DRAMC driver.
> +	  Provide the API for DRAMC low power scenario, and the interface
> +	  for reporting DRAM information, e.g. DRAM mode register (MR) for
> +	  DRAM vendor ID, temperature, and density.
> diff --git a/drivers/memory/mediatek/Makefile b/drivers/memory/mediatek/Makefile
> new file mode 100644
> index 0000000..632be48
> --- /dev/null
> +++ b/drivers/memory/mediatek/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_MTK_DRAMC)	+= mtk-dramc.o
> diff --git a/drivers/memory/mediatek/mtk-dramc.c b/drivers/memory/mediatek/mtk-dramc.c
> new file mode 100644
> index 0000000..155b3b7
> --- /dev/null
> +++ b/drivers/memory/mediatek/mtk-dramc.c
> @@ -0,0 +1,711 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 MediaTek Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <memory/mediatek/dramc.h>
> +
> +#define DRAMC_DRV_NAME	"mtk-dramc"

What does this define bring? What's the benefit?

> +
> +struct mr_info_t {
> +	unsigned int mr_index;
> +	unsigned int mr_value;
> +};
> +
> +/*

(...)

> +
> +static struct platform_driver dramc_drv = {
> +	.probe = dramc_probe,
> +	.remove = dramc_remove,
> +	.driver = {
> +		.name = DRAMC_DRV_NAME,
> +		.owner = THIS_MODULE,

NAK, this is so old mistake... No point to review - run Smatch, sparse,
checkpatch and coccinelle. Fix all the errors and then resubmit.

> +		.of_match_table = mtk_dramc_of_ids,
> +	},
> +};
> +
> +static int __init dramc_drv_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&dramc_drv);
> +	if (ret) {
> +		pr_info("%s: init fail, ret 0x%x\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static void __exit dramc_drv_exit(void)
> +{
> +	platform_driver_unregister(&dramc_drv);
> +}
> +
> +module_init(dramc_drv_init);
> +module_exit(dramc_drv_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("MediaTek DRAMC Driver");
> +MODULE_AUTHOR("Po-Kai Chi <pk.chi@mediatek.com>");
> diff --git a/include/memory/mediatek/dramc.h b/include/memory/mediatek/dramc.h
> new file mode 100644
> index 0000000..c8d200f
> --- /dev/null
> +++ b/include/memory/mediatek/dramc.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021 MediaTek Inc.
> + */
> +
> +#ifndef __DRAMC_H__

Extend the header guard - MEMORY_MEDIATEK_DRAMC

> +#define __DRAMC_H__



Best regards,
Krzysztof
