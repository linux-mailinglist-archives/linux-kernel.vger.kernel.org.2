Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E807451C72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352164AbhKPASO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:18:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351692AbhKOXlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:41:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCC0263264;
        Mon, 15 Nov 2021 23:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637019324;
        bh=PCb62uSzHoFDXvpK6GdiAFchpkKe5otH1dTcVl8HL/U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gl/UUtDqFM7yYd0CSxXxZWnFivSQ3/lrQ+nvQchpPDGrLS06u5Fm8i+Q3wH8ekX2y
         bGop6VhsHu/ZElikUu50hHmmPzmc9Em5ffS69D5Xwen+m6BsGkPzdx2fRVT9qpxEQk
         ti8KeoHjVwjfTbf16fD1Ch8jZ6I5nFrwj3CH4Of80HHmbFvh5n+EfodHrMLkQWalym
         7zIYvpOhSPXboM3EulT138y/QiV95MPXdtYy3vZW5jFVBIFpZXY82t6ndiX7+u+v0Y
         Ch4+FwwIy3I08/thSdx3cGlYIvDk7l5jEfyE1IbIVenkwg6WBdzClQezxNeNVHOpiA
         vmP35pFjtOAzw==
Received: by mail-ed1-f46.google.com with SMTP id w1so13061723edc.6;
        Mon, 15 Nov 2021 15:35:24 -0800 (PST)
X-Gm-Message-State: AOAM532s1VmxnwoLW23tW7sYwqVmHJE5Ze9pSkVmrOfWjvZC1aKh1T0l
        KUEqmDhWxM6OmYURhQlAziU+HS/C70ywPnj2rg==
X-Google-Smtp-Source: ABdhPJw+UjacWtQlAoFVaGYNdJuE6YCBvZSUS5QkHlQPat2aY3cXF7+d2BbNsfgziQrDO0UJuJEuHHiE8rB0DWxelS8=
X-Received: by 2002:a50:c34d:: with SMTP id q13mr3823008edb.65.1637019323180;
 Mon, 15 Nov 2021 15:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20210930155222.5861-1-yongqiang.niu@mediatek.com> <20210930155222.5861-6-yongqiang.niu@mediatek.com>
