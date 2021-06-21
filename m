Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA013AE4CA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhFUIcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhFUIb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:31:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5868261183
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624264185;
        bh=3k7UKLAzplWylccCBWjz7kXMM/herlyLZaHwytCXBXE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fENbtecuXfxTiz7RPH+9f4S8YpxmcBZol1rcmNfPb26+/uh/SRxCJJcnzISj0bvlN
         8H7IASU54wrLZG84P7cvMi8lGU3pTEkDX4gEyepqJqB0QlzOqzhE2lSzYhCgvwhJST
         z8KWdWiWTzgQPfxtInMgvnMxfSB7EQhLtLxFvEP/CJ9hc20IVQ7CW/hHsMfye89SWg
         aAdZMtkoKR+H9F86ZBXuCthjiPxSgubLC7NDsbdxxZhwGxfXt5DXwlQRqY6jdjWIr2
         YQ5jlF0lPdK7/6uwz+3mZ59mv6Qfh9trZFrkcMVMBZWird4L2EtHRPVy7jtYf5XsCu
         D8dGxhBzEtSHw==
Received: by mail-ed1-f47.google.com with SMTP id r7so17701071edv.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:29:45 -0700 (PDT)
X-Gm-Message-State: AOAM533x+LcQ2NZ/4gu1unU1X2YB9f1eZa+8oM8MjAArLvpBVKUKF+lR
        gWdd1m7MlNs8u+/UMT8ovCYg5Gyy8+8kLaoQ9g==
X-Google-Smtp-Source: ABdhPJy99W+iUMmSVT+D20GJWXJQDvrweRWoVmNQ4hxYbGjBoj+VtBCmyu5vVrJXOxAqXXXmJvQFU6lq5QdPkA+ASs8=
X-Received: by 2002:aa7:ce0c:: with SMTP id d12mr6504464edv.49.1624264183889;
 Mon, 21 Jun 2021 01:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210617103214.44217-1-jitao.shi@mediatek.com>
In-Reply-To: <20210617103214.44217-1-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 21 Jun 2021 16:29:30 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9LkeWjz0zs19hvb_3AMxhytqmAk6H1jGS1VxDkQqFr5Q@mail.gmail.com>
Message-ID: <CAAOTY_9LkeWjz0zs19hvb_3AMxhytqmAk6H1jGS1VxDkQqFr5Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: force hsa hbp hfp packets multiple of
 lanenum to avoid screen shift
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        CK Hu <ck.hu@mediatek.com>, stonea168@163.com,
        huijuan.xie@mediatek.com, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        shuijing.li@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2021=E5=B9=B46=E6=9C=8817=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The bridge chip "ANX7625" requires the packets on lanes to aligne at the =
end,
> or ANX7625 will shift the screen.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index ae403c67cbd9..4735e0092ffe 100644
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
> @@ -499,6 +501,13 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi=
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
> @@ -1095,6 +1104,10 @@ static int mtk_dsi_probe(struct platform_device *p=
dev)
>         dsi->bridge.of_node =3D dev->of_node;
>         dsi->bridge.type =3D DRM_MODE_CONNECTOR_DSI;
>
> +       if (dsi->next_bridge)
> +               dsi->force_dsi_end_without_null =3D of_property_read_bool=
(dsi->next_bridge->of_node,
> +                                                                       "=
force_dsi_end_without_null");

This patch looks good to me, but I could not find
"force_dsi_end_without_null" in binding document.

Regards,
Chun-Kuang.

> +
>         drm_bridge_add(&dsi->bridge);
>
>         ret =3D component_add(&pdev->dev, &mtk_dsi_component_ops);
> --
> 2.25.1
