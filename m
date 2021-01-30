Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A347309491
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhA3Ks3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230058AbhA3Ks1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 05:48:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DB8564E11;
        Sat, 30 Jan 2021 10:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612003665;
        bh=5FNwFKFJKhpf5dz+xOSrw5lKqBCBFGGdfkLS/GvS4U4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y/UCH+4q6v/Azl8lKOGRrY5WTdA40/UnzQZOeZzfQmujQuxAMxvm3G2BWudR+b+xh
         y30St+5YJ42fKO0dTS3FKKC3xX8bK7tWWXJeSoCZh4OByPdAGm6KUCfvNWhemd57Rd
         q2mLKYytQfNntKaSoyYe+FjxMRuuDN8EgL6WEw9JeK9mLFsmkW3M7TOD3OgyiKYxMS
         MwhINYfeBtd9fPUTd8DtEkCUB6Hmg6k1rzrKhdhjOtOmh1LN0miLsDuY0BYrAqVjeb
         Z2+b0YKGxmvd3LvBq9rtStDzrO4jQrLA7zdWgfXMv7LbEWBfaJu5sGwMHDoJwPs+ny
         V4cxEPPNMFzKg==
Received: by mail-ed1-f44.google.com with SMTP id s11so13465338edd.5;
        Sat, 30 Jan 2021 02:47:45 -0800 (PST)
X-Gm-Message-State: AOAM5328zoh805BqJx8yAicGfOC/jts8YCQKSGin4wiviU0+qj8+JkJF
        d7vT0ns7jKqIrcjN95TBzQQUIwAT9paP9ZMDHg==
X-Google-Smtp-Source: ABdhPJya6vlJOcHpM9aDxP3BY3pALpxvEEvOK7qY8e2QMrITpzOL3pT09Iph2zKDy0YH88989Zt+MAeN/h2YhQ9FyHU=
X-Received: by 2002:aa7:c604:: with SMTP id h4mr9618476edq.166.1612003663906;
 Sat, 30 Jan 2021 02:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20210129092209.2584718-1-hsinyi@chromium.org> <20210129092209.2584718-9-hsinyi@chromium.org>
