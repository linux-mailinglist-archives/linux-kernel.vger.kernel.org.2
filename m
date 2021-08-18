Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE903F01A6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 12:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhHRKbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 06:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230013AbhHRKbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 06:31:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6372A60F38;
        Wed, 18 Aug 2021 10:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629282642;
        bh=qsct0Q+X4q0fGE+2WIZ8nYpWaRfryNn4gkgZa+MvA/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZhA1SR5fgU5ZGl5gjNePF7SXFJJecyKm4PAsHn9TmEmcoG268ldYVcwhICQZqsRjK
         mCwtACv6uMTZ5LwkSG1rJ4vn1Y2VOOu6+f0mBLel67DtyahFkUGgPAUW2vrHB47OME
         SABKKx8jz7AZarIZgAayDEGkGpC10A6on7mo3n0y3wudvSpkKb7dP5MTDD5Lfw7VML
         Cd3Ua3jn3Cr8k+xNjLBG6fDLvpXTNFQYZI8Sa6ev9mdr+bb3eB7dKSyXW99ClnU2Cw
         O9rys1iyQVG5Nn9vK53Gg8yJoa4VMmi2Ky4WzSmM+xzZE3ccKEh5spiDe/JtatkS3J
         XZMR0W/3KvqSQ==
Date:   Wed, 18 Aug 2021 12:30:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v11 01/11] phy: HiSilicon: Add driver for Kirin 970 PCIe
 PHY
Message-ID: <20210818123037.2adef2de@coco.lan>
In-Reply-To: <YRzck9WqerFtu846@matsya>
References: <cover.1628755058.git.mchehab+huawei@kernel.org>
        <7788c5ead6d6f5a6f9e5faaee4460eb2149967c4.1628755058.git.mchehab+huawei@kernel.org>
        <YRuSnXHSZHhBC40r@matsya>
        <20210818110123.33eba838@coco.lan>
        <YRzck9WqerFtu846@matsya>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 18 Aug 2021 15:40:27 +0530
Vinod Koul <vkoul@kernel.org> escreveu:

> On 18-08-21, 11:01, Mauro Carvalho Chehab wrote:
> > Hi Vinod,
> > 
> > Em Tue, 17 Aug 2021 16:12:37 +0530
> > Vinod Koul <vkoul@kernel.org> escreveu:
> >   
> > > > +	/* FIXME: calling it causes an Asynchronous SError interrupt */
> > > > +//	kirin_pcie_clk_ctrl(phy, false);    
> > > 
> > > when will you fix the fixme and pls remove the deadcode  
> > 
> > Working with clocks on this SoC is very tricky: there are lots of clock
> > lines (~70) that are critical for this device to work. Such lines are
> > enabled via the Device's firmware, and are supposed to be always
> > powered. Powering off such clock lines cause a SError.
> > 
> > Most clocks on this device are managed by the clk-hikey3670 driver.
> > At the current state of clk-hi3670, the only way for HiKey 970
> > to even boot is to add:
> > 
> > 	clk_ignore_unused=true
> > 
> > as a Kernel boot parameter. That is the solution given by the downstream
> > official distributions for HiKey970 at 96boards.
> > 
> > The fix is to flag the critical clocks with CLK_IS_CRITICAL at the
> > clk-hi3670 driver, but finding the right clock set has been a challenge.
> > 
> > I spent the last couple of weeks trying to identify the critical ones,
> > as I'm aiming to be able to use a Kernel built with a default arm64
> > one of my goals is to have this device working fine with a
> > "make defconfig" Kernel.
> > 
> > So, I added this patch:
> > 
> > 	https://lore.kernel.org/lkml/2d2de5e902ced072bcfd5e5311d6b10326b9245b.1627041240.git.mchehab+huawei@kernel.org/
> > 
> > to my tree (which reduces the set of clocks using CLK_IGNORE_UNUSED
> > from 308 to 163 clocks). Than I ran script that was dropping the
> > flag one by one, boots the new Kernel and do a sanity check. When it 
> > fails to boot, I manually dropped the patch, and re-run the script
> > to test the remaining clocks. After a couple of weeks, I reached a patch
> > with 78 clock lines that seemed critical, but the resulting patch was
> > not stable, as, depending on the day I boot the Kernel with such patch,
> > it crashes with SError in a couple of seconds after booting, or 
> > cause the Ethernet firmware to not load.
> > 
> > I intend to keep trying to find the clock lines that can't be disabled,
> > but this is very time consuming, as I couldn't find any documentation
> > about that. So, it has to be done empirically.
> > 
> > -
> > 
> > In any case, fixing it doesn't sound a critical issue for the PHY
> > driver. I mean, right now, this patchset allows removing and 
> > re-inseting the PCIe driver, which is already an improvement over the
> > original upstream driver, which was missing the power-off logic for
> > Kirin 960.
> > 
> > With this patchset, both power-off/power-on logic for both HiKey960
> > (where the PHY is inside the pcie-kirin driver) and for HiKey970,
> > which uses this PHY driver. On both devices, I tested an endless loop 
> > with rmmod/modprobe for the PCIe.
> > 
> > Besides that, in practice, removing PCIe in runtime is something that
> > people usually don't do.
> > 
> > So, while it would be cool to balance the clock disable logic,
> > I don't think this is a critical issue in this particular case.  
> 
> Okay sounds fair to me, I think fixme should be left but the c99 style
> code commented out can be removed

Agreed. I'll replace it with:

+       /*
+        * FIXME: The enabled clocks should be disabled here by calling
+        * kirin_pcie_clk_ctrl(phy, false);
+        * However, some clocks used at Kirin 970 should be marked as
+        * CLK_IS_CRITICAL at clk-hi3670 driver, as powering such clocks off
+        * cause an Asynchronous SError interrupt, which produces panic().
+        * While clk-hi3670 is not fixed, we cannot risk disabling clocks here.
+        */

Thanks,
Mauro
