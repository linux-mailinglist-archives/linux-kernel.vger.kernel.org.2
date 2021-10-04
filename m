Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBEF4208DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 11:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhJDKAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:00:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51750 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbhJDKAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:00:11 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D5C2E1F42EC7;
        Mon,  4 Oct 2021 10:58:20 +0100 (BST)
Date:   Mon, 4 Oct 2021 11:58:17 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mtd: rawnand: use mutex to protect access while in
 suspend
Message-ID: <20211004115817.18739936@collabora.com>
In-Reply-To: <20211004085509.iikxtdvxpt6bri5c@skn-laptop>
References: <20211004065608.3190348-1-sean@geanix.com>
        <20211004104147.579f3b01@collabora.com>
        <20211004085509.iikxtdvxpt6bri5c@skn-laptop>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2021 10:55:09 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On Mon, Oct 04, 2021 at 10:41:47AM +0200, Boris Brezillon wrote:
> > On Mon,  4 Oct 2021 08:56:09 +0200
> > Sean Nyekjaer <sean@geanix.com> wrote:
> >   
> > > This will prevent nand_get_device() from returning -EBUSY.
> > > It will force mtd_write()/mtd_read() to wait for the nand_resume() to unlock
> > > access to the mtd device.
> > > 
> > > Then we avoid -EBUSY is returned to ubifsi via mtd_write()/mtd_read(),
> > > that will in turn hard error on every error returened.
> > > We have seen during ubifs tries to call mtd_write before the mtd device
> > > is resumed.  
> > 
> > I think the problem is here. Why would UBIFS/UBI try to write something
> > to a device that's not resumed yet (or has been suspended already, if
> > you hit this in the suspend path).
> >   
> > > 
> > > Exec_op[0] speed things up, so we see this race when the device is
> > > resuming. But it's actually "mtd: rawnand: Simplify the locking" that
> > > allows it to return -EBUSY, before that commit it would have waited for
> > > the mtd device to resume.  
> > 
> > Uh, wait. If nand_resume() was called before any writes/reads this
> > wouldn't happen. IMHO, the problem is not that we return -EBUSY without
> > blocking, the problem is that someone issues a write/read before calling
> > mtd_resume().
> >   
> 
> The commit msg from "mtd: rawnand: Simplify the locking" states this clearly.
> 
> """
> Last important change to mention: we now return -EBUSY when someone
> tries to access a device that as been suspended, and propagate this
> error to the upper layer.
> """
> 
> IMHO "mtd: rawnand: Simplify the locking" should never had been merged
> before the upper layers was fixed to handle -EBUSY. ;)
> Which they still not are...

That's not really the problem here. Upper layers should never get
-EBUSY in the first place if the MTD device was resumed before the UBI
device. Looks like we have a missing UBI -> MTD parenting link, which
would explain why things don't get resumed in the right order. Can you
try with the following diff applied?

---
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index f399edc82191..1981ce8f3a26 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -905,6 +905,7 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int
ubi_num, ubi->dev.release = dev_release;
        ubi->dev.class = &ubi_class;
        ubi->dev.groups = ubi_dev_groups;
+       ubi->dev.parent = &mtd->dev;
 
        ubi->mtd = mtd;
        ubi->ubi_num = ubi_num;

