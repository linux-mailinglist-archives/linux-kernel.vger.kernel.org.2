Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194513D0F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbhGUMNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbhGUMNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:13:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD08C061766
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 05:54:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gx2so1590597pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 05:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iP4NUt/V0t1FXR1pars3ssyFHqsgxDoI/nyz3Is/Xqk=;
        b=gRk9/ILWwpLwl4zdj87BtAXrrYFGzkeVH6ObYfiKFfNQFmCyQIL6FYk80hsfm3asvB
         uGHNMJG+I/w9nTSOu1Yc/BAJFqRn1GkWPWM4/O1D8l2XKi6HSqHgNZzU3FokU5Idm1Tr
         ujF3MsuBvEb42eOWep8HcPBgTmsXD5KOQBb3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iP4NUt/V0t1FXR1pars3ssyFHqsgxDoI/nyz3Is/Xqk=;
        b=gQRTOIYN0fMYJ3bZA4p9q3omVYVoSNN0i/Mav18MCVV3P6sVA2L7A6P/NmEvx66u2Z
         ut183mo2AAItTDmprJa7zEGd5jQQnMpMN1Nq17XE/uSOd1q4VCv390zH+l6hftYFtEgU
         wFdFjVoQvZ1Or/3Gnu0+kdamzJSPTi0aCgpngCGM9BNLtdWCMnbcnIG2ZQW/njrNFqJE
         iGLoezu7tT5dvz9oXqV9gCYzpMFYg7zvGfX3zAn/nxHfS8f3ZoARYXLaplcAc9ymrgzG
         I8bFuUKVwUgKRFDcECOeK5kIGY36XmGZeqVLwmu+QI4jenLcgQur5lwu8RtcyR/B35hJ
         KuBw==
X-Gm-Message-State: AOAM530yhWO8kL8xDjS1XfmWU9eOKMf+/UpPoJTcor6ExJvvZOr2AUc1
        sJTzScJHvwEjCz4c0s0BoC4sXFRqX0rqYPnaF8cYQA==
X-Google-Smtp-Source: ABdhPJxsmHAT2BjdepvDkN94Ybs5nzq1uHhKtiM33GLd1tM4ZQBT6B0+xAjq7jQtTwOBEoILmIvJdMTSXTVC8Sch6dI=
X-Received: by 2002:a17:902:8c83:b029:129:17e5:a1cc with SMTP id
 t3-20020a1709028c83b029012917e5a1ccmr27602827plo.49.1626872051386; Wed, 21
 Jul 2021 05:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210715121209.31024-1-yong.wu@mediatek.com> <20210715121209.31024-11-yong.wu@mediatek.com>
In-Reply-To: <20210715121209.31024-11-yong.wu@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 21 Jul 2021 20:54:00 +0800
Message-ID: <CAATdQgDOGW7nudDoR5UPbax+d3e9omhPstrNd_FCPLd+96ZC9w@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] memory: mtk-smi: mt8195: Add initial setting for smi-common
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

On Thu, Jul 15, 2021 at 8:25 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> To improve the performance, add initial setting for smi-common.
> some register use some fix setting(suggested from DE).
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 42 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 3c288716a378..c52bf02458ff 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -18,11 +18,19 @@
>  #include <dt-bindings/memory/mtk-memory-port.h>
>
>  /* SMI COMMON */
> +#define SMI_L1LEN                      0x100
> +
>  #define SMI_BUS_SEL                    0x220
>  #define SMI_BUS_LARB_SHIFT(larbid)     ((larbid) << 1)
>  /* All are MMU0 defaultly. Only specialize mmu1 here. */
>  #define F_MMU1_LARB(larbid)            (0x1 << SMI_BUS_LARB_SHIFT(larbid))
>
> +#define SMI_M4U_TH                     0x234
> +#define SMI_FIFO_TH1                   0x238
> +#define SMI_FIFO_TH2                   0x23c
> +#define SMI_DCM                                0x300
> +#define SMI_DUMMY                      0x444
> +
>  /* SMI LARB */
>
>  /* Below are about mmu enable registers, they are different in SoCs */
> @@ -58,6 +66,13 @@
>         (_id << 8 | _id << 10 | _id << 12 | _id << 14); \
>  })
>
> +#define SMI_COMMON_INIT_REGS_NR                6
> +
> +struct mtk_smi_reg_pair {
> +       unsigned int            offset;
> +       u32                     value;
> +};
> +
>  enum mtk_smi_type {
>         MTK_SMI_GEN1,
>         MTK_SMI_GEN2,           /* gen2 smi common */
> @@ -74,6 +89,8 @@ static const char * const mtk_smi_larb_clks_optional[] = {"gals"};
>  struct mtk_smi_common_plat {
>         enum mtk_smi_type       type;
>         u32                     bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
> +
> +       const struct mtk_smi_reg_pair   *init;
>  };
>
>  struct mtk_smi_larb_gen {
> @@ -409,6 +426,15 @@ static struct platform_driver mtk_smi_larb_driver = {
>         }
>  };
>
> +static const struct mtk_smi_reg_pair mtk_smi_common_mt8195_init[SMI_COMMON_INIT_REGS_NR] = {
> +       {SMI_L1LEN, 0xb},
> +       {SMI_M4U_TH, 0xe100e10},
> +       {SMI_FIFO_TH1, 0x506090a},
> +       {SMI_FIFO_TH2, 0x506090a},
> +       {SMI_DCM, 0x4f1},
> +       {SMI_DUMMY, 0x1},
> +};
> +
>  static const struct mtk_smi_common_plat mtk_smi_common_gen1 = {
>         .type     = MTK_SMI_GEN1,
>  };
> @@ -439,11 +465,13 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8195_vdo = {
>         .type     = MTK_SMI_GEN2,
>         .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(3) | F_MMU1_LARB(5) |
>                     F_MMU1_LARB(7),
> +       .init     = mtk_smi_common_mt8195_init,
>  };
>
>  static const struct mtk_smi_common_plat mtk_smi_common_mt8195_vpp = {
>         .type     = MTK_SMI_GEN2,
>         .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(7),
> +       .init     = mtk_smi_common_mt8195_init,
>  };
>
>  static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8195 = {
> @@ -530,15 +558,21 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
>  static int __maybe_unused mtk_smi_common_resume(struct device *dev)
>  {
>         struct mtk_smi *common = dev_get_drvdata(dev);
> -       u32 bus_sel = common->plat->bus_sel;
> -       int ret;
> +       const struct mtk_smi_reg_pair *init = common->plat->init;
> +       u32 bus_sel = common->plat->bus_sel; /* default is 0 */
> +       int ret, i;
>
>         ret = clk_bulk_prepare_enable(common->clk_num, common->clks);
>         if (ret)
>                 return ret;
>
> -       if (common->plat->type == MTK_SMI_GEN2 && bus_sel)
> -               writel(bus_sel, common->base + SMI_BUS_SEL);
> +       if (common->plat->type != MTK_SMI_GEN2)
> +               return 0;
> +
> +       for (i = 0; i < SMI_COMMON_INIT_REGS_NR && init && init[i].offset; i++)
> +               writel_relaxed(init[i].value, common->base + init[i].offset);

I'm not sure this array for register settings could be applied to other
platforms in future or only applied to mt8195. If it's only for mt8195,
I think taking callback function instead of mtk_smi_reg_pair[] as init member
would be better:

if (common->plat->init)
    common->plat->init(...);

> +
> +       writel(bus_sel, common->base + SMI_BUS_SEL);
>         return 0;
>  }
>
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
