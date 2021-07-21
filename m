Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4563D0CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240301AbhGUKPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239690AbhGUKGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:06:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0FFC0610D3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:44:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id jx7-20020a17090b46c7b02901757deaf2c8so791818pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m9KfU32Td3xB/wuWNhNbDVpIahkZHa5eXkr6/E8GaKE=;
        b=he/bvGRxDLSF7f0GBNdzXYHRkkjCsYcba5AlfCdmFGNOSPALoTInP/YKKXJkwF2DPu
         90L1sVjKnum25CXgGjAHi/E3U9XJXUxXyt6f2VlovfiI7NI4CGfsdLzyn12fuW0W5d4g
         xlb3wCH4NBfE83xkTJy7oGw7zBhZkEwfYc3Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9KfU32Td3xB/wuWNhNbDVpIahkZHa5eXkr6/E8GaKE=;
        b=YAJmtbewaLoOd8P5Asdb4eZUigSWmaMug6mwuf9ZKN/gEvnQfwoIyejd+HS2euxx05
         tYuexv98p4xop+DrwgV9k5xfrZSm3JviIHtBPRqwS78XzUpqeXrM4CZEiRTnRrjh0bka
         XQ33zvsOWWgTM7cweoio3MNtVljF1E1x+qhDRpWwjh3tIUR32ZiZM091NM3NnW1MzFNL
         itsA/gt76PFV+r1lPGPhNd2Z8PciyfthDsJwRrnmktihvIuM4Od4sxxA77rTB/+J2mpd
         MPbkw1ydCgq1ikEoYi4ftr2nRp7135Weul7WeYpYKLmCvK6U5M4EMh5+mZCT0HPqnDjs
         7SiA==
X-Gm-Message-State: AOAM5302zFGfl8XxCWN4uE/C1StwNb8Me4Kex454o2HOmqTHtV94ZA6g
        B+R1CRcWYCTOq4OggXqQQySV7QNLcrkofwdzutnx0g==
X-Google-Smtp-Source: ABdhPJwMQyEj40wDyMHpYAAPz6Zr7HtqGIr3IjYBKZh75hmdijcf7C1xGMIP2NE1ifwpN1NaVPhToI/+eV5K9Fo7Ztc=
X-Received: by 2002:a17:902:8c83:b029:129:17e5:a1cc with SMTP id
 t3-20020a1709028c83b029012917e5a1ccmr27210970plo.49.1626864289274; Wed, 21
 Jul 2021 03:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210715121209.31024-1-yong.wu@mediatek.com> <20210715121209.31024-6-yong.wu@mediatek.com>
In-Reply-To: <20210715121209.31024-6-yong.wu@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 21 Jul 2021 18:44:37 +0800
Message-ID: <CAATdQgB4P=7Wvhc_SBxy1tGKRXD7qukc95bGNJJ=ECyVm_dgHQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] memory: mtk-smi: Adjust some code position
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, anthony.huang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 15, 2021 at 8:23 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> No functional change. Only move the code position to make the code more
> readable.
> 1. Put the register smi-common above smi-larb. Prepare to add some others
>    register setting.
> 2. Put mtk_smi_larb_unbind around larb_bind.
> 3. Sort the SoC data alphabetically. and put them in one line as the
>    current kernel allow it.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

