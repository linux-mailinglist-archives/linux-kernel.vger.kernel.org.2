Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3BF43B640
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbhJZQAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235747AbhJZQAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:00:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CD9860EFE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 15:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635263866;
        bh=OB+yWz25S7H3KGVqOadlPy4oTErCjsdJuZ0ZVaPAy8k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sObXfWHNH1Ep7PFB5UCko8HHE1M5p0eOXoVGC2j1svd5koMPgu3SBYJhrKhRYL7gG
         Ipzv7OqMDkYd8FHSJ6t2x3B5kbgsXqamX9GTdjjRCL/qPmMb9HMLb8bOWsxdzG2a3N
         Npm2Pn+FBviP7eXtv3z9yDhFZIL1PYrI42cvfIDht4LvRNR1Cmh/uAC0YTgv87tc+X
         OwWAqhIDSVWFAu6/YnvQsI1QDzY4Sp1uZVWobtjRogKjgJnJoQ9o67ed278WmKnyUK
         sIJMPcszBPWET4VZcDIMko7TJvcVrq/9c1oLIaGXqXMHawm+Rlhp9yG9ACqf4lSglq
         LteNFVK7Wk46w==
Received: by mail-ed1-f42.google.com with SMTP id 5so15342781edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:57:46 -0700 (PDT)
X-Gm-Message-State: AOAM532ArVQrZ71pZgBYM5Hh5J2KbKVwyJ5YdIJU4SOJ+tNJFylED/4X
        Azx5A1YLC4VlL9Zhy02bkI8+VfgU2cohMFb2sg==
X-Google-Smtp-Source: ABdhPJybqDR3/pnAJXzhteBsi4mz3UfvtHoiBaXiMxgZ9m+2o1xf0216M+QZACOhTRWtaq3EIkWNHjKybj9XSRrnxzE=
X-Received: by 2002:a50:ff0a:: with SMTP id a10mr22780481edu.357.1635263708464;
 Tue, 26 Oct 2021 08:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211026052916.8222-1-jason-jh.lin@mediatek.com> <20211026052916.8222-4-jason-jh.lin@mediatek.com>
In-Reply-To: <20211026052916.8222-4-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 26 Oct 2021 23:54:57 +0800
X-Gmail-Original-Message-ID: <CAAOTY__8jL__0H=puB+WmMAO9MBiFpzh=6Aw8VLSJ6xNsSakuA@mail.gmail.com>
Message-ID: <CAAOTY__8jL__0H=puB+WmMAO9MBiFpzh=6Aw8VLSJ6xNsSakuA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] drm/mediatek: Detect CMDQ execution timeout
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
> From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>
> CMDQ is used to update display register in vblank period, so
> it should be execute in next 2 vblank. One vblank interrupt
> before send message (occasionally) and one vblank interrupt
> after cmdq done. If it fail to execute in next 3 vblank,
> tiemout happen.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index e23e3224ac67..dad1f85ee315 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -54,6 +54,7 @@ struct mtk_drm_crtc {
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         struct cmdq_client              cmdq_client;
>         u32                             cmdq_event;
> +       u32                             cmdq_vblank_cnt;
>  #endif
>
>         struct device                   *mmsys_dev;
> @@ -227,7 +228,10 @@ struct mtk_ddp_comp *mtk_drm_ddp_comp_for_plane(stru=
ct drm_crtc *crtc,
>  static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
>  {
>         struct cmdq_cb_data *data =3D mssg;
> +       struct cmdq_client *cmdq_cl =3D container_of(cl, struct cmdq_clie=
nt, client);
> +       struct mtk_drm_crtc *mtk_crtc =3D container_of(cmdq_cl, struct mt=
k_drm_crtc, cmdq_client);
>
> +       mtk_crtc->cmdq_vblank_cnt =3D 0;
>         cmdq_pkt_destroy(data->pkt);
>  }
>  #endif
> @@ -483,6 +487,15 @@ static void mtk_drm_crtc_update_config(struct mtk_dr=
m_crtc *mtk_crtc,
>                                            cmdq_handle->pa_base,
>                                            cmdq_handle->cmd_buf_size,
>                                            DMA_TO_DEVICE);
> +               /*
> +                * CMDQ command should execute in next 3 vblank.
> +                * One vblank interrupt before send message (occasionally=
)
> +                * and one vblank interrupt after cmdq done,
> +                * so it's timeout after 3 vblank interrupt.
> +                * If it fail to execute in next 3 vblank, timeout happen=
.
> +                */
> +               mtk_crtc->cmdq_vblank_cnt =3D 3;
> +
>                 mbox_send_message(mtk_crtc->cmdq_client.chan, cmdq_handle=
);
>                 mbox_client_txdone(mtk_crtc->cmdq_client.chan, 0);
>         }
> @@ -499,11 +512,14 @@ static void mtk_crtc_ddp_irq(void *data)
>
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         if (!priv->data->shadow_register && !mtk_crtc->cmdq_client.chan)
> +               mtk_crtc_ddp_config(crtc, NULL);
> +       else if (mtk_crtc->cmdq_vblank_cnt > 0 && --mtk_crtc->cmdq_vblank=
_cnt =3D=3D 0)
> +               DRM_ERROR("mtk_crtc %d CMDQ execute command timeout!\n",
> +                         drm_crtc_index(&mtk_crtc->base));
>  #else
>         if (!priv->data->shadow_register)
> -#endif
>                 mtk_crtc_ddp_config(crtc, NULL);
> -
> +#endif
>         mtk_drm_finish_page_flip(mtk_crtc);
>  }
>
> --
> 2.18.0
>
