Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343523C863B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhGNOin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231977AbhGNOil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:38:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78397613C0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 14:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626273349;
        bh=M3HjJVm0txCIX2c2GAG6GyVimWezeOrVUPEb3tzfzGY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XQn3x5e1Q9qEHi79IweZ0O0/41jRm8IcUHnzO53PMGkMLfY7G+FWMiISzzKVaOnMM
         qFmt/dbo9871iRZkbxrNZf/KAl54DtLB1zAEWx1kPxHdMYuWpFRBhJEPgLXORO/tvb
         csUPzFDwK8bGA/bF+WKQ77KbEcsWt6kL1Y62J0fDPjq+gGqJc6PNLxw0dE3EAvO0y9
         tSJddHNzXGvk7tvTSH6hS6Q2R9n9M8WX3U9aiRmx+lb0rxNff7unYXEQMyxBJwloH4
         uM6dINpLi9S+swiq7F2GcXvwfUBBr9z3gsZy6AMYPTqCqSf4pdQt61tW6wvbrLnyfc
         nDE9ayNZm+MAw==
Received: by mail-ej1-f53.google.com with SMTP id v20so3657778eji.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 07:35:49 -0700 (PDT)
X-Gm-Message-State: AOAM5328tTRDnOVUm3toNxlDAQTKC1zVOKIHGXmU0yE+Wq93vx9P38Pb
        TuXuT/JSuNuBGRK8RUvVRrv6Mtvmgf1TeKlJaQ==
X-Google-Smtp-Source: ABdhPJymfAgJfY2wCBGWNtXmuwg4agIU3K1RR96RYccGqz81ewoSZFhIn4O5wGRSm5qYhoaOeb28aOuzSwDvWj0M0Wc=
X-Received: by 2002:a17:906:aaca:: with SMTP id kt10mr12662752ejb.127.1626273348048;
 Wed, 14 Jul 2021 07:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210710113819.5170-1-jason-jh.lin@mediatek.com> <20210710113819.5170-8-jason-jh.lin@mediatek.com>
In-Reply-To: <20210710113819.5170-8-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 14 Jul 2021 22:35:37 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8LW0VSLL7P2qWOWngPF36FzzJvhdk6_0wGvkaWH3R1ZA@mail.gmail.com>
Message-ID: <CAAOTY_8LW0VSLL7P2qWOWngPF36FzzJvhdk6_0wGvkaWH3R1ZA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] drm/mediatek: add mediatek-drm of vdosys0 support
 for mt8195
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
> Add driver data of mt8195 vdosys0 to mediatek-drm and the sub driver.
>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c |  6 ++++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c   | 24 ++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
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
> index b46bdb8985da..d6f6d1bdad85 100644
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

Where is the dp_intf driver in this series?

Regards,
Chun-Kuang.

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
> @@ -410,6 +428,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[=
] =3D {
>           .data =3D (void *)MTK_DISP_RDMA },
>         { .compatible =3D "mediatek,mt8183-disp-rdma",
>           .data =3D (void *)MTK_DISP_RDMA },
> +       { .compatible =3D "mediatek,mt8195-disp-rdma",
> +         .data =3D (void *)MTK_DISP_RDMA },
>         { .compatible =3D "mediatek,mt8173-disp-wdma",
>           .data =3D (void *)MTK_DISP_WDMA },
>         { .compatible =3D "mediatek,mt8183-disp-ccorr",
> @@ -448,6 +468,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[=
] =3D {
>           .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt8183-disp-mutex",
>           .data =3D (void *)MTK_DISP_MUTEX },
> +       { .compatible =3D "mediatek,mt8195-disp-mutex",
> +         .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt2701-disp-pwm",
>           .data =3D (void *)MTK_DISP_BLS },
>         { .compatible =3D "mediatek,mt8173-disp-pwm",
> @@ -468,6 +490,8 @@ static const struct of_device_id mtk_drm_of_ids[] =3D=
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
