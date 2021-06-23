Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1DA3B1504
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 09:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFWHps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 03:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhFWHpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:45:47 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32D2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 00:43:29 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id s72so309293vkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 00:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZFZ3Qf8H+XBIa/oMisZw/D3Im/ahJP0cwpid0U6HpQ=;
        b=evyDOdVUL1vKeraZPbu3NIBKCJQBy9XLmCOqpla+U9XapwVrklQH9J71PfiGp00kHO
         eniZFbVjF6Ehznv42jnyGHVUPDXz2drD8VB1IGIJ2Rc8Pyv9qgB7MT2lC4z3iH9ONVA9
         nQOc+nonFaFSp4VsoRYPKoIyHDcFc/T3DetIP1yU+BEy9+H4JjksUz9IkYfFuALZYCvR
         3dRTnEKijkcPnUJK4FRX0j2UvqlbgiuyDOk3d5Bz9hcIIaRDgZRNZchbcEBRPMFYvve8
         Z5KGWY+sckgu8gD0B9phkRlcjUQhR1dEUOmqQCeTRLkrmYQXOru6XrVvlTObd7ZxbbWq
         nGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZFZ3Qf8H+XBIa/oMisZw/D3Im/ahJP0cwpid0U6HpQ=;
        b=ZwIG56dqiPsefN9se7f3vOk2sMVwVsH8cWK+YoXilnwtPdbr2KqyjP6rUjjKVgi/aK
         HguJ9eHxIeQGzG9z/yR0gt51rtCLqziVPmwhBw2Madpm4XE7rUD73vLN68iwZbE2kmOi
         gj5P5R+lPm2kfKQdI9301tvrskBF5y3ahbABeykRcltQTuvDqd3SykR0FmwxvN0kxxLc
         yXag9JLj8OLN5/xnVpIs8G1p2EmJ69GU2TUsNRtlrvlpBYOGnr3b+p9smxJnJ/WRwQxI
         ubWMx8m1nbrW7zFP+6DYCH2Dd2/FGS5Ez7DgoQTao9twLqqc74fbsNnoADl4iUTj6eQp
         JdkQ==
X-Gm-Message-State: AOAM533RmLsM1L3xRISpLKE3lP2EK1mMGtC/sEQFMeJ/zDvcbenRcdt+
        5KUp+mODUuS/4T3KhjMpnXeXMIAwOnvUJI7GPDQ=
X-Google-Smtp-Source: ABdhPJyPkjbAwuzy5EfZ9X+hciMT78zICSfqEwCYGFxexmdHDyDnl6ZlOok2f/Fsv79wCJnWSa8C6Q/ODtUcCiPOReE=
X-Received: by 2002:a1f:fecc:: with SMTP id l195mr19530608vki.21.1624434208862;
 Wed, 23 Jun 2021 00:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <YNLRn/5JkyYhYwxi@matsya> <YNLhBZokBed/jxNC@kroah.com>
 <CAMhs-H8hV8Lv2B3vCcCqgWmpg3jbhLF8kna2SoFbSd5xV3ARXw@mail.gmail.com> <YNLkYPa/+Gs88loj@kroah.com>
In-Reply-To: <YNLkYPa/+Gs88loj@kroah.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 23 Jun 2021 09:43:17 +0200
Message-ID: <CAMhs-H-dvbenJbuA-rvnzsW_85Rp+Ox8yW3+0g7M8=C7tTO3dA@mail.gmail.com>
Subject: Re: [GIT PULL]: Generic phy updates for v5.14
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Jun 23, 2021 at 9:36 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 23, 2021 at 09:29:06AM +0200, Sergio Paracuellos wrote:
> > Hi Greg,
> >
> > On Wed, Jun 23, 2021 at 9:21 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jun 23, 2021 at 11:45:59AM +0530, Vinod Koul wrote:
> > > > Hello Greg,
> > > >
> > > > Please pull to receive Generic phy subsystem updates for v5.14
> > > >
> > > > The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> > > >
> > > >   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.14
> > > >
> > > > for you to fetch changes up to f7eedcb8539ddcbb6fe7791f1b4ccf43f905c72f:
> > > >
> > > >   phy: ti: dm816x: Fix the error handling path in 'dm816x_usb_phy_probe() (2021-06-21 12:04:18 +0530)
> > > >
> > > > ----------------------------------------------------------------
> > > > phy-for-5.14
> > > >
> > > >   - Updates:
> > > >         - Yaml conversion for renesas,rcar-gen3 pcie phy and
> > > >         rockchip-usb-phy bindings
> > > >         - Support for devm_phy_get() taking NULL phy name
> > > >
> > > >   - New support:
> > > >       - PCIe phy for Qualcomm IPQ60xx
> > > >       - PCIe phy for Qualcomm SDX55
> > > >       - USB phy for RK3308
> > > >       - CAN transceivers phy for TI TCAN104x
> > > >         - Innosilicon-based CSI dphy for rockchip
> > >
> > > Why is PHY_MT7621_PCI only y/n?  Shouldn't this be able to be built as a
> > > module?
> > >
> > > The USB phy enables this driver, which now forces me to build it into my
> > > kernel, which does not seem like a wise idea.  I'm not sure which commit
> > > in this series does this, but that isn't a good thing.
> > >
> > > Ah, it's 6eded551cefe ("phy: ralink: Kconfig: convert mt7621-pci-phy
> > > into 'bool'"), why is that needed?  We are working to turn more code
> > > into modules, not force them to be built in, this feels like the wrong
> > > way to go :(
> >
> > This was turned into bool to automatically be included if CONFIG_PCI_MT7621
> > is set. This should be the only requirement to add this phy driver for
> > real hardware since it has nothing to do if there is no
> > CONFIG_PCI_MT7621. That's why Kconfig is now:
> >
> > depends on (RALINK && OF && PCI_MT7621) || COMPILE_TEST
> > Am I missing something here???
>
> It is forcing it to be built into the kernel, why can it not just be a
> module?  You took that ability away here by making the value a 'bool'.

I see. Thanks for clarification and sorry for the inconvenience.

Thanks,
    Sergio Paracuellos
>
> thanks,
>
> greg k-h
