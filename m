Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C498B411210
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbhITJtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhITJtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:49:31 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD34BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 02:48:04 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e7so16742338pgk.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lP4lLyZsFEqWiwhyXMr4Opdw5/67jPTt6YJ5qHZtMJc=;
        b=fUWR1YeZCHBdf8WtcFiuDXW1UEOcO/z5GdAQKZefe5vPNlOUyRCInBmb64Yv94OFNq
         UIAcV472D0ALte6gWvbvcXdILE5WjurM27eLZGWV9VPheDaaQ7HXsyscibpQZ5u/0qRM
         il7QTUh8Vw+KRFYiEkRlKzWi67OyAsPLeamH+kwvLh/vUMPU1IPzaZj4DCI1nw5ZCKRF
         05fWoQE90MqwnFi1XCjGOeqmsRB4A1hhaOgEq9V5ebiXOnycTP9OEyd+AHAZSRV024F6
         MQ4j4FTxk0AZHdSuKcmpf2+qfkLmWGgYJRtzl68g0ocIyvr2p0yKGfpznaHA4W5AvLaB
         4qpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lP4lLyZsFEqWiwhyXMr4Opdw5/67jPTt6YJ5qHZtMJc=;
        b=MI+OFuHPJlOXtMcMSrfCJLAgldbqtWbxCge4xCAIQdg8cFOoSa8YSQkMakk9WjupHF
         P7P92TOMYY3YYqzSr2aWx6AoTSInq6dd5u9WN8G6MErsWOD63ucmDFY+fAclisNMXfW1
         27WAkCGd1NsXjVjBn4hs/CZB1jGcCGFJWmGN0TSHCFO5MiO5Eb825yNeXg8VSowcg4pC
         a0aQHOQIBp7btoHQFkvjJQnXJnwINbgeZG/8fl5mCrI+s7RDP8AQYpXpPZDnI1w7vl3r
         X6TjmN6AUm0SO3Fnx9Jeq7cKLoZ4keoden8s3YWc4O7Y+jpAzYrqczTa62gGzFRKLp2A
         mMcg==
X-Gm-Message-State: AOAM53290lJkv3gY2+dSeJQH9fyWaQrUNzQLWz8t94lP9jyeggcTH1fW
        lRNnYEA+srTilfiWnFHPVBnnmi3Gb+0alTwfQo0cjg==
X-Google-Smtp-Source: ABdhPJy5bfNQJwVXlTMJ3A0voNBw3oOzciJaoe6AMl79fn/fbgGwvM9LgDIyKNH8lNsqpw2o8ZvofCUIHwWsSPRwhwk=
X-Received: by 2002:a63:391:: with SMTP id 139mr22691394pgd.410.1632131284170;
 Mon, 20 Sep 2021 02:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210918035041.25512-1-liyunlonga@uniontech.com>
In-Reply-To: <20210918035041.25512-1-liyunlonga@uniontech.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 20 Sep 2021 11:47:53 +0200
Message-ID: <CAG3jFysCS2g4QrXgZQ9E9Jzq_-5OnXPPUf0kWMpkx56DFkdD1A@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: it66121: Added it66121 chip external screen
 status judgment.
To:     Yunlongli <liyunlonga@uniontech.com>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Yunlongli,

Thanks for submitting this fix.

On Sat, 18 Sept 2021 at 05:51, Yunlongli <liyunlonga@uniontech.com> wrote:

The formatting of this commit message is a bit unusual, let's try to
change it to the normal formatting.

Remove the dot from the commit title:
"drm: bridge: it66121: Added it66121 chip external screen status
judgment." -> "drm: bridge: it66121: Added it66121 chip external
screen status judgment"


>
> fix: Add further confirm if external screens are involved.

The "fix:" tag is not needed. However if this commit fixes a bug
introduced in an earlier commit a machine readable tag like the the
one below could be added after the commit message.

Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")

>
> log: In the actual tests,  the IT66121 chip sometimes misjudged whether
>      it had an external screen, so, reference the it66121_user_guid.pdf
>      about Audio/Video data is stable or not A typical initialization
>      of HDMI link should be based on interrupt signal and appropriate
>      register probing. Recommended flow is detailed in IT66121
>      Programming Guide. Simply put, the microcontroller should monitor
>      the HPD status first. Upon valid HPD event, move on to check
>      RxSENDetect register to see if the receiver chip is ready for
>      further handshaking. When RxSENDetect is asserted, start reading EDID
>      data through DDC channels and carry on the rest of the handshaking
>      subsequently.If the micro-controller makes no use of the interrupt
>      signal as well as the above-mentioned status  registers, the link
>      establishment might fail. Please do follow the suggested
>      initialization flow recommended in IT66121 Programming Guide.
>      So, I add the IT66121_SYS_STATUS_SENDECTECT register status detection.
>

The "log:" prefix is not needed, and neither is the indentation of the text.

Secondly maybe it would be nice to format the above chunk of text into
paragraphs just to make it easier to read.

> Signed-off-by: Yunlongli <liyunlonga@uniontech.com>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 2f2a09adb4bc..9ed4fa298d11 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -523,7 +523,7 @@ static bool it66121_is_hpd_detect(struct it66121_ctx *ctx)
>         if (regmap_read(ctx->regmap, IT66121_SYS_STATUS_REG, &val))
>                 return false;
>
> -       return val & IT66121_SYS_STATUS_HPDETECT;
> +       return ((val & IT66121_SYS_STATUS_HPDETECT) && (val & IT66121_SYS_STATUS_SENDECTECT));
>  }
>
>  static int it66121_bridge_attach(struct drm_bridge *bridge,
> --
> 2.20.1
>
>
>

With the above suggestions fixed, feel free to add my r-b and submit a
v2 of this patch.
Reviewed-by: Robert Foss <robert.foss@linaro.org>
