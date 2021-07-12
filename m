Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D843C59D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381376AbhGLJJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381601AbhGLJAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 05:00:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311B4C0613B1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 01:51:45 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q4so22931254ljp.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 01:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sR4KnKKgxHN9z8BeYEVAscsOfy0MsCFzGozgJRmjHoQ=;
        b=KBTKNUYZKpv1sfofoG4yBTpCqrXuE/QxxcU5XAWeL7z1AGVZFoAa5YAou4XmMVTWqr
         oKvV+cFzMqHu22KtQT1+v+8BIhMvn9fPjAqM+CkB2XEcVzcqyWrW/KgN16Lto6pSAWNW
         yMOezXNLCbp6WHbZzS+yVgpy7N2WIXBtiL8DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sR4KnKKgxHN9z8BeYEVAscsOfy0MsCFzGozgJRmjHoQ=;
        b=PI/cj+ryTOeWc87pbdXHuMIL2d3ehOTdv0ZFpdQooT/0k9cfnUX5ntB3uxDbS8BOTg
         4RPK48Vp2e8MDzmvzh8BQ0ls5VAu6tx7ej5okoY9SSbrBWxCq8udVZvbsQ7KcO54Y0A5
         arI29oiNe5VdsLVgqp4KbtSpc1Uwr1EwZio9p+3/pIWitsu9pQ49jVENlcha3i+nPOE6
         iSS4QzPfG5u6SCfACt2nAJrPAvAEX48Z+nSeG8NHE6VL4id8XmySCOsXAHQvs/ojZqx1
         Sc1myrSpUd6EpCz2Hn2mKYase8u7+tiM2RNqYA084DrfdqxZGIxuwyV5uiV7+x3kBVkM
         d3WQ==
X-Gm-Message-State: AOAM533B4Ti0E5XQrCZD/qaTqQRtiFaiuDNLr3E2oM/F5kxlfMZS51ym
        Byj1ACTyLSS6f/JJPteJ9nCs3UY/7POXSCv6uhwcbw==
X-Google-Smtp-Source: ABdhPJznoaETcAUcESZx3FrbuVmH9FyPfOB6iuI5K/5+igBo1ampLvrOGeE2zzhzQgFOCefiXeU1BA4Gn8l8OL90wfU=
X-Received: by 2002:a05:651c:2115:: with SMTP id a21mr41006635ljq.185.1626079903572;
 Mon, 12 Jul 2021 01:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com> <20210616224743.5109-23-chun-jie.chen@mediatek.com>
