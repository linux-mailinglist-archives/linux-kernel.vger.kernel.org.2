Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD6541B170
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbhI1OAr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 10:00:47 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53677 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240898AbhI1OAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:00:43 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 48A271C0008;
        Tue, 28 Sep 2021 13:59:01 +0000 (UTC)
Date:   Tue, 28 Sep 2021 15:58:59 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] mtd: add MEMREAD ioctl
Message-ID: <20210928155859.433844cb@xps13>
In-Reply-To: <20210920070221.10173-1-kernel@kempniu.pl>
References: <20210920070221.10173-1-kernel@kempniu.pl>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michał,

+ Boris just in case you have anything obvious that pops up in your
  head when reading the description, otherwise no need to thoroughfully
  review this ;)

kernel@kempniu.pl wrote on Mon, 20 Sep 2021 09:02:21 +0200:

> User-space applications making use of MTD devices via /dev/mtd*
> character devices currently have limited capabilities for reading data:
> 
>   - only deprecated methods of accessing OOB layout information exist,
> 
>   - there is no way to explicitly specify MTD operation mode to use; it
>     is auto-selected based on the MTD file mode (MTD_FILE_MODE_*) set
>     for the character device; in particular, this prevents using
>     MTD_OPS_AUTO_OOB for reads,
> 
>   - all existing user-space interfaces which cause mtd_read() or
>     mtd_read_oob() to be called (via mtdchar_read() and
>     mtdchar_read_oob(), respectively) return success even when those
>     functions return -EUCLEAN or -EBADMSG; this renders user-space
>     applications using these interfaces unaware of any corrected
>     bitflips or uncorrectable ECC errors detected during reads.
> 
> Note that the existing MEMWRITE ioctl allows the MTD operation mode to
> be explicitly set, allowing user-space applications to write page data
> and OOB data without requiring them to know anything about the OOB
> layout of the MTD device they are writing to (MTD_OPS_AUTO_OOB).  Also,
> the MEMWRITE ioctl does not mangle the return value of mtd_write_oob().
> 
> Add a new ioctl, MEMREAD, which addresses the above issues.  It is
> intended to be a read-side counterpart of the existing MEMWRITE ioctl.
> 
> Update include/uapi/mtd/mtd-abi.h accordingly.

I have to admit I am generally scared whenever something touches this
file. While I am really open to anything internally I know we need to be
careful with these additions, hence I will only merge this patch with
all other MTD maintainers acks.

On my side I am fine with the approach though.

Thanks,
Miquèl

