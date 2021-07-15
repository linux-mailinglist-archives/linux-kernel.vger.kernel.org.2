Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF873CAF9E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 01:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhGOXYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 19:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhGOXYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 19:24:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADBAC613DF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 23:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626391288;
        bh=9I1FQ/xlcSW6V6YDMUT0pMaXY4C/E6hCW9gWiy8s3os=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=odKvTiXa8PolDvohfp8Ywk3tqitzgFx+sx2m0EqratAiYZchpHLtEvj46p4UxKK6D
         MfnBqNL5pHzhKBRHA0KzTm7KBVJdUkpaDVl8HUyaTZxhvIzIErCQeUmPz9btN6ShhD
         P8BXsmQ8isCOqwpj4dURHh83waF2/zvHIUmOXD0Qx31KSGkyjhyvjP43r9nD3TfIqe
         ma9/6Md14elEGrJ/ocELrb7Sr0X4YmcTpPgDTQXoYgRTLA6GMG8im57khdnJQ4zTb6
         om+UKWfroqCIoZ6geAa8ZGJrJrIPaDyr3ZtUdZmy3CISjaqV7wzkopBc8oOSjbF//W
         sUGcDzL2XTsyw==
Received: by mail-ed1-f50.google.com with SMTP id t2so10107066edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 16:21:28 -0700 (PDT)
X-Gm-Message-State: AOAM531FZj7v1AWauJLYJh5EZ6VOk+9voxTeFg976YimYVedJm9UrD0I
        rkXjMj+PHC29UgUl56MVD4O8IfMOO530FrVJhg==
X-Google-Smtp-Source: ABdhPJzEhN36gQfGsMcLv2BgUwXFmuuMM8AtTbTw5t0ccG0IdeI22HNgLrMOjlfYyUtnxwWoHzlk3ImJxnnoz+KrSZ4=
X-Received: by 2002:a05:6402:17d3:: with SMTP id s19mr10365031edy.49.1626391287133;
 Thu, 15 Jul 2021 16:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210715173750.10852-1-jason-jh.lin@mediatek.com> <20210715173750.10852-12-jason-jh.lin@mediatek.com>
In-Reply-To: <20210715173750.10852-12-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 16 Jul 2021 07:21:15 +0800
X-Gmail-Original-Message-ID: <CAAOTY__4LUowqv6T6s5bC94Ed8HjM2qWbB4M3_G3m_sDh6nkSg@mail.gmail.com>
Message-ID: <CAAOTY__4LUowqv6T6s5bC94Ed8HjM2qWbB4M3_G3m_sDh6nkSg@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] drm/mediatek: add DSC support for MT8195
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        fshao@google.com, Nancy Lin <nancy.lin@mediatek.com>,
        singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=881=
