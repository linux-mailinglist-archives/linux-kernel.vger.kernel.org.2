Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4A33CBB78
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhGPSA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 14:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhGPSAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:00:24 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32254C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 10:57:29 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g5so16121249ybu.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQW3GGc/1Va1cw3Bpau5ZzEZ6iztReFZLNyywqfViAs=;
        b=qkIpcDi1geFjKktjDaAp51kJDJviDb35yb5ScOgyz6eSvgZuroCOM6dUpRPh8xQEeq
         CCMsdN1Wp2vM0FajpRCOte8J/rAmVJtCkL2Dvhebq+Q4KMSIryqkppgz/w3UujN6+i6n
         1GMMLT8Nm7sFFbgIXslTnDwwhktX8trtzbLxRTUQc1dtHrvKQRo2EiuAquCgX1wvBO7Y
         EH5JkzplO1XELeHghHWcZLgwINaxoxjtAN0oZlD7xJl2QOno5Ji9EHad5Lhmd3/ovfJG
         borYWL0kmhsUinq8z5h1vl0deKAq58dv+W4CGZoMZUN/0Y6uR7qqNx0riYLblc+QrIEj
         3y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQW3GGc/1Va1cw3Bpau5ZzEZ6iztReFZLNyywqfViAs=;
        b=puaKdjM+SfAjwBQnTQBFXzMvUGZ+tnDfKTkpGpPgyBHzYoEPGFfNxrB1D+Kk8/HWAo
         /fkkvdLFzCUGO9aDTEmmMGK/Pb5/E0PXhw0T8inhPDPSdqSlBkCvT3ocxwZH7nLorzIZ
         10rOcK9nCbJbTccGxrzendH3Yz0Uk+zDyQmL1NcCgYiztDkGbL5M1E9AAv6g9iTO8nTW
         cQ9bbEjTCiV8BiGPPGKgvEIq7QKcogcBLo/qcQaKvAat8NDNWacu2EIvGh1pdeTs76D7
         NivLwwiMcnTvBl8XZeiCQAELi/j/YP1Y/0soSuI3setUwXNhOkRprFejdNlr/XM+yP6K
         O5oA==
X-Gm-Message-State: AOAM533ZqULWBNdKyaRAjly68loR1OORwQfPxQcOjYhoWebl6jT3LSgW
        qzSjN9RQ6wBzNj8AizPF8oPCj3ciZJsCEq5jvds++g==
X-Google-Smtp-Source: ABdhPJx3191ATZV8iavJsUcIabdLHawOx50YUWGy62AQyjAgNiWXOFVLNNeLefA69Tj63fceB9/Y4TSbdBL5TsHZF3Q=
X-Received: by 2002:a25:4047:: with SMTP id n68mr15190555yba.96.1626458248262;
 Fri, 16 Jul 2021 10:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210710064511.1288232-1-willmcvicker@google.com>
In-Reply-To: <20210710064511.1288232-1-willmcvicker@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 16 Jul 2021 10:56:41 -0700
Message-ID: <CAGETcx_XZDWNQ2OLEs0XMnq3m1WFJ8mD0LAXFTpYBXPLPUCAxA@mail.gmail.com>
Subject: Re: [PATCH] drm/mipi: set fwnode when a mipi_dsi_device registers itself
To:     Will McVicker <willmcvicker@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

Thanks for catching this.

On Fri, Jul 9, 2021 at 11:45 PM Will McVicker <willmcvicker@google.com> wrote:
>
> This is needed for fw_devlink to work properly with MIPI DSI devices.
> Without setting the device's fwnode, the sync state framework isn't able
> to properly track device links between the MIPI DSI device and its
> suppliers which may result in its supplier probing before the mipi
> device.

I think it'd be more accurate if the commit text is something like:

drm/mipi: set fwnode when a mipi_dsi_device is registered

This allows the fw_devlink feature to work across mipi_dsi bus devices too. This
feature avoid unnecessary probe deferrals of mipi_dsi devices, defers
consumers of
mipi_dsi devices till the mipi_dsi devices probe, and allows mipi_dsi drivers to
implement sync_state() callbacks.

Reviewed-by: Saravana Kannan <saravanak@google.com>

Thanks,
Saravana

>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index 5dd475e82995..469d56cf2a50 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -222,6 +222,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
>         }
>
>         dsi->dev.of_node = info->node;
> +       dsi->dev.fwnode = of_fwnode_handle(info->node);
>         dsi->channel = info->channel;
>         strlcpy(dsi->name, info->type, sizeof(dsi->name));
>
> --
> 2.32.0.93.g670b81a890-goog
>