In-Reply-To: <20210129092209.2584718-9-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 30 Jan 2021 18:47:31 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8eGVK_fqPh7CH=3KhPXQK_Yi_QMoSp9URV5rVU34e9Cw@mail.gmail.com>
Message-ID: <CAAOTY_8eGVK_fqPh7CH=3KhPXQK_Yi_QMoSp9URV5rVU34e9Cw@mail.gmail.com>
Subject: Re: [PATCH v13 8/8] drm/mediatek: add support for mediatek SOC MT8183
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
> 1. add ovl private data
> 2. add rdma private data
> 3. add gamma privte data
> 4. add main and external path module for crtc create

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
>  drivers/gpu/drm/mediatek/mtk_disp_gamma.c |  1 +
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c   | 18 +++++++++
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c  |  6 +++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c    | 45 +++++++++++++++++++++++
>  4 files changed, 70 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/=
mediatek/mtk_disp_gamma.c
> index 5092a27ccc28b..7121d75a06bdc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> @@ -182,6 +182,7 @@ static const struct mtk_disp_gamma_data mt8173_gamma_=
driver_data =3D {
>  static const struct of_device_id mtk_disp_gamma_driver_dt_match[] =3D {
>         { .compatible =3D "mediatek,mt8173-disp-gamma",
>           .data =3D &mt8173_gamma_driver_data},
> +       { .compatible =3D "mediatek,mt8183-disp-gamma"},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_disp_gamma_driver_dt_match);
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/me=
diatek/mtk_disp_ovl.c
> index 1c295c58a5e82..da7e38a28759b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -424,11 +424,29 @@ static const struct mtk_disp_ovl_data mt8173_ovl_dr=
iver_data =3D {
>         .fmt_rgb565_is_0 =3D true,
>  };
>
> +static const struct mtk_disp_ovl_data mt8183_ovl_driver_data =3D {
> +       .addr =3D DISP_REG_OVL_ADDR_MT8173,
> +       .gmc_bits =3D 10,
> +       .layer_nr =3D 4,
> +       .fmt_rgb565_is_0 =3D true,
> +};
> +
> +static const struct mtk_disp_ovl_data mt8183_ovl_2l_driver_data =3D {
> +       .addr =3D DISP_REG_OVL_ADDR_MT8173,
> +       .gmc_bits =3D 10,
> +       .layer_nr =3D 2,
> +       .fmt_rgb565_is_0 =3D true,
> +};
> +
>  static const struct of_device_id mtk_disp_ovl_driver_dt_match[] =3D {
>         { .compatible =3D "mediatek,mt2701-disp-ovl",
>           .data =3D &mt2701_ovl_driver_data},
>         { .compatible =3D "mediatek,mt8173-disp-ovl",
>           .data =3D &mt8173_ovl_driver_data},
> +       { .compatible =3D "mediatek,mt8183-disp-ovl",
> +         .data =3D &mt8183_ovl_driver_data},
> +       { .compatible =3D "mediatek,mt8183-disp-ovl-2l",
> +         .data =3D &mt8183_ovl_2l_driver_data},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_disp_ovl_driver_dt_match);
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_rdma.c
> index b84004394970f..728aaadfea8cf 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -351,11 +351,17 @@ static const struct mtk_disp_rdma_data mt8173_rdma_=
driver_data =3D {
>         .fifo_size =3D SZ_8K,
>  };
>
> +static const struct mtk_disp_rdma_data mt8183_rdma_driver_data =3D {
> +       .fifo_size =3D 5 * SZ_1K,
> +};
> +
>  static const struct of_device_id mtk_disp_rdma_driver_dt_match[] =3D {
>         { .compatible =3D "mediatek,mt2701-disp-rdma",
>           .data =3D &mt2701_rdma_driver_data},
>         { .compatible =3D "mediatek,mt8173-disp-rdma",
>           .data =3D &mt8173_rdma_driver_data},
> +       { .compatible =3D "mediatek,mt8183-disp-rdma",
> +         .data =3D &mt8183_rdma_driver_data},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_disp_rdma_driver_dt_match);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 279d3e6f11563..486e73e675ad5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -129,6 +129,24 @@ static const enum mtk_ddp_comp_id mt8173_mtk_ddp_ext=
[] =3D {
>         DDP_COMPONENT_DPI0,
>  };
>
> +static const enum mtk_ddp_comp_id mt8183_mtk_ddp_main[] =3D {
> +       DDP_COMPONENT_OVL0,
> +       DDP_COMPONENT_OVL_2L0,
> +       DDP_COMPONENT_RDMA0,
> +       DDP_COMPONENT_COLOR0,
> +       DDP_COMPONENT_CCORR,
> +       DDP_COMPONENT_AAL0,
> +       DDP_COMPONENT_GAMMA,
> +       DDP_COMPONENT_DITHER,
> +       DDP_COMPONENT_DSI0,
> +};
> +
> +static const enum mtk_ddp_comp_id mt8183_mtk_ddp_ext[] =3D {
> +       DDP_COMPONENT_OVL_2L1,
> +       DDP_COMPONENT_RDMA1,
> +       DDP_COMPONENT_DPI0,
> +};
> +
>  static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data =3D {
>         .main_path =3D mt2701_mtk_ddp_main,
>         .main_len =3D ARRAY_SIZE(mt2701_mtk_ddp_main),
> @@ -161,6 +179,13 @@ static const struct mtk_mmsys_driver_data mt8173_mms=
ys_driver_data =3D {
>         .ext_len =3D ARRAY_SIZE(mt8173_mtk_ddp_ext),
>  };
>
> +static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data =3D {
> +       .main_path =3D mt8183_mtk_ddp_main,
> +       .main_len =3D ARRAY_SIZE(mt8183_mtk_ddp_main),
> +       .ext_path =3D mt8183_mtk_ddp_ext,
> +       .ext_len =3D ARRAY_SIZE(mt8183_mtk_ddp_ext),
> +};
> +
>  static int mtk_drm_kms_init(struct drm_device *drm)
>  {
>         struct mtk_drm_private *private =3D drm->dev_private;
> @@ -375,12 +400,20 @@ static const struct of_device_id mtk_ddp_comp_dt_id=
s[] =3D {
>           .data =3D (void *)MTK_DISP_OVL },
>         { .compatible =3D "mediatek,mt8173-disp-ovl",
>           .data =3D (void *)MTK_DISP_OVL },
> +       { .compatible =3D "mediatek,mt8183-disp-ovl",
> +         .data =3D (void *)MTK_DISP_OVL },
> +       { .compatible =3D "mediatek,mt8183-disp-ovl-2l",
> +         .data =3D (void *)MTK_DISP_OVL_2L },
>         { .compatible =3D "mediatek,mt2701-disp-rdma",
>           .data =3D (void *)MTK_DISP_RDMA },
>         { .compatible =3D "mediatek,mt8173-disp-rdma",
>           .data =3D (void *)MTK_DISP_RDMA },
> +       { .compatible =3D "mediatek,mt8183-disp-rdma",
> +         .data =3D (void *)MTK_DISP_RDMA },
>         { .compatible =3D "mediatek,mt8173-disp-wdma",
>           .data =3D (void *)MTK_DISP_WDMA },
> +       { .compatible =3D "mediatek,mt8183-disp-ccorr",
> +         .data =3D (void *)MTK_DISP_CCORR },
>         { .compatible =3D "mediatek,mt2701-disp-color",
>           .data =3D (void *)MTK_DISP_COLOR },
>         { .compatible =3D "mediatek,mt8173-disp-color",
> @@ -389,22 +422,32 @@ static const struct of_device_id mtk_ddp_comp_dt_id=
s[] =3D {
>           .data =3D (void *)MTK_DISP_AAL},
>         { .compatible =3D "mediatek,mt8173-disp-gamma",
>           .data =3D (void *)MTK_DISP_GAMMA, },
> +       { .compatible =3D "mediatek,mt8183-disp-gamma",
> +         .data =3D (void *)MTK_DISP_GAMMA, },
> +       { .compatible =3D "mediatek,mt8183-disp-dither",
> +         .data =3D (void *)MTK_DISP_DITHER },
>         { .compatible =3D "mediatek,mt8173-disp-ufoe",
>           .data =3D (void *)MTK_DISP_UFOE },
>         { .compatible =3D "mediatek,mt2701-dsi",
>           .data =3D (void *)MTK_DSI },
>         { .compatible =3D "mediatek,mt8173-dsi",
>           .data =3D (void *)MTK_DSI },
> +       { .compatible =3D "mediatek,mt8183-dsi",
> +         .data =3D (void *)MTK_DSI },
>         { .compatible =3D "mediatek,mt2701-dpi",
>           .data =3D (void *)MTK_DPI },
>         { .compatible =3D "mediatek,mt8173-dpi",
>           .data =3D (void *)MTK_DPI },
> +       { .compatible =3D "mediatek,mt8183-dpi",
> +         .data =3D (void *)MTK_DPI },
>         { .compatible =3D "mediatek,mt2701-disp-mutex",
>           .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt2712-disp-mutex",
>           .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt8173-disp-mutex",
>           .data =3D (void *)MTK_DISP_MUTEX },
> +       { .compatible =3D "mediatek,mt8183-disp-mutex",
> +         .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt2701-disp-pwm",
>           .data =3D (void *)MTK_DISP_BLS },
>         { .compatible =3D "mediatek,mt8173-disp-pwm",
> @@ -423,6 +466,8 @@ static const struct of_device_id mtk_drm_of_ids[] =3D=
 {
>           .data =3D &mt2712_mmsys_driver_data},
>         { .compatible =3D "mediatek,mt8173-mmsys",
>           .data =3D &mt8173_mmsys_driver_data},
> +       { .compatible =3D "mediatek,mt8183-mmsys",
> +         .data =3D &mt8183_mmsys_driver_data},
>         { }
>  };
>
> --
> 2.30.0.365.g02bc693789-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
