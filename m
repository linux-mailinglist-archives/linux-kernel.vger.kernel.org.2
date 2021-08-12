Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5503E9B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 02:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhHLAUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 20:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhHLAUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 20:20:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA8356104F;
        Thu, 12 Aug 2021 00:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628727606;
        bh=8WwHn/zMxj39QrM8VdRSIm8zdth6Umf39XRXeWVmE6k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BPdorrsEj599FTpV2LS39F6Tkr7571nFfRknfLNvvlprN33+Mdmtk2FkntqYaOqT9
         xLaKybLKzih4HlHo05atceeZjxSNlu8GRKunLtv0Vy7MSBt3ZZehXaCqTAYDXKzUBQ
         Q3TtQ9dv+zW/TQv76lpXgVnEKnszkaB5MW1qUP1EmhTQjA0M2Cibm2POPpniTuIlnB
         PRPoRAiIrFUblWwJrrZpoPjv9At7Cnqo7JNagMZn5ikS/M/QqSLAUogbQ3YFVF+xbx
         /3SYgtHKDKew0Ctay6GJfjgMOtbqVniX9ov11YaLOCPp4Kc925XF3m/ssLUqBR/MaL
         JudwvfnNexlYA==
Received: by mail-ed1-f44.google.com with SMTP id r19so3279055eds.13;
        Wed, 11 Aug 2021 17:20:06 -0700 (PDT)
X-Gm-Message-State: AOAM530QG0gWRd+PZ+lTAVZsVWsZFN8HcMU7c0UoX9e1kKGQ0KB5AMw/
        Fby6I2cLp32zeBWmZerPwJWnb/jiQ/APlCVEqA==
X-Google-Smtp-Source: ABdhPJxKHb7wCRP3M/rwctlj0eB86IcbWXjn8UwsLLYmcTXsasU1mLRWPrWTRtopKhZ4g6A4oAdieVECbfuvx3wokHw=
X-Received: by 2002:aa7:c857:: with SMTP id g23mr2005613edt.219.1628727605357;
 Wed, 11 Aug 2021 17:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <1628646468-29775-1-git-send-email-yongqiang.niu@mediatek.com> <1628646468-29775-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1628646468-29775-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 12 Aug 2021 08:19:54 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-qigNtPJETHsE8YaVqxctrZ7Y+a31f5eqOVHXPowuucw@mail.gmail.com>
Message-ID: <CAAOTY_-qigNtPJETHsE8YaVqxctrZ7Y+a31f5eqOVHXPowuucw@mail.gmail.com>
Subject: Re: [PATCH v4] drm/mediatek: clear pending flag when cmdq packet is done.
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B48=E6=9C=
=8811=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=889:48=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> In cmdq mode, packet may be flushed before it is executed, so
> the pending flag should be cleared after cmdq packet is done.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 47 +++++++++++++++++++++++++++=
++----
>  1 file changed, 42 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index 4c25e33..89f093d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -267,6 +267,36 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void=
 *mssg)
>  {
>         struct mtk_drm_crtc *mtk_crtc =3D container_of(cl, struct mtk_drm=
_crtc, cmdq_cl);
>         struct cmdq_cb_data *data =3D mssg;
> +       struct mtk_crtc_state *state;
> +       unsigned int i;
> +
> +       state =3D to_mtk_crtc_state(mtk_crtc->base.state);
> +
> +       state->pending_config =3D false;
> +
> +       if (mtk_crtc->pending_planes) {
> +               for (i =3D 0; i < mtk_crtc->layer_nr; i++) {
> +                       struct drm_plane *plane =3D &mtk_crtc->planes[i];
> +                       struct mtk_plane_state *plane_state;
> +
> +                       plane_state =3D to_mtk_plane_state(plane->state);
> +
> +                       plane_state->pending.config =3D false;
> +               }
> +               mtk_crtc->pending_planes =3D false;
> +       }
> +
> +       if (mtk_crtc->pending_async_planes) {
> +               for (i =3D 0; i < mtk_crtc->layer_nr; i++) {
> +                       struct drm_plane *plane =3D &mtk_crtc->planes[i];
> +                       struct mtk_plane_state *plane_state;
> +
> +                       plane_state =3D to_mtk_plane_state(plane->state);
> +
> +                       plane_state->pending.async_config =3D false;
> +               }
> +               mtk_crtc->pending_async_planes =3D false;
> +       }
>
>         mtk_crtc->cmdq_vblank_cnt =3D 0;
>         mtk_drm_cmdq_pkt_destroy(mtk_crtc->cmdq_chan, data->pkt);
> @@ -423,7 +453,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc=
,
>                                     state->pending_vrefresh, 0,
>                                     cmdq_handle);
>
> -               state->pending_config =3D false;
> +               if (!cmdq_handle)
> +                       state->pending_config =3D false;
>         }
>
>         if (mtk_crtc->pending_planes) {
> @@ -443,9 +474,12 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crt=
c,
>                                 mtk_ddp_comp_layer_config(comp, local_lay=
er,
>                                                           plane_state,
>                                                           cmdq_handle);
> -                       plane_state->pending.config =3D false;
> +                       if (!cmdq_handle)
> +                               plane_state->pending.config =3D false;
>                 }
> -               mtk_crtc->pending_planes =3D false;
> +
> +               if (!cmdq_handle)
> +                       mtk_crtc->pending_planes =3D false;
>         }
>
>         if (mtk_crtc->pending_async_planes) {
> @@ -465,9 +499,12 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crt=
c,
>                                 mtk_ddp_comp_layer_config(comp, local_lay=
er,
>                                                           plane_state,
>                                                           cmdq_handle);
> -                       plane_state->pending.async_config =3D false;
> +                       if (!cmdq_handle)
> +                               plane_state->pending.async_config =3D fal=
se;
>                 }
> -               mtk_crtc->pending_async_planes =3D false;
> +
> +               if (!cmdq_handle)
> +                       mtk_crtc->pending_async_planes =3D false;
>         }
>  }
>
> --
> 1.8.1.1.dirty
>
