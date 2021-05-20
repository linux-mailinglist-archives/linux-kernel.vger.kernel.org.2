Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A66C38B4AB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhETQzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbhETQzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:55:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC86C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:54:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i17so18352269wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o7pBWJzNKsDVSAi0Kda9nVTcz1QRPwNqhV8cq3eyftA=;
        b=OJpCCVZ/L/pcOIRGd2BvgxdCB+r8SNq/NM0TjSTdRqq/BRuLbTialPysWVcRztaQzV
         o1zkqS/OZk0QRTfaMMcdUZr9qBWRpZvpa/GKZ882fkoQbV2J3w5sM/fC1Kg8SjijfaEM
         bOqLPXxBcRL724S4rgpz7Q2HbqHx/0FKvodUlVfMs3n8bWvGbs/pw9LxrhY7bifK1+8M
         9s2hzs3mXjVGtfD2JlUQfexustocAqoOJYAFLPLXQZvceJjeK2sLw/XxYFnGpAA3K4WI
         kdKJEfFZEx+do6zfnGJiiWvlB9Hy8q+UtDjKDM5whB9ooSiBFrFPq4ShLjTPhSpma6xv
         TtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7pBWJzNKsDVSAi0Kda9nVTcz1QRPwNqhV8cq3eyftA=;
        b=q4S22nxlwWkYv9oFDOvk/84i3gzWJyF8Wrz/1YG8zWzgNNSDfaxJzVH86ZkH8pnD6J
         dgj6mLPRUm0Uh7ucdrcHq4tCPLPuB1i6TEXp6TcPof4pQW8ncN10QRc8zjgW7UCegLAg
         Ew5IuO7//nimXMVNbdQfiaGXJ/E7KXCfCnueVfpuamCNnQGQ4X81066xIG1DKToS6uNF
         D2fiK4wPruLk1IcsDJ5C0UdUjWEhGXPvQzOpqCsYu3oZ6NhqiZTmTD0RAKFi/sV9lRQ0
         LLal2IwSGbLfbbkWCDoTbBSS7Ql9sU1wefBdPrMRKJccPun+RzLIY8Gw5OPi5TeVbyM8
         m+BA==
X-Gm-Message-State: AOAM53146pZaRQ6QAhfGgXmfK8H+zmifKzLy1uOZOCLAUztxha0llYIV
        OWeVmTmExFbk2PI7X2x8zBAxY2dw7vZb5koR3sfy5H7KbBuRmg==
X-Google-Smtp-Source: ABdhPJyLmgaoTM51t95U44bzxtlVZkq59RCk4epIylEp1iw8ZiHJkO7dVBh7RRx7zg0Gfa8eC6I9NzZU0pfgj/GrTrs=
X-Received: by 2002:a5d:6248:: with SMTP id m8mr5314867wrv.42.1621529652057;
 Thu, 20 May 2021 09:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210520150344.273900-1-maxime@cerno.tech>
In-Reply-To: <20210520150344.273900-1-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Thu, 20 May 2021 17:53:56 +0100
Message-ID: <CAPY8ntD8NHLU6xX+hU9n5LgoJM8_N+pvabmCpOw6AQrH_peN5g@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/vc4: Add support for the BCM2711 VEC
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Thu, 20 May 2021 at 16:03, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> The composite output in the BCM2711 is dealt using the VEC. While the earlier
> SoCs were properly supported, it wasn't functional on the BCM2711. Add the
> needed support from the RPi downstream kernel.

Thanks for upstreaming these.
As far as I'm concerned they're all good, but DT bindings aren't an
area of expertise for me.

Patches 1&3:
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Patches 2&4:
Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

This is going to need firmware from 23rd March 2021 or later in order
to ensure that the VEC can use an integer divider from the PLL. PLLC
was rejigged to run at 2592MHz so that /24 gives the VEC the 108MHz
clock it requires. (Before that it needed a special config.txt option
to set the PLLs appropriately).

 Dave

> Maxime
>
> Mateusz Kwiatkowski (4):
>   drm/vc4: Fix clock source for VEC PixelValve on BCM2711
>   dt-bindings: display: bcm2835-vec: Add BCM2711 compatible
>   drm/vc4: Separate VEC compatible variants
>   ARM: boot: dts: bcm2711: Add BCM2711 VEC compatible
>
>  .../bindings/display/brcm,bcm2835-vec.yaml    |  4 ++-
>  arch/arm/boot/dts/bcm2711.dtsi                |  1 +
>  drivers/gpu/drm/vc4/vc4_crtc.c                |  2 +-
>  drivers/gpu/drm/vc4/vc4_vec.c                 | 27 +++++++++++++++----
>  4 files changed, 27 insertions(+), 7 deletions(-)
>
> --
> 2.31.1
>
