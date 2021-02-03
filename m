Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB8A30DF6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhBCQO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:14:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234730AbhBCQOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:14:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C00364F7E;
        Wed,  3 Feb 2021 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612368797;
        bh=AQrfOurFPo9gnZOXOaGVJkwCb0fop9D1Z1sW3xY8ZxY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a2++B/Suw2TYLedVVPghMZLhqFE9kxUKUjZv2c9k2K/t7E14YqMyNHfQfRn9TZAnN
         6bL1sOXR7gmFj/R0ImuH03schE6kRVCTpVjvbCQkMWSQ2a0nVGYtDMV6joJDqfsq5J
         oGObiLUIq2uQvUuyF49FLXau5fzzrp4ZS3M6coxJEP+zXpN0v1PhDKlahHsuVOq3Z6
         24ft/7nk+KIaW+8gDWhuYaPrbJb14frbvOxxJ6gTOeFaMc19jYKKaTClrjzsvgSl7Y
         A+SCRaOXg6nq7kPEjIW140c8esaCndPcvQUPqg54G5ZrQXHWKEG0SmsrUgMSfx4hUb
         04uU4SZjM9Q2Q==
Received: by mail-ed1-f45.google.com with SMTP id l12so241175edt.3;
        Wed, 03 Feb 2021 08:13:17 -0800 (PST)
X-Gm-Message-State: AOAM531kUUBf78qeS6SKGbpR2mBLr/gN4H56A7Hl81zpVp17wtyRvKIm
        oM2x7a+f9j5h1zdVIwYqncj3wkRM7ETbWcSlIQ==
X-Google-Smtp-Source: ABdhPJyBdVYLXmkNnXtupRLW9DEu2Z1Nd97m8EdOuGWGJ8OQmtfuN0Spc+ukeKWbXrzTGTcjSVmMOfVDmmWPADZxnaE=
X-Received: by 2002:a50:ef0a:: with SMTP id m10mr3822586eds.38.1612368795581;
 Wed, 03 Feb 2021 08:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20210202081237.774442-1-hsinyi@chromium.org> <20210202081237.774442-5-hsinyi@chromium.org>
