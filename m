Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F5B357142
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347376AbhDGQAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245406AbhDGP75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:59:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D87261394;
        Wed,  7 Apr 2021 15:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617811187;
        bh=hGXNzVJiH86Iaj7zXKQ35uQKcMAGo1DSHvGN1U3LigI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Eo9KXeSeF+qiiMEGBRTSan29w2Je5fOzX3pOmVElTHi7slb0WJjRYTAXzrWkEi5x6
         yTVFc4CvBTJLc4Oujco6Z+AL2tSisD/h6vlGZU9lXUEL07/Wl6JQn2Ltl6/VIKK/Ye
         kE5p1sWa2AOpUz8CiyzLM9P0jaCQHocVmc316We4uxopIxF4FX5SavnDy87kwOQXVe
         y3qrrM/cTCmaPCZPDElsMGRKu91TH7Zad4Nw1Vnl7HZrMlZFT4pmA7H2B08jwBkbay
         JCixRc/O6Upa3OxBNVKdH4K2DBI/HDrK1y4hXX13GRC95O/hZGGO3y2jZyrxQI4e2T
         TNJ52eMFZd0YQ==
Received: by mail-ej1-f51.google.com with SMTP id e14so28483738ejz.11;
        Wed, 07 Apr 2021 08:59:47 -0700 (PDT)
X-Gm-Message-State: AOAM530xpUItdPpmZOeQ8s41sjVb+gXxYSC0yUytwpMgGTy+bJ2yM6xY
        vSkrlzP30AKFV0FAWogJTDzAQo8UCmI70FPM1w==
X-Google-Smtp-Source: ABdhPJwpyfbWTwn3/jlmyA5Hhu8Vwe6NWCunioufvDhHzHzmvZ82ObW9OPDby6jvwPsk5u2uvIzq/RFbEZhCbrFa1jc=
X-Received: by 2002:a17:906:4a52:: with SMTP id a18mr4522021ejv.194.1617811185726;
 Wed, 07 Apr 2021 08:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210407143656.2574-1-jitao.shi@mediatek.com>
In-Reply-To: <20210407143656.2574-1-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 7 Apr 2021 23:59:34 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9sxEZ-M8dp1w4ac+DR-9ESOxVGfDfhd4d8MkCMsCj7kg@mail.gmail.com>
Message-ID: <CAAOTY_9sxEZ-M8dp1w4ac+DR-9ESOxVGfDfhd4d8MkCMsCj7kg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: force hsa hsa hfp packets multiple of line
 num to avoid screen shift
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
        Cawa Cheng <cawa.cheng@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
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

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2021=E5=B9=B44=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:37=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The bridge chip ANX7625 require the line packets ending at the sametime
> or ANX7625 will shift the screen.
>
> Change-Id: Ia324ad28fbff54140feedb9a1d6bfb2b246d0447
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index a1ff152ef468..e825a80862de 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -194,6 +194,8 @@ struct mtk_dsi {
>         struct clk *hs_clk;
>
>         u32 data_rate;
> +       /* force dsi line end without dsi_null data */
> +       bool force_dsi_end_without_null;
>
>         unsigned long mode_flags;
>         enum mipi_dsi_pixel_format format;
> @@ -495,6 +497,13 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi=
 *dsi)
>                 DRM_WARN("HFP + HBP less than d-phy, FPS will under 60Hz\=
n");
>         }
>
> +       if (dsi->force_dsi_end_without_null) {
> +               horizontal_sync_active_byte =3D roundup(horizontal_sync_a=
ctive_byte, dsi->lanes) - 2;
> +               horizontal_frontporch_byte =3D roundup(horizontal_frontpo=
rch_byte, dsi->lanes) - 2;
> +               horizontal_backporch_byte =3D roundup(horizontal_backporc=
h_byte, dsi->lanes) - 2;
> +               horizontal_backporch_byte -=3D (vm->hactive * dsi_tmp_buf=
_bpp + 2) % dsi->lanes;
> +       }
> +
>         writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
>         writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
>         writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
> @@ -1091,6 +1100,9 @@ static int mtk_dsi_probe(struct platform_device *pd=
ev)
>         dsi->bridge.of_node =3D dev->of_node;
>         dsi->bridge.type =3D DRM_MODE_CONNECTOR_DSI;
>
> +       dsi->force_dsi_end_without_null =3D of_property_read_bool(dev->of=
_node,
> +                                                               "force_ds=
i_end_without_null");

If force_dsi_end_without_null is caused by ANX7625, I think we should
get this information from ANX7625.

Regards,
Chun-Kuang.

> +
>         drm_bridge_add(&dsi->bridge);
>
>         ret =3D component_add(&pdev->dev, &mtk_dsi_component_ops);
> --
> 2.25.1
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
