Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A0132CE53
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhCDIWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:22:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236574AbhCDIWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:22:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95B5564EEC;
        Thu,  4 Mar 2021 08:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614846092;
        bh=pBHgX8QmYMcAWzPINfXUjSXKbqcV1ueKgf8HCzd+kIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jyBz5m94PwDjhRy95q5Zp4Zs6HSh73VjC77ZBZIf8FpxDBG0CYW/hgtRe8QHjrry9
         iH5tR3twom96CxIVVvaDnMTvWQqCM0UXp6pSAz1/rMcSfWuFUHYDXXxEbDsVNJVeHz
         YokhyIi7CGD0+rau64aCoh66iaOFVOA3rP0zZ8tI=
Date:   Thu, 4 Mar 2021 09:21:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     raychi@google.com, badhri@google.com, balbi@kernel.org,
        kyletso@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/2] an additional path to control charging current
Message-ID: <YECYiL0F/Odqz91g@kroah.com>
References: <20210222115149.3606776-1-raychi@google.com>
 <20210303150126.24538-1-heiko.thiery@gmail.com>
 <CAEyMn7bc8F940WZc0Xf-p9Ri6K4sKcLvG-VfYh2o+bjuhT82NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEyMn7bc8F940WZc0Xf-p9Ri6K4sKcLvG-VfYh2o+bjuhT82NQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 04:26:38PM +0100, Heiko Thiery wrote:
> Hi,
> 
> Am Mi., 3. März 2021 um 16:01 Uhr schrieb Heiko Thiery <heiko.thiery@gmail.com>:
> >
> > Hi Ray,
> >
> >
> > > Currently, VBUS draw callback does no action when the
> > > generic PHYs are used. The patches add an additional path
> > > to control charging current through power supply property
> > > POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT.
> > >
> > > Ray Chi (2):
> > >   usb: dwc3: add a power supply for current control
> > >   usb: dwc3: add an alternate path in vbus_draw callback
> >
> > While using next-20210303 this patchset leads to the following kernel crash on my board:
> >
> > ---- 8< ----
> >
> > [    1.392084] VFIO - User Level meta-driver version: 0.3
> > [    1.398370] Unable to handle kernel NULL pointer dereference at virtual address 00000000000003a0
> > [    1.407552] Mem abort info:
> > [    1.410479]   ESR = 0x96000004
> > [    1.413668]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    1.419217]   SET = 0, FnV = 0
> > [    1.422413]   EA = 0, S1PTW = 0
> > [    1.425690] Data abort info:
> > [    1.428705]   ISV = 0, ISS = 0x00000004
> > [    1.432715]   CM = 0, WnR = 0
> > [    1.435821] [00000000000003a0] user address but active_mm is swapper
> > [    1.442458] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > [    1.448274] Modules linked in:
> > [    1.451469] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc1-next-20210303-00005-g090e892099db #126
> > [    1.461269] Hardware name: Kontron pITX-imx8m (DT)
> > [    1.466268] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> > [    1.472538] pc : devm_power_supply_get_by_phandle+0xe4/0x148
> > [    1.478455] lr : dwc3_probe+0xbac/0xfa0
> > [    1.482462] sp : ffff800011f1bb00
> > [    1.485918] x29: ffff800011f1bb00 x28: 0000000000000000
> > [    1.491467] x27: ffff800011681078 x26: ffff8000115d048c
> > [    1.497016] x25: ffff0000c089ea00 x24: 0000000000000003
> > [    1.502564] x23: ffff0000c089ea00 x22: ffff800011b89948
> > [    1.508112] x21: 0000000000000003 x20: 00000000fffffdfb
> > [    1.513660] x19: ffff0000c03f1080 x18: 00000000000000c0
> > [    1.519209] x17: 0000000000000000 x16: 0000000000000000
> > [    1.524757] x15: fffffc0000001000 x14: 0000000000000000
> > [    1.530306] x13: 0000000000000000 x12: 0000000000000030
> > [    1.535853] x11: 0101010101010101 x10: ffff800011f1ba50
> > [    1.541402] x9 : ffff0000ff784c70 x8 : 0000000000000010
> > [    1.546950] x7 : ffff0000c03a5590 x6 : 0000000000000080
> > [    1.552498] x5 : ffff0000c0098000 x4 : 00000000000003a0
> > [    1.558047] x3 : ffff800011cb2dc8 x2 : 0000000000000000
> > [    1.563596] x1 : 0000000000000001 x0 : 0000000000000000
> > [    1.569146] Call trace:
> > [    1.571700]  devm_power_supply_get_by_phandle+0xe4/0x148
> > [    1.577248]  dwc3_probe+0xbac/0xfa0
> > [    1.580890]  platform_probe+0x68/0xd8
> > [    1.584719]  really_probe+0xe4/0x3c0
> > [    1.588454]  driver_probe_device+0x58/0xb8
> > [    1.592733]  device_driver_attach+0x74/0x80
> > [    1.597100]  __driver_attach+0x58/0xe0
> > [    1.601016]  bus_for_each_dev+0x74/0xc8
> > [    1.605020]  driver_attach+0x24/0x30
> > [    1.608753]  bus_add_driver+0x184/0x1e8
> > [    1.612758]  driver_register+0x64/0x120
> > [    1.616764]  __platform_driver_register+0x28/0x38
> > [    1.621675]  dwc3_driver_init+0x1c/0x28
> > [    1.625684]  do_one_initcall+0x74/0x1d0
> > [    1.629691]  kernel_init_freeable+0x1d4/0x23c
> > [    1.634240]  kernel_init+0x14/0x118
> > [    1.637885]  ret_from_fork+0x10/0x30
> > [    1.641624] Code: 88027c01 35ffffa2 17fffe96 f9800091 (885f7c82)
> > [    1.647992] ---[ end trace c6e48cea897d0b0d ]---
> > [    1.652833] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> > [    1.660822] SMP: stopping secondary CPUs
> > [    1.664921] Kernel Offset: disabled
> > [    1.668560] CPU features: 0x00240002,2000200c
> > [    1.673106] Memory Limit: none
> > [    1.676296] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> >
> >
> > ---- 8< ----
> 
> This fixes the crash.
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index d15f065849cd..94fdbe502ce9 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1628,7 +1628,7 @@ static int dwc3_probe(struct platform_device *pdev)
>  assert_reset:
>         reset_control_assert(dwc->reset);
> 
> -       if (!dwc->usb_psy)
> +       if (dwc->usb_psy)
>                 power_supply_put(dwc->usb_psy);
> 
>         return ret;
> @@ -1653,7 +1653,7 @@ static int dwc3_remove(struct platform_device *pdev)
>         dwc3_free_event_buffers(dwc);
>         dwc3_free_scratch_buffers(dwc);
> 
> -       if (!dwc->usb_psy)
> +       if (dwc->usb_psy)
>                 power_supply_put(dwc->usb_psy);
> 
>         return 0;
> 

Fixed with d05a12f0478c ("usb: dwc3: Fix dereferencing of null
dwc->usb_psy") in my tree and should show up in the next linux-next.

thanks,

greg k-h
