Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F93E3E9B99
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 02:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhHLAZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 20:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbhHLAZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 20:25:36 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B5FC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 17:25:12 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id a7-20020a9d5c870000b029050333abe08aso5543974oti.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 17:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=aBF5XsmOwLOwhoJ7V4vA+C2s7+F6s8RQ06qQNUqSroI=;
        b=h+56UWETmWksgXZ6odjCSUhkS60nq9twTFk5O3iDfPkw9SlJ2Q9MC4k1YZ13wA9QSI
         cz2Pc3wlRcNYEKwZ643eM+MtGzStloEbEFNy4YhjnGGkil5U0nH2pe9f1iubEMhKDwtU
         PwWNtWc+gGsmqzXBvFg2DTN9n6mT6P+9a9T3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=aBF5XsmOwLOwhoJ7V4vA+C2s7+F6s8RQ06qQNUqSroI=;
        b=pjJc0OAtKE6EnWi27Qkg57YPx7h/LDEz/YXePB9iG8NIXlMsegxvd9j6xAl4qsLkWb
         yki2uQzpe1xuxmtNmXjjz+HErFAahlf5VnyYpEGpvFBDgOuNeiuHzJjkHB7P9c2ft/+9
         TpbUfxQE3uPmSyLJpN1ggxSHSs/BjAnUoOOsKAZaX+25mSgVyLZm+yVpSuUU0NwApGK8
         PEpYcs4PfD/H5plgXYydUzlJgtoPs9lKxho9wicDrXh4mthsBweAJrL7/PCy/ShxtSxQ
         PGAF957ZZNW5z+1TbVS01IglP3dfhPgDMtYCIhXghXq8CR0CMEE2Jq6QgJK+FOIxeznY
         Wb+w==
X-Gm-Message-State: AOAM531lFdxVa5K4dPQaQ3PsIC/SgsyoePJSk7rZYTLqJYDNQcodiDDY
        K/hdzDpWOKmtcQbQpmDoPWC/pBl8Q9h2ggcpKvyzVA==
X-Google-Smtp-Source: ABdhPJx0FoYmfQ9zAKiWN4L09yMr9AcpGP2BwH3WsltDn0CSuMhuEFOx+zQVeSaXHI+pNsLrGV3maXsnDszKO/B14Ss=
X-Received: by 2002:a9d:5542:: with SMTP id h2mr1268834oti.25.1628727911938;
 Wed, 11 Aug 2021 17:25:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Aug 2021 17:25:11 -0700
MIME-Version: 1.0
In-Reply-To: <20210811235253.924867-2-robdclark@gmail.com>
References: <20210811235253.924867-1-robdclark@gmail.com> <20210811235253.924867-2-robdclark@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 11 Aug 2021 17:25:11 -0700
Message-ID: <CAE-0n51mqTwUdT1cmL=ubcFppFZ8GwerPBWCJ2QsyRtzG9vkjw@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/bridge: ti-sn65dsi86: Avoid creating multiple connectors
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Clark (2021-08-11 16:52:47)
> From: Rob Clark <robdclark@chromium.org>
>
> If we created our own connector because the driver does not support the
> NO_CONNECTOR flag, we don't want the downstream bridge to *also* create
> a connector.  And if this driver did pass the NO_CONNECTOR flag (and we
> supported that mode) this would change nothing.
>
> Fixes: 4e5763f03e10 ("drm/bridge: ti-sn65dsi86: Wrap panel with panel-bridge")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

Thanks for saving me the packaging effort.

Reported-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
