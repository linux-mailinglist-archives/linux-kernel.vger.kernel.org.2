Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60093E2EA3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 18:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbhHFQ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 12:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238146AbhHFQ6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 12:58:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D515611CA;
        Fri,  6 Aug 2021 16:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628269071;
        bh=Iq3JFJpe4v4uars7zwQdHHDQ5cN6JTmt9RP3MFgbTJo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sa5Y+iW+M7ymqXw5tGZTbBJeK5UwSDhC4CdImHeRte7FAaEHEzd9VhUmqeGSoJCdk
         0cKJRiJToy5IcGckswSD2+5IWtOr4yqsq4+MXJ9meKhBwwX0y3yPOCb7rywHCsj3I7
         5G6ZCsy4ScfcTMvlCw9acVXlYNM0rf1NZ7ktAOUZtDEx8D/+ebr/TuzRkGk6ODZOr8
         VP6WKP+A14yiSAWcP7GoSYwPoRjEj3YCvmymyDHf9KkJK2kGdVcnslTd9hrRrSUu0S
         4xZAgOkW2nnO+xBUJNgU7RMW174zn06MRTJ17FgOBdYe/Jj5GOATsvTGslcE0oy0tc
         Mp2UR2Jvz3EOw==
Received: by mail-ed1-f47.google.com with SMTP id y7so13935101eda.5;
        Fri, 06 Aug 2021 09:57:51 -0700 (PDT)
X-Gm-Message-State: AOAM531baeSp1aCs8LRxnI26hPW7R2y/3tvGGIxnOfuJRrrAnWL56c/9
        lKXgs43TTCkAaeOy0TPVpNlKnAPYHdZq9Rtg8w==
X-Google-Smtp-Source: ABdhPJwpPAHkKVYX0mPM6GGHdCCqQFtp/LkO7Ls+T5FRP12kWP7vN85NI62JbQ33Fcq2pTG3c2S0PG+abga+IcjVHgQ=
X-Received: by 2002:a05:6402:440e:: with SMTP id y14mr14390681eda.38.1628269070008;
 Fri, 06 Aug 2021 09:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210805205226.24880-1-jason-jh.lin@mediatek.com> <20210805205226.24880-8-jason-jh.lin@mediatek.com>
