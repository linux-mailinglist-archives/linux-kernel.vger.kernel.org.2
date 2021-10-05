Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D1B42209C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhJEIY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:24:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45842 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhJEIY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:24:56 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6D8531F41E9F;
        Tue,  5 Oct 2021 09:23:05 +0100 (BST)
Date:   Tue, 5 Oct 2021 10:23:00 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mtd: rawnand: use mutex to protect access while in
 suspend
Message-ID: <20211005102300.5da6d480@collabora.com>
In-Reply-To: <20211005070930.epgxb5qzumk4awxq@skn-laptop>
References: <20211004065608.3190348-1-sean@geanix.com>
        <20211004104147.579f3b01@collabora.com>
        <20211004085509.iikxtdvxpt6bri5c@skn-laptop>
        <20211004115817.18739936@collabora.com>
        <20211004101246.kagtezizympxupat@skn-laptop>
        <20211004134700.26327f6f@collabora.com>
        <20211005070930.epgxb5qzumk4awxq@skn-laptop>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 09:09:30 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On Mon, Oct 04, 2021 at 01:47:00PM +0200, Boris Brezillon wrote:
> > On Mon, 4 Oct 2021 12:12:46 +0200
> > Sean Nyekjaer <sean@geanix.com> wrote:
> >   
> > > On Mon, Oct 04, 2021 at 11:58:17AM +0200, Boris Brezillon wrote:  
> > > > On Mon, 4 Oct 2021 10:55:09 +0200
> > > > Sean Nyekjaer <sean@geanix.com> wrote:
> > > >     
> > > > > On Mon, Oct 04, 2021 at 10:41:47AM +0200, Boris Brezillon wrote:    
> > > > > > On Mon,  4 Oct 2021 08:56:09 +0200
> > > > > > Sean Nyekjaer <sean@geanix.com> wrote:
> > > > > >       
> > > > > > > This will prevent nand_get_device() from returning -EBUSY.
> > > > > > > It will force mtd_write()/mtd_read() to wait for the nand_resume() to unlock
> > > > > > > access to the mtd device.
> > > > > > > 
> > > > > > > Then we avoid -EBUSY is returned to ubifsi via mtd_write()/mtd_read(),
> > > > > > > that will in turn hard error on every error returened.
> > > > > > > We have seen during ubifs tries to call mtd_write before the mtd device
> > > > > > > is resumed.      
> > > > > > 
> > > > > > I think the problem is here. Why would UBIFS/UBI try to write something
> > > > > > to a device that's not resumed yet (or has been suspended already, if
> > > > > > you hit this in the suspend path).
> > > > > >       
> > > > > > > 
> > > > > > > Exec_op[0] speed things up, so we see this race when the device is
> > > > > > > resuming. But it's actually "mtd: rawnand: Simplify the locking" that
> > > > > > > allows it to return -EBUSY, before that commit it would have waited for
> > > > > > > the mtd device to resume.      
> > > > > > 
> > > > > > Uh, wait. If nand_resume() was called before any writes/reads this
> > > > > > wouldn't happen. IMHO, the problem is not that we return -EBUSY without
> > > > > > blocking, the problem is that someone issues a write/read before calling
> > > > > > mtd_resume().
> > > > > >       
> > > > > 
> > > > > The commit msg from "mtd: rawnand: Simplify the locking" states this clearly.
> > > > > 
> > > > > """
> > > > > Last important change to mention: we now return -EBUSY when someone
> > > > > tries to access a device that as been suspended, and propagate this
> > > > > error to the upper layer.
> > > > > """
> > > > > 
> > > > > IMHO "mtd: rawnand: Simplify the locking" should never had been merged
> > > > > before the upper layers was fixed to handle -EBUSY. ;)
> > > > > Which they still not are...    
> > > > 
> > > > That's not really the problem here. Upper layers should never get
> > > > -EBUSY in the first place if the MTD device was resumed before the UBI
> > > > device. Looks like we have a missing UBI -> MTD parenting link, which
> > > > would explain why things don't get resumed in the right order. Can you
> > > > try with the following diff applied?
> > > > 
> > > > ---
> > > > diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> > > > index f399edc82191..1981ce8f3a26 100644
> > > > --- a/drivers/mtd/ubi/build.c
> > > > +++ b/drivers/mtd/ubi/build.c
> > > > @@ -905,6 +905,7 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int
> > > > ubi_num, ubi->dev.release = dev_release;
> > > >         ubi->dev.class = &ubi_class;
> > > >         ubi->dev.groups = ubi_dev_groups;
> > > > +       ubi->dev.parent = &mtd->dev;
> > > >  
> > > >         ubi->mtd = mtd;
> > > >         ubi->ubi_num = ubi_num;
> > > >     
> > > 
> > > No change:
> > > [   71.739193] Filesystems sync: 34.212 seconds
> > > [   71.755044] Freezing user space processes ... (elapsed 0.004 seconds) done.
> > > [   71.767289] OOM killer disabled.
> > > [   71.770552] Freezing remaining freezable tasks ... (elapsed 0.004 seconds) done.
> > > [   71.782182] printk: Suspending console(s) (use no_console_suspend to debug)
> > > [   71.824391] nand_suspend
> > > [   71.825177] gpmi_pm_suspend
> > > [   71.825676] PM: suspend devices took 0.040 seconds
> > > [   71.825971] nand_write_oob - nand_get_device() returned -EBUSY
> > > [   71.825985] ubi0 error: ubi_io_write: error -16 while writing 4096 bytes to PEB 986:65536, written 0 bytes
> > > [   71.826029] CPU: 0 PID: 7 Comm: kworker/u2:0 Not tainted 5.15.0-rc3-dirty #43
> > > [   71.826043] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
> > > [   71.826054] Workqueue: writeback wb_workfn (flush-ubifs_0_8)
> > > [   71.826094] [<c010da84>] (unwind_backtrace) from [<c010a1b4>] (show_stack+0x10/0x14)
> > > [   71.826122] [<c010a1b4>] (show_stack) from [<c0989c30>] (dump_stack_lvl+0x40/0x4c)
> > > [   71.826151] [<c0989c30>] (dump_stack_lvl) from [<c05ed690>] (ubi_io_write+0x510/0x6b0)
> > > [   71.826178] [<c05ed690>] (ubi_io_write) from [<c05ea2f0>] (ubi_eba_write_leb+0xd0/0x968)
> > > [   71.826204] [<c05ea2f0>] (ubi_eba_write_leb) from [<c05e8754>] (ubi_leb_write+0xd0/0xe8)
> > > [   71.826232] [<c05e8754>] (ubi_leb_write) from [<c03d67bc>] (ubifs_leb_write+0x68/0x104)
> > > [   71.826263] [<c03d67bc>] (ubifs_leb_write) from [<c03d79e8>] (ubifs_wbuf_write_nolock+0x28c/0x74c)
> > > [   71.826291] [<c03d79e8>] (ubifs_wbuf_write_nolock) from [<c03ca18c>] (ubifs_jnl_write_data+0x1b8/0x2b4)
> > > [   71.826319] [<c03ca18c>] (ubifs_jnl_write_data) from [<c03cd184>] (do_writepage+0x190/0x284)
> > > [   71.826342] [<c03cd184>] (do_writepage) from [<c023083c>] (__writepage+0x14/0x68)
> > > [   71.826367] [<c023083c>] (__writepage) from [<c0231748>] (write_cache_pages+0x1c8/0x3f0)
> > > [   71.826390] [<c0231748>] (write_cache_pages) from [<c0233854>] (do_writepages+0xcc/0x1f4)
> > > [   71.826413] [<c0233854>] (do_writepages) from [<c02d03dc>] (__writeback_single_inode+0x2c/0x1b4)
> > > [   71.826440] [<c02d03dc>] (__writeback_single_inode) from [<c02d0a64>] (writeback_sb_inodes+0x200/0x470)
> > > [   71.826466] [<c02d0a64>] (writeback_sb_inodes) from [<c02d0d10>] (__writeback_inodes_wb+0x3c/0xf4)
> > > [   71.826493] [<c02d0d10>] (__writeback_inodes_wb) from [<c02d0f58>] (wb_writeback+0x190/0x1f0)
> > > [   71.826520] [<c02d0f58>] (wb_writeback) from [<c02d21d8>] (wb_workfn+0x2c0/0x3d4)
> > > [   71.826545] [<c02d21d8>] (wb_workfn) from [<c013ac04>] (process_one_work+0x1e0/0x440)
> > > [   71.826574] [<c013ac04>] (process_one_work) from [<c013aeac>] (worker_thread+0x48/0x594)
> > > [   71.826600] [<c013aeac>] (worker_thread) from [<c0142364>] (kthread+0x134/0x15c)
> > > [   71.826625] [<c0142364>] (kthread) from [<c0100150>] (ret_from_fork+0x14/0x24)  
> > 
> > I'm not entirely sure, but given the timing, it looks like this
> > actually happens in the suspend path, not it the resume path. What I
> > don't get is why we still have a kernel thread running at that point.  
> 
> Have you seen the reproducer script?

