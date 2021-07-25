Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFA53D4AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 02:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhGYAHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 20:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhGYAHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 20:07:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CADE660EAF;
        Sun, 25 Jul 2021 00:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627174093;
        bh=rqTMF7et93wqK2S9QEQh0AXTbWrjl0wbtX9lz1IwDpU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wkc/uf486ctKkf9xfXEVlqtYx98X7jN6Jmay8fPvmofQL9S2mJxjOHmzYlw7DT9tA
         iVtlr6ZXqvYy3fKU+EX0EQUV9kDwTkhr8LdzEXcixKZ+6WMm0f1q9hVqatLKO9Yuqt
         R0k8mchMGltDjkDvEoCUvg/C57xMBirz7wDWeEcvNTBY+1eHNHmttLPgACc0ST6ZB+
         Aqz5K2O2kbl9FHOOwiwpszjo2GmudHGF+jSIlRuBM0j2EEdnyExvuCjbHCui1X730L
         pHHG6je1mzknwv0vOHUuKGAYHJQY3Um/ohUTWh9zquFt8ftDcRs28OxaOf3OnLVsxD
         QdLR728OSWICQ==
Received: by mail-ed1-f48.google.com with SMTP id n2so6648078eda.10;
        Sat, 24 Jul 2021 17:48:13 -0700 (PDT)
X-Gm-Message-State: AOAM530mzVeaaWi6RGn++oEuiAT2HP5Oca8wU6J/rn4OvPsE3dwC/7Hc
        u7IKAafqlFbeI3Lzu+dKzbmvvwVz3a39C+lK8w==
X-Google-Smtp-Source: ABdhPJyHF3C7y4GxdOWyVoATJvkT4FJF0sPvDzuozkpixhZJOklw3ILHhIso95awG7W8/b7SkUqZ5w068IoN5vLnmUU=
X-Received: by 2002:aa7:c7c2:: with SMTP id o2mr13718311eds.166.1627174092447;
 Sat, 24 Jul 2021 17:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <1626417143-8015-1-git-send-email-yongqiang.niu@mediatek.com> <1626417143-8015-3-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1626417143-8015-3-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 25 Jul 2021 08:48:01 +0800
X-Gmail-Original-Message-ID: <CAAOTY__+KNkf0nc4-RH6HJZuTWMM+JWfKU2Rgctr6XogomNGHA@mail.gmail.com>
Message-ID: <CAAOTY__+KNkf0nc4-RH6HJZuTWMM+JWfKU2Rgctr6XogomNGHA@mail.gmail.com>
Subject: Re: [PATCH v3, 2/3] drm/mediatek: add mt8183 aal support
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
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=
=8816=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:32=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This patch add mt8183 private data

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_aal.c | 1 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/me=
diatek/mtk_disp_aal.c
> index fb212e96..64b4528 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> @@ -151,6 +151,7 @@ static int mtk_disp_aal_remove(struct platform_device=
 *pdev)
>  static const struct of_device_id mtk_disp_aal_driver_dt_match[] =3D {
>         { .compatible =3D "mediatek,mt8173-disp-aal",
>           .data =3D &mt8173_aal_driver_data},
> +       { .compatible =3D "mediatek,mt8183-disp-aal"},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_disp_aal_driver_dt_match);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 67a585e..143ba24 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -420,6 +420,8 @@ static void mtk_drm_unbind(struct device *dev)
>           .data =3D (void *)MTK_DISP_COLOR },
>         { .compatible =3D "mediatek,mt8173-disp-aal",
>           .data =3D (void *)MTK_DISP_AAL},
> +       { .compatible =3D "mediatek,mt8183-disp-aal",
> +         .data =3D (void *)MTK_DISP_AAL},
>         { .compatible =3D "mediatek,mt8173-disp-gamma",
>           .data =3D (void *)MTK_DISP_GAMMA, },
>         { .compatible =3D "mediatek,mt8183-disp-gamma",
> --
> 1.8.1.1.dirty
>
