Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4A0370540
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 06:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhEAEOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 00:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhEAEOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 00:14:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C33EB6143D;
        Sat,  1 May 2021 04:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619842393;
        bh=rZkUEmWuORYzrFh3ZGN+u1VrkOvfZ6ioX1N/wXlRhT8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fYqkKVidNSEWrYSre3relENB+/LhNBGJTFBZG0V7qwT7V9I6AUdgUvl881k9Tmr/r
         3wP0q6aQFpqTLz6VohS2ChhmdM5qBzWktugErRjplKuvnPzalaH+vcRsy28OVOXT9w
         1y0dkp+DqEuElbHKIcpuEvB142eH2QyhjeR5muV4WiJ50J/IEm/G/5Yr+huuLWZM9a
         fB96SJayqWxpvnAzNvq74ulOcZmYASHYXDcpIAWiV4oaZbuYCfO4KVFI0P71fNn0oa
         nLdjGxkWY6l2NpoJGdNqzsRuA0kcEuizDPP4SfPoZmbAiRkJgva3heD81FzyWtLTQR
         J4EjN8gm2Hb6A==
Received: by mail-ej1-f48.google.com with SMTP id f24so136758ejc.6;
        Fri, 30 Apr 2021 21:13:13 -0700 (PDT)
X-Gm-Message-State: AOAM530TKugI21ZRiZ7Po9ITTZuvODXhkJQKoeAD11IMNBQomwb8b8fN
        kLZBWAFbuSeVfIyJ2HipbJGsNrubklVQUjNfKQ==
X-Google-Smtp-Source: ABdhPJxnC6UDbmKBHF8gvCRW9YTLGWrnRCI6f7HVRl4NQ9Fnv7HEZ7PTr7+e4xfWR+t0j874t8lbSwZFwtkzb60aqLk=
X-Received: by 2002:a17:906:3da9:: with SMTP id y9mr7566517ejh.303.1619842392342;
 Fri, 30 Apr 2021 21:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <1619838819-11309-1-git-send-email-yongqiang.niu@mediatek.com> <1619838819-11309-3-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1619838819-11309-3-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 1 May 2021 12:13:00 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-hQ=6TbbL+usSUd+ygxBVK+xzD2Q1zL_SvoGx2s7hyWQ@mail.gmail.com>
Message-ID: <CAAOTY_-hQ=6TbbL+usSUd+ygxBVK+xzD2Q1zL_SvoGx2s7hyWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/mediatek: clear pending flag when cmdq packet is done.
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B45=E6=9C=
=881=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8811:13=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> In cmdq mode, packet may be flushed before it is executed, so
> the pending flag should be cleared after cmdq packet is done.
>
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 57 +++++++++++++++++++++++++++=
+++---
>  1 file changed, 52 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index c37881b..6a3cf47 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -231,18 +231,57 @@ static void ddp_cmdq_cb(struct cmdq_cb_data data)
>  {
>         struct mtk_cmdq_cb_data *cb_data =3D data.data;
>         struct mtk_drm_crtc *mtk_crtc;
> +       struct mtk_crtc_state *state;
> +       unsigned int i;
>
>         if (!cb_data) {
>                 DRM_ERROR("cmdq callback data is null pointer!\n");
>                 return;
>         }
>
> +       if (data.sta =3D=3D CMDQ_CB_ERROR) {

I would like this patch to depend on [1].

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/2021031423332=
3.23377-2-chunkuang.hu@kernel.org/

Regards,
Chun-Kuang.

> +               DRM_WARN("cmdq callback error!!\n");
> +               goto destroy_pkt;
> +       }
> +
>         mtk_crtc =3D cb_data->mtk_crtc;
>         if (!mtk_crtc) {
>                 DRM_ERROR("cmdq callback mtk_crtc is null pointer!\n");
>                 goto destroy_pkt;
>         }
>
> +       state =3D to_mtk_crtc_state(mtk_crtc->base.state);
> +
> +       if (state->pending_config) {
> +               state->pending_config =3D false;
> +       }
> +
> +       if (mtk_crtc->pending_planes) {
> +               for (i =3D 0; i < mtk_crtc->layer_nr; i++) {
> +                       struct drm_plane *plane =3D &mtk_crtc->planes[i];
> +                       struct mtk_plane_state *plane_state;
> +
> +                       plane_state =3D to_mtk_plane_state(plane->state);
> +
> +                       if (plane_state->pending.config)
> +                               plane_state->pending.config =3D false;
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
> +                       if (plane_state->pending.async_config)
> +                               plane_state->pending.async_config =3D fal=
se;
> +               }
> +               mtk_crtc->pending_async_planes =3D false;
> +       }
> +
>         mtk_drm_finish_page_flip(mtk_crtc);
>
>  destroy_pkt:
> @@ -403,7 +442,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc=
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
> @@ -423,9 +463,12 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crt=
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
> @@ -445,9 +488,13 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crt=
c,
>                                 mtk_ddp_comp_layer_config(comp, local_lay=
er,
>                                                           plane_state,
>                                                           cmdq_handle);
> -                       plane_state->pending.async_config =3D false;
> +
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
