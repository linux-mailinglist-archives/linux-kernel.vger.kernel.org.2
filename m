Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975BA3B1485
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 09:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhFWHYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 03:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhFWHYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:24:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25AFE60FD8;
        Wed, 23 Jun 2021 07:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624432903;
        bh=Wr7Xwj0AVGz4/fmNTS3r6GUj58PDzxfEICzQj91dEMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eeh6f5ZxGETBItmTo6twrdn3krfzpeB8Nz9+B+ucHn/VNkJ5S5Qe7UHgbpI7V1VPv
         VYw0Aqy7adNJddCzLxxBAJXLsTn/xcVqXMIhHHTZT41kUCULKH1qtTh+kZBLmXtMJU
         NiYK3SzeeyA1K/4LlbVQyHcpiBYcE6A3YiEDbVd4=
Date:   Wed, 23 Jun 2021 09:21:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Linux Phy <linux-phy@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL]: Generic phy updates for v5.14
Message-ID: <YNLhBZokBed/jxNC@kroah.com>
References: <YNLRn/5JkyYhYwxi@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNLRn/5JkyYhYwxi@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 11:45:59AM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive Generic phy subsystem updates for v5.14
> 
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.14
> 
> for you to fetch changes up to f7eedcb8539ddcbb6fe7791f1b4ccf43f905c72f:
> 
>   phy: ti: dm816x: Fix the error handling path in 'dm816x_usb_phy_probe() (2021-06-21 12:04:18 +0530)
> 
> ----------------------------------------------------------------
> phy-for-5.14
> 
>   - Updates:
>         - Yaml conversion for renesas,rcar-gen3 pcie phy and
> 	  rockchip-usb-phy bindings
>         - Support for devm_phy_get() taking NULL phy name
> 
>   - New support:
> 	- PCIe phy for Qualcomm IPQ60xx
> 	- PCIe phy for Qualcomm SDX55
> 	- USB phy for RK3308
> 	- CAN transceivers phy for TI TCAN104x
>         - Innosilicon-based CSI dphy for rockchip

Why is PHY_MT7621_PCI only y/n?  Shouldn't this be able to be built as a
module?

The USB phy enables this driver, which now forces me to build it into my
kernel, which does not seem like a wise idea.  I'm not sure which commit
in this series does this, but that isn't a good thing.

Ah, it's 6eded551cefe ("phy: ralink: Kconfig: convert mt7621-pci-phy
into 'bool'"), why is that needed?  We are working to turn more code
into modules, not force them to be built in, this feels like the wrong
way to go :(

I don't want to take this series because of this at the moment.

thanks,

greg k-h
