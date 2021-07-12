Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6EF3C5F57
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 17:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbhGLPgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 11:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232203AbhGLPgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 11:36:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B8BF61221;
        Mon, 12 Jul 2021 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626104036;
        bh=5X2UURg25rMrNoAilDfJ7k5RncDDoVLvR+Fw5b9WLPE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dN9t5tWJoXIcqxJmju4K9H9qiofOopREzVIeKkjPOyRWSxyMPc5+lr+BWCkfl61Qy
         eTun6f4aOQ5xKTiU6IpCRyY4dgvh5uTE3rvyCazU9lR82vjAk65hNQTbF0fLhXDHX6
         BOPT3DwNCG4hkcAhXIe/NJ3k4AkJbRRC6RC34HbTcRgMHKJef/UyEGSdz6KwGHOfFI
         aR2nqk3nPXYzYeude33hsHbYwOJ00nZjplGbhRvSu2UbzKir3Vdj1DZZdzTR3vQBct
         4lcXjW5m4VCZU498cPGilAvzWtBqM/qU2n6q3rrGhwxKvt1gczZBAw4oebh658ugz1
         pwQyWSbW/96sw==
Received: by mail-ej1-f51.google.com with SMTP id i20so35399150ejw.4;
        Mon, 12 Jul 2021 08:33:56 -0700 (PDT)
X-Gm-Message-State: AOAM532ntn8SSOJ4tem1Y/U1bHxHIvLvT9OXk8Yq+lP4ovi30Q3uiyRh
        2oFZWuy1wzvW05p0uYh52ef3jdiOoAkUoiAkHw==
X-Google-Smtp-Source: ABdhPJwj+mU1GvCIh7UbOfcTMRsKzqq4SbbuuVJj57Xk+j0+HYYnALX6tsQE/1bSkimd2ZH7rSzVXRe5CtlOJPmpo1I=
X-Received: by 2002:a17:906:7e4f:: with SMTP id z15mr49606241ejr.194.1626104034975;
 Mon, 12 Jul 2021 08:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <1626051778-13577-1-git-send-email-yongqiang.niu@mediatek.com> <1626051778-13577-3-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1626051778-13577-3-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 12 Jul 2021 23:33:43 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-W-wm2X5PPSzRjQ0LSFEQaDZvsC4bW_Q58NXX-PpBe+Q@mail.gmail.com>
Message-ID: <CAAOTY_-W-wm2X5PPSzRjQ0LSFEQaDZvsC4bW_Q58NXX-PpBe+Q@mail.gmail.com>
Subject: Re: [PATCH v2, 2/3] drm/mediatek: add mt8183 aal support
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
=8812=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=889:03=E5=AF=AB=E9=81=93=
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
