Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493883654C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 11:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhDTJGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 05:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhDTJGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:06:06 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C67C061763
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 02:05:34 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b9so7995285iod.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sky0InoRGfz08ZIPfmMoicP8h0LTiiMAffpNGDgYJbs=;
        b=nXMxTLh0sKp6GpxETText2EprCJ00h2r68bNjyo/IF5LUKD5vBUWvHwARRPAn+uyrJ
         kQjDZ0KCSUQEIki+oYck1Elb/FO48FaV2LtgbHDizELXrrlpNqUAtUVQ5tTUE9mHKyB5
         ZbQXnv+ZIdsOqZz8tjBc7JlTrPQwcxVciypAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sky0InoRGfz08ZIPfmMoicP8h0LTiiMAffpNGDgYJbs=;
        b=b+s+7+wybV8S4+750opi2FoGVttJHTzxO2qJ1GnqNuG25JvsvXVFhNoIKg4OMTOaM3
         P0W/5ry8uflVZAEBrezwSvxgo4BtUaU+UclG2e3yXleiBTFYVOwYrjGB1oJaiRozmZtc
         rTamtDn4+SdRUT9LhL4eOezcovrx4GzoaAt7UbJ02cKwj/4/cEo9fu3Zb6JgKmKNZJJ6
         2PcvkM/fKU6lzhpfxByyhEzzfv6sr6WoUoWqKf/YHuPBOx4MrWs79YNRwqi4oPMbi2NY
         F/gCwglaX9TCRhwclpJ2DTylOFRpWhV81R3SrP+jt4zXSrvtntQtBIxkz0k1UHY9bqhU
         6Wkg==
X-Gm-Message-State: AOAM531RT7OJYRWbOkSP2cxxir1IfEw5HFFGAKShHnEdh0fK3L9o1gqe
        QhQO4Bgsgi2oseFnZmHO4t5WIvYTRuitMvmOPRWfoQ==
X-Google-Smtp-Source: ABdhPJzFCTPxONwGXoOnArB99NKE78wLC243d0eUdaQKA1eYD2nbVDr80hIVXEpRVLb15Vj/6o9+Igu1fSkXz87MjDc=
X-Received: by 2002:a5d:9682:: with SMTP id m2mr18657371ion.20.1618909533198;
 Tue, 20 Apr 2021 02:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210409045314.3420733-1-hsinyi@chromium.org>
In-Reply-To: <20210409045314.3420733-1-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 20 Apr 2021 17:05:06 +0800
Message-ID: <CAJMQK-gFk8WV0W2TTP7=OTsBqgWmy_eKSd42Xa5dJzvUFDTAXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/mediatek: set panel orientation before drm_dev_register().
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 12:53 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> drm_dev_register() sets connector->registration_state to
> DRM_CONNECTOR_REGISTERED and dev->registered to true. If
> drm_connector_set_panel_orientation() is first called after
> drm_dev_register(), it will fail several checks and results in following
> warning. So set panel orientation in dsi before drm_dev_register() is
> called.
>
> [    4.480976] ------------[ cut here ]------------
> [    4.485603] WARNING: CPU: 5 PID: 369 at drivers/gpu/drm/drm_mode_object.c:45 __drm_mode_object_add+0xb4/0xbc
> <snip>
> [    4.609772] Call trace:
> [    4.612208]  __drm_mode_object_add+0xb4/0xbc
> [    4.616466]  drm_mode_object_add+0x20/0x2c
> [    4.620552]  drm_property_create+0xdc/0x174
> [    4.624723]  drm_property_create_enum+0x34/0x98
> [    4.629241]  drm_connector_set_panel_orientation+0x64/0xa0
> [    4.634716]  boe_panel_get_modes+0x88/0xd8
> [    4.638802]  drm_panel_get_modes+0x2c/0x48
> [    4.642887]  panel_bridge_get_modes+0x1c/0x28
> [    4.647233]  drm_bridge_connector_get_modes+0xa0/0xd4
> [    4.652273]  drm_helper_probe_single_connector_modes+0x218/0x700
> [    4.658266]  drm_mode_getconnector+0x1b4/0x45c
> [    4.662699]  drm_ioctl_kernel+0xac/0x128
> [    4.666611]  drm_ioctl+0x268/0x410
> [    4.670002]  drm_compat_ioctl+0xdc/0xf0
> [    4.673829]  __arm64_compat_sys_ioctl+0xc8/0x100
> [    4.678436]  el0_svc_common+0xf4/0x1c0
> [    4.682174]  do_el0_svc_compat+0x28/0x3c
> [    4.686088]  el0_svc_compat+0x10/0x1c
> [    4.689738]  el0_sync_compat_handler+0xa8/0xcc
> [    4.694171]  el0_sync_compat+0x178/0x180
> [    4.698082] ---[ end trace b4f2db9d9c88610b ]---
> [    4.702721] ------------[ cut here ]------------
> [    4.707329] WARNING: CPU: 5 PID: 369 at drivers/gpu/drm/drm_mode_object.c:243 drm_object_attach_property+0x48/0xb8
> <snip>
> [    4.833830] Call trace:
> [    4.836266]  drm_object_attach_property+0x48/0xb8
> [    4.840958]  drm_connector_set_panel_orientation+0x84/0xa0
> [    4.846432]  boe_panel_get_modes+0x88/0xd8
> [    4.850516]  drm_panel_get_modes+0x2c/0x48
> [    4.854600]  panel_bridge_get_modes+0x1c/0x28
> [    4.858946]  drm_bridge_connector_get_modes+0xa0/0xd4
> [    4.863984]  drm_helper_probe_single_connector_modes+0x218/0x700
> [    4.869978]  drm_mode_getconnector+0x1b4/0x45c
> [    4.874410]  drm_ioctl_kernel+0xac/0x128
> [    4.878320]  drm_ioctl+0x268/0x410
> [    4.881711]  drm_compat_ioctl+0xdc/0xf0
> [    4.885536]  __arm64_compat_sys_ioctl+0xc8/0x100
> [    4.890142]  el0_svc_common+0xf4/0x1c0
> [    4.893879]  do_el0_svc_compat+0x28/0x3c
> [    4.897791]  el0_svc_compat+0x10/0x1c
> [    4.901441]  el0_sync_compat_handler+0xa8/0xcc
> [    4.905873]  el0_sync_compat+0x178/0x180
> [    4.909783] ---[ end trace b4f2db9d9c88610c ]---
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

ping on the thread, thanks.

> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index ae403c67cbd9..45a702ee09f3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -205,6 +205,7 @@ struct mtk_dsi {
>         u32 irq_data;
>         wait_queue_head_t irq_wait_queue;
>         const struct mtk_dsi_driver_data *driver_data;
> +       enum drm_panel_orientation orientation;
>  };
>
>  static inline struct mtk_dsi *bridge_to_dsi(struct drm_bridge *b)
> @@ -966,6 +967,8 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
>         }
>         drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
>
> +       drm_connector_set_panel_orientation(dsi->connector, dsi->orientation);
> +
>         return 0;
>
>  err_cleanup_encoder:
> @@ -1029,6 +1032,12 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>                         ret = PTR_ERR(dsi->next_bridge);
>                         goto err_unregister_host;
>                 }
> +
> +               ret = of_drm_get_panel_orientation(panel->dev->of_node, &dsi->orientation);
> +               if (ret) {
> +                       dev_err(dev, "failed to get panel orientation %d\n", ret);
> +                       return ret;
> +               }
>         }
>
>         dsi->driver_data = of_device_get_match_data(dev);
> --
> 2.31.1.295.g9ea45b61b8-goog
>
