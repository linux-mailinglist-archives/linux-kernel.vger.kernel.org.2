Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FE737AC89
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhEKRA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231230AbhEKRA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:00:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A7C1617C9;
        Tue, 11 May 2021 16:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620752390;
        bh=fIaiKncbOhF42NMcvb4keKbwIafRTHDcsfrQf6pI4Zc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iSOZZjkLk1XC2l7Ax+Cejz3YlYEvxypiYQEMM1+doGiT2tjeA46AqiAH1no71ZxgU
         aXMplkqs+teBTIiQ7yV4cSjsEPNT7mJuMFqsvX2jG1n6qDgLAR0rDicrYsKJVFZ7ow
         eunzD+6ugHMcpFbv7t22K3drcWLFU05L6+C7L0qS/PBtHlfmbtHsBtmJ910yJmse60
         n45dphqcT2+6qZ8D9VKeKoPOySfD5uZK6qjZ7NqvHs0s33ebXyBQO6hud9rZKCGHUz
         C0pmR7VGDAoLWT4zyo5RfVVn5rRJAlS0HlyLulgaVqJULDOBhCBI/fNBwxUvr+1QwZ
         XICr7CfLBDaJg==
Received: by mail-ej1-f45.google.com with SMTP id b25so30763926eju.5;
        Tue, 11 May 2021 09:59:50 -0700 (PDT)
X-Gm-Message-State: AOAM533+E9NQ+8c3t4NhfWOArIybY8Fcbnaysl23ciaPLUcfwpsKFg3s
        IfiTg+Pc6y4OfBs7bjn/dSBsdPqSuN6NAgpQsQ==
X-Google-Smtp-Source: ABdhPJxp5uMHxFRYAjGBeRPy0112+HQl4dnKPgPi5HnV7AMeIGK9ib7Kgyb4Krz215eGf9u0Uv0O15l+sUz8XH7qDeI=
X-Received: by 2002:a17:906:b0cb:: with SMTP id bk11mr33264259ejb.310.1620752388961;
 Tue, 11 May 2021 09:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210429041641.11077-1-rex-bc.chen@mediatek.com> <20210429041641.11077-4-rex-bc.chen@mediatek.com>
In-Reply-To: <20210429041641.11077-4-rex-bc.chen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 12 May 2021 00:59:37 +0800
X-Gmail-Original-Message-ID: <CAAOTY_94qU7Qm8yLjKOypTAP8m2yT27n2xainc70=buMCjMTcg@mail.gmail.com>
Message-ID: <CAAOTY_94qU7Qm8yLjKOypTAP8m2yT27n2xainc70=buMCjMTcg@mail.gmail.com>
Subject: Re: [v3 RESEND,PATCH 3/3] drm/mediatek: dpi: add bus format negotiation
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

Rex-BC Chen <rex-bc.chen@mediatek.com> =E6=96=BC 2021=E5=B9=B44=E6=9C=8829=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8812:16=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add the atomic_get_output_bus_fmts, atomic_get_input_bus_fmts to negotiat=
e
> the possible output and input formats for the current mode and monitor,
> and use the negotiated formats in a basic atomic_check callback.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 92 ++++++++++++++++++++++++++++--
>  1 file changed, 87 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index c548780dd3a5..8822d9448ae8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -536,6 +536,87 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *=
dpi,
>         return 0;
>  }
>
> +#define MAX_OUTPUT_SEL_FORMATS 2
> +
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
> +       u32 *output_fmts;
> +       struct mtk_dpi *dpi =3D bridge_to_dpi(bridge);
> +
> +       *num_output_fmts =3D 0;
> +
> +       output_fmts =3D kcalloc(MAX_OUTPUT_SEL_FORMATS, sizeof(*output_fm=
ts),
> +                             GFP_KERNEL);
> +       if (!output_fmts)
> +               return NULL;
> +
> +       /* Default 8bit RGB fallback */
> +       if (dpi->conf->dual_edge) {
> +               output_fmts[0] =3D  MEDIA_BUS_FMT_RGB888_2X12_LE;
> +               output_fmts[1] =3D  MEDIA_BUS_FMT_RGB888_2X12_BE;
> +               *num_output_fmts =3D 2;
> +       } else {
> +               output_fmts[0] =3D  MEDIA_BUS_FMT_RGB888_1X24;
> +               *num_output_fmts =3D 1;
> +       }
> +
> +       return output_fmts;
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
> +                               true : false;

I would like to keep the out_bus_format rather than keep ddr_edge_sel,
and in mtk_dpi_dual_edge() use dpi->out_bus_format to decide edge
selection.

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
>
> @@ -574,6 +655,12 @@ static const struct drm_bridge_funcs mtk_dpi_bridge_=
funcs =3D {
>         .mode_set =3D mtk_dpi_bridge_mode_set,
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
> @@ -620,11 +707,6 @@ static int mtk_dpi_bind(struct device *dev, struct d=
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
