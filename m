Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63F8370539
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 06:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhEAEHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 00:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbhEAEHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 00:07:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38948613F4;
        Sat,  1 May 2021 04:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619841989;
        bh=F+isvP/CISEBur6+0efALgnBlYarHdry2+xf4t13CSQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Laf32isseyoxoRlwVduDmzQloyXdmi8KFQvzoQbIpm//+nG2tKgMZKOTmZw8KhEws
         h6wXYysAUKvIXNy263+Fvjl8rRAFB4laVwWX1qKIHBMo/SjncrB4+CTzUTB7S6y627
         DxhBXP5/UnFst/UMWoLRlmOegqns5crpye1SjT/hWXaVMYxLsfi5bUELL+6AfbJb4d
         NGk15pJuP75yQG5eDN+1RqAtDA4yDmdjB9IlB2pB4arlDX0rqtLqoChA2GTNzlAjvR
         d+85ImFDiGyEBKS5WQGChN3HEOpOXgRquTqTWP/mIZcXoAwWEf1P+34T4T8tBkYGtn
         HjSucjlZ8y8EA==
Received: by mail-ed1-f49.google.com with SMTP id g10so394407edb.0;
        Fri, 30 Apr 2021 21:06:29 -0700 (PDT)
X-Gm-Message-State: AOAM5320yRVZJv41J5MRrONIxI4DC5f3kYAraCZDp866lI4TXCVIviq5
        Ar8MBkJ2J2DU7Lz2pfKhyPULT3xium+/e92tUA==
X-Google-Smtp-Source: ABdhPJy/xB9YH6r0sZIkUz5zI/CnVQBqFHcrCzYVGkRITeICDiq17pGJWls+d/u9iH8uBuq2/DCSh3jzzV+xhxEq6C0=
X-Received: by 2002:aa7:db0c:: with SMTP id t12mr9503414eds.72.1619841987818;
 Fri, 30 Apr 2021 21:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <1619838819-11309-1-git-send-email-yongqiang.niu@mediatek.com> <1619838819-11309-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1619838819-11309-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 1 May 2021 12:06:15 +0800
X-Gmail-Original-Message-ID: <CAAOTY_93Ym8yg1rmTVSqG5XCCkkGTWE4HBqiUWCRYk-Af4WKNg@mail.gmail.com>
Message-ID: <CAAOTY_93Ym8yg1rmTVSqG5XCCkkGTWE4HBqiUWCRYk-Af4WKNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/mediatek: move page flip handle into cmdq cb
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
        Chun-Hung Wu <chun-hung.wu@mediatek.com>
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
> move page flip handle into cmdq cb
> irq callback will before cmdq flush ddp register
> into hardware, that will cause the display frame page
> flip event before it realy display out time

After apply patch [1], we don't need to care about which one (irq or
cmdq_cb) come first. Even though cmdq_cb come later, GCE would have
already write register in vblank.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20210430&id=3D368166ec7600ba83587cfcb31d817cf6479cf006

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 46 +++++++++++++++++++++++++++=
+++---
>  1 file changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index 8b0de90..c37881b 100644
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
> @@ -223,7 +229,27 @@ struct mtk_ddp_comp *mtk_drm_ddp_comp_for_plane(stru=
ct drm_crtc *crtc,
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>  static void ddp_cmdq_cb(struct cmdq_cb_data data)
>  {
> -       cmdq_pkt_destroy(data.data);
> +       struct mtk_cmdq_cb_data *cb_data =3D data.data;
> +       struct mtk_drm_crtc *mtk_crtc;
> +
> +       if (!cb_data) {
> +               DRM_ERROR("cmdq callback data is null pointer!\n");
> +               return;
> +       }
> +
> +       mtk_crtc =3D cb_data->mtk_crtc;
> +       if (!mtk_crtc) {
> +               DRM_ERROR("cmdq callback mtk_crtc is null pointer!\n");
> +               goto destroy_pkt;
> +       }
> +
> +       mtk_drm_finish_page_flip(mtk_crtc);
> +
> +destroy_pkt:
> +       if (cb_data->cmdq_handle)
> +               cmdq_pkt_destroy(cb_data->cmdq_handle);
> +
> +       kfree(cb_data);
>  }
>  #endif
>
> @@ -463,13 +489,20 @@ static void mtk_drm_crtc_hw_config(struct mtk_drm_c=
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
> @@ -488,7 +521,14 @@ static void mtk_crtc_ddp_irq(void *data)
>  #endif
>                 mtk_crtc_ddp_config(crtc, NULL);
>
> +       drm_crtc_handle_vblank(&mtk_crtc->base);
> +
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +       if (!priv->data->shadow_register && !mtk_crtc->cmdq_client)
> +               mtk_drm_finish_page_flip(mtk_crtc);
> +#else
>         mtk_drm_finish_page_flip(mtk_crtc);
> +#endif
>  }
>
>  static int mtk_drm_crtc_enable_vblank(struct drm_crtc *crtc)
> --
> 1.8.1.1.dirty
>
