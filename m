Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51787320EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 00:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhBUX4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 18:56:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhBUX4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 18:56:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8493364E64;
        Sun, 21 Feb 2021 23:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613951721;
        bh=pCV1sQy9uTqnFAmmvzP8ZG3dSUM5TF1WU3OUbHWIOv4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T1pRRi5/D/X7oVKcOmFHTJtXqE5RutVhZWk7CLVNL5XbPT8qLQytrs0gEhOLn4zd/
         oMtzAGHyufc5EAcu9qpi67kgU5sFMf0THymI2PM4BPddsXq3IEgenfteJzQ7WsMpWg
         Fh++ylm32cIb7DV/46FFXRFy9poORUQIvjU8kqLcIl0MrLQppdq+Qg8jAVnNCwkeN8
         /s3Qc9qVacn1oOqUcFUrQUhG+UfoVpF7MO9ssZOm1coRCCrCAsNKygsF8/yDUcW1cN
         zVRfdYaI0IFjAPoRJWcZeJb+WzRvA2sS0avXg/cZpzLDNODhVX8uiwhLavvKRoiERK
         9eZgDdBOeY/sQ==
Received: by mail-ed1-f51.google.com with SMTP id i14so19434588eds.8;
        Sun, 21 Feb 2021 15:55:21 -0800 (PST)
X-Gm-Message-State: AOAM530Ig5p3dOBvdBDxynLTxJ9qlmFw4q4+RM928g2qYOdwaNLkZxdL
        PXgwHswInickGI+KBg28diwa945MO2Qwd0n5Vg==
X-Google-Smtp-Source: ABdhPJzjfP1nPPQ1MNPaWVnfk2Mr7HLZ5b27HJabVIkK5eW+HiRwhioG5vwkCodyWo5nFcJXQ+8wp5PIi/mGH6iID4E=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr19989951edw.303.1613951719928;
 Sun, 21 Feb 2021 15:55:19 -0800 (PST)
MIME-Version: 1.0
References: <1613728452-24871-1-git-send-email-yongqiang.niu@mediatek.com> <1613728452-24871-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1613728452-24871-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 22 Feb 2021 07:55:10 +0800
X-Gmail-Original-Message-ID: <CAAOTY_92-Kw+BFnxgQbh2zFT5hDBAF+uZe+_VgCd4NAziQ0wUg@mail.gmail.com>
Message-ID: <CAAOTY_92-Kw+BFnxgQbh2zFT5hDBAF+uZe+_VgCd4NAziQ0wUg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/mediatek: move page flip handle into cmdq cb
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B42=E6=9C=
=8819=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:54=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> move page flip handle into cmdq cb
> irq callback will before cmdq flush ddp register
> into hardware, that will cause the display frame page
> flip event before it realy display out time
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 33 +++++++++++++++++++++++++++=
++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index bdd37ea..bece327 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -72,6 +72,13 @@ struct mtk_crtc_state {
>         unsigned int                    pending_vrefresh;
>  };
>
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +struct mtk_cmdq_cb_data {
> +       struct cmdq_pkt                 *cmdq_handle;
> +       struct mtk_drm_crtc             *mtk_crtc;
> +};
> +#endif
> +
>  static inline struct mtk_drm_crtc *to_mtk_crtc(struct drm_crtc *c)
>  {
>         return container_of(c, struct mtk_drm_crtc, base);
> @@ -96,7 +103,6 @@ static void mtk_drm_crtc_finish_page_flip(struct mtk_d=
rm_crtc *mtk_crtc)
>
>  static void mtk_drm_finish_page_flip(struct mtk_drm_crtc *mtk_crtc)
>  {
> -       drm_crtc_handle_vblank(&mtk_crtc->base);
>         if (mtk_crtc->pending_needs_vblank) {
>                 mtk_drm_crtc_finish_page_flip(mtk_crtc);
>                 mtk_crtc->pending_needs_vblank =3D false;
> @@ -241,7 +247,19 @@ struct mtk_ddp_comp *mtk_drm_ddp_comp_for_plane(stru=
ct drm_crtc *crtc,
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>  static void ddp_cmdq_cb(struct cmdq_cb_data data)
>  {
> -       cmdq_pkt_destroy(data.data);
> +       struct mtk_cmdq_cb_data *cb_data =3D data.data;
> +
> +       if (cb_data) {
> +               struct mtk_drm_crtc *mtk_crtc =3D cb_data->mtk_crtc;
> +
> +               if (mtk_crtc)
> +                       mtk_drm_finish_page_flip(mtk_crtc);
> +
> +               if (cb_data->cmdq_handle)
> +                       cmdq_pkt_destroy(cb_data->cmdq_handle);
> +
> +               kfree(cb_data);
> +       }
>  }
>  #endif
>
> @@ -481,13 +499,20 @@ static void mtk_drm_crtc_hw_config(struct mtk_drm_c=
rtc *mtk_crtc)
>         }
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         if (mtk_crtc->cmdq_client) {
> +               struct mtk_cmdq_cb_data *cb_data;
> +
>                 mbox_flush(mtk_crtc->cmdq_client->chan, 2000);
>                 cmdq_handle =3D cmdq_pkt_create(mtk_crtc->cmdq_client, PA=
GE_SIZE);
>                 cmdq_pkt_clear_event(cmdq_handle, mtk_crtc->cmdq_event);
>                 cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, false);
>                 mtk_crtc_ddp_config(crtc, cmdq_handle);
>                 cmdq_pkt_finalize(cmdq_handle);
> -               cmdq_pkt_flush_async(cmdq_handle, ddp_cmdq_cb, cmdq_handl=
e);
> +
> +               cb_data =3D kmalloc(sizeof(*cb_data), GFP_KERNEL);
> +               cb_data->cmdq_handle =3D cmdq_handle;
> +               cb_data->mtk_crtc =3D mtk_crtc;
> +
> +               cmdq_pkt_flush_async(cmdq_handle, ddp_cmdq_cb, cb_data);
>         }
>  #endif
>         mutex_unlock(&mtk_crtc->hw_lock);
> @@ -674,7 +699,7 @@ void mtk_crtc_ddp_irq(struct drm_crtc *crtc, struct m=
tk_ddp_comp *comp)
>  #endif
>                 mtk_crtc_ddp_config(crtc, NULL);
>
> -       mtk_drm_finish_page_flip(mtk_crtc);
> +       drm_crtc_handle_vblank(&mtk_crtc->base);

For CPU and shadow register case, where to handle page flip?
The correct sequence should be:

1. set pending_needs_vblank to true
2. mtk_drm_crtc_hw_config
3. irq comes, handle page flip, and set pending_needs_vblank to false

But now irq comes before 2, so this patch want to fix this bug.
I think shadow register also have this problem. The control flow of
shadow register is similar to cmdq, so I would like to fix both
problem in the same way.

Regards,
Chun-Kuang.

>  }
>
>  static int mtk_drm_crtc_num_comp_planes(struct mtk_drm_crtc *mtk_crtc,
> --
> 1.8.1.1.dirty
>
