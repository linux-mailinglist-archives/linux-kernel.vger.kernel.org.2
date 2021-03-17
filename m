Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C968F33F45C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 16:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhCQPtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 11:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231998AbhCQPsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1154664F5E;
        Wed, 17 Mar 2021 15:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615995291;
        bh=H6ToFP9IpajHVCAlF99k3SS6q1zby7bi+PPlrMJQOdQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fuDHz6UVURxUyrd7PzH5LVSEU2BR0ELsxOfALk/LlAmYMQZMmXBVsWbyqgCdBUPN7
         WlUYOiNRq4Q6WHGSwG5eFQEwIejGTlIQA8PzLf2oZvkMKWbcAYpNHlM21x0QJxFCI5
         mWaJugGH0EkqOrUqLgJ82lc7/pQSehtlKRMuCwxfipFUUlRhMwYiUh90+EPQPOMZFa
         wA/oJ/qmRrg+pc9nU0atUpPKgOj4s82jaqjCF0NpViOa0fpy4TLjpnEeFBuOhR+uxp
         0DdvfQ5iL4ofew/T204nrFq5xqIqEhgyoqpWbQx6Xi7PBmyBnr4jyZfejTRWMoaEOK
         w8p+hUDhUGXzg==
Received: by mail-ej1-f49.google.com with SMTP id dx17so3327942ejb.2;
        Wed, 17 Mar 2021 08:34:50 -0700 (PDT)
X-Gm-Message-State: AOAM532oBIZWMm+AZkbxDq6rZlr5/4scDgCCxb9KqnuxeTbRtHS1Me85
        /zJ6D+grrxj/W0nOCy42Q3/x7hbejYLAG2TlUw==
X-Google-Smtp-Source: ABdhPJwSiOiRDcVZYuIJiV7u6IZ2RehlGlE6RVJe04HiMs9FM5CJD8TDbdJFQJRTY2Pp3r0L1WnqjxkxX4VsM2B0y+s=
X-Received: by 2002:a17:906:9888:: with SMTP id zc8mr36576434ejb.310.1615995289517;
 Wed, 17 Mar 2021 08:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <1615865179-22051-1-git-send-email-rex-bc.chen@mediatek.com> <1615865179-22051-2-git-send-email-rex-bc.chen@mediatek.com>
In-Reply-To: <1615865179-22051-2-git-send-email-rex-bc.chen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 17 Mar 2021 23:34:38 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8pt5Vm9Xjy-c4kLV0qcmVJQp4Pj2=gokrnuGrdrYD7Nw@mail.gmail.com>
Message-ID: <CAAOTY_8pt5Vm9Xjy-c4kLV0qcmVJQp4Pj2=gokrnuGrdrYD7Nw@mail.gmail.com>
Subject: Re: [RESEND,v4,1/2] drm/mediatek: mtk_dpi: Add check for max clock
 rate in mode_valid
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rex:

Rex-BC Chen <rex-bc.chen@mediatek.com> =E6=96=BC 2021=E5=B9=B43=E6=9C=8816=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8811:26=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add per-platform max clock rate check in mtk_dpi_bridge_mode_valid.
>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index b05f900d9322..e1945d4bd7c4 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -120,6 +120,7 @@ struct mtk_dpi_yc_limit {
>  struct mtk_dpi_conf {
>         unsigned int (*cal_factor)(int clock);
>         u32 reg_h_fre_con;
> +       u32 max_clock_khz;
>         bool edge_sel_en;
>  };
>
> @@ -557,9 +558,22 @@ static void mtk_dpi_bridge_enable(struct drm_bridge =
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

Build error:

../drivers/gpu/drm/mediatek/mtk_dpi.c:576:16: error: initialization
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
  .mode_valid =3D mtk_dpi_bridge_mode_valid,
                ^~~~~~~~~~~~~~~~~~~~~~~~~

Please remove my 'Reviewed-by' tag.

Regards,
Chun-Kuang.

>         .disable =3D mtk_dpi_bridge_disable,
>         .enable =3D mtk_dpi_bridge_enable,
>  };
> @@ -668,17 +682,20 @@ static unsigned int mt8183_calculate_factor(int clo=
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
> 2.18.0
>
