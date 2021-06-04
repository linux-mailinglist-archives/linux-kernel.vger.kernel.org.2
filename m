Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B2039C2D8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhFDVsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:48:50 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:40523 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhFDVss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:48:48 -0400
Received: by mail-lj1-f180.google.com with SMTP id u22so13343408ljh.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EUuG4qFZB8LBUFaeW8Kg5aOV0bTfac73qMPrMVkcgpU=;
        b=caeXpJBNR6ZlKosaU8pGnnDu87/vKtCbp99dJTlsr4lHu2HlNOE3y54vZyYGK96yxw
         c1KGToZhy5tFa0a3QsAa3s/hNze8We8TN0GZi3jwcXKK/Yfbc6HOaaalej3mgXTMa1Rf
         wT90fznzlFDA5x74vLXYLEXR4N8wsxT/XMx3WFLf5ytOMhIt2u3OtWqxR1VAMdtU0Z63
         lBIxxNfBX6axYCD3LBgEMbAre3o/BrHTvvpfd5yWt2k1lEjaBMEO+n57le+xHzYk1Ovg
         OcNAhjRuExi2mCeS6ISDUTu03Ykb3JGI7r5MBN1qqoZNWdsClrMRqf42CukV4WkFZwEL
         HrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUuG4qFZB8LBUFaeW8Kg5aOV0bTfac73qMPrMVkcgpU=;
        b=ep3e1abyfQrWcT+1fRxyLerxnlifjZDECUj0ivF0csNDLNhwv9j7X6gxQoqPFLGsNK
         Nk77dAB+2rpj78T7OQ0HhO7pRb4TiCd3LCnnghPePrDqGxjoOHH9GBNV7wshE9NStmhN
         1BvofohZRTfR9H7a8DVzXS5e4vKtUDioOQZ07LFhzIfU06dflco09lRRsoRRWoLv7wsB
         lkVMSh39Uk6RrCnd/dL41IzNFbudG3lbXr3A8dBsHRT88xayj5MuaUBQpibGBGAdlR+3
         djZx7jk0LaoRH7uPwok9aPsrbsNgVJfk45dua5Oy6wbxQqwlH+uYFxNITYDeAV1wxW9E
         647Q==
X-Gm-Message-State: AOAM532blYYd+TrTl+49PTELuu7cq3bvZiYR5iMJzf35DwvBvdqpTXGE
        k8EyAViXDIdd3zBlUJlCjlJ2L99ygZZ93vILK/HHOw==
X-Google-Smtp-Source: ABdhPJwUPz4c/n9oWvqrjymDxZa08iBnsLgzrcdTMrlUa6W57fT8Zivu3nIHfACQzTWee9KTNEkbGOEV9cVLTrwIt6Q=
X-Received: by 2002:a05:651c:1501:: with SMTP id e1mr5199986ljf.74.1622843147180;
 Fri, 04 Jun 2021 14:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210524131852.263883-1-maxime@cerno.tech> <20210524131852.263883-2-maxime@cerno.tech>
 <CACRpkdbVyMBEAr0n1+d3KSwV5J3spgfW6US9vwz1=2f34Ep3dQ@mail.gmail.com> <20210604080139.sccm3fggd3jvkkpa@gilmour>
In-Reply-To: <20210604080139.sccm3fggd3jvkkpa@gilmour>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Jun 2021 23:45:36 +0200
Message-ID: <CACRpkdb0Wg8MoOrJxvjkTkncpyOHE1E7oYWWMOzJoxTxWN2R=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/vc4: hdmi: Convert to gpiod
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Eric Anholt <eric@anholt.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans Verkuil <hans.verkuil@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 10:01 AM Maxime Ripard <maxime@cerno.tech> wrote:
> On Fri, May 28, 2021 at 01:57:56AM +0200, Linus Walleij wrote:
> > On Mon, May 24, 2021 at 3:19 PM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > > The new gpiod interface takes care of parsing the GPIO flags and to
> > > return the logical value when accessing an active-low GPIO, so switching
> > > to it simplifies a lot the driver.
> > >
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >
> > Thanks for fixing this!
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Is it for both patches or just this one?

I went and added Reviewed-by: to 1/2 as well so you can merge the
patches. Was simple enough even though I'm not a VC4 expert.

Yours,
Linus Walleij
