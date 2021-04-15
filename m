Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5964360BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhDOOiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:38:16 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39699 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232759AbhDOOiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:38:15 -0400
Received: (qmail 1532246 invoked by uid 1000); 15 Apr 2021 10:37:51 -0400
Date:   Thu, 15 Apr 2021 10:37:51 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dmitry Vyukov <dvyukov@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, abrestic@google.com,
        paulburton@google.com
Subject: Re: UBSAN: array-index-out-of-bounds in ehci_hub_control
Message-ID: <20210415143751.GB1530055@rowland.harvard.edu>
References: <CACT4Y+YOXJ15j6c_8N-09xpxTHXO3J07K83p4p+SAFa4=47ayw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YOXJ15j6c_8N-09xpxTHXO3J07K83p4p+SAFa4=47ayw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 04:10:45PM +0200, Dmitry Vyukov wrote:
> Hi,
> 
> I've got this report while booting v5.10.13 kernel, but upstream code
> seems to be the same.
> The access to port_status, the code is:
> 
> struct ehci_regs {
>     u32 port_status[0]; /* up to N_PORTS */
>     u32 reserved3[9];
> https://elixir.bootlin.com/linux/v5.12-rc7/source/include/linux/usb/ehci_def.h#L130
> 
> Question: should it be an empty array "[]" to prevent the undefined behavior?
> Or should it be declared as "[9]" to be more explicit?

Arnd has already looked at this:

	https://marc.info/?t=158828240200001&r=1&w=2

I thought we had arrived at an acceptable (though not great) solution, 
but he never posted any finished patches.  :-(

Alan Stern

> UBSAN: array-index-out-of-bounds in drivers/usb/host/ehci-hub.c:893:16
> index 1 is out of range for type 'u32 [0]'
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.10.13+ #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.13.0-44-g88ab0c15525c-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x183/0x225 lib/dump_stack.c:118
>  ubsan_epilogue lib/ubsan.c:148 [inline]
>  __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:356
>  ehci_hub_control+0x1d27/0x2370 drivers/usb/host/ehci-hub.c:893
>  rh_call_control+0x938/0x11a0 drivers/usb/core/hcd.c:683
>  rh_urb_enqueue drivers/usb/core/hcd.c:842 [inline]
>  usb_hcd_submit_urb+0x2f2/0x5f0 drivers/usb/core/hcd.c:1543
>  usb_start_wait_urb+0x11a/0x550 drivers/usb/core/message.c:58
>  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
>  usb_control_msg+0x281/0x470 drivers/usb/core/message.c:153
>  hub_power_on+0x1a8/0x3c0 arch/x86/include/asm/bitops.h:219
>  hub_activate+0x330/0x1ba0 drivers/usb/core/hub.c:1076
>  hub_configure+0x19e0/0x2690 drivers/usb/core/hub.c:1680
>  hub_probe+0x82f/0x9b0 drivers/usb/core/hub.c:1882
>  usb_probe_interface+0x67b/0xb70 drivers/usb/core/driver.c:396
>  really_probe+0x58b/0x1580 drivers/base/dd.c:558
>  driver_probe_device+0x15a/0x310 drivers/base/dd.c:740
>  bus_for_each_drv+0x16a/0x1f0 drivers/base/bus.c:431
>  __device_attach+0x2b2/0x4b0 drivers/base/dd.c:914
>  bus_probe_device+0xb8/0x200 drivers/base/bus.c:491
>  device_add+0x8e7/0xcb0 drivers/base/core.c:2954
>  usb_set_configuration+0x1b98/0x2230 drivers/usb/core/message.c:2159
>  usb_generic_driver_probe+0x83/0x140 drivers/usb/core/generic.c:238
>  usb_probe_device+0x13a/0x260 drivers/usb/core/driver.c:293
>  really_probe+0x58b/0x1580 drivers/base/dd.c:558
>  driver_probe_device+0x15a/0x310 drivers/base/dd.c:740
>  bus_for_each_drv+0x16a/0x1f0 drivers/base/bus.c:431
>  __device_attach+0x2b2/0x4b0 drivers/base/dd.c:914
>  bus_probe_device+0xb8/0x200 drivers/base/bus.c:491
>  device_add+0x8e7/0xcb0 drivers/base/core.c:2954
>  usb_new_device+0xa43/0x1120 drivers/usb/core/hub.c:2554
>  register_root_hub+0x214/0x560 drivers/usb/core/hcd.c:1009
>  usb_add_hcd+0x8ee/0x1080 drivers/usb/core/hcd.c:2793
>  usb_hcd_pci_probe+0xa61/0x1280 drivers/usb/core/hcd-pci.c:264
>  local_pci_probe drivers/pci/pci-driver.c:308 [inline]
>  pci_call_probe drivers/pci/pci-driver.c:365 [inline]
>  __pci_device_probe drivers/pci/pci-driver.c:390 [inline]
>  pci_device_probe+0x3ef/0x630 drivers/pci/pci-driver.c:433
>  really_probe+0x544/0x1580 drivers/base/dd.c:554
>  driver_probe_device+0x15a/0x310 drivers/base/dd.c:740
>  device_driver_attach+0x176/0x280 drivers/base/dd.c:1015
>  __driver_attach+0xa7/0x490 drivers/base/dd.c:1092
>  bus_for_each_dev+0x168/0x1d0 drivers/base/bus.c:305
>  bus_add_driver+0x324/0x5e0 drivers/base/bus.c:622
>  driver_register+0x2e9/0x3e0 drivers/base/driver.c:171
>  do_one_initcall+0x1a3/0x410 init/main.c:1217
>  do_initcall_level+0x168/0x218 init/main.c:1290
>  do_initcalls+0x50/0x91 init/main.c:1306
>  kernel_init_freeable+0x33b/0x47f init/main.c:1527
>  kernel_init+0xd/0x290 init/main.c:1415
