Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FF43F5C33
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbhHXKha convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Aug 2021 06:37:30 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:44753 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbhHXKgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:36:43 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 87C87240008;
        Tue, 24 Aug 2021 10:35:44 +0000 (UTC)
Date:   Tue, 24 Aug 2021 12:35:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [PATCH -next] mtd: fix possible deadlock when loading and
 opening mtd device
Message-ID: <20210824123543.21c6162b@xps13>
In-Reply-To: <20210824103005.1895457-1-yangyingliang@huawei.com>
References: <20210824103005.1895457-1-yangyingliang@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Yang Yingliang <yangyingliang@huawei.com> wrote on Tue, 24 Aug 2021
18:30:05 +0800:

> I got the possible circular locking dependency detected report:

I think that possible lock dependency got fixed (patch has been applied
on mtd/next and is available in linux-next already).

Thanks for the patch anyway!
Miquèl

> 
> [   52.472106][  T483] ======================================================
> [   52.473212][  T483] WARNING: possible circular locking dependency detected
> [   52.474322][  T483] 5.14.0-rc6-next-20210820+ #438 Not tainted
> [   52.475272][  T483] ------------------------------------------------------
> [   52.476385][  T483] systemd-udevd/483 is trying to acquire lock:
> [   52.477356][  T483] ffffffff8c5d45a8 (mtd_table_mutex){+.+.}-{3:3}, at: blktrans_open.cold.18+0x44/0x4b1
> [   52.480510][  T483]
> [   52.480510][  T483] but task is already holding lock:
> [   52.481664][  T483] ffff88810eff8918 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x428/0x910
> [   52.483164][  T483]
> [   52.483164][  T483] which lock already depends on the new lock.
> [   52.483164][  T483]
> [   52.484578][  T483]
> [   52.484578][  T483] the existing dependency chain (in reverse order) is:
> [   52.485803][  T483]
> [   52.485803][  T483] -> #1 (&disk->open_mutex){+.+.}-{3:3}:
> [   52.486888][  T483]        __mutex_lock+0x140/0x15d0
> [   52.487599][  T483]        bd_register_pending_holders+0xb9/0x302
> [   52.488463][  T483]        device_add_disk+0x375/0xcf0
> [   52.489198][  T483]        add_mtd_blktrans_dev+0x11a4/0x16f0
> [   52.490019][  T483]        mtdblock_add_mtd+0x21a/0x2b0
> [   52.490771][  T483]        blktrans_notify_add+0xae/0xdb
> [   52.491531][  T483]        add_mtd_device.cold.26+0xa98/0xc98
> [   52.492348][  T483]        mtd_device_parse_register+0x516/0x870
> [   52.493201][  T483]        mtdram_init_device+0x294/0x350
> [   52.493966][  T483]        init_mtdram+0xde/0x16e
> [   52.494644][  T483]        do_one_initcall+0x105/0x650
> [   52.495381][  T483]        kernel_init_freeable+0x6aa/0x732
> [   52.496171][  T483]        kernel_init+0x1c/0x1c0
> [   52.496847][  T483]        ret_from_fork+0x1f/0x30
> [   52.497530][  T483]
> [   52.497530][  T483] -> #0 (mtd_table_mutex){+.+.}-{3:3}:
> [   52.498591][  T483]        __lock_acquire+0x2cfa/0x5990
> [   52.499343][  T483]        lock_acquire+0x1a0/0x500
> [   52.500041][  T483]        __mutex_lock+0x140/0x15d0
> [   52.500749][  T483]        blktrans_open.cold.18+0x44/0x4b1
> [   52.501545][  T483]        blkdev_get_whole+0x9f/0x280
> [   52.502282][  T483]        blkdev_get_by_dev+0x593/0x910
> [   52.503041][  T483]        blkdev_open+0x154/0x2a0
> [   52.503726][  T483]        do_dentry_open+0x6a9/0x1260
> [   52.504461][  T483]        path_openat+0xe06/0x2850
> [   52.505160][  T483]        do_filp_open+0x1b0/0x280
> [   52.505857][  T483]        do_sys_openat2+0x60e/0x9a0
> [   52.506576][  T483]        do_sys_open+0xca/0x140
> [   52.507251][  T483]        do_syscall_64+0x38/0xb0
> [   52.507936][  T483]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   52.508822][  T483]
> [   52.508822][  T483] other info that might help us debug this:
> [   52.508822][  T483]
> [   52.510218][  T483]  Possible unsafe locking scenario:
> [   52.510218][  T483]
> [   52.511240][  T483]        CPU0                    CPU1
> [   52.511975][  T483]        ----                    ----
> [   52.512708][  T483]   lock(&disk->open_mutex);
> [   52.513342][  T483]                                lock(mtd_table_mutex);
> [   52.514295][  T483]                                lock(&disk->open_mutex);
> [   52.515276][  T483]   lock(mtd_table_mutex);
> [   52.515884][  T483]
> [   52.515884][  T483]  *** DEADLOCK ***
> 
> load module path:              open device path:
> init_mtdram()
> add_mtd_device()
> mutex_lock(&mtd_table_mutex)
> blktrans_notifier()
> add_mtd()
>                                 blkdev_get_by_dev()
>                                 mutex_lock(&disk->open_mutex)
>                                 blktrans_open()
>                                 mutex_lock(&mtd_table_mutex);
> bd_register_pending_holders()
> mutex_lock(&disk->open_mutex)
> 
> add_mtd() is called under mtd_table_mutex, before it acquires open_mutex,
> open_mutex may be acquired by another cpu when opening the device, and it
> will wait for mtd_table_mutex which is already acquired, then the 'ABBA'
> deadlock scenario is happend, reduce the mtd_table_mutex to avoid this.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/mtd/mtd_blkdevs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index 44bea3f65060..476933ab561d 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -358,6 +358,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
>  	list_add_tail(&new->list, &tr->devs);
>   added:
>  	mutex_unlock(&blktrans_ref_mutex);
> +	mutex_unlock(&mtd_table_mutex);
>  
>  	mutex_init(&new->lock);
>  	kref_init(&new->ref);
> @@ -434,6 +435,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
>  					new->disk_attributes);
>  		WARN_ON(ret);
>  	}
> +	mutex_lock(&mtd_table_mutex);
>  	return 0;
>  
>  out_free_tag_set:
> @@ -441,6 +443,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
>  out_kfree_tag_set:
>  	kfree(new->tag_set);
>  out_list_del:
> +	mutex_lock(&mtd_table_mutex);
>  	list_del(&new->list);
>  	return ret;
>  }