> ---
>  drivers/memory/mtk-smi.c | 185 +++++++++++++++------------------------
>  1 file changed, 73 insertions(+), 112 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index ff07b14bcd66..6f8e582bace5 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -17,12 +17,15 @@
>  #include <dt-bindings/memory/mt2701-larb-port.h>
>  #include <dt-bindings/memory/mtk-memory-port.h>
>
> -/* mt8173 */
> -#define SMI_LARB_MMU_EN                0xf00
> +/* SMI COMMON */
> +#define SMI_BUS_SEL                    0x220
> +#define SMI_BUS_LARB_SHIFT(larbid)     ((larbid) << 1)
> +/* All are MMU0 defaultly. Only specialize mmu1 here. */
> +#define F_MMU1_LARB(larbid)            (0x1 << SMI_BUS_LARB_SHIFT(larbid))
>
> -/* mt8167 */
> -#define MT8167_SMI_LARB_MMU_EN 0xfc0
> +/* SMI LARB */
>
> +/* Below are about mmu enable registers, they are different in SoCs */
>  /* mt2701 */
>  #define REG_SMI_SECUR_CON_BASE         0x5c0
>
> @@ -41,20 +44,20 @@
>  /* mt2701 domain should be set to 3 */
>  #define SMI_SECUR_CON_VAL_DOMAIN(id)   (0x3 << ((((id) & 0x7) << 2) + 1))
>
> -/* mt2712 */
> -#define SMI_LARB_NONSEC_CON(id)        (0x380 + ((id) * 4))
> -#define F_MMU_EN               BIT(0)
> -#define BANK_SEL(id)           ({                      \
> +/* mt8167 */
> +#define MT8167_SMI_LARB_MMU_EN         0xfc0
> +
> +/* mt8173 */
> +#define MT8173_SMI_LARB_MMU_EN         0xf00
> +
> +/* larb gen2 */
> +#define SMI_LARB_NONSEC_CON(id)                (0x380 + ((id) * 4))
> +#define F_MMU_EN                       BIT(0)
> +#define BANK_SEL(id)                   ({              \
>         u32 _id = (id) & 0x3;                           \
>         (_id << 8 | _id << 10 | _id << 12 | _id << 14); \
>  })
>
> -/* SMI COMMON */
> -#define SMI_BUS_SEL                    0x220
> -#define SMI_BUS_LARB_SHIFT(larbid)     ((larbid) << 1)
> -/* All are MMU0 defaultly. Only specialize mmu1 here. */
> -#define F_MMU1_LARB(larbid)            (0x1 << SMI_BUS_LARB_SHIFT(larbid))
> -
>  enum mtk_smi_type {
>         MTK_SMI_GEN1,
>         MTK_SMI_GEN2
> @@ -132,36 +135,16 @@ mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
>         return -ENODEV;
>  }
>
> -static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
> -{
> -       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> -       u32 reg;
> -       int i;
> -
> -       if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
> -               return;
> -
> -       for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
> -               reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
> -               reg |= F_MMU_EN;
> -               reg |= BANK_SEL(larb->bank[i]);
> -               writel(reg, larb->base + SMI_LARB_NONSEC_CON(i));
> -       }
> -}
> -
> -static void mtk_smi_larb_config_port_mt8173(struct device *dev)
> +static void
> +mtk_smi_larb_unbind(struct device *dev, struct device *master, void *data)
>  {
> -       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> -
> -       writel(*larb->mmu, larb->base + SMI_LARB_MMU_EN);
> +       /* Do nothing as the iommu is always enabled. */
>  }
>
> -static void mtk_smi_larb_config_port_mt8167(struct device *dev)
> -{
> -       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> -
> -       writel(*larb->mmu, larb->base + MT8167_SMI_LARB_MMU_EN);
> -}
> +static const struct component_ops mtk_smi_larb_component_ops = {
> +       .bind = mtk_smi_larb_bind,
> +       .unbind = mtk_smi_larb_unbind,
> +};
>
>  static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  {
> @@ -194,26 +177,36 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>         }
>  }
>
> -static void
> -mtk_smi_larb_unbind(struct device *dev, struct device *master, void *data)
> +static void mtk_smi_larb_config_port_mt8167(struct device *dev)
>  {
> -       /* Do nothing as the iommu is always enabled. */
> +       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +
> +       writel(*larb->mmu, larb->base + MT8167_SMI_LARB_MMU_EN);
>  }
>
> -static const struct component_ops mtk_smi_larb_component_ops = {
> -       .bind = mtk_smi_larb_bind,
> -       .unbind = mtk_smi_larb_unbind,
> -};
> +static void mtk_smi_larb_config_port_mt8173(struct device *dev)
> +{
> +       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
>
> -static const struct mtk_smi_larb_gen mtk_smi_larb_mt8173 = {
> -       /* mt8173 do not need the port in larb */
> -       .config_port = mtk_smi_larb_config_port_mt8173,
> -};
> +       writel(*larb->mmu, larb->base + MT8173_SMI_LARB_MMU_EN);
> +}
>
> -static const struct mtk_smi_larb_gen mtk_smi_larb_mt8167 = {
> -       /* mt8167 do not need the port in larb */
> -       .config_port = mtk_smi_larb_config_port_mt8167,
> -};
> +static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
> +{
> +       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +       u32 reg;
> +       int i;
> +
> +       if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
> +               return;
> +
> +       for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
> +               reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
> +               reg |= F_MMU_EN;
> +               reg |= BANK_SEL(larb->bank[i]);
> +               writel(reg, larb->base + SMI_LARB_NONSEC_CON(i));
> +       }
> +}
>
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
>         .port_in_larb = {
> @@ -235,6 +228,16 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt6779 = {
>                 /* DUMMY | IPU0 | IPU1 | CCU | MDLA */
>  };
>
> +static const struct mtk_smi_larb_gen mtk_smi_larb_mt8167 = {
> +       /* mt8167 do not need the port in larb */
> +       .config_port = mtk_smi_larb_config_port_mt8167,
> +};
> +
> +static const struct mtk_smi_larb_gen mtk_smi_larb_mt8173 = {
> +       /* mt8173 do not need the port in larb */
> +       .config_port = mtk_smi_larb_config_port_mt8173,
> +};
> +
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
>         .config_port                = mtk_smi_larb_config_port_gen2_general,
>         .larb_direct_to_common_mask = BIT(2) | BIT(3) | BIT(7),
> @@ -246,34 +249,13 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
>  };
>
>  static const struct of_device_id mtk_smi_larb_of_ids[] = {
> -       {
> -               .compatible = "mediatek,mt8167-smi-larb",
> -               .data = &mtk_smi_larb_mt8167
> -       },
> -       {
> -               .compatible = "mediatek,mt8173-smi-larb",
> -               .data = &mtk_smi_larb_mt8173
> -       },
> -       {
> -               .compatible = "mediatek,mt2701-smi-larb",
> -               .data = &mtk_smi_larb_mt2701
> -       },
> -       {
> -               .compatible = "mediatek,mt2712-smi-larb",
> -               .data = &mtk_smi_larb_mt2712
> -       },
> -       {
> -               .compatible = "mediatek,mt6779-smi-larb",
> -               .data = &mtk_smi_larb_mt6779
> -       },
> -       {
> -               .compatible = "mediatek,mt8183-smi-larb",
> -               .data = &mtk_smi_larb_mt8183
> -       },
> -       {
> -               .compatible = "mediatek,mt8192-smi-larb",
> -               .data = &mtk_smi_larb_mt8192
> -       },
> +       {.compatible = "mediatek,mt2701-smi-larb", .data = &mtk_smi_larb_mt2701},
> +       {.compatible = "mediatek,mt2712-smi-larb", .data = &mtk_smi_larb_mt2712},
> +       {.compatible = "mediatek,mt6779-smi-larb", .data = &mtk_smi_larb_mt6779},
> +       {.compatible = "mediatek,mt8167-smi-larb", .data = &mtk_smi_larb_mt8167},
> +       {.compatible = "mediatek,mt8173-smi-larb", .data = &mtk_smi_larb_mt8173},
> +       {.compatible = "mediatek,mt8183-smi-larb", .data = &mtk_smi_larb_mt8183},
> +       {.compatible = "mediatek,mt8192-smi-larb", .data = &mtk_smi_larb_mt8192},
>         {}
>  };
>
> @@ -428,34 +410,13 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
>  };
>
>  static const struct of_device_id mtk_smi_common_of_ids[] = {
> -       {
> -               .compatible = "mediatek,mt8173-smi-common",
> -               .data = &mtk_smi_common_gen2,
> -       },
> -       {
> -               .compatible = "mediatek,mt8167-smi-common",
> -               .data = &mtk_smi_common_gen2,
> -       },
> -       {
> -               .compatible = "mediatek,mt2701-smi-common",
> -               .data = &mtk_smi_common_gen1,
> -       },
> -       {
> -               .compatible = "mediatek,mt2712-smi-common",
> -               .data = &mtk_smi_common_gen2,
> -       },
> -       {
> -               .compatible = "mediatek,mt6779-smi-common",
> -               .data = &mtk_smi_common_mt6779,
> -       },
> -       {
> -               .compatible = "mediatek,mt8183-smi-common",
> -               .data = &mtk_smi_common_mt8183,
> -       },
> -       {
> -               .compatible = "mediatek,mt8192-smi-common",
> -               .data = &mtk_smi_common_mt8192,
> -       },
> +       {.compatible = "mediatek,mt2701-smi-common", .data = &mtk_smi_common_gen1},
> +       {.compatible = "mediatek,mt2712-smi-common", .data = &mtk_smi_common_gen2},
> +       {.compatible = "mediatek,mt6779-smi-common", .data = &mtk_smi_common_mt6779},
> +       {.compatible = "mediatek,mt8167-smi-common", .data = &mtk_smi_common_gen2},
> +       {.compatible = "mediatek,mt8173-smi-common", .data = &mtk_smi_common_gen2},
> +       {.compatible = "mediatek,mt8183-smi-common", .data = &mtk_smi_common_mt8183},
> +       {.compatible = "mediatek,mt8192-smi-common", .data = &mtk_smi_common_mt8192},
>         {}
>  };
>
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
