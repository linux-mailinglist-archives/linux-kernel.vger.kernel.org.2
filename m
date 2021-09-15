Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068C340C565
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhIOMkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232824AbhIOMkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:40:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F92861101;
        Wed, 15 Sep 2021 12:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631709529;
        bh=a3TBBoTEtdTFPLkbZK3vIfcp3bfPWGDzgMweU/+/KEc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JQeFAfFQTMpX9j9COx/xjYubAkwVdQ+9QK5vAcYeDUhkHWvnWh1UwFWrWVGPNjt31
         44TYS9P5M96otG/StpXCmX6X9TmPfOfhUmfyQRK1qpTGpvFXUP++EsvaCOOSWb1LOb
         qa2CPNrD1Luqcz/eOd3U+dbs3j2cujVveVqmeRpeLPI96xP8UPUVMplxGttLVLaf7z
         yvMftAzGH9z61WdDuRX5vVXsdUfHd+o30TZjy3d9BHCATGexQtk5iLs+zKBitTPZLu
         V0cDcbXl2zIla2Vaf8z90F7cs2mJJqa6HPVPefS41YsiLaOkxqjZqbj1iM6nnEwEJw
         71Wc5641S41SQ==
Date:   Wed, 15 Sep 2021 14:38:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] clk: HiSilicon: clk-hi3670: mark critical clocks as
 such
Message-ID: <20210915143819.029f920e@coco.lan>
In-Reply-To: <20210820204023.39752576@coco.lan>
References: <92f1641972bf899847e54ee041a95bb7c1bbff71.1629473738.git.mchehab+huawei@kernel.org>
        <20210820175233.GA26106@thinkpad>
        <20210820204023.39752576@coco.lan>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 20 Aug 2021 20:40:23 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Fri, 20 Aug 2021 23:22:33 +0530
> Manivannan Sadhasivam <mani@kernel.org> escreveu:
> 
> > On Fri, Aug 20, 2021 at 05:35:43PM +0200, Mauro Carvalho Chehab wrote:
> > > The fixed-rate and fixed_factor clocks are critical to the
> > > system: disabling them causes HiKey970 to not finish booting.
> > >   
> > 
> > You mean all fixed rate and fixed factor clocks are critical to the system?
> > I don't think so.

I suspect that the actual issue is related to this (at 
drivers/clk/clk.c):

	late_initcall_sync(clk_disable_unused);

Based on my tests, clk_disable_unused() is called too early,
before the init code from the drivers built as module to be called.

See, if the system is left to disable unused clocks, those are the last
messages at the console:

	[   22.348592] initcall acpi_gpio_handle_deferred_request_irqs+0x0/0xa8 returned 0 after 1 usecs, irqs_disabled() 0
	[   22.366973] calling  fb_logo_late_init+0x0/0x20 @ 1 irqs_disabled() 0
	[   22.373432] initcall fb_logo_late_init+0x0/0x20 returned 0 after 1 usecs, irqs_disabled() 0

	[   22.381800] calling  clk_disable_unused+0x0/0xe8 @ 1 irqs_disabled() 0
				==================

	<SoC dies here... no other messages>