In-Reply-To: <20210202081237.774442-5-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 4 Feb 2021 00:13:05 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-xqeW=4G0A-t44pKm0VFZ6qKw2Dx2vyGsnxG3E9vD5Ow@mail.gmail.com>
Message-ID: <CAAOTY_-xqeW=4G0A-t44pKm0VFZ6qKw2Dx2vyGsnxG3E9vD5Ow@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] drm/mediatek: separate ccorr module
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

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2021=E5=B9=B42=E6=9C=882=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:13=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
>
> ccorr ctm matrix bits will be different in mt8192

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/Makefile           |   3 +-
>  drivers/gpu/drm/mediatek/mtk_disp_ccorr.c   | 216 ++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h     |   9 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  95 +--------
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   8 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   1 +
>  6 files changed, 236 insertions(+), 96 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
>
> diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek=
/Makefile
> index b64674b944860..dc54a7a690054 100644
> --- a/drivers/gpu/drm/mediatek/Makefile
> +++ b/drivers/gpu/drm/mediatek/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -mediatek-drm-y :=3D mtk_disp_color.o \
> +mediatek-drm-y :=3D mtk_disp_ccorr.o \
> +                 mtk_disp_color.o \
>                   mtk_disp_gamma.o \
>                   mtk_disp_ovl.o \
>                   mtk_disp_rdma.o \
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/=
mediatek/mtk_disp_ccorr.c
> new file mode 100644
> index 0000000000000..6ee2431e6b843
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021 MediaTek Inc.
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
> +#define DISP_CCORR_EN                          0x0000
> +#define CCORR_EN                                       BIT(0)
> +#define DISP_CCORR_CFG                         0x0020
> +#define CCORR_RELAY_MODE                               BIT(0)
> +#define CCORR_ENGINE_EN                                        BIT(1)
> +#define CCORR_GAMMA_OFF                                        BIT(2)
> +#define CCORR_WGAMUT_SRC_CLIP                          BIT(3)
> +#define DISP_CCORR_SIZE                                0x0030
> +#define DISP_CCORR_COEF_0                      0x0080
> +#define DISP_CCORR_COEF_1                      0x0084
> +#define DISP_CCORR_COEF_2                      0x0088
> +#define DISP_CCORR_COEF_3                      0x008C
> +#define DISP_CCORR_COEF_4                      0x0090
> +
> +struct mtk_disp_ccorr_data {
> +       u32 reserved;
> +};
> +
> +/**
> + * struct mtk_disp_ccorr - DISP_CCORR driver structure
> + * @ddp_comp - structure containing type enum and hardware resources
> + * @crtc - associated crtc to report irq events to
> + */
> +struct mtk_disp_ccorr {
> +       struct clk *clk;
> +       void __iomem *regs;
> +       struct cmdq_client_reg cmdq_reg;
> +       const struct mtk_disp_ccorr_data        *data;
> +};
> +
> +int mtk_ccorr_clk_enable(struct device *dev)
> +{
> +       struct mtk_disp_ccorr *ccorr =3D dev_get_drvdata(dev);
> +
> +       return clk_prepare_enable(ccorr->clk);
> +}
> +
> +void mtk_ccorr_clk_disable(struct device *dev)
> +{
> +       struct mtk_disp_ccorr *ccorr =3D dev_get_drvdata(dev);
> +
> +       clk_disable_unprepare(ccorr->clk);
> +}
> +
> +void mtk_ccorr_config(struct device *dev, unsigned int w,
> +                            unsigned int h, unsigned int vrefresh,
> +                            unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> +{
> +       struct mtk_disp_ccorr *ccorr =3D dev_get_drvdata(dev);
> +
> +       mtk_ddp_write(cmdq_pkt, h << 16 | w, &ccorr->cmdq_reg, ccorr->reg=
s,
> +                     DISP_CCORR_SIZE);
> +       mtk_ddp_write(cmdq_pkt, CCORR_ENGINE_EN, &ccorr->cmdq_reg, ccorr-=
>regs,
> +                     DISP_CCORR_CFG);
> +}
> +
> +void mtk_ccorr_start(struct device *dev)
> +{
> +       struct mtk_disp_ccorr *ccorr =3D dev_get_drvdata(dev);
> +
> +       writel(CCORR_EN, ccorr->regs + DISP_CCORR_EN);
> +}
> +
> +void mtk_ccorr_stop(struct device *dev)
> +{
> +       struct mtk_disp_ccorr *ccorr =3D dev_get_drvdata(dev);
> +
> +       writel_relaxed(0x0, ccorr->regs + DISP_CCORR_EN);
> +}
> +
> +/* Converts a DRM S31.32 value to the HW S1.10 format. */
> +static u16 mtk_ctm_s31_32_to_s1_10(u64 in)
> +{
> +       u16 r;
> +
> +       /* Sign bit. */
> +       r =3D in & BIT_ULL(63) ? BIT(11) : 0;
> +
> +       if ((in & GENMASK_ULL(62, 33)) > 0) {
> +               /* identity value 0x100000000 -> 0x400, */
> +               /* if bigger this, set it to max 0x7ff. */
> +               r |=3D GENMASK(10, 0);
> +       } else {
> +               /* take the 11 most important bits. */
> +               r |=3D (in >> 22) & GENMASK(10, 0);
> +       }
> +
> +       return r;
> +}
> +
> +void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state)
> +{
> +       struct mtk_disp_ccorr *ccorr =3D dev_get_drvdata(dev);
> +       struct drm_property_blob *blob =3D state->ctm;
> +       struct drm_color_ctm *ctm;
> +       const u64 *input;
> +       uint16_t coeffs[9] =3D { 0 };
> +       int i;
> +       struct cmdq_pkt *cmdq_pkt =3D NULL;
> +
> +       if (!blob)
> +               return;
> +
> +       ctm =3D (struct drm_color_ctm *)blob->data;
> +       input =3D ctm->matrix;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(coeffs); i++)
> +               coeffs[i] =3D mtk_ctm_s31_32_to_s1_10(input[i]);
> +
> +       mtk_ddp_write(cmdq_pkt, coeffs[0] << 16 | coeffs[1],
> +                     &ccorr->cmdq_reg, ccorr->regs, DISP_CCORR_COEF_0);
> +       mtk_ddp_write(cmdq_pkt, coeffs[2] << 16 | coeffs[3],
> +                     &ccorr->cmdq_reg, ccorr->regs, DISP_CCORR_COEF_1);
> +       mtk_ddp_write(cmdq_pkt, coeffs[4] << 16 | coeffs[5],
> +                     &ccorr->cmdq_reg, ccorr->regs, DISP_CCORR_COEF_2);
> +       mtk_ddp_write(cmdq_pkt, coeffs[6] << 16 | coeffs[7],
> +                     &ccorr->cmdq_reg, ccorr->regs, DISP_CCORR_COEF_3);
> +       mtk_ddp_write(cmdq_pkt, coeffs[8] << 16,
> +                     &ccorr->cmdq_reg, ccorr->regs, DISP_CCORR_COEF_4);
> +}
> +
> +static int mtk_disp_ccorr_bind(struct device *dev, struct device *master=
,
> +                              void *data)
> +{
> +       return 0;
> +}
> +
> +static void mtk_disp_ccorr_unbind(struct device *dev, struct device *mas=
ter,
> +                                 void *data)
> +{
> +}
> +
> +static const struct component_ops mtk_disp_ccorr_component_ops =3D {
> +       .bind   =3D mtk_disp_ccorr_bind,
> +       .unbind =3D mtk_disp_ccorr_unbind,
> +};
> +
> +static int mtk_disp_ccorr_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct mtk_disp_ccorr *priv;
> +       struct resource *res;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->clk =3D devm_clk_get(dev, NULL);
> +       if (IS_ERR(priv->clk)) {
> +               dev_err(dev, "failed to get ccorr clk\n");
> +               return PTR_ERR(priv->clk);
> +       }
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       priv->regs =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(priv->regs)) {
> +               dev_err(dev, "failed to ioremap ccorr\n");
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
> +       ret =3D component_add(dev, &mtk_disp_ccorr_component_ops);
> +       if (ret)
> +               dev_err(dev, "Failed to add component: %d\n", ret);
> +
> +       return ret;
> +}
> +
> +static int mtk_disp_ccorr_remove(struct platform_device *pdev)
> +{
> +       component_del(&pdev->dev, &mtk_disp_ccorr_component_ops);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id mtk_disp_ccorr_driver_dt_match[] =3D {
> +       { .compatible =3D "mediatek,mt8183-disp-ccorr"},
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_disp_ccorr_driver_dt_match);
> +
> +struct platform_driver mtk_disp_ccorr_driver =3D {
> +       .probe          =3D mtk_disp_ccorr_probe,
> +       .remove         =3D mtk_disp_ccorr_remove,
> +       .driver         =3D {
> +               .name   =3D "mediatek-disp-ccorr",
> +               .owner  =3D THIS_MODULE,
> +               .of_match_table =3D mtk_disp_ccorr_driver_dt_match,
> +       },
> +};
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/me=
diatek/mtk_disp_drv.h
> index cdb0383f99061..cafd9df2d63bb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> @@ -9,6 +9,15 @@
>  #include <linux/soc/mediatek/mtk-cmdq.h>
>  #include "mtk_drm_plane.h"
>
> +void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state)=
;
> +int mtk_ccorr_clk_enable(struct device *dev);
> +void mtk_ccorr_clk_disable(struct device *dev);
> +void mtk_ccorr_config(struct device *dev, unsigned int w,
> +                     unsigned int h, unsigned int vrefresh,
> +                     unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
> +void mtk_ccorr_start(struct device *dev);
> +void mtk_ccorr_stop(struct device *dev);
> +
>  void mtk_color_bypass_shadow(struct device *dev);
>  int mtk_color_clk_enable(struct device *dev);
>  void mtk_color_clk_disable(struct device *dev);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 7f5614a6faab8..445ea805d43f3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -35,20 +35,6 @@
>  #define DISP_AAL_EN                            0x0000
>  #define DISP_AAL_SIZE                          0x0030
>
> -#define DISP_CCORR_EN                          0x0000
> -#define CCORR_EN                               BIT(0)
> -#define DISP_CCORR_CFG                         0x0020
> -#define CCORR_RELAY_MODE                       BIT(0)
> -#define CCORR_ENGINE_EN                                BIT(1)
> -#define CCORR_GAMMA_OFF                                BIT(2)
> -#define CCORR_WGAMUT_SRC_CLIP                  BIT(3)
> -#define DISP_CCORR_SIZE                                0x0030
> -#define DISP_CCORR_COEF_0                      0x0080
> -#define DISP_CCORR_COEF_1                      0x0084
> -#define DISP_CCORR_COEF_2                      0x0088
> -#define DISP_CCORR_COEF_3                      0x008C
> -#define DISP_CCORR_COEF_4                      0x0090
> -
>  #define DISP_DITHER_EN                         0x0000
>  #define DITHER_EN                              BIT(0)
>  #define DISP_DITHER_CFG                                0x0020
> @@ -266,82 +252,6 @@ static void mtk_aal_stop(struct device *dev)
>         writel_relaxed(0x0, priv->regs + DISP_AAL_EN);
>  }
>
> -static void mtk_ccorr_config(struct device *dev, unsigned int w,
> -                            unsigned int h, unsigned int vrefresh,
> -                            unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> -{
> -       struct mtk_ddp_comp_dev *priv =3D dev_get_drvdata(dev);
> -
> -       mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs,=
 DISP_CCORR_SIZE);
> -       mtk_ddp_write(cmdq_pkt, CCORR_ENGINE_EN, &priv->cmdq_reg, priv->r=
egs, DISP_CCORR_CFG);
> -}
> -
> -static void mtk_ccorr_start(struct device *dev)
> -{
> -       struct mtk_ddp_comp_dev *priv =3D dev_get_drvdata(dev);
> -
> -       writel(CCORR_EN, priv->regs + DISP_CCORR_EN);
> -}
> -
> -static void mtk_ccorr_stop(struct device *dev)
> -{
> -       struct mtk_ddp_comp_dev *priv =3D dev_get_drvdata(dev);
> -
> -       writel_relaxed(0x0, priv->regs + DISP_CCORR_EN);
> -}
> -
> -/* Converts a DRM S31.32 value to the HW S1.10 format. */
> -static u16 mtk_ctm_s31_32_to_s1_10(u64 in)
> -{
> -       u16 r;
> -
> -       /* Sign bit. */
> -       r =3D in & BIT_ULL(63) ? BIT(11) : 0;
> -
> -       if ((in & GENMASK_ULL(62, 33)) > 0) {
> -               /* identity value 0x100000000 -> 0x400, */
> -               /* if bigger this, set it to max 0x7ff. */
> -               r |=3D GENMASK(10, 0);
> -       } else {
> -               /* take the 11 most important bits. */
> -               r |=3D (in >> 22) & GENMASK(10, 0);
> -       }
> -
> -       return r;
> -}
> -
> -static void mtk_ccorr_ctm_set(struct device *dev,
> -                             struct drm_crtc_state *state)
> -{
> -       struct mtk_ddp_comp_dev *priv =3D dev_get_drvdata(dev);
> -       struct drm_property_blob *blob =3D state->ctm;
> -       struct drm_color_ctm *ctm;
> -       const u64 *input;
> -       uint16_t coeffs[9] =3D { 0 };
> -       int i;
> -       struct cmdq_pkt *cmdq_pkt =3D NULL;
> -
> -       if (!blob)
> -               return;
> -
> -       ctm =3D (struct drm_color_ctm *)blob->data;
> -       input =3D ctm->matrix;
> -
> -       for (i =3D 0; i < ARRAY_SIZE(coeffs); i++)
> -               coeffs[i] =3D mtk_ctm_s31_32_to_s1_10(input[i]);
> -
> -       mtk_ddp_write(cmdq_pkt, coeffs[0] << 16 | coeffs[1],
> -                     &priv->cmdq_reg, priv->regs, DISP_CCORR_COEF_0);
> -       mtk_ddp_write(cmdq_pkt, coeffs[2] << 16 | coeffs[3],
> -                     &priv->cmdq_reg, priv->regs, DISP_CCORR_COEF_1);
> -       mtk_ddp_write(cmdq_pkt, coeffs[4] << 16 | coeffs[5],
> -                     &priv->cmdq_reg, priv->regs, DISP_CCORR_COEF_2);
> -       mtk_ddp_write(cmdq_pkt, coeffs[6] << 16 | coeffs[7],
> -                     &priv->cmdq_reg, priv->regs, DISP_CCORR_COEF_3);
> -       mtk_ddp_write(cmdq_pkt, coeffs[8] << 16,
> -                     &priv->cmdq_reg, priv->regs, DISP_CCORR_COEF_4);
> -}
> -
>  static void mtk_dither_config(struct device *dev, unsigned int w,
>                               unsigned int h, unsigned int vrefresh,
>                               unsigned int bpc, struct cmdq_pkt *cmdq_pkt=
)
> @@ -380,8 +290,8 @@ static const struct mtk_ddp_comp_funcs ddp_aal =3D {
>  };
>
>  static const struct mtk_ddp_comp_funcs ddp_ccorr =3D {
> -       .clk_enable =3D mtk_ddp_clk_enable,
> -       .clk_disable =3D mtk_ddp_clk_disable,
> +       .clk_enable =3D mtk_ccorr_clk_enable,
> +       .clk_disable =3D mtk_ccorr_clk_disable,
>         .config =3D mtk_ccorr_config,
>         .start =3D mtk_ccorr_start,
>         .stop =3D mtk_ccorr_stop,
> @@ -642,6 +552,7 @@ int mtk_ddp_comp_init(struct device_node *node, struc=
t mtk_ddp_comp *comp,
>         }
>
>         if (type =3D=3D MTK_DISP_BLS ||
> +           type =3D=3D MTK_DISP_CCORR ||
>             type =3D=3D MTK_DISP_COLOR ||
>             type =3D=3D MTK_DISP_GAMMA ||
>             type =3D=3D MTK_DPI ||
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 486e73e675ad5..b013d56d27773 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -531,11 +531,12 @@ static int mtk_drm_probe(struct platform_device *pd=
ev)
>                 private->comp_node[comp_id] =3D of_node_get(node);
>
>                 /*
> -                * Currently only the COLOR, GAMMA, OVL, RDMA, DSI, and D=
PI blocks have
> -                * separate component platform drivers and initialize the=
ir own
> +                * Currently only the CCORR, COLOR, GAMMA, OVL, RDMA, DSI=
, and DPI
> +                * blocks have separate component platform drivers and in=
itialize their own
>                  * DDP component structure. The others are initialized he=
re.
>                  */
> -               if (comp_type =3D=3D MTK_DISP_COLOR ||
> +               if (comp_type =3D=3D MTK_DISP_CCORR ||
> +                   comp_type =3D=3D MTK_DISP_COLOR ||
>                     comp_type =3D=3D MTK_DISP_GAMMA ||
>                     comp_type =3D=3D MTK_DISP_OVL ||
>                     comp_type =3D=3D MTK_DISP_OVL_2L ||
> @@ -634,6 +635,7 @@ static struct platform_driver mtk_drm_platform_driver=
 =3D {
>  };
>
>  static struct platform_driver * const mtk_drm_drivers[] =3D {
> +       &mtk_disp_ccorr_driver,
>         &mtk_disp_color_driver,
>         &mtk_disp_gamma_driver,
>         &mtk_disp_ovl_driver,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.h
> index 0e54e3d51014a..637f5669e8954 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -46,6 +46,7 @@ struct mtk_drm_private {
>         struct drm_atomic_state *suspend_state;
>  };
>
> +extern struct platform_driver mtk_disp_ccorr_driver;
>  extern struct platform_driver mtk_disp_color_driver;
>  extern struct platform_driver mtk_disp_gamma_driver;
>  extern struct platform_driver mtk_disp_ovl_driver;
> --
> 2.30.0.365.g02bc693789-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
