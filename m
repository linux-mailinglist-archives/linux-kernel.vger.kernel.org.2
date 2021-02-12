Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFA03198EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 04:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhBLDoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 22:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhBLDoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 22:44:00 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B461BC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 19:43:14 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id r2so7776441ybk.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 19:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fO2dAUD/g2FJ6JkizhIC2grkl0fhoTQPAOqI9IcmjlU=;
        b=jGZB9cZEdWkKlfqSRphqDwh6vCabGoYHMqfUPXnOXwPxnZn+P3pTBuM8LNv2Hlcl0E
         BQatBRHsk7w2yWo/lbqu6zd7zgrOdAi0mwrA2FuWQrpP0LQSrVDHerf7CAc4VjhLkrRV
         Iq1n1cwnxkPGFzVsgjAGEmXYls+XHlFBL5bdNj538svSk/oyAwfrVsq2Y9sPoyH/F4Hz
         bNtizHFOb51gDpgYqCBz4413nrM5x48xThiqjRPhQNcXaLfAvASGuHWv1EljOtOK3jxS
         1XnamgtZvs7xOx22kAl7JSL4IqK+M89+80YaZkU8Izfpw7aDB/ogPHe3p7JotC+76c/x
         30kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fO2dAUD/g2FJ6JkizhIC2grkl0fhoTQPAOqI9IcmjlU=;
        b=W3srMyWv2fZwwlVI0AoX3zeoFtxA/r2idqqi8oSX1OngTfLgSukNBHU/2h8UL90ewA
         4i/8jXJy08rUSf7iRZM6XYZ/S4u7eyhj40CIgq8tFaiV2d5QYMhPpRDaqfcwd34YX6mD
         r9peFmbXkEDV00wTRnjOUfnkOonK/fix1VmfV8VLpk+CPtmXhgblggtVA/4S6o1ChnhH
         TFe+zsiHEVN30WOAjtnm6kd875j9fpJIcD9mUdXqIW61bmxsbXprKr5q7uLCOrMD/hUt
         VGKu/IPAx/cNheQQwQZZRILihV/WVt3c1gpXqqYThyhqdX2unCob8x+8KMgdX6UrzfCC
         GgcA==
X-Gm-Message-State: AOAM532ywIbn82i7nvOTx6LhQekZdNFnu7145apyM9/92M9YxoL+Y1WB
        JkFDn1RA8pRtevSjWAvmvLhaZkLQyaGyIaPWRwsboA==
X-Google-Smtp-Source: ABdhPJy3cT+3e9A7v46P1KP2hWtVZLhnKWkVWKXrQYhpNEZ21oRz3GTXIl0429bQq7LjcXFxTPSZeMO6YjSglBMKrNs=
X-Received: by 2002:a25:cc89:: with SMTP id l131mr1459522ybf.346.1613101392785;
 Thu, 11 Feb 2021 19:43:12 -0800 (PST)
MIME-Version: 1.0
References: <CAGETcx9YpCUMmHjyydMtOJP9SKBbVsHNB-9SspD9u=txJ12Gug@mail.gmail.com>
 <YCRjmpKjK0pxKTCP@lunn.ch> <CAGETcx-tBw_=VPvQVYcpPJBJjgQvp8UASrdMdSbSduahZpJf9w@mail.gmail.com>
 <4f0086ad-1258-063d-0ace-fe4c6c114991@gmail.com> <CAGETcx_9bmeLzOvDp8eCGdWtfwZNajCBCNSbyx7a_0T=FcSvwA@mail.gmail.com>
 <YCU3vaZ51XpksIpc@lunn.ch>
In-Reply-To: <YCU3vaZ51XpksIpc@lunn.ch>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 11 Feb 2021 19:42:36 -0800
Message-ID: <CAGETcx9gS7oq65nU9nHicMU6NXN8L=z9zuuEuEDMjtLUYyOoVg@mail.gmail.com>
Subject: Re: phy_attach_direct()'s use of device_bind_driver()
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 5:57 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Yeah, I plan to fix this. So I have a few more questions. In the
> > example I gave, what should happen if the gpios listed in the phy's DT
> > node aren't ready yet?
>
> There are four different use cases for GPIO.
>
> 1) The GPIO is used to reset all devices on the MDIO bus. When the bus
> is registered with the core, the core will try to get this GPIO. If we
> get EPROBE_DEFER, the registration of the bus is deferred and tried
> again later. If the MAC driver tries to get the PHY device before the
> MDIO bus is enumerated, it should also get EPROBE_DEFER, and in the
> end everything should work.
>
> 2) The GPIO is for a specific PHY. Here we have an oddity in the
> code. If the PHY responds to bus enumeration, before we start doing
> anything with the reset GPIO, it will be discovered on the bus. At
> this point, we try to get the GPIO. If that fails with EPROBE_DEFER,
> all the PHYs on the bus are unregistered, and the bus registration
> process fails with EPROBE_DEFER.
>
> 3) The GPIO is for a specific PHY. However, the device does not
> respond to enumeration, because it is held in reset. You can get
> around this by placing the ID values into device tree. The bus is
> first enumerated in the normal way. And then devices which are listed
> in DT, but have not been found, and have ID registers are registered
> to the bus. This follows pretty much the same path as for a device
> which is discovered. Before the device is registered with the device
> core, we get the GPIOs, and handle the EPROBE_DEFER, unwinding
> everything.
>
> 4) The GPIO does not use the normal name in DT. Or the PHY has some
> other resource, which phylib does nothing with. The driver specific to
> the hardware has code to handle the resource. It should try to get
> those resources during probe. If probe returns EPROBE_DEFER, the probe
> will be retried later. And when the MAC driver tries to find the PHY,
> it should also get EPROBE_DEFER.
>
> In case 4, the fallback driver has no idea about these PHY devices
> specific properties. They are not part of 802.3 clause 22. So it will
> ignore them. Probably the PHY will not work, because it is missing a
> reset, or a clock, or a regulator. But we don't really care about
> that. In order that the DT was accepted into the kernel, there must be
> a device specific driver which uses those properties. So the kernel
> installation is broken, that hardware specific driver is missing.

Thanks! I don't know anything about mdio (other than the generic bus
stuff) or "MAC driver" (except for "MAC address"). So  I had to read
this multiple times and I think I finally got it at a high level. So,
to summarize it and ignoring case 4, the phy device would never get
added to driver core before all it's required resources are available
just because of how it's part of an ethernet controller/mdio bus. So
by the time we force bind a PHY to the generic driver, all the
required resources should already be set up and work with the generic
driver.

So the plan to fix this warning is, when device_bind_driver() is called:
1. Delete all device links from the device (in this case, the PHY) to
suppliers that haven't probed yet because there's no probe function
that can defer at this point.
2. Then call the usual device link status update code so that it
updates the status of the remaining device links correctly. This will
avoid the warning.

This seems like a generic solution that works for PHY and for any
device that is force bound.

Thanks for the help!

-Saravana
