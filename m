Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468F53A1208
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbhFILID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238414AbhFILIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:08:02 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC22C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:06:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id bn21so31126798ljb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edtgaudOZI4aiobavQOBXkJeOQl3hnYi6MVEV9AQq84=;
        b=ayZr7B/HMgVlC0okdohGCei7GaktNCuF+JQVg9SStH5spMXSHL3MnoVsgcy0gRKsa4
         pmC0Ygl7wVqf8VNXIa61EBQp1XUesgEtUX6+OLbue18UVTP2J47q+hd2k9/FHzfOHm5z
         v4s5fWNXcE4/VZXgXHruumXCmX5k8xgRxNY7/zlcN6NTfr5/GC2s1LXU9dTDHZshBKAk
         fI5MiFrk14taaL/0EL1VY7ryUodwSdjXb05t+Qz7hHFcs3/UjKjSPPUYSd7DSJxsvaO/
         ziRY4ZuBQwp9SwRC/wZ2DbWTwttmeVHxRTQE75htG42JEINP5VSFO96y+WHJUC6jJULz
         mX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edtgaudOZI4aiobavQOBXkJeOQl3hnYi6MVEV9AQq84=;
        b=lXFJfiiOqXlI59ofp2GknJ+1GvFmA5gblV8I0DPFULfEUoJL7O0NBJmRSOJa2VZVhR
         m94bDhpzgcX9k6Ds07ZvAVk9+0qnufRg1jjtx652MrKF4bMls6jGN7pd91Y21MGLc2qx
         Jn0PxMOr9Vj34oqMPFGq15pLoIrZh6LtZ/twtWB+iiq7hsX4mk2DQlUPZoAkmDeRg7hV
         9L2iYuyEt9pIMipb1sbf3DR6kRG9dPPERWRMZxUWNV9C7zrZQFrobM+mzbj95l3l3SUC
         8ddBtoFAzBU2MgBoNQBGAkUusHDyYMETBr7WAhq2issmzMVTRCcEUpzxcLH/dGZ178Iz
         OnRA==
X-Gm-Message-State: AOAM533m5kFETrYlxoLdH5DNoRoRPzeV/YKDz4Ikevh7DS5uFx5VGsmX
        VMCGFLJRGPzNjm5zunsC+/l/qAcO4SIpiOaUVzYT3g==
X-Google-Smtp-Source: ABdhPJzV9fO/orVbfpt+Pzff+qMI9NVxWDVHQAbz6au45P7iPdxzk0Z/yoL6wNzUHNhPVrsLwIbINGn7G3wSbYXVuXg=
X-Received: by 2002:a05:651c:1411:: with SMTP id u17mr11266433lje.438.1623236765968;
 Wed, 09 Jun 2021 04:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210607170555.4006050-1-dianders@chromium.org> <20210607100234.v9.3.I98bf729846c37c4c143f6ab88b1e299280e2fe26@changeid>
In-Reply-To: <20210607100234.v9.3.I98bf729846c37c4c143f6ab88b1e299280e2fe26@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Jun 2021 13:05:55 +0200
Message-ID: <CACRpkdZF_WgoJHExbw8R8ejVkWh7h32VfXQw8mfux_i2+sy-QA@mail.gmail.com>
Subject: Re: [PATCH v9 03/11] dt-bindings: drm/bridge: ti-sn65dsi86: Add
 aux-bus child
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Lyude Paul <lyude@redhat.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
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

On Mon, Jun 7, 2021 at 7:06 PM Douglas Anderson <dianders@chromium.org> wrote:

>  The patch ("dt-bindings: drm: Introduce the DP AUX bus") talks about
> how using the DP AUX bus is better than learning how to slice
> bread. Let's add it to the ti-sn65dsi86 bindings.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
