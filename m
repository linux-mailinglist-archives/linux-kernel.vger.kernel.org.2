Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE3141B22E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbhI1OhE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 10:37:04 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:53551 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241249AbhI1OhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:37:03 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 553FE100012;
        Tue, 28 Sep 2021 14:35:20 +0000 (UTC)
Date:   Tue, 28 Sep 2021 16:35:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] mtd: add MEMREAD ioctl
Message-ID: <20210928163519.08cd1138@xps13>
In-Reply-To: <20210928162402.6bb64fcf@collabora.com>
References: <20210920070221.10173-1-kernel@kempniu.pl>
        <20210928155859.433844cb@xps13>
        <20210928162402.6bb64fcf@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

boris.brezillon@collabora.com wrote on Tue, 28 Sep 2021 16:24:02 +0200:

> Hi Miquel, Michal,
> 
> On Tue, 28 Sep 2021 15:58:59 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Hi Michał,
> > 
> > + Boris just in case you have anything obvious that pops up in your
> >   head when reading the description, otherwise no need to thoroughfully
> >   review this ;)  
> 
> Couple of comment below.
> 
> 
> > > Signed-off-by: Michał Kępień <kernel@kempniu.pl>
> > > ---
> > > This patch is a shameless calque^W^W^Wheavily inspired by MEMWRITE code,
> > > so quite a lot of copy-pasting happened.  I guess it is somewhat
> > > expected when adding a read-side counterpart of existing code which
> > > takes care of writes, but please excuse me if I went too far.
> > > 
> > > Note that "scripts/checkpatch.pl --strict" returns two alignment
> > > warnings for this patch.  Given that existing code triggers the same
> > > warnings, I assumed that local consistency trumps checkpatch.pl's
> > > complaints.
> > > 
> > >  drivers/mtd/mtdchar.c      | 60 ++++++++++++++++++++++++++++++++++++++
> > >  include/uapi/mtd/mtd-abi.h | 43 +++++++++++++++++++++++----
> > >  2 files changed, 98 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> > > index 155e991d9d75..92e0024bdcf7 100644
> > > --- a/drivers/mtd/mtdchar.c
> > > +++ b/drivers/mtd/mtdchar.c
> > > @@ -621,6 +621,58 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
> > >  	return ret;
> > >  }
> > >  
> > > +static int mtdchar_read_ioctl(struct mtd_info *mtd,
> > > +		struct mtd_read_req __user *argp)
> > > +{
> > > +	struct mtd_info *master = mtd_get_master(mtd);
> > > +	struct mtd_read_req req;
> > > +	struct mtd_oob_ops ops = {};
> > > +	void __user *usr_data, *usr_oob;
> > > +	int ret;
> > > +
> > > +	if (copy_from_user(&req, argp, sizeof(req)))
> > > +		return -EFAULT;
> > > +
> > > +	usr_data = (void __user *)(uintptr_t)req.usr_data;
> > > +	usr_oob = (void __user *)(uintptr_t)req.usr_oob;
> > > +
> > > +	if (!master->_read_oob)
> > > +		return -EOPNOTSUPP;
> > > +	ops.mode = req.mode;
> > > +	ops.len = (size_t)req.len;
> > > +	ops.ooblen = (size_t)req.ooblen;
> > > +	ops.ooboffs = 0;
> > > +
> > > +	if (usr_data) {
> > > +		ops.datbuf = kmalloc(ops.len, GFP_KERNEL);  
> 
> Hm, I know the write path does that, but I'm really not sure
> kmalloc()-ing a buffer of the requested read length is a good
> idea. Having a loop doing reads with an erasesize granularity would
> avoid this unbounded allocation while keeping performance acceptable in
> most cases.

Right.

> 
> > > +		if (IS_ERR(ops.datbuf))
> > > +			return PTR_ERR(ops.datbuf);
> > > +	} else {
> > > +		ops.datbuf = NULL;
> > > +	}
> > > +
> > > +	if (usr_oob) {
> > > +		ops.oobbuf = kmalloc(ops.ooblen, GFP_KERNEL);
> > > +		if (IS_ERR(ops.oobbuf)) {
> > > +			kfree(ops.datbuf);
> > > +			return PTR_ERR(ops.oobbuf);
> > > +		}
> > > +	} else {
> > > +		ops.oobbuf = NULL;
> > > +	}
> > > +
> > > +	ret = mtd_read_oob(mtd, (loff_t)req.start, &ops);
> > > +
> > > +	if (copy_to_user(usr_data, ops.datbuf, ops.retlen) ||
> > > +	    copy_to_user(usr_oob, ops.oobbuf, ops.oobretlen))
> > > +		ret = -EFAULT;
> > > +
> > > +	kfree(ops.datbuf);
> > > +	kfree(ops.oobbuf);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
> > >  {
> > >  	struct mtd_file_info *mfi = file->private_data;
> > > @@ -643,6 +695,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
> > >  	case MEMGETINFO:
> > >  	case MEMREADOOB:
> > >  	case MEMREADOOB64:
> > > +	case MEMREAD:
> > >  	case MEMISLOCKED:
> > >  	case MEMGETOOBSEL:
> > >  	case MEMGETBADBLOCK:
> > > @@ -817,6 +870,13 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
> > >  		break;
> > >  	}
> > >  
> > > +	case MEMREAD:
> > > +	{
> > > +		ret = mtdchar_read_ioctl(mtd,
> > > +		      (struct mtd_read_req __user *)arg);
> > > +		break;
> > > +	}
> > > +
> > >  	case MEMLOCK:
> > >  	{
> > >  		struct erase_info_user einfo;
> > > diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
> > > index b869990c2db2..337e6e597fad 100644
> > > --- a/include/uapi/mtd/mtd-abi.h
> > > +++ b/include/uapi/mtd/mtd-abi.h
> > > @@ -55,9 +55,9 @@ struct mtd_oob_buf64 {
> > >   * @MTD_OPS_RAW:	data are transferred as-is, with no error correction;
> > >   *			this mode implies %MTD_OPS_PLACE_OOB
> > >   *
> > > - * These modes can be passed to ioctl(MEMWRITE) and are also used internally.
> > > - * See notes on "MTD file modes" for discussion on %MTD_OPS_RAW vs.
> > > - * %MTD_FILE_MODE_RAW.
> > > + * These modes can be passed to ioctl(MEMWRITE) and ioctl(MEMREAD); they are
> > > + * also used internally. See notes on "MTD file modes" for discussion on
> > > + * %MTD_OPS_RAW vs. %MTD_FILE_MODE_RAW.
> > >   */
> > >  enum {
> > >  	MTD_OPS_PLACE_OOB = 0,
> > > @@ -91,6 +91,32 @@ struct mtd_write_req {
> > >  	__u8 padding[7];
> > >  };
> > >  
> > > +/**
> > > + * struct mtd_read_req - data structure for requesting a read operation
> > > + *
> > > + * @start:	start address
> > > + * @len:	length of data buffer
> > > + * @ooblen:	length of OOB buffer
> > > + * @usr_data:	user-provided data buffer
> > > + * @usr_oob:	user-provided OOB buffer
> > > + * @mode:	MTD mode (see "MTD operation modes")
> > > + * @padding:	reserved, must be set to 0
> > > + *
> > > + * This structure supports ioctl(MEMREAD) operations, allowing data and/or OOB
> > > + * reads in various modes. To read from OOB-only, set @usr_data == NULL, and to
> > > + * read data-only, set @usr_oob == NULL. However, setting both @usr_data and
> > > + * @usr_oob to NULL is not allowed.
> > > + */
> > > +struct mtd_read_req {
> > > +	__u64 start;
> > > +	__u64 len;
> > > +	__u64 ooblen;
> > > +	__u64 usr_data;
> > > +	__u64 usr_oob;
> > > +	__u8 mode;
> > > +	__u8 padding[7];
> > > +};  
> 
> I do agree that a new interface is needed, but if we're adding a new
> entry point, let's make sure it covers all possible use cases we have
> now. At the very least, I think we're missing info about the maximum
> number of corrected bits per ECC region on the portion being read.
> Propagating EUCLEAN errors is nice, but it's not precise enough IMHO.
> 
> I remember discussing search a new READ ioctl with Sascha Hauer a few
> years back, but I can't find the discussion...

We also discussed a mtd_io_op some time ago, which would equivalently
replace mtd_oob_ops at some point, including more information such as
the bitflips which happened on every chunk instead of the information
regarding the maximum number of bitflips in one of the chunks only.
IIRC the point was to get rid of the mtd_{read,write}{,_oob} hooks and
structures in favor of a more robust and complete set of operations.

