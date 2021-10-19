Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3C3433279
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhJSJkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbhJSJkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:40:35 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEC1C061745
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:38:23 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s136so15589493pgs.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FmZwwurzHUIgzog1mbj4L9gUB3DIhNbg7RscBTn6OoM=;
        b=WyH//UHrgcnR42KDwu/l6zEOk0qExpjbMQ0Pn5rH2+ifefhuNxf7Av9Jw8lJavvn3q
         zceyGUfXcu6kMhgdfnpYLK6Q3KgkMSdBNuHoOdBp/agB0LwXdgT3fR0qHqHxdNldStbn
         XtRjboBsRrCTUIEiNp7MTITB5Ugym/VxfL4iDoK4tBc2MxqA36VpzNxmTIrQ5u5CBVik
         laZp74RctWJ7lY59dTgvLyfqXFaXr/snUWMEAxOsa51zINI9ik6YvU7qUyQv/Q6ExUgN
         2/DTzH0jenlIjJUXED2SqNlA8OqG/DhCHa1Vv8LOqnl51Uw9Jhn5IIcOHUu8XAj7NVCT
         MNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmZwwurzHUIgzog1mbj4L9gUB3DIhNbg7RscBTn6OoM=;
        b=oQ9svfGOAOe5ms6+7VGaaPDlLxcpVVqfsicgzOI+4SFI+OsSC+x4hhq7pLSkJE5Yah
         VJJK3sMi0ENp9ZBXgKDSaGsZfZRDT4FFpn7z5mOHSxvxPHPFAy0JZCpuSdKMWUA1MoUi
         9AXo2I+FFn9V10NEgEl938NnBzCDiVyZeHZsOmH3btRJoeZS+K6AxYMzojAhvMjugZit
         1zdbuZdllgb+OIdc8XOoTp5bC8HHQmfv0aFh/O0t82mm2NjDNhVbWODXMNOcwbKoA6FY
         6TGQ7wy5CSt/h+1I3DmepF4FMQhnaWU50z4QgupZGZ/tcks25OQcws7PoHGd0lTSucXl
         lrZQ==
X-Gm-Message-State: AOAM530OnT6gSK9IF5fDuBKqESYKljLa8ZrKMZrKkFSGAD0+wnYA0244
        zV0o8Wn2LlJ3a78KiYHh9DMWgeScGoO3RV9NxjD1Xg==
X-Google-Smtp-Source: ABdhPJwAa5Tkb1+PY4gY9OfoU4QL7eAw3O6I0M/OFPLc5LvmUh3TBaJ+WIXX7r5Nq/4I0WZ4dUVwzv2cpAZw3WjZxWI=
X-Received: by 2002:a63:b708:: with SMTP id t8mr6585637pgf.410.1634636302940;
 Tue, 19 Oct 2021 02:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211002233447.1105-1-digetx@gmail.com> <20211002233447.1105-6-digetx@gmail.com>
In-Reply-To: <20211002233447.1105-6-digetx@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 19 Oct 2021 11:38:12 +0200
Message-ID: <CAG3jFytesDqy8B43VWL46_47sOWkisrp7ytF33X2aU6wP=mjoQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] drm/bridge: tc358768: Correct BTACNTRL1 programming
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Oct 2021 at 01:35, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> TXTAGOCNT and RXTASURECNT bitfields of BTACNTRL1 register are swapped in
> the code, correct them. Driver doesn't implement low power mode for now,
> so this change doesn't make a practical difference yet.
>
> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # Asus TF700T
> Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> #TF700T
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index cfceba5ef3b8..fd585bf925fe 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -790,7 +790,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>         val = tc358768_ns_to_cnt(val, dsibclk_nsk) - 1;
>         val2 = tc358768_ns_to_cnt(tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk),
>                                   dsibclk_nsk) - 2;
> -       val |= val2 << 16;
> +       val = val << 16 | val2;
>         dev_dbg(priv->dev, "BTACNTRL1: 0x%x\n", val);
>         tc358768_write(priv, TC358768_BTACNTRL1, val);
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
