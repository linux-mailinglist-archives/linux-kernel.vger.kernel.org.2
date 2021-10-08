Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332EB426D8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242937AbhJHPhk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Oct 2021 11:37:40 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:20683 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhJHPhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:37:38 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id A38AF24000B;
        Fri,  8 Oct 2021 15:35:27 +0000 (UTC)
Date:   Fri, 8 Oct 2021 17:35:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mtd: core: protect access to mtd devices while
 in suspend
Message-ID: <20211008173526.19745a10@xps13>
In-Reply-To: <20211008143825.3717116-1-sean@geanix.com>
References: <20211008141524.20ca8219@collabora.com>
        <20211008143825.3717116-1-sean@geanix.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

sean@geanix.com wrote on Fri,  8 Oct 2021 16:38:24 +0200:

> This will prevent reading/writing/erasing to a suspended mtd device.
> It will force mtd_write()/mtd_read()/mtd_erase() to wait for
> mtd_resume() to unlock access to mtd devices.

Maybe you can use the present tense, as in:
Prevent reading/...

s/mtd/MTD/

Force mtd_write/...

I would suggest something like:

	Prevent accessing the devices while in a suspended state. Also
	prevent suspending a device which is still currently in use.


> Exec_op[0] speed things up, so we see this race when rawnand devices going

I believe you can quote the commit inline, like below (please use the
12-digit hash below as well).

I am not sure ->exec_op() is to be blamed here, maybe this change
revealed the issue but I doubt it is because of its efficiency. The
problem was just laying silently IMHO.

> into suspend. But it's actually "mtd: rawnand: Simplify the locking" that
> allows it to return errors rather than locking, before that commit it would
> have waited for the rawnand device to resume.

I don't think so, I believe it was broken in the same way but was just
not returning errors.
> 
> Tested on a iMX6ULL.
> 
> [0]:
> ef347c0cfd61 ("mtd: rawnand: gpmi: Implement exec_op")
> 

	Suggested-by: Boris... 

would be nice.


> Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> 
> Hope I got it all :)
> 
>  drivers/mtd/mtdcore.c   | 57 ++++++++++++++++++++++++++++++++++++++++-
>  include/linux/mtd/mtd.h | 36 ++++++++++++++++++--------
>  2 files changed, 81 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index c8fd7f758938..3c93202e6cbb 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -36,6 +36,44 @@
>  
>  struct backing_dev_info *mtd_bdi;
>  
> +static void mtd_start_access(struct mtd_info *mtd)
> +{
> +	struct mtd_info *master = mtd_get_master(mtd);
> +
> +	/*
> +	 * Don't take the suspend_lock on devices that don't
> +	 * implement the suspend hook. Otherwise, lockdep will
> +	 * complain about nested locks when trying to suspend MTD
> +	 * partitions or MTD devices created by gluebi which are
> +	 * backed by real devices.
> +	 */
> +	if (!master->_suspend)
> +		return;
> +
> +	/*
> +	 * Wait until the device is resumed. Should we have a
> +	 * non-blocking mode here?
> +	 */
> +	while (1) {
> +		down_read(&master->master.suspend_lock);
> +		if (!master->master.suspended)
> +			return;
> +
> +		up_read(&master->master.suspend_lock);
> +		wait_event(master->master.resume_wq, master->master.suspended == 0);

"var == 0" translates well to "!var"

> +	}
> +}
> +
> +static void mtd_end_access(struct mtd_info *mtd)
> +{
> +	struct mtd_info *master = mtd_get_master(mtd);
> +
> +	if (!master->_suspend)
> +		return;
> +
> +	up_read(&master->master.suspend_lock);
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  
>  static int mtd_cls_suspend(struct device *dev)
> @@ -1000,6 +1038,9 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
>  
>  	ret = mtd_otp_nvmem_add(mtd);
>  
> +	init_waitqueue_head(&mtd->master.resume_wq);
> +	init_rwsem(&mtd->master.suspend_lock);

what about setting this in mtd_set_dev_defaults()?

> +
>  out:
>  	if (ret && device_is_registered(&mtd->dev))
>  		del_mtd_device(mtd);
> @@ -1241,6 +1282,8 @@ int mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
>  	struct erase_info adjinstr;
>  	int ret;
>  
> +	mtd_start_access(mtd);

I believe we should cover all the ioctls, even if they are not
accessing the device. I don't think it's a problem to stop
interacting when the devices are suspended?

> +
>  	instr->fail_addr = MTD_FAIL_ADDR_UNKNOWN;
>  	adjinstr = *instr;
>  
> @@ -1278,6 +1321,8 @@ int mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
>  		}
>  	}
>  
> +	mtd_end_access(mtd);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(mtd_erase);
> @@ -1558,6 +1603,8 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
>  	struct mtd_ecc_stats old_stats = master->ecc_stats;
>  	int ret_code;
>  
> +	mtd_start_access(mtd);
> +
>  	ops->retlen = ops->oobretlen = 0;
>  
>  	ret_code = mtd_check_oob_ops(mtd, from, ops);
> @@ -1577,6 +1624,8 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
>  
>  	mtd_update_ecc_stats(mtd, master, &old_stats);
>  
> +	mtd_end_access(mtd);
> +
>  	/*
>  	 * In cases where ops->datbuf != NULL, mtd->_read_oob() has semantics
>  	 * similar to mtd->_read(), returning a non-negative integer
> @@ -1597,6 +1646,8 @@ int mtd_write_oob(struct mtd_info *mtd, loff_t to,
>  	struct mtd_info *master = mtd_get_master(mtd);
>  	int ret;
>  
> +	mtd_start_access(mtd);
> +
>  	ops->retlen = ops->oobretlen = 0;
>  
>  	if (!(mtd->flags & MTD_WRITEABLE))
> @@ -1615,7 +1666,11 @@ int mtd_write_oob(struct mtd_info *mtd, loff_t to,
>  	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
>  		return mtd_io_emulated_slc(mtd, to, false, ops);
>  
> -	return mtd_write_oob_std(mtd, to, ops);
> +	ret = mtd_write_oob_std(mtd, to, ops);
> +
> +	mtd_end_access(mtd);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(mtd_write_oob);
>  
> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index 88227044fc86..cfab07b02dc9 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -231,6 +231,8 @@ struct mtd_master {
>  	struct mutex partitions_lock;
>  	struct mutex chrdev_lock;
>  	unsigned int suspended : 1;
> +	wait_queue_head_t resume_wq;
> +	struct rw_semaphore suspend_lock;
>  };
>  
>  struct mtd_info {
> @@ -546,30 +548,42 @@ int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs);
>  static inline int mtd_suspend(struct mtd_info *mtd)
>  {
>  	struct mtd_info *master = mtd_get_master(mtd);
> -	int ret;
> +	int ret = 0;
>  
> -	if (master->master.suspended)
> -		return 0;
>  
> -	ret = master->_suspend ? master->_suspend(master) : 0;
> -	if (ret)
> +	if (!master->_suspend)
>  		return ret;
>  
> -	master->master.suspended = 1;
> -	return 0;
> +	down_write(&master->master.suspend_lock);
> +	if (!master->master.suspended) {
> +		ret = master->_suspend(master);
> +		if (!ret)
> +			master->master.suspended = 1;
> +	}
> +	up_write(&master->master.suspend_lock);
> +
> +	return ret;
>  }
>  
>  static inline void mtd_resume(struct mtd_info *mtd)
>  {
>  	struct mtd_info *master = mtd_get_master(mtd);
>  
> -	if (!master->master.suspended)
> +	if (!master->_suspend)
>  		return;
>  
> -	if (master->_resume)
> -		master->_resume(master);
>  
> -	master->master.suspended = 0;
> +	down_write(&master->master.suspend_lock);
> +	if (master->master.suspended) {
> +		if (master->_resume)
> +			master->_resume(master);
> +
> +		master->master.suspended = 0;
> +
> +		/* The MTD dev has been resumed, wake up all waiters. */
> +		wake_up_all(&master->master.resume_wq);
> +	}
> +	up_write(&master->master.suspend_lock);
>  }
>  
>  static inline uint32_t mtd_div_by_eb(uint64_t sz, struct mtd_info *mtd)

The other patch lgtm.

Thanks,
Miquèl