> Signed-off-by: Michał Kępień <kernel@kempniu.pl>
> ---
> This patch is a shameless calque^W^W^Wheavily inspired by MEMWRITE code,
> so quite a lot of copy-pasting happened.  I guess it is somewhat
> expected when adding a read-side counterpart of existing code which
> takes care of writes, but please excuse me if I went too far.
> 
> Note that "scripts/checkpatch.pl --strict" returns two alignment
> warnings for this patch.  Given that existing code triggers the same
> warnings, I assumed that local consistency trumps checkpatch.pl's
> complaints.
> 
>  drivers/mtd/mtdchar.c      | 60 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/mtd/mtd-abi.h | 43 +++++++++++++++++++++++----
>  2 files changed, 98 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> index 155e991d9d75..92e0024bdcf7 100644
> --- a/drivers/mtd/mtdchar.c
> +++ b/drivers/mtd/mtdchar.c
> @@ -621,6 +621,58 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
>  	return ret;
>  }
>  
> +static int mtdchar_read_ioctl(struct mtd_info *mtd,
> +		struct mtd_read_req __user *argp)
> +{
> +	struct mtd_info *master = mtd_get_master(mtd);
> +	struct mtd_read_req req;
> +	struct mtd_oob_ops ops = {};
> +	void __user *usr_data, *usr_oob;
> +	int ret;
> +
> +	if (copy_from_user(&req, argp, sizeof(req)))
> +		return -EFAULT;
> +
> +	usr_data = (void __user *)(uintptr_t)req.usr_data;
> +	usr_oob = (void __user *)(uintptr_t)req.usr_oob;
> +
> +	if (!master->_read_oob)
> +		return -EOPNOTSUPP;
> +	ops.mode = req.mode;
> +	ops.len = (size_t)req.len;
> +	ops.ooblen = (size_t)req.ooblen;
> +	ops.ooboffs = 0;
> +
> +	if (usr_data) {
> +		ops.datbuf = kmalloc(ops.len, GFP_KERNEL);
> +		if (IS_ERR(ops.datbuf))
> +			return PTR_ERR(ops.datbuf);
> +	} else {
> +		ops.datbuf = NULL;
> +	}
> +
> +	if (usr_oob) {
> +		ops.oobbuf = kmalloc(ops.ooblen, GFP_KERNEL);
> +		if (IS_ERR(ops.oobbuf)) {
> +			kfree(ops.datbuf);
> +			return PTR_ERR(ops.oobbuf);
> +		}
> +	} else {
> +		ops.oobbuf = NULL;
> +	}
> +
> +	ret = mtd_read_oob(mtd, (loff_t)req.start, &ops);
> +
> +	if (copy_to_user(usr_data, ops.datbuf, ops.retlen) ||
> +	    copy_to_user(usr_oob, ops.oobbuf, ops.oobretlen))
> +		ret = -EFAULT;
> +
> +	kfree(ops.datbuf);
> +	kfree(ops.oobbuf);
> +
> +	return ret;
> +}
> +
>  static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
>  {
>  	struct mtd_file_info *mfi = file->private_data;
> @@ -643,6 +695,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
>  	case MEMGETINFO:
>  	case MEMREADOOB:
>  	case MEMREADOOB64:
> +	case MEMREAD:
>  	case MEMISLOCKED:
>  	case MEMGETOOBSEL:
>  	case MEMGETBADBLOCK:
> @@ -817,6 +870,13 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
>  		break;
>  	}
>  
> +	case MEMREAD:
> +	{
> +		ret = mtdchar_read_ioctl(mtd,
> +		      (struct mtd_read_req __user *)arg);
> +		break;
> +	}
> +
>  	case MEMLOCK:
>  	{
>  		struct erase_info_user einfo;
> diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
> index b869990c2db2..337e6e597fad 100644
> --- a/include/uapi/mtd/mtd-abi.h
> +++ b/include/uapi/mtd/mtd-abi.h
> @@ -55,9 +55,9 @@ struct mtd_oob_buf64 {
>   * @MTD_OPS_RAW:	data are transferred as-is, with no error correction;
>   *			this mode implies %MTD_OPS_PLACE_OOB
>   *
> - * These modes can be passed to ioctl(MEMWRITE) and are also used internally.
> - * See notes on "MTD file modes" for discussion on %MTD_OPS_RAW vs.
> - * %MTD_FILE_MODE_RAW.
> + * These modes can be passed to ioctl(MEMWRITE) and ioctl(MEMREAD); they are
> + * also used internally. See notes on "MTD file modes" for discussion on
> + * %MTD_OPS_RAW vs. %MTD_FILE_MODE_RAW.
>   */
>  enum {
>  	MTD_OPS_PLACE_OOB = 0,
> @@ -91,6 +91,32 @@ struct mtd_write_req {
>  	__u8 padding[7];
>  };
>  
> +/**
> + * struct mtd_read_req - data structure for requesting a read operation
> + *
> + * @start:	start address
> + * @len:	length of data buffer
> + * @ooblen:	length of OOB buffer
> + * @usr_data:	user-provided data buffer
> + * @usr_oob:	user-provided OOB buffer
> + * @mode:	MTD mode (see "MTD operation modes")
> + * @padding:	reserved, must be set to 0
> + *
> + * This structure supports ioctl(MEMREAD) operations, allowing data and/or OOB
> + * reads in various modes. To read from OOB-only, set @usr_data == NULL, and to
> + * read data-only, set @usr_oob == NULL. However, setting both @usr_data and
> + * @usr_oob to NULL is not allowed.
> + */
> +struct mtd_read_req {
> +	__u64 start;
> +	__u64 len;
> +	__u64 ooblen;
> +	__u64 usr_data;
> +	__u64 usr_oob;
> +	__u8 mode;
> +	__u8 padding[7];
> +};
> +
>  #define MTD_ABSENT		0
>  #define MTD_RAM			1
>  #define MTD_ROM			2
> @@ -207,6 +233,12 @@ struct otp_info {
>  #define MEMWRITE		_IOWR('M', 24, struct mtd_write_req)
>  /* Erase a given range of user data (must be in mode %MTD_FILE_MODE_OTP_USER) */
>  #define OTPERASE		_IOW('M', 25, struct otp_info)
> +/*
> + * Most generic read interface; can read in-band and/or out-of-band in various
> + * modes (see "struct mtd_read_req"). This ioctl is not supported for flashes
> + * without OOB, e.g., NOR flash.
> + */
> +#define MEMREAD			_IOWR('M', 26, struct mtd_read_req)
>  
>  /*
>   * Obsolete legacy interface. Keep it in order not to break userspace
> @@ -270,8 +302,9 @@ struct mtd_ecc_stats {
>   * Note: %MTD_FILE_MODE_RAW provides the same functionality as %MTD_OPS_RAW -
>   * raw access to the flash, without error correction or autoplacement schemes.
>   * Wherever possible, the MTD_OPS_* mode will override the MTD_FILE_MODE_* mode
> - * (e.g., when using ioctl(MEMWRITE)), but in some cases, the MTD_FILE_MODE is
> - * used out of necessity (e.g., `write()', ioctl(MEMWRITEOOB64)).
> + * (e.g., when using ioctl(MEMWRITE) or ioctl(MEMREAD)), but in some cases, the
> + * MTD_FILE_MODE is used out of necessity (e.g., `write()',
> + * ioctl(MEMWRITEOOB64)).
>   */
>  enum mtd_file_modes {
>  	MTD_FILE_MODE_NORMAL = MTD_OTP_OFF,

