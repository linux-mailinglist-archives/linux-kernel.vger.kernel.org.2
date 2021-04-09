Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AE735A8EB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 00:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbhDIWmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 18:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235147AbhDIWmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 18:42:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F020F610F9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 22:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618008109;
        bh=kPU9MHQc5UBpAesVzgChKDqg5ezVTH1zzx3kKya3lS4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mfx9Ja5QDAcDuMJ0cIxsWj13awopKAanMQQzk+uzyiLfl6TBS7Xqs4+NpUjdzNUXC
         75PSiAv+VD5ODnnyL39lVTG/vhDVaXwWJ2E0MfPoxNMEXd/N0TnLm4k9lkt64NNf+c
         l+Bp0I2AC9QSs6qF+l5MmOKKOQzpmgmRHEmYpoXr3s44mYSjUKF+Cn4+8eOQ1Tc7MH
         YxHaByhjSpZ1f/9UG1k29pR6Z97BaFBRBtxI6BVt1LKOcx7F7Doq5fplTZ2ViyigxG
         D5vBngsUX2T3QOTDzGuvJZ/Dn73CQymnFUi9V6PtdVkgqFfrulmeI1SzHSQA2h2jC2
         cadyrrYvXPmIg==
Received: by mail-ej1-f53.google.com with SMTP id e14so10975444ejz.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 15:41:48 -0700 (PDT)
X-Gm-Message-State: AOAM533bwTv1L330piu3U8pakd0G6tKltG5Q2qQyldnyYFYHpns/QfA1
        ahkSrBzo/t0oc0b2L4IYFxBGdt7ZoTE7ru046w==
X-Google-Smtp-Source: ABdhPJxHH2lrOdOuGA1wZAlZs2TRipft1zFc1O4kBSOWkcjad7ttw50P23oLD4EgsHthvgWENyhgcC/G8ZhZKbbGe4U=
X-Received: by 2002:a17:907:700d:: with SMTP id wr13mr18342403ejb.310.1618008107597;
 Fri, 09 Apr 2021 15:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210409084308.481185-1-narmstrong@baylibre.com>
In-Reply-To: <20210409084308.481185-1-narmstrong@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 10 Apr 2021 06:41:36 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-gqN2HCLg6AABsXYzJoBxpN8FkMfjqWFu2q=6noiY1qg@mail.gmail.com>
Message-ID: <CAAOTY_-gqN2HCLg6AABsXYzJoBxpN8FkMfjqWFu2q=6noiY1qg@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm: mediatek: hdmi: check for valid modes on MT8167
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Neil:

Neil Armstrong <narmstrong@baylibre.com> =E6=96=BC 2021=E5=B9=B44=E6=9C=889=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On MT8167, only CEA modes and anything using a clock below 148500 is
> supported for HDMI. This change adds some checks to make sure the
> video format is OK for MT8167.

I think this patch should be separated to 3 patches. check CEA mode,
check clock, add mt8167 hdmi support.

>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index 8ee55f9e2954..991e2e935b93 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -148,6 +148,8 @@ struct hdmi_audio_param {
>
>  struct mtk_hdmi_conf {
>         bool tz_disabled;
> +       unsigned long max_mode_clock;
> +       bool cea_modes_only;
>  };
>
>  struct mtk_hdmi {
> @@ -1259,6 +1261,13 @@ static int mtk_hdmi_conn_mode_valid(struct drm_con=
nector *conn,
>                         return MODE_BAD;
>         }
>
> +       if (hdmi->conf->cea_modes_only && !drm_match_cea_mode(mode))
> +               return MODE_BAD;
> +
> +       if (hdmi->conf->max_mode_clock &&
> +           mode->clock > hdmi->conf->max_mode_clock)
> +               return MODE_CLOCK_HIGH;
> +
>         if (mode->clock < 27000)
>                 return MODE_CLOCK_LOW;
>         if (mode->clock > 297000)
> @@ -1810,10 +1819,18 @@ static const struct mtk_hdmi_conf mtk_hdmi_conf_m=
t2701 =3D {
>         .tz_disabled =3D true,
>  };
>
> +static const struct mtk_hdmi_conf mtk_hdmi_conf_mt8167 =3D {
> +       .max_mode_clock =3D 148500,
> +       .cea_modes_only =3D true,
> +};
> +
>  static const struct of_device_id mtk_drm_hdmi_of_ids[] =3D {
>         { .compatible =3D "mediatek,mt2701-hdmi",
>           .data =3D &mtk_hdmi_conf_mt2701,
>         },
> +       { .compatible =3D "mediatek,mt8167-hdmi",

"mediatek,mt8167-hdmi" does not exist in binding document, so add this
to binding document first.
In addition, could you also transfer mediatek,hdmi.txt to yaml format?

Regards,
Chun-Kuang.

> +         .data =3D &mtk_hdmi_conf_mt8167,
> +       },
>         { .compatible =3D "mediatek,mt8173-hdmi",
>         },
>         {}
> --
> 2.25.1
>
