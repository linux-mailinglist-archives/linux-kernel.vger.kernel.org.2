Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880F03B14B6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 09:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhFWHiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 03:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhFWHiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:38:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04F536128A;
        Wed, 23 Jun 2021 07:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624433747;
        bh=pCOhVJN/mvleiRbdksd7EMIoZK9+lmr+dtQTNulvelw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MjhbzRFvwHvypgQZoJh5SxzpMVOS+MbnMFxQH6BZ6fspyIZpjteJhlTekt6oyhSvp
         N13atBa15MCb3ULaLM3fJe2BDYGygXhjVo7MEreOX4Ltp7yKk//J4dlY75QnfkW8cj
         c1laWpwl1fAGavsgwXPkbd/AvX/oyTqYgU/spWBpsm2mcgaWQSd7UK5AUZyfj0skVj
         8eMcjYR7NgQZa2nRCa5X7mNqo4NaOaTtSH5xRJbAKxy1cC6CF58FPPZiRqYLoXV6V9
         Zt5lpqRbSqLgc0BPl0Tecr9hQPyHfk9gEnLaf7N2gBBMMDymQRJ4noOpRhelYjioy1
         AyWOb8IOAG5jQ==
Date:   Wed, 23 Jun 2021 13:05:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL]: Generic phy updates for v5.14
Message-ID: <YNLkUNrqIV13NtMI@matsya>
References: <YNLRn/5JkyYhYwxi@matsya>
 <YNLhBZokBed/jxNC@kroah.com>
 <CAMhs-H8hV8Lv2B3vCcCqgWmpg3jbhLF8kna2SoFbSd5xV3ARXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H8hV8Lv2B3vCcCqgWmpg3jbhLF8kna2SoFbSd5xV3ARXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-21, 09:29, Sergio Paracuellos wrote:
> Hi Greg,
> 
> On Wed, Jun 23, 2021 at 9:21 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 23, 2021 at 11:45:59AM +0530, Vinod Koul wrote:
> > > Hello Greg,
> > >
> > > Please pull to receive Generic phy subsystem updates for v5.14
> > >
> > > The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> > >
> > >   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.14
> > >
> > > for you to fetch changes up to f7eedcb8539ddcbb6fe7791f1b4ccf43f905c72f:
> > >
> > >   phy: ti: dm816x: Fix the error handling path in 'dm816x_usb_phy_probe() (2021-06-21 12:04:18 +0530)
> > >
> > > ----------------------------------------------------------------
> > > phy-for-5.14
> > >
> > >   - Updates:
> > >         - Yaml conversion for renesas,rcar-gen3 pcie phy and
> > >         rockchip-usb-phy bindings
> > >         - Support for devm_phy_get() taking NULL phy name
> > >
> > >   - New support:
> > >       - PCIe phy for Qualcomm IPQ60xx
> > >       - PCIe phy for Qualcomm SDX55
> > >       - USB phy for RK3308
> > >       - CAN transceivers phy for TI TCAN104x
> > >         - Innosilicon-based CSI dphy for rockchip
> >
> > Why is PHY_MT7621_PCI only y/n?  Shouldn't this be able to be built as a
> > module?
> >
> > The USB phy enables this driver, which now forces me to build it into my
> > kernel, which does not seem like a wise idea.  I'm not sure which commit
> > in this series does this, but that isn't a good thing.
> >
> > Ah, it's 6eded551cefe ("phy: ralink: Kconfig: convert mt7621-pci-phy
> > into 'bool'"), why is that needed?  We are working to turn more code
> > into modules, not force them to be built in, this feels like the wrong
> > way to go :(

Agree, I should have _not_ picked this, sorry.

I am reverting this commit and sending updated series shortly

> This was turned into bool to automatically be included if CONFIG_PCI_MT7621
> is set. This should be the only requirement to add this phy driver for
> real hardware since it has nothing to do if there is no
> CONFIG_PCI_MT7621. That's why Kconfig is now:
> 
> depends on (RALINK && OF && PCI_MT7621) || COMPILE_TEST
> Am I missing something here???

Yes a module can also be added. I think you should select PHY_MT7621_PCI
in the PCI_MT7621 Kconfig

-- 
~Vinod
