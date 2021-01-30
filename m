Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A8F3093C4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhA3Jyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:54:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231843AbhA3JvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:51:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 226D064E1D;
        Sat, 30 Jan 2021 09:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612000238;
        bh=LgbTJ3tIY4Lnts/jruQ5ky4J32Gja9Xar9VtrIT5m7s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZGc4Dp9pFYJB3Qk84ZMLh8zkmFk5HHHd/Bjgs6SCzp5+3kOiR1vyYsgvfrAbVT/Ff
         2jDaPOyMG8UPPNXpBDb/5EPhgpr1ecE/3RDWHo+OPFjEjsULvaGx2/uCp2SUxnHwp8
         2kgoIE+MGS/QX0+BoPSCYb5l0NifbdP8+YDbGTiMnAeUaOwZjfdj9JspGUvd3MngMd
         vfoPduAzugr5SYmF7FNqwTTgv7iLSPLECf9Dh31REt+cHXFsAgjnPT7k/w0jv3UwSi
         tvPdS1/k16VJ/TZKFBiHDwKJ5Dbo8i/UY5MVq7Rx9Xbfj1Zx7Eo6ms08CNTMyUk9a3
         vQtq7fNqMx6Rg==
Received: by mail-ej1-f41.google.com with SMTP id bl23so16599651ejb.5;
        Sat, 30 Jan 2021 01:50:38 -0800 (PST)
X-Gm-Message-State: AOAM533wa0Ytk0/C14HKA0MP2j9NKcgRTr0TjptPKPt7sW+lK3ymaHXf
        fj+W+sQ2mnNxXKw5kKeGZM/0/w3S8m+ZGF4Ong==
X-Google-Smtp-Source: ABdhPJxwx47bk8a8xJ4z+4Bse0bBxxcXlzdas3fZag7eVRjxwW7pgp0Q0F5u63eOPTKakYowMCaLKipX3ONZL2WLuXE=
X-Received: by 2002:a17:906:7f98:: with SMTP id f24mr8362943ejr.75.1612000236687;
 Sat, 30 Jan 2021 01:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20210129092209.2584718-1-hsinyi@chromium.org> <20210129092209.2584718-4-hsinyi@chromium.org>
In-Reply-To: <20210129092209.2584718-4-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 30 Jan 2021 17:50:23 +0800
X-Gmail-Original-Message-ID: <CAAOTY_88vkrYHKr6amT-ftP1QcY9=dVFDGuu5fD3-2fRbm_Fpw@mail.gmail.com>
Message-ID: <CAAOTY_88vkrYHKr6amT-ftP1QcY9=dVFDGuu5fD3-2fRbm_Fpw@mail.gmail.com>
Subject: Re: [PATCH v13 3/8] drm/mediatek: add mtk_dither_set_common() function
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
> Current implementation of mtk_dither_set() cast dev data to
> struct mtk_ddp_comp_dev. But other devices with different dev data
> would also call this function.
>
> Separate necessary parameters out so other device components (dither,
> gamma) can call this function.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  4 +++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 27 ++++++++++++++-------
>  2 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/me=
diatek/mtk_disp_drv.h
> index 46d199b7b4a29..9e5537f76b22a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> @@ -17,6 +17,10 @@ void mtk_color_config(struct device *dev, unsigned int=
 w,
>                       unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
>  void mtk_color_start(struct device *dev);
>
> +void mtk_dither_set_common(void __iomem *regs, struct cmdq_client_reg *c=
mdq_reg,
> +                          unsigned int bpc, unsigned int cfg,
> +                          unsigned int dither_en, struct cmdq_pkt *cmdq_=
pkt);
> +
>  void mtk_dpi_start(struct device *dev);
>  void mtk_dpi_stop(struct device *dev);
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 7b5293429426d..07804ab16f44d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -151,33 +151,42 @@ static void mtk_ddp_clk_disable(struct device *dev)
>         clk_disable_unprepare(priv->clk);
>  }
>
> -static void mtk_dither_set(struct device *dev, unsigned int bpc,
> -                   unsigned int CFG, struct cmdq_pkt *cmdq_pkt)
> -{
> -       struct mtk_ddp_comp_dev *priv =3D dev_get_drvdata(dev);
>
> +void mtk_dither_set_common(void __iomem *regs, struct cmdq_client_reg *c=
mdq_reg,
> +                          unsigned int bpc, unsigned int cfg,
> +                          unsigned int dither_en, struct cmdq_pkt *cmdq_=
pkt)
> +{
>         /* If bpc equal to 0, the dithering function didn't be enabled */
>         if (bpc =3D=3D 0)
>                 return;
>
>         if (bpc >=3D MTK_MIN_BPC) {
> -               mtk_ddp_write(cmdq_pkt, 0, &priv->cmdq_reg, priv->regs, D=
ISP_DITHER_5);
> -               mtk_ddp_write(cmdq_pkt, 0, &priv->cmdq_reg, priv->regs, D=
ISP_DITHER_7);
> +               mtk_ddp_write(cmdq_pkt, 0, cmdq_reg, regs, DISP_DITHER_5)=
;
> +               mtk_ddp_write(cmdq_pkt, 0, cmdq_reg, regs, DISP_DITHER_7)=
;
>                 mtk_ddp_write(cmdq_pkt,
>                               DITHER_LSB_ERR_SHIFT_R(MTK_MAX_BPC - bpc) |
>                               DITHER_ADD_LSHIFT_R(MTK_MAX_BPC - bpc) |
>                               DITHER_NEW_BIT_MODE,
> -                             &priv->cmdq_reg, priv->regs, DISP_DITHER_15=
);
> +                             cmdq_reg, regs, DISP_DITHER_15);
>                 mtk_ddp_write(cmdq_pkt,
>                               DITHER_LSB_ERR_SHIFT_B(MTK_MAX_BPC - bpc) |
>                               DITHER_ADD_LSHIFT_B(MTK_MAX_BPC - bpc) |
>                               DITHER_LSB_ERR_SHIFT_G(MTK_MAX_BPC - bpc) |
>                               DITHER_ADD_LSHIFT_G(MTK_MAX_BPC - bpc),
> -                             &priv->cmdq_reg, priv->regs, DISP_DITHER_16=
);
> -               mtk_ddp_write(cmdq_pkt, DISP_DITHERING, &priv->cmdq_reg, =
priv->regs, CFG);
> +                             cmdq_reg, regs, DISP_DITHER_16);
> +               mtk_ddp_write(cmdq_pkt, dither_en, cmdq_reg, regs, cfg);
>         }
>  }
>
> +static void mtk_dither_set(struct device *dev, unsigned int bpc,
> +                   unsigned int cfg, struct cmdq_pkt *cmdq_pkt)
> +{
> +       struct mtk_ddp_comp_dev *priv =3D dev_get_drvdata(dev);
> +
> +       mtk_dither_set_common(priv->regs, &priv->cmdq_reg, bpc, cfg,
> +                             DISP_DITHERING, cmdq_pkt);
> +}
> +
>  static void mtk_od_config(struct device *dev, unsigned int w,
>                           unsigned int h, unsigned int vrefresh,
>                           unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> --
> 2.30.0.365.g02bc693789-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
