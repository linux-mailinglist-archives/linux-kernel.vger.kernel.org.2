Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD223C39C2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 03:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhGKBWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 21:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhGKBWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 21:22:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41CBC6135F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 01:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625966396;
        bh=V2LFnzXhDnFALWzigtheapVJ4kOC9VCUS93ZFlSowJ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=doB+zYvrzRNlTQoqtXMO1ayvHP4UG+BcjypswlgoYq3nBvsHRJYYe67Lse4Klx14j
         +BqGaDwiqPOvmIF+HmnofzUY5Ld6fcK3ZhL+0zU8dMDdqeQk9RBqDZHGStJoELProf
         mayB6zyXW4XIyZF9ICWySi1tf6PldwgzlmW3YLCi8QayELlDDBailj+ZbT0J9Zaqv2
         NWQzNDWWN34gwBnSPCK5xZG+t3t1dbc9Gz9y/9QYVHXNNd0viV056SAxVNZ38RH5q+
         8ugm9yHuM84CXfjrHWf7mm/xqIOPoQRtx//T9QqrCODWGdjdPvy/giSuiG8iQ90KoN
         mr7KZ7ftelzEw==
Received: by mail-ed1-f45.google.com with SMTP id ca14so3814652edb.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 18:19:56 -0700 (PDT)
X-Gm-Message-State: AOAM533g/euznRqwMzDMg0d7a0D64SBnnznyEtDusNWC75hDbpal6+Zb
        paHpYI9R9rvUqvfl0diMcWPt2xRAea66eVFucA==
X-Google-Smtp-Source: ABdhPJzyu9hHDSuWLUNnw9aZion+52gaiGxZdQKpnM2XSvGBl1wFC0sYYsJ4Lu1MavtEbQQVFVplAPmF5RJzOsVv3rQ=
X-Received: by 2002:a50:d0cf:: with SMTP id g15mr34600027edf.219.1625966394766;
 Sat, 10 Jul 2021 18:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210710113819.5170-1-jason-jh.lin@mediatek.com> <20210710113819.5170-9-jason-jh.lin@mediatek.com>
In-Reply-To: <20210710113819.5170-9-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 11 Jul 2021 09:19:43 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-RYv-DvUBBhCOvWwxh1cu1hCvnaXkjA3X1_+vEP_QvBg@mail.gmail.com>
Message-ID: <CAAOTY_-RYv-DvUBBhCOvWwxh1cu1hCvnaXkjA3X1_+vEP_QvBg@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] drm/mediatek: add DSC support for mt8195
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
0=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=887:38=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add DSC module file.

Introduce DSC here.

