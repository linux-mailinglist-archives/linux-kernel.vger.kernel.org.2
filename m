Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD5B369D92
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 01:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbhDWXvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 19:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhDWXu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 19:50:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8456C611BF;
        Fri, 23 Apr 2021 23:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619221819;
        bh=ztQ6BB47y5pg5s5XIXQqZ3xaTwRQkbGaRUPw9y7VJVo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r+YzHc/0eGDg4hwwB3cYiV49KICfpmWTjscSSChhp1hV5Vp/6IQ8zeD5bUKlSThji
         z5+OItSlKRar+wz1Rs2X95GRyma8bLcyOPGJDKaEkNtjz3JbBjdR8J8mSCI63chQej
         cgZga8jXru0D2gmdMXea1ZkdDVB9krzXfz6jKW9buMpXW20FipCReVj+/BpBwsOO2U
         U4Otj5Zvx3M8SKv1qrkGIvlDiREReUY6vfx7UnoepHb3MmDb3wmsXXCNXmPyLn4oYs
         XZQ6jNJ3iabzEB1tZIsxr54OUD5rFQdV6f8xdIeFEXgzmC4amvF0RMhsYLM36qEucG
         Y8UUklQNk/n+g==
Received: by mail-ed1-f48.google.com with SMTP id e7so59097074edu.10;
        Fri, 23 Apr 2021 16:50:19 -0700 (PDT)
X-Gm-Message-State: AOAM531oR4DR4q4I96FsJAV80EwvxKnaI/siAP0TtiIFdHwFj3kdM7et
        rB00sinDT2eD/14h2NZfu4f5idfhsqQzjqWIwQ==
X-Google-Smtp-Source: ABdhPJzlVD28y0pYvsLPGGp62BNLpS8yONHuPO054avTUO5tWEZi+o/N9PFsuZ2V+7mlxrPRRUsealY34YDjmiFn7cA=
X-Received: by 2002:a05:6402:1157:: with SMTP id g23mr7364478edw.303.1619221818075;
 Fri, 23 Apr 2021 16:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210420132614.150242-1-jitao.shi@mediatek.com> <20210420132614.150242-4-jitao.shi@mediatek.com>
In-Reply-To: <20210420132614.150242-4-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 24 Apr 2021 07:50:07 +0800
X-Gmail-Original-Message-ID: <CAAOTY__JZsAmGtX-+hNu0123xKoEdP2CgGxmQK2bqa-i+3dr6Q@mail.gmail.com>
Message-ID: <CAAOTY__JZsAmGtX-+hNu0123xKoEdP2CgGxmQK2bqa-i+3dr6Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/mediatek: add dsi module reset driver
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

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2021=E5=B9=B44=E6=9C=8820=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:26=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Reset dsi HW to default when power on. Prevent the setting differet
> between bootloader and kernel.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 36 +++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 455fe582c6b5..113438ddd4cc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -7,10 +7,12 @@
>  #include <linux/component.h>
>  #include <linux/iopoll.h>
>  #include <linux/irq.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>
>  #include <video/mipi_display.h>
>  #include <video/videomode.h>
> @@ -143,6 +145,8 @@
>  #define DATA_0                         (0xff << 16)
>  #define DATA_1                         (0xff << 24)
>
> +#define MMSYS_SW_RST_DSI_B BIT(25)
> +
>  #define NS_TO_CYCLE(n, c)    ((n) / (c) + (((n) % (c)) ? 1 : 0))
>
>  #define MTK_DSI_HOST_IS_READ(type) \
> @@ -186,7 +190,8 @@ struct mtk_dsi {
>         struct drm_bridge *next_bridge;
>         struct drm_connector *connector;
>         struct phy *phy;
> -
> +       struct regmap *mmsys_sw_rst_b;
> +       u32 sw_rst_b;
>         void __iomem *regs;
>
>         struct clk *engine_clk;
> @@ -272,6 +277,16 @@ static void mtk_dsi_disable(struct mtk_dsi *dsi)
>         mtk_dsi_mask(dsi, DSI_CON_CTRL, DSI_EN, 0);
>  }
>
> +static void mtk_dsi_reset_all(struct mtk_dsi *dsi)
> +{
> +       regmap_update_bits(dsi->mmsys_sw_rst_b, dsi->sw_rst_b,
> +                          MMSYS_SW_RST_DSI_B, 0);
> +       usleep_range(1000, 1100);
> +
> +       regmap_update_bits(dsi->mmsys_sw_rst_b, dsi->sw_rst_b,
> +                          MMSYS_SW_RST_DSI_B, MMSYS_SW_RST_DSI_B);
> +}
> +
>  static void mtk_dsi_reset_engine(struct mtk_dsi *dsi)
>  {
>         mtk_dsi_mask(dsi, DSI_CON_CTRL, DSI_RESET, DSI_RESET);
> @@ -985,6 +1000,8 @@ static int mtk_dsi_bind(struct device *dev, struct d=
evice *master, void *data)
>
>         ret =3D mtk_dsi_encoder_init(drm, dsi);
>
> +       mtk_dsi_reset_all(dsi);
> +
>         return ret;
>  }
>
> @@ -1007,6 +1024,7 @@ static int mtk_dsi_probe(struct platform_device *pd=
ev)
>         struct device *dev =3D &pdev->dev;
>         struct drm_panel *panel;
>         struct resource *regs;
> +       struct regmap *regmap;
>         int irq_num;
>         int ret;
>
> @@ -1022,6 +1040,22 @@ static int mtk_dsi_probe(struct platform_device *p=
dev)
>                 return ret;
>         }
>
> +       regmap =3D syscon_regmap_lookup_by_phandle(dev->of_node,
> +                                                "mediatek,syscon-dsi");
> +       ret =3D of_property_read_u32_index(dev->of_node, "mediatek,syscon=
-dsi", 1,
> +                                        &dsi->sw_rst_b);
> +
> +       if (IS_ERR(regmap))
> +               ret =3D PTR_ERR(regmap);
> +
> +       if (ret) {
> +               ret =3D PTR_ERR(regmap);
> +               dev_err(dev, "Failed to get mmsys registers: %d\n", ret);
> +               return ret;
> +       }
> +
> +       dsi->mmsys_sw_rst_b =3D regmap;
> +

It looks like that mtk-mmsys is the reset controller and mtk-dsi is
reset consumer. Please refer to [1], [2] to implement.

[1] https://www.kernel.org/doc/html/latest/driver-api/reset.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/reset/reset.txt?h=3Dv5.12-rc8

Regards,
Chun-Kuang.

>         ret =3D drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
>                                           &panel, &dsi->next_bridge);
>         if (ret)
> --
> 2.25.1
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
