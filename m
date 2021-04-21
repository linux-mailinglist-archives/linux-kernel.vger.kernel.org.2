Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F3436637C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 03:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbhDUB5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 21:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhDUB5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 21:57:07 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42A0C061763
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 18:56:35 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id c3so27553373ils.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 18:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cvMssSvc8hPyloKKClMogTnqJuOXUsMOm4XH61nQD34=;
        b=duz3UEHMYloeEwUBvhhwPqYWfptD8iwoHpnlrEhziVb7cG+9UwhbQIR/oX+ERtldRA
         goUOXoKvlHGEQTxqX44Jp1mncGTT57MJTkgjQmU/eNUhT6+523DnP8gKv/62bVAhmJ1t
         Orm8ZwXPdwjhFxkm9f+trZgH68wjoz69x7JSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cvMssSvc8hPyloKKClMogTnqJuOXUsMOm4XH61nQD34=;
        b=WoIbEkIhpLxiSKE2YVRn6IkE3zRxUglGOPTCwnUXU6dTXi3w70QgDgAcyIZ8v5sw9y
         oHKoZoIfCv3Mau3p8p+AxWZpZ5X1RVNy29CbwNIZI9ZDPhQdouAYh+9lQnMfVhNFuWq9
         o68u5TZimkwWdQlzTqieWME7iiOHlLypwsKV1ZpVM5GVkY3vlfL16b7gr6wxnH64RDyM
         VpS3QWhjm85FMOHbgHHH6x5ymqTuShlTOlCFceq3FgyGaGFzgoS/aUbkSaBq9U1hzaAX
         PEwk8yD+e2T3ZLxY8awxeaFuDDn6Shwas43sz1HzHSQSJjpWou0doMZdhO+WGexaSsgx
         X/jg==
X-Gm-Message-State: AOAM532lMBObOYmtMQC+C7hlMU5ATZ/AW+v4LlXHVwErO3HVw2DDwfAk
        MYRFwYTXtE4A1kXgSNbViKm420zPncs0YIPH/QvcTw==
X-Google-Smtp-Source: ABdhPJyduQbgwU81Uwxufem1ofj2vTk7xmlEMfaBM6o4S82+Dp7cP5qxHhrJsqLF8Jh6BVMCYX0eqfz3T+c6stggfO0=
X-Received: by 2002:a05:6e02:20ce:: with SMTP id 14mr24148490ilq.102.1618970193723;
 Tue, 20 Apr 2021 18:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210409045314.3420733-1-hsinyi@chromium.org> <CAJMQK-gFk8WV0W2TTP7=OTsBqgWmy_eKSd42Xa5dJzvUFDTAXQ@mail.gmail.com>
 <CAAOTY_9pJ=H4gQKsC1VeHo6Z4qsHFzOe267QVu6p_Jid0AXsKQ@mail.gmail.com>
In-Reply-To: <CAAOTY_9pJ=H4gQKsC1VeHo6Z4qsHFzOe267QVu6p_Jid0AXsKQ@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 21 Apr 2021 09:56:07 +0800
Message-ID: <CAJMQK-i8aZWmKyJ=7Gf8Wee3MynnqVvpijTOxqKp9M0vyECcPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/mediatek: set panel orientation before drm_dev_register().
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
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

On Wed, Apr 21, 2021 at 7:47 AM Chun-Kuang Hu <chunkuang.hu@kernel.org> wro=
te:
>
> Hi, Hsin-Yi:
>
> Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2021=E5=B9=B44=E6=9C=8820=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:05=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Fri, Apr 9, 2021 at 12:53 PM Hsin-Yi Wang <hsinyi@chromium.org> wrot=
e:
> > >
> > > drm_dev_register() sets connector->registration_state to
> > > DRM_CONNECTOR_REGISTERED and dev->registered to true. If
> > > drm_connector_set_panel_orientation() is first called after
> > > drm_dev_register(), it will fail several checks and results in follow=
ing
> > > warning. So set panel orientation in dsi before drm_dev_register() is
> > > called.
>
> All connector would have this problem, so I would like to fix this in
> common code.
> In drm_connector_init(), you could add "panel orientation" property
> with value DRM_MODE_PANEL_ORIENTATION_UNKNOWN, so it would not add new
> object when get modes.

Hi CK,

Calling drm_connector_set_panel_orientation() with
DRM_MODE_PANEL_ORIENTATION_UNKNOWN will be a no-op. And once the
orientation is set, the 2nd call to this is also no-op.
https://elixir.bootlin.com/linux/v5.12-rc8/source/drivers/gpu/drm/drm_conne=
ctor.c#L2182

The 1st time call to drm_connector_set_panel_orientation() has to be
prior than drm_dev_register().

Orientation is an optional property, and different dsi has different
ways to read and handle this. Eg. vlv_dsi[1], intel_dp[2], so I think
it's better to let each connector decide how to handle orientation.

[1] https://elixir.bootlin.com/linux/v5.12-rc8/source/drivers/gpu/drm/i915/=
display/vlv_dsi.c#L1632
[2] https://elixir.bootlin.com/linux/v5.12-rc8/source/drivers/gpu/drm/i915/=
display/intel_dp.c#L6488

