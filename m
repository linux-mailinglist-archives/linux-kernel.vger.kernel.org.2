Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A786390E95
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 04:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhEZDAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 23:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231348AbhEZDAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 23:00:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4400161432;
        Wed, 26 May 2021 02:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621997961;
        bh=1Vi1ujoloi31h2fuTBqvWFO8m+MME1+FdhmIe/4hQ+Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rKedvANRVrz37/9gpYWlfiBK7yVOGeM0429Ejkiwleu2mHk+u6mehxhp+HP47ai6o
         Jcb08As80Q5nwvnuzXIW0dqV1U/A48EoRCzmZzWvUA66GZ4Hfbhp1VYJE49TqTuFUL
         +vZzZCP55y1p8IFnuKQNENTXelhvL7bD3bl39smTpD78nMypnQokwFVq0il+GXUNDz
         TjRO0xBrHlQjXDzw7nxx2k0yBravJNuAirYM/tw5mpTu/8UuokV+7QsKNo3CXmZgZd
         BCIpYBBASb/a/tQsnx32eIafMDgNYp2ecC9g59eAAv+qMMVHab7O/NVXa8M/ED0RsY
         jhJcKM2Fl1fcA==
Received: by mail-ej1-f51.google.com with SMTP id s22so38842ejv.12;
        Tue, 25 May 2021 19:59:21 -0700 (PDT)
X-Gm-Message-State: AOAM532RD42wAAEqh1FL6aycEujaczBtkvUuJtnfPP/R0826KNhIg7jI
        2Fzu3Tg3IZsFTDB6APoZpaO3jg7mtpqRTaaMPw==
X-Google-Smtp-Source: ABdhPJxTpRaVAcS1iQ8JUak5Isj5SZ8WTpbasCnC3NVQg5nTUIZ8my96cmr6BjhE3jH3wnSKPus1KvnkztIiaHs+46Q=
X-Received: by 2002:a17:907:1ca1:: with SMTP id nb33mr31304670ejc.75.1621997959809;
 Tue, 25 May 2021 19:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210525121448.30075-1-rex-bc.chen@mediatek.com> <20210525121448.30075-4-rex-bc.chen@mediatek.com>
