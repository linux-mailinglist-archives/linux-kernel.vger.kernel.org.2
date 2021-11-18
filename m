Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EF94553F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 05:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbhKREzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 23:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbhKREzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 23:55:25 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C24DC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 20:52:26 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id g28so4258110pgg.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 20:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QSOtOAi5Tc1aIEzabwTYbDWspkmg5uzVLYl8MIpPJoA=;
        b=MdFNOM/e2K2/fRS6inj/lGYD9pE3B63yoJteoHGfVImfEoViHCQ0lCSOQ43s42TfHA
         pocsPucoLU2vRtzZKm0yhhejcLKw3uMNVCqAMMfifLzVYWiGQ+nORuUSTyRqGzEcj9SV
         RIkoXoDDgcWSjKBTKc8tuosEHqfgGDDoGbyMuJXmj6uFWG7+9Bl+sK2nzQT//l8e/MKC
         eXS6kn+lNHaQ12VpSpfETvbb8HW9M/vTbZBMj+S0zZHBHrcreL5WcIWSjaYxo6pX8jCg
         ZZSD2z9+KaxK7GwxkYQmFqaPGEYR04B56QFDavcl7mZczdzmsFo40SdOTWEM1+k1mhON
         uPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSOtOAi5Tc1aIEzabwTYbDWspkmg5uzVLYl8MIpPJoA=;
        b=2BhcpIE2r2SufpGtDCJptuFrfCkmUvtpsO9FXcBQOXBYnEfRnkHclG8udGwi5oQiIy
         IiZrUllHixxVMPDB67Fp32hgyvcH/0fHl2+AIRe2X1XIoPsKjVGX4t5O7uCSS5GTxj9i
         bIcZc8AS7e/iE+sBZcLHpR3sIphwAU3ckz0ESd+m5c03AcSXe5uJuDMHKcAaHSKj4Uo+
         FU1KBjxOa9C81ikQclJxeya2Acb8ktOk/Goueox37iGa40JHeWkE8rdDfhccbdYEmYpe
         YfCl3yYBHZhMejnMqkon3hfbmP/H/Ew5vBAFfWJPloUJLQXKGi5XjhexF5cYA86/J16W
         PriQ==
X-Gm-Message-State: AOAM531KunOe2YKk1dInc0hLGAkMRpnmSi08WUPBXFr6j4TBym5D1fyR
        zNtrtj4+/kqZYyXXWAzozpvKL8f2pxI2EwpQ15PI/g==
X-Google-Smtp-Source: ABdhPJz5uBVbVFCngw7k8h9ZCzm+ig9jeVfnyUG/Yflt8UH1BiiKZNwTDTqCnlI/CLuQuJ76kR+PQZ4lr97UqVdw30A=
X-Received: by 2002:a05:6a00:848:b0:49f:b215:e002 with SMTP id
 q8-20020a056a00084800b0049fb215e002mr52878678pfk.47.1637211145842; Wed, 17
 Nov 2021 20:52:25 -0800 (PST)
MIME-Version: 1.0
References: <20211118031125.3778969-1-xji@analogixsemi.com>
In-Reply-To: <20211118031125.3778969-1-xji@analogixsemi.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 18 Nov 2021 12:52:14 +0800
Message-ID: <CA+Px+wUc8+5HtkS8y4b9aw7m+wLS+zC1em6VKRNog1QKnJrZ=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Check GPIO description to avoid crash
To:     Xin Ji <xji@analogixsemi.com>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com,
        dan.carpenter@oracle.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        sam@ravnborg.org, pihsun@chromium.org, maxime@cerno.tech,
        drinkcat@google.com, hsinyi@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bliang@analogixsemi.com, qwen@analogixsemi.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 11:11 AM Xin Ji <xji@analogixsemi.com> wrote:
> @@ -1098,9 +1098,18 @@ static void anx7625_init_gpio(struct anx7625_data *platform)
>         /* Gpio for chip power enable */
>         platform->pdata.gpio_p_on =
>                 devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
> +       if (IS_ERR(platform->pdata.gpio_p_on)) {
> +               DRM_DEV_DEBUG_DRIVER(dev, "no enable gpio found\n");
> +               platform->pdata.gpio_p_on = NULL;
> +       }
> +
>         /* Gpio for chip reset */
>         platform->pdata.gpio_reset =
>                 devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +       if (IS_ERR(platform->pdata.gpio_reset)) {
> +               DRM_DEV_DEBUG_DRIVER(dev, "no reset gpio found\n");
> +               platform->pdata.gpio_p_on = NULL;
> +       }
>
>         if (platform->pdata.gpio_p_on && platform->pdata.gpio_reset) {
>                 platform->pdata.low_power_mode = 1;

devm_gpiod_get_optional() is possible to return NULL (see
https://elixir.bootlin.com/linux/v5.15.2/source/drivers/gpio/gpiolib-devres.c#L250).
Thus, we should use IS_ERR_OR_NULL for checking the return value.

The cases here would work fine except it will skip to print some
informative messages.

Acked-by: Tzung-Bi Shih <tzungbi@google.com>
