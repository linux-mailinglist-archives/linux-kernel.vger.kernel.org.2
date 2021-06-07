Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A3439DA93
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhFGLGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:06:00 -0400
Received: from first.geanix.com ([116.203.34.67]:41006 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhFGLF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:05:59 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 9A67346261A;
        Mon,  7 Jun 2021 11:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1623063845; bh=+WoSHYWiqrrDaZuoquHBwPk2NLLZ8Aff/DoPqDje5dY=;
        h=From:To:Cc:Subject:Date;
        b=Z3YuDLtHHaN4hPVC8xKzqrAR4lPj02mzYabKJxercVlp/fdWh3Gf5a3CvQ6FgMQYM
         AjHiYW9SQJvQOyxVFgQ1e0L09M3KeZn4zTjqmmATs0V78G+H+e356SVCIIK8RZ/BiG
         Y3jX3dbEfCrxU6i2LQ+lGdWhLALTdEh6ptTfHpsE1Zv/efdvGVvgr5gDDuY9+MNpMO
         AP9FnWqkbb+7XyvWBSYwBnOhlCnVEhaAJXXDgtYAKdAxa/gcg0yrWTMpCvwaFNloz1
         rhCaQ/84hYsBOd7KRRN9S3/ISYMOF5r4YCNPh0RibHgTUCl0G9LwpCNGoQxiatyZee
         xavqCG74OqxLw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] clk: fix possible circular locking in clk_notifier_register()
Date:   Mon,  7 Jun 2021 13:01:54 +0200
Message-Id: <20210607110154.1291335-1-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=4.0 tests=ALL_TRUSTED,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocating memory with prepare_lock mutex held makes lockdep unhappy
when memory pressure makes the system do fs_reclaim on eg. rawnand using
clk.

Fix this by allocating with GFP_ATOMIC instead of GFP_KERNEL.