In-Reply-To: <20210805205226.24880-8-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 7 Aug 2021 00:57:39 +0800
X-Gmail-Original-Message-ID: <CAAOTY__RgqdMfE5w4VK7cdZkZNEY0=sqFsuAUeQTPQfte2fYXQ@mail.gmail.com>
Message-ID: <CAAOTY__RgqdMfE5w4VK7cdZkZNEY0=sqFsuAUeQTPQfte2fYXQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] drm/mediatek: add mediatek-drm of vdosys0 support
 for mt8195
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        fshao@chromium.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B48=E6=9C=886=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=884:52=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Add driver data of mt8195 vdosys0 to mediatek-drm and the sub driver.
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
> This patch is base on [1]
>
> [1] dt-bindings: mediatek: display: add mt8195 SoC binding
> https://patchwork.kernel.org/project/linux-mediatek/patch/20210805171346.=
24249-5-jason-jh.lin@mediatek.com/
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c |  6 +++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c   | 28 ++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_rdma.c
> index 728aaadfea8c..00e9827acefe 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -355,6 +355,10 @@ static const struct mtk_disp_rdma_data mt8183_rdma_d=
river_data =3D {
>         .fifo_size =3D 5 * SZ_1K,
>  };
>
> +static const struct mtk_disp_rdma_data mt8195_rdma_driver_data =3D {
> +       .fifo_size =3D 1920,
> +};
> +
>  static const struct of_device_id mtk_disp_rdma_driver_dt_match[] =3D {
>         { .compatible =3D "mediatek,mt2701-disp-rdma",
>           .data =3D &mt2701_rdma_driver_data},
> @@ -362,6 +366,8 @@ static const struct of_device_id mtk_disp_rdma_driver=
_dt_match[] =3D {
>           .data =3D &mt8173_rdma_driver_data},
>         { .compatible =3D "mediatek,mt8183-disp-rdma",
>           .data =3D &mt8183_rdma_driver_data},
> +       { .compatible =3D "mediatek,mt8195-disp-rdma",
> +         .data =3D &mt8195_rdma_driver_data},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_disp_rdma_driver_dt_match);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 5eb9c0a04447..9aebf73144c6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -147,6 +147,19 @@ static const enum mtk_ddp_comp_id mt8183_mtk_ddp_ext=
[] =3D {
>         DDP_COMPONENT_DPI0,
>  };
>
> +static const enum mtk_ddp_comp_id mt8195_mtk_ddp_main[] =3D {
> +       DDP_COMPONENT_OVL0,
> +       DDP_COMPONENT_RDMA0,
> +       DDP_COMPONENT_COLOR0,
> +       DDP_COMPONENT_CCORR,
> +       DDP_COMPONENT_AAL0,
> +       DDP_COMPONENT_GAMMA,
> +       DDP_COMPONENT_DITHER,
> +       DDP_COMPONENT_DSC0,
> +       DDP_COMPONENT_MERGE0,
> +       DDP_COMPONENT_DP_INTF0,
> +};
> +
>  static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data =3D {
>         .main_path =3D mt2701_mtk_ddp_main,
>         .main_len =3D ARRAY_SIZE(mt2701_mtk_ddp_main),
> @@ -186,6 +199,11 @@ static const struct mtk_mmsys_driver_data mt8183_mms=
ys_driver_data =3D {
>         .ext_len =3D ARRAY_SIZE(mt8183_mtk_ddp_ext),
>  };
>
> +static const struct mtk_mmsys_driver_data mt8195_vdosys0_driver_data =3D=
 {
> +       .main_path =3D mt8195_mtk_ddp_main,
> +       .main_len =3D ARRAY_SIZE(mt8195_mtk_ddp_main),
> +};
> +
>  static int mtk_drm_kms_init(struct drm_device *drm)
>  {
>         struct mtk_drm_private *private =3D drm->dev_private;
> @@ -406,10 +424,14 @@ static const struct of_device_id mtk_ddp_comp_dt_id=
s[] =3D {
>           .data =3D (void *)MTK_DISP_COLOR },
>         { .compatible =3D "mediatek,mt8183-disp-dither",
>           .data =3D (void *)MTK_DISP_DITHER },
> +       { .compatible =3D "mediatek,mt8195-disp-dsc",
> +         .data =3D (void *)MTK_DISP_DSC },
>         { .compatible =3D "mediatek,mt8173-disp-gamma",
>           .data =3D (void *)MTK_DISP_GAMMA, },
>         { .compatible =3D "mediatek,mt8183-disp-gamma",
>           .data =3D (void *)MTK_DISP_GAMMA, },
> +       { .compatible =3D "mediatek,mt8195-disp-merge",
> +         .data =3D (void *)MTK_DISP_MERGE },
>         { .compatible =3D "mediatek,mt2701-disp-mutex",
>           .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt2712-disp-mutex",
> @@ -418,6 +440,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[=
] =3D {
>           .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt8183-disp-mutex",
>           .data =3D (void *)MTK_DISP_MUTEX },
> +       { .compatible =3D "mediatek,mt8195-disp-mutex",
> +         .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt8173-disp-od",
>           .data =3D (void *)MTK_DISP_OD },
>         { .compatible =3D "mediatek,mt2701-disp-ovl",
> @@ -438,6 +462,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[=
] =3D {
>           .data =3D (void *)MTK_DISP_RDMA },
>         { .compatible =3D "mediatek,mt8183-disp-rdma",
>           .data =3D (void *)MTK_DISP_RDMA },
> +       { .compatible =3D "mediatek,mt8195-disp-rdma",
> +         .data =3D (void *)MTK_DISP_RDMA },
>         { .compatible =3D "mediatek,mt8173-disp-ufoe",
>           .data =3D (void *)MTK_DISP_UFOE },
>         { .compatible =3D "mediatek,mt8173-disp-wdma",
> @@ -468,6 +494,8 @@ static const struct of_device_id mtk_drm_of_ids[] =3D=
 {
>           .data =3D &mt8173_mmsys_driver_data},
>         { .compatible =3D "mediatek,mt8183-mmsys",
>           .data =3D &mt8183_mmsys_driver_data},
> +       {.compatible =3D "mediatek,mt8195-vdosys0",
> +         .data =3D &mt8195_vdosys0_driver_data},
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, mtk_drm_of_ids);
> --
> 2.18.0
>