>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/Makefile           |   1 +
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h     |   8 +
>  drivers/gpu/drm/mediatek/mtk_disp_dsc.c     | 205 ++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  13 ++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   1 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   4 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   1 +
>  7 files changed, 233 insertions(+)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_dsc.c
>
> diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek=
/Makefile
> index dc54a7a69005..a1b239135c8f 100644
> --- a/drivers/gpu/drm/mediatek/Makefile
> +++ b/drivers/gpu/drm/mediatek/Makefile
> @@ -5,6 +5,7 @@ mediatek-drm-y :=3D mtk_disp_ccorr.o \
>                   mtk_disp_gamma.o \
>                   mtk_disp_ovl.o \
>                   mtk_disp_rdma.o \
> +                 mtk_disp_dsc.o \
>                   mtk_drm_crtc.o \
>                   mtk_drm_ddp_comp.o \
>                   mtk_drm_drv.o \
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/me=
diatek/mtk_disp_drv.h
> index cafd9df2d63b..128d9fdbaf9e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> @@ -89,4 +89,12 @@ void mtk_rdma_enable_vblank(struct device *dev,
>                             void *vblank_cb_data);
>  void mtk_rdma_disable_vblank(struct device *dev);
>
> +int mtk_dsc_clk_enable(struct device *dev);
> +void mtk_dsc_clk_disable(struct device *dev);
> +void mtk_dsc_config(struct device *dev, unsigned int width,
> +                   unsigned int height, unsigned int vrefresh,
> +                   unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
> +void mtk_dsc_start(struct device *dev);
> +void mtk_dsc_stop(struct device *dev);
> +
>  #endif
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_dsc.c b/drivers/gpu/drm/me=
diatek/mtk_disp_dsc.c
> new file mode 100644
> index 000000000000..61187f824c19
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_dsc.c
> @@ -0,0 +1,205 @@
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
> +#include <linux/pm_runtime.h>
> +#include <linux/soc/mediatek/mtk-cmdq.h>
> +
> +#include "mtk_drm_crtc.h"
> +#include "mtk_drm_ddp_comp.h"
> +#include "mtk_drm_gem.h"
> +#include "mtk_disp_drv.h"
> +
> +#define DISP_REG_DSC_CON                       0x0000
> +#define DSC_EN                                         BIT(0)
> +#define DSC_DUAL_INOUT                         BIT(2)
> +#define DSC_IN_SRC_SEL                         BIT(3)
> +#define DSC_BYPASS                                     BIT(4)
> +#define DSC_RELAY                                      BIT(5)
> +#define DSC_EMPTY_FLAG_SEL                     0xc000
> +#define DSC_UFOE_SEL                           BIT(16)
> +#define DISP_REG_DSC_OBUF                      0x0070
> +
> +/**
> + * struct mtk_disp_dsc - DISP_DSC driver structure
> + * @clk - clk of dsc hardware
> + * @regs - hardware register address of dsc
> + * @comp_id - enum type of component id
> + * @cmdq_reg - structure containing cmdq hardware resource
> + */
> +struct mtk_disp_dsc {
> +       struct clk *clk;
> +       void __iomem *regs;
> +       enum mtk_ddp_comp_id comp_id;

comp_id is useless, so remove.

> +       struct cmdq_client_reg          cmdq_reg;
> +};
> +
> +void mtk_dsc_start(struct device *dev)
> +{
> +       struct mtk_disp_dsc *dsc =3D dev_get_drvdata(dev);
> +       void __iomem *baddr =3D dsc->regs;
> +       int ret =3D 0;
> +
> +       ret =3D pm_runtime_get_sync(dev);

I think no sub driver enable the power, so sync with other sub driver.

> +       if (ret < 0)
> +               DRM_ERROR("Failed to enable power domain: %d\n", ret);
> +
> +       mtk_ddp_write_mask(NULL, DSC_EN,
> +                          &dsc->cmdq_reg, baddr,
> +                          DISP_REG_DSC_CON, DSC_EN);
> +
> +       pr_debug("dsc_start:0x%x\n", readl(baddr + DISP_REG_DSC_CON));

No sub driver print this, sync with other sub driver.

> +}
> +
> +void mtk_dsc_stop(struct device *dev)
> +{
> +       struct mtk_disp_dsc *dsc =3D dev_get_drvdata(dev);
> +       void __iomem *baddr =3D dsc->regs;
> +       int ret =3D 0;
> +
> +       mtk_ddp_write_mask(NULL, 0x0, &dsc->cmdq_reg, baddr,
> +                          DISP_REG_DSC_CON, DSC_EN);
> +
> +       pr_debug("dsc_stop:0x%x\n", readl(baddr + DISP_REG_DSC_CON));

Why we need this information?

> +
> +       ret =3D pm_runtime_put(dev);

Ditto as pm_runtime_get_sync().

> +       if (ret < 0)
> +               DRM_ERROR("Failed to disable power domain: %d\n", ret);
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
> +       mtk_ddp_write_mask(handle, DSC_BYPASS,
> +                          &dsc->cmdq_reg, dsc->regs,
> +                          DISP_REG_DSC_CON, DSC_BYPASS);
> +       mtk_ddp_write_mask(handle, DSC_UFOE_SEL,
> +                          &dsc->cmdq_reg, dsc->regs,
> +                          DISP_REG_DSC_CON, DSC_UFOE_SEL);
> +       mtk_ddp_write_mask(handle, DSC_DUAL_INOUT,
> +                          &dsc->cmdq_reg, dsc->regs,
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
> +       enum mtk_ddp_comp_id comp_id;
> +       int irq;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       comp_id =3D mtk_ddp_comp_get_id(dev->of_node, MTK_DISP_DSC);
> +       if ((int)comp_id < 0) {
> +               dev_err(dev, "Failed to identify by alias: %d\n", comp_id=
);
> +               return comp_id;
> +       }
> +
> +       priv->comp_id =3D comp_id;
> +
> +       irq =3D platform_get_irq(pdev, 0);

Why do you get irq?

> +       if (irq < 0)
> +               return irq;
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
> +       pm_runtime_enable(dev);

Sync with other sub driver.

> +
> +       ret =3D component_add(dev, &mtk_disp_dsc_component_ops);
> +       if (ret !=3D 0) {
> +               dev_err(dev, "Failed to add component: %d\n", ret);
> +               pm_runtime_disable(dev);
> +       }
> +
> +       return ret;
> +}
> +
> +static int mtk_disp_dsc_remove(struct platform_device *pdev)
> +{
> +       component_del(&pdev->dev, &mtk_disp_dsc_component_ops);
> +
> +       pm_runtime_disable(&pdev->dev);

Sync with other sub driver.

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
> index 75bc00e17fc4..d0b0f41dfe5a 100644
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
> @@ -391,6 +400,9 @@ static const struct mtk_ddp_comp_match mtk_ddp_matche=
s[DDP_COMPONENT_ID_MAX] =3D {
>         [DDP_COMPONENT_RDMA0]   =3D { MTK_DISP_RDMA,      0, &ddp_rdma },
>         [DDP_COMPONENT_RDMA1]   =3D { MTK_DISP_RDMA,      1, &ddp_rdma },
>         [DDP_COMPONENT_RDMA2]   =3D { MTK_DISP_RDMA,      2, &ddp_rdma },
> +       [DDP_COMPONENT_DSC0]    =3D { MTK_DISP_DSC,       0, &ddp_dsc },
> +       [DDP_COMPONENT_DSC1]    =3D { MTK_DISP_DSC,       1, &ddp_dsc },
> +       [DDP_COMPONENT_DSC1_VIRTUAL0]   =3D { MTK_DISP_DSC,       -1, &dd=
p_dsc },

Alphabetic order.

>         [DDP_COMPONENT_UFOE]    =3D { MTK_DISP_UFOE,      0, &ddp_ufoe },
>         [DDP_COMPONENT_WDMA0]   =3D { MTK_DISP_WDMA,      0, NULL },
>         [DDP_COMPONENT_WDMA1]   =3D { MTK_DISP_WDMA,      1, NULL },
> @@ -509,6 +521,7 @@ int mtk_ddp_comp_init(struct device_node *node, struc=
t mtk_ddp_comp *comp,
>             type =3D=3D MTK_DISP_CCORR ||
>             type =3D=3D MTK_DISP_COLOR ||
>             type =3D=3D MTK_DISP_GAMMA ||
> +           type =3D=3D MTK_DISP_DSC ||

Alphabetic order.

>             type =3D=3D MTK_DPI ||
>             type =3D=3D MTK_DSI ||
>             type =3D=3D MTK_DISP_OVL ||
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
> index d6f6d1bdad85..7dfca63c1042 100644
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
> @@ -563,6 +565,7 @@ static int mtk_drm_probe(struct platform_device *pdev=
)
>                 if (comp_type =3D=3D MTK_DISP_CCORR ||
>                     comp_type =3D=3D MTK_DISP_COLOR ||
>                     comp_type =3D=3D MTK_DISP_GAMMA ||
> +                   comp_type =3D=3D MTK_DISP_DSC ||
>                     comp_type =3D=3D MTK_DISP_OVL ||
>                     comp_type =3D=3D MTK_DISP_OVL_2L ||
>                     comp_type =3D=3D MTK_DISP_RDMA ||
> @@ -667,6 +670,7 @@ static struct platform_driver * const mtk_drm_drivers=
[] =3D {
>         &mtk_disp_rdma_driver,
>         &mtk_dpi_driver,
>         &mtk_drm_platform_driver,
> +       &mtk_disp_dsc_driver,

Alphabetic order.

>         &mtk_dsi_driver,
>  };
>
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
