Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC889350E9C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 07:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhDAF61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 01:58:27 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63299 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhDAF6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 01:58:18 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1315vsTR070801;
        Thu, 1 Apr 2021 14:57:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Thu, 01 Apr 2021 14:57:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1315vn9u070762
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 1 Apr 2021 14:57:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] misc: vmw_vmci: initialize payload passed to vmci_send_datagram()
Date:   Thu,  1 Apr 2021 14:57:47 +0900
Message-Id: <20210401055747.3820-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN complains that the vmci_use_ppn64() == false path in
vmci_dbell_register_notification_bitmap() left upper 32bits of
bitmap_set_msg.bitmap_ppn64 member uninitialized.

KMSAN also complains that vmci_check_host_caps() left the payload part
of check_msg uninitialized.

  [   21.458023][    T1] vmw_vmci 0000:00:07.7: Found VMCI PCI device at 0x11080, irq 16
  [   21.461252][    T1] vmw_vmci 0000:00:07.7: Using capabilities 0xc
  [   21.463199][    T1] =====================================================
  [   21.465014][    T1] BUG: KMSAN: uninit-value in kmsan_check_memory+0xd/0x10
  [   21.465014][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.11.0-rc7+ #4
  [   21.465014][    T1] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
  [   21.465014][    T1] Call Trace:
  [   21.465014][    T1]  dump_stack+0x21c/0x280
  [   21.465014][    T1]  kmsan_report+0xfb/0x1e0
  [   21.465014][    T1]  kmsan_internal_check_memory+0x484/0x520
  [   21.465014][    T1]  ? kmsan_get_metadata+0x116/0x180
  [   21.465014][    T1]  kmsan_check_memory+0xd/0x10
  [   21.465014][    T1]  iowrite8_rep+0x86/0x380
  [   21.465014][    T1]  vmci_send_datagram+0x150/0x280
  [   21.465014][    T1]  vmci_dbell_register_notification_bitmap+0x133/0x1e0
  [   21.465014][    T1]  vmci_guest_probe_device+0xcab/0x1e70
  [   21.465014][    T1]  ? vmci_send_datagram+0x280/0x280
  [   21.465014][    T1]  pci_device_probe+0xab3/0xe70
  [   21.465014][    T1]  ? pci_uevent+0x830/0x830
  [   21.465014][    T1]  really_probe+0xd16/0x24d0
  [   21.465014][    T1]  driver_probe_device+0x29d/0x3a0
  [   21.465014][    T1]  device_driver_attach+0x25a/0x490
  [   21.465014][    T1]  __driver_attach+0x78c/0x840
  [   21.465014][    T1]  ? kmsan_get_metadata+0x116/0x180
  [   21.465014][    T1]  bus_for_each_dev+0x210/0x340
  [   21.465014][    T1]  ? driver_attach+0xb0/0xb0
  [   21.465014][    T1]  driver_attach+0x89/0xb0
  [   21.465014][    T1]  bus_add_driver+0x677/0xc40
  [   21.465014][    T1]  driver_register+0x485/0x8e0
  [   21.465014][    T1]  __pci_register_driver+0x1ff/0x350
  [   21.465014][    T1]  vmci_guest_init+0x3e/0x41
  [   21.465014][    T1]  vmci_drv_init+0x1d6/0x43f
  [   21.465014][    T1]  do_one_initcall+0x39c/0x9a0
  [   21.465014][    T1]  ? null_init+0x11dc/0x11dc
  [   21.465014][    T1]  ? kmsan_get_metadata+0x116/0x180
  [   21.465014][    T1]  ? kmsan_get_shadow_origin_ptr+0x84/0xb0
  [   21.465014][    T1]  ? null_init+0x11dc/0x11dc
  [   21.465014][    T1]  do_initcall_level+0x1d7/0x259
  [   21.465014][    T1]  do_initcalls+0x127/0x1cb
  [   21.465014][    T1]  ? cpu_init_udelay+0xcf/0xcf
  [   21.465014][    T1]  ? debug_boot_weak_hash_enable+0x61/0x61
  [   21.465014][    T1]  do_basic_setup+0x33/0x36
  [   21.465014][    T1]  kernel_init_freeable+0x29a/0x3ed
  [   21.465014][    T1]  ? rest_init+0x1f0/0x1f0
  [   21.465014][    T1]  kernel_init+0x1f/0x840
  [   21.465014][    T1]  ? rest_init+0x1f0/0x1f0
  [   21.465014][    T1]  ret_from_fork+0x1f/0x30
  [   21.465014][    T1]
  [   21.465014][    T1] Local variable ----bitmap_set_msg@vmci_dbell_register_notification_bitmap created at:
  [   21.465014][    T1]  vmci_dbell_register_notification_bitmap+0x50/0x1e0
  [   21.465014][    T1]  vmci_dbell_register_notification_bitmap+0x50/0x1e0
  [   21.465014][    T1]
  [   21.465014][    T1] Bytes 28-31 of 32 are uninitialized
  [   21.465014][    T1] Memory access of size 32 starts at ffff88810098f570
  [   21.465014][    T1] =====================================================
  [   21.465014][    T1] Disabling lock debugging due to kernel taint
  [   21.539748][    T1] =====================================================
  [   21.541627][    T1] BUG: KMSAN: uninit-value in kmsan_check_memory+0xd/0x10
  [   21.543636][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B             5.11.0-rc7+ #4
  [   21.546134][    T1] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
  [   21.549126][    T1] Call Trace:
  [   21.549639][    T1]  dump_stack+0x21c/0x280
  [   21.549639][    T1]  kmsan_report+0xfb/0x1e0
  [   21.549639][    T1]  kmsan_internal_check_memory+0x202/0x520
  [   21.549639][    T1]  ? kmsan_get_metadata+0x116/0x180
  [   21.549639][    T1]  kmsan_check_memory+0xd/0x10
  [   21.549639][    T1]  iowrite8_rep+0x86/0x380
  [   21.549639][    T1]  vmci_guest_probe_device+0xf0b/0x1e70
  [   21.549639][    T1]  ? vmci_send_datagram+0x280/0x280
  [   21.549639][    T1]  pci_device_probe+0xab3/0xe70
  [   21.549639][    T1]  ? pci_uevent+0x830/0x830
  [   21.549639][    T1]  really_probe+0xd16/0x24d0
  [   21.549639][    T1]  driver_probe_device+0x29d/0x3a0
  [   21.549639][    T1]  device_driver_attach+0x25a/0x490
  [   21.549639][    T1]  __driver_attach+0x78c/0x840
  [   21.549639][    T1]  ? kmsan_get_metadata+0x116/0x180
  [   21.549639][    T1]  bus_for_each_dev+0x210/0x340
  [   21.549639][    T1]  ? driver_attach+0xb0/0xb0
  [   21.549639][    T1]  driver_attach+0x89/0xb0
  [   21.549639][    T1]  bus_add_driver+0x677/0xc40
  [   21.549639][    T1]  driver_register+0x485/0x8e0
  [   21.549639][    T1]  __pci_register_driver+0x1ff/0x350
  [   21.549639][    T1]  vmci_guest_init+0x3e/0x41
  [   21.549639][    T1]  vmci_drv_init+0x1d6/0x43f
  [   21.549639][    T1]  do_one_initcall+0x39c/0x9a0
  [   21.549639][    T1]  ? null_init+0x11dc/0x11dc
  [   21.549639][    T1]  ? kmsan_get_metadata+0x116/0x180
  [   21.549639][    T1]  ? kmsan_get_shadow_origin_ptr+0x84/0xb0
  [   21.549639][    T1]  ? null_init+0x11dc/0x11dc
  [   21.549639][    T1]  do_initcall_level+0x1d7/0x259
  [   21.549639][    T1]  do_initcalls+0x127/0x1cb
  [   21.549639][    T1]  ? cpu_init_udelay+0xcf/0xcf
  [   21.549639][    T1]  ? debug_boot_weak_hash_enable+0x61/0x61
  [   21.549639][    T1]  do_basic_setup+0x33/0x36
  [   21.549639][    T1]  kernel_init_freeable+0x29a/0x3ed
  [   21.549639][    T1]  ? rest_init+0x1f0/0x1f0
  [   21.549639][    T1]  kernel_init+0x1f/0x840
  [   21.549639][    T1]  ? rest_init+0x1f0/0x1f0
  [   21.549639][    T1]  ret_from_fork+0x1f/0x30
  [   21.549639][    T1]
  [   21.549639][    T1] Uninit was created at:
  [   21.549639][    T1]  kmsan_internal_poison_shadow+0x5c/0xf0
  [   21.549639][    T1]  kmsan_slab_alloc+0x8d/0xe0
  [   21.549639][    T1]  kmem_cache_alloc+0x84f/0xe30
  [   21.549639][    T1]  vmci_guest_probe_device+0xd11/0x1e70
  [   21.549639][    T1]  pci_device_probe+0xab3/0xe70
  [   21.549639][    T1]  really_probe+0xd16/0x24d0
  [   21.549639][    T1]  driver_probe_device+0x29d/0x3a0
  [   21.549639][    T1]  device_driver_attach+0x25a/0x490
  [   21.549639][    T1]  __driver_attach+0x78c/0x840
  [   21.549639][    T1]  bus_for_each_dev+0x210/0x340
  [   21.549639][    T1]  driver_attach+0x89/0xb0
  [   21.549639][    T1]  bus_add_driver+0x677/0xc40
  [   21.549639][    T1]  driver_register+0x485/0x8e0
  [   21.549639][    T1]  __pci_register_driver+0x1ff/0x350
  [   21.549639][    T1]  vmci_guest_init+0x3e/0x41
  [   21.549639][    T1]  vmci_drv_init+0x1d6/0x43f
  [   21.549639][    T1]  do_one_initcall+0x39c/0x9a0
  [   21.549639][    T1]  do_initcall_level+0x1d7/0x259
  [   21.549639][    T1]  do_initcalls+0x127/0x1cb
  [   21.549639][    T1]  do_basic_setup+0x33/0x36
  [   21.549639][    T1]  kernel_init_freeable+0x29a/0x3ed
  [   21.549639][    T1]  kernel_init+0x1f/0x840
  [   21.549639][    T1]  ret_from_fork+0x1f/0x30
  [   21.549639][    T1]
  [   21.549639][    T1] Bytes 28-31 of 36 are uninitialized
  [   21.549639][    T1] Memory access of size 36 starts at ffff8881675e5f00
  [   21.549639][    T1] =====================================================
  [   21.639830][    T1] Guest personality initialized and is active
  [   21.642165][    T1] VMCI host device registered (name=vmci, major=10, minor=121)

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/misc/vmw_vmci/vmci_doorbell.c | 2 +-
 drivers/misc/vmw_vmci/vmci_guest.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_doorbell.c b/drivers/misc/vmw_vmci/vmci_doorbell.c
index 345addd9306d..fa8a7fce4481 100644
--- a/drivers/misc/vmw_vmci/vmci_doorbell.c
+++ b/drivers/misc/vmw_vmci/vmci_doorbell.c
@@ -326,7 +326,7 @@ int vmci_dbell_host_context_notify(u32 src_cid, struct vmci_handle handle)
 bool vmci_dbell_register_notification_bitmap(u64 bitmap_ppn)
 {
 	int result;
-	struct vmci_notify_bm_set_msg bitmap_set_msg;
+	struct vmci_notify_bm_set_msg bitmap_set_msg = { };
 
 	bitmap_set_msg.hdr.dst = vmci_make_handle(VMCI_HYPERVISOR_CONTEXT_ID,
 						  VMCI_SET_NOTIFY_BITMAP);
diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index cc8eeb361fcd..1018dc77269d 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -168,7 +168,7 @@ static int vmci_check_host_caps(struct pci_dev *pdev)
 				VMCI_UTIL_NUM_RESOURCES * sizeof(u32);
 	struct vmci_datagram *check_msg;
 
-	check_msg = kmalloc(msg_size, GFP_KERNEL);
+	check_msg = kzalloc(msg_size, GFP_KERNEL);
 	if (!check_msg) {
 		dev_err(&pdev->dev, "%s: Insufficient memory\n", __func__);
 		return -ENOMEM;
-- 
2.18.4

