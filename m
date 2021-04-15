Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89014360B81
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhDOOLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbhDOOLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:11:21 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17182C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:10:58 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id u8so18187377qtq.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BwP9e0XVIhVzEXOphzKqckHLGf3aj3r0852tUNyk6S8=;
        b=c9F2HLMz1ehUHjPz/zCEhAi96fQizYt2CQQCnOUEqyvePh1vwjgFZqNiHH4numBdP2
         yq+ku/ccATDrUVaIzk6IWTrvGXJ32EpkPUKw+acv4Q2rYiyqtH6jVAOT9pyxP8ClLha+
         obYdJQkom4ie/KIxvdm3Xd0PwIrqjHdVeAHDpyY/ln1L5omsN1pf/Dt98K25NvCt5R2x
         8hWxTq3cNlqmk/EGFbA18MW0c17OgqF8nJGM9ft5gPIGQp5NqdYCdRZpDnDhERhgXk9E
         OgICrU9spxWbWaGvoUDAXb0Lt7CGvlqcC8z3oQQl7qk7xcvfwFurREnorF/4NNjaN4Cq
         p5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BwP9e0XVIhVzEXOphzKqckHLGf3aj3r0852tUNyk6S8=;
        b=oVG09UQLnL93jOyzKeUnwErQjbpikyWdIJixinno3Tx6ZVxChaAH6ANWy/16SsQB+7
         mXFT/GzZaMGvOJNbOp2HK+/5nV4pAMyy6TmRsNxcHjvCZrWaPYhr1r13cWujryqrXS7/
         8GPwHsUqu/uy0jUl/qWQN75gPwwYVrb8/brMp5gnI4a99wPUf5Yy8Aeu7kBd7AUEZg6s
         yxB+P8PHBkIDwdifntFbIZNTRb6IbQyun0TDtqHxlGZoL7ZHMysxJgW70hLZY8/r1awQ
         prRIu+vNbvPaZV35q1/WaqPaKJw4Og7EpyjGeVP+gz0q3nfb3inx6hSQfHimpOuOCfN3
         9G4w==
X-Gm-Message-State: AOAM531078h9iPGF/Onq4V8JNzBnO4w0+6+tLgzqKvp3AEVwNfXPhJdS
        Yh10WT+7p0Xqms20NtsQoLAUxvEEIiXZjwIHFI2QtA==
X-Google-Smtp-Source: ABdhPJy2sR/JNDrsQA5gKVzIcPaDGSTpOccJxge9DKTxEOGkoDVL7HpkJQNAduY1ER1G6bBcxtbtxEqYemdNQCl4ZYE=
X-Received: by 2002:ac8:5c92:: with SMTP id r18mr3180746qta.66.1618495856883;
 Thu, 15 Apr 2021 07:10:56 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 15 Apr 2021 16:10:45 +0200
Message-ID: <CACT4Y+YOXJ15j6c_8N-09xpxTHXO3J07K83p4p+SAFa4=47ayw@mail.gmail.com>
Subject: UBSAN: array-index-out-of-bounds in ehci_hub_control
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     abrestic@google.com, paulburton@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got this report while booting v5.10.13 kernel, but upstream code
seems to be the same.
The access to port_status, the code is:

struct ehci_regs {
    u32 port_status[0]; /* up to N_PORTS */
    u32 reserved3[9];
https://elixir.bootlin.com/linux/v5.12-rc7/source/include/linux/usb/ehci_def.h#L130

Question: should it be an empty array "[]" to prevent the undefined behavior?
Or should it be declared as "[9]" to be more explicit?


UBSAN: array-index-out-of-bounds in drivers/usb/host/ehci-hub.c:893:16
index 1 is out of range for type 'u32 [0]'
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.10.13+ #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.13.0-44-g88ab0c15525c-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x183/0x225 lib/dump_stack.c:118
 ubsan_epilogue lib/ubsan.c:148 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:356
 ehci_hub_control+0x1d27/0x2370 drivers/usb/host/ehci-hub.c:893
 rh_call_control+0x938/0x11a0 drivers/usb/core/hcd.c:683
 rh_urb_enqueue drivers/usb/core/hcd.c:842 [inline]
 usb_hcd_submit_urb+0x2f2/0x5f0 drivers/usb/core/hcd.c:1543
 usb_start_wait_urb+0x11a/0x550 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x281/0x470 drivers/usb/core/message.c:153
 hub_power_on+0x1a8/0x3c0 arch/x86/include/asm/bitops.h:219
 hub_activate+0x330/0x1ba0 drivers/usb/core/hub.c:1076
 hub_configure+0x19e0/0x2690 drivers/usb/core/hub.c:1680
 hub_probe+0x82f/0x9b0 drivers/usb/core/hub.c:1882
 usb_probe_interface+0x67b/0xb70 drivers/usb/core/driver.c:396
 really_probe+0x58b/0x1580 drivers/base/dd.c:558
 driver_probe_device+0x15a/0x310 drivers/base/dd.c:740
 bus_for_each_drv+0x16a/0x1f0 drivers/base/bus.c:431
 __device_attach+0x2b2/0x4b0 drivers/base/dd.c:914
 bus_probe_device+0xb8/0x200 drivers/base/bus.c:491
 device_add+0x8e7/0xcb0 drivers/base/core.c:2954
 usb_set_configuration+0x1b98/0x2230 drivers/usb/core/message.c:2159
 usb_generic_driver_probe+0x83/0x140 drivers/usb/core/generic.c:238
 usb_probe_device+0x13a/0x260 drivers/usb/core/driver.c:293
 really_probe+0x58b/0x1580 drivers/base/dd.c:558
 driver_probe_device+0x15a/0x310 drivers/base/dd.c:740
 bus_for_each_drv+0x16a/0x1f0 drivers/base/bus.c:431
 __device_attach+0x2b2/0x4b0 drivers/base/dd.c:914
 bus_probe_device+0xb8/0x200 drivers/base/bus.c:491
 device_add+0x8e7/0xcb0 drivers/base/core.c:2954
 usb_new_device+0xa43/0x1120 drivers/usb/core/hub.c:2554
 register_root_hub+0x214/0x560 drivers/usb/core/hcd.c:1009
 usb_add_hcd+0x8ee/0x1080 drivers/usb/core/hcd.c:2793
 usb_hcd_pci_probe+0xa61/0x1280 drivers/usb/core/hcd-pci.c:264
 local_pci_probe drivers/pci/pci-driver.c:308 [inline]
 pci_call_probe drivers/pci/pci-driver.c:365 [inline]
 __pci_device_probe drivers/pci/pci-driver.c:390 [inline]
 pci_device_probe+0x3ef/0x630 drivers/pci/pci-driver.c:433
 really_probe+0x544/0x1580 drivers/base/dd.c:554
 driver_probe_device+0x15a/0x310 drivers/base/dd.c:740
 device_driver_attach+0x176/0x280 drivers/base/dd.c:1015
 __driver_attach+0xa7/0x490 drivers/base/dd.c:1092
 bus_for_each_dev+0x168/0x1d0 drivers/base/bus.c:305
 bus_add_driver+0x324/0x5e0 drivers/base/bus.c:622
 driver_register+0x2e9/0x3e0 drivers/base/driver.c:171
 do_one_initcall+0x1a3/0x410 init/main.c:1217
 do_initcall_level+0x168/0x218 init/main.c:1290
 do_initcalls+0x50/0x91 init/main.c:1306
 kernel_init_freeable+0x33b/0x47f init/main.c:1527
 kernel_init+0xd/0x290 init/main.c:1415
