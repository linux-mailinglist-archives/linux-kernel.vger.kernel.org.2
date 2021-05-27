Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782AC3939DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbhE1AAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 20:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbhE0X7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:59:42 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8294BC061761
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 16:58:08 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w7so3041506lji.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 16:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/6TyNLS59PYNs/WTcrtUIUT5kNAncgPO5brYD/qSY1A=;
        b=xjBfEJXiAxx2S5D2/f50gWG8/k2CgFJJIbFk2kqSHI390FVsZ7YEwcMDVZQ1y20RDp
         7GIdF6slVgZ8tAH+GuahxitTO5D+Ed+ftGyNUs0XJmcsMWJRCLEJ12XmlAThQFpZra3S
         8rMGbyYZeHob3V5s6pM04ssAVxD5yjElhavkEM+GzE7d6YqpMl+uK/bMc49bb2MBjrFR
         kQdT3duoWQB9eBUoSQJ4bZvKLuyx9kKZyeJGEb5mrYc/vh8STu//r/CR6DT7tXkpnAxr
         xT+jfNOQKNlLa6ol0Hw+v818c2JYVwdNDStYN1PjnJyu6ON6NN8HNh1cDrJOPdZlqWz7
         14Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6TyNLS59PYNs/WTcrtUIUT5kNAncgPO5brYD/qSY1A=;
        b=q+HeOunx3LGKWBXLOA2ByXR2M8ADa3JxZ9gtR56V46LpZINPUlcPt1RWdORuHDswg6
         0udB284sptls7IKkCxv3IMn2q+XFd37w/NcCHa7ZcStQ9PYZ0Nx5HcoAUUlYnqDPHf7p
         2jkPTIpgMbhWIwOrk/Qw5rCk6psu/VawQma/nIf274w7cNrzZHB3moMa0aiHj+T7KYPp
         MtA1lzBdft2mhmGmLo5M14Mnn/05Qq5TAkdb4WaKHEnSwM6wBAjovpn1lzKEpaAMRxTd
         /+UqvkrW6b4HqC4rvOuuKGtdOerX9NOYECZliopBOauTPwrm4LpmlJTbb3L/OemrH7fy
         OY+w==
X-Gm-Message-State: AOAM531+/YEEKhjazNaBA1h1T54DzX2l7XVQvUIP5lViQe6Qm79936UX
        kcUr6JuIavwJTPINTMLsDFPnkKietP3jWicsn/Rd3Q==
X-Google-Smtp-Source: ABdhPJwfaZ+od043GlQ/8lXgQWvmv1gC9smitcCReiNIAl3QGi5pTcNhd9+RmkYFFImSO1TZDwOAATrmIU4XKGVkiOM=
X-Received: by 2002:a2e:1319:: with SMTP id 25mr4449914ljt.200.1622159886872;
 Thu, 27 May 2021 16:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210524131852.263883-1-maxime@cerno.tech> <20210524131852.263883-2-maxime@cerno.tech>
In-Reply-To: <20210524131852.263883-2-maxime@cerno.tech>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 01:57:56 +0200
Message-ID: <CACRpkdbVyMBEAr0n1+d3KSwV5J3spgfW6US9vwz1=2f34Ep3dQ@mail.gmail.com>
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
        Hans Verkuil <hans.verkuil@cisco.com>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 3:19 PM Maxime Ripard <maxime@cerno.tech> wrote:

> The new gpiod interface takes care of parsing the GPIO flags and to
> return the logical value when accessing an active-low GPIO, so switching
> to it simplifies a lot the driver.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Thanks for fixing this!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
