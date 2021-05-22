Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8418D38D52E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhEVKgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhEVKgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:36:07 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE488C0613ED
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 03:34:41 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id t17so10267100ljd.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 03:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GYUGb+Vmff9gIUFyntVd0FDSDvGjX/ufL9sA1nyH3vE=;
        b=BoJ8q46zkHwgiqwqQriO/CkcH2ITeLf1ezMGx+UzZ8wDLGLO89xIOlJochoYDjDjWD
         VKfN6KnYmFLB6KSnYwg+92T2S7iOLUicG+XA/VkwSPkDfLa0WoMwqCiNkWhUogFjad74
         m6WXkkfcz9fq/r+HAtrmj/7OmM2bIeWOW1c7iMm5v8+ZHPQBbU5g2oeV2FQZj8sFlhI5
         Vxayp7bWj1GlHkAtIK5GTCSwY8mn0K8RTEfO50R/b0+ozUyYoiTomGDigFs5riqELBa5
         Y8zobRoz3tuQhl8Kc5/PykT1s7cppXe7/V2Hke6tIKBaDMkyYY23avqaiUk98xQ5gFcU
         2B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GYUGb+Vmff9gIUFyntVd0FDSDvGjX/ufL9sA1nyH3vE=;
        b=flSJA6qERfVNwihJLlS8kQtWMhvljGLyAv+H9bzlAtqow3rVbfJETF/BqUKWsKK3ZA
         qWDUE9zB8qX4o2FeiM33rn355NGsMb9h1x9ovpmyAbBcEUHIOE00aZTv4Htc6vXl7HDJ
         EIAMbnaE4HXopKz3UWY06HsUtyl8DB0EQAPdNuUsVSzN/c12SgHLTtu0eW/40GmnqWXd
         FDs+bwB/ByT6h5h/PJRmzAWuuVE92buj2Y4dVqgCMIwV1HCmxWeCiRe8whJPdnTY/RGY
         BNQudN6PvvcEjBd5FG0o3VJY+Oi6cZtT6ayaZFIl2b970uAWXW+ZEYTfbuL1+ueYoZCl
         VAMg==
X-Gm-Message-State: AOAM533ESNbfLV6mfkY+IV7YFfYxa9Vq4/hqLI83TRiOUjMYwQ+zzaZe
        gV0uvpZw0MN9Jqgo2Fv4Ubw1ze8UC9f4pYRPgJkRWw==
X-Google-Smtp-Source: ABdhPJz+ibDLMNP419ZZFrjVh+qJ+I+wQfZgaVgBBcDbk/aF9PHnxGEBejFwxuPQTBjJzM6NkcCaBX514iUfRyBvKSw=
X-Received: by 2002:a2e:889a:: with SMTP id k26mr9933011lji.438.1621679679967;
 Sat, 22 May 2021 03:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210517200907.1459182-1-dianders@chromium.org> <20210517130450.v7.4.I787c9ba09ed5ce12500326ded73a4f7c9265b1b3@changeid>
In-Reply-To: <20210517130450.v7.4.I787c9ba09ed5ce12500326ded73a4f7c9265b1b3@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 22 May 2021 12:34:28 +0200
Message-ID: <CACRpkda_MTBrXR-as5t_Ji8mU4=95NQ_GTDtjcERncm9yS1moA@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] drm: Introduce the DP AUX bus
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
        Rajeev Nandan <rajeevny@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 10:09 PM Douglas Anderson <dianders@chromium.org> wrote:

> Historically "simple" eDP panels have been handled by panel-simple
> which is a basic platform_device. In the device tree, the panel node
> was at the top level and not connected to anything else.
>
> Let's change it so that, instead, panels can be represented as being
> children of the "DP AUX bus". Essentially we're saying that the
> hierarchy that we're going to represent is the "control" connections
> between devices. The DP AUX bus is a control bus provided by an eDP
> controller (the parent) and consumed by a device like a panel (the
> child).
>
> The primary incentive here is to cleanly provide the panel driver the
> ability to communicate over the AUX bus while handling lifetime issues
> properly. The panel driver may want the AUX bus for controlling the
> backlight or querying the panel's EDID.
>
> The idea for this bus's design was hashed out over IRC [1].
>
> [1] https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&date=2021-05-11
>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Rajeev Nandan <rajeevny@codeaurora.org>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

I like the concept and the general idea behind this, clean and
helpful design.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
