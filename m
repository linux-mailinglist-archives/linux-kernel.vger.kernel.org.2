Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9634352A8B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 14:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbhDBMSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 08:18:39 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64230 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbhDBMSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 08:18:30 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 132CHpUW086619;
        Fri, 2 Apr 2021 21:17:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Fri, 02 Apr 2021 21:17:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 132CHgND086600
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 2 Apr 2021 21:17:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 1/2] misc: vmw_vmci: explicitly initialize vmci_notify_bm_set_msg struct
Date:   Fri,  2 Apr 2021 21:17:41 +0900
Message-Id: <20210402121742.3917-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN complains that the vmci_use_ppn64() == false path in
vmci_dbell_register_notification_bitmap() left upper 32bits of
bitmap_set_msg.bitmap_ppn64 member uninitialized.

  =====================================================
  BUG: KMSAN: uninit-value in kmsan_check_memory+0xd/0x10
  CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.11.0-rc7+ #4
  Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
  Call Trace:
   dump_stack+0x21c/0x280
   kmsan_report+0xfb/0x1e0
   kmsan_internal_check_memory+0x484/0x520
   kmsan_check_memory+0xd/0x10
   iowrite8_rep+0x86/0x380
   vmci_send_datagram+0x150/0x280
   vmci_dbell_register_notification_bitmap+0x133/0x1e0
   vmci_guest_probe_device+0xcab/0x1e70
   pci_device_probe+0xab3/0xe70
   really_probe+0xd16/0x24d0
   driver_probe_device+0x29d/0x3a0
   device_driver_attach+0x25a/0x490
   __driver_attach+0x78c/0x840
   bus_for_each_dev+0x210/0x340
   driver_attach+0x89/0xb0
   bus_add_driver+0x677/0xc40
   driver_register+0x485/0x8e0
   __pci_register_driver+0x1ff/0x350
   vmci_guest_init+0x3e/0x41
   vmci_drv_init+0x1d6/0x43f
   do_one_initcall+0x39c/0x9a0
   do_initcall_level+0x1d7/0x259
   do_initcalls+0x127/0x1cb
   do_basic_setup+0x33/0x36
   kernel_init_freeable+0x29a/0x3ed
   kernel_init+0x1f/0x840
   ret_from_fork+0x1f/0x30

  Local variable ----bitmap_set_msg@vmci_dbell_register_notification_bitmap created at:
   vmci_dbell_register_notification_bitmap+0x50/0x1e0
   vmci_dbell_register_notification_bitmap+0x50/0x1e0

  Bytes 28-31 of 32 are uninitialized
  Memory access of size 32 starts at ffff88810098f570
  =====================================================

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 83e2ec765be03e8a ("VMCI: doorbell implementation.")
Cc: <stable@vger.kernel.org>
---
 drivers/misc/vmw_vmci/vmci_doorbell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.18.4

