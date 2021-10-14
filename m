Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE3B42D2DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 08:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhJNGqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 02:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhJNGqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 02:46:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 866CF60F21;
        Thu, 14 Oct 2021 06:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634193882;
        bh=nyxODPb2p/zfIUMBOeqoEw5JaXddVkpJ92sGj/BOz9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tu/q1YOH0iwtZN4UygL2yK/ZCtGlNkHkv+4CkT7UH0l4xVuQ0RoX7L+UUhHiwLmoQ
         NfBOjSwtJnumc/gpDZ/bf0b3RgDZBb7VsqBIgxU8pouXfKtfJKya8iHUa+jBpBWh9v
         gvL39KaaH4Ga85+OSJqdDyOmQGWhd0yPpGT99/BgZpXsu88D4azzsS0sviquunf5O3
         Q8icSczn0gLmisO5MtwvtGPkMxFAf1Bn5F+DHCNoevsGM0y/Uwe8LpeCie14HrGtVP
         Cei1u8e+NGD/P2zIk0PbRM2mlFyXBVxIpzMHR+IObIf28oq6Ll6zmxSo9EBj3vgcy+
         xJfWKPuHW03+Q==
Date:   Thu, 14 Oct 2021 08:44:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] clk: fix the need of booking clk_ignore_unused=true
 on embedded devs
Message-ID: <20211014084437.47a04183@sal.lan>
In-Reply-To: <20211011061718.GB1834@thinkpad>
References: <cover.1633607765.git.mchehab+huawei@kernel.org>
        <20211011061718.GB1834@thinkpad>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 11 Oct 2021 11:47:18 +0530
Manivannan Sadhasivam <mani@kernel.org> escreveu:

> Hi Mauro,
> 
> On Thu, Oct 07, 2021 at 02:06:53PM +0200, Mauro Carvalho Chehab wrote:
> > Currently, the only way to boot a Kernel with drivers built as modules on embedded 
> > devices like HiKey 970 is to pass clk_ignore_unused=true as a modprobe parameter.
> > 
> > There are two separate issues:
> > 
> > 1. the clk's core calls clk_disable_unused() too early. By the time this
> >    function is called, only the builtin drivers were already probed/initialized.
> >    Drivers built as modules will only be probed afterwards.
> > 
> >    This cause a race condition and boot instability, as the clk core will try
> >    to disable clocks while the drivers built as modules are still being
> >    probed and initialized.  
> 
> So you are mentioning a "race" condition here but it is not mentioned in the
> actual patch. 

Patch 1 explains it...

> If the issue you are seeing is because the clocks used by the
> modules are disabled before they are probed, why can't they just enable the
> clocks during the probe time?
> 
> Am I missing something?

What happens is that such clocks are enabled when the system boots,
and, when those are disabled, very bad things happen, as those
interrupt clocks used by several parts of the system.

Most of the problems happen because the ARM SoC produce SError NMI 
interrupts when some such clocks are disabled, which calls panic().

Other clocks disable some key components of the system that aren't
directly related with a driver, but, instead, controls some core
part of the device, making the SoC to wait forever for an I/O event
that will never happen.

A small set of clocks make the system unreliable, causing drivers
to fail probing. Those can either lead to panic() or break support
for a peripheral, like WiFi, USB and/or PCI.

The core issue is that clk_disable_unused() happens too early.
This is called at late_initcall_sync() time, which is triggered
before the probe/init code of the drivers compiled as modules
to be called. So, what happens is:


 BIOS enables clocks that are needed for the device to boot             
 |                                
 +-> Linux start booting
 |
 +-> builtin drivers are probed 
 |
 +--------------------------------\
 |                                |
 +-> late_initcall_sync() calls   +-> Modules start probing
 |   clk_disable_unused)          |
 |                                +-> Some drivers are probed
 |                                |   before their needed clks
 |                                |   got disabled
 |                                |
 +-> Clocks are disabled          |
 |                                |
 +-> SError -> panic()            |
                                  \ (several drivers weren't
				     probed/initialized)

The only fix for that is to postpone clk_disable_unused() to happen
after all driver probe/init are called, or to completely disable
it.

The current distributions recommended at:
	https://www.96boards.org/product/hikey970/

pass clk_ignore_unused as a boot parameter, which disables the call
to clk_disable_unused().

The only sane way to get rid of that is to fix the core to let the
drivers to finish probe/init before disabling clocks.

See, the regulators logic that disables unused power lines also
do the same: it waits for 30 seconds after late_initcall_sync()
before calling Runtime PM suspend logic.

Regards,
Mauro
