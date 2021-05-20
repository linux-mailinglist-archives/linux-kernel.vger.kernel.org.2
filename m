Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF5E38ACE8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbhETLvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242719AbhETLkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:40:24 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2284C04981A
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:12:13 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id g11so10766525ilq.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hM9iWHQw8llRbnnbpFxr+yRm64ZVy+q1ZE0MMw/cpmY=;
        b=GeBzHXR2RcwkBbBvN9dKO+0RWo4eNKFGpi1tU9lKPekIem6dxP3/52yhjMRD/Oidcq
         zZavPug6l5BXmxDgui4b789qBPszWqOV+6l8iREx5MoVPzOp3n3pgn22DX3qzUATsGxo
         rks/P1XAW7x1p4AOMBxvszjx4BJ0i6XAtg749OFi5mqONDqF0/WMz9g4cORdVB7bdsWc
         Bwy4bKNMD/LjExq50rxEk2b/AmZKRPd9rDDWMDlfwmLiMGF53PkorP5fpuVSiByhJHpI
         4VapdKMTTQBWMHbFB/R3WKbhgsR1XXvisGx7DPGBpY7Nhm4+nNxnnF2gSfF3zD0ZSmGl
         v9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hM9iWHQw8llRbnnbpFxr+yRm64ZVy+q1ZE0MMw/cpmY=;
        b=js9+3nO/9M/8L7k5afLKMMj8HGNtlZouUDsUGxHVur/D+Uxu4OdxVYDCa9lDzK9Ohq
         guTiW+q62hzfA5oHvPiK2tpqMvDUWdBXKoG7h2xr5mF1WcBa6g6cMPZpgfjfY7dbgCsf
         NYthQ9l3+uc0P0KYNx0dlE8eEnRJNYPhEGA4WAzUMg7pWv2xi/p3/qlUmMycunTimefQ
         NbJDTjPQKreJP6QMTmJltnDS1jg5KZISLMNLdX7e+Dwbqduvp1qvGIEwZC4L9ez26Wag
         2NAoSjiaQe13nRF6jRGnfeAJOTJJbhAIgA5jHF0i9+6by2MjolFEuPWADYKKn86GKrne
         TC1w==
X-Gm-Message-State: AOAM533S/xdF7wYMet24TozMlEgdWD1ABTt5HsRbQDV24Csldk72oL4V
        8UrV09iY4EOhcrVNVl7kIWpUuj1ryrjwY7quncXS3w==
X-Google-Smtp-Source: ABdhPJz2wgYK5wtzmQSOAagwO9bVo75O8m6IquGkE4Ecf2XrkgakHVTo8l14fAfQGKSdQ65mecXLc9MikZT1ap2eQuc=
X-Received: by 2002:a05:6e02:92f:: with SMTP id o15mr4811751ilt.127.1621505533011;
 Thu, 20 May 2021 03:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210520064508.3121211-1-pihsun@chromium.org>
In-Reply-To: <20210520064508.3121211-1-pihsun@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 20 May 2021 18:12:02 +0800
Message-ID: <CA+Px+wXnMsLbEhpwEPpkDar+6RT+jT3YPnkFDKB1wFaLn12jRw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Synchronously run runtime suspend.
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 2:45 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
> Fixes: 60487584a79a ("drm/bridge: anx7625: refactor power control to use runtime PM framework")
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

Tested-by: Tzung-Bi Shih <tzungbi@google.com>
