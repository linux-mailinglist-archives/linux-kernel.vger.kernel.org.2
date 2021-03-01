Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63C2327C01
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhCAKY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhCAKWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:22:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3BDC061356
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 02:20:15 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n4so12459395wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 02:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2zLTscw7wOIHCKJsbv7EvXNjRvEZ5kz74UBnGjXVjTU=;
        b=mFGrItjkvoJVrXpL5H/ZVBjEe7oWSGMKsJ1MYpIrrJJ5FnOb7ovdgJ1sSMRGqPrmy4
         zbEx4RbJd/92AsEcVc5qnwnlIe2ggvgRv3CjU95bus8OkCh9b+ZXoc2dHJK+dUkqF3re
         bVcZDKm75IGkVIbgk4aPThVgAWmVNUEH2PZ25GdTX/xOHloFP49SU1xlIRha1GuCLPDt
         X9BzZnHOD2t1Tc/t1Rodhsg7TwwNV1nAzaw4OFM90nkwT+gAdLwKVCkRh0gqabAHwHIl
         xxuNqHX/nsebxYm9ITkwxwIToKQD5ebSxv+jmTmV424wo2J/JZVYlxUJC/Hmk1lCSeo9
         zpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2zLTscw7wOIHCKJsbv7EvXNjRvEZ5kz74UBnGjXVjTU=;
        b=eL3/3tG3SOBjvyUhUoGnkVX4DAxqnpIrwZjs997/rMXuKByADA4rTXBcwBzHkS5XAS
         FxVCcRUs4MLrjJryc0H0rvXX2Q5ulJSX7ojDBnMJri6l3RVVm6P2xg53BtSyrLZWyHEu
         ClGfpmw7PDPs2YsCQXE8VvfI4VKc9Q2o9GscGMdZ/F+VkDhyD22WGb9StZ6YKA2W9juz
         a8CSQ+uyoJFvJ3IgB31qRGVzrD74bVMLSO7xgDRxAwewc6k+2dTEp8RZY0T6iuiD+ScC
         QMOBx7hd6fqAAPiHAZmWDAkGQLSsYZcGsdo6tB3rMyx8XdXAPAGXbzQoUHjQCv7ibHot
         8DWQ==
X-Gm-Message-State: AOAM533JPheWqcvJRSUn4VmLoggp2u9T5U+sQ39J7HFPwr6dct0RYfxx
        8kNBbh45siwe6Pab9Am3cSafpw==
X-Google-Smtp-Source: ABdhPJyhXqlY4O4GpeMZwaqlIPN28woGucyJtnjtzDIPSmpD7EdSB3oh3HNgXIRS1kknZvDUkQxMPA==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr15533330wmh.114.1614594013863;
        Mon, 01 Mar 2021 02:20:13 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id m17sm3837105wrx.92.2021.03.01.02.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 02:20:13 -0800 (PST)
Date:   Mon, 1 Mar 2021 10:20:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Fei Shao <fshao@chromium.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Yuchen Huang <yuchen.huang@mediatek.com>,
        Ran Bi <ran.bi@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH RESEND v5 5/8] mfd: Add support for the MediaTek MT6359
 PMIC
Message-ID: <20210301102011.GI641347@dell>
References: <1611913781-23460-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1611913781-23460-6-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1611913781-23460-6-git-send-email-hsin-hsiung.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021, Hsin-Hsiung Wang wrote:

