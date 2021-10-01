Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366C941F442
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 20:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355601AbhJASDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 14:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355596AbhJASDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:03:48 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3334FC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 11:02:04 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p80so12615812iod.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGWtQ8weImqQpPz3//oFTgRTO/g29HsvOa/9MfOVgZs=;
        b=dvH7fniNsvzTWgdm7rBSCJ2hGBhYLqkOJuwZpogrL2WwQjldz2SM84+KJPm9IGDaKC
         /fvGIgKYkZfK9mwMVG9MxIVdMEMPQiXkGWgSEFKgbYjrjiQa3pBFhqtIJD2H/wynGrr2
         qAQ6k9PAMebL4+moFHi/AnEUTMy1BQOCG1g1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGWtQ8weImqQpPz3//oFTgRTO/g29HsvOa/9MfOVgZs=;
        b=tkpZnJSQUbrQjILQbeMBJpuHk2hmAW0S7ym8bOzedYZ0DXbif4oT/QiAyiEufRdb1b
         jUUM7hwPWz+IfnDtGRYNJTWCNaYb+y7XaTHY7FpRHUAFBdf/DZwqu8eZW/FIam3z0Lwe
         eOCALNKPXg8Nq5Z803sZUL4wNnqRjvv/raP1zP8iuLxRFTfjF9WFN/eSqQ2Rxhc7B0ZX
         FuGyx6+13Pwi6iqZlw7CoVghXOPiUlFs0g9aW+XbUQEaDgCadankBJOMlUV3iLA83V3E
         vKHPhviR9ZwIn2/M9mezkwHLqNT3jnadlxd1qvkmJGJRC0EQ/Mo5sOdWEHh0M2VZ39Uh
         i6Aw==
X-Gm-Message-State: AOAM5338BBSfvcqvnJbISTXPb/zUZS9k7VfneG9MfHvBGiL8stx5LxYX
        St3kX4OiOZCmbqAMCe4KUMGXDBJpAtSjPg==
X-Google-Smtp-Source: ABdhPJzDA1Uv5S7ubXpkoxq4j/T+WETriaelP/LqavBzkcJjZDh1RSwvK2z6FYnnQqplg8fghlKSFA==
X-Received: by 2002:a05:6602:2bd4:: with SMTP id s20mr9282664iov.63.1633111323489;
        Fri, 01 Oct 2021 11:02:03 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id f6sm3990567ilj.16.2021.10.01.11.02.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 11:02:02 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id z184so12664635iof.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 11:02:02 -0700 (PDT)
X-Received: by 2002:a02:c7d2:: with SMTP id s18mr2939004jao.68.1633111321643;
 Fri, 01 Oct 2021 11:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210920225801.227211-1-robdclark@gmail.com> <20210920225801.227211-3-robdclark@gmail.com>
 <YUvKwsNS0LQf9PfO@pendragon.ideasonboard.com>
In-Reply-To: <YUvKwsNS0LQf9PfO@pendragon.ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Oct 2021 11:01:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VwORJ65v_JgXqXkUKg+Kbb-q6mrbnuEL3VG8v552SRzQ@mail.gmail.com>
Message-ID: <CAD=FV=VwORJ65v_JgXqXkUKg+Kbb-q6mrbnuEL3VG8v552SRzQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/bridge: ti-sn65dsi86: Implement bridge->mode_valid()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
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

Hi,

On Wed, Sep 22, 2021 at 5:31 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Rob,
>
> Thank you for the patch.
>
> On Mon, Sep 20, 2021 at 03:57:59PM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > For the brave new world of bridges not creating their own connectors, we
> > need to implement the max clock limitation via bridge->mode_valid()
> > instead of connector->mode_valid().
> >
> > v2: Drop unneeded connector->mode_valid()
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 25 +++++++++++++------------
> >  1 file changed, 13 insertions(+), 12 deletions(-)

There's no reason to wait on this patch. Landed to drm-misc-next.

77d40e0176a5 drm/bridge: ti-sn65dsi86: Implement bridge->mode_valid()

-Doug
