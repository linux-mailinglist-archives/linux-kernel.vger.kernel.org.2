Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB03309408
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhA3KIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:08:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhA3KGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 05:06:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0410364E0C;
        Sat, 30 Jan 2021 10:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612001149;
        bh=/QEbBItZgyb0oI8KAuKDpk4DtDTW9iuhXIrM7+HRj6Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uf66muYjBLSFDN1tuCKLNKmenCUK2Tl2dcCVTzqZayiHcWOSZzZlqzdiny3M4pH8v
         3PVLo+PdH2Oq6yF8GY/xuncTRukJWvlEGrSm0uFPIlaqppCLdYfCIIGr+ylO19UgTg
         Px3DWlsgAbXxs7iiWjy4DSiG5hYlcTIHeB5BGzvCkZntfo8hThzBqQNzmUWoKWS9Mb
         zhN9+J8PtSzJ+sCC6ZyBb18of1hV1xgQvXXjpAP7oY1uhnCfDuCh/+SjUI9iFbj+FO
         jX4LYTNy+RqixvGsXjjes5kO+3ArDOut14CwnsetT+DtwxdeGn1nxirKXj7XMJmASj
         xsBytYi8V/RAg==
Received: by mail-ej1-f54.google.com with SMTP id rv9so16584736ejb.13;
        Sat, 30 Jan 2021 02:05:48 -0800 (PST)
X-Gm-Message-State: AOAM530ahvfvjYJC+LL32FHuGFiiosfQjJ7v0lcN5fMB+S5lWdvkNnYS
        MFCmCEmdutPVTsaqKItd5xKJZk15hd/HtwMiLQ==
X-Google-Smtp-Source: ABdhPJx4ZRZnhyAay/ZYFKC/OlCSQkwfbYOSwwxbJU5pv0BqOKlmlC90ebOQ5LbXchWco/Z6VAoK1Y4uAB2EtE1ODJM=
X-Received: by 2002:a17:906:a106:: with SMTP id t6mr8473323ejy.63.1612001147416;
 Sat, 30 Jan 2021 02:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20210129092209.2584718-1-hsinyi@chromium.org> <20210129092209.2584718-5-hsinyi@chromium.org>
In-Reply-To: <20210129092209.2584718-5-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 30 Jan 2021 18:05:34 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-FqFAU6Qca3uk_XNrO1qRdPPbcRCK1A3P7jZxBMqveiA@mail.gmail.com>
Message-ID: <CAAOTY_-FqFAU6Qca3uk_XNrO1qRdPPbcRCK1A3P7jZxBMqveiA@mail.gmail.com>
Subject: Re: [PATCH v13 4/8] drm/mediatek: separate gamma module
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:23=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
>
> mt8183 gamma module will different with mt8173
> separate gamma for add private data

