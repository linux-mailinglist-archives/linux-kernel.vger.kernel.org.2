Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DE0413DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 00:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhIUWjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 18:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhIUWjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 18:39:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8231CC061575
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:37:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w29so1064086wra.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NF/erRb1xvPiKeuz4vBloWnkjZnF25C64FmvspbwiEo=;
        b=JYjh8ATXm2rsrUDRYndqccmq6DGYrm5G5oFK0PZXiGJoNKohaS1/MHXzIgY7DdAXpw
         bL4LKJHOwlXzBZjI4gZmIAtxO4OxYq2Su5L8Di4QO7DjVkyyBL9ArU39slEuMQnHItjY
         d9fqTTl6hRWixuueYxiVGwJm4aZg7d79t694owtoAdVY8UdbwDTw3HKt2+GerXIv9Vfc
         IM9z1BHJHHud/yTUA/IZBbib8s7DIEM7z8e74ulK65VduDRs3HHTlbat7RGYmBIkfJXc
         gvf4Bk+dyL2yC3udwwiFlF899jZ3k7UFinfilIFMRsx9yzoq0QFvbKqgeFjjteG+uAmv
         FLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NF/erRb1xvPiKeuz4vBloWnkjZnF25C64FmvspbwiEo=;
        b=lNvhrwr+xKscExfI4t0jSLLif/ApzIICP8+bCJH/8RkfRiGq+7iVQQH+pVgi6jjnR7
         as4LBweP4BfijuJ6DNd0ogNTeiZuxcmdv4tWUfK6Io7pMUvCUWbhMwsv0SUPJ3spnBl1
         0zeLHFDXQ2oA0Q2P9L5EJrPk/jq4+qb5lycZdssGeHxrubYKJpuf4z2j1SQmccaJN3Pl
         JaeJj2yS1D39Z4EAYAc6cLwRbRpn6klMN9ZRSmlG0lw6YA9M6MFFkmxlQkpTSlWdAR1M
         IHkjkmoFHt2UQuJOEOVbt5hjq/1SaOTJGfys/PqEn0gR5WbkFhp+UTmjkHOycYrmvSRG
         ZkKQ==
X-Gm-Message-State: AOAM531PBVGWjQB5+hNcadVcSFDVn78AIequf8d0v6wSkbLC6pmaM+D8
        F8humiOZbz6Add0WtlK7f6rvJ96hcivYcpC9sNg=
X-Google-Smtp-Source: ABdhPJwQrPe5g07Tgw6bfhoM7DZmOuM0RlxSlbPtGLd/rX3SR68UPXcB1WP9tH3HG9lf3JQ2MI9QK4YJvhJ6cChuQtI=
X-Received: by 2002:a05:600c:1d16:: with SMTP id l22mr5431621wms.101.1632263852964;
 Tue, 21 Sep 2021 15:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210920225801.227211-1-robdclark@gmail.com> <20210920225801.227211-4-robdclark@gmail.com>
 <CAD=FV=WGmk6UY2MA4=y4gaM4G66t-qxuLtAZvUahzwg8YsLv=g@mail.gmail.com>
In-Reply-To: <CAD=FV=WGmk6UY2MA4=y4gaM4G66t-qxuLtAZvUahzwg8YsLv=g@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 21 Sep 2021 15:42:05 -0700
Message-ID: <CAF6AEGuE1y7ZdOE+=N1v7Zc=gigopS50BaADHpUOoM2TrshSCw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/bridge: ti-sn65dsi86: Add NO_CONNECTOR support
To:     Doug Anderson <dianders@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
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

On Tue, Sep 21, 2021 at 3:20 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Sep 20, 2021 at 3:53 PM Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Slightly awkward to fish out the display_info when we aren't creating
> > own connector.  But I don't see an obvious better way.
> >
> > v2: Remove error return with NO_CONNECTOR flag
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 39 ++++++++++++++++++++-------
> >  1 file changed, 29 insertions(+), 10 deletions(-)
>
> This seems fine to me:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> ...if you would like me to apply patch #2 / #3 to drm-misc-next then
> please yell.

Thanks.. I think we can give it a few days for Laurent to have a look.

This will conflict some with Maxime's bridge vs dsi-host ordering
series.. not sure how close that one is to the finish line, but I can
rebase either patch on top of the other depending on which order they
are applied

BR,
-R
