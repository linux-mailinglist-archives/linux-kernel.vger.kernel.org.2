Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30B73D38F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 12:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhGWKRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhGWKRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:17:10 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FDFC061575;
        Fri, 23 Jul 2021 03:57:43 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id n1-20020a4ac7010000b0290262f3c22a63so285736ooq.9;
        Fri, 23 Jul 2021 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBz0dtgYVQrqON9ki19pyTXdgYHDHHRmKCuyorfFi3k=;
        b=gNgk1LKEKujs1nKd39082I8YamaBunLwrOQwlq8pncm6c675yr0pWk6kmCS9XMOEEH
         PnMK4I1OFmrXgZXF+oI4RbyBja7D6avLrEVOemcbgnAx2NnIXnLbNVrYr6V5RgGY2o3D
         aJHiR6tke5YdOOqdAatqtek7s0cBPwFR2rjdYz2AkAQJxflDIJ+dHiIjZRt03XskT2Th
         hJr/AIZLHjhwLoOJCyLUGHHHqA5G3BALpMQBHRxHrHjCbZWBHYonV30IOPwUdF4RROwf
         lHw/Brchq8OkpFtH4kIWeYBbhWP2qVQc2tkuXyNLIE/kRcr1StK/gL0pOV991mvlWSyi
         teIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBz0dtgYVQrqON9ki19pyTXdgYHDHHRmKCuyorfFi3k=;
        b=h7VMgaGpKpKds6+hCiGoMCnImFOpcj4h+GX5Cvka40PP9RPET1dtt85JU5YoLIjqXT
         uSyTNx/hFovjD00ISbo3JgFBYWgUVsrhCPji+ZepbNRTQIr/QB8EO7DCgjcUEra0pWkL
         e0/dkFbm915j0MrwNWYI48ATr+BWJl2VeHGPESUhTXrMm+M2ZOzH8E1jly6ml39cb6k5
         Zq670Tof9Jlxa0AQgYeLhrpcrj+B3HMnbl4HWMK7MIXEXJhV23qom+/AnAZxx/NbxzxP
         ciD03wc3Ral0KqxepPAAaT3mj2VlQ816zRqlMjpl0XdTw4TDWtPSqX9MJ/6nMsWSSBcC
         zDFw==
X-Gm-Message-State: AOAM532BTJ6dOk3v/1EATgs2M29PFT8x395Bfb38COAeIF2icaoFNMrr
        3sir7U8uq8GdEEERUwvH6dCedmv7Dfxd0jhtfRQ=
X-Google-Smtp-Source: ABdhPJw8nSLBKpusTpXWyNKMJwjdopgMNXsW6lFKCwJUrE9XCtlviYrXEYEDEZ2rwO2NCvaXLSV9snc2sIZ/oO9Dcto=
X-Received: by 2002:a4a:2a05:: with SMTP id k5mr2369005oof.0.1627037863046;
 Fri, 23 Jul 2021 03:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210722094551.15255-1-nancy.lin@mediatek.com> <20210722094551.15255-10-nancy.lin@mediatek.com>
In-Reply-To: <20210722094551.15255-10-nancy.lin@mediatek.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 23 Jul 2021 12:57:31 +0200
Message-ID: <CAFqH_53bnNvjGjZ2S8oyAx2t0if-YpQyZcb9sRapG2q21X4fGw@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] soc: mediatek: mmsys: Add reset controller
 support for MT8195 vdosys1
To:     "Nancy.Lin" <nancy.lin@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        devicetree <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        singo.chang@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nancy,

Thank you for your patch.

Missatge de Nancy.Lin <nancy.lin@mediatek.com> del dia dj., 22 de jul.
2021 a les 11:46:
>
> Among other features the mmsys driver should implement a reset
> controller to be able to reset different bits from their space.
>

I'm working on a series that does the same, it should be nice if we
can coordinate [1]

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=515355

> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> ---
>  drivers/soc/mediatek/mt8195-mmsys.h |  1 +
>  drivers/soc/mediatek/mtk-mmsys.c    | 77 +++++++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-mmsys.h    |  1 +
>  3 files changed, 79 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mt8195-mmsys.h b/drivers/soc/mediatek/mt8195-mmsys.h
> index 4bdb2087250c..a7f6e275bfe5 100644
> --- a/drivers/soc/mediatek/mt8195-mmsys.h
> +++ b/drivers/soc/mediatek/mt8195-mmsys.h
> @@ -154,6 +154,7 @@
>  #define DISP_DP_INTF0_SEL_IN_FROM_VDO0_MERGE_DL_ASYNC_MOUT     (1 << 0)
>  #define DISP_DP_INTF0_SEL_IN_FROM_VDO0_DSC_DL_ASYNC_MOUT       (2 << 0)
>
> +#define MT8195_VDO1_SW0_RST_B           0x1d0
>  #define MT8195_VDO1_MERGE0_ASYNC_CFG_WD        0xe30
>  #define MT8195_VDO1_MERGE1_ASYNC_CFG_WD        0xe40
>  #define MT8195_VDO1_MERGE2_ASYNC_CFG_WD        0xe50
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index d0f4a407f8f8..1ae04efeadab 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -4,10 +4,12 @@
>   * Author: James Liao <jamesjj.liao@mediatek.com>
>   */
>
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
>  #include <linux/soc/mediatek/mtk-mmsys.h>
>
>  #include "mtk-mmsys.h"
> @@ -15,6 +17,8 @@
>  #include "mt8183-mmsys.h"
>  #include "mt8195-mmsys.h"
>
> +#define MMSYS_SW_RESET_PER_REG 32
> +
>  static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
>         .clk_driver = "clk-mt2701-mm",
>         .routes = mmsys_default_routing_table,
> @@ -65,12 +69,15 @@ static const struct mtk_mmsys_driver_data mt8195_vdosys1_driver_data = {
>         .num_routes = ARRAY_SIZE(mmsys_mt8195_routing_table),
>         .config = mmsys_mt8195_config_table,
>         .num_configs = ARRAY_SIZE(mmsys_mt8195_config_table),
> +       .sw_reset_start = MT8195_VDO1_SW0_RST_B,

That change is interesting and I think I should also take it into
consideration with my series.

>  };
>
>  struct mtk_mmsys {
>         void __iomem *regs;
>         struct cmdq_client_reg cmdq_base;
>         const struct mtk_mmsys_driver_data *data;
> +       spinlock_t lock; /* protects mmsys_sw_rst_b reg */

Seems that mmsys_sw_rst_b reg has different names for different SoCs?
I mean I know that for MT8173 and MT8183 the register is called
mmsys_sw0_rst_b but looks like for MT8195 the name is vdo1_sw0_rst_b?
So maybe we should update this comment to be more generic.

> +       struct reset_controller_dev rcdev;
>  };
>
>  void mtk_mmsys_ddp_connect(struct device *dev,
> @@ -148,6 +155,63 @@ void mtk_mmsys_ddp_config(struct device *dev, enum mtk_mmsys_config_type config,
>  }
>  EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_config);
>
> +static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned long id,
> +                                 bool assert)
> +{
> +       struct mtk_mmsys *mmsys = container_of(rcdev, struct mtk_mmsys, rcdev);
> +       unsigned long flags;
> +       u32 reg;
> +       int i;
> +       u32 offset;
> +
> +       offset = (id / MMSYS_SW_RESET_PER_REG) * sizeof(u32);
> +       id = 1 << (id % MMSYS_SW_RESET_PER_REG);
> +
> +       spin_lock_irqsave(&mmsys->lock, flags);
> +
> +       reg = readl_relaxed(mmsys->regs + mmsys->data->sw_reset_start + offset);
> +
> +       if (assert)
> +               reg &= ~BIT(id);
> +       else
> +               reg |= BIT(id);
> +
> +       writel_relaxed(reg, mmsys->regs + mmsys->data->sw_reset_start + offset);
> +
> +       spin_unlock_irqrestore(&mmsys->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int mtk_mmsys_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +       return mtk_mmsys_reset_update(rcdev, id, true);
> +}
> +
> +static int mtk_mmsys_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +       return mtk_mmsys_reset_update(rcdev, id, false);
> +}
> +
> +static int mtk_mmsys_reset(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +       int ret;
> +
> +       ret = mtk_mmsys_reset_assert(rcdev, id);
> +       if (ret)
> +               return ret;
> +
> +       usleep_range(1000, 1100);
> +

One question that I received in my series, and I couldn't answer
because I don't have the datasheet, is if
is this known to be enough for all IP cores that can be reset by this
controller? Is this time specified in the datasheet?

> +       return mtk_mmsys_reset_deassert(rcdev, id);
> +}
> +
> +static const struct reset_control_ops mtk_mmsys_reset_ops = {
> +       .assert = mtk_mmsys_reset_assert,
> +       .deassert = mtk_mmsys_reset_deassert,
> +       .reset = mtk_mmsys_reset,
> +};
> +
>  static int mtk_mmsys_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -174,6 +238,19 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
>         if (ret)
>                 dev_dbg(dev, "No mediatek,gce-client-reg!\n");
>  #endif
> +
> +       spin_lock_init(&mmsys->lock);
> +
> +       mmsys->rcdev.owner = THIS_MODULE;
> +       mmsys->rcdev.nr_resets = 64;

Is the number of resets 64 for MT8195? I think is 32 for MT8173 and
MT8183. Can you confirm?

Thanks,
  Enric

> +       mmsys->rcdev.ops = &mtk_mmsys_reset_ops;
> +       mmsys->rcdev.of_node = pdev->dev.of_node;
> +       ret = devm_reset_controller_register(&pdev->dev, &mmsys->rcdev);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Couldn't register mmsys reset controller: %d\n", ret);
> +               return ret;
> +       }
> +
>         platform_set_drvdata(pdev, mmsys);
>
>         clks = platform_device_register_data(&pdev->dev, mmsys->data->clk_driver,
> diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
> index 084b1f5f3c88..cc57c3895c51 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.h
> +++ b/drivers/soc/mediatek/mtk-mmsys.h
> @@ -87,6 +87,7 @@ struct mtk_mmsys_driver_data {
>         const unsigned int num_routes;
>         const struct mtk_mmsys_config *config;
>         const unsigned int num_configs;
> +       u32 sw_reset_start;
>  };
>
>  /*
> --
> 2.18.0
>
