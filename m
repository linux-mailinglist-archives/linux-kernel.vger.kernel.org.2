Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B705A39DB48
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhFGLa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:30:26 -0400
Received: from first.geanix.com ([116.203.34.67]:42672 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230314AbhFGLaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:30:25 -0400
Received: from [192.168.64.199] (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 0E54A465A61;
        Mon,  7 Jun 2021 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1623065312; bh=sRBLjhQQ1DK8GijThZ1yAz8BGDHOivfYQUhDn/PH0w4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=l7KJPmF2OF507DY885ByLqsh9N6hMMPlkP6OUrDjYFX73nnUEBsNtzl8HBOMbOJd8
         0KMJAYQ9muaCcNQ2Gh+5byohCpgo1RGZTw6zMkS2BahOew5mNnSijagi56incjvJZP
         hCyfr7Qfl/JCEXD5VbOJ3xrx5nwMroYMfX2eEKgQXVtNAn9uhuzv7cSAn/JXzcnMkL
         jEC0h6cqqv6H48+GZFaax0+Qwyb1d0u6Pt8Z2EBUV6K4LhJRp3+GXUrwdqLJLUgUSS
         rS4/UjltXVXN+v2AeJm18umYCr6V5935bCSRATYzDbmbYxUMr9HUzcYfaCaX4Gxudx
         uB8SZkbHt790w==
Subject: Re: [RFC PATCH] clk: fix possible circular locking in
 clk_notifier_register()
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210607110154.1291335-1-sean@geanix.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <6cbea3c8-80b8-62aa-8a58-a31d548e1d91@geanix.com>
Date:   Mon, 7 Jun 2021 13:28:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210607110154.1291335-1-sean@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=4.0 tests=ALL_TRUSTED,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2021 13.01, Sean Nyekjaer wrote:
> Allocating memory with prepare_lock mutex held makes lockdep unhappy
> when memory pressure makes the system do fs_reclaim on eg. rawnand using
> clk.
> 
> Fix this by allocating with GFP_ATOMIC instead of GFP_KERNEL.
> 
> [  462.466020] ======================================================
> [  462.472211] WARNING: possible circular locking dependency detected
> [  462.478406] 4.19.128-00489-gffc0949c2231 #2 Not tainted
> [  462.483641] ------------------------------------------------------
> [  462.489831] kswapd0/22 is trying to acquire lock:
> [  462.494553] 882c9532 (&c->commit_sem){++++}, at: make_reservation+0x68/0x41c
> [  462.501638]
> [  462.501638] but task is already holding lock:
> [  462.507483] 11f3c233 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x48
> [  462.514388]
> [  462.514388] which lock already depends on the new lock.
> [  462.514388]
> [  462.522579]
> [  462.522579] the existing dependency chain (in reverse order) is:
> [  462.530073]
> [  462.530073] -> #4 (fs_reclaim){+.+.}:
> [  462.535242]        fs_reclaim_acquire+0x78/0x88
> [  462.539792]        kmem_cache_alloc_trace+0x34/0x2e8
> [  462.544775]        clk_notifier_register+0x84/0xfc
> [  462.549586]        i2c_imx_probe+0x23c/0x678
> [  462.553872]        platform_drv_probe+0x50/0xa0
> [  462.558419]        really_probe+0x2b8/0x3d8
> [  462.562617]        driver_probe_device+0x64/0x16c
> [  462.567334]        __driver_attach+0x120/0x144
> [  462.571795]        bus_for_each_dev+0x7c/0xc4
> [  462.576166]        driver_attach+0x20/0x28
> [  462.580276]        bus_add_driver+0x174/0x208
> [  462.584646]        driver_register+0x90/0x120
> [  462.589016]        __platform_driver_register+0x38/0x4c
> [  462.594260]        i2c_adap_imx_init+0x18/0x20
> [  462.598721]        do_one_initcall+0x8c/0x32c
> [  462.603096]        kernel_init_freeable+0x300/0x3e4
> [  462.607993]        kernel_init+0x10/0x114
> [  462.612016]        ret_from_fork+0x14/0x20
> [  462.616124]          (null)
> [  462.618928]
> [  462.618928] -> #3 (prepare_lock){+.+.}:
> [  462.624270]        __mutex_lock+0x60/0x8dc
> [  462.628381]        mutex_lock_nested+0x24/0x2c
> [  462.632843]        clk_prepare_lock+0x44/0xec
> [  462.637216]        clk_unprepare+0x24/0x34
> [  462.641327]        gpmi_disable_clk+0x2c/0x3c
> [  462.645697]        gpmi_select_chip+0x84/0xa4
> [  462.650071]        nand_read_oob+0x748/0x7b8
> [  462.654358]        part_read_oob+0x40/0x78
> [  462.658466]        mtd_read+0x10c/0x13c
> [  462.662318]        ubi_io_read+0xc8/0x354
> [  462.666342]        ubi_eba_read_leb+0xc8/0x544
> [  462.670798]        ubi_eba_read_leb_sg+0x70/0x170
> [  462.675514]        ubi_leb_read_sg+0x7c/0xbc
> [  462.679799]        ubiblock_do_work+0xcc/0x118
> [  462.684260]        process_one_work+0x2a4/0x744
> [  462.688805]        worker_thread+0x5c/0x554
> [  462.693004]        kthread+0x120/0x160
> [  462.696767]        ret_from_fork+0x14/0x20
> [  462.700874]          (null)
> [  462.703676]
> [  462.703676] -> #2 (&le->mutex){++++}:
> [  462.708842]        down_read+0x3c/0x80
> [  462.712608]        ubi_eba_read_leb+0x4c/0x544
> [  462.717065]        ubi_leb_read+0x7c/0xbc
> [  462.721089]        ubifs_leb_read+0x34/0x80
> [  462.725288]        ubifs_read_nnode+0x194/0x208
> [  462.729831]        ubifs_lpt_lookup_dirty+0x1e0/0x294
> [  462.734899]        ubifs_replay_journal+0x48/0x15a8
> [  462.739789]        ubifs_mount+0x104c/0x15f0
> [  462.744074]        mount_fs+0x1c/0xb8
> [  462.747753]        vfs_kern_mount.part.0+0x58/0x148
> [  462.752648]        do_mount+0x6a4/0xec8
> [  462.756499]        ksys_mount+0x90/0xbc
> [  462.760349]        sys_mount+0x1c/0x24
> [  462.764108]        ret_fast_syscall+0x0/0x28
> [  462.768390]        0xbebcbb38
> [  462.771367]
> [  462.771367] -> #1 (&c->lp_mutex){+.+.}:
> [  462.776705]        __mutex_lock+0x60/0x8dc
> [  462.780818]        mutex_lock_nested+0x24/0x2c
> [  462.785277]        ubifs_gc_start_commit+0x28/0x32c
> [  462.790170]        do_commit+0x1cc/0x7e4
> [  462.794105]        ubifs_run_commit+0x98/0xd0
> [  462.798476]        grab_empty_leb+0x60/0x98
> [  462.802674]        ubifs_rcvry_gc_commit+0x10c/0x1d8
> [  462.807651]        ubifs_mount+0x1308/0x15f0
> [  462.811934]        mount_fs+0x1c/0xb8
> [  462.815610]        vfs_kern_mount.part.0+0x58/0x148
> [  462.820503]        do_mount+0x6a4/0xec8
> [  462.824353]        ksys_mount+0x90/0xbc
> [  462.828201]        sys_mount+0x1c/0x24
> [  462.831962]        ret_fast_syscall+0x0/0x28
> [  462.836243]        0xbebcbb38
> [  462.839220]
> [  462.839220] -> #0 (&c->commit_sem){++++}:
> [  462.844733]        lock_acquire+0xd4/0x1f8
> [  462.848845]        down_read+0x3c/0x80
> [  462.852608]        make_reservation+0x68/0x41c
> [  462.857064]        ubifs_jnl_write_data+0x134/0x2b8
> [  462.861955]        do_writepage+0x88/0x210
> [  462.866063]        ubifs_writepage+0x1b8/0x274
> [  462.870522]        shrink_page_list+0x800/0xf68
> [  462.875065]        shrink_inactive_list+0x1b4/0x4f0
> [  462.879956]        shrink_node+0x44c/0x9c0
> [  462.884063]        kswapd+0x3f8/0x928
> [  462.887741]        kthread+0x120/0x160
> [  462.891504]        ret_from_fork+0x14/0x20
> [  462.895609]          (null)
> [  462.898412]
> [  462.898412] other info that might help us debug this:
> [  462.898412]
> [  462.906428] Chain exists of:
> [  462.906428]   &c->commit_sem --> prepare_lock --> fs_reclaim
> [  462.906428]
> [  462.916455]  Possible unsafe locking scenario:
> [  462.916455]
> [  462.922384]        CPU0                    CPU1
> [  462.926923]        ----                    ----
> [  462.931459]   lock(fs_reclaim);
> [  462.934613]                                lock(prepare_lock);
> [  462.940458]                                lock(fs_reclaim);
> [  462.946127]   lock(&c->commit_sem);
> [  462.949628]
> [  462.949628]  *** DEADLOCK ***
> [  462.949628]
> [  462.955563] 1 lock held by kswapd0/22:
> [  462.959322]  #0: 11f3c233 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x48
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> 
> Could have used GPF_NOWAIT, but it seems wrong during memory reclaim.
> 

Hi,

Seems like this results in a deadlock another place :/
Does anyone have an idea to whats happening..?

/Sean

[ 1462.362442] ======================================================

[ 1462.368635] WARNING: possible circular locking dependency detected

[ 1462.374829] 4.19.128-00489-gffc0949c2231-dirty #8 Not tainted

[ 1462.380585] ------------------------------------------------------

[ 1462.386776] kswapd0/22 is trying to acquire lock:

[ 1462.391495] 24766f3c (&c->commit_sem){++++}, at: make_reservation+0x68/0x41c

[ 1462.398581] 

[ 1462.398581] but task is already holding lock:

[ 1462.404424] d2d78f56 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x48

[ 1462.411330] 

[ 1462.411330] which lock already depends on the new lock.

[ 1462.411330] 

[ 1462.419521] 

[ 1462.419521] the existing dependency chain (in reverse order) is:

[ 1462.427015] 

[ 1462.427015] -> #5 (fs_reclaim){+.+.}:

[ 1462.432181]        fs_reclaim_acquire+0x78/0x88

[ 1462.436729]        __kmalloc+0x48/0x31c

[ 1462.440583]        pcpu_mem_zalloc+0x34/0x8c

[ 1462.444871]        pcpu_create_chunk+0x20/0x270

[ 1462.449415]        pcpu_balance_workfn+0x5dc/0x74c

[ 1462.454224]        process_one_work+0x2a4/0x744

[ 1462.458768]        worker_thread+0x5c/0x554

[ 1462.462968]        kthread+0x120/0x160

[ 1462.466731]        ret_from_fork+0x14/0x20

[ 1462.470839]          (null)

[ 1462.473643] 

[ 1462.473643] -> #4 (pcpu_alloc_mutex){+.+.}:

[ 1462.479334]        __mutex_lock+0x60/0x8dc

[ 1462.483447]        mutex_lock_killable_nested+0x24/0x30

[ 1462.488686]        pcpu_alloc+0x404/0x854

[ 1462.492708]        __alloc_percpu+0x18/0x20

[ 1462.496911]        init_srcu_struct_fields+0x3e4/0x460

[ 1462.502063]        __init_srcu_struct+0x50/0x5c

[ 1462.506609]        srcu_init_notifier_head+0x2c/0x54

[ 1462.511593]        clk_notifier_register+0x9c/0xfc

[ 1462.516403]        i2c_imx_probe+0x23c/0x678

[ 1462.520690]        platform_drv_probe+0x50/0xa0

[ 1462.525240]        really_probe+0x2b8/0x3d8

[ 1462.529437]        driver_probe_device+0x64/0x16c

[ 1462.534157]        __driver_attach+0x120/0x144

[ 1462.538617]        bus_for_each_dev+0x7c/0xc4

[ 1462.542987]        driver_attach+0x20/0x28

[ 1462.547098]        bus_add_driver+0x174/0x208

[ 1462.551469]        driver_register+0x90/0x120

[ 1462.555836]        __platform_driver_register+0x38/0x4c

[ 1462.561082]        i2c_adap_imx_init+0x18/0x20

[ 1462.565543]        do_one_initcall+0x8c/0x32c

[ 1462.569919]        kernel_init_freeable+0x300/0x3e4

[ 1462.574816]        kernel_init+0x10/0x114

[ 1462.578838]        ret_from_fork+0x14/0x20

[ 1462.582944]          (null)

[ 1462.585746] 

[ 1462.585746] -> #3 (prepare_lock){+.+.}:

[ 1462.591087]        __mutex_lock+0x60/0x8dc

[ 1462.595197]        mutex_lock_nested+0x24/0x2c

[ 1462.599655]        clk_prepare_lock+0x44/0xec

[ 1462.604027]        clk_unprepare+0x24/0x34

[ 1462.608139]        gpmi_disable_clk+0x2c/0x3c

[ 1462.612510]        gpmi_select_chip+0x84/0xa4

[ 1462.616883]        nand_read_oob+0x748/0x7b8

[ 1462.621169]        part_read_oob+0x40/0x78

[ 1462.625279]        mtd_read+0x10c/0x13c

[ 1462.629131]        ubi_io_read+0xc8/0x354

[ 1462.633155]        ubi_eba_read_leb+0xc8/0x544

[ 1462.637612]        ubi_eba_read_leb_sg+0x70/0x170

[ 1462.642329]        ubi_leb_read_sg+0x7c/0xbc

[ 1462.646615]        ubiblock_do_work+0xcc/0x118

[ 1462.651073]        process_one_work+0x2a4/0x744

[ 1462.655616]        worker_thread+0x5c/0x554

[ 1462.659815]        kthread+0x120/0x160

[ 1462.663577]        ret_from_fork+0x14/0x20

[ 1462.667683]          (null)

[ 1462.670483] 

[ 1462.670483] -> #2 (&le->mutex){++++}:

[ 1462.675653]        down_read+0x3c/0x80

[ 1462.679416]        ubi_eba_read_leb+0x4c/0x544

[ 1462.683872]        ubi_leb_read+0x7c/0xbc

[ 1462.687896]        ubifs_leb_read+0x34/0x80

[ 1462.692093]        ubifs_read_node+0x9c/0x268

[ 1462.696465]        ubifs_load_znode+0x90/0x4a4

[ 1462.700927]        ubifs_lookup_level0+0x1c8/0x214

[ 1462.705733]        ubifs_tnc_locate+0x60/0x1f4

[ 1462.710189]        ubifs_iget+0x9c/0x554

[ 1462.714125]        ubifs_mount+0x1278/0x15f0

[ 1462.718410]        mount_fs+0x1c/0xb8

[ 1462.722092]        vfs_kern_mount.part.0+0x58/0x148

[ 1462.726988]        do_mount+0x6a4/0xec8

[ 1462.730839]        ksys_mount+0x90/0xbc

[ 1462.734690]        sys_mount+0x1c/0x24

[ 1462.738453]        ret_fast_syscall+0x0/0x28

[ 1462.742734]        0xbedf2b38

[ 1462.745710] 

[ 1462.745710] -> #1 (&c->tnc_mutex){+.+.}:

[ 1462.751139]        __mutex_lock+0x60/0x8dc

[ 1462.755250]        mutex_lock_nested+0x24/0x2c

[ 1462.759709]        ubifs_tnc_add_nm+0x44/0x268

[ 1462.764165]        ubifs_jnl_update+0x508/0x694

[ 1462.768709]        ubifs_mkdir+0x1b8/0x25c

[ 1462.772820]        vfs_mkdir+0xcc/0x13c

[ 1462.776672]        do_mkdirat+0x88/0x118

[ 1462.780606]        sys_mkdir+0x1c/0x20

[ 1462.784369]        ret_fast_syscall+0x0/0x28

[ 1462.788649]        0xbedf16e4

[ 1462.791624] 

[ 1462.791624] -> #0 (&c->commit_sem){++++}:

[ 1462.797136]        lock_acquire+0xd4/0x1f8

[ 1462.801247]        down_read+0x3c/0x80

[ 1462.805010]        make_reservation+0x68/0x41c

[ 1462.809465]        ubifs_jnl_write_data+0x134/0x2b8

[ 1462.814356]        do_writepage+0x88/0x210

[ 1462.818465]        ubifs_writepage+0x1b8/0x274

[ 1462.822923]        shrink_page_list+0x800/0xf68

[ 1462.827466]        shrink_inactive_list+0x1b4/0x4f0

[ 1462.832354]        shrink_node+0x44c/0x9c0

[ 1462.836462]        kswapd+0x3f8/0x928

[ 1462.840140]        kthread+0x120/0x160

[ 1462.843903]        ret_from_fork+0x14/0x20

[ 1462.848008]          (null)

[ 1462.850810] 

[ 1462.850810] other info that might help us debug this:

[ 1462.850810] 

[ 1462.858827] Chain exists of:

[ 1462.858827]   &c->commit_sem --> pcpu_alloc_mutex --> fs_reclaim

[ 1462.858827] 

[ 1462.869200]  Possible unsafe locking scenario:

[ 1462.869200] 

[ 1462.875130]        CPU0                    CPU1

[ 1462.879668]        ----                    ----

[ 1462.884204]   lock(fs_reclaim);

[ 1462.887357]                                lock(pcpu_alloc_mutex);

[ 1462.893549]                                lock(fs_reclaim);

[ 1462.899218]   lock(&c->commit_sem);

[ 1462.902720] 

[ 1462.902720]  *** DEADLOCK ***

[ 1462.902720] 

[ 1462.908655] 1 lock held by kswapd0/22:

[ 1462.912412]  #0: d2d78f56 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x48

