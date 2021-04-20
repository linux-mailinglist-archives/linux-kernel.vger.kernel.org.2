Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69579366295
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 01:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbhDTXrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 19:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234186AbhDTXrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 19:47:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25F1A61405;
        Tue, 20 Apr 2021 23:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618962425;
        bh=eA0je9XIMBi+hBIu0Pn+Aqj2T8qTA7b2uS0VLUF9zzI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LLoLlHkeLBDnQdbZLhuvX9xOoH4axN0qp+9NqdkFFfPTNsTVrZX2BYwP95/jmzXbe
         FZdHUD9WmZ8roFsiA8D2MZxqFnhaf8wG4d0mEji0L11b9lNqtTc226sT81K2/sFg0d
         3NOutLIfcIdLaCAfDJuBkkcQsjJn7GG+NnryiTpTIJNTAgZ4rrxfKGKH7Z/fdQEgu9
         jO3bL4tY86zEh/S5odoWApJ/bgqVsXXCohotJowhgy8LdR2mLlCrl7mJxFJaisZsLq
         UkCous9eWdQPBpcr/CN9dWVs4HWZTJ42DMYruXNpzSY8/J57DCFo4UA6mwFLZ7lwl2
         C5ymHH/U29J+w==
Received: by mail-ej1-f47.google.com with SMTP id r12so60828205ejr.5;
        Tue, 20 Apr 2021 16:47:05 -0700 (PDT)
X-Gm-Message-State: AOAM531vkiZRY5JyTpqKl7h+QMkGyn1TSq5btnL4oa6bLFsfU3iaiNtn
        68OpQq6ZIj/0FyMGVj4Ai4ySgSAH9jSnm5sS1A==
X-Google-Smtp-Source: ABdhPJzWtA0GFcdRkEW30nmVsBQ8OqLDMIWv7BThU6NzNQoUVz5rdXp0ZYW89/UGZrCQLN81Daaw9OUcamTMW6UpIik=
X-Received: by 2002:a17:907:629c:: with SMTP id nd28mr30584066ejc.267.1618962423550;
 Tue, 20 Apr 2021 16:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210409045314.3420733-1-hsinyi@chromium.org> <CAJMQK-gFk8WV0W2TTP7=OTsBqgWmy_eKSd42Xa5dJzvUFDTAXQ@mail.gmail.com>
In-Reply-To: <CAJMQK-gFk8WV0W2TTP7=OTsBqgWmy_eKSd42Xa5dJzvUFDTAXQ@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 21 Apr 2021 07:46:52 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9pJ=H4gQKsC1VeHo6Z4qsHFzOe267QVu6p_Jid0AXsKQ@mail.gmail.com>
Message-ID: <CAAOTY_9pJ=H4gQKsC1VeHo6Z4qsHFzOe267QVu6p_Jid0AXsKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/mediatek: set panel orientation before drm_dev_register().
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2021=E5=B9=B44=E6=9C=8820=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:05=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Apr 9, 2021 at 12:53 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > drm_dev_register() sets connector->registration_state to
> > DRM_CONNECTOR_REGISTERED and dev->registered to true. If
> > drm_connector_set_panel_orientation() is first called after
> > drm_dev_register(), it will fail several checks and results in followin=
g
> > warning. So set panel orientation in dsi before drm_dev_register() is
> > called.

All connector would have this problem, so I would like to fix this in
common code.
In drm_connector_init(), you could add "panel orientation" property
with value DRM_MODE_PANEL_ORIENTATION_UNKNOWN, so it would not add new
object when get modes.

Regards,
Chun-Kuang.

