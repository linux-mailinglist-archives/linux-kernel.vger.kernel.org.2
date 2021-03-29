Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2A734D4B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhC2QSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:18:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbhC2QST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:18:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0D8561964
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 16:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617034698;
        bh=g+KluKB8J7DldbUMXc360cZ2gLPYH64Rs8T0Q973c4I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rkSS3PoK+z4fEREe+CoYCingZyivZDsBHNbwPlFWBfPdMrt4Wt+zyS0PB/B2OASft
         G79ZHSSLVeV608NosAI5ZvXt+Ii+uXVp48O7e7S6USRvhyHpSgg5E2UCOxtO8r71Ij
         zzNChtAVev9Kel8Ho5KPcqAQHKJAnrxW70r27OpKxP/BQ80/UPJNkivj1/oy1mDCmu
         uedhsqvFsWBPC2N9dGPVvJ5sNALsTiBAeezUCb0vgnt3Fw1AtWg0Ipya7mDRW4VGU9
         YbZimZtgj+IKi6BPVysKGCJ+f9TKR+prb7xUfxxaO0EpAHAF/xmXEQbEa52fsQlZ6c
         /GOwQRix4h1Zw==
Received: by mail-ej1-f52.google.com with SMTP id jy13so20399872ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:18:18 -0700 (PDT)
X-Gm-Message-State: AOAM530l6cFBPSSfMCikYARySaCN9uw+yrLDU3FblqXMEBHSj2wh4JWp
        mx+Dog2fLJZ7fHPyzh0DJxPla6zJZCbbi82E0w==
X-Google-Smtp-Source: ABdhPJzW5H3Lz87UAaUdYwZ6+LCv3qjBvbr2LYXfYPYVmXRCOrWSVgwuKYSAM/RT4dWSLTowm0pFAOoA7i5p2TsOxgA=
X-Received: by 2002:a17:906:7c4:: with SMTP id m4mr29562982ejc.63.1617034697158;
 Mon, 29 Mar 2021 09:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210313094331.26374-1-chunkuang.hu@kernel.org>
In-Reply-To: <20210313094331.26374-1-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 30 Mar 2021 00:18:05 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-6i-D5Ou+Bme-ipvodmqU8Ybsot4yNhKgqr4G-=Ptr9A@mail.gmail.com>
Message-ID: <CAAOTY_-6i-D5Ou+Bme-ipvodmqU8Ybsot4yNhKgqr4G-=Ptr9A@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: crtc: Make config-updating atomic
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to mediatek-drm-next [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B43=E6=9C=8813=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=885:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> While updating config, the irq would occur and get the partial
> config, so use variable config_updating to make updating atomic.
>
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index 8b0de90156c6..870f66210848 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -61,6 +61,7 @@ struct mtk_drm_crtc {
>
>         /* lock for display hardware access */
>         struct mutex                    hw_lock;
> +       bool                            config_updating;
>  };
>
>  struct mtk_crtc_state {
> @@ -97,7 +98,7 @@ static void mtk_drm_crtc_finish_page_flip(struct mtk_dr=
m_crtc *mtk_crtc)
>  static void mtk_drm_finish_page_flip(struct mtk_drm_crtc *mtk_crtc)
>  {
>         drm_crtc_handle_vblank(&mtk_crtc->base);
> -       if (mtk_crtc->pending_needs_vblank) {
> +       if (!mtk_crtc->config_updating && mtk_crtc->pending_needs_vblank)=
 {
>                 mtk_drm_crtc_finish_page_flip(mtk_crtc);
>                 mtk_crtc->pending_needs_vblank =3D false;
>         }
> @@ -425,7 +426,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc=
,
>         }
>  }
>
> -static void mtk_drm_crtc_hw_config(struct mtk_drm_crtc *mtk_crtc)
> +static void mtk_drm_crtc_update_config(struct mtk_drm_crtc *mtk_crtc,
> +                                      bool needs_vblank)
>  {
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         struct cmdq_pkt *cmdq_handle;
> @@ -436,6 +438,10 @@ static void mtk_drm_crtc_hw_config(struct mtk_drm_cr=
tc *mtk_crtc)
>         int i;
>
>         mutex_lock(&mtk_crtc->hw_lock);
> +       mtk_crtc->config_updating =3D true;
> +       if (needs_vblank)
> +               mtk_crtc->pending_needs_vblank =3D true;
> +
>         for (i =3D 0; i < mtk_crtc->layer_nr; i++) {
>                 struct drm_plane *plane =3D &mtk_crtc->planes[i];
>                 struct mtk_plane_state *plane_state;
> @@ -472,6 +478,7 @@ static void mtk_drm_crtc_hw_config(struct mtk_drm_crt=
c *mtk_crtc)
>                 cmdq_pkt_flush_async(cmdq_handle, ddp_cmdq_cb, cmdq_handl=
e);
>         }
>  #endif
> +       mtk_crtc->config_updating =3D false;
>         mutex_unlock(&mtk_crtc->hw_lock);
>  }
>
> @@ -532,7 +539,7 @@ void mtk_drm_crtc_async_update(struct drm_crtc *crtc,=
 struct drm_plane *plane,
>                 return;
>
>         plane_helper_funcs->atomic_update(plane, new_state);
> -       mtk_drm_crtc_hw_config(mtk_crtc);
> +       mtk_drm_crtc_update_config(mtk_crtc, false);
>  }
>
>  static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
> @@ -582,7 +589,7 @@ static void mtk_drm_crtc_atomic_disable(struct drm_cr=
tc *crtc,
>         }
>         mtk_crtc->pending_planes =3D true;
>
> -       mtk_drm_crtc_hw_config(mtk_crtc);
> +       mtk_drm_crtc_update_config(mtk_crtc, false);
>         /* Wait for planes to be disabled */
>         drm_crtc_wait_one_vblank(crtc);
>
> @@ -618,14 +625,12 @@ static void mtk_drm_crtc_atomic_flush(struct drm_cr=
tc *crtc,
>         struct mtk_drm_crtc *mtk_crtc =3D to_mtk_crtc(crtc);
>         int i;
>
> -       if (mtk_crtc->event)
> -               mtk_crtc->pending_needs_vblank =3D true;
>         if (crtc->state->color_mgmt_changed)
>                 for (i =3D 0; i < mtk_crtc->ddp_comp_nr; i++) {
>                         mtk_ddp_gamma_set(mtk_crtc->ddp_comp[i], crtc->st=
ate);
>                         mtk_ddp_ctm_set(mtk_crtc->ddp_comp[i], crtc->stat=
e);
>                 }
> -       mtk_drm_crtc_hw_config(mtk_crtc);
> +       mtk_drm_crtc_update_config(mtk_crtc, !!mtk_crtc->event);
>  }
>
>  static const struct drm_crtc_funcs mtk_crtc_funcs =3D {
> --
> 2.17.1
>
