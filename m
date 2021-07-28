Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE7C3D954D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhG1SaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1SaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:30:06 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97821C061757;
        Wed, 28 Jul 2021 11:30:03 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id a93so5576451ybi.1;
        Wed, 28 Jul 2021 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y95ajZGFXcI2xcNt97PSRH6Nx3noubDMmxeuFO9Gk2o=;
        b=bNDvnmWEOW5mJA2nX6+TwYm+WfU/8VI/sTK0FcMohSw8ezYb31tiy3T70kSUl334Ry
         xdeiM/EpCKCyiSFMi0u1Kd+2OZWOal7irKJG+ep4Hq3B2pAdfGd8jzWBHpoPxfxhnG3L
         LvReE8RPlv9ta5ns0axwZXOeWMyDvKqQWNykLBTW1r0aG3vPCkIMdr2Uj5mug8kuUQJb
         EptKzl+PZMeRqA1KD4VG6evHWDZ8VxKQ08W6x5iMvu0tLmfMMKMxXC0crResOblZuc+D
         oB1CgZ/PDqBr3LXRjwIJoN9kV8K+9m9Y4v2F1qQD9LiRgLmN5hp8BY6sVfCAMB5dsOvO
         JbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y95ajZGFXcI2xcNt97PSRH6Nx3noubDMmxeuFO9Gk2o=;
        b=KzZ8tsb/3FZ7R5n4As3cQASJmiQNh7eCaeV9kD2g6qyfBYKBlpSyjjExVDm42ZIVvJ
         UjDgxVYneoeHKAr2o+tSfb3i9vo74Atu0uxd/zHv8xirgJgJXZwgnvuQmko0zFAqHCtQ
         9PjIoUAViefM1EAELgelryYoq+6/LEDEfP5+9ADFjYDGR7/QxdEPn0z29cfUD76W4aVG
         LCHuR3BxiH2m5TJYs2lgi+jhPJVM1l3GXyGCWBxLA0puiAEzgPmgW5dLgH/0yJQ23N2P
         s+0UgNFYQqCWg+Tss4gRHfOIJQDsowz48V2kd5vtL1mBiLFNjUP6a55O33OsMYs85ybS
         9/Eg==
X-Gm-Message-State: AOAM530O5JVKWS+m0pUrAXpQOyRNSEvWeIOEEy0HOpQ1IGo/NADc18ox
        PshqXAOttiM2SudUbaYySEIJwbkalQId+a9uh2R1ohmFfFjvRA==
X-Google-Smtp-Source: ABdhPJz8AaPKzA6NAbKDMFvIaMMGEpaICIrpzm6ZaC0jVYadagMj+meR/xZJdBaq+MGpF5RxyIfm4Ihl6OkuyeK+hrc=
X-Received: by 2002:a5b:48f:: with SMTP id n15mr1368515ybp.457.1627497002716;
 Wed, 28 Jul 2021 11:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210728161020.3905-1-michael.riesch@wolfvision.net>
 <20210728161020.3905-3-michael.riesch@wolfvision.net> <YQGaAFvqqc7wXrWD@lunn.ch>
In-Reply-To: <YQGaAFvqqc7wXrWD@lunn.ch>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 28 Jul 2021 14:29:50 -0400
Message-ID: <CAMdYzYo8zf0wjtAxTuYQnZQsBtw38prNuAA0j0sBEamcbzZbfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rk3568-evb1-v10: add ethernet support
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>, Simon Xue <xxm@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 1:55 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Jul 28, 2021 at 06:10:20PM +0200, Michael Riesch wrote:
> > +&gmac0 {
> > +     phy-mode = "rgmii";
>
> ...
> > +
> > +     tx_delay = <0x3c>;
> > +     rx_delay = <0x2f>;
>
> Hi Michael
>
> In general, we try to have the PHY introduce the RGMII delays, not the
> MAC. Did you try
>
> phy-mode = "rgmii-id";
>
> and remove these delay values? It is hard for me to say if that will
> work because i've no idea what 0x3c and 0x2f means? Are they
> equivalent to 2ns?

Unfortunately the driver and TRM are both rather non-specific as to
how this works.
The driver sets the tx_delay to 0x30 and rx_delay to 0x10 if these
values are not defined, or sets them both to 0 in case of rgmii_id.

Generally all rockchip boards use this value instead of the rgmii_id,
I imagine because it's more consistent to tune here than the hit or
miss support of the phy drivers.
The usual course of action is to test to find the lowest and highest
working values and take the median value to plug in here.

>
>      Andrew
