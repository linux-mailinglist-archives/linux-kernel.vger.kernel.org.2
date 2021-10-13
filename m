Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C67342BFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhJMM0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhJMM0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:26:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E16C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:24:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i20so9289548edj.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E7777Rn8WZgRU94sV32PJhBQtU2jViEmeE5HVty2A3Q=;
        b=gkLU0xHe7v0sco0mH4atHD5gjqLvOiBEbTDTg8eVphxQ0fKpOFzX/5f/Uh8ikJsd65
         UmR5u3u7El5K9JLvt9ZUpp8rhAd07E/8Kbq4XBmyMBOL8Su29vmz55E/5wB8sL6LQEXs
         CciWtkOSW0TC91Mypxj+6p8P2+elUKAiRlcHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E7777Rn8WZgRU94sV32PJhBQtU2jViEmeE5HVty2A3Q=;
        b=hyZzuQAP++CYSunhREY93t+v9QTJjCYcQ4J34V9Ns+ZPzu2zaheSADOU0IH//IoptM
         t5gsVZvkfzcvmvZMvhFdCeNpLRrplKmlCdJjKyTsrSuJi8vgvD1w2QRjgo10OP1C6YXS
         6cwZmct19xZdp+7O7JLibSFEmTchkusNqeMIpHBGjqPGGm/xYYTXhF15ICcGiPq5Tb/s
         V78FpcKtv6SriAit+W+VE1d5drxILVZ08OToYNnPixJtKLeXWhQf1tJdcLKAVHcUCni0
         SyFWIxsKrB6PsUuRaaaZUZbLL7ML/WqHB321eAtpxSswcivCOaKoiVGnssPjnOEmj6e5
         hglg==
X-Gm-Message-State: AOAM5328fK2X75R7QBM5fn0XFpOpr8gOSyTSQqTRGpj3tNs8t12MNzBz
        5mzQ5xU4aygeQp5jfUMaNCq+1OtTm7iwH6bVsC7R/A==
X-Google-Smtp-Source: ABdhPJx6ALfWBqZoheRlbNO87piva2MSM95Nsp4fqABwfziY3aBtUdnH+lJgFZNdgfuDRZRUXL7I4FtxcYqcuz4J1N4=
X-Received: by 2002:aa7:cb8a:: with SMTP id r10mr9146051edt.237.1634127887450;
 Wed, 13 Oct 2021 05:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <4d0ec577fdeb01fa232ffa743fde06129353396a.1634126587.git.agx@sigxcpu.org>
In-Reply-To: <4d0ec577fdeb01fa232ffa743fde06129353396a.1634126587.git.agx@sigxcpu.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 13 Oct 2021 17:54:36 +0530
Message-ID: <CAMty3ZAsn4K0WFRC_FNN2Mina0gSu4Nc1y1zVsoZ8GuSqcQFsA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: nwl-dsi: Move bridge add/remove to dsi callbacks
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Andrzej Hajda <andrzej.hajda@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 5:44 PM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> Move the panel and bridge_{add,remove} from the bridge callbacks to the
> DSI callbacks to make sure we don't indicate readiness to participate in
> the display pipeline before the panel is attached.
>
> This was prompted by commit fb8d617f8fd6 ("drm/bridge: Centralize error
> message when bridge attach fails") which triggered
>
>   [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@3080=
0000/mipi-dsi@30a0 0000 to encoder None-34: -517
>
> during boot.
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> ---
> This was prompted by the discussion at
> https://lore.kernel.org/dri-devel/00493cc61d1443dab1c131c46c5890f95f6f9b2=
5.1634068657.git.agx@sigxcpu.org/
>
>  drivers/gpu/drm/bridge/nwl-dsi.c | 64 ++++++++++++++++++--------------
>  1 file changed, 37 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nw=
l-dsi.c
> index a7389a0facfb..77aa6f13afef 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -355,6 +355,9 @@ static int nwl_dsi_host_attach(struct mipi_dsi_host *=
dsi_host,
>  {
>         struct nwl_dsi *dsi =3D container_of(dsi_host, struct nwl_dsi, ds=
i_host);
>         struct device *dev =3D dsi->dev;
> +       struct drm_bridge *panel_bridge;
> +       struct drm_panel *panel;
> +       int ret;
>
>         DRM_DEV_INFO(dev, "lanes=3D%u, format=3D0x%x flags=3D0x%lx\n", de=
vice->lanes,
>                      device->format, device->mode_flags);
> @@ -362,10 +365,43 @@ static int nwl_dsi_host_attach(struct mipi_dsi_host=
 *dsi_host,
>         if (device->lanes < 1 || device->lanes > 4)
>                 return -EINVAL;
>
> +       ret =3D drm_of_find_panel_or_bridge(dsi->dev->of_node, 1, 0, &pan=
el,
> +                                         &panel_bridge);
> +       if (ret)
> +               return ret;
> +
> +       if (panel) {
> +               panel_bridge =3D drm_panel_bridge_add(panel);
> +               if (IS_ERR(panel_bridge))
> +                       return PTR_ERR(panel_bridge);
> +       }
> +       if (!panel_bridge)
> +               return -EPROBE_DEFER;
> +
> +       dsi->panel_bridge =3D panel_bridge;
>         dsi->lanes =3D device->lanes;
>         dsi->format =3D device->format;
>         dsi->dsi_mode_flags =3D device->mode_flags;
>
> +       /*
> +        * The DSI output has been properly configured, we can now safely
> +        * register the input to the bridge framework so that it can take=
 place
> +        * in a display pipeline.
> +        */
> +       drm_bridge_add(&dsi->bridge);
> +
> +       return 0;
> +}
> +
> +static int nwl_dsi_host_detach(struct mipi_dsi_host *dsi_host,
> +                              struct mipi_dsi_device *dev)
> +{
> +       struct nwl_dsi *dsi =3D container_of(dsi_host, struct nwl_dsi, ds=
i_host);
> +
> +       drm_bridge_remove(&dsi->bridge);
> +       if (dsi->panel_bridge)
> +               drm_panel_bridge_remove(dsi->panel_bridge);
> +

If I'm correct this logic will failed to find the direct and I2C based
bridges. As these peripheral bridges are trying to find the bridge
device from bridge_attach unlike DSI panels are trying to find the
panel via host attach directly from probe.

Similar issue we have encounters with dw-mipi-dsi bridge.
c206c7faeb3263a7cc7b4de443a3877cd7a5e74b

Jagan.
