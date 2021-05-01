Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E784437071A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 13:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhEAMAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 08:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbhEAMAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 08:00:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AAAC06138B
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 04:59:18 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 12so1059851lfq.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 04:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QLxSp/ePlciHnCzVMGdXgyEZo0R6BmfwYtxDKjI/pqU=;
        b=jcIi+kb7+jywxzREwePLOZyikDcoPK0Z0M1f/JhBnLif3jWV6ATJl0nXzhuKTa72Qm
         PQMeKbrrwBH5qU6RcI+NNhRgPjaBrwIYgPMpQvGGv4MtxK1r7IIEWX/CQ02RVRl1iFbP
         P42ki89fVr+tczmJUY02sjARyeOt/wHldYK1fffQ9dF5dcWQqYv7a03b2KoKkb/yXUB7
         czOvMyriPuA18ukQogxg9Z3Yk57cksDHyHt43PE/7IA3zPwZH4HW8aFNpNk1EGarsOXl
         pUjfQOfyivF2OAuny4eJEDvj7wVkpPBX0oatWIhPAKVSouQyEufzyxJr1bzere5HjMFs
         edJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLxSp/ePlciHnCzVMGdXgyEZo0R6BmfwYtxDKjI/pqU=;
        b=OZvyysVOuPAOp2XzoMsYc15CtTx7dgi9CGh8iuxW2vsXU3VK1MTdNOOy+n13GV1ySd
         ojPO98KolxzdVDIxIwbtmecg2/r5XHmNSD3rMc7sFnDult6+nqhsQQUV2fhdrUm0a43S
         9vlGdhKwNlMQmv6x0z5iPUwb9QoVrKQGC37wcFG3Te6tnIYAZnixrUa5zOOpGPWpvKYS
         UMuhgpoH+wTy4oSR8QDPonDYJi+XoaKGLc8Z0QO8CMQfrxhyhtMB5XlWxcslmXKUhQMR
         tJmzRmHbMow+taweWvj9dfuzA8PF9sAeLUmKW8JuPiFDw3gNt/Mcwes7TGIQdLwlicoV
         5GpA==
X-Gm-Message-State: AOAM531phWWH+5s/bVXxBYn2Ej2f/tvTyZIIzLAyJFC/rq+W1YH2dK6d
        +q2+Bei0IYRqFvuFItmUbxSZfYS5MT+3SxUkCZ5vtQ==
X-Google-Smtp-Source: ABdhPJw+F9WmElJwhUk24Nw7bpvwEd3U15o9b5hWV9qrpBy3C0X7Zj7MCbUNd4hF1kIE4C9w9FMOjoMDoXiThg28GGk=
X-Received: by 2002:a05:6512:3e1f:: with SMTP id i31mr6880595lfv.29.1619870357179;
 Sat, 01 May 2021 04:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210423165906.2504169-1-dianders@chromium.org> <20210423095743.v5.9.I3e68fa38c4ccbdbdf145cad2b01e83a1e5eac302@changeid>
In-Reply-To: <20210423095743.v5.9.I3e68fa38c4ccbdbdf145cad2b01e83a1e5eac302@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 1 May 2021 13:59:06 +0200
Message-ID: <CACRpkdbZxauBFLvR_MMx4WD+K6DftK19Fivt_mkE=+Xr2EPUvQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/20] drm/bridge: ti-sn65dsi86: Break GPIO and
 MIPI-to-eDP bridge into sub-drivers
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 6:59 PM Douglas Anderson <dianders@chromium.org> wrote:

> Let's use the newly minted aux bus to break up the driver into sub
> drivers. We're not doing a full breakup here: all the code is still in
> the same file and remains largely untouched. The big goal here of
> using sub-drivers is to allow part of our code to finish probing even
> if some other code needs to defer. This can solve some chicken-and-egg
> problems. Specifically:
> - In commit 48834e6084f1 ("drm/panel-simple: Support hpd-gpios for
>   delaying prepare()") we had to add a bit of a hack to simpel-panel
>   to support HPD showing up late. We can get rid of that hack now
>   since the GPIO part of our driver can finish probing early.
> - We have a desire to expose our DDC bus to simple-panel (and perhaps
>   to a backlight driver?). That will end up with the same
>   chicken-and-egg problem. A future patch to move this to a sub-driver
>   will fix it.
> - If/when we support the PWM functionality present in the bridge chip
>   for a backlight we'll end up with another chicken-and-egg
>   problem. If we allow the PWM to be a sub-driver too then it solves
>   this problem.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v5:
> - Fix module compile problems (Bjorn + kbuild bot)
> - Remove useless MODULE_DEVICE_TABLE (Bjorn).

This is generally a good idea. I have no idea when to use
auxbus or MFD but I trust that you researched that so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
