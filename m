Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D968C3FC96E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhHaOM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhHaOM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:12:56 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8680AC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:12:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so2109754pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DwBG0kbYLoprwx2xDskuGjAg4KxbwGBk3fVvkOflJfY=;
        b=n4plaO9ZqXTMabwQQad7OQWiFxsARGV7/IksaEq0V+fk0Zar3ZT8MUTLoE2UWcX4MU
         zrVz9ULgAArOMtdajOyS0NRgdYmASL0E3tULikziScQjHqXjdDxNJe8F3UuhQ5DCFetJ
         SEjUA0AznWEznLoyb4A+/Bp9ZQWGW+j2Wi4KjQWGqZ/+PuIH8uulXO87Q40BX/X/C9Ji
         VCkkkixVthgv0kfgThJ3bvFwJ2rmHkmipXXtLzc4YtwSC1Eot/27pCBts9+zBhgCXaZb
         YfbUSJPuTMOYkdYUSs1GXJ3NX3d2DI4yxeCMPM+avwPD8BP70QqkWLTTS/lNdppx7Rkm
         mVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwBG0kbYLoprwx2xDskuGjAg4KxbwGBk3fVvkOflJfY=;
        b=VtbuQTk2hgl83kZNbzhB+BCClEGhcxfLI+CvDz/bgFeM9sHwa8qJsQXxvGGnQVZS15
         t+4FZKttPp90Gjy6uVwEQcOqDAL8Y5pLobco1vPQC/LXe+zbuB3fuaB2fAeaMbQ96cxm
         sN7k50Soy/GlGGW+2OZLuDmNUFsmQaNME9iz/TrsGZkhJidHXTPgsR9bI9/sgJcNxOF5
         FDOFg7JKBMWxejQ8hdyhbXBEXPzqJPwJ7tiTzdyz0rZXRC/d98x9qDB46gyD/mVPTAA8
         aUau/FH4pLY5bBLjsoH88V/Skh9r4b/dQknAgSXYioRDs4CNycFGfKncOwgeYNaWnZ+K
         Mw8A==
X-Gm-Message-State: AOAM5320UGeeqvKYEkQkciysw7rC48JAJ6JyzuJp48QCEaXvuRenWec2
        URAgoFjs3hce4RkC8N3nSTsNmgZJx1gLQ0yTV1+ewA==
X-Google-Smtp-Source: ABdhPJx5yHJTTzBrXq2AUYXsGcTAO5IKtUmnDI+oVOLx/pegeMs0loQRWMfDgCq3QQK52OVn5wqzTEChmIVQ8Q2ox7A=
X-Received: by 2002:a17:902:a513:b029:11a:9be6:f1b9 with SMTP id
 s19-20020a170902a513b029011a9be6f1b9mr4831914plq.55.1630419120987; Tue, 31
 Aug 2021 07:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210819060110.3427256-1-xji@analogixsemi.com>
In-Reply-To: <20210819060110.3427256-1-xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 31 Aug 2021 16:11:49 +0200
Message-ID: <CAG3jFytk21cSVKiFcu859CBvUW593XQw5_D97Uydsf798jyWDg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: anx7625: enable DSI EOTP
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Nicolas Boichat <drinkcat@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, Torsten Duwe <duwe@lst.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bernie Liang <bliang@analogixsemi.com>,
        Qilin Wen <qwen@analogixsemi.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 at 08:01, Xin Ji <xji@analogixsemi.com> wrote:
>
> Enable DSI EOTP feature for fixing some panel screen constant shift issue.
> Removing MIPI flag MIPI_DSI_MODE_NO_EOT_PACKET to enable DSI EOTP.
>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index abc8db77bfd3..1a871f6b6822 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1335,7 +1335,6 @@ static int anx7625_attach_dsi(struct anx7625_data *ctx)
>         dsi->format = MIPI_DSI_FMT_RGB888;
>         dsi->mode_flags = MIPI_DSI_MODE_VIDEO   |
>                 MIPI_DSI_MODE_VIDEO_SYNC_PULSE  |
> -               MIPI_DSI_MODE_NO_EOT_PACKET     |
>                 MIPI_DSI_MODE_VIDEO_HSE;
>
>         if (mipi_dsi_attach(dsi) < 0) {

Applied to drm-misc-next
