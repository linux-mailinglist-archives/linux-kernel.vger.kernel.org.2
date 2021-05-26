Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BDC390E70
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 04:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhEZCsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 22:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhEZCsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 22:48:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47AB361432;
        Wed, 26 May 2021 02:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621997241;
        bh=sKcmWhJmVsIPdkX6fdFoAIC9r4N6jPGMkT7L2NUL4Sw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pgk9dH1ZD5Vu8B97z4WJqYgpSwz2kzsBILrAGP4aNFWDu4IFYkHtsZIjUzunj6R0K
         6S1FoiFpLFYMO+fFxfj4JwAW34UlBxslC5d5p/uVCp3ZCH9qZN3add3eOyiar5S3mR
         AMo/SJqdpTgVGDArMwefDxbIF6+4uaIjvIw5dXCzyOBzn5zyJIgihs1xXYUhgDKKsl
         MT1Z022sEHnX3kaxMMK9ArW4LAXqgP+ggyjp4Savpd3OZMSKdrCPzwFbpTjLNUGWxf
         ON/tkUoCb2JyTILn0eT5jzEvFsZs3yaUPgX8qqYAEk0xbG0DW+IUfIuJ6ubTP2pWeI
         vHKcCPIwcl07Q==
Received: by mail-ed1-f45.google.com with SMTP id g7so26492320edm.4;
        Tue, 25 May 2021 19:47:21 -0700 (PDT)
X-Gm-Message-State: AOAM530grqEMh853ovuTGrFcps+Q3kq3FDsQYrTrcIDRLvIpQX3hO+l9
        Cs2IjT0iW+4fe+xim8gv9mkJEEDD1g1jMog0SA==
X-Google-Smtp-Source: ABdhPJwZ9qhKoR/4aN1yXlD5plSJwQb48VNfGpy4rh2cgs/Z+gzv3xIUzO+FkXgz28nH6QdNiD2ByhbTu7W1IKIoSuY=
X-Received: by 2002:aa7:ccc6:: with SMTP id y6mr35286163edt.303.1621997239928;
 Tue, 25 May 2021 19:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210525121448.30075-1-rex-bc.chen@mediatek.com> <20210525121448.30075-3-rex-bc.chen@mediatek.com>
In-Reply-To: <20210525121448.30075-3-rex-bc.chen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 26 May 2021 10:47:10 +0800
X-Gmail-Original-Message-ID: <CAAOTY__0EU5Sjo2ygj2tXHk3VTRuyEf+q4cGh3nGN1K1vMkFMw@mail.gmail.com>
Message-ID: <CAAOTY__0EU5Sjo2ygj2tXHk3VTRuyEf+q4cGh3nGN1K1vMkFMw@mail.gmail.com>
Subject: Re: [v4,PATCH 2/3] drm/mediatek: config driver data to support dual
 edge sample
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rex:

Rex-BC Chen <rex-bc.chen@mediatek.com> =E6=96=BC 2021=E5=B9=B45=E6=9C=8825=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:15=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Add output_fmts and num_output_fmts value for all configuration.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index d3b883c97aaf..d6a422986efc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -695,10 +695,21 @@ static unsigned int mt8183_calculate_factor(int clo=
ck)
>                 return 2;
>  }
>
> +static const u32 mt8173_output_fmts[] =3D {
> +MEDIA_BUS_FMT_RGB888_1X24,

indent.

> +};
> +
> +static const u32 mt8183_output_fmts[] =3D {
> +MEDIA_BUS_FMT_RGB888_2X12_LE,
> +MEDIA_BUS_FMT_RGB888_2X12_BE,

ditto.

Regards,
Chun-Kuang.

> +};
> +
>  static const struct mtk_dpi_conf mt8173_conf =3D {
>         .cal_factor =3D mt8173_calculate_factor,
>         .reg_h_fre_con =3D 0xe0,
>         .max_clock_khz =3D 300000,
> +       .output_fmts =3D mt8173_output_fmts,
> +       .num_output_fmts =3D ARRAY_SIZE(mt8173_output_fmts),
>  };
>
>  static const struct mtk_dpi_conf mt2701_conf =3D {
> @@ -706,18 +717,24 @@ static const struct mtk_dpi_conf mt2701_conf =3D {
>         .reg_h_fre_con =3D 0xb0,
>         .edge_sel_en =3D true,
>         .max_clock_khz =3D 150000,
> +       .output_fmts =3D mt8173_output_fmts,
> +       .num_output_fmts =3D ARRAY_SIZE(mt8173_output_fmts),
>  };
>
>  static const struct mtk_dpi_conf mt8183_conf =3D {
>         .cal_factor =3D mt8183_calculate_factor,
>         .reg_h_fre_con =3D 0xe0,
>         .max_clock_khz =3D 100000,
> +       .output_fmts =3D mt8183_output_fmts,
> +       .num_output_fmts =3D ARRAY_SIZE(mt8183_output_fmts),
>  };
>
>  static const struct mtk_dpi_conf mt8192_conf =3D {
>         .cal_factor =3D mt8183_calculate_factor,
>         .reg_h_fre_con =3D 0xe0,
>         .max_clock_khz =3D 150000,
> +       .output_fmts =3D mt8173_output_fmts,
> +       .num_output_fmts =3D ARRAY_SIZE(mt8173_output_fmts),
>  };
>
>  static int mtk_dpi_probe(struct platform_device *pdev)
> --
> 2.18.0
>