Thanks
>
> Regards,
> Chun-Kuang.
>
> > >
> > > [    4.480976] ------------[ cut here ]------------
> > > [    4.485603] WARNING: CPU: 5 PID: 369 at drivers/gpu/drm/drm_mode_o=
bject.c:45 __drm_mode_object_add+0xb4/0xbc
> > > <snip>
> > > [    4.609772] Call trace:
> > > [    4.612208]  __drm_mode_object_add+0xb4/0xbc
> > > [    4.616466]  drm_mode_object_add+0x20/0x2c
> > > [    4.620552]  drm_property_create+0xdc/0x174
> > > [    4.624723]  drm_property_create_enum+0x34/0x98
> > > [    4.629241]  drm_connector_set_panel_orientation+0x64/0xa0
> > > [    4.634716]  boe_panel_get_modes+0x88/0xd8
> > > [    4.638802]  drm_panel_get_modes+0x2c/0x48
> > > [    4.642887]  panel_bridge_get_modes+0x1c/0x28
> > > [    4.647233]  drm_bridge_connector_get_modes+0xa0/0xd4
> > > [    4.652273]  drm_helper_probe_single_connector_modes+0x218/0x700
> > > [    4.658266]  drm_mode_getconnector+0x1b4/0x45c
> > > [    4.662699]  drm_ioctl_kernel+0xac/0x128
> > > [    4.666611]  drm_ioctl+0x268/0x410
> > > [    4.670002]  drm_compat_ioctl+0xdc/0xf0
> > > [    4.673829]  __arm64_compat_sys_ioctl+0xc8/0x100
> > > [    4.678436]  el0_svc_common+0xf4/0x1c0
> > > [    4.682174]  do_el0_svc_compat+0x28/0x3c
> > > [    4.686088]  el0_svc_compat+0x10/0x1c
> > > [    4.689738]  el0_sync_compat_handler+0xa8/0xcc
> > > [    4.694171]  el0_sync_compat+0x178/0x180
> > > [    4.698082] ---[ end trace b4f2db9d9c88610b ]---
> > > [    4.702721] ------------[ cut here ]------------
> > > [    4.707329] WARNING: CPU: 5 PID: 369 at drivers/gpu/drm/drm_mode_o=
bject.c:243 drm_object_attach_property+0x48/0xb8
> > > <snip>
> > > [    4.833830] Call trace:
> > > [    4.836266]  drm_object_attach_property+0x48/0xb8
> > > [    4.840958]  drm_connector_set_panel_orientation+0x84/0xa0
> > > [    4.846432]  boe_panel_get_modes+0x88/0xd8
> > > [    4.850516]  drm_panel_get_modes+0x2c/0x48
> > > [    4.854600]  panel_bridge_get_modes+0x1c/0x28
> > > [    4.858946]  drm_bridge_connector_get_modes+0xa0/0xd4
> > > [    4.863984]  drm_helper_probe_single_connector_modes+0x218/0x700
> > > [    4.869978]  drm_mode_getconnector+0x1b4/0x45c
> > > [    4.874410]  drm_ioctl_kernel+0xac/0x128
> > > [    4.878320]  drm_ioctl+0x268/0x410
> > > [    4.881711]  drm_compat_ioctl+0xdc/0xf0
> > > [    4.885536]  __arm64_compat_sys_ioctl+0xc8/0x100
> > > [    4.890142]  el0_svc_common+0xf4/0x1c0
> > > [    4.893879]  do_el0_svc_compat+0x28/0x3c
> > > [    4.897791]  el0_svc_compat+0x10/0x1c
> > > [    4.901441]  el0_sync_compat_handler+0xa8/0xcc
> > > [    4.905873]  el0_sync_compat+0x178/0x180
> > > [    4.909783] ---[ end trace b4f2db9d9c88610c ]---
> > >
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >
> > ping on the thread, thanks.
> >
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_dsi.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/med=
iatek/mtk_dsi.c
> > > index ae403c67cbd9..45a702ee09f3 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > @@ -205,6 +205,7 @@ struct mtk_dsi {
> > >         u32 irq_data;
> > >         wait_queue_head_t irq_wait_queue;
> > >         const struct mtk_dsi_driver_data *driver_data;
> > > +       enum drm_panel_orientation orientation;
> > >  };
> > >
> > >  static inline struct mtk_dsi *bridge_to_dsi(struct drm_bridge *b)
> > > @@ -966,6 +967,8 @@ static int mtk_dsi_encoder_init(struct drm_device=
 *drm, struct mtk_dsi *dsi)
> > >         }
> > >         drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
> > >
> > > +       drm_connector_set_panel_orientation(dsi->connector, dsi->orie=
ntation);
> > > +
> > >         return 0;
> > >
> > >  err_cleanup_encoder:
> > > @@ -1029,6 +1032,12 @@ static int mtk_dsi_probe(struct platform_devic=
e *pdev)
> > >                         ret =3D PTR_ERR(dsi->next_bridge);
> > >                         goto err_unregister_host;
> > >                 }
> > > +
> > > +               ret =3D of_drm_get_panel_orientation(panel->dev->of_n=
ode, &dsi->orientation);
> > > +               if (ret) {
> > > +                       dev_err(dev, "failed to get panel orientation=
 %d\n", ret);
> > > +                       return ret;
> > > +               }
> > >         }
> > >
> > >         dsi->driver_data =3D of_device_get_match_data(dev);
> > > --
> > > 2.31.1.295.g9ea45b61b8-goog
> > >
