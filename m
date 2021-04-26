Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1858036ABCF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 07:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhDZFVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 01:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDZFVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 01:21:06 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F174C061756
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 22:20:25 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id q25so11284974iog.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 22:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpMkjz9KyykiFO6l5ZQQuINgIfMM9OaiAAxRnjrTqLo=;
        b=diwNewPbdQFBq8nbfkdx9BlVdn6q+QQ7rkY5vw2F1FJFAl9k5Sx3CJGLUbm8kEplp1
         pKV4i/aMsoZXuMwyoElTvs0J6OWy9/je+pyvdyU40uSSP2iAOhtOnWp73VtHbaYdOvF5
         /almRjcvW7teXIf1nHh/cuafbPEmiyXMjiWfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpMkjz9KyykiFO6l5ZQQuINgIfMM9OaiAAxRnjrTqLo=;
        b=iE8z0bRPylnTrOOiysYqIv/N0CZHK3du5g1EgptFvHWrD2Xh3Ur7NJOKRxhYPud1Yw
         RiWnUTOu4AK1eKNa/LjMX25QHlTzDKh/I79ndeU70Qs/g3SlUl4nTXA+MR0O+MwxFs80
         ZuSG2XM9p5336DQc3OM2CPZm+9TQFEIcnhE+9wuc4MQXWVI1q4KQEXlb7vz6+us66pdr
         C6EUrrQSrxWbSVzWCxAyd55Ed+JuUSwOJj8rSe8ZqSU52Fwtey3GmUjFrtSN0kCdhE/d
         +o8+XgqJ5A85Z/HIuSK5sKAYBMFFFfmTeCuFBay+cH8t7vAFASqWQjFw3RDdGh5gyaJh
         lPTg==
X-Gm-Message-State: AOAM5326vrKGzRXjsqoSUw4ieOHQAw0lhywjLzS6GXYPOZcPEqQtL+sx
        vvQHvxhZHVg8TJ9HjieJJtiZbzo3P3H/GADwsjkLCQ==
X-Google-Smtp-Source: ABdhPJzl+nlI65EpIE3bLCS7G3KC95MAVHm0nvQs80CqTwdYNWAv1l/fLJqKJxUcdszePkWtP+JyptF55LMMQziX0SY=
X-Received: by 2002:a02:a40a:: with SMTP id c10mr14239901jal.98.1619414424923;
 Sun, 25 Apr 2021 22:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210409045314.3420733-1-hsinyi@chromium.org> <CAMavQKJUpYP8jo2JDGMYNBGtbPSSO7z9BAComm5JQoty=HPtJg@mail.gmail.com>
In-Reply-To: <CAMavQKJUpYP8jo2JDGMYNBGtbPSSO7z9BAComm5JQoty=HPtJg@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 26 Apr 2021 13:19:59 +0800
Message-ID: <CAJMQK-govRgDfKhzxhe-GPBQ27EEfpmsxbbNH6X=6CTni=uqRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/mediatek: set panel orientation before drm_dev_register().
To:     Sean Paul <sean@poorly.run>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 9:53 PM Sean Paul <sean@poorly.run> wrote:
>
> On Fri, Apr 9, 2021 at 12:53 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > drm_dev_register() sets connector->registration_state to
> > DRM_CONNECTOR_REGISTERED and dev->registered to true. If
> > drm_connector_set_panel_orientation() is first called after
> > drm_dev_register(), it will fail several checks and results in following
> > warning. So set panel orientation in dsi before drm_dev_register() is
> > called.
> >
> > [    4.480976] ------------[ cut here ]------------
> > [    4.485603] WARNING: CPU: 5 PID: 369 at drivers/gpu/drm/drm_mode_object.c:45 __drm_mode_object_add+0xb4/0xbc
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
> > [    4.707329] WARNING: CPU: 5 PID: 369 at drivers/gpu/drm/drm_mode_object.c:243 drm_object_attach_property+0x48/0xb8
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
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
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
> > @@ -966,6 +967,8 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
> >         }
> >         drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
> >
> > +       drm_connector_set_panel_orientation(dsi->connector, dsi->orientation);
> > +
> >         return 0;
> >
> >  err_cleanup_encoder:
> > @@ -1029,6 +1032,12 @@ static int mtk_dsi_probe(struct platform_device *pdev)
> >                         ret = PTR_ERR(dsi->next_bridge);
> >                         goto err_unregister_host;
> >                 }
> > +
> > +               ret = of_drm_get_panel_orientation(panel->dev->of_node, &dsi->orientation);
> > +               if (ret) {
> > +                       dev_err(dev, "failed to get panel orientation %d\n", ret);
> > +                       return ret;
> > +               }
>
> I don't think this is the right place to mine orientation since it
> duplicates the call from the panel driver.
>
> Instead, how about splitting out
> property_create_enum/attach_orientation_property from
> set_panel_orientation such that you can attach the property (with
> UNKNOWN value) in the connector init and then leave the panel to set
> it properly in get_modes (I kind of disagree with populating this in
> get_modes as well, but I don't think there's anywhere else to stick it
> right now)?
>
> AFAICT orientation is the only property which has the create/attach
> calls in the set function which seems like a perfect recipe for this
> type of failure.
>
>
> Sean
>

Thanks for the review. It is updated in v2.

> >         }
> >
> >         dsi->driver_data = of_device_get_match_data(dev);
> > --
> > 2.31.1.295.g9ea45b61b8-goog
> >
