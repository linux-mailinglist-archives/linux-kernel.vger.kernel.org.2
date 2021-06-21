Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BD73AEDDC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhFUQXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 12:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhFUQWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:22:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CE2C061787
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:18:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r9so20337323wrz.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tthdio2toNyiWcsxLuaNlU3sKk9Qswk6j48qKJdhloI=;
        b=qhaDLDHPMGDuCgFJBo3YwN8uNEPEWZV2c8hfOhY43wO4SjlCDHZbid9svB4Gj0YIBE
         5O6NfI+Zl7C4EkEoX2fiGureZkOzLPH8OL1WybeNAF2VACmyWpc8+8lTEGPQ4XyIvZB0
         XnxVezcTlsuJ8I4Cdna18yDM9csRjqh7z0MSwNZ+Pp2HaaiayBGTTwZ76n3vXMqehkWl
         COxak8LopA4zbC0Q2VwwTdO3oZZ99o7FjBwrwXx0+ZsZpCjhML4UaMF5Zvu6MHcLm2/+
         9AMOckO1zN/XeMPQGhCEi7QZ/YRN5NJXZNA+moDsb1Z4IWeNhLxEnvlYAENdjeppBf9N
         wywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tthdio2toNyiWcsxLuaNlU3sKk9Qswk6j48qKJdhloI=;
        b=QkcLuuBqsmnyxa5Ui6X3E46CiPcttzqhuZS2EiaH16zfwhTAYOaXCdPV3stuMkuhAo
         zuXkxQ7OhVUIkivDQZ+0mcNcRVDRBA3QySRX6X2mfMkIEluxEwia/JvCFNk6bq8J03Cy
         GhUK1A7vYMK8CbO0SsR8hJQV0F2W1H9CIva7cT0IvpyB9rqQThh1uwohLXigTs/moWGC
         WQHX45DLGZDekUv0ADgaMpkDEV+2c/qjfR9l4gCaaVEDm8wGcV7jXNFRkvikTFqbCV4B
         RrlaS982stWc9+0RBuQuAnccBvA8/+SKG6sFvjmL0x5lqcFOqwJZbP7W+wEc2qw+QUy0
         kmQQ==
X-Gm-Message-State: AOAM530F7HCSYGPKHvq8YUrtOXp7eVhCtZuRiwqPKBIZwuykt5dbme4t
        +Zs6uWjoNZpHAKfR6TLEcx/L9mDXYvJgg1lfvSQkFQ==
X-Google-Smtp-Source: ABdhPJxfKgsLbD4mBF8xFTkaIH9Jnw9ynEp+yGhuiV13D4JlBQx5v9mfFu1UDaDERTmS2+WQtGjJYV+GeqnCMJ0Efic=
X-Received: by 2002:a5d:59a5:: with SMTP id p5mr28448027wrr.27.1624292319231;
 Mon, 21 Jun 2021 09:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200707101912.571531-1-maxime@cerno.tech> <YM6dgVb12oITNfc0@pendragon.ideasonboard.com>
 <20210621160517.5fptdj4tkbzgqn76@gilmour>
In-Reply-To: <20210621160517.5fptdj4tkbzgqn76@gilmour>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Mon, 21 Jun 2021 17:18:22 +0100
Message-ID: <CAPY8ntA0dsNwiyEiSHR7AuL1ESyPvTpKWAAg=MK3Gx9HKhq5qg@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: dsi: Only register our component once a DSI
 device is attached
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Tim Gover <tim.gover@raspberrypi.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Mon, 21 Jun 2021 at 17:05, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Laurent,
>
> On Sun, Jun 20, 2021 at 04:44:33AM +0300, Laurent Pinchart wrote:
> > Hi Maxime,
> >
> > I'm testing this, and I'm afraid it causes an issue with all the
> > I2C-controlled bridges. I'm focussing on the newly merged ti-sn65dsi83
> > driver at the moment, but other are affected the same way.
> >
> > With this patch, the DSI component is only added when the DSI device is
> > attached to the host with mipi_dsi_attach(). In the ti-sn65dsi83 driver,
> > this happens in the bridge attach callback, which is called when the
> > bridge is attached by a call to drm_bridge_attach() in vc4_dsi_bind().
> > This creates a circular dependency, and the DRM/KMS device is never
> > created.
>
> We discussed it on IRC, but it makes more sense here.
>
> The thing is, that patch is fixing a circular dependency we discussed
> with Andrzej a year ago:
>
> https://lore.kernel.org/dri-devel/20200630132711.ezywhvoiuv3swo57@gilmour.lan/
>
> It seems like we have to choose between having the panels or bridges
> working :/

The Pi panel using the panel-raspberrypi-touchscreen driver is flawed
as it controls the power to the FT5406 touchscreen element as well as
the display. If DRM powers down the display, power goes to the
touchscreen too, but the edt-ft5x06 touchscreen driver has no notion
of this :-(

The two parts have been broken into bridge/tc358762 and
regulator/rpi-panel-attiny-regulator which then allows the edt-ft5x06
driver to keep control over power. I haven't had it be 100% reliable
though, so I'm still investigating as time allows, but this seems like
the better solution than panel-raspberrypi-touchscreen.

With the tc358762 node back under the DSI host node, I think that
circular dependency you were trying to solve goes away.
However with sn65dsi83 being I2C configured, is that an issue again?

  Dave
