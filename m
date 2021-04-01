Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F70350EEF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhDAGSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233128AbhDAGSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:18:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09A8861007;
        Thu,  1 Apr 2021 06:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617257889;
        bh=6rvN9ddFIrCz8JVd3fiGYugNn97znHLYzDPSD73gplU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nD/JLyXlF1FEU/RlL2D+tFNxkZrIrs8jdSbFpDTCZz+3pRzqufMyxHv3CRuoDIbz2
         OMXsCaAEe/9EzeHCW+7Abv5IXOY56yaHSbKShlW94g8eexHzEsIn1obnyq3B9BkqAx
         4xZQeMJzDvk6siEtNTU0RWm79pjl4LWGmgTQmbAc=
Date:   Thu, 1 Apr 2021 08:18:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: vmw_vmci: initialize payload passed to
 vmci_send_datagram()
Message-ID: <YGVlnbTIVsps8FeJ@kroah.com>
References: <20210401055747.3820-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401055747.3820-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 02:57:47PM +0900, Tetsuo Handa wrote:
> KMSAN complains that the vmci_use_ppn64() == false path in
> vmci_dbell_register_notification_bitmap() left upper 32bits of
> bitmap_set_msg.bitmap_ppn64 member uninitialized.
> 
> KMSAN also complains that vmci_check_host_caps() left the payload part
> of check_msg uninitialized.
> 
>   [   21.458023][    T1] vmw_vmci 0000:00:07.7: Found VMCI PCI device at 0x11080, irq 16
>   [   21.461252][    T1] vmw_vmci 0000:00:07.7: Using capabilities 0xc
>   [   21.463199][    T1] =====================================================
>   [   21.465014][    T1] BUG: KMSAN: uninit-value in kmsan_check_memory+0xd/0x10
>   [   21.465014][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.11.0-rc7+ #4
>   [   21.465014][    T1] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
>   [   21.465014][    T1] Call Trace:
>   [   21.465014][    T1]  dump_stack+0x21c/0x280
>   [   21.465014][    T1]  kmsan_report+0xfb/0x1e0
>   [   21.465014][    T1]  kmsan_internal_check_memory+0x484/0x520
>   [   21.465014][    T1]  ? kmsan_get_metadata+0x116/0x180
>   [   21.465014][    T1]  kmsan_check_memory+0xd/0x10
>   [   21.465014][    T1]  iowrite8_rep+0x86/0x380
>   [   21.465014][    T1]  vmci_send_datagram+0x150/0x280
>   [   21.465014][    T1]  vmci_dbell_register_notification_bitmap+0x133/0x1e0
>   [   21.465014][    T1]  vmci_guest_probe_device+0xcab/0x1e70
>   [   21.465014][    T1]  ? vmci_send_datagram+0x280/0x280
>   [   21.465014][    T1]  pci_device_probe+0xab3/0xe70
>   [   21.465014][    T1]  ? pci_uevent+0x830/0x830
>   [   21.465014][    T1]  really_probe+0xd16/0x24d0
>   [   21.465014][    T1]  driver_probe_device+0x29d/0x3a0
>   [   21.465014][    T1]  device_driver_attach+0x25a/0x490
>   [   21.465014][    T1]  __driver_attach+0x78c/0x840
>   [   21.465014][    T1]  ? kmsan_get_metadata+0x116/0x180
>   [   21.465014][    T1]  bus_for_each_dev+0x210/0x340
>   [   21.465014][    T1]  ? driver_attach+0xb0/0xb0
>   [   21.465014][    T1]  driver_attach+0x89/0xb0
>   [   21.465014][    T1]  bus_add_driver+0x677/0xc40
>   [   21.465014][    T1]  driver_register+0x485/0x8e0
>   [   21.465014][    T1]  __pci_register_driver+0x1ff/0x350
>   [   21.465014][    T1]  vmci_guest_init+0x3e/0x41
>   [   21.465014][    T1]  vmci_drv_init+0x1d6/0x43f
>   [   21.465014][    T1]  do_one_initcall+0x39c/0x9a0
>   [   21.465014][    T1]  ? null_init+0x11dc/0x11dc
>   [   21.465014][    T1]  ? kmsan_get_metadata+0x116/0x180
>   [   21.465014][    T1]  ? kmsan_get_shadow_origin_ptr+0x84/0xb0
>   [   21.465014][    T1]  ? null_init+0x11dc/0x11dc
>   [   21.465014][    T1]  do_initcall_level+0x1d7/0x259
>   [   21.465014][    T1]  do_initcalls+0x127/0x1cb
>   [   21.465014][    T1]  ? cpu_init_udelay+0xcf/0xcf
>   [   21.465014][    T1]  ? debug_boot_weak_hash_enable+0x61/0x61
>   [   21.465014][    T1]  do_basic_setup+0x33/0x36
>   [   21.465014][    T1]  kernel_init_freeable+0x29a/0x3ed
>   [   21.465014][    T1]  ? rest_init+0x1f0/0x1f0
>   [   21.465014][    T1]  kernel_init+0x1f/0x840
>   [   21.465014][    T1]  ? rest_init+0x1f0/0x1f0
>   [   21.465014][    T1]  ret_from_fork+0x1f/0x30
>   [   21.465014][    T1]
>   [   21.465014][    T1] Local variable ----bitmap_set_msg@vmci_dbell_register_notification_bitmap created at:
>   [   21.465014][    T1]  vmci_dbell_register_notification_bitmap+0x50/0x1e0
>   [   21.465014][    T1]  vmci_dbell_register_notification_bitmap+0x50/0x1e0
>   [   21.465014][    T1]
>   [   21.465014][    T1] Bytes 28-31 of 32 are uninitialized
>   [   21.465014][    T1] Memory access of size 32 starts at ffff88810098f570
>   [   21.465014][    T1] =====================================================
>   [   21.465014][    T1] Disabling lock debugging due to kernel taint
>   [   21.539748][    T1] =====================================================
>   [   21.541627][    T1] BUG: KMSAN: uninit-value in kmsan_check_memory+0xd/0x10
>   [   21.543636][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B             5.11.0-rc7+ #4
>   [   21.546134][    T1] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
>   [   21.549126][    T1] Call Trace:
>   [   21.549639][    T1]  dump_stack+0x21c/0x280
>   [   21.549639][    T1]  kmsan_report+0xfb/0x1e0
>   [   21.549639][    T1]  kmsan_internal_check_memory+0x202/0x520
>   [   21.549639][    T1]  ? kmsan_get_metadata+0x116/0x180
>   [   21.549639][    T1]  kmsan_check_memory+0xd/0x10
>   [   21.549639][    T1]  iowrite8_rep+0x86/0x380
>   [   21.549639][    T1]  vmci_guest_probe_device+0xf0b/0x1e70
>   [   21.549639][    T1]  ? vmci_send_datagram+0x280/0x280
>   [   21.549639][    T1]  pci_device_probe+0xab3/0xe70
>   [   21.549639][    T1]  ? pci_uevent+0x830/0x830
>   [   21.549639][    T1]  really_probe+0xd16/0x24d0
>   [   21.549639][    T1]  driver_probe_device+0x29d/0x3a0
>   [   21.549639][    T1]  device_driver_attach+0x25a/0x490
>   [   21.549639][    T1]  __driver_attach+0x78c/0x840
>   [   21.549639][    T1]  ? kmsan_get_metadata+0x116/0x180
>   [   21.549639][    T1]  bus_for_each_dev+0x210/0x340
>   [   21.549639][    T1]  ? driver_attach+0xb0/0xb0
>   [   21.549639][    T1]  driver_attach+0x89/0xb0
>   [   21.549639][    T1]  bus_add_driver+0x677/0xc40
>   [   21.549639][    T1]  driver_register+0x485/0x8e0
>   [   21.549639][    T1]  __pci_register_driver+0x1ff/0x350
>   [   21.549639][    T1]  vmci_guest_init+0x3e/0x41
>   [   21.549639][    T1]  vmci_drv_init+0x1d6/0x43f
>   [   21.549639][    T1]  do_one_initcall+0x39c/0x9a0
>   [   21.549639][    T1]  ? null_init+0x11dc/0x11dc
>   [   21.549639][    T1]  ? kmsan_get_metadata+0x116/0x180
>   [   21.549639][    T1]  ? kmsan_get_shadow_origin_ptr+0x84/0xb0
>   [   21.549639][    T1]  ? null_init+0x11dc/0x11dc
>   [   21.549639][    T1]  do_initcall_level+0x1d7/0x259
>   [   21.549639][    T1]  do_initcalls+0x127/0x1cb
>   [   21.549639][    T1]  ? cpu_init_udelay+0xcf/0xcf
>   [   21.549639][    T1]  ? debug_boot_weak_hash_enable+0x61/0x61
>   [   21.549639][    T1]  do_basic_setup+0x33/0x36
>   [   21.549639][    T1]  kernel_init_freeable+0x29a/0x3ed
>   [   21.549639][    T1]  ? rest_init+0x1f0/0x1f0
>   [   21.549639][    T1]  kernel_init+0x1f/0x840
>   [   21.549639][    T1]  ? rest_init+0x1f0/0x1f0
>   [   21.549639][    T1]  ret_from_fork+0x1f/0x30
>   [   21.549639][    T1]
>   [   21.549639][    T1] Uninit was created at:
>   [   21.549639][    T1]  kmsan_internal_poison_shadow+0x5c/0xf0
>   [   21.549639][    T1]  kmsan_slab_alloc+0x8d/0xe0
>   [   21.549639][    T1]  kmem_cache_alloc+0x84f/0xe30
>   [   21.549639][    T1]  vmci_guest_probe_device+0xd11/0x1e70
>   [   21.549639][    T1]  pci_device_probe+0xab3/0xe70
>   [   21.549639][    T1]  really_probe+0xd16/0x24d0
>   [   21.549639][    T1]  driver_probe_device+0x29d/0x3a0
>   [   21.549639][    T1]  device_driver_attach+0x25a/0x490
>   [   21.549639][    T1]  __driver_attach+0x78c/0x840
>   [   21.549639][    T1]  bus_for_each_dev+0x210/0x340
>   [   21.549639][    T1]  driver_attach+0x89/0xb0
>   [   21.549639][    T1]  bus_add_driver+0x677/0xc40
>   [   21.549639][    T1]  driver_register+0x485/0x8e0
>   [   21.549639][    T1]  __pci_register_driver+0x1ff/0x350
>   [   21.549639][    T1]  vmci_guest_init+0x3e/0x41
>   [   21.549639][    T1]  vmci_drv_init+0x1d6/0x43f
>   [   21.549639][    T1]  do_one_initcall+0x39c/0x9a0
>   [   21.549639][    T1]  do_initcall_level+0x1d7/0x259
>   [   21.549639][    T1]  do_initcalls+0x127/0x1cb
>   [   21.549639][    T1]  do_basic_setup+0x33/0x36
>   [   21.549639][    T1]  kernel_init_freeable+0x29a/0x3ed
>   [   21.549639][    T1]  kernel_init+0x1f/0x840
>   [   21.549639][    T1]  ret_from_fork+0x1f/0x30
>   [   21.549639][    T1]
>   [   21.549639][    T1] Bytes 28-31 of 36 are uninitialized
>   [   21.549639][    T1] Memory access of size 36 starts at ffff8881675e5f00
>   [   21.549639][    T1] =====================================================
>   [   21.639830][    T1] Guest personality initialized and is active
>   [   21.642165][    T1] VMCI host device registered (name=vmci, major=10, minor=121)
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---

What commit does this "fix"?  Can you resend with a proper "Fixes:" tag
so we know where it needs to be backported to?

thanks,

greg k-h