When I disable clk_disable_unused, There are several other initcall logs
after it:

	[   22.340305] calling  acpi_gpio_handle_deferred_request_irqs+0x0/0xa8 @ 1 irqs_disabled() 0
	[   22.348594] dwmmc_k3 fc183000.dwmmc2: card claims to support voltages below defined range
	[   22.348592] initcall acpi_gpio_handle_deferred_request_irqs+0x0/0xa8 returned 0 after 1 usecs, irqs_disabled() 0
	[   22.366973] calling  fb_logo_late_init+0x0/0x20 @ 1 irqs_disabled() 0
	[   22.373432] initcall fb_logo_late_init+0x0/0x20 returned 0 after 1 usecs, irqs_disabled() 0

	[   22.356984] initcall clk_disable_unused+0x0/0xe8 returned 0 after 117 usecs, irqs_disabled() 0
				==================

	[   22.372335] initcall imx_clk_disable_uart+0x0/0x88 returned 0 after 1 usecs, irqs_disabled() 0
	[   22.387946] initcall regulator_init_complete+0x0/0x58 returned 0 after 2 usecs, irqs_disabled() 0
	[   22.404163] initcall of_platform_sync_state_init+0x0/0x20 returned 0 after 1 usecs, irqs_disabled() 0
	[   22.426508] initcall alsa_sound_last_init+0x0/0x90 returned 0 after 6239 usecs, irqs_disabled() 0
	[   22.703071] initcall inet6_init+0x0/0x358 [ipv6] returned 0 after 13341 usecs, irqs_disabled() 0
	[   22.723861] initcall xt_init+0x0/0x1000 [x_tables] returned 0 after 8 usecs, irqs_disabled() 0
	[   22.744405] initcall ip_tables_init+0x0/0x1000 [ip_tables] returned 0 after 23 usecs, irqs_disabled() 0
	[   23.467003] initcall fuse_init+0x0/0x154 [fuse] returned 0 after 392 usecs, irqs_disabled() 0
	[   23.537742] initcall drm_core_init+0x0/0x1000 [drm] returned 0 after 122 usecs, irqs_disabled() 0
	[   24.519076] initcall rfkill_init+0x0/0x12c [rfkill] returned 0 after 15654 usecs, irqs_disabled() 0
	[   24.622168] initcall hi3670_pcie_phy_driver_init+0x0/0x1000 [phy_hi3670_pcie] returned 0 after 836 usecs, irqs_disabled() 0
	[   24.665100] initcall hi3670_phy_driver_init+0x0/0x1000 [phy_hi3670_usb3] returned 0 after 1888 usecs, irqs_disabled() 0
	[   24.694668] initcall typec_init+0x0/0x1000 [typec] returned 0 after 89 usecs, irqs_disabled() 0
	[   24.732557] initcall cpu_feature_match_ASIMD_init+0x0/0x1000 [crct10dif_ce] returned 0 after 8838 usecs, irqs_disabled() 0
	[   24.746636] initcall tcpci_i2c_driver_init+0x0/0x1000 [tcpci] returned 0 after 8607 usecs, irqs_disabled() 0
	[   24.774541] initcall hisi_hikey_usb_driver_init+0x0/0x1000 [hisi_hikey_usb] returned 0 after 35860 usecs, irqs_disabled() 0
	[   24.892957] initcall rt1711h_i2c_driver_init+0x0/0x1000 [tcpci_rt1711h] returned 0 after 21500 usecs, irqs_disabled() 0
	[   24.956528] initcall wl1271_init+0x0/0x1000 [wlcore_sdio] returned 0 after 83582 usecs, irqs_disabled() 0
	[   25.039853] initcall cfg80211_init+0x0/0xdc [cfg80211] returned 0 after 26291 usecs, irqs_disabled() 0
	[   25.118288] initcall ieee80211_init+0x0/0x40 [mac80211] returned 0 after 15 usecs, irqs_disabled() 0
	[   25.335203] initcall wl18xx_driver_init+0x0/0x1000 [wl18xx] returned 0 after 134423 usecs, irqs_disabled() 0
	[   26.277300] initcall ecdh_init+0x0/0xd0 [ecdh_generic] returned 0 after 302 usecs, irqs_disabled() 0
	[   26.435409] initcall bt_init+0x0/0xcc [bluetooth] returned 0 after 63051 usecs, irqs_disabled() 0
	[   26.508033] initcall btusb_driver_init+0x0/0x1000 [btusb] returned 0 after 305 usecs, irqs_disabled() 0
	[   27.333049] initcall kirin_pcie_driver_init+0x0/0x1000 [pcie_kirin] returned 0 after 805983 usecs, irqs_disabled() 0

It may be unrelated, but, when checking .config, the above init codes
seem to belong to the drivers compiled as modules:

	CONFIG_RFKILL=m
	CONFIG_DRM=m
	CONFIG_TYPEC_RT1711H=m
	CONFIG_TYPEC_TCPCI=m
	CONFIG_WL18XX=m
	CONFIG_BT=m
	CONFIG_HISI_HIKEY_USB=m
	CONFIG_PHY_HI3670_USB=m
	CONFIG_PHY_HI3670_PCIE=m

On other words, late_initcall_sync() is calling clk_disable_unused()
too early. Either its implementation should be changed to take
module driver init into account, or something like:

	#define after_all_initcalls(fn)		__define_initcall(fn, 8)

would need to be added, in order for this to work properly.

Another alternative would be to start a thread (or a delayed thread)
via late_initcall_sync() that would only call clk_disable_unused()
after being sure that *all* driver init code will have finished.

Thanks,
Mauro