> This adds support for the MediaTek MT6359 PMIC. This is a
> multifunction device with the following sub modules:
> 
> - Codec
> - Interrupt
> - Regulator
> - RTC
> 
> It is interfaced to the host controller using SPI interface
> by a proprietary hardware called PMIC wrapper or pwrap.
> MT6359 MFD is a child device of the pwrap.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
> changes since v4:
> - remove unused compatible name in the mt6359 mfd cells.
> ---
>  drivers/mfd/mt6358-irq.c             |  24 ++
>  drivers/mfd/mt6397-core.c            |  26 ++
>  include/linux/mfd/mt6359/core.h      | 133 +++++++
>  include/linux/mfd/mt6359/registers.h | 529 +++++++++++++++++++++++++++
>  include/linux/mfd/mt6397/core.h      |   1 +
>  5 files changed, 713 insertions(+)
>  create mode 100644 include/linux/mfd/mt6359/core.h
>  create mode 100644 include/linux/mfd/mt6359/registers.h
> 
> diff --git a/drivers/mfd/mt6358-irq.c b/drivers/mfd/mt6358-irq.c
> index 4b094e5e51cc..83f3ffbdbb4c 100644
> --- a/drivers/mfd/mt6358-irq.c
> +++ b/drivers/mfd/mt6358-irq.c
> @@ -5,6 +5,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/mfd/mt6358/core.h>
>  #include <linux/mfd/mt6358/registers.h>
> +#include <linux/mfd/mt6359/core.h>
> +#include <linux/mfd/mt6359/registers.h>
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -26,6 +28,17 @@ static const struct irq_top_t mt6358_ints[] = {
>  	MT6358_TOP_GEN(MISC),
>  };
>  
> +static const struct irq_top_t mt6359_ints[] = {
> +	MT6359_TOP_GEN(BUCK),
> +	MT6359_TOP_GEN(LDO),
> +	MT6359_TOP_GEN(PSC),
> +	MT6359_TOP_GEN(SCK),
> +	MT6359_TOP_GEN(BM),
> +	MT6359_TOP_GEN(HK),
> +	MT6359_TOP_GEN(AUD),
> +	MT6359_TOP_GEN(MISC),
> +};
> +
>  static struct pmic_irq_data mt6358_irqd = {
>  	.num_top = ARRAY_SIZE(mt6358_ints),
>  	.num_pmic_irqs = MT6358_IRQ_NR,
> @@ -33,6 +46,13 @@ static struct pmic_irq_data mt6358_irqd = {
>  	.pmic_ints = mt6358_ints,
>  };
>  
> +static struct pmic_irq_data mt6359_irqd = {
> +	.num_top = ARRAY_SIZE(mt6359_ints),
> +	.num_pmic_irqs = MT6359_IRQ_NR,
> +	.top_int_status_reg = MT6359_TOP_INT_STATUS0,
> +	.pmic_ints = mt6359_ints,
> +};
> +
>  static void pmic_irq_enable(struct irq_data *data)
>  {
>  	unsigned int hwirq = irqd_to_hwirq(data);
> @@ -195,6 +215,10 @@ int mt6358_irq_init(struct mt6397_chip *chip)
>  		chip->irq_data = &mt6358_irqd;
>  		break;
>  
> +	case MT6359_CHIP_ID:
> +		chip->irq_data = &mt6359_irqd;
> +		break;
> +
>  	default:
>  		dev_err(chip->dev, "unsupported chip: 0x%x\n", chip->chip_id);
>  		return -ENODEV;
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 7518d74c3b4c..617e4e4d5de0 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -13,9 +13,11 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/mt6323/core.h>
>  #include <linux/mfd/mt6358/core.h>
> +#include <linux/mfd/mt6359/core.h>
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/mfd/mt6323/registers.h>
>  #include <linux/mfd/mt6358/registers.h>
> +#include <linux/mfd/mt6359/registers.h>
>  #include <linux/mfd/mt6397/registers.h>
>  
>  #define MT6323_RTC_BASE		0x8000
> @@ -99,6 +101,19 @@ static const struct mfd_cell mt6358_devs[] = {
>  	},
>  };
>  
> +static const struct mfd_cell mt6359_devs[] = {
> +	{
> +		.name = "mt6359-regulator",
> +	}, {
> +		.name = "mt6359-rtc",
> +		.num_resources = ARRAY_SIZE(mt6358_rtc_resources),
> +		.resources = mt6358_rtc_resources,
> +		.of_compatible = "mediatek,mt6358-rtc",
> +	}, {
> +		.name = "mt6359-sound",
> +	},
> +};

Nit: Please put the single-line entries on one line.

Like this:

	{ .name = "mt6359-sound" },

>  static const struct mfd_cell mt6397_devs[] = {
>  	{
>  		.name = "mt6397-rtc",
> @@ -149,6 +164,14 @@ static const struct chip_data mt6358_core = {
>  	.irq_init = mt6358_irq_init,
>  };
>  
> +static const struct chip_data mt6359_core = {
> +	.cid_addr = MT6359_SWCID,
> +	.cid_shift = 8,
> +	.cells = mt6359_devs,
> +	.cell_size = ARRAY_SIZE(mt6359_devs),
> +	.irq_init = mt6358_irq_init,
> +};
> +
>  static const struct chip_data mt6397_core = {
>  	.cid_addr = MT6397_CID,
>  	.cid_shift = 0,
> @@ -218,6 +241,9 @@ static const struct of_device_id mt6397_of_match[] = {
>  	}, {
>  		.compatible = "mediatek,mt6358",
>  		.data = &mt6358_core,
> +	}, {
> +		.compatible = "mediatek,mt6359",
> +		.data = &mt6359_core,
>  	}, {
>  		.compatible = "mediatek,mt6397",
>  		.data = &mt6397_core,
> diff --git a/include/linux/mfd/mt6359/core.h b/include/linux/mfd/mt6359/core.h
> new file mode 100644
> index 000000000000..61872f1ecbe4
> --- /dev/null
> +++ b/include/linux/mfd/mt6359/core.h
> @@ -0,0 +1,133 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020 MediaTek Inc.

This is out of date.

> + */
> +
> +#ifndef __MFD_MT6359_CORE_H__
> +#define __MFD_MT6359_CORE_H__

[...]

> +#endif /* __MFD_MT6359_CORE_H__ */
> diff --git a/include/linux/mfd/mt6359/registers.h b/include/linux/mfd/mt6359/registers.h
> new file mode 100644
> index 000000000000..4d72f0a7f2b0
> --- /dev/null
> +++ b/include/linux/mfd/mt6359/registers.h
> @@ -0,0 +1,529 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020 MediaTek Inc.

This too.

> + */
> +
> +#ifndef __MFD_MT6359_REGISTERS_H__
> +#define __MFD_MT6359_REGISTERS_H__

[...]

> +#endif /* __MFD_MT6359_REGISTERS_H__ */
> diff --git a/include/linux/mfd/mt6397/core.h b/include/linux/mfd/mt6397/core.h
> index 949268581b36..56f210eebc54 100644
> --- a/include/linux/mfd/mt6397/core.h
> +++ b/include/linux/mfd/mt6397/core.h
> @@ -13,6 +13,7 @@
>  enum chip_id {
>  	MT6323_CHIP_ID = 0x23,
>  	MT6358_CHIP_ID = 0x58,
> +	MT6359_CHIP_ID = 0x59,
>  	MT6391_CHIP_ID = 0x91,
>  	MT6397_CHIP_ID = 0x97,
>  };

Once you fixed those issues, feel free to add my:

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
