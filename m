Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1DB37BBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 13:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhELLhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 07:37:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2715 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhELLhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 07:37:20 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FgCN96tLnz1BLb6;
        Wed, 12 May 2021 19:33:29 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Wed, 12 May 2021
 19:35:59 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <Markus.Elfring@web.de>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <sunke32@huawei.com>
Subject: [PATCH 1/2] nbd: Fix NULL pointer in flush_workqueue
Date:   Wed, 12 May 2021 19:43:30 +0800
Message-ID: <20210512114331.1233964-2-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210512114331.1233964-1-sunke32@huawei.com>
References: <20210512114331.1233964-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Open /dev/nbdX first, the config_refs will be 1 and
the pointers in nbd_device are still null. Disconnect
/dev/nbdX, then reference a null recv_workq. The
protection by config_refs in nbd_genl_disconnect is useless.

[  656.366194] BUG: kernel NULL pointer dereference, address: 0000000000000020
[  656.368943] #PF: supervisor write access in kernel mode
[  656.369844] #PF: error_code(0x0002) - not-present page
[  656.370717] PGD 10cc87067 P4D 10cc87067 PUD 1074b4067 PMD 0
[  656.371693] Oops: 0002 [#1] SMP
[  656.372242] CPU: 5 PID: 7977 Comm: nbd-client Not tainted 5.11.0-rc5-00040-g76c057c84d28 #1
[  656.373661] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
[  656.375904] RIP: 0010:mutex_lock+0x29/0x60
[  656.376627] Code: 00 0f 1f 44 00 00 55 48 89 fd 48 83 05 6f d7 fe 08 01 e8 7a c3 ff ff 48 83 05 6a d7 fe 08 01 31 c0 65 48 8b 14 25 00 6d 01 00 <f0> 48 0f b1 55 d
[  656.378934] RSP: 0018:ffffc900005eb9b0 EFLAGS: 00010246
[  656.379350] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  656.379915] RDX: ffff888104cf2600 RSI: ffffffffaae8f452 RDI: 0000000000000020
[  656.380473] RBP: 0000000000000020 R08: 0000000000000000 R09: ffff88813bd6b318
[  656.381039] R10: 00000000000000c7 R11: fefefefefefefeff R12: ffff888102710b40
[  656.381599] R13: ffffc900005eb9e0 R14: ffffffffb2930680 R15: ffff88810770ef00
[  656.382166] FS:  00007fdf117ebb40(0000) GS:ffff88813bd40000(0000) knlGS:0000000000000000
[  656.382806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  656.383261] CR2: 0000000000000020 CR3: 0000000100c84000 CR4: 00000000000006e0
[  656.383819] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  656.384370] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  656.384927] Call Trace:
[  656.385111]  flush_workqueue+0x92/0x6c0
[  656.385395]  nbd_disconnect_and_put+0x81/0xd0
[  656.385716]  nbd_genl_disconnect+0x125/0x2a0
[  656.386034]  genl_family_rcv_msg_doit.isra.0+0x102/0x1b0
[  656.386422]  genl_rcv_msg+0xfc/0x2b0
[  656.386685]  ? nbd_ioctl+0x490/0x490
[  656.386954]  ? genl_family_rcv_msg_doit.isra.0+0x1b0/0x1b0
[  656.387354]  netlink_rcv_skb+0x62/0x180
[  656.387638]  genl_rcv+0x34/0x60
[  656.387874]  netlink_unicast+0x26d/0x590
[  656.388162]  netlink_sendmsg+0x398/0x6c0
[  656.388451]  ? netlink_rcv_skb+0x180/0x180
[  656.388750]  ____sys_sendmsg+0x1da/0x320
[  656.389038]  ? ____sys_recvmsg+0x130/0x220
[  656.389334]  ___sys_sendmsg+0x8e/0xf0
[  656.389605]  ? ___sys_recvmsg+0xa2/0xf0
[  656.389889]  ? handle_mm_fault+0x1671/0x21d0
[  656.390201]  __sys_sendmsg+0x6d/0xe0
[  656.390464]  __x64_sys_sendmsg+0x23/0x30
[  656.390751]  do_syscall_64+0x45/0x70
[  656.391017]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

To fix it, just add if (nbd->recv_workq) to nbd_disconnect_and_put().

Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")
Signed-off-by: Sun Ke <sunke32@huawei.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/nbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4ff71b579cfc..974da561b8e5 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1980,7 +1980,8 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
 	 * config ref and try to destroy the workqueue from inside the work
 	 * queue.
 	 */
-	flush_workqueue(nbd->recv_workq);
+	if (nbd->recv_workq)
+		flush_workqueue(nbd->recv_workq);
 	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
 			       &nbd->config->runtime_flags))
 		nbd_config_put(nbd);
-- 
2.25.4

