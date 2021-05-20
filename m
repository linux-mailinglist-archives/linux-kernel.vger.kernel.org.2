Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9F238AD4E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242494AbhETMD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242420AbhETMDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:03:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F1EC05189C
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:25:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id s20so8753114plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzcCMdn7AWAOzOW85sX9PhoEpIf+O0kjM4jka7jzb/E=;
        b=Pbf9x3xzIaUirTOlH3BIWfV/MkY24clUI1riLlGFGq8JMA6stksgxshyVGUYnKcxtI
         dGxP+GfGQ3gRNiAxwpm39uTt/X+1gL4CS3DwKlR+Yn94H/KrBeZcC+Qiie9fCh4ZZ0er
         0YzofFRyhkn44h1FWmUhyXcPUlHJqq1FPnnLWnPHN1YrfsmT/9FqU0BlD56jlijIiGjV
         ZHFpSxG5EOqGAl1urkrJIWO1fvqh4YsVSFR4h9SesXpsSFcPoRQVBf7HgQ620chOHF35
         L2ICKkol5SqrxnQuMdBq38/elfZw7ojRNh3oFWOSkDmZU6Ro7IhI1O8QBvL8bsux1W4n
         tgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzcCMdn7AWAOzOW85sX9PhoEpIf+O0kjM4jka7jzb/E=;
        b=B1AO4jsFvg7Z+qqSXIG+ZFu5OTrYX4FLwZ5hyQSgdASes+uSUMM/UHXa2ePEdtVn65
         7QITHgM9tQz1occce+6DayDo2AafztaMq/hNLcNyzQS7Ss6x+jLDb6EfXMy6mO//aGiq
         en00pqSw/WpFU6YTNfw599fYr/Mqk3j9r97biB3ibvO7xoaLtLLOYL7yxSEi5tyI2u9q
         pJLaC/jw2M0eFe3TK9j+jTm+RYBsYRgyYDXZldWxMJJdvoHteWjvbI5DJJoXr96uhtJ/
         jrOBzXFjbUIpUHuvYVBoird/kbBOzvUChaMAs9NclGYtYiCVC4GAbGhoP2pj/ORYjxCl
         YUgw==
X-Gm-Message-State: AOAM530zmfqbPtZdw7gxuSa0vlStGGog0CJR2FhBkvOhXb6aXSd63/J8
        /+LOeec3D56VAsPUXNywuy93sSuQwONAsH4fHzRJMg==
X-Google-Smtp-Source: ABdhPJxUDB2Glgp87vkEVGP5IiXVx/gimyk58B60TNfXb6X0gR2NtYKOYoFyuSL52I22cyOY7hCHAL23y/lTqcdoWEE=
X-Received: by 2002:a17:90a:7e8f:: with SMTP id j15mr4221550pjl.19.1621506323290;
 Thu, 20 May 2021 03:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210520064508.3121211-1-pihsun@chromium.org> <CA+Px+wXnMsLbEhpwEPpkDar+6RT+jT3YPnkFDKB1wFaLn12jRw@mail.gmail.com>
In-Reply-To: <CA+Px+wXnMsLbEhpwEPpkDar+6RT+jT3YPnkFDKB1wFaLn12jRw@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 20 May 2021 12:25:12 +0200
Message-ID: <CAG3jFyt9j0B_VNvDtu_App_4+uZDHqLEYAjA-FYDoNQribZ+JQ@mail.gmail.com>
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

On Thu, 20 May 2021 at 12:12, Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Thu, May 20, 2021 at 2:45 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
> > Fixes: 60487584a79a ("drm/bridge: anx7625: refactor power control to use runtime PM framework")
> > Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
>
> Tested-by: Tzung-Bi Shih <tzungbi@google.com>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
