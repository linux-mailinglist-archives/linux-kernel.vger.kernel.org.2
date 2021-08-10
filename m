Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4F93E5935
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 13:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbhHJLjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 07:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhHJLjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 07:39:19 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6271BC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 04:38:57 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id a13so31689415iol.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 04:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUwXDTn/nEQtIoTdsB5jMGa7v/7U/IC/RlJbSIvkA1c=;
        b=HQZMelUdqTZxUf3JkxmmsVTFmC1Mdz68Keh3lO5z0POpnpnucoqqg7rkVnDLJEDQ6d
         IrWRH/zoUzNO2TcjqvLRRagTN37zva1aLLs8hJw7RE/EuZuteefOiZKVnIsvShS7ng9D
         iDwqDIak8IyzBAFWDd6vDqEHQ0XNZYlAH4qWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUwXDTn/nEQtIoTdsB5jMGa7v/7U/IC/RlJbSIvkA1c=;
        b=dODnY7vl7UF2hrpMsLha6R4Q4Dz+WGBMEluDUc5m4WlFK5dPljzNB4V+L7uBVmAVBh
         pOGyRhCki08f7nqi/vLfrPCYzhjDyRlJlAqA94JcMV6kSamCIG82CV+c5zJmkMuBYk3d
         x74fc5jP7owPEV2HkRakSTnPi+7GlGiUHuy5Jg44GTsAeP/Fk6b+bxd+ClBVV+71q7n+
         9n78oOApR3YmV2z7l3Pv6Ihfi6Z0cFg+2X5vODUXe1zQgIziFqXEtdYRCfdXfVIqGgMy
         hujDb06nlkA4UePA4L3D4U7W5V+VIHLOoK8r6SN5kQv7tge4PBO7Sxn9znz7IURpb8Wh
         V4Cw==
X-Gm-Message-State: AOAM5320hqamFPS2i9JTWUdsitW3x5EVaq3WHqesue8r1oCGhO5iY/yW
        Nmb1UEh9TdNFz4A0pUByOEcnzE7xHT2yQzTJDIO5jg==
X-Google-Smtp-Source: ABdhPJyWjNvIInY7E8yPGRGtVh57QG1QSVK8P+R3j/fA9L2Xby5Bs4c9n+zM0z8jClvd941GJvNiXO8tquBwf6KQReE=
X-Received: by 2002:a02:cc21:: with SMTP id o1mr27001854jap.114.1628595536700;
 Tue, 10 Aug 2021 04:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210810111124.247838-1-allen.chen@ite.com.tw>
In-Reply-To: <20210810111124.247838-1-allen.chen@ite.com.tw>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 10 Aug 2021 19:38:30 +0800
Message-ID: <CAJMQK-g9=7o750t4ZAyND7nqrRvx=tMqUs+-=1--M1CqGXvAdw@mail.gmail.com>
Subject: Re: [PATCH v8] drm/bridge: add it6505 driver
To:     allen <allen.chen@ite.com.tw>
Cc:     Hsin-Yi Wang <hsinyi@google.com>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 7:31 PM allen <allen.chen@ite.com.tw> wrote:
>
> This adds support for the iTE IT6505.
> This device can convert DPI signal to DP output.
>
> From: Allen Chen <allen.chen@ite.com.tw>
> Tested-by: Hsin-yi Wang <hsinyi@chromium.org>
> Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
>
---  <-- Add this line next time.
Add the change logs below this line so that they're not mixed with
commit messages.

> v7->v8:
> fixed "checkpatch --strict" error
> remove unused variable *edid
> remove mode_set() callback
> Documenting the individual bits of the interrupt mask values
> change it6505_dpcd_write parameter from unsigned long to u8
>
> This patch depends on https://patchwork.kernel.org/project/linux-mediatek/patch/20210722062246.2512666-4-sam@ravnborg.org/
> ---
>  drivers/gpu/drm/bridge/Kconfig      |    8 +
>  drivers/gpu/drm/bridge/Makefile     |    1 +
>  drivers/gpu/drm/bridge/ite-it6505.c | 3333 +++++++++++++++++++++++++++
>  3 files changed, 3342 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/ite-it6505.c
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 431b6e12a81fe..e1afe171075f5 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -74,6 +74,14 @@ config DRM_DISPLAY_CONNECTOR
>           on ARM-based platforms. Saying Y here when this driver is not needed
>           will not cause any issue.
>
<snip>

> +
> +       /* Register aux channel */
> +       it6505->aux.name = "DP-AUX";
> +       it6505->aux.dev = dev;
> +       it6505->aux.transfer = it6505_aux_transfer;
> +
> +       err = drm_dp_aux_register(&it6505->aux);

drm_dp_aux_register() checks if aux->drm_dev is null. Assign this
otherwise you'll see warnings.

> +       if (err < 0) {
> +               dev_err(dev, "Failed to register aux: %d", err);
> +               return err;
> +       }
<snip>