6=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:38=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add DSC module file:
>   DSC is designed for real-time systems with real-time compression,
>   transmission, decompression and display.
>   The DSC standard is a specification of the algorithms used for
>   compressing and decompressing image display streams, including
>   the specification of the syntax and semantics of the compressed
>   video bit stream.
>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/Makefile           |   1 +
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h     |   8 +
>  drivers/gpu/drm/mediatek/mtk_disp_dsc.c     | 161 ++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  19 ++-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   1 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   8 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   1 +
>  7 files changed, 194 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_dsc.c
>
> diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek=
/Makefile
> index dc54a7a69005..44948e221fd3 100644
> --- a/drivers/gpu/drm/mediatek/Makefile
> +++ b/drivers/gpu/drm/mediatek/Makefile
> @@ -2,6 +2,7 @@
>
>  mediatek-drm-y :=3D mtk_disp_ccorr.o \
>                   mtk_disp_color.o \
> +                 mtk_disp_dsc.o \
>                   mtk_disp_gamma.o \
>                   mtk_disp_ovl.o \
>                   mtk_disp_rdma.o \
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/me=
diatek/mtk_disp_drv.h
> index cafd9df2d63b..c7e9bd370acd 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> @@ -33,6 +33,14 @@ void mtk_dither_set_common(void __iomem *regs, struct =
cmdq_client_reg *cmdq_reg,
>  void mtk_dpi_start(struct device *dev);
>  void mtk_dpi_stop(struct device *dev);
>
> +int mtk_dsc_clk_enable(struct device *dev);
> +void mtk_dsc_clk_disable(struct device *dev);
> +void mtk_dsc_config(struct device *dev, unsigned int width,
> +                   unsigned int height, unsigned int vrefresh,
> +                   unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
> +void mtk_dsc_start(struct device *dev);
> +void mtk_dsc_stop(struct device *dev);
> +
>  void mtk_dsi_ddp_start(struct device *dev);
>  void mtk_dsi_ddp_stop(struct device *dev);
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_dsc.c b/drivers/gpu/drm/me=
diatek/mtk_disp_dsc.c
> new file mode 100644
> index 000000000000..6a196220c532
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_dsc.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 MediaTek Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/component.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/mediatek/mtk-cmdq.h>
> +
> +#include "mtk_drm_crtc.h"
> +#include "mtk_drm_ddp_comp.h"
> +#include "mtk_drm_gem.h"
> +#include "mtk_disp_drv.h"
> +
> +#define DISP_REG_DSC_CON                       0x0000
> +#define DSC_EN                                 BIT(0)
> +#define DSC_DUAL_INOUT                         BIT(2)
> +#define DSC_BYPASS                             BIT(4)
> +#define DSC_UFOE_SEL                           BIT(16)
> +
> +/**
> + * struct mtk_disp_dsc - DISP_DSC driver structure
> + * @clk - clk of dsc hardware
> + * @regs - hardware register address of dsc
> + * @cmdq_reg - structure containing cmdq hardware resource
> + */
> +struct mtk_disp_dsc {
> +       struct clk *clk;
> +       void __iomem *regs;
> +       struct cmdq_client_reg          cmdq_reg;
> +};

Squash mtk_disp_dsc.c into mtk_drm_ddp_comp.c and this patch would be
much simpler.

> +
> +void mtk_dsc_start(struct device *dev)
> +{
> +       struct mtk_disp_dsc *dsc =3D dev_get_drvdata(dev);
> +       void __iomem *baddr =3D dsc->regs;

baddr is used only once, so use dsc->regs directly.

> +
> +       mtk_ddp_write_mask(NULL, DSC_EN, &dsc->cmdq_reg, baddr,
> +                          DISP_REG_DSC_CON, DSC_EN);
> +}
> +
> +void mtk_dsc_stop(struct device *dev)
> +{
> +       struct mtk_disp_dsc *dsc =3D dev_get_drvdata(dev);
> +       void __iomem *baddr =3D dsc->regs;

Ditto.

> +
> +       mtk_ddp_write_mask(NULL, 0x0, &dsc->cmdq_reg, baddr,
> +                          DISP_REG_DSC_CON, DSC_EN);
> +}
> +
> +int mtk_dsc_clk_enable(struct device *dev)
> +{
> +       struct mtk_disp_dsc *dsc =3D dev_get_drvdata(dev);
> +
> +       return clk_prepare_enable(dsc->clk);
> +}
> +
> +void mtk_dsc_clk_disable(struct device *dev)
> +{
> +       struct mtk_disp_dsc *dsc =3D dev_get_drvdata(dev);
> +
> +       clk_disable_unprepare(dsc->clk);
> +}
> +
> +void mtk_dsc_config(struct device *dev, unsigned int w,
> +                   unsigned int h, unsigned int vrefresh,
> +                   unsigned int bpc, struct cmdq_pkt *handle)
> +{
> +       struct mtk_disp_dsc *dsc =3D dev_get_drvdata(dev);
> +
> +       /* dsc bypass mode */
> +       mtk_ddp_write_mask(handle, DSC_BYPASS, &dsc->cmdq_reg, dsc->regs,
> +                          DISP_REG_DSC_CON, DSC_BYPASS);
> +       mtk_ddp_write_mask(handle, DSC_UFOE_SEL, &dsc->cmdq_reg, dsc->reg=
s,
> +                          DISP_REG_DSC_CON, DSC_UFOE_SEL);
> +       mtk_ddp_write_mask(handle, DSC_DUAL_INOUT, &dsc->cmdq_reg, dsc->r=
egs,
> +                          DISP_REG_DSC_CON, DSC_DUAL_INOUT);
> +}
> +
> +static int mtk_disp_dsc_bind(struct device *dev, struct device *master,
> +                            void *data)
> +{
> +       return 0;
> +}
> +
> +static void mtk_disp_dsc_unbind(struct device *dev, struct device *maste=
r,
> +                               void *data)
> +{
> +}
> +
> +static const struct component_ops mtk_disp_dsc_component_ops =3D {
> +       .bind =3D mtk_disp_dsc_bind,
> +       .unbind =3D mtk_disp_dsc_unbind,
> +};
> +
> +static int mtk_disp_dsc_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct resource *res;
> +       struct mtk_disp_dsc *priv;
> +       int irq;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->clk =3D devm_clk_get(dev, NULL);
> +       if (IS_ERR(priv->clk)) {
> +               dev_err(dev, "failed to get dsc clk\n");
> +               return PTR_ERR(priv->clk);
> +       }
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       priv->regs =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(priv->regs)) {
> +               dev_err(dev, "failed to ioremap dsc\n");
> +               return PTR_ERR(priv->regs);
> +       }
> +
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +       ret =3D cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
> +       if (ret)
> +               dev_dbg(dev, "get mediatek,gce-client-reg fail!\n");
> +#endif
> +
> +       platform_set_drvdata(pdev, priv);
> +
> +       ret =3D component_add(dev, &mtk_disp_dsc_component_ops);
> +       if (ret !=3D 0)
> +               dev_err(dev, "Failed to add component: %d\n", ret);
> +
> +       return ret;
> +}
> +
> +static int mtk_disp_dsc_remove(struct platform_device *pdev)
> +{
> +       component_del(&pdev->dev, &mtk_disp_dsc_component_ops);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id mtk_disp_dsc_driver_dt_match[] =3D {
> +       { .compatible =3D "mediatek,mt8195-disp-dsc", },
> +       {},
> +};
> +
> +MODULE_DEVICE_TABLE(of, mtk_disp_dsc_driver_dt_match);
> +
> +struct platform_driver mtk_disp_dsc_driver =3D {
> +       .probe =3D mtk_disp_dsc_probe,
> +       .remove =3D mtk_disp_dsc_remove,
> +       .driver =3D {
> +               .name =3D "mediatek-disp-dsc",
> +               .owner =3D THIS_MODULE,
> +               .of_match_table =3D mtk_disp_dsc_driver_dt_match,
> +       },
> +};
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 75bc00e17fc4..ba3d7a1ce7ab 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -333,6 +333,14 @@ static const struct mtk_ddp_comp_funcs ddp_rdma =3D =
{
>         .layer_config =3D mtk_rdma_layer_config,
>  };
>
> +static const struct mtk_ddp_comp_funcs ddp_dsc =3D {
> +       .config =3D mtk_dsc_config,
> +       .start =3D mtk_dsc_start,
> +       .stop =3D mtk_dsc_stop,
> +       .clk_enable =3D mtk_dsc_clk_enable,
> +       .clk_disable =3D mtk_dsc_clk_disable,
> +};
> +
>  static const struct mtk_ddp_comp_funcs ddp_ufoe =3D {
>         .clk_enable =3D mtk_ddp_clk_enable,
>         .clk_disable =3D mtk_ddp_clk_disable,
> @@ -356,6 +364,7 @@ static const char * const mtk_ddp_comp_stem[MTK_DDP_C=
OMP_TYPE_MAX] =3D {
>         [MTK_DISP_MUTEX] =3D "mutex",
>         [MTK_DISP_OD] =3D "od",
>         [MTK_DISP_BLS] =3D "bls",
> +       [MTK_DISP_DSC] =3D "dsc",
>  };
>
>  struct mtk_ddp_comp_match {
> @@ -374,6 +383,9 @@ static const struct mtk_ddp_comp_match mtk_ddp_matche=
s[DDP_COMPONENT_ID_MAX] =3D {
>         [DDP_COMPONENT_DITHER]  =3D { MTK_DISP_DITHER,    0, &ddp_dither =
},
>         [DDP_COMPONENT_DPI0]    =3D { MTK_DPI,            0, &ddp_dpi },
>         [DDP_COMPONENT_DPI1]    =3D { MTK_DPI,            1, &ddp_dpi },
> +       [DDP_COMPONENT_DSC0]    =3D { MTK_DISP_DSC,       0, &ddp_dsc },
> +       [DDP_COMPONENT_DSC1]    =3D { MTK_DISP_DSC,       1, &ddp_dsc },
> +       [DDP_COMPONENT_DSC1_VIRTUAL0]   =3D { MTK_DISP_DSC,       -1, &dd=
p_dsc },

What is DDP_COMPONENT_DSC1_VIRTUAL0? If use less, remove it.

>         [DDP_COMPONENT_DSI0]    =3D { MTK_DSI,            0, &ddp_dsi },
>         [DDP_COMPONENT_DSI1]    =3D { MTK_DSI,            1, &ddp_dsi },
>         [DDP_COMPONENT_DSI2]    =3D { MTK_DSI,            2, &ddp_dsi },
> @@ -508,13 +520,14 @@ int mtk_ddp_comp_init(struct device_node *node, str=
uct mtk_ddp_comp *comp,
>         if (type =3D=3D MTK_DISP_BLS ||
>             type =3D=3D MTK_DISP_CCORR ||
>             type =3D=3D MTK_DISP_COLOR ||
> +           type =3D=3D MTK_DISP_DSC ||
>             type =3D=3D MTK_DISP_GAMMA ||
> -           type =3D=3D MTK_DPI ||
> -           type =3D=3D MTK_DSI ||
>             type =3D=3D MTK_DISP_OVL ||
>             type =3D=3D MTK_DISP_OVL_2L ||
>             type =3D=3D MTK_DISP_PWM ||
> -           type =3D=3D MTK_DISP_RDMA)
> +           type =3D=3D MTK_DISP_RDMA ||
> +           type =3D=3D MTK_DPI ||
> +           type =3D=3D MTK_DSI)

Moving MTK_DPI and MTK_DSI is not related to DSC, so move this
modification to another patch.

>                 return 0;
>
>         priv =3D devm_kzalloc(comp->dev, sizeof(*priv), GFP_KERNEL);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.h
> index bb914d976cf5..661fb620e266 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -34,6 +34,7 @@ enum mtk_ddp_comp_type {
>         MTK_DISP_MUTEX,
>         MTK_DISP_OD,
>         MTK_DISP_BLS,
> +       MTK_DISP_DSC,
>         MTK_DDP_COMP_TYPE_MAX,
>  };
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index d6f6d1bdad85..990a54049a7d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -446,6 +446,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[=
] =3D {
>           .data =3D (void *)MTK_DISP_GAMMA, },
>         { .compatible =3D "mediatek,mt8183-disp-dither",
>           .data =3D (void *)MTK_DISP_DITHER },
> +       { .compatible =3D "mediatek,mt8195-disp-dsc",
> +         .data =3D (void *)MTK_DISP_DSC },
>         { .compatible =3D "mediatek,mt8173-disp-ufoe",
>           .data =3D (void *)MTK_DISP_UFOE },
>         { .compatible =3D "mediatek,mt2701-dsi",
> @@ -562,12 +564,13 @@ static int mtk_drm_probe(struct platform_device *pd=
ev)
>                  */
>                 if (comp_type =3D=3D MTK_DISP_CCORR ||
>                     comp_type =3D=3D MTK_DISP_COLOR ||
> +                   comp_type =3D=3D MTK_DISP_DSC ||
>                     comp_type =3D=3D MTK_DISP_GAMMA ||
>                     comp_type =3D=3D MTK_DISP_OVL ||
>                     comp_type =3D=3D MTK_DISP_OVL_2L ||
>                     comp_type =3D=3D MTK_DISP_RDMA ||
> -                   comp_type =3D=3D MTK_DSI ||
> -                   comp_type =3D=3D MTK_DPI) {
> +                   comp_type =3D=3D MTK_DPI ||
> +                   comp_type =3D=3D MTK_DSI) {
>                         dev_info(dev, "Adding component match for %pOF\n"=
,
>                                  node);
>                         drm_of_component_match_add(dev, &match, compare_o=
f,
> @@ -662,6 +665,7 @@ static struct platform_driver mtk_drm_platform_driver=
 =3D {
>  static struct platform_driver * const mtk_drm_drivers[] =3D {
>         &mtk_disp_ccorr_driver,
>         &mtk_disp_color_driver,
> +       &mtk_disp_dsc_driver,
>         &mtk_disp_gamma_driver,
>         &mtk_disp_ovl_driver,
>         &mtk_disp_rdma_driver,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.h
> index 637f5669e895..8b722330ef7d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -51,6 +51,7 @@ extern struct platform_driver mtk_disp_color_driver;
>  extern struct platform_driver mtk_disp_gamma_driver;
>  extern struct platform_driver mtk_disp_ovl_driver;
>  extern struct platform_driver mtk_disp_rdma_driver;
> +extern struct platform_driver mtk_disp_dsc_driver;

Alphabetic order.

Regards,
Chun-Kuang.

>  extern struct platform_driver mtk_dpi_driver;
>  extern struct platform_driver mtk_dsi_driver;
>
> --
> 2.18.0
>