After I clean up all checkpatch error, applied to mediatek-drm-next
[1]. Remember to clean up all checkpatch error before send out
patches.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/Makefile           |   1 +
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  10 +
>  drivers/gpu/drm/mediatek/mtk_disp_gamma.c   | 191 ++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  71 ++------
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   4 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   1 +
>  6 files changed, 217 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_gamma.c
>
> diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek=
/Makefile
> index 01d06332f7679..b64674b944860 100644
> --- a/drivers/gpu/drm/mediatek/Makefile
> +++ b/drivers/gpu/drm/mediatek/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  mediatek-drm-y :=3D mtk_disp_color.o \
> +                 mtk_disp_gamma.o \
>                   mtk_disp_ovl.o \
>                   mtk_disp_rdma.o \
>                   mtk_drm_crtc.o \
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/me=
diatek/mtk_disp_drv.h
> index 9e5537f76b22a..02191010699f8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> @@ -27,6 +27,16 @@ void mtk_dpi_stop(struct device *dev);
>  void mtk_dsi_ddp_start(struct device *dev);
>  void mtk_dsi_ddp_stop(struct device *dev);
>
> +int mtk_gamma_clk_enable(struct device *dev);
> +void mtk_gamma_clk_disable(struct device *dev);
> +void mtk_gamma_config(struct device *dev, unsigned int w,
> +                      unsigned int h, unsigned int vrefresh,
> +                      unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
> +void mtk_gamma_set(struct device *dev, struct drm_crtc_state *state);
> +void mtk_gamma_set_common(void __iomem *regs, struct drm_crtc_state *sta=
te);
> +void mtk_gamma_start(struct device *dev);
> +void mtk_gamma_stop(struct device *dev);
> +
>  void mtk_ovl_bgclr_in_on(struct device *dev);
>  void mtk_ovl_bgclr_in_off(struct device *dev);
>  void mtk_ovl_bypass_shadow(struct device *dev);
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/=
mediatek/mtk_disp_gamma.c
> new file mode 100644
> index 0000000000000..6b520807921e3
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> @@ -0,0 +1,191 @@
> +/*
> + * SPDX-License-Identifier:
> + *
> + * Copyright (c) 2020 MediaTek Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/component.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/mediatek/mtk-cmdq.h>
> +
> +#include "mtk_disp_drv.h"
> +#include "mtk_drm_crtc.h"
> +#include "mtk_drm_ddp_comp.h"
> +
> +#define DISP_GAMMA_EN                          0x0000
> +#define GAMMA_EN                                       BIT(0)
> +#define DISP_GAMMA_CFG                         0x0020
> +#define GAMMA_LUT_EN                                   BIT(1)
> +#define GAMMA_DITHERING                                        BIT(2)
> +#define DISP_GAMMA_SIZE                                0x0030
> +#define DISP_GAMMA_LUT                         0x0700
> +
> +#define LUT_10BIT_MASK                         0x03ff
> +
> +struct mtk_disp_gamma_data {
> +       u32 reserved;
> +};
> +
> +/**
> + * struct mtk_disp_gamma - DISP_GAMMA driver structure
> + * @ddp_comp - structure containing type enum and hardware resources
> + * @crtc - associated crtc to report irq events to
> + */
> +struct mtk_disp_gamma {
> +       struct clk *clk;
> +       void __iomem *regs;
> +       struct cmdq_client_reg cmdq_reg;
> +       const struct mtk_disp_gamma_data *data;
> +};
> +
> +int mtk_gamma_clk_enable(struct device *dev)
> +{
> +       struct mtk_disp_gamma *gamma =3D dev_get_drvdata(dev);
> +
> +       return clk_prepare_enable(gamma->clk);
> +}
> +
> +void mtk_gamma_clk_disable(struct device *dev)
> +{
> +       struct mtk_disp_gamma *gamma =3D dev_get_drvdata(dev);
> +
> +       clk_disable_unprepare(gamma->clk);
> +}
> +
> +void mtk_gamma_set_common(void __iomem *regs, struct drm_crtc_state *sta=
te)
> +{
> +       unsigned int i, reg;
> +       struct drm_color_lut *lut;
> +       void __iomem *lut_base;
> +       u32 word;
> +
> +       if (state->gamma_lut) {
> +               reg =3D readl(regs + DISP_GAMMA_CFG);
> +               reg =3D reg | GAMMA_LUT_EN;
> +               writel(reg, regs + DISP_GAMMA_CFG);
> +               lut_base =3D regs + DISP_GAMMA_LUT;
> +               lut =3D (struct drm_color_lut *)state->gamma_lut->data;
> +               for (i =3D 0; i < MTK_LUT_SIZE; i++) {
> +                       word =3D (((lut[i].red >> 6) & LUT_10BIT_MASK) <<=
 20) +
> +                               (((lut[i].green >> 6) & LUT_10BIT_MASK) <=
< 10) +
> +                               ((lut[i].blue >> 6) & LUT_10BIT_MASK);
> +                       writel(word, (lut_base + i * 4));
> +               }
> +       }
> +}
> +
> +void mtk_gamma_set(struct device *dev, struct drm_crtc_state *state)
> +{
> +       struct mtk_disp_gamma *gamma =3D dev_get_drvdata(dev);
> +
> +       mtk_gamma_set_common(gamma->regs, state);
> +}
> +
> +void mtk_gamma_config(struct device *dev, unsigned int w,
> +                     unsigned int h, unsigned int vrefresh,
> +                     unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> +{
> +       struct mtk_disp_gamma *gamma =3D dev_get_drvdata(dev);
> +
> +       mtk_ddp_write(cmdq_pkt, h << 16 | w, &gamma->cmdq_reg, gamma->reg=
s,
> +                     DISP_GAMMA_SIZE);
> +       mtk_dither_set_common(gamma->regs, &gamma->cmdq_reg, bpc, DISP_GA=
MMA_CFG,
> +                             GAMMA_DITHERING, cmdq_pkt);
> +}
> +
> +void mtk_gamma_start(struct device *dev)
> +{
> +       struct mtk_disp_gamma *gamma =3D dev_get_drvdata(dev);
> +
> +       writel(GAMMA_EN, gamma->regs + DISP_GAMMA_EN);
> +}
> +
> +void mtk_gamma_stop(struct device *dev)
> +{
> +       struct mtk_disp_gamma *gamma =3D dev_get_drvdata(dev);
> +
> +       writel_relaxed(0x0, gamma->regs + DISP_GAMMA_EN);
> +}
> +
> +static int mtk_disp_gamma_bind(struct device *dev, struct device *master=
,
> +                              void *data)
> +{
> +       return 0;
> +}
> +
> +static void mtk_disp_gamma_unbind(struct device *dev, struct device *mas=
ter,
> +                                 void *data)
> +{
> +}
> +
> +static const struct component_ops mtk_disp_gamma_component_ops =3D {
> +       .bind   =3D mtk_disp_gamma_bind,
> +       .unbind =3D mtk_disp_gamma_unbind,
> +};
> +
> +static int mtk_disp_gamma_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct mtk_disp_gamma *priv;
> +       struct resource *res;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->clk =3D devm_clk_get(dev, NULL);
> +       if (IS_ERR(priv->clk)) {
> +               dev_err(dev, "failed to get gamma clk\n");
> +               return PTR_ERR(priv->clk);
> +       }
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       priv->regs =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(priv->regs)) {
> +               dev_err(dev, "failed to ioremap gamma\n");
> +               return PTR_ERR(priv->regs);
> +       }
> +
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +       ret =3D cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
> +       if (ret)
> +               dev_dbg(dev, "get mediatek,gce-client-reg fail!\n");
> +#endif
> +
> +       priv->data =3D of_device_get_match_data(dev);
> +       platform_set_drvdata(pdev, priv);
> +
> +       ret =3D component_add(dev, &mtk_disp_gamma_component_ops);
> +       if (ret)
> +               dev_err(dev, "Failed to add component: %d\n", ret);
> +
> +       return ret;
> +}
> +
> +static int mtk_disp_gamma_remove(struct platform_device *pdev)
> +{
> +       component_del(&pdev->dev, &mtk_disp_gamma_component_ops);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id mtk_disp_gamma_driver_dt_match[] =3D {
> +       { .compatible =3D "mediatek,mt8173-disp-gamma"},
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_disp_gamma_driver_dt_match);
> +
> +struct platform_driver mtk_disp_gamma_driver =3D {
> +       .probe          =3D mtk_disp_gamma_probe,
> +       .remove         =3D mtk_disp_gamma_remove,
> +       .driver         =3D {
> +               .name   =3D "mediatek-disp-gamma",
> +               .owner  =3D THIS_MODULE,
> +               .of_match_table =3D mtk_disp_gamma_driver_dt_match,
> +       },
> +};
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 07804ab16f44d..ac2cb25620357 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -55,11 +55,6 @@
>  #define DITHER_RELAY_MODE                      BIT(0)
>  #define DISP_DITHER_SIZE                       0x0030
>
> -#define DISP_GAMMA_EN                          0x0000
> -#define DISP_GAMMA_CFG                         0x0020
> -#define DISP_GAMMA_SIZE                                0x0030
> -#define DISP_GAMMA_LUT                         0x0700
> -
>  #define LUT_10BIT_MASK                         0x03ff
>
>  #define OD_RELAYMODE                           BIT(0)
> @@ -68,9 +63,6 @@
>
>  #define AAL_EN                                 BIT(0)
>
> -#define GAMMA_EN                               BIT(0)
> -#define GAMMA_LUT_EN                           BIT(1)
> -
>  #define DISP_DITHERING                         BIT(2)
>  #define DITHER_LSB_ERR_SHIFT_R(x)              (((x) & 0x7) << 28)
>  #define DITHER_OVFLW_BIT_R(x)                  (((x) & 0x7) << 24)
> @@ -151,7 +143,6 @@ static void mtk_ddp_clk_disable(struct device *dev)
>         clk_disable_unprepare(priv->clk);
>  }
>
> -
>  void mtk_dither_set_common(void __iomem *regs, struct cmdq_client_reg *c=
mdq_reg,
>                            unsigned int bpc, unsigned int cfg,
>                            unsigned int dither_en, struct cmdq_pkt *cmdq_=
pkt)
> @@ -221,6 +212,13 @@ static void mtk_aal_config(struct device *dev, unsig=
ned int w,
>         mtk_ddp_write(cmdq_pkt, w << 16 | h, &priv->cmdq_reg, priv->regs,=
 DISP_AAL_SIZE);
>  }
>
> +static void mtk_aal_gamma_set(struct device *dev, struct drm_crtc_state =
*state)
> +{
> +       struct mtk_ddp_comp_dev *priv =3D dev_get_drvdata(dev);
> +
> +        mtk_gamma_set_common(priv->regs, state);
> +}
> +
>  static void mtk_aal_start(struct device *dev)
>  {
>         struct mtk_ddp_comp_dev *priv =3D dev_get_drvdata(dev);
> @@ -335,58 +333,10 @@ static void mtk_dither_stop(struct device *dev)
>         writel_relaxed(0x0, priv->regs + DISP_DITHER_EN);
>  }
>
> -static void mtk_gamma_config(struct device *dev, unsigned int w,
> -                            unsigned int h, unsigned int vrefresh,
> -                            unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> -{
> -       struct mtk_ddp_comp_dev *priv =3D dev_get_drvdata(dev);
> -
> -       mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs,=
 DISP_GAMMA_SIZE);
> -       mtk_dither_set(dev, bpc, DISP_GAMMA_CFG, cmdq_pkt);
> -}
> -
> -static void mtk_gamma_start(struct device *dev)
> -{
> -       struct mtk_ddp_comp_dev *priv =3D dev_get_drvdata(dev);
> -
> -       writel(GAMMA_EN, priv->regs  + DISP_GAMMA_EN);
> -}
> -
> -static void mtk_gamma_stop(struct device *dev)
> -{
> -       struct mtk_ddp_comp_dev *priv =3D dev_get_drvdata(dev);
> -
> -       writel_relaxed(0x0, priv->regs  + DISP_GAMMA_EN);
> -}
> -
> -static void mtk_gamma_set(struct device *dev,
> -                         struct drm_crtc_state *state)
> -{
> -       struct mtk_ddp_comp_dev *priv =3D dev_get_drvdata(dev);
> -       unsigned int i, reg;
> -       struct drm_color_lut *lut;
> -       void __iomem *lut_base;
> -       u32 word;
> -
> -       if (state->gamma_lut) {
> -               reg =3D readl(priv->regs + DISP_GAMMA_CFG);
> -               reg =3D reg | GAMMA_LUT_EN;
> -               writel(reg, priv->regs + DISP_GAMMA_CFG);
> -               lut_base =3D priv->regs + DISP_GAMMA_LUT;
> -               lut =3D (struct drm_color_lut *)state->gamma_lut->data;
> -               for (i =3D 0; i < MTK_LUT_SIZE; i++) {
> -                       word =3D (((lut[i].red >> 6) & LUT_10BIT_MASK) <<=
 20) +
> -                               (((lut[i].green >> 6) & LUT_10BIT_MASK) <=
< 10) +
> -                               ((lut[i].blue >> 6) & LUT_10BIT_MASK);
> -                       writel(word, (lut_base + i * 4));
> -               }
> -       }
> -}
> -
>  static const struct mtk_ddp_comp_funcs ddp_aal =3D {
>         .clk_enable =3D mtk_ddp_clk_enable,
>         .clk_disable =3D mtk_ddp_clk_disable,
> -       .gamma_set =3D mtk_gamma_set,
> +       .gamma_set =3D mtk_aal_gamma_set,
>         .config =3D mtk_aal_config,
>         .start =3D mtk_aal_start,
>         .stop =3D mtk_aal_stop,
> @@ -427,8 +377,8 @@ static const struct mtk_ddp_comp_funcs ddp_dsi =3D {
>  };
>
>  static const struct mtk_ddp_comp_funcs ddp_gamma =3D {
> -       .clk_enable =3D mtk_ddp_clk_enable,
> -       .clk_disable =3D mtk_ddp_clk_disable,
> +       .clk_enable =3D mtk_gamma_clk_enable,
> +       .clk_disable =3D mtk_gamma_clk_disable,
>         .gamma_set =3D mtk_gamma_set,
>         .config =3D mtk_gamma_config,
>         .start =3D mtk_gamma_start,
> @@ -644,6 +594,7 @@ int mtk_ddp_comp_init(struct device_node *node, struc=
t mtk_ddp_comp *comp,
>
>         if (type =3D=3D MTK_DISP_BLS ||
>             type =3D=3D MTK_DISP_COLOR ||
> +           type =3D=3D MTK_DISP_GAMMA ||
>             type =3D=3D MTK_DPI ||
>             type =3D=3D MTK_DSI ||
>             type =3D=3D MTK_DISP_OVL ||
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 5d39dd54255d1..279d3e6f11563 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -486,11 +486,12 @@ static int mtk_drm_probe(struct platform_device *pd=
ev)
>                 private->comp_node[comp_id] =3D of_node_get(node);
>
>                 /*
> -                * Currently only the COLOR, OVL, RDMA, DSI, and DPI bloc=
ks have
> +                * Currently only the COLOR, GAMMA, OVL, RDMA, DSI, and D=
PI blocks have
>                  * separate component platform drivers and initialize the=
ir own
>                  * DDP component structure. The others are initialized he=
re.
>                  */
>                 if (comp_type =3D=3D MTK_DISP_COLOR ||
> +                   comp_type =3D=3D MTK_DISP_GAMMA ||
>                     comp_type =3D=3D MTK_DISP_OVL ||
>                     comp_type =3D=3D MTK_DISP_OVL_2L ||
>                     comp_type =3D=3D MTK_DISP_RDMA ||
> @@ -589,6 +590,7 @@ static struct platform_driver mtk_drm_platform_driver=
 =3D {
>
>  static struct platform_driver * const mtk_drm_drivers[] =3D {
>         &mtk_disp_color_driver,
> +       &mtk_disp_gamma_driver,
>         &mtk_disp_ovl_driver,
>         &mtk_disp_rdma_driver,
>         &mtk_dpi_driver,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.h
> index e8238fa4aa2ac..0e54e3d51014a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -47,6 +47,7 @@ struct mtk_drm_private {
>  };
>
>  extern struct platform_driver mtk_disp_color_driver;
> +extern struct platform_driver mtk_disp_gamma_driver;
>  extern struct platform_driver mtk_disp_ovl_driver;
>  extern struct platform_driver mtk_disp_rdma_driver;
>  extern struct platform_driver mtk_dpi_driver;
> --
> 2.30.0.365.g02bc693789-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
