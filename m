Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EEB432893
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 22:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhJRUpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 16:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhJRUpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 16:45:23 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C14CC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:43:11 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id w11so16238751ilv.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEzkQ9AMimvLzS0zxjsiIV7V37hJ+OdttYyqIoFNqLU=;
        b=RYeZX0qbLYX5B/8w8AGyG/PUKn2mi5CkbqHMQZ1HVTrpYucMxBIwaC5K23Da2IDRs/
         P0sSsMh0AGfFbKC5g9VZ5RnOIi/a/K9ODJGGKjhT2z/iCgJSgW0kL4ed1S4Ziua06sIg
         hd4V5LQ/y2btPOQrWgZy+7ZGx4QNReKC8RBbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEzkQ9AMimvLzS0zxjsiIV7V37hJ+OdttYyqIoFNqLU=;
        b=qpuL64Hw+HzBtuVoxgsUnWBV4GPH5YfKxQe93dwDuP8TijMx8uoCXZ22lB76+rYCdq
         EkrqqFzwTxPqeGsxW+7XSRDGJD8IvQEyDNcAVMhsPxGXvB4GnWBJNaA4Mvb02/tIFIXP
         kKgiZg66VoilH1m5bm6n/TEZ6U5iYO5M15X9UbxH504fOClZJUc7OuH6fkoXNI8Sue2C
         1DTeXmF7nRq9tgQKbLrpFZ8Q1YutvcZMVZcna9N9Dd/rHIQBIuTDnu+N6X2ufB5qINQy
         AU5gS9urzNx26XXEYoWlbosODCFtUZsauywYcPxQ0LnBGOke6+TO/TxYVWnA+FXhzM3I
         720w==
X-Gm-Message-State: AOAM530wDBuQ+Bb/aPk/+YsBCaEXWEfotlxzuFZ5nA3VDfuHmfhl33mz
        ZFfytc75yXkZiF+VWxWa9rVc+hqhTQRawA==
X-Google-Smtp-Source: ABdhPJxS9c9WgOcKH735R/eJ+rN7XOkfekMbZebzY8Gf5aro9xeotZDcWfyh/OE0g33SNSP2jJEoqA==
X-Received: by 2002:a05:6e02:1a44:: with SMTP id u4mr15860374ilv.4.1634589790772;
        Mon, 18 Oct 2021 13:43:10 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id v23sm7182923iot.20.2021.10.18.13.43.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 13:43:10 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id k3so16259289ilu.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:43:10 -0700 (PDT)
X-Received: by 2002:a05:6e02:15cb:: with SMTP id q11mr15819434ilu.180.1634589789692;
 Mon, 18 Oct 2021 13:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211016095644.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
In-Reply-To: <20211016095644.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Oct 2021 13:42:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V7+MzyjsLKE87c=8bkFiRbQkGoM4Jfm8jcsJBG0aYAWw@mail.gmail.com>
Message-ID: <CAD=FV=V7+MzyjsLKE87c=8bkFiRbQkGoM4Jfm8jcsJBG0aYAWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: parade-ps8640: Enable runtime power management
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
> @@ -319,81 +345,70 @@ static void ps8640_bridge_poweron(struct ps8640 *ps_bridge)
>          */
>         msleep(200);
>
> -       ret = regmap_read_poll_timeout(map, PAGE2_GPIO_H, status,
> -                                      status & PS_GPIO9, 20 * 1000, 200 * 1000);
> -
> -       if (ret < 0) {
> -               DRM_ERROR("failed read PAGE2_GPIO_H: %d\n", ret);
> -               goto err_regulators_disable;
> -       }

Above the "msleep(200)" I see a comment that says "and then check the
MCU ready flag every 20ms". That probably refers to the code that
you're moving here. Maybe change the comment above the "msleep(200);"
to something like this if you like it:

/*
 * Mystery 200 ms delay for the "MCU to be ready". It's unclear if
 * this is truly necessary since the MCU will already signal that
 * things are "good to go" by signaling HPD on "gpio 9". See
 * ps8640_ensure_hpd(). For now we'll keep this mystery delay just in
 * case.
 */

Other than that this looks good to me, which isn't really a surprise
since I was involved in helping with / reviewing early versions of
this change. In any case, I'm happy with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