In-Reply-To: <20210616224743.5109-23-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 12 Jul 2021 16:51:32 +0800
Message-ID: <CAGXv+5EkunhQMnEP1gfkM-t1X+wUed1PkBTA+RZTdBQ3OGgd3g@mail.gmail.com>
Subject: Re: [PATCH 22/22] clk: mediatek: Add MT8195 apusys clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 17, 2021 at 7:00 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 apusys clock provider
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig                 |  6 ++
>  drivers/clk/mediatek/Makefile                |  1 +
>  drivers/clk/mediatek/clk-mt8195-apusys_pll.c | 84 ++++++++++++++++++++
>  3 files changed, 91 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-apusys_pll.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index ade85a52b7ed..9bd1ebff61f2 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -690,6 +690,12 @@ config COMMON_CLK_MT8195_IMP_IIC_WRAP
>         help
>           This driver supports MediaTek MT8195 imp_iic_wrap clocks.
>
> +config COMMON_CLK_MT8195_APUSYS_PLL
> +       bool "Clock driver for MediaTek MT8195 apusys_pll"
> +       depends on COMMON_CLK_MT8195
> +       help
> +         This driver supports MediaTek MT8195 apusys_pll clocks.
> +
>  config COMMON_CLK_MT8516
>         bool "Clock driver for MediaTek MT8516"
>         depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index b10c6267ba98..676ed7d665b7 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -98,5 +98,6 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS0) += clk-mt8195-vpp0.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS1) += clk-mt8195-vpp1.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_IMP_IIC_WRAP) += clk-mt8195-imp_iic_wrap.o
> +obj-$(CONFIG_COMMON_CLK_MT8195_APUSYS_PLL) += clk-mt8195-apusys_pll.o
>  obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
>  obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
> new file mode 100644
> index 000000000000..d9b49cf71281
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (c) 2021 MediaTek Inc.
> +// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +#include <dt-bindings/clock/mt8195-clk.h>
> +
> +#define MT8195_PLL_FMAX                (3800UL * MHZ)
> +#define MT8195_PLL_FMIN                (1500UL * MHZ)
> +#define MT8195_INTEGER_BITS    8
> +
> +#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags,      \
> +                       _rst_bar_mask, _pcwbits, _pd_reg, _pd_shift,    \
> +                       _tuner_reg, _tuner_en_reg, _tuner_en_bit,       \
> +                       _pcw_reg, _pcw_shift, _pcw_chg_reg,                             \
> +                       _en_reg, _pll_en_bit) {                                 \

Some of these fields are always set to zero in this driver. Either they
use the same value, or it means the particular function is not supported
in the hardware.

You could move the fixed value for unsupported functions, such as rst_bar_mask,
or even all common values, into the macro to simplify the macro argument list.
And if you do so, please also add comments explaining which values are shared,
and why they can be shared.

I believe the same could also be done for the APLL driver.

> +               .id = _id,                                              \
> +               .name = _name,                                          \
> +               .reg = _reg,                                            \
> +               .pwr_reg = _pwr_reg,                                    \
> +               .en_mask = _en_mask,                                    \
> +               .flags = _flags,                                        \
> +               .rst_bar_mask = _rst_bar_mask,                          \
> +               .fmax = MT8195_PLL_FMAX,                                \
> +               .fmin = MT8195_PLL_FMIN,                                \
> +               .pcwbits = _pcwbits,                                    \
> +               .pcwibits = MT8195_INTEGER_BITS,                        \
> +               .pd_reg = _pd_reg,                                      \
> +               .pd_shift = _pd_shift,                                  \
> +               .tuner_reg = _tuner_reg,                                \
> +               .tuner_en_reg = _tuner_en_reg,                          \
> +               .tuner_en_bit = _tuner_en_bit,                          \
> +               .pcw_reg = _pcw_reg,                                    \
> +               .pcw_shift = _pcw_shift,                                \
> +               .pcw_chg_reg = _pcw_chg_reg,                            \
> +               .en_reg = _en_reg,                                      \
> +               .pll_en_bit = _pll_en_bit,                              \
> +       }
> +
> +static const struct mtk_pll_data apusys_plls[] = {
> +       PLL(CLK_APUSYS_PLL_APUPLL, "apusys_pll_apupll", 0x008, 0x014, 0,
> +               0, 0, 22, 0x00c, 24, 0, 0, 0, 0x00c, 0, 0, 0, 0),
> +       PLL(CLK_APUSYS_PLL_NPUPLL, "apusys_pll_npupll", 0x018, 0x024, 0,
> +               0, 0, 22, 0x01c, 24, 0, 0, 0, 0x01c, 0, 0, 0, 0),
> +       PLL(CLK_APUSYS_PLL_APUPLL1, "apusys_pll_apupll1", 0x028, 0x034, 0,
> +               0, 0, 22, 0x02c, 24, 0, 0, 0, 0x02c, 0, 0, 0, 0),
> +       PLL(CLK_APUSYS_PLL_APUPLL2, "apusys_pll_apupll2", 0x038, 0x044, 0,
> +               0, 0, 22, 0x03c, 24, 0, 0, 0, 0x03c, 0, 0, 0, 0),

The datasheet doesn't provide names for these clocks. The values here look
correct though.

> +};
> +
> +static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
> +{
> +       struct clk_onecell_data *clk_data;
> +       struct device_node *node = pdev->dev.of_node;
> +
> +       clk_data = mtk_alloc_clk_data(CLK_APUSYS_PLL_NR_CLK);
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       mtk_clk_register_plls(node, apusys_plls, ARRAY_SIZE(apusys_plls), clk_data);
> +
> +       return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +}
> +
> +static const struct of_device_id of_match_clk_mt8195_apusys_pll[] = {
> +       { .compatible = "mediatek,mt8195-apusys_pll", },
> +       {}
> +};
> +
> +static struct platform_driver clk_mt8195_apusys_pll_drv = {
> +       .probe = clk_mt8195_apusys_pll_probe,
> +       .driver = {
> +               .name = "clk-mt8195-apusys_pll",
> +               .of_match_table = of_match_clk_mt8195_apusys_pll,
> +       },
> +};
> +

The general comments from the other patches apply as well


Regards
ChenYu


> +builtin_platform_driver(clk_mt8195_apusys_pll_drv);
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
