Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD563EEA8F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbhHQKHU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Aug 2021 06:07:20 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:36325 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbhHQKFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:05:04 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 6A8D524000F;
        Tue, 17 Aug 2021 10:04:02 +0000 (UTC)
Date:   Tue, 17 Aug 2021 12:04:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] mtd: mtdconcat: Check existence of _read|_write from
 subdev'master device before assigning
Message-ID: <20210817120401.1ccf98bd@xps13>
In-Reply-To: <8b315831-84c5-38f3-d3b7-bb53f52c28b8@huawei.com>
References: <20210817024552.1691649-1-chengzhihao1@huawei.com>
        <8b315831-84c5-38f3-d3b7-bb53f52c28b8@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhihao,

Zhihao Cheng <chengzhihao1@huawei.com> wrote on Tue, 17 Aug 2021
10:45:55 +0800:

> 在 2021/8/17 10:45, Zhihao Cheng 写道:
> Hi Miquel,
> I found a better way to fix the "WARNING" on _read|_read_oob checking. Since sub-mtd device has been registered successfully, we can check against the existence of _read|_read_oob callbacks by subdev's master device.
> BTW, fix missing space between the SHA1 and the subject suggested by Stephen.

I am a bit lost, I need to see the big picture again. I will drop the
current patches that applied, please resend the full series with a
changelog.

> > Since 2431c4f5b46c3 ("mtd: Implement mtd_{read,write}() as wrappers
> > around mtd_{read,write}_oob()") don't allow _write|_read and
> > _write_oob|_read_oob existing at the same time. We should check the

                                                  , we

> > existence of callbacks "_read and _write" from subdev's master device
> > (We can trust master device since it has been registered) before
> > assigning, otherwise following warning occurs while making
> > concatenated device:
> >
> >    WARNING: CPU: 2 PID: 6728 at drivers/mtd/mtdcore.c:595
> >    add_mtd_device+0x7f/0x7b0
> >
> > Fixes: 2431c4f5b46c3 ("mtd: Implement mtd_{read,write}() around ...")

                                                             ^
Wrong commit message

> > Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> > ---

Also, please shorten a bit the two commit titles, like:

mtd: mtdconcat: Judge callback existence based on the master

Finally, in the other patch, there is a typo in the example
reproduce.c (combine misspelled).

> >   drivers/mtd/mtdconcat.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
> > index af51eee6b5e8..f685a581df48 100644
> > --- a/drivers/mtd/mtdconcat.c
> > +++ b/drivers/mtd/mtdconcat.c
> > @@ -694,6 +694,10 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
> >   		concat->mtd._block_markbad = concat_block_markbad;
> >   	if (subdev_master->_panic_write)
> >   		concat->mtd._panic_write = concat_panic_write;
> > +	if (subdev_master->_read)
> > +		concat->mtd._read = concat_read;
> > +	if (subdev_master->_write)
> > +		concat->mtd._write = concat_write;  
> >   >   	concat->mtd.ecc_stats.badblocks = subdev[0]->ecc_stats.badblocks;
> >   > @@ -755,8 +759,6 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c  
> >   	concat->mtd.name = name;  
> >   >   	concat->mtd._erase = concat_erase;  
> > -	concat->mtd._read = concat_read;
> > -	concat->mtd._write = concat_write;
> >   	concat->mtd._sync = concat_sync;
> >   	concat->mtd._lock = concat_lock;
> >   	concat->mtd._unlock = concat_unlock;  
> 
> 

Thanks,
Miquèl