> >
> > [    4.480976] ------------[ cut here ]------------
> > [    4.485603] WARNING: CPU: 5 PID: 369 at drivers/gpu/drm/drm_mode_obj=
ect.c:45 __drm_mode_object_add+0xb4/0xbc
> > <snip>
> > [    4.609772] Call trace:
> > [    4.612208]  __drm_mode_object_add+0xb4/0xbc
> > [    4.616466]  drm_mode_object_add+0x20/0x2c
> > [    4.620552]  drm_property_create+0xdc/0x174
> > [    4.624723]  drm_property_create_enum+0x34/0x98
> > [    4.629241]  drm_connector_set_panel_orientation+0x64/0xa0
> > [    4.634716]  boe_panel_get_modes+0x88/0xd8
> > [    4.638802]  drm_panel_get_modes+0x2c/0x48
> > [    4.642887]  panel_bridge_get_modes+0x1c/0x28
> > [    4.647233]  drm_bridge_connector_get_modes+0xa0/0xd4
> > [    4.652273]  drm_helper_probe_single_connector_modes+0x218/0x700
> > [    4.658266]  drm_mode_getconnector+0x1b4/0x45c
> > [    4.662699]  drm_ioctl_kernel+0xac/0x128
> > [    4.666611]  drm_ioctl+0x268/0x410
> > [    4.670002]  drm_compat_ioctl+0xdc/0xf0
> > [    4.673829]  __arm64_compat_sys_ioctl+0xc8/0x100
> > [    4.678436]  el0_svc_common+0xf4/0x1c0
> > [    4.682174]  do_el0_svc_compat+0x28/0x3c
> > [    4.686088]  el0_svc_compat+0x10/0x1c
> > [    4.689738]  el0_sync_compat_handler+0xa8/0xcc
> > [    4.694171]  el0_sync_compat+0x178/0x180
> > [    4.698082] ---[ end trace b4f2db9d9c88610b ]---
> > [    4.702721] ------------[ cut here ]------------
> > [    4.707329] WARNING: CPU: 5 PID: 369 at drivers/gpu/drm/drm_mode_obj=
ect.c:243 drm_object_attach_property+0x48/0xb8
> > <snip>
> > [    4.833830] Call trace:
> > [    4.836266]  drm_object_attach_property+0x48/0xb8
> > [    4.840958]  drm_connector_set_panel_orientation+0x84/0xa0
> > [    4.846432]  boe_panel_get_modes+0x88/0xd8
> > [    4.850516]  drm_panel_get_modes+0x2c/0x48
> > [    4.854600]  panel_bridge_get_modes+0x1c/0x28
> > [    4.858946]  drm_bridge_connector_get_modes+0xa0/0xd4
> > [    4.863984]  drm_helper_probe_single_connector_modes+0x218/0x700
> > [    4.869978]  drm_mode_getconnector+0x1b4/0x45c
> > [    4.874410]  drm_ioctl_kernel+0xac/0x128
> > [    4.878320]  drm_ioctl+0x268/0x410
> > [    4.881711]  drm_compat_ioctl+0xdc/0xf0
> > [    4.885536]  __arm64_compat_sys_ioctl+0xc8/0x100
> > [    4.890142]  el0_svc_common+0xf4/0x1c0
> > [    4.893879]  do_el0_svc_compat+0x28/0x3c
> > [    4.897791]  el0_svc_compat+0x10/0x1c
> > [    4.901441]  el0_sync_compat_handler+0xa8/0xcc
> > [    4.905873]  el0_sync_compat+0x178/0x180
> > [    4.909783] ---[ end trace b4f2db9d9c88610c ]---
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>
> ping on the thread, thanks.
>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/media=
tek/mtk_dsi.c
> > index ae403c67cbd9..45a702ee09f3 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -205,6 +205,7 @@ struct mtk_dsi {
> >         u32 irq_data;
> >         wait_queue_head_t irq_wait_queue;
> >         const struct mtk_dsi_driver_data *driver_data;
> > +       enum drm_panel_orientation orientation;
> >  };
> >
> >  static inline struct mtk_dsi *bridge_to_dsi(struct drm_bridge *b)
> > @@ -966,6 +967,8 @@ static int mtk_dsi_encoder_init(struct drm_device *=
drm, struct mtk_dsi *dsi)
> >         }
> >         drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
> >
> > +       drm_connector_set_panel_orientation(dsi->connector, dsi->orient=
ation);
> > +
> >         return 0;
> >
> >  err_cleanup_encoder:
> > @@ -1029,6 +1032,12 @@ static int mtk_dsi_probe(struct platform_device =
*pdev)
> >                         ret =3D PTR_ERR(dsi->next_bridge);
> >                         goto err_unregister_host;
> >                 }
> > +
> > +               ret =3D of_drm_get_panel_orientation(panel->dev->of_nod=
e, &dsi->orientation);
> > +               if (ret) {
> > +                       dev_err(dev, "failed to get panel orientation %=
d\n", ret);
> > +                       return ret;
> > +               }
> >         }
> >
> >         dsi->driver_data =3D of_device_get_match_data(dev);
> > --
> > 2.31.1.295.g9ea45b61b8-goog
> >
