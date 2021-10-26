Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC9F43B69A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbhJZQMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235165AbhJZQMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:12:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AEFF60EFE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635264624;
        bh=R9XHfPiiMdHaMgonXhRNxe+si5OeI8KDpG4+6gMNnWo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EsNqCYCSil0bxC5mXHF3/mu9yA2nKdyb3QR3DpiKRa+sdOytrhblE9T1s8a20r6NO
         4u0bL9q8e6OWWQm05hPdS9ureYsE7gUKjp4ZFsGyvF6LIeQSZ+bh12Htt9Ly72bz7s
         hU4YcezLAYrnw2qr9j0n9sUqj4XAS6R8KqHEHqRrpgugaBrVpELkNCIb7mq4fUj3ZI
         rKgYRjGeve4WbHBUWha5aF0NcIko/3VXeTgVTFqLp2Cn7um2jIYGW/gbZEV6Azq0+i
         LCxc00ySfu8D6keTdEHEUjUOyLOu9uEzV/0dVsI6yd6tY9Vk7JseI7Y51rMNn4YXGX
         6/yV7ZIKWu9pg==
Received: by mail-ed1-f41.google.com with SMTP id z20so2390925edi.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:10:24 -0700 (PDT)
X-Gm-Message-State: AOAM533JmMZZ5MCi0/aapNISeKlMjQiwmzfWK8SeoIehTX3xGG1aNc5c
        GB0gxFDPILxSqGlzgLpkkvwjzEhiEG/mqfJODw==
X-Google-Smtp-Source: ABdhPJyFy2UYH5W8n5qxwQhKlt0rY0EVB0dXXDZyKeTXA7dBLlF7y1ifgfrW3G4thyWRnm7C7npA+36pHS87eytsgRk=
X-Received: by 2002:a17:907:6ea6:: with SMTP id sh38mr31993724ejc.388.1635264489262;
 Tue, 26 Oct 2021 09:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211026052916.8222-1-jason-jh.lin@mediatek.com> <20211026052916.8222-6-jason-jh.lin@mediatek.com>
In-Reply-To: <20211026052916.8222-6-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 27 Oct 2021 00:07:58 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8Wz8+k+XyZaojzuGu3mkR2oidFh09eYarQA_63NFJ__g@mail.gmail.com>
Message-ID: <CAAOTY_8Wz8+k+XyZaojzuGu3mkR2oidFh09eYarQA_63NFJ__g@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] drm/mediatek: Clear pending flag when cmdq packet
 is done
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, fshao@chromium.org,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=88=
26=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=881:29=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
>
> In cmdq mode, packet may be flushed before it is executed, so
> the pending flag should be cleared after cmdq packet is done.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 51 ++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index 31f05efc1bc0..ea285795776f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -275,8 +275,42 @@ struct mtk_ddp_comp *mtk_drm_ddp_comp_for_plane(stru=
ct drm_crtc *crtc,
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>  static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
>  {
> +       struct cmdq_cb_data *data =3D mssg;
>         struct cmdq_client *cmdq_cl =3D container_of(cl, struct cmdq_clie=
nt, client);
>         struct mtk_drm_crtc *mtk_crtc =3D container_of(cmdq_cl, struct mt=
k_drm_crtc, cmdq_client);
> +       struct mtk_crtc_state *state;
> +       unsigned int i;
> +
> +       if (data->sta < 0)
> +               return;
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
>  }
> @@ -432,7 +466,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc=
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
> @@ -452,9 +487,12 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crt=
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
> @@ -474,9 +512,12 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crt=
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
> 2.18.0
>
