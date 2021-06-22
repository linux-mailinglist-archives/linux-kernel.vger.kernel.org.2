Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A50C3B0DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 21:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhFVUAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhFVT77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 15:59:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B22DC061574;
        Tue, 22 Jun 2021 12:57:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l1so240528ejb.6;
        Tue, 22 Jun 2021 12:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eovzw/udn4hicrC407R2X9SrTc2QGxyjor98KY9344o=;
        b=ofg0zEesjw/TVIggXvcIPH9DhGxXKSu3YWaBmok3qYhCzDJdLDF2FsMeqpMBwexpQ/
         ksHDL089XVMVKt9O40sZVVDvQBckA/2cpF9IeuFFXqS4ubOEH3x1LiIXWt8x5IdqEw2n
         rVm53TetQoqR93n+1YkQuSikga5VtiWvaGy+qQg5lQkmI1y9gFFwmxC17kfi+TejkrGV
         6JS26EHtHAtIs2d54h/qG0RYACCtShPOI2ByFu6zYIdaDcQ9n6pfJPTaAw8zqNCk4YE6
         t8BGqlqrkWWaTQN2Gk3MI9chqPSmFQC0tIYlhYPAykP7D7bGVQ+rOC4+OH97GwnxU6Tu
         uwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eovzw/udn4hicrC407R2X9SrTc2QGxyjor98KY9344o=;
        b=avJXnHK9E561N/ve6Lz4fEx7STvcheORLl4U4hFSv+2qQJkcomifg6AI9tTg35PNOp
         PIZa9cvLbiNRZAwii7+CH8fFn8zYgkbZlCwimIrLeRigWa7sVaaIb4b6kI1q51Rr3Snz
         8zADe0o6x9hIi0qCwsHzje5CAOx1d9ONiS+3wWRORJdLgo91RtKaQLKbfeaCMZlfSb5E
         qASDmw+kP/qgX3dT1WDqwowoEz85pi1CelCKeAgYOU/1NyuvljF31YlCI57TA6eLys8Y
         wAaXPlsYbk7TVt2Qvy8OUqZaBUoOQjngPKnLKbjXmsiAb54rnwyLZcxwxj3H7pilgAZ7
         bnxw==
X-Gm-Message-State: AOAM532UMWigkEQUvktdopd8qWewluqjxTZByJC0YkS3pjsx/xoujA6J
        bz4b0P/hwqqZyIFGOraPpL3up4cErqascaVijio=
X-Google-Smtp-Source: ABdhPJyKd7e5C4Ph84g4B35RZoEdjwc6rb5o8Q7KdW9xfBBwAEDRGr7WOP7Jo/YB2xiUfT0KiK2lMC5guhRIKZ2smks=
X-Received: by 2002:a17:906:f188:: with SMTP id gs8mr5734432ejb.527.1624391859989;
 Tue, 22 Jun 2021 12:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210604190338.2248295-1-martin.blumenstingl@googlemail.com>
 <20210604190338.2248295-3-martin.blumenstingl@googlemail.com> <YNAvItt8BQH1QmQT@vkoul-mobl>
In-Reply-To: <YNAvItt8BQH1QmQT@vkoul-mobl>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 22 Jun 2021 21:57:28 +0200
Message-ID: <CAFBinCAOi0EuucaQcJvgzV3o9fu=26u2ivAiQVidrmXTzQRQfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] phy: amlogic: Add a new driver for the HDMI TX PHY on Meson8/8b/8m2
To:     Vinod Koul <vkoul@kernel.org>
Cc:     robh+dt@kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kishon@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

thanks for taking the time to review this!

On Mon, Jun 21, 2021 at 8:18 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 04-06-21, 21:03, Martin Blumenstingl wrote:
> > Amlogic Meson8/8b/8m2 have a built-in HDMI PHY in the HHI register
> > region. Unfortunately only few register bits are documented. For
> > HHI_HDMI_PHY_CNTL0 the magic numbers are taken from the 3.10 vendor
> > kernel.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  drivers/phy/amlogic/Kconfig              |  11 ++
> >  drivers/phy/amlogic/Makefile             |   1 +
> >  drivers/phy/amlogic/phy-meson8-hdmi-tx.c | 150 +++++++++++++++++++++++
> >  3 files changed, 162 insertions(+)
> >  create mode 100644 drivers/phy/amlogic/phy-meson8-hdmi-tx.c
> >
> > diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> > index db5d0cd757e3..e6c3a2a8b769 100644
> > --- a/drivers/phy/amlogic/Kconfig
> > +++ b/drivers/phy/amlogic/Kconfig
> > @@ -2,6 +2,17 @@
> >  #
> >  # Phy drivers for Amlogic platforms
> >  #
> > +config PHY_MESON8_HDMI_TX
> > +     tristate "Meson8, Meson8b and Meson8m2 HDMI TX PHY driver"
> > +     default ARCH_MESON
> > +     depends on (ARCH_MESON && ARM) || COMPILE_TEST
>
> depends on ARM seems redundant..
config ARCH_MESON exists in arch/arm as well as arch/arm64
my idea was to hide it from the 64-bit SoCs since it's not used there

While reading your comment I spotted something for myself:
I think "default ARCH_MESON" should not be there.

> > + * Meson8, Meson8b and Meson8m2 HDMI TX PHY.
> > + *
> > + * Copyright (C) 2020 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> 2021..
good catch, I'll fix this in v2


Best regards,
Martin
