Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F51A33FC41
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 01:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhCRAba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 20:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhCRAbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 20:31:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A420764F2B;
        Thu, 18 Mar 2021 00:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616027476;
        bh=kE5pzJREcMtcsKe3XXovC6KJw1unQTOB5zOB90M91cY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mgEdWsITi62mNieWrt3tt4Ns/P9SkqyfMc4vReldRwLoUMBhwCeLpKFrGitrVwO59
         i8j6PIp2pGqzOw5zBDDYh3FCyiHGnYDTzzv7DimOmXrbnxyjT58J57rttyeT+gXRsP
         hhSHuapQuAoYMuAcVFjcxOre4h3RyYrNXlp7nyqvWEmrJg+JzhxnEjufjYuF+IrqwD
         KV3tZDwKhJQqOrVs4NIvcq74tTGCKgKBWMklbZUvKI1x9hTDejZ6eeWdeN7HAW4ZYj
         ZCLrQaO51S3FceqzACjNEjRZ0JxLaAh4HaExjt9IK1Jj+R/12M0fAGa4t+Ok2UMDs3
         /gMmCT9ZWHEpQ==
Received: by mail-ej1-f52.google.com with SMTP id t18so1187225ejc.13;
        Wed, 17 Mar 2021 17:31:15 -0700 (PDT)
X-Gm-Message-State: AOAM532LU8OEgzaEMdgKvkxT3oFvJ56AwjTl+uQUfXBCtStjssuSiJyX
        t75g1pv+8oU/MsRF3pGAZMIu1wnh5LtJeVnhTg==
X-Google-Smtp-Source: ABdhPJyRt0/BHVBbK/+kJchk+xOcRQnGlNm6MFZSoVqqh6s/25AE46ySni1iQzV9dfexmdF4fKF39m+xGj/DSl/FVys=
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr38674530ejc.267.1616027473977;
 Wed, 17 Mar 2021 17:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210201034755.15793-1-jitao.shi@mediatek.com>
In-Reply-To: <20210201034755.15793-1-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 18 Mar 2021 08:31:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY_--LQxwvnmWws23OkShBiQdxumoULoLTuHeXXMqZ6aW7g@mail.gmail.com>
Message-ID: <CAAOTY_--LQxwvnmWws23OkShBiQdxumoULoLTuHeXXMqZ6aW7g@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: fine tune the data lane trail by project dts
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        huijuan.xie@mediatek.com, stonea168@163.com,
        Cawa Cheng <cawa.cheng@mediatek.com>, shuijing.li@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2021=E5=B9=B42=E6=9C=881=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:48=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Some panels or bridges require customized hs_da_trail time.
> So add a property in devicetree for this panels and bridges.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 8c70ec39bfe1..6e7092fa2fee 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -194,6 +194,7 @@ struct mtk_dsi {
>         struct clk *hs_clk;
>
>         u32 data_rate;
> +       u32 da_trail_delta;
>
>         unsigned long mode_flags;
>         enum mipi_dsi_pixel_format format;
> @@ -234,7 +235,7 @@ static void mtk_dsi_phy_timconfig(struct mtk_dsi *dsi=
)
>         timing->da_hs_prepare =3D (80 * data_rate_mhz + 4 * 1000) / 8000;
>         timing->da_hs_zero =3D (170 * data_rate_mhz + 10 * 1000) / 8000 +=
 1 -
>                              timing->da_hs_prepare;
> -       timing->da_hs_trail =3D timing->da_hs_prepare + 1;
> +       timing->da_hs_trail =3D timing->da_hs_prepare + 1 + dsi->da_trail=
_delta;
>
>         timing->ta_go =3D 4 * timing->lpx - 2;
>         timing->ta_sure =3D timing->lpx + 2;
> @@ -1094,6 +1095,13 @@ static int mtk_dsi_probe(struct platform_device *p=
dev)
>                 goto err_unregister_host;
>         }
>
> +       ret =3D of_property_read_u32_index(dev->of_node, "da_trail_delta"=
, 0,
> +                                        &dsi->da_trail_delta);

This value depends on panel, so I think we should get some value from
panel's device node to calculate this value.

Regards,
Chun-Kuang.

> +       if (ret) {
> +               dev_info(dev, "Can't get da_trail_delta, keep it as 0: %d=
\n", ret);
> +               dsi->da_trail_delta =3D 0;
> +       }
> +
>         comp_id =3D mtk_ddp_comp_get_id(dev->of_node, MTK_DSI);
>         if (comp_id < 0) {
>                 dev_err(dev, "Failed to identify by alias: %d\n", comp_id=
);
> --
> 2.12.5
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
