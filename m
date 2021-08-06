Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF513E2FC4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 21:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbhHFT1Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Aug 2021 15:27:16 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59579 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbhHFT1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 15:27:15 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 669B360005;
        Fri,  6 Aug 2021 19:26:56 +0000 (UTC)
Date:   Fri, 6 Aug 2021 21:26:55 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
Subject: Re: [PATCH 2/2] mtd: mtdconcat: Remove concat_{read|write}_oob
Message-ID: <20210806212655.16e4d03d@xps13>
In-Reply-To: <20210731023243.3977104-3-chengzhihao1@huawei.com>
References: <20210731023243.3977104-1-chengzhihao1@huawei.com>
        <20210731023243.3977104-3-chengzhihao1@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhihao,

Richard, a question for you below :)

Zhihao Cheng <chengzhihao1@huawei.com> wrote on Sat, 31 Jul 2021
10:32:43 +0800:

> Since 2431c4f5b46c3("mtd: Implement mtd_{read,write}() as wrappers
> around mtd_{read,write}_oob()") don't allow _write|_read and
> _write_oob|_read_oob existing at the same time. We should stop these
> two callback functions assigning, otherwise following warning occurs
> while making concatenated device:
> 
>   WARNING: CPU: 2 PID: 6728 at drivers/mtd/mtdcore.c:595
>   add_mtd_device+0x7f/0x7b0
> 
> Fixes: 2431c4f5b46c3("mtd: Implement mtd_{read,write}() around ...")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  drivers/mtd/mtdconcat.c | 113 +---------------------------------------
>  1 file changed, 1 insertion(+), 112 deletions(-)
> 
> diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
> index ea130eeb54d5..98d1c79cf51d 100644
> --- a/drivers/mtd/mtdconcat.c
> +++ b/drivers/mtd/mtdconcat.c
> @@ -256,110 +256,6 @@ concat_writev(struct mtd_info *mtd, const struct kvec *vecs,
>  	return err;
>  }
>  
> -static int
> -concat_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
> -{
> -	struct mtd_concat *concat = CONCAT(mtd);
> -	struct mtd_oob_ops devops = *ops;
> -	int i, err, ret = 0;
> -
> -	ops->retlen = ops->oobretlen = 0;
> -
> -	for (i = 0; i < concat->num_subdev; i++) {
> -		struct mtd_info *subdev = concat->subdev[i];
> -
> -		if (from >= subdev->size) {
> -			from -= subdev->size;
> -			continue;
> -		}
> -
> -		/* partial read ? */
> -		if (from + devops.len > subdev->size)
> -			devops.len = subdev->size - from;
> -
> -		err = mtd_read_oob(subdev, from, &devops);
> -		ops->retlen += devops.retlen;
> -		ops->oobretlen += devops.oobretlen;
> -
> -		/* Save information about bitflips! */
> -		if (unlikely(err)) {
> -			if (mtd_is_eccerr(err)) {
> -				mtd->ecc_stats.failed++;
> -				ret = err;
> -			} else if (mtd_is_bitflip(err)) {
> -				mtd->ecc_stats.corrected++;
> -				/* Do not overwrite -EBADMSG !! */
> -				if (!ret)
> -					ret = err;
> -			} else
> -				return err;
> -		}
> -
> -		if (devops.datbuf) {
> -			devops.len = ops->len - ops->retlen;
> -			if (!devops.len)
> -				return ret;
> -			devops.datbuf += devops.retlen;
> -		}
> -		if (devops.oobbuf) {
> -			devops.ooblen = ops->ooblen - ops->oobretlen;
> -			if (!devops.ooblen)
> -				return ret;
> -			devops.oobbuf += ops->oobretlen;
> -		}
> -
> -		from = 0;
> -	}
> -	return -EINVAL;
> -}
> -
> -static int
> -concat_write_oob(struct mtd_info *mtd, loff_t to, struct mtd_oob_ops *ops)
> -{
> -	struct mtd_concat *concat = CONCAT(mtd);
> -	struct mtd_oob_ops devops = *ops;
> -	int i, err;
> -
> -	if (!(mtd->flags & MTD_WRITEABLE))
> -		return -EROFS;
> -
> -	ops->retlen = ops->oobretlen = 0;
> -
> -	for (i = 0; i < concat->num_subdev; i++) {
> -		struct mtd_info *subdev = concat->subdev[i];
> -
> -		if (to >= subdev->size) {
> -			to -= subdev->size;
> -			continue;
> -		}
> -
> -		/* partial write ? */
> -		if (to + devops.len > subdev->size)
> -			devops.len = subdev->size - to;
> -
> -		err = mtd_write_oob(subdev, to, &devops);
> -		ops->retlen += devops.retlen;
> -		ops->oobretlen += devops.oobretlen;
> -		if (err)
> -			return err;
> -
> -		if (devops.datbuf) {
> -			devops.len = ops->len - ops->retlen;
> -			if (!devops.len)
> -				return 0;
> -			devops.datbuf += devops.retlen;
> -		}
> -		if (devops.oobbuf) {
> -			devops.ooblen = ops->ooblen - ops->oobretlen;
> -			if (!devops.ooblen)
> -				return 0;
> -			devops.oobbuf += devops.oobretlen;
> -		}
> -		to = 0;
> -	}
> -	return -EINVAL;
> -}
> -
>  static int concat_erase(struct mtd_info *mtd, struct erase_info *instr)
>  {
>  	struct mtd_concat *concat = CONCAT(mtd);
> @@ -684,10 +580,6 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
>  	subdev_master = mtd_get_master(subdev[0]);
>  	if (subdev_master->_writev)
>  		concat->mtd._writev = concat_writev;
> -	if (subdev_master->_read_oob)
> -		concat->mtd._read_oob = concat_read_oob;
> -	if (subdev_master->_write_oob)
> -		concat->mtd._write_oob = concat_write_oob;

Actually I am not sure _read|write_oob() is the right callback to
remove.

Richard, what is your input on this? Shall we remove _read|write()
instead? I don't remember the exact rationale behind these two helpers.

>  	if (subdev_master->_block_isbad)
>  		concat->mtd._block_isbad = concat_block_isbad;
>  	if (subdev_master->_block_markbad)
> @@ -724,15 +616,12 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
>  				    subdev[i]->flags & MTD_WRITEABLE;
>  		}
>  
> -		subdev_master = mtd_get_master(subdev[i]);
>  		concat->mtd.size += subdev[i]->size;
>  		concat->mtd.ecc_stats.badblocks +=
>  			subdev[i]->ecc_stats.badblocks;
>  		if (concat->mtd.writesize   !=  subdev[i]->writesize ||
>  		    concat->mtd.subpage_sft != subdev[i]->subpage_sft ||
> -		    concat->mtd.oobsize    !=  subdev[i]->oobsize ||
> -		    !concat->mtd._read_oob  != !subdev_master->_read_oob ||
> -		    !concat->mtd._write_oob != !subdev_master->_write_oob) {
> +		    concat->mtd.oobsize    !=  subdev[i]->oobsize) {
>  			kfree(concat);
>  			printk("Incompatible OOB or ECC data on \"%s\"\n",
>  			       subdev[i]->name);

Thanks,
Miquèl
