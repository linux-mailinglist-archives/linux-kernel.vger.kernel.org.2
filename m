Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7C93E4146
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhHIIAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbhHIIAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:00:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C47C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 01:00:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id z20so4638787ejf.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 01:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09liQ8AeWAUmuhsIobyFZpGuppadfA5M/x17fZL+bQA=;
        b=pV1OHKgOW9VZJOADH0nrKuV28pqphGWMo1FqQ+k8pAtbMrgMntaYxUhcVX6iwluI3M
         PEh/8S8ZSR9w35cvsZSpmPibWUPJOK4q5GZzIQismOh3LppLqfJwDHW7l8v34L7MDFNY
         1zYNNGO957sDyeFEJw97/0piP+XPUXIzEpOMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09liQ8AeWAUmuhsIobyFZpGuppadfA5M/x17fZL+bQA=;
        b=lUSSxX0TWQp6Xs2PoXnb6/V8+DlLxH4ygutS1fm8VluclP49KRm+yAPAV1aLyk6lJP
         qWL+IrRPYFZbSgS50vZfL+AiRq+5AXVHKeM9yLXY7Co2bQLv2N+ieFhqYmh6Hzid+F1H
         +vQ1z7JAmJ6qOesE91sNFQlVwAZONgyTWzZskOjK6CkYBnSyfYYAP4p2Cu6SUbNE5T35
         UH+ZIi/X+N9/UiT6zOSail1aNo5Y9qtdg5kz+dmFIVybtz4RmILGVxt//vDun/4+jd6b
         dFhJFIGQjUMq3lEGbd7QpniB/gT/gXVlHYYBy7dJwzrp4pHVBl4cOTktpCvDag4XrJA3
         M1cw==
X-Gm-Message-State: AOAM530txTGHAwMqpAfa9qurEU6nFDEeYF3840Zm9RbnwBQbGEnhrmVu
        klDrTek1YXyrqXLawyRh1YGDeNJzbWhO9+8Sg3Xbyw==
X-Google-Smtp-Source: ABdhPJyJ7Mh+LlouB+AJc3TNWg5pj/eIQXNn3JEAVYq9o5fPp5qet1DHDw8U/a0GKVgaZXex8SwHG36hOytcUbg8Zp0=
X-Received: by 2002:a17:907:1691:: with SMTP id hc17mr21800230ejc.522.1628496016327;
 Mon, 09 Aug 2021 01:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210804140941eucas1p2d4d4ec491074530c714797523aec05ea@eucas1p2.samsung.com>
 <20210728133229.2247965-1-maxime@cerno.tech> <cc638e20-aa7c-7014-f70b-1bb68e629d87@samsung.com>
In-Reply-To: <cc638e20-aa7c-7014-f70b-1bb68e629d87@samsung.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 9 Aug 2021 13:30:05 +0530
Message-ID: <CAMty3ZDLM0Ap4Ni+kExEgVyFw2eQygZNeTxbWjOxvE=uduVkag@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] drm/bridge: Make panel and bridge probe order consistent
To:     "a.hajda" <a.hajda@samsung.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

On Wed, Aug 4, 2021 at 7:48 PM a.hajda <a.hajda@samsung.com> wrote:
>
> Hi Maxime,
>
> I have been busy with other tasks, and I did not follow the list last
> time, so sorry for my late response.
>
> On 28.07.2021 15:32, Maxime Ripard wrote:
> > Hi,
> >
> > We've encountered an issue with the RaspberryPi DSI panel that prevented the
> > whole display driver from probing.
> >
> > The issue is described in detail in the commit 7213246a803f ("drm/vc4: dsi:
> > Only register our component once a DSI device is attached"), but the basic idea
> > is that since the panel is probed through i2c, there's no synchronization
> > between its probe and the registration of the MIPI-DSI host it's attached to.
> >
> > We initially moved the component framework registration to the MIPI-DSI Host
> > attach hook to make sure we register our component only when we have a DSI
> > device attached to our MIPI-DSI host, and then use lookup our DSI device in our
> > bind hook.
> >
> > However, all the DSI bridges controlled through i2c are only registering their
> > associated DSI device in their bridge attach hook, meaning with our change
>
>
> I guess this is incorrect. I have promoted several times the pattern
> that device driver shouldn't expose its interfaces (for example
> component_add, drm_panel_add, drm_bridge_add) until it gathers all
> required dependencies. In this particular case bridges should defer
> probe until DSI bus becomes available. I guess this way the patch you
> reverts would work.
>
> I advised few times this pattern in case of DSI hosts, apparently I
> didn't notice the similar issue can appear in case of bridges. Or there
> is something I have missed???

Look like Maxime is correct. I2C based DSI bridge will get probe
during bridge_attach which usually called from bridge driver
bridge_attach call. Non-I2C bridges and DSI panels will get probe
during host.attach.

We do get similar situation for dw-mipi-dsi bridges, where icn6211
bridge is not I2C-based bridge and it gets probed in host_attach and
sn65dsi83 is I2C based bridge and it gets probed in bridge_attach.

Here is the simple call trace we have observed with dw-mipi-dsi bridge
when all possible DSI device are trying to probe.

1. DSI panels and bridges will invoke the host attach
   from probe in order to find the panel_or_bridge.

   chipone_probe()
       dw_mipi_dsi_host_attach().start
           dw_mipi_dsi_panel_or_bridge()
                ...found the panel_or_bridge...

   ltdc_encoder_init().start
       dw_mipi_dsi_bridge_attach().start
                   dw_mipi_dsi_host_attach().start
                       chipone_attach(). start

                       chipone_attach(). done
                   dw_mipi_dsi_host_attach().done
       dw_mipi_dsi_bridge_attach(). done
   ltdc_encoder_init().done

2. I2C based DSI bridge will invoke the drm_bridge_attach
   from bridge attach in order to find the panel_or_bridge.

   ltdc_encoder_init().start
       dw_mipi_dsi_bridge_attach().start
           dw_mipi_dsi_panel_or_bridge()
                ...found the panel_or_bridge...
                   dw_mipi_dsi_host_attach().start
                       sn65dsi83_attach(). start

                       sn65dsi83_attach(). done
                   dw_mipi_dsi_host_attach().done
       dw_mipi_dsi_bridge_attach(). done
   ltdc_encoder_init().done

It is correct that the I2C-based bridges will attach the host via
mipi_dsi_attach in driver bridge API where as it done in probe for
Non-I2C bridges and DSI panels.

>
> Anyway there are already eleven(?) bridge drivers using this pattern. I
> wonder if fixing it would be difficult, or if it expose other issues???
> The patches should be quite straightforward - move
> of_find_mipi_dsi_host_by_node and mipi_dsi_device_register_full to probe
> time.
>
> Finally I think that if we will not fix these bridge drivers we will
> encounter another set of issues with new platforms connecting "DSI host
> drivers assuming this pattern" and "i2c/dsi device drivers assuming
> pattern already present in the bridges".

Agreed, I'm trying to understand the several ways to fix this. Right
now I'm trying this on sun6i_mipi_dsi and exynos_drm_dsi. Will let you
know for any update and suggestions on the same.

Thanks,
Jagan.
