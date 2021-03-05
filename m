Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6DA32EF3C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhCEPnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhCEPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:42:51 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B793DC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 07:42:50 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id h9so2005923qtq.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 07:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yV7w8lFfqbTYmvCeqaDZrkMh+QKf4ua1fYumR1UcKc=;
        b=F6SAI2tnULetz3th26nEFSei84A+5/Gay++NqJcsy0GFDLlWIIsqXy2OuBCr6X8SVj
         h02R5IOAhuvDQDalhmwrws3iQJJy8gPPXxshlmBbcXT2B/ebFBdjA9NbXyyWfw7w0SMA
         ZWTCuEb+r5LYLR8gJj/5R8u3QTTfBfmFq33iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yV7w8lFfqbTYmvCeqaDZrkMh+QKf4ua1fYumR1UcKc=;
        b=BHupi0SdZ3K9lso0v37ASo2ZcM7m/fDAC3HQbg/IyeBLmUBotAP8bkOCUUNkLVbqpT
         8SkpbFGogYXJKzmYQmn6HlQLLLUhR5lVfHK8OKRYGowXVnxQEx8ONVicZhgGpUDbxmu3
         tvJbpt93vp+Hewm/in4B2lwRxUmxqU/Brmzi9CeNRF9thqWqD17VO2CBU5q1VpfgSH17
         9uXZw98QsyAL7n3FhsUReEqqYINbHDy0zasS63pAnqmoqRXqCPxJohMYFjUBbcGtypdi
         1R2manxnz9Gy6EeDSvH6OzRhfPz1n6LA+SFnG4qFyqs1iKeZqimwkR9lNavw2Ea8EydK
         Gf5w==
X-Gm-Message-State: AOAM530e6OIUipTmHjLHDtJQJg4sDwZwP4gI/EEe/ozZ8M5TVPDeYDc2
        zH5MIv+Ixo9aUsagD2e4nGPjLd0TXhbI5g==
X-Google-Smtp-Source: ABdhPJwnPsC2G+pJsezu1S39Bq9hiV0H/t5H0BlSFufRZJ1OmFZizFaQCpEFi9cIRhXw8GoTJY6poA==
X-Received: by 2002:a05:622a:18c:: with SMTP id s12mr9628196qtw.131.1614958969589;
        Fri, 05 Mar 2021 07:42:49 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id e21sm2070576qtw.63.2021.03.05.07.42.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 07:42:48 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id n195so2370203ybg.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 07:42:47 -0800 (PST)
X-Received: by 2002:a25:ab54:: with SMTP id u78mr15215866ybi.276.1614958967269;
 Fri, 05 Mar 2021 07:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20210115224420.1635017-1-dianders@chromium.org>
In-Reply-To: <20210115224420.1635017-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 Mar 2021 07:42:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vwgd0FeKThVRHQjne9npRjojAWpkY4O4nXr=_vDcEK9g@mail.gmail.com>
Message-ID: <CAD=FV=Vwgd0FeKThVRHQjne9npRjojAWpkY4O4nXr=_vDcEK9g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] drm/panel-simple: Patches for N116BCA-EA1
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On Fri, Jan 15, 2021 at 2:44 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> This series is to get the N116BCA-EA1 panel working. Most of the
> patches are simple, but on hardware I have in front of me the panel
> sometimes doesn't come up. I'm still working with the hardware
> manufacturer to get to the bottom of it, but I've got it working with
> retries. Adding the retries doesn't seem like an insane thing to do
> and makes some of the error handling more robust, so I've gone ahead
> and included those patches here. Hopefully they look OK.
>
> Changes in v2:
> - Set the "unprepared_time" so if we retry we give the proper delay.
> - ("drm/panel-simple: Don't wait longer for HPD...") new for v2.
> - ("drm/panel-simple: Retry if we timeout waiting for HPD") new for v2.
> - ("dt-bindings: dt-bindings: display: simple: Add N116BCA-EA1") new for v2.
> - ("drm/panel-simple: Add N116BCA-EA1") new for v2.
>
> Douglas Anderson (5):
>   drm/panel-simple: Undo enable if HPD never asserts
>   drm/panel-simple: Don't wait longer for HPD than hpd_absent_delay
>   drm/panel-simple: Retry if we timeout waiting for HPD
>   dt-bindings: dt-bindings: display: simple: Add N116BCA-EA1
>   drm/panel-simple: Add N116BCA-EA1
>
>  .../bindings/display/panel/panel-simple.yaml  |  2 +
>  drivers/gpu/drm/panel/panel-simple.c          | 84 +++++++++++++++++--
>  2 files changed, 80 insertions(+), 6 deletions(-)

While this isn't massively urgent, I'm hoping to get some confirmation
that it's still in someone's queue to look at.  A quick "it's still in
my queue" would be much appreciated!  :-)  If I don't hear anything
then I guess next week I'll see if I can find other ways to poke folks
or find a different route to land this series.  Thanks!

-Doug