How would I know about this script or your previous attempt (mentioned
at the end of this email) given I was not Cc-ed on the previous
discussion, and nothing mentions it in this RFC...

> ---
> root@iwg26-v1:/data/root# cat /data/crash.sh
> #!/bin/sh -x
> 
> echo enabled > /sys/devices/platform/soc/2100000.bus/21f4000.serial/tty/ttymxc4/power/wakeup
> 
> rm /data/test50M
> dd if=/dev/urandom of=/tmp/test50M bs=1M count=50
> cp /tmp/test50M /data/ &
> sleep 1
> echo mem > /sys/power/state
> ---
> 
> As seen in the log above disk is synced before suspend.
> cp is continuing to copy data to ubifs.
> And then user space processes are frozen.
> At this point the kernel thread would have unwritten data.
> 
> We tried to solve this with:
> https://lkml.org/lkml/2021/9/1/280

I see. It's still unclear to me when the write happens. Is it in the
suspend path (before the system is actually suspended), or in the
resume path (when the system is being resumed).

Anyway, let's admit writing to a storage device while it's suspended is
a valid use case and requires the storage layer to put this request on
old. This wait should not, IMHO, be handled at the NAND level, but at
the MTD level (using a waitqueue, and an atomic to make
suspended/resumed transitions safe). And abusing a mutex to implement
that is certainly not a good idea.
