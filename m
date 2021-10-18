Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DC6432896
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 22:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhJRUqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 16:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhJRUqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 16:46:11 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F54C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:43:59 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id o184so5849648iof.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qi8NOFsLDDab/yOpN0XP104qJcqwkCAnAmt6gilG+5I=;
        b=aciretGC6a6ALhm0FgbvurjyzW+NP25atSOa2ypM1Tu3vG/GPjqL3nTovQyoM1Mq7p
         zYtqmKvmD/GVQ64+KAfuiUJogEVeMnqVVfe8v2aYnRwnXKhfKqtZmdKcyw94d5vp4YWa
         DH8wIR0mZ7Ew2wqZBFPO8kwIW31TMM3tiOxMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qi8NOFsLDDab/yOpN0XP104qJcqwkCAnAmt6gilG+5I=;
        b=ciR4zGljgjnDdHCYupof4ReI0htwbjYfELD01CO6cyy4AqCA9IecArmZ93ef+mpy9P
         n4Yt+P4WMXbbZVG+ETJiRSVDTAPzzo6aDzocaD1iNgvFi6Ni8Tjj7t2XJKpW/xTUFHEa
         PQ5dry4QXiu0A5BhPnmIIF996GhbnuR7LFJ2K9aQmTiRGTLjnzZp0lutkDMLzQVFBY7F
         klZ2rvAJfm59FY3shR+fuo3NbFVTUF6ftI7sRP0VnhSRpPqNxeT/lpmgtZHWz60Je9tR
         QY41PZwLlQCsO46aebrAJsY1Gt6tYiCrmKCcHU2a+6ckeWJNJzPr8P8uf7vtWajtKs/O
         mGHA==
X-Gm-Message-State: AOAM5304hvhzKKgRdX4v0WT3xTUAxT09KXpDbgV6PBzC2MIAR8hiGtFl
        mKVRGuDSBYfSVRtamo3VuZVZD/KWYlWZKg==
X-Google-Smtp-Source: ABdhPJwfUSmykS0oroj3Fm+vKjR1nEkW6Het5QZrE0tE3mPXky+NDimEqkzOb11d+zt1yE+oRR2zBQ==
X-Received: by 2002:a02:ad05:: with SMTP id s5mr1398235jan.65.1634589838650;
        Mon, 18 Oct 2021 13:43:58 -0700 (PDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id a4sm7567385ild.52.2021.10.18.13.43.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 13:43:58 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id j8so16213529ila.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:43:57 -0700 (PDT)
X-Received: by 2002:a05:6e02:17ce:: with SMTP id z14mr15289996ilu.120.1634589837544;
 Mon, 18 Oct 2021 13:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211016095644.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
 <20211016095644.2.I44ee57ef73528243acf8f29af8d2416b810e1a9d@changeid>
In-Reply-To: <20211016095644.2.I44ee57ef73528243acf8f29af8d2416b810e1a9d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Oct 2021 13:43:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XXOY_Rded_j6oysDkZ=e7_Gc1SPKPbkLK2DBdoKHWuKA@mail.gmail.com>
Message-ID: <CAD=FV=XXOY_Rded_j6oysDkZ=e7_Gc1SPKPbkLK2DBdoKHWuKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: parade-ps8640: Populate devices on aux-bus
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 16, 2021 at 9:57 AM Philip Chen <philipchen@chromium.org> wrote:
>
> Conventionally, panel is listed under the root in the device tree.
> When userland asks for display mode, ps8640 bridge is responsible
> for returning EDID when ps8640_bridge_get_edid() is called.
>
> Now enable a new option of listing the panel under "aux-bus" of ps8640
> bridge node in the device tree. In this case, panel driver can retrieve
> EDID by triggering AUX transactions, without ps8640_bridge_get_edid()
> calls at all.
>
> To prevent the "old" and "new" options from interfering with each
> other's logic flow, disable DRM_BRIDGE_OP_EDID when the new option
> is taken.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 52 ++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index acfe1bf0f936..98884f799ea8 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -14,6 +14,7 @@
>  #include <linux/regulator/consumer.h>
>
>  #include <drm/drm_bridge.h>
> +#include <drm/drm_dp_aux_bus.h>

You need a `select DRM_DP_AUX_BUS` in the Kconfig to avoid the errors
that the build robot found for you.


>  #include <drm/drm_dp_helper.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_of.h>
> @@ -149,6 +150,24 @@ static inline struct ps8640 *aux_to_ps8640(struct drm_dp_aux *aux)
>         return container_of(aux, struct ps8640, aux);
>  }
>
> +static bool ps8640_of_panel_on_aux_bus(struct device *dev)
> +{
> +       struct device_node *bus, *panel;
> +
> +       if (!dev->of_node)
> +               return false;

You probably don't need the above check. I think things would be
pretty broken if we didn't have an "of_node".


> +       bus = of_get_child_by_name(dev->of_node, "aux-bus");
> +       if (!bus)
> +               return false;
> +
> +       panel = of_get_child_by_name(bus, "panel");

of_node_put(bus);


> +       if (!panel)
> +               return false;

of_node_put(panel);


Other than the above, this looks reasonable to me.

-Doug
