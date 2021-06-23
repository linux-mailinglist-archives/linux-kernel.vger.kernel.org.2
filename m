Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F206C3B1500
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 09:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhFWHo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 03:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhFWHo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:44:57 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050E7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 00:42:40 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id c17so312276vke.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 00:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QWcEfVlRPDE7umTD9TH5Mp46BQKHp2+rPBHbAgzkd1c=;
        b=WFXgt/vs7D5F/sigAvBFHavC7noNwNZEY3WMuYc9rSPYAmeXU54W1qD98lpSKjopo4
         FHsiEExQpdXaVi0H5zT5FbR6I9OYPkDmTHCFUuXJcmMkQn4hnC7TfzazA+kMV//ioBrh
         vr6ZK2R1x9x0L4Sl8ZUYVbYrujhi8jP65cd1V3Z7iM+RAoRfgGY+oVN6RZ3OEPz1c2bG
         CTMLaaj9I+y+K6y1MaF9h7coptJr4qXhnDoNIIJvHVUtHglGxezUa/f0LGtxQjhrCz62
         ZRKJucfcVM0GIvmsPhsQ1H7OlZAHUEirEUpZ42aVh2H/YzqUc7FSrFZDThV65pYN19GV
         nOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWcEfVlRPDE7umTD9TH5Mp46BQKHp2+rPBHbAgzkd1c=;
        b=URo5dt9mBeJTod3UfgRLK9OhaWgEc8d1tzfAPHAKYvl3BQsDS8xC+I46kC5bDd1sBO
         598STRbV5t28pal7v8ffXQfSDh29ExGlee5wmqa5RWFnuRMNGgew1Jkzea5Mf+Xb/Rjj
         rSeGz1ibLnXb7TRij6OiQmM2kjpxxiy6Ycyk8wOcCOWBGraQX86LHMmOwGzFGZpZtqgF
         vGZTKcKYVYetb/ogxHT918RQvWe6sMWgnlutf4prRzJKSYcyzzDSRiRjqfT58H3SkF+e
         /swsyUQH7sxW5vSFxB5dlgxhl3RyJONYNmI3x3vI6JNNjPB7j7A+Wec4mxhXBXoEiB+V
         y8Ww==
X-Gm-Message-State: AOAM533pOvVx99JMw4VpE+h0RFUUQfomIZUqn9ANSyT/dnMsJQBXJVfT
        cLD8gf5Hj1KWq+DUYkNBvR9XMS5SBGT1t9Os3GI=
X-Google-Smtp-Source: ABdhPJzSgJRrYHZT3DVbgEx3XWriz9RjcrKdEkq10nkDQsLGnbXsM2wBpgkXHKKS6XKOVXyhrNptRUEYB5y4a9BPyp8=
X-Received: by 2002:a1f:5487:: with SMTP id i129mr22624012vkb.14.1624434159099;
 Wed, 23 Jun 2021 00:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <YNLRn/5JkyYhYwxi@matsya> <YNLhBZokBed/jxNC@kroah.com>
 <CAMhs-H8hV8Lv2B3vCcCqgWmpg3jbhLF8kna2SoFbSd5xV3ARXw@mail.gmail.com> <YNLkUNrqIV13NtMI@matsya>
In-Reply-To: <YNLkUNrqIV13NtMI@matsya>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 23 Jun 2021 09:42:28 +0200
Message-ID: <CAMhs-H_PZttV+RQoEke7DZZmpTsuHBmjSJciTzvT6MKjwS4Nzg@mail.gmail.com>
Subject: Re: [GIT PULL]: Generic phy updates for v5.14
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Wed, Jun 23, 2021 at 9:35 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 23-06-21, 09:29, Sergio Paracuellos wrote:
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
>
> Agree, I should have _not_ picked this, sorry.
>
> I am reverting this commit and sending updated series shortly
>
> > This was turned into bool to automatically be included if CONFIG_PCI_MT7621
> > is set. This should be the only requirement to add this phy driver for
> > real hardware since it has nothing to do if there is no
> > CONFIG_PCI_MT7621. That's why Kconfig is now:
> >
> > depends on (RALINK && OF && PCI_MT7621) || COMPILE_TEST
> > Am I missing something here???
>
> Yes a module can also be added. I think you should select PHY_MT7621_PCI
> in the PCI_MT7621 Kconfig

I see. My bad understanding here, sorry. Thanks for reverting this.

Best regards,
    Sergio Paracuellos
>
> --
> ~Vinod
