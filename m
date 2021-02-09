Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8524A3144B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhBIAOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:14:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhBIAN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:13:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9187964EAA;
        Tue,  9 Feb 2021 00:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612829597;
        bh=YGQmG5Aw41UXZ3vI14ndhT9iSdpoqlYcFpzEnNjxbjE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WbIo1RFAUb3UxRl4kThhbzRV6iE2oes6501a2dews7L6RpBw1Tp+RWtbCFOId5QLv
         +ogETCL1EKjjPK8T5pXEVCnYLqhzsbWHzM0TVsC+cEyFOy0fsP0gPg/vtyyyeIbnmk
         y8JqSEYI7gqgh5fwAmG1FX0iH2cHpY6FNb9PtLINeRCsDfvkO96IIrZDqEyYOrY+PD
         AbngIjlr6E17MKSxtNUX9+oWYwDQUTxRrG19/1QypjWGsw4/ylB6XvoWN65+zAOUvz
         +461sHNjjZFHFZZYVBe8lfQtSaQ5DnRGbkAkXWlf4Ro5Mk0y0STLO6XUcxtFUAVM/l
         EYXYuP6EsjVVA==
Received: by mail-ed1-f51.google.com with SMTP id c6so21425244ede.0;
        Mon, 08 Feb 2021 16:13:17 -0800 (PST)
X-Gm-Message-State: AOAM531CgVvij/TN31Yw+pqXdkJBwFiSGCumVJoqryUflBr5+EEs9pyn
        MLLIHZXNXkZTMP643H9w5+5Doj0oTTIxNqzLUQ==
X-Google-Smtp-Source: ABdhPJxAI/h9uXjLJYnN0Sa3CKD70oKvcOCCJCsQsOiLlPPOuDvuzg3BdEn1AI05WVTfO15A/MjEAGAWq5okef9eZWg=
X-Received: by 2002:a50:d90a:: with SMTP id t10mr20535060edj.162.1612829596148;
 Mon, 08 Feb 2021 16:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20210208014221.196584-1-jitao.shi@mediatek.com> <20210208014221.196584-2-jitao.shi@mediatek.com>
In-Reply-To: <20210208014221.196584-2-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 9 Feb 2021 08:13:05 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-tEJA7suX_9PH9XRcjdd67o6aVw+Nd4A-PBjEFxOUKcQ@mail.gmail.com>
Message-ID: <CAAOTY_-tEJA7suX_9PH9XRcjdd67o6aVw+Nd4A-PBjEFxOUKcQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/mediatek: mtk_dpi: Add check for max clock
 rate in mode_valid
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        CK Hu <ck.hu@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>, stonea168@163.com,
        huijuan.xie@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, shuijing.li@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2021=E5=B9=B42=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=889:42=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add per-platform max clock rate check in mtk_dpi_bridge_mode_valid.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 52f11a63a330..ffa4a0f1989f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -118,6 +118,7 @@ struct mtk_dpi_yc_limit {
>  struct mtk_dpi_conf {
>         unsigned int (*cal_factor)(int clock);
>         u32 reg_h_fre_con;
> +       u32 max_clock_khz;
>         bool edge_sel_en;
>  };
>
> @@ -555,9 +556,22 @@ static void mtk_dpi_bridge_enable(struct drm_bridge =
*bridge)
>         mtk_dpi_set_display_mode(dpi, &dpi->mode);
>  }
>
> +static enum drm_mode_status
> +mtk_dpi_bridge_mode_valid(struct drm_bridge *bridge,
> +                         const struct drm_display_mode *mode)
> +{
> +       struct mtk_dpi *dpi =3D bridge_to_dpi(bridge);
> +
> +       if (dpi->conf->max_clock_khz && mode->clock > dpi->conf->max_cloc=
k_khz)
> +               return MODE_CLOCK_HIGH;
> +
> +       return MODE_OK;
> +}
> +
>  static const struct drm_bridge_funcs mtk_dpi_bridge_funcs =3D {
>         .attach =3D mtk_dpi_bridge_attach,
>         .mode_set =3D mtk_dpi_bridge_mode_set,
> +       .mode_valid =3D mtk_dpi_bridge_mode_valid,
>         .disable =3D mtk_dpi_bridge_disable,
>         .enable =3D mtk_dpi_bridge_enable,
>  };
> @@ -673,17 +687,20 @@ static unsigned int mt8183_calculate_factor(int clo=
ck)
>  static const struct mtk_dpi_conf mt8173_conf =3D {
>         .cal_factor =3D mt8173_calculate_factor,
>         .reg_h_fre_con =3D 0xe0,
> +       .max_clock_khz =3D 300000,
>  };
>
>  static const struct mtk_dpi_conf mt2701_conf =3D {
>         .cal_factor =3D mt2701_calculate_factor,
>         .reg_h_fre_con =3D 0xb0,
>         .edge_sel_en =3D true,
> +       .max_clock_khz =3D 150000,
>  };
>
>  static const struct mtk_dpi_conf mt8183_conf =3D {
>         .cal_factor =3D mt8183_calculate_factor,
>         .reg_h_fre_con =3D 0xe0,
> +       .max_clock_khz =3D 100000,
>  };
>
>  static int mtk_dpi_probe(struct platform_device *pdev)
> --
> 2.25.1
