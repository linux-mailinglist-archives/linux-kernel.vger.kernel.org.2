Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5AA38AD5D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240166AbhETMEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbhETMDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:03:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A06AC0611A7
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:28:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 69so8771955plc.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/KWRCsGKMUP2JAZnha37ZjnkZMEQx6lVgM8h9scsc7w=;
        b=M3oXNQTwNcGsOs/VcEwNm2YeWm8XEow0w8yaKf4YpYNeFKLqQ0CBuipLIHVMMtxvs1
         taHLYVgcwgF3jcmdZd0/7xu7fPfolPRJ+tBzKaAKK4QTsG+YA1mZCKL8XtVw863SDnGd
         KzS/R62sjDv+NoUXZLKiP6RhE72Vwa2H2Ykk0a31x55+KETfxmoyVaMWv9OSYP+hCtza
         M82MFJO3Y1N3dFB7nIbrzhtPQBmdGnKR+p2YYzW6fyOqqOwj01ALIzvi7BqS4aytqI19
         Sv/CPFsHlW4OJIqie9WpaYumocGMixGeDmmOVctYNNSbvH2Nr2RLlsW32Dk5Zq3ZAuSO
         G47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/KWRCsGKMUP2JAZnha37ZjnkZMEQx6lVgM8h9scsc7w=;
        b=milie3qgXhZc+JaqHEJ/socw2V4vQqfLZqxf9psnkmAGP5JMFrU5tr9CLQa7Cv7i0p
         InsQ7c/X0DwqTo0EgdbWKFIUuF6LQ0KyiuEZjEjwJEgkmzyROFUcOPeeTUo8lcaT8JOS
         NidjDh3z9MNaR42xkSwqhq6Kw6i0/QY55wYk7YsgkXhqtGdDEXZ9W20f/oDvRz1AltVm
         c+sBGr4aY6ImGCsuvw2EzfWwYaSdNrITJKqitOn98eB3SUqm7Lm4UqimdJCRoQMTiXPg
         ALsVEYA4QyULy0sFyGJTXW2SxlTucAA1luVFEBxlfDB0qsBePHKdUPznz49zzppfqd3S
         rzwQ==
X-Gm-Message-State: AOAM532ogZcUIJxtiCAZ/0+as1t/+mUcKNgaN3cEEHKYplkY6VvEk8wp
        9y31dpVHXvvMyzqFbMtMQ11ARqQ2Ff9YFXKokDZAAA==
X-Google-Smtp-Source: ABdhPJz1Akg6leOAzD4rkKpl4SGUm+AMhGdX93niDWgYb1yUT0yQdQZbKeu60FjyaAaofzU3zQf07zJ6P3gIOwA+rNE=
X-Received: by 2002:a17:90a:7e8f:: with SMTP id j15mr4233113pjl.19.1621506499815;
 Thu, 20 May 2021 03:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210520064508.3121211-1-pihsun@chromium.org> <CA+Px+wXnMsLbEhpwEPpkDar+6RT+jT3YPnkFDKB1wFaLn12jRw@mail.gmail.com>
 <CAG3jFyt9j0B_VNvDtu_App_4+uZDHqLEYAjA-FYDoNQribZ+JQ@mail.gmail.com>
In-Reply-To: <CAG3jFyt9j0B_VNvDtu_App_4+uZDHqLEYAjA-FYDoNQribZ+JQ@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 20 May 2021 12:28:08 +0200
Message-ID: <CAG3jFyvyGrxcv8sLvjEhrQva0c3KHxU4g5LDnM=ZC8JvVL2Jjw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Synchronously run runtime suspend.
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
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

Applied to drm-misc-next

On Thu, 20 May 2021 at 12:25, Robert Foss <robert.foss@linaro.org> wrote:
>
> On Thu, 20 May 2021 at 12:12, Tzung-Bi Shih <tzungbi@google.com> wrote:
> >
> > On Thu, May 20, 2021 at 2:45 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
> > > Fixes: 60487584a79a ("drm/bridge: anx7625: refactor power control to use runtime PM framework")
> > > Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> >
> > Tested-by: Tzung-Bi Shih <tzungbi@google.com>
>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