In-Reply-To: <20210930155222.5861-6-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 16 Nov 2021 07:35:12 +0800
X-Gmail-Original-Message-ID: <CAAOTY_90zmM-iqbs7_pjSQgeDvn6=3mczAGo4d0eNWADpNtp6Q@mail.gmail.com>
Message-ID: <CAAOTY_90zmM-iqbs7_pjSQgeDvn6=3mczAGo4d0eNWADpNtp6Q@mail.gmail.com>
Subject: Re: [PATCH v10, 5/5] drm/mediatek: add support for mediatek SOC MT8192
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>, CK Hu <ck.hu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=
=8830=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:52=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> add support for mediatek SOC MT8192

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
>  drivers/gpu/drm/mediatek/mtk_disp_ccorr.c |  6 ++++
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c   | 20 +++++++++++
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c  |  6 ++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c    | 42 +++++++++++++++++++++++
>  4 files changed, 74 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/=
mediatek/mtk_disp_ccorr.c
> index 141cb36b9c07..3a53ebc4e172 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> @@ -205,9 +205,15 @@ static const struct mtk_disp_ccorr_data mt8183_ccorr=
_driver_data =3D {
>         .matrix_bits =3D 10,
>  };
>
> +static const struct mtk_disp_ccorr_data mt8192_ccorr_driver_data =3D {
> +       .matrix_bits =3D 11,
> +};
> +
>  static const struct of_device_id mtk_disp_ccorr_driver_dt_match[] =3D {
>         { .compatible =3D "mediatek,mt8183-disp-ccorr",
>           .data =3D &mt8183_ccorr_driver_data},
> +       { .compatible =3D "mediatek,mt8192-disp-ccorr",
> +         .data =3D &mt8192_ccorr_driver_data},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_disp_ccorr_driver_dt_match);
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/me=
diatek/mtk_disp_ovl.c
> index 5326989d5206..2146299e5f52 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -456,6 +456,22 @@ static const struct mtk_disp_ovl_data mt8183_ovl_2l_=
driver_data =3D {
>         .fmt_rgb565_is_0 =3D true,
>  };
>
> +static const struct mtk_disp_ovl_data mt8192_ovl_driver_data =3D {
> +       .addr =3D DISP_REG_OVL_ADDR_MT8173,
> +       .gmc_bits =3D 10,
> +       .layer_nr =3D 4,
> +       .fmt_rgb565_is_0 =3D true,
> +       .smi_id_en =3D true,
> +};
> +
> +static const struct mtk_disp_ovl_data mt8192_ovl_2l_driver_data =3D {
> +       .addr =3D DISP_REG_OVL_ADDR_MT8173,
> +       .gmc_bits =3D 10,
> +       .layer_nr =3D 2,
> +       .fmt_rgb565_is_0 =3D true,
> +       .smi_id_en =3D true,
> +};
> +
>  static const struct of_device_id mtk_disp_ovl_driver_dt_match[] =3D {
>         { .compatible =3D "mediatek,mt2701-disp-ovl",
>           .data =3D &mt2701_ovl_driver_data},
> @@ -465,6 +481,10 @@ static const struct of_device_id mtk_disp_ovl_driver=
_dt_match[] =3D {
>           .data =3D &mt8183_ovl_driver_data},
>         { .compatible =3D "mediatek,mt8183-disp-ovl-2l",
>           .data =3D &mt8183_ovl_2l_driver_data},
> +       { .compatible =3D "mediatek,mt8192-disp-ovl",
> +         .data =3D &mt8192_ovl_driver_data},
> +       { .compatible =3D "mediatek,mt8192-disp-ovl-2l",
> +         .data =3D &mt8192_ovl_2l_driver_data},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_disp_ovl_driver_dt_match);
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_rdma.c
> index 75d7f45579e2..d41a3970b944 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -353,6 +353,10 @@ static const struct mtk_disp_rdma_data mt8183_rdma_d=
river_data =3D {
>         .fifo_size =3D 5 * SZ_1K,
>  };
>
> +static const struct mtk_disp_rdma_data mt8192_rdma_driver_data =3D {
> +       .fifo_size =3D 5 * SZ_1K,
> +};
> +
>  static const struct of_device_id mtk_disp_rdma_driver_dt_match[] =3D {
>         { .compatible =3D "mediatek,mt2701-disp-rdma",
>           .data =3D &mt2701_rdma_driver_data},
> @@ -360,6 +364,8 @@ static const struct of_device_id mtk_disp_rdma_driver=
_dt_match[] =3D {
>           .data =3D &mt8173_rdma_driver_data},
>         { .compatible =3D "mediatek,mt8183-disp-rdma",
>           .data =3D &mt8183_rdma_driver_data},
> +       { .compatible =3D "mediatek,mt8192-disp-rdma",
> +         .data =3D &mt8192_rdma_driver_data},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_disp_rdma_driver_dt_match);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index aec39724ebeb..fa86485b4b9a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -158,6 +158,25 @@ static const enum mtk_ddp_comp_id mt8183_mtk_ddp_ext=
[] =3D {
>         DDP_COMPONENT_DPI0,
>  };
>
> +static const enum mtk_ddp_comp_id mt8192_mtk_ddp_main[] =3D {
> +       DDP_COMPONENT_OVL0,
> +       DDP_COMPONENT_OVL_2L0,
> +       DDP_COMPONENT_RDMA0,
> +       DDP_COMPONENT_COLOR0,
> +       DDP_COMPONENT_CCORR,
> +       DDP_COMPONENT_AAL0,
> +       DDP_COMPONENT_GAMMA,
> +       DDP_COMPONENT_POSTMASK0,
> +       DDP_COMPONENT_DITHER,
> +       DDP_COMPONENT_DSI0,
> +};
> +
> +static const enum mtk_ddp_comp_id mt8192_mtk_ddp_ext[] =3D {
> +       DDP_COMPONENT_OVL_2L2,
> +       DDP_COMPONENT_RDMA4,
> +       DDP_COMPONENT_DPI0,
> +};
> +
>  static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data =3D {
>         .main_path =3D mt2701_mtk_ddp_main,
>         .main_len =3D ARRAY_SIZE(mt2701_mtk_ddp_main),
> @@ -202,6 +221,13 @@ static const struct mtk_mmsys_driver_data mt8183_mms=
ys_driver_data =3D {
>         .ext_len =3D ARRAY_SIZE(mt8183_mtk_ddp_ext),
>  };
>
> +static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data =3D {
> +       .main_path =3D mt8192_mtk_ddp_main,
> +       .main_len =3D ARRAY_SIZE(mt8192_mtk_ddp_main),
> +       .ext_path =3D mt8192_mtk_ddp_ext,
> +       .ext_len =3D ARRAY_SIZE(mt8192_mtk_ddp_ext),
> +};
> +
>  static int mtk_drm_kms_init(struct drm_device *drm)
>  {
>         struct mtk_drm_private *private =3D drm->dev_private;
> @@ -407,6 +433,10 @@ static const struct of_device_id mtk_ddp_comp_dt_ids=
[] =3D {
>           .data =3D (void *)MTK_DISP_OVL },
>         { .compatible =3D "mediatek,mt8183-disp-ovl-2l",
>           .data =3D (void *)MTK_DISP_OVL_2L },
> +       { .compatible =3D "mediatek,mt8192-disp-ovl",
> +         .data =3D (void *)MTK_DISP_OVL },
> +       { .compatible =3D "mediatek,mt8192-disp-ovl-2l",
> +         .data =3D (void *)MTK_DISP_OVL_2L },
>         { .compatible =3D "mediatek,mt2701-disp-rdma",
>           .data =3D (void *)MTK_DISP_RDMA },
>         { .compatible =3D "mediatek,mt8167-disp-rdma",
> @@ -415,12 +445,16 @@ static const struct of_device_id mtk_ddp_comp_dt_id=
s[] =3D {
>           .data =3D (void *)MTK_DISP_RDMA },
>         { .compatible =3D "mediatek,mt8183-disp-rdma",
>           .data =3D (void *)MTK_DISP_RDMA },
> +       { .compatible =3D "mediatek,mt8192-disp-rdma",
> +         .data =3D (void *)MTK_DISP_RDMA },
>         { .compatible =3D "mediatek,mt8173-disp-wdma",
>           .data =3D (void *)MTK_DISP_WDMA },
>         { .compatible =3D "mediatek,mt8167-disp-ccorr",
>           .data =3D (void *)MTK_DISP_CCORR },
>         { .compatible =3D "mediatek,mt8183-disp-ccorr",
>           .data =3D (void *)MTK_DISP_CCORR },
> +       { .compatible =3D "mediatek,mt8192-disp-ccorr",
> +         .data =3D (void *)MTK_DISP_CCORR },
>         { .compatible =3D "mediatek,mt2701-disp-color",
>           .data =3D (void *)MTK_DISP_COLOR },
>         { .compatible =3D "mediatek,mt8167-disp-color",
> @@ -433,6 +467,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[=
] =3D {
>           .data =3D (void *)MTK_DISP_AAL},
>         { .compatible =3D "mediatek,mt8183-disp-aal",
>           .data =3D (void *)MTK_DISP_AAL},
> +       { .compatible =3D "mediatek,mt8192-disp-aal",
> +         .data =3D (void *)MTK_DISP_AAL},
>         { .compatible =3D "mediatek,mt8167-disp-gamma",
>           .data =3D (void *)MTK_DISP_GAMMA, },
>         { .compatible =3D "mediatek,mt8173-disp-gamma",
> @@ -469,6 +505,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[=
] =3D {
>           .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt8183-disp-mutex",
>           .data =3D (void *)MTK_DISP_MUTEX },
> +       { .compatible =3D "mediatek,mt8192-disp-mutex",
> +         .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt2701-disp-pwm",
>           .data =3D (void *)MTK_DISP_BLS },
>         { .compatible =3D "mediatek,mt8167-disp-pwm",
> @@ -477,6 +515,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[=
] =3D {
>           .data =3D (void *)MTK_DISP_PWM },
>         { .compatible =3D "mediatek,mt8173-disp-od",
>           .data =3D (void *)MTK_DISP_OD },
> +       { .compatible =3D "mediatek,mt8192-disp-postmask",
> +         .data =3D (void *)MTK_DISP_POSTMASK },
>         { }
>  };
>
> @@ -493,6 +533,8 @@ static const struct of_device_id mtk_drm_of_ids[] =3D=
 {
>           .data =3D &mt8173_mmsys_driver_data},
>         { .compatible =3D "mediatek,mt8183-mmsys",
>           .data =3D &mt8183_mmsys_driver_data},
> +       { .compatible =3D "mediatek,mt8192-mmsys",
> +         .data =3D &mt8192_mmsys_driver_data},
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, mtk_drm_of_ids);
> --
> 2.25.1
>