[  462.466020] ======================================================
[  462.472211] WARNING: possible circular locking dependency detected
[  462.478406] 4.19.128-00489-gffc0949c2231 #2 Not tainted
[  462.483641] ------------------------------------------------------
[  462.489831] kswapd0/22 is trying to acquire lock:
[  462.494553] 882c9532 (&c->commit_sem){++++}, at: make_reservation+0x68/0x41c
[  462.501638]
[  462.501638] but task is already holding lock:
[  462.507483] 11f3c233 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x48
[  462.514388]
[  462.514388] which lock already depends on the new lock.
[  462.514388]
[  462.522579]
[  462.522579] the existing dependency chain (in reverse order) is:
[  462.530073]
[  462.530073] -> #4 (fs_reclaim){+.+.}:
[  462.535242]        fs_reclaim_acquire+0x78/0x88
[  462.539792]        kmem_cache_alloc_trace+0x34/0x2e8
[  462.544775]        clk_notifier_register+0x84/0xfc
[  462.549586]        i2c_imx_probe+0x23c/0x678
[  462.553872]        platform_drv_probe+0x50/0xa0
[  462.558419]        really_probe+0x2b8/0x3d8
[  462.562617]        driver_probe_device+0x64/0x16c
[  462.567334]        __driver_attach+0x120/0x144
[  462.571795]        bus_for_each_dev+0x7c/0xc4
[  462.576166]        driver_attach+0x20/0x28
[  462.580276]        bus_add_driver+0x174/0x208
[  462.584646]        driver_register+0x90/0x120
[  462.589016]        __platform_driver_register+0x38/0x4c
[  462.594260]        i2c_adap_imx_init+0x18/0x20
[  462.598721]        do_one_initcall+0x8c/0x32c
[  462.603096]        kernel_init_freeable+0x300/0x3e4
[  462.607993]        kernel_init+0x10/0x114
[  462.612016]        ret_from_fork+0x14/0x20
[  462.616124]          (null)
[  462.618928]
[  462.618928] -> #3 (prepare_lock){+.+.}:
[  462.624270]        __mutex_lock+0x60/0x8dc
[  462.628381]        mutex_lock_nested+0x24/0x2c
[  462.632843]        clk_prepare_lock+0x44/0xec
[  462.637216]        clk_unprepare+0x24/0x34
[  462.641327]        gpmi_disable_clk+0x2c/0x3c
[  462.645697]        gpmi_select_chip+0x84/0xa4
[  462.650071]        nand_read_oob+0x748/0x7b8
[  462.654358]        part_read_oob+0x40/0x78
[  462.658466]        mtd_read+0x10c/0x13c
[  462.662318]        ubi_io_read+0xc8/0x354
[  462.666342]        ubi_eba_read_leb+0xc8/0x544
[  462.670798]        ubi_eba_read_leb_sg+0x70/0x170
[  462.675514]        ubi_leb_read_sg+0x7c/0xbc
[  462.679799]        ubiblock_do_work+0xcc/0x118
[  462.684260]        process_one_work+0x2a4/0x744
[  462.688805]        worker_thread+0x5c/0x554
[  462.693004]        kthread+0x120/0x160
[  462.696767]        ret_from_fork+0x14/0x20
[  462.700874]          (null)
[  462.703676]
[  462.703676] -> #2 (&le->mutex){++++}:
[  462.708842]        down_read+0x3c/0x80
[  462.712608]        ubi_eba_read_leb+0x4c/0x544
[  462.717065]        ubi_leb_read+0x7c/0xbc
[  462.721089]        ubifs_leb_read+0x34/0x80
[  462.725288]        ubifs_read_nnode+0x194/0x208
[  462.729831]        ubifs_lpt_lookup_dirty+0x1e0/0x294
[  462.734899]        ubifs_replay_journal+0x48/0x15a8
[  462.739789]        ubifs_mount+0x104c/0x15f0
[  462.744074]        mount_fs+0x1c/0xb8
[  462.747753]        vfs_kern_mount.part.0+0x58/0x148
[  462.752648]        do_mount+0x6a4/0xec8
[  462.756499]        ksys_mount+0x90/0xbc
[  462.760349]        sys_mount+0x1c/0x24
[  462.764108]        ret_fast_syscall+0x0/0x28
[  462.768390]        0xbebcbb38
[  462.771367]
[  462.771367] -> #1 (&c->lp_mutex){+.+.}:
[  462.776705]        __mutex_lock+0x60/0x8dc
[  462.780818]        mutex_lock_nested+0x24/0x2c
[  462.785277]        ubifs_gc_start_commit+0x28/0x32c
[  462.790170]        do_commit+0x1cc/0x7e4
[  462.794105]        ubifs_run_commit+0x98/0xd0
[  462.798476]        grab_empty_leb+0x60/0x98
[  462.802674]        ubifs_rcvry_gc_commit+0x10c/0x1d8
[  462.807651]        ubifs_mount+0x1308/0x15f0
[  462.811934]        mount_fs+0x1c/0xb8
[  462.815610]        vfs_kern_mount.part.0+0x58/0x148
[  462.820503]        do_mount+0x6a4/0xec8
[  462.824353]        ksys_mount+0x90/0xbc
[  462.828201]        sys_mount+0x1c/0x24
[  462.831962]        ret_fast_syscall+0x0/0x28
[  462.836243]        0xbebcbb38
[  462.839220]
[  462.839220] -> #0 (&c->commit_sem){++++}:
[  462.844733]        lock_acquire+0xd4/0x1f8
[  462.848845]        down_read+0x3c/0x80
[  462.852608]        make_reservation+0x68/0x41c
[  462.857064]        ubifs_jnl_write_data+0x134/0x2b8
[  462.861955]        do_writepage+0x88/0x210
[  462.866063]        ubifs_writepage+0x1b8/0x274
[  462.870522]        shrink_page_list+0x800/0xf68
[  462.875065]        shrink_inactive_list+0x1b4/0x4f0
[  462.879956]        shrink_node+0x44c/0x9c0
[  462.884063]        kswapd+0x3f8/0x928
[  462.887741]        kthread+0x120/0x160
[  462.891504]        ret_from_fork+0x14/0x20
[  462.895609]          (null)
[  462.898412]
[  462.898412] other info that might help us debug this:
[  462.898412]
[  462.906428] Chain exists of:
[  462.906428]   &c->commit_sem --> prepare_lock --> fs_reclaim
[  462.906428]
[  462.916455]  Possible unsafe locking scenario:
[  462.916455]
[  462.922384]        CPU0                    CPU1
[  462.926923]        ----                    ----
[  462.931459]   lock(fs_reclaim);
[  462.934613]                                lock(prepare_lock);
[  462.940458]                                lock(fs_reclaim);
[  462.946127]   lock(&c->commit_sem);
[  462.949628]
[  462.949628]  *** DEADLOCK ***
[  462.949628]
[  462.955563] 1 lock held by kswapd0/22:
[  462.959322]  #0: 11f3c233 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x48

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---

Could have used GPF_NOWAIT, but it seems wrong during memory reclaim.

 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 65508eb89ec9..eb2a547487d6 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4348,7 +4348,7 @@ int clk_notifier_register(struct clk *clk, struct notifier_block *nb)
 			goto found;
 
 	/* if clk wasn't in the notifier list, allocate new clk_notifier */
-	cn = kzalloc(sizeof(*cn), GFP_KERNEL);
+	cn = kzalloc(sizeof(*cn), GFP_ATOMIC);
 	if (!cn)
 		goto out;
 
-- 
2.31.0

