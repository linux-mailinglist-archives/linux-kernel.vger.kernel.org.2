Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DADF393A45
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 02:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbhE1Abo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 20:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbhE1Abl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 20:31:41 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBF0C061761
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:30:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x38so2707406lfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cAYxSZ2/LUsSsn8d06yEcKP0Gfca5oqTYVqfarEyY4Q=;
        b=CGtHb0yWAyWtrKrDJIeR8VvZXgsNXy84JWlXeb19e88ME4csylVRHl7Lcd0FSfDG0h
         ryKXiFr8u9YGB+o8gN9tyhxz+8cY1mpCam+L8sKlzDjb/42QPB8sNGoba6bPqd9anVEN
         kxYBVVuI2MpYL5detAHUgrZRAHMV3L25XISvh6/vovNXuIn3BTU2ZD5RJuDCVhmLP+LF
         aHdccEzIYbbY9D1GDhNCytmG45H5v/JQZyvRqjYzagGmAfhnPFrh4qIu6DsGUN8B55zh
         wxYwjrkV1MIPbk8KDhuf3kM6wY3c0iOY5tgMqzWgJrnM/Rhk3RniD0Lwb2pb7uCZJZXs
         UV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cAYxSZ2/LUsSsn8d06yEcKP0Gfca5oqTYVqfarEyY4Q=;
        b=k6P/yOo2NDCn7IsMxGK0hjsahTU3FgBpiDrvccCYEjSG3FgiFNJ7sMVvRBNr9jJANG
         M3RAq3urNHV9NzSkUlcUDTMZEvmAP3+nKFQU7av+BgEVghAQHSTulmziEUGJxms0+ZBG
         tmx2Sb8lLKs579Jsq29Ytp+y6BA53X8FRWjnQasotdYjo3AwYoBz0YgdjvdP+3haNY49
         y4pemDJZNs1yiSa4tGHUVVOIKz7Plx0vxiRbVPK6Li5a7MTViU9+rE+j4FoURGk/Vfy/
         FVe3a3Qs3GRmvlPk5T0JQYhxkEHsZPFbLQFIP3Z8nsoXEA0zkwAn69/HZkyojsKvIWC4
         GxPg==
X-Gm-Message-State: AOAM530QuXrzpW3ZbBYZmJuZqnzzBt/1fsv2yaZYHZrkuv3HbpwFg4P4
        CAqoAXke/KF9ztHg/Ox4pCAkYSjNxs7D4PnsMCt4Fg==
X-Google-Smtp-Source: ABdhPJxjKWZl4nXKcEb8D++9zwhUGTk9lmQJdMjIN1Wc6enAt0Oqdih6wD8S0QT6XSpnKxPCjDnCZ7wSs6HcuOnh1dU=
X-Received: by 2002:a19:f616:: with SMTP id x22mr3924647lfe.291.1622161804749;
 Thu, 27 May 2021 17:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210525000159.3384921-1-dianders@chromium.org> <20210524165920.v8.3.I98bf729846c37c4c143f6ab88b1e299280e2fe26@changeid>
In-Reply-To: <20210524165920.v8.3.I98bf729846c37c4c143f6ab88b1e299280e2fe26@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 02:29:53 +0200
Message-ID: <CACRpkdZQ_4OMfUPZj1hXzRzqcfbhnrOHZ42NdP+giKbcz3=2VQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/11] dt-bindings: drm/bridge: ti-sn65dsi86: Add
 aux-bus child
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thierry Reding <treding@nvidia.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 2:02 AM Douglas Anderson <dianders@chromium.org> wrote:

> The patch ("dt-bindings: drm: Introduce the DP AUX bus") talks about
> how using the DP AUX bus is better than learning how to slice
> bread. Let's add it to the ti-sn65dsi86 bindings.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
(...)
>      description: See ../../pwm/pwm.yaml for description of the cell formats.>

Just use the full path:
/schemas/pwm/pwm.yaml

> +  aux-bus:
> +    $ref: ../dp-aux-bus.yaml#

Use the full path. (Same method as above)

This removes the need for ../../... ....

You do it here:

>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports

Other than that I think it looks all right!

Yours,
Linus Walleij
