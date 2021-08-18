Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409C43F0142
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 12:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhHRKIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 06:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232954AbhHRKIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 06:08:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED15860524;
        Wed, 18 Aug 2021 10:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629281287;
        bh=kXLnEEJGec2eHlvfXuRhjzOVRMGWMGYMdxf6pPnhCEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DoTYj/xgaXnPG/f7+VG4/U1MQnMebyvI/oU1GFrS1OgLGAh5hpohjrRAhZsRDvRcG
         eBbKUYmemu/gl8EYLGgEptDnIi/VMd6Tx+BT8ZXqyS2yqCphWLRUruI1c1sucQRgAN
         nD0hPdBJhATiSCOEa+trgP1kurPYKCH9R7UsaahfrDDZKWZjiN/Xzu7daTENW3vQET
         ymKNbReIGkjxfdRU4/yrtxmp0gX+11M0JTf6IFo3wg51ift9G3QzzY/Il0aW2iOuHU
         ImvyqLvOtQArM5QPJa1RxKrXR9reqCSAsE9537Q235bDhSvIgT6GiZv1MMhQipP36/
         bb2AjmY0Dx6ZA==
Date:   Wed, 18 Aug 2021 12:08:02 +0200
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
Message-ID: <20210818120802.3ba5fd59@coco.lan>
In-Reply-To: <20210818110123.33eba838@coco.lan>
References: <cover.1628755058.git.mchehab+huawei@kernel.org>
        <7788c5ead6d6f5a6f9e5faaee4460eb2149967c4.1628755058.git.mchehab+huawei@kernel.org>
        <YRuSnXHSZHhBC40r@matsya>
        <20210818110123.33eba838@coco.lan>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 18 Aug 2021 11:01:23 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Hi Vinod,
> 
> Em Tue, 17 Aug 2021 16:12:37 +0530
> Vinod Koul <vkoul@kernel.org> escreveu:
> 
> > > +	/* FIXME: calling it causes an Asynchronous SError interrupt */
> > > +//	kirin_pcie_clk_ctrl(phy, false);    
> > 
> > when will you fix the fixme and pls remove the deadcode  
> 
> Working with clocks on this SoC is very tricky: there are lots of clock
> lines (~70) that are critical for this device to work. Such lines are
> enabled via the Device's firmware, and are supposed to be always
> powered. Powering off such clock lines cause a SError.
> 
> Most clocks on this device are managed by the clk-hikey3670 driver.
> At the current state of clk-hi3670, the only way for HiKey 970
> to even boot is to add:
> 
> 	clk_ignore_unused=true
> 
> as a Kernel boot parameter. That is the solution given by the downstream
> official distributions for HiKey970 at 96boards.
> 
> The fix is to flag the critical clocks with CLK_IS_CRITICAL at the
> clk-hi3670 driver, but finding the right clock set has been a challenge.
> 
> I spent the last couple of weeks trying to identify the critical ones,
> as I'm aiming to be able to use a Kernel built with a default arm64
> one of my goals is to have this device working fine with a
> "make defconfig" Kernel.
> 
> So, I added this patch:
> 
> 	https://lore.kernel.org/lkml/2d2de5e902ced072bcfd5e5311d6b10326b9245b.1627041240.git.mchehab+huawei@kernel.org/
> 
> to my tree (which reduces the set of clocks using CLK_IGNORE_UNUSED
> from 308 to 163 clocks). Than I ran script that was dropping the
> flag one by one, boots the new Kernel and do a sanity check. When it 
> fails to boot, I manually dropped the patch, and re-run the script
> to test the remaining clocks. After a couple of weeks, I reached a patch
> with 78 clock lines that seemed critical, but the resulting patch was
> not stable, as, depending on the day I boot the Kernel with such patch,
> it crashes with SError in a couple of seconds after booting, or 
> cause the Ethernet firmware to not load.
> 
> I intend to keep trying to find the clock lines that can't be disabled,
> but this is very time consuming, as I couldn't find any documentation
> about that. So, it has to be done empirically.
> 
> -
> 
> In any case, fixing it doesn't sound a critical issue for the PHY
> driver. I mean, right now, this patchset allows removing and 
> re-inseting the PCIe driver, which is already an improvement over the
> original upstream driver, which was missing the power-off logic for
> Kirin 960.
> 
> With this patchset, both power-off/power-on logic for both HiKey960
> (where the PHY is inside the pcie-kirin driver) and for HiKey970,
> which uses this PHY driver. On both devices, I tested an endless loop 
> with rmmod/modprobe for the PCIe.
> 
> Besides that, in practice, removing PCIe in runtime is something that
> people usually don't do.
> 
> So, while it would be cool to balance the clock disable logic,
> I don't think this is a critical issue in this particular case.
> 
> Thanks,
> Mauro

Btw, this is one of such panic errors:

[    4.468948] hi3670_pcie_phy fc000000.pcie-phy: PIPE clk is not stable
[    4.522530] SError Interrupt on CPU4, code 0xbf000002 -- SError
[    4.522535] CPU: 4 PID: 223 Comm: systemd-udevd Not tainted 5.14.0-rc1+ #370
[    4.522537] Hardware name: HiKey970 (DT)
[    4.522539] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO BTYPE=--)
[    4.522540] pc : el1_interrupt+0x20/0x80
[    4.522542] lr : el1h_64_irq_handler+0x18/0x24
[    4.522543] sp : ffff800012903610
[    4.522543] x29: ffff800012903610 x28: ffff000108410e40 x27: ffff0001bf3e4100
[    4.522551] x26: 0000000000000000 x25: 0000000000000000 x24: ffff0001009dec10
[    4.522554] x23: 0000000040000005 x22: ffff800010ed1330 x21: ffff800012903790
[    4.522556] x20: ffff8000104e42e0 x19: ffff800012903640 x18: 0000000000000000
[    4.522559] x17: 0000000000000000 x16: 0000000000000000 x15: 0763072007450750
[    4.522563] x14: 074907500720073a x13: ffff0001b87e0000 x12: 000000000000053a
[    4.522565] x11: 00000000000001be x10: ffff0001bf2386c0 x9 : 00000000ffff0000
[    4.522568] x8 : ffff0001b87e0000 x7 : ffff0001bf2386c0 x6 : 0000000000000000
[    4.522571] x5 : ffff00010370aac0 x4 : ffff000108410e40 x3 : ffff800011f20cd8
[    4.522573] x2 : ffff000108410e40 x1 : 00000000000000c0 x0 : ffff800012903640
[    4.522577] Kernel panic - not syncing: Asynchronous SError Interrupt
[    4.522578] CPU: 4 PID: 223 Comm: systemd-udevd Not tainted 5.14.0-rc1+ #370
[    4.522579] Hardware name: HiKey970 (DT)
[    4.522579] Call trace:
[    4.522580]  dump_backtrace+0x0/0x1e0
[    4.522581]  show_stack+0x18/0x24
[    4.522581]  dump_stack_lvl+0x68/0x84
[    4.522582]  dump_stack+0x18/0x34
[    4.522583]  panic+0x16c/0x334
[    4.522583]  nmi_panic+0x8c/0x90
[    4.522584]  arm64_serror_panic+0x78/0x84
[    4.522585]  do_serror+0x58/0x5c
[    4.522586]  el1h_64_error_handler+0x30/0x50
[    4.522586]  el1h_64_error+0x78/0x7c
[    4.522588]  el1_interrupt+0x20/0x80
[    4.522588]  el1h_64_irq_handler+0x18/0x24
[    4.522589]  el1h_64_irq+0x78/0x7c
[    4.522590]  mutex_lock_io+0xf0/0x370
[    4.522591]  clk_unprepare+0x28/0x50
[    4.522591]  kirin_pcie_clk_ctrl+0x164/0x1a0 [phy_hi3670_pcie]
[    4.522592]  hi3670_pcie_phy_power_on+0x720/0xb00 [phy_hi3670_pcie]
[    4.522593]  phy_power_on+0x78/0x130
[    4.522594]  kirin_pcie_probe+0x6a8/0x88c [pcie_kirin]
[    4.522595]  platform_probe+0x68/0xe0
[    4.522596]  really_probe+0x1b0/0x42c
[    4.522596]  __driver_probe_device+0x114/0x190
[    4.522597]  driver_probe_device+0x40/0x100
[    4.522598]  __driver_attach+0xcc/0x1e0
[    4.522599]  bus_for_each_dev+0x70/0xd0
[    4.522600]  driver_attach+0x24/0x30
[    4.522601]  bus_add_driver+0x140/0x234
[    4.522601]  driver_register+0x78/0x130
[    4.522602]  __platform_driver_register+0x28/0x34
[    4.522603]  kirin_pcie_driver_init+0x24/0x1000 [pcie_kirin]
[    4.522604]  do_one_initcall+0x50/0x1b0
[    4.522605]  do_init_module+0x5c/0x254
[    4.522605]  load_module+0x21cc/0x2820
[    4.522606]  __do_sys_finit_module+0xbc/0x130
[    4.522607]  __arm64_sys_finit_module+0x24/0x30
[    4.522608]  invoke_syscall+0x48/0x114
[    4.522608]  el0_svc_common+0xc4/0xdc
[    4.522609]  do_el0_svc+0x28/0x90
[    4.522610]  el0_svc+0x2c/0x54
[    4.522610]  el0t_64_sync_handler+0x1a4/0x1b0
[    4.522611]  el0t_64_sync+0x198/0x19c
[    4.522633] SMP: stopping secondary CPUs
[    4.522634] Kernel Offset: disabled
[    4.522635] CPU features: 0x00003051,00000846
[    4.522636] Memory Limit: none

Thanks,
Mauro
