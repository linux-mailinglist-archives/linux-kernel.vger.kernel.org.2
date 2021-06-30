Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6817D3B7F35
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 10:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbhF3Iq3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Jun 2021 04:46:29 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52981 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbhF3Iq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 04:46:28 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id BF226C0009;
        Wed, 30 Jun 2021 08:43:54 +0000 (UTC)
Date:   Wed, 30 Jun 2021 10:43:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] mtd: break circular locks in register_mtd_blktrans
Message-ID: <20210630104353.7575e920@xps13>
In-Reply-To: <03e19ec8-7479-9be2-3563-a2fcf9d0ec0c@gmail.com>
References: <20210617160904.570111-1-desmondcheongzx@gmail.com>
        <03e19ec8-7479-9be2-3563-a2fcf9d0ec0c@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com> wrote on Wed, 30 Jun
2021 16:04:17 +0800:

> On 18/6/21 12:09 am, Desmond Cheong Zhi Xi wrote:
> > Syzbot reported a circular locking dependency:
> > https://syzkaller.appspot.com/bug?id=7bd106c28e846d1023d4ca915718b1a0905444cb
> > 
> > This happens because of the following lock dependencies:
> > 
> > 1. loop_ctl_mutex -> bdev->bd_mutex (when loop_control_ioctl calls
> > loop_remove, which then calls del_gendisk; this also happens in
> > loop_exit which eventually calls loop_remove)
> > 
> > 2. bdev->bd_mutex -> mtd_table_mutex (when blkdev_get_by_dev calls
> > __blkdev_get, which then calls blktrans_open)
> > 
> > 3. mtd_table_mutex -> major_names_lock (when register_mtd_blktrans
> > calls __register_blkdev)
> > 
> > 4. major_names_lock -> loop_ctl_mutex (when blk_request_module calls
> > loop_probe)
> > 
> > Hence there's an overall dependency of:
> > 
> > loop_ctl_mutex   ----------> bdev->bd_mutex
> >        ^                            |
> >        |                            |
> >        |                            v
> > major_names_lock <---------  mtd_table_mutex
> > 
> > We can break this circular dependency by holding mtd_table_mutex only
> > for the required critical section in register_mtd_blktrans. This
> > avoids the mtd_table_mutex -> major_names_lock dependency.
> > 
> > Reported-and-tested-by: syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com
> > Co-developed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> > ---
> > 
> > Changes in v1 -> v2:
> > 
> > Break the circular dependency in register_mtd_blktrans instead of blk_request_module, as suggested by Christoph Hellwig.
> > 
> >   drivers/mtd/mtd_blkdevs.c | 8 ++------
> >   1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> > index fb8e12d590a1..7d26cfe24d05 100644
> > --- a/drivers/mtd/mtd_blkdevs.c
> > +++ b/drivers/mtd/mtd_blkdevs.c
> > @@ -528,14 +528,10 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
> >   	if (!blktrans_notifier.list.next)
> >   		register_mtd_user(&blktrans_notifier);
> >   > -
> > -	mutex_lock(&mtd_table_mutex);
> > -
> >   	ret = register_blkdev(tr->major, tr->name);
> >   	if (ret < 0) {
> >   		printk(KERN_WARNING "Unable to register %s block device on major %d: %d\n",
> >   		       tr->name, tr->major, ret);
> > -		mutex_unlock(&mtd_table_mutex);
> >   		return ret;
> >   	}
> >   > @@ -545,12 +541,12 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
> >   	tr->blkshift = ffs(tr->blksize) - 1;
> >   >   	INIT_LIST_HEAD(&tr->devs);
> > -	list_add(&tr->list, &blktrans_majors);
> >   > +	mutex_lock(&mtd_table_mutex);
> > +	list_add(&tr->list, &blktrans_majors);
> >   	mtd_for_each_device(mtd)
> >   		if (mtd->type != MTD_ABSENT)
> >   			tr->add_mtd(tr, mtd);
> > -
> >   	mutex_unlock(&mtd_table_mutex);
> >   	return 0;
> >   }
> > 
> 
> Hi maintainers,
> 
> Any chance to review this patch?
> 
> For additional reference, the mtd_table_mutex --> major_names_lock hierarchy that can be removed by this patch also appears in a different lock chain:
> https://syzkaller.appspot.com/bug?id=cbf5fe846f14a90f05e10df200b08c57941dc750

I'm fine with the patch, but it came too late in the release cycle so
now I'm waiting -rc1 to apply it.

Thanks,
Miquèl