In-Reply-To: <20210525121448.30075-4-rex-bc.chen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 26 May 2021 10:59:09 +0800
X-Gmail-Original-Message-ID: <CAAOTY__9Emac0Lc=afZMcJzCuO-myJDS--rshMkkrVZr9imSog@mail.gmail.com>
Message-ID: <CAAOTY__9Emac0Lc=afZMcJzCuO-myJDS--rshMkkrVZr9imSog@mail.gmail.com>
Subject: Re: [v4,PATCH 3/3] drm/mediatek: dpi: add bus format negotiation
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
> Add the atomic_get_output_bus_fmts, atomic_get_input_bus_fmts to negotiat=
e
> the possible output and input formats for the current mode and monitor,
> and use the negotiated formats in a basic atomic_check callback.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 78 ++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index d6a422986efc..667a97470389 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -540,6 +540,73 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *=
dpi,
>         return 0;
>  }
>
> +static u32 *mtk_dpi_bridge_atomic_get_output_bus_fmts(struct drm_bridge =
*bridge,
> +                                       struct drm_bridge_state *bridge_s=
tate,
> +                                       struct drm_crtc_state *crtc_state=
,
> +                                       struct drm_connector_state *conn_=
state,
> +                                       unsigned int *num_output_fmts)
> +{
> +       struct mtk_dpi *dpi =3D bridge_to_dpi(bridge);
> +
> +       *num_output_fmts =3D 0;
> +
> +       if (!dpi->conf->output_fmts)

print error here because this should not happen.

> +               return NULL;
> +
> +       *num_output_fmts =3D dpi->conf->num_output_fmts;
> +
> +       return (u32 *)dpi->conf->output_fmts;

I think you should allocate new buffer for output_fmts because the
caller would free it.

> +}
> +
> +#define MAX_INPUT_SEL_FORMATS  1
> +
> +static u32 *mtk_dpi_bridge_atomic_get_input_bus_fmts(struct drm_bridge *=
bridge,
> +                                       struct drm_bridge_state *bridge_s=
tate,
> +                                       struct drm_crtc_state *crtc_state=
,
> +                                       struct drm_connector_state *conn_=
state,
> +                                       u32 output_fmt,
> +                                       unsigned int *num_input_fmts)
> +{
> +       u32 *input_fmts;
> +
> +       *num_input_fmts =3D 0;
> +
> +       input_fmts =3D kcalloc(MAX_INPUT_SEL_FORMATS, sizeof(*input_fmts)=
,
> +                            GFP_KERNEL);
> +       if (!input_fmts)
> +               return NULL;
> +
> +       *num_input_fmts =3D 1;
> +       input_fmts[0] =3D MEDIA_BUS_FMT_RGB888_1X24;

it seems that MAX_INPUT_SEL_FORMATS has no influence here. Maybe just
remove MAX_INPUT_SEL_FORMATS, or you should have flexibility here for
different MAX_INPUT_SEL_FORMATS value.

> +
> +       return input_fmts;
> +}
> +
> +static int mtk_dpi_bridge_atomic_check(struct drm_bridge *bridge,
> +                                      struct drm_bridge_state *bridge_st=
ate,
> +                                      struct drm_crtc_state *crtc_state,
> +                                      struct drm_connector_state *conn_s=
tate)
> +{
> +       struct mtk_dpi *dpi =3D bridge->driver_private;
> +       unsigned int out_bus_format;
> +
> +       out_bus_format =3D bridge_state->output_bus_cfg.format;
> +
> +       dev_dbg(dpi->dev, "input format 0x%04x, output format 0x%04x\n",
> +               bridge_state->input_bus_cfg.format,
> +               bridge_state->output_bus_cfg.format);
> +
> +       dpi->ddr_edge_sel =3D (out_bus_format =3D=3D MEDIA_BUS_FMT_RGB888=
_2X12_LE) ?
> +                          true : false;

dpi->output_fmt =3D out_bus_format;

Regards,
Chun-Kuang.

> +
> +       dpi->bit_num =3D MTK_DPI_OUT_BIT_NUM_8BITS;
> +       dpi->channel_swap =3D MTK_DPI_OUT_CHANNEL_SWAP_RGB;
> +       dpi->yc_map =3D MTK_DPI_OUT_YC_MAP_RGB;
> +       dpi->color_format =3D MTK_DPI_COLOR_FORMAT_RGB;
> +
> +       return 0;
> +}
> +
>  static int mtk_dpi_bridge_attach(struct drm_bridge *bridge,
>                                  enum drm_bridge_attach_flags flags)
>  {
> @@ -592,6 +659,12 @@ static const struct drm_bridge_funcs mtk_dpi_bridge_=
funcs =3D {
>         .mode_valid =3D mtk_dpi_bridge_mode_valid,
>         .disable =3D mtk_dpi_bridge_disable,
>         .enable =3D mtk_dpi_bridge_enable,
> +       .atomic_check =3D mtk_dpi_bridge_atomic_check,
> +       .atomic_get_output_bus_fmts =3D mtk_dpi_bridge_atomic_get_output_=
bus_fmts,
> +       .atomic_get_input_bus_fmts =3D mtk_dpi_bridge_atomic_get_input_bu=
s_fmts,
> +       .atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_st=
ate,
> +       .atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +       .atomic_reset =3D drm_atomic_helper_bridge_reset,
>  };
>
>  void mtk_dpi_start(struct device *dev)
> @@ -638,11 +711,6 @@ static int mtk_dpi_bind(struct device *dev, struct d=
evice *master, void *data)
>         }
>         drm_connector_attach_encoder(dpi->connector, &dpi->encoder);
>
> -       dpi->bit_num =3D MTK_DPI_OUT_BIT_NUM_8BITS;
> -       dpi->channel_swap =3D MTK_DPI_OUT_CHANNEL_SWAP_RGB;
> -       dpi->yc_map =3D MTK_DPI_OUT_YC_MAP_RGB;
> -       dpi->color_format =3D MTK_DPI_COLOR_FORMAT_RGB;
> -
>         return 0;
>
>  err_cleanup:
> --
> 2.18.0
>
