Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420893CBE19
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 22:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbhGPU7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 16:59:52 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:45067 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhGPU7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 16:59:50 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Jul 2021 16:59:50 EDT
IronPort-SDR: p3F3OMqqi/FBn1jzJiFVk2JgtZwDn1DypYFtHclox8DXjFterUO17vuVm8HRARDf9bOB5+wXRg
 4P745SiUd+aZnuwE6uCznra4darlLi4crivDqHAA36Dh1mnGPeuAgOCh1QEQqkJhD5uchTNzVY
 f+vX+gyXrZb0hoHiXaxpV9eVTzds5KeoyFgC9/gwptXeq7ik78Yn10OJt64BpD3/PDmOxQr0o5
 +qiswytS+hMalJuFYEwOlJXKK1Fq2o5Ml3s7hkM06/kHLwfA/u6epteQv/eZ+svZbAnQ8/lc0V
 ku4chJwHk7im6cgiW1PF6s1G
X-IronPort-AV: E=Sophos;i="5.84,245,1620720000"; 
   d="scan'208";a="66063730"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 16 Jul 2021 12:49:49 -0800
IronPort-SDR: 0LTvEaGOpdPEEWRO6+30U5xaO2Sm4vp//3nOGRfD7A4rotBp9QK2ds7YuSLHQpbBflUPM7gJri
 YE+KevlY04a9vga5SFFby77GL9INzEzaGcm6APCnrX+SmjthJhRteGpYcIw7/hn/9zejxsLull
 mI8eD7blGpaZzUGCYxf63FYtPXyZ+yjwQiwo74Q6dDGgCTop31fOan+VoeBeIcUFhxrU/rjxGw
 PHqUjUA/dEQOgIAM+0BofCGSDHb80UeHuCNhC8iJxzmEVtFg3CatH+ueN5/gyabA2DLq/fYr4F
 uJk=
From:   "George G. Davis" <george_davis@mentor.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "George G. Davis" <george_davis@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "open list:HYPERBUS SUPPORT" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "George G. Davis" <davis.george@siemens.com>
Subject: [PATCH] mtd: hyperbus: rpc-if: fix bug in rpcif_hb_remove
Date:   Fri, 16 Jul 2021 16:49:35 -0400
Message-ID: <20210716204935.25859-1-george_davis@mentor.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "George G. Davis" <davis.george@siemens.com>

The following KASAN BUG is observed when testing the rpc-if driver on
rcar-gen3:

root@rcar-gen3:~# modprobe -r rpc-if
[  101.930146] ==================================================================
[  101.937408] BUG: KASAN: slab-out-of-bounds in __lock_acquire+0x518/0x25d0
[  101.944240] Read of size 8 at addr ffff0004c5be2750 by task modprobe/664
[  101.950959]
[  101.952466] CPU: 2 PID: 664 Comm: modprobe Not tainted 5.14.0-rc1-00342-g1a1464d7aa31 #1
[  101.960578] Hardware name: Renesas H3ULCB board based on r8a77951 (DT)
[  101.967120] Call trace:
[  101.969580]  dump_backtrace+0x0/0x2c0
[  101.973275]  show_stack+0x1c/0x30
[  101.976616]  dump_stack_lvl+0x9c/0xd8
[  101.980301]  print_address_description.constprop.0+0x74/0x2b8
[  101.986071]  kasan_report+0x1f4/0x26c
[  101.989757]  __asan_load8+0x98/0xd4
[  101.993266]  __lock_acquire+0x518/0x25d0
[  101.997215]  lock_acquire.part.0+0x18c/0x360
[  102.001506]  lock_acquire+0x74/0x90
[  102.005013]  _raw_spin_lock_irq+0x98/0x130
[  102.009131]  __pm_runtime_disable+0x30/0x210
[  102.013427]  rpcif_hb_remove+0x5c/0x70 [rpc_if]
[  102.018001]  platform_remove+0x40/0x80
[  102.021771]  __device_release_driver+0x234/0x350
[  102.026412]  driver_detach+0x158/0x20c
[  102.030179]  bus_remove_driver+0xa0/0x140
[  102.034212]  driver_unregister+0x48/0x80
[  102.038153]  platform_driver_unregister+0x18/0x24
[  102.042879]  rpcif_platform_driver_exit+0x1c/0x34 [rpc_if]
[  102.048400]  __arm64_sys_delete_module+0x210/0x310
[  102.053212]  invoke_syscall+0x60/0x190
[  102.056986]  el0_svc_common+0x12c/0x144
[  102.060844]  do_el0_svc+0x88/0xac
[  102.064181]  el0_svc+0x24/0x3c
[  102.067257]  el0t_64_sync_handler+0x1a8/0x1b0
[  102.071634]  el0t_64_sync+0x198/0x19c
[  102.075315]
[  102.076815] Allocated by task 628:
[  102.080781]
[  102.082280] Last potentially related work creation:
[  102.087524]
[  102.089022] The buggy address belongs to the object at ffff0004c5be2000
[  102.089022]  which belongs to the cache kmalloc-2k of size 2048
[  102.101555] The buggy address is located 1872 bytes inside of
[  102.101555]  2048-byte region [ffff0004c5be2000, ffff0004c5be2800)
[  102.113486] The buggy address belongs to the page:
[  102.118409]
[  102.119908] Memory state around the buggy address:
[  102.124711]  ffff0004c5be2600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  102.131947]  ffff0004c5be2680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  102.139181] >ffff0004c5be2700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  102.146412]                                                  ^
[  102.152257]  ffff0004c5be2780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  102.159491]  ffff0004c5be2800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  102.166723] ==================================================================

The above bug is caused by use of the wrong pointer in the
rpcif_disable_rpm() call. Fix the bug by using the correct pointer.

Fixes: e806241e03b7 ("mtd: hyperbus: add Renesas RPC-IF driver")
Signed-off-by: George G. Davis <davis.george@siemens.com>
---
 drivers/mtd/hyperbus/rpc-if.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/hyperbus/rpc-if.c b/drivers/mtd/hyperbus/rpc-if.c
index ecb050ba95cd..2806024b50ac 100644
--- a/drivers/mtd/hyperbus/rpc-if.c
+++ b/drivers/mtd/hyperbus/rpc-if.c
@@ -150,9 +150,9 @@ static int rpcif_hb_remove(struct platform_device *pdev)
 {
 	struct rpcif_hyperbus *hyperbus = platform_get_drvdata(pdev);
 	int error = hyperbus_unregister_device(&hyperbus->hbdev);
-	struct rpcif *rpc = dev_get_drvdata(pdev->dev.parent);
 
-	rpcif_disable_rpm(rpc);
+	rpcif_disable_rpm(&hyperbus->rpc);
+
 	return error;
 }
 
-- 
2.17.1

