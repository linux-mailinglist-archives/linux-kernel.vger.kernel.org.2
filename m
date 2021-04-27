Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7EF36BEAD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 06:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhD0Ez6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 00:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhD0Ez5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 00:55:57 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC366C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 21:55:14 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id c3so2403598ils.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 21:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c7CMAWsTHJS5ZlKrtLT8/uKd+9sVCrhwy4eEIxaMid4=;
        b=Jy1LOHSpBw+Gdy/cEYT4HVMp8f/HSRE/jJW5fCpgHCD+8NPLOxUTlCPrtVWW8gEVpB
         Kmr0gDqGtFOZOtMjzyrKL1DU9NTiTityLU17Oq55mU8yeQ8MgWhqkTnBdfk6n3BgHYL2
         Mocjxbr9FKaGx2AL3CNs5PStsAPEsux3K5irE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c7CMAWsTHJS5ZlKrtLT8/uKd+9sVCrhwy4eEIxaMid4=;
        b=fWOgXdMcOs/M6+rBMSQyfxXRT94ECFxmqoCWUrPNNEgNeLyKpqx3ls5VkH01HeI0/O
         1oGnl7GGl4uR0uRf/Q11+IX3uiTih9hAnBb5o7c2d0imIiJ75p7XEAtPO9slEazx7HZ2
         Qv5XBNntQj1cnqP1Ug5i0XUXR5s4onsCtVyL8LMhMS6rshQyrmSecRXra3j0R3Xs42t8
         J88vbXasvgVQgMV7k87p7xC1wesLszhqKZ94EVLD2cQ4u2YpaoXkSXStkUeZQJt+q3m8
         4lCqdOy+xrTjscbdUdwHjp4eikUY/U/cHvP58/nTvmJq5yi2nukR99BROyyu1R7aS4qg
         gjnQ==
X-Gm-Message-State: AOAM533aV4tDFucr6xNcXnuCTk5iyl/mGCV8jpIrSg5qH4xgeySnFG4o
        EzGG2wAzdVUnpBgeHX5r0i5A9jommIHNAG54OF8dRg==
X-Google-Smtp-Source: ABdhPJxOAKxZrgMvTG0BSiji50CJBHZX2VLbCR6qSQamlJaoMFoDUX0DCKnZA9uTm1Ff2Fzj+vNKQpyrQ1aSeUp9nHM=
X-Received: by 2002:a05:6e02:1282:: with SMTP id y2mr17160988ilq.308.1619499313996;
 Mon, 26 Apr 2021 21:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210426051848.2600890-1-hsinyi@chromium.org> <YIbdPqolop6cBnYH@intel.com>
In-Reply-To: <YIbdPqolop6cBnYH@intel.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 27 Apr 2021 12:54:47 +0800
Message-ID: <CAJMQK-hKew8RyEJ=e3upUCC-qFaeZE=jLiJdOpv5gw6izwdeCQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpu: drm: init set panel orientation property earlier
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Paul <sean@poorly.run>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:33 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Mon, Apr 26, 2021 at 01:18:47PM +0800, Hsin-Yi Wang wrote:
> > drm_dev_register() sets connector->registration_state to
> > DRM_CONNECTOR_REGISTERED and dev->registered to true. If
> > drm_connector_set_panel_orientation() is first called after
> > drm_dev_register(), it will fail several checks and results in followin=
g
> > warning.
> >
> > Create panel orientation property in drm_connector_init()
> > and set default value to UNKNOWN. Let the panel set the real value
> > later.
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
> > ---
> > v1:
> > https://patchwork.kernel.org/project/linux-mediatek/patch/2021040904531=
4.3420733-1-hsinyi@chromium.org/
> > ---
> >  drivers/gpu/drm/drm_connector.c | 28 +++++++++++++++-------------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_conn=
ector.c
> > index 7631f76e7f34..a1acb4af0ef4 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -303,6 +303,10 @@ int drm_connector_init(struct drm_device *dev,
> >                                  config->tile_property,
> >                                  0);
> >
> > +     drm_object_attach_property(&connector->base,
> > +                                config->panel_orientation_property,
> > +                                DRM_MODE_PANEL_ORIENTATION_UNKNOWN);
> > +
>
> A bit silly to add this to every connector. I think you should just
> fix the driver/bridge stuff to set up the orientaion earlier.
>

v3 is sent: https://patchwork.kernel.org/project/linux-mediatek/patch/20210=
427044948.12596-1-hsinyi@chromium.org/
Create a function to init this property so that drivers can call this
after connector init. Panel can set the value later.

> >       if (drm_core_check_feature(dev, DRIVER_ATOMIC)) {
> >               drm_object_attach_property(&connector->base, config->prop=
_crtc_id, 0);
> >       }
> > @@ -1210,7 +1214,7 @@ static const struct drm_prop_enum_list dp_colorsp=
aces[] =3D {
> >   *   INPUT_PROP_DIRECT) will still map 1:1 to the actual LCD panel
> >   *   coordinates, so if userspace rotates the picture to adjust for
> >   *   the orientation it must also apply the same transformation to the
> > - *   touchscreen input coordinates. This property is initialized by ca=
lling
> > + *   touchscreen input coordinates. This property value is set by call=
ing
> >   *   drm_connector_set_panel_orientation() or
> >   *   drm_connector_set_panel_orientation_with_quirk()
> >   *
> > @@ -1298,6 +1302,14 @@ int drm_connector_create_standard_properties(str=
uct drm_device *dev)
> >               return -ENOMEM;
> >       dev->mode_config.hdr_output_metadata_property =3D prop;
> >
> > +     prop =3D drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
> > +                                     "panel orientation",
> > +                                     drm_panel_orientation_enum_list,
> > +                                     ARRAY_SIZE(drm_panel_orientation_=
enum_list));
> > +     if (!prop)
> > +             return -ENOMEM;
> > +     dev->mode_config.panel_orientation_property =3D prop;
> > +
> >       return 0;
> >  }
> >
> > @@ -2205,19 +2217,9 @@ int drm_connector_set_panel_orientation(
> >       info->panel_orientation =3D panel_orientation;
> >
> >       prop =3D dev->mode_config.panel_orientation_property;
> > -     if (!prop) {
> > -             prop =3D drm_property_create_enum(dev, DRM_MODE_PROP_IMMU=
TABLE,
> > -                             "panel orientation",
> > -                             drm_panel_orientation_enum_list,
> > -                             ARRAY_SIZE(drm_panel_orientation_enum_lis=
t));
> > -             if (!prop)
> > -                     return -ENOMEM;
> > -
> > -             dev->mode_config.panel_orientation_property =3D prop;
> > -     }
> >
> > -     drm_object_attach_property(&connector->base, prop,
> > -                                info->panel_orientation);
> > +     drm_object_property_set_value(&connector->base, prop,
> > +                                   info->panel_orientation);
> >       return 0;
> >  }
> >  EXPORT_SYMBOL(drm_connector_set_panel_orientation);
> > --
> > 2.31.1.498.g6c1eba8ee3d-goog
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
