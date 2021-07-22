Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A0E3D1F58
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 09:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhGVHNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 03:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhGVHNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 03:13:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3103BC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 00:54:06 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id l26so5635187eda.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 00:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=heGQ4sEU/tcxYGYCH9nVmqIF3VXGFcDHuA5EFudXLOI=;
        b=buD/WBZbanBwdOA+/TO17KV/J3rYmYlKv1VLdOZDhuWbAuHHYJaHq/0xYZdYRCwvO6
         t+CpHyfb+cKkK0Lxo8VWaUu4WOgt5ymWoVG8qFP0IMXa2ViCt9NE53JGQRyUsyEFwo5f
         4rwshKRq2sOmOx9wAuOhfynJ33Tu0/Bm3MJ04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=heGQ4sEU/tcxYGYCH9nVmqIF3VXGFcDHuA5EFudXLOI=;
        b=R9KF4OrHX+O698dtwi70i2O57bLmHpTksNSpN2Jgky6v21dQb7OJYJS+YPIOIJG0zf
         E0e5W//VSTtKGAFeabcMAYz1bK+wc0I4qqVFMTksrTerTDMDXbr9QPYbfNRJficKJ29Z
         st36eFSdsNvgw1WkNDcqSYCx5/rnbdhW4iYn040V9i95bIdytqyh9vIncd8lm/5F+uxV
         1rGMZ8FmQyXP+6QYUBXtXlpfM9tGanRcrn/c9qZYk03xwSk95H8lhSB6xzXgT41PbMaS
         O21nRWrOjvbs18E9Aiz2W5ebe1J9Q3CvMHaXwpRNdCyYZWeDjZot3wMEK+DvlCjtGHr5
         y+sw==
X-Gm-Message-State: AOAM532/rCf6Ueyo67I8i0FjbGddFwHnpTPkqwfyYUAalKKa8axEe/YC
        P4arWV4Z+OR9C4fMYOHRAux1GWD3yhIfeDa6EuLWMg==
X-Google-Smtp-Source: ABdhPJywGnLozfLI+UYKok/2rOKWLwbeYIpdC4Lmv6hjc/+htpEJDm1YdNGlgyx/wnehdHFfXEzTifwl480+4uuSqTo=
X-Received: by 2002:a05:6402:144f:: with SMTP id d15mr52935243edx.27.1626940444767;
 Thu, 22 Jul 2021 00:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210720134525.563936-1-maxime@cerno.tech> <20210720134525.563936-6-maxime@cerno.tech>
In-Reply-To: <20210720134525.563936-6-maxime@cerno.tech>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 22 Jul 2021 13:23:53 +0530
Message-ID: <CAMty3ZAjxr6YCWyY_A3MGJAVPTHASQde=BQFaCfr+wWkHzO6nA@mail.gmail.com>
Subject: Re: [PATCH 05/10] drm/panel: Create attach and detach callbacks
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, Jul 20, 2021 at 7:15 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> In order to make the probe order expectation more consistent between
> bridges, let's create attach and detach hooks for the panels as well to
> match what is there for bridges.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/drm_panel.c | 20 ++++++++++++++++++++
>  include/drm/drm_panel.h     |  6 ++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index f634371c717a..23bca798a2f3 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -223,6 +223,26 @@ int drm_panel_get_modes(struct drm_panel *panel,
>  }
>  EXPORT_SYMBOL(drm_panel_get_modes);
>
> +int drm_panel_attach(struct drm_panel *panel)
> +{
> +       if (!panel)
> +               return -EINVAL;
> +
> +       if (panel->funcs && panel->funcs->attach)
> +               return panel->funcs->attach(panel);
> +
> +       return -EOPNOTSUPP;

Most of the panel drivers won't require panel attach/detach API's so
we need to handle those cases as well if we didn't already.

Thanks,
Jagan.
