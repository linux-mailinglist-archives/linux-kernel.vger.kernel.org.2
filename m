Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3EA38D542
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhEVKmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhEVKmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:42:18 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A880FC06138A
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 03:40:52 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w33so25458089lfu.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lg1y9Obp80Osz1Bq342Yu+rTFD/2WpZGCEwwuCDW6E8=;
        b=uc4PL6oylDsloueQXrsHk4s9gDW5ReETZHqDdO2FyOsAYj2AXbF4Y5GiSKBEvOZlXb
         y46aWz4RMRtLBBv82Mz353uoHrmnz8CuPPFIqMQWmKIePAclvQmgmh0dS3Q8hkHcVPqx
         /M3QyfikllKwEsHD2xUdHIaY6wC2eyjluXU9nw1Iki6Gn6a6GU6ihNNNtWuLilr+Qzyz
         mmWFT3DXaNR+vSEzUxpNXg4ffVaZHNJi9hute/lOz9R4kJ/FlckJBIUh+MosI/5m8fn+
         /BqribLnX9ZuLHVWmOsAfN8QJUSbhGsBpsZMysFe2Ouy/QuFaNz461USE2xWHGPzKCQZ
         0dMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lg1y9Obp80Osz1Bq342Yu+rTFD/2WpZGCEwwuCDW6E8=;
        b=hnO7FFL33uAC2GFExqgQqBVlumhbNtgJI1x/mXtYpDblkXUxwDsXI3a7kc3kktDDSC
         EIyopOB1bAcTGqAl9IeBGsdauPHoKOGbAB/yyCWqhhbIb3SMUC87jdG0GRltFxpKhXVz
         qwcEP/SRnhjK4q7WdEW8aPORohn4qvszlyMjGf9p5OnvfXYmse/AIH9Bs2L5W0mDeXmK
         s0Abe4WJNYBbt3i1caqMFgruagv2StrK1dr+86HA7QULBt2zC80hpxZiOV9359hyGSDC
         0BuxjxHXzcifqAUCfcgdFU3dnNEtO5SBZ4FTIro4HyLB/FDY27rMPiO+azKwOKT7k9Oq
         gvog==
X-Gm-Message-State: AOAM531RRR0AEXTjJgLj1N9kwvbWTBJ/9e5ckNysZK705GGmOdIENfgY
        CHsYaiELN7I/cRpWzTXQ/H8wJqJ7V3sgWCoNjFna6Q==
X-Google-Smtp-Source: ABdhPJxhLwsuqV6feNa9R5NW2NBld0tSR0wyt/uxJOCt1dJmqHL9iyeqVVJScvTt9ZNQ720pZRp4l/glKWQcrUEPhEY=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr4994893lfn.465.1621680051047;
 Sat, 22 May 2021 03:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210517200907.1459182-1-dianders@chromium.org> <20210517130450.v7.10.Ibdb7735fb1844561b902252215a69526a14f9abd@changeid>
In-Reply-To: <20210517130450.v7.10.Ibdb7735fb1844561b902252215a69526a14f9abd@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 22 May 2021 12:40:39 +0200
Message-ID: <CACRpkdbrmFS87xRRbwbU7J05bGDKmx5oJR880sr_ZA4KWKSKfA@mail.gmail.com>
Subject: Re: [PATCH v7 10/10] arm64: dts: qcom: sc7180-trogdor: Move panel
 under the bridge chip
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Thierry Reding <treding@nvidia.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 10:09 PM Douglas Anderson <dianders@chromium.org> wrote:

> Putting the panel under the bridge chip (under the aux-bus node)
> allows the panel driver to get access to the DP AUX bus, enabling all
> sorts of fabulous new features.
>
> While we're at this, get rid of a level of hierarchy for the panel
> node. It doesn't need "ports / port" and can just have a "port" child.
>
> For Linux, this patch has a hard requirement on the patches adding DP
> AUX bus support to the ti-sn65dsi86 bridge chip driver. See the patch
> ("drm/bridge: ti-sn65dsi86: Add support for the DP AUX bus").
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

This is really looking good.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
