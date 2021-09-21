Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21C0413D72
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 00:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhIUWVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 18:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbhIUWVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 18:21:30 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EF8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:20:02 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 134so656399iou.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWLoAInOLCehVyUDdEFgyA0aq8c1810nqg999R8oxfU=;
        b=aj3QxekWfRi3uAdc5lpdDn6FoYAedJ8FsTjBDvBCDWRjEzt/JQ6p7imxAG/DApK+mF
         2gagVt3X8luIoitRLXSKRYVwLgSznNVpaZyG8m/4FCGZweCBBZsIAUvT7PdIPZbU8wN1
         mfAQEwrxhepXNPQuDT3ppCtjQk9jPR2TpYAss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWLoAInOLCehVyUDdEFgyA0aq8c1810nqg999R8oxfU=;
        b=p5Bec16lI2Fg0XthCe0v/uQfH3H/1aVOu01Uq4u3voW2LdJlUNKO4R6QXhPKmM/Dig
         s9G7GS+dczMwhy/VpUzT6ciUqr3n2+k599MYjtTfDL77i/MXjmK9wXvPLjWuufWStBhd
         vZ/jg6Pwe45+uxld8axRsOsgywcAW38x8wyc4yZ7vj6CBC40DTqFt15E482kaGa0wzTV
         pXJnaM4VTSZ/klO1NTpeVamCmoEeqUmWMgSZHGzCjnznR55wg547At54AjBW6N3BGqA7
         MLCAke1tDCgQJ0YTzOebgSkkGk+iE5xAHOeFzC9RrYBZtT4Gz3RlJpdlpLZh8eGXYnES
         twrw==
X-Gm-Message-State: AOAM533PRMsAmypi5lviDWLLZD+mlKOn4OJUequKTObBGaK12kJDmydH
        GX06xpxpuP+1zxPiYREsDMgpmJgTBRSE7g==
X-Google-Smtp-Source: ABdhPJxp37XG6wQThaz/AIe3qdzZ7aHlMAj7bVdchW+0Ylfj1wca3DpK7GVrGLsUc2NYbeAlF8Qlag==
X-Received: by 2002:a05:6602:3c5:: with SMTP id g5mr1945321iov.42.1632262801163;
        Tue, 21 Sep 2021 15:20:01 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id d10sm107465ilu.54.2021.09.21.15.20.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 15:20:00 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id w1so546603ilv.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:20:00 -0700 (PDT)
X-Received: by 2002:a05:6e02:1b0c:: with SMTP id i12mr20195314ilv.27.1632262799686;
 Tue, 21 Sep 2021 15:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210920225801.227211-1-robdclark@gmail.com> <20210920225801.227211-4-robdclark@gmail.com>
In-Reply-To: <20210920225801.227211-4-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 21 Sep 2021 15:19:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WGmk6UY2MA4=y4gaM4G66t-qxuLtAZvUahzwg8YsLv=g@mail.gmail.com>
Message-ID: <CAD=FV=WGmk6UY2MA4=y4gaM4G66t-qxuLtAZvUahzwg8YsLv=g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/bridge: ti-sn65dsi86: Add NO_CONNECTOR support
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 20, 2021 at 3:53 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Slightly awkward to fish out the display_info when we aren't creating
> own connector.  But I don't see an obvious better way.
>
> v2: Remove error return with NO_CONNECTOR flag
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 39 ++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 10 deletions(-)

This seems fine to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...if you would like me to apply patch #2 / #3 to drm-misc-next then
please yell.

-Doug
