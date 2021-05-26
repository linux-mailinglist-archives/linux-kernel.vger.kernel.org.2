Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23B4390D29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 02:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhEZADA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 20:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhEZACy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 20:02:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C34F061420;
        Wed, 26 May 2021 00:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621987283;
        bh=cMM7Bk50oz+P2FRsUKDbD7UktmnSmO7vUpLohfS5wTI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hDpQBCLj+QP9gqGVupCLadKq5svYg3I4rmWyMW7TxUaSHQ78Y7UWwGBra3RQvUl0r
         joGOn/Q2fHAhfFy/BS3KGwz959mnCOySCLMfhjeItWZmltokLa9n9qOsj9bfq6bAEh
         7NwR7C7Pfdx82TF4rd687hR2/rSlthcAheqSW9bI0tn3HP36G9kvuFxJMSgrMZSRWB
         c1Zz0+Ze9tyYBE6KkIL55QxgbmJUo0fT2GCzkseLOzhABZhaD3mqkzYyIxUm256w8a
         6lBFDegViAn5GEkazAN5c5H2NIUjO0+dhRZyaUmSWlKOT9CZjwOF7PdzljqzN5H4bO
         szodhiBh/7XXA==
Received: by mail-ed1-f49.google.com with SMTP id t15so38346174edr.11;
        Tue, 25 May 2021 17:01:23 -0700 (PDT)
X-Gm-Message-State: AOAM533LhP7kU7QnIIuJJzuU0JjDD8sFQsnmn3CtuyvhhuagFJwcU3mR
        wFRxlWLOl/JyqJyD97LPQ6impOAUf+80lg/TrA==
X-Google-Smtp-Source: ABdhPJy1oDnaYpLU8X/cl7NIOPaEIw45IshBooChnuh12l1QRQ8hL/Z2puieZJQRDPdggduT1yMK61LXcza2N49AtaQ=
X-Received: by 2002:a05:6402:34d5:: with SMTP id w21mr34605470edc.38.1621987282361;
 Tue, 25 May 2021 17:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210525121448.30075-1-rex-bc.chen@mediatek.com> <20210525121448.30075-2-rex-bc.chen@mediatek.com>
In-Reply-To: <20210525121448.30075-2-rex-bc.chen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 26 May 2021 08:01:11 +0800
X-Gmail-Original-Message-ID: <CAAOTY__aasihVxC72f7b_R-=UcR85Z1G9M8TxUS9dBrad-aRxQ@mail.gmail.com>
Message-ID: <CAAOTY__aasihVxC72f7b_R-=UcR85Z1G9M8TxUS9dBrad-aRxQ@mail.gmail.com>
Subject: Re: [v4,PATCH 1/3] drm/mediatek: dpi dual edge sample mode support
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
> DPI can sample on falling, rising or both edge.
> When DPI sample the data both rising and falling edge.
> It can reduce half data io pins.
> Use num_output_fmts to determine whether it is dual edge mode.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index bea91c81626e..d3b883c97aaf 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -83,6 +83,7 @@ struct mtk_dpi {
>         struct pinctrl *pinctrl;
>         struct pinctrl_state *pins_gpio;
>         struct pinctrl_state *pins_dpi;
> +       bool ddr_edge_sel;

I would like to keep output_fmt instead of ddr_edge_sel.
Initialize output_fmt to MEDIA_BUS_FMT_RGB888_1X24 in this patch.

>         int refcount;
>  };
>
> @@ -122,6 +123,8 @@ struct mtk_dpi_conf {
>         u32 reg_h_fre_con;
>         u32 max_clock_khz;
>         bool edge_sel_en;
> +       const u32 *output_fmts;
> +       u32 num_output_fmts;

Move these to next patch.

>  };
>
>  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 m=
ask)
> @@ -381,6 +384,16 @@ static void mtk_dpi_config_color_format(struct mtk_d=
pi *dpi,
>         }
>  }
>
> +static void mtk_dpi_dual_edge(struct mtk_dpi *dpi)
> +{
> +       if (dpi->conf->num_output_fmts > 1) {
> +               mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE,
> +                            DDR_EN | DDR_4PHASE);
> +               mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING,
> +                            dpi->ddr_edge_sel ? EDGE_SEL : 0, EDGE_SEL);
> +       }

if (dpi->output_fmt =3D=3D MEDIA_BUS_FMT_RGB888_2X12_LE) ||
   (dpi->output_fmt =3D=3D MEDIA_BUS_FMT_RGB888_2X12_BE) {
    mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE, DDR_EN |
DDR_4PHASE);
    mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING,
                             dpi->output_fmt =3D=3D
MEDIA_BUS_FMT_RGB888_2X12_LE ? EDGE_SEL : 0, EDGE_SEL);
} else {
    mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE, 0);
}

> +}
> +
>  static void mtk_dpi_power_off(struct mtk_dpi *dpi)
>  {
>         if (WARN_ON(dpi->refcount =3D=3D 0))
> @@ -455,7 +468,8 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *d=
pi,
>         pll_rate =3D clk_get_rate(dpi->tvd_clk);
>
>         vm.pixelclock =3D pll_rate / factor;
> -       clk_set_rate(dpi->pixel_clk, vm.pixelclock);
> +       clk_set_rate(dpi->pixel_clk,
> +                    vm.pixelclock * ((dpi->conf->num_output_fmts > 1) ? =
2 : 1));

if (dpi->output_fmt =3D=3D MEDIA_BUS_FMT_RGB888_2X12_LE) ||
   (dpi->output_fmt =3D=3D MEDIA_BUS_FMT_RGB888_2X12_BE)
    clk_set_rate(dpi->pixel_clk, vm.pixelclock * 2);
else
    clk_set_rate(dpi->pixel_clk, vm.pixelclock);

>         vm.pixelclock =3D clk_get_rate(dpi->pixel_clk);
>
>         dev_dbg(dpi->dev, "Got  PLL %lu Hz, pixel clock %lu Hz\n",
> @@ -519,6 +533,7 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *d=
pi,
>         mtk_dpi_config_yc_map(dpi, dpi->yc_map);
>         mtk_dpi_config_color_format(dpi, dpi->color_format);
>         mtk_dpi_config_2n_h_fre(dpi);
> +       mtk_dpi_dual_edge(dpi);
>         mtk_dpi_config_disable_edge(dpi);
>         mtk_dpi_sw_reset(dpi, false);
>
> --
> 2.18.0
>
