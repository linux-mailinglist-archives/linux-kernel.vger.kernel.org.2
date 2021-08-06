Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206433E2FC6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 21:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243907AbhHFT3U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Aug 2021 15:29:20 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:51755 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243646AbhHFT3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 15:29:17 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 0E29D100003;
        Fri,  6 Aug 2021 19:28:58 +0000 (UTC)
Date:   Fri, 6 Aug 2021 21:28:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
Subject: Re: [PATCH 1/2] mtd: mtdconcat: Judge callback function existence
 getting from master for each partition
Message-ID: <20210806212857.240e0c1f@xps13>
In-Reply-To: <20210731023243.3977104-2-chengzhihao1@huawei.com>
References: <20210731023243.3977104-1-chengzhihao1@huawei.com>
        <20210731023243.3977104-2-chengzhihao1@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhihao,

Zhihao Cheng <chengzhihao1@huawei.com> wrote on Sat, 31 Jul 2021
10:32:42 +0800:

> Since commit 46b5889cc2c5("mtd: implement proper partition handling")
> applied, mtd partition device won't hold some callback functions, such
> as _block_isbad, _block_markbad, etc. Besides, function mtd_block_isbad()
> will get mtd device's master mtd device, then invokes master mtd device's
> callback function. So, following process may result mtd_block_isbad()
> always return 0, even though mtd device has bad blocks:
> 
> 1. Split a mtd device into 3 partitions: PA, PB, PC
> [ Each mtd partition device won't has callback function _block_isbad(). ]
> 2. Concatenate PA and PB as a new mtd device PN
> [ mtd_concat_create() finds out each subdev has no callback function
> _block_isbad(), so PN won't be assigned callback function
> concat_block_isbad(). ]
> Then, mtd_block_isbad() checks "!master->_block_isbad" is true, will
> always return 0.
> 
> Reproducer:
> // reproduce.c
> static int __init init_diy_module(void)
> {
> 	struct mtd_info *mtd[2];
> 	struct mtd_info *mtd_combine = NULL;
> 
> 	mtd[0] = get_mtd_device_nm("NAND simulator partition 0");
> 	if (!mtd[0]) {
> 		pr_err("cannot find mtd1\n");
> 		return -EINVAL;
> 	}
> 	mtd[1] = get_mtd_device_nm("NAND simulator partition 1");
> 	if (!mtd[1]) {
> 		pr_err("cannot find mtd2\n");
> 		return -EINVAL;
> 	}
> 
> 	put_mtd_device(mtd[0]);
> 	put_mtd_device(mtd[1]);
> 
> 	mtd_combine = mtd_concat_create(mtd, 2, "Combine mtd");
> 	if (mtd_combine == NULL) {
> 		pr_err("comnoine  fail\n");
> 		return -EINVAL;
> 	}
> 
> 	mtd_device_register(mtd_combine, NULL, 0);
> 	pr_info("Combine success\n");
> 
> 	return 0;
> }
> 
> 1. ID="0x20,0xac,0x00,0x15"
> 2. modprobe nandsim id_bytes=$ID parts=50,100 badblocks=100
> 3. insmod reproduce.ko
> 4. flash_erase /dev/mtd3 0 0
>   libmtd: error!: MEMERASE64 ioctl failed for eraseblock 100 (mtd3)
>   error 5 (Input/output error)
>   // Should be "flash_erase: Skipping bad block at 00c80000"
> 
> Fixes: 46b5889cc2c54bac ("mtd: implement proper partition handling")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  drivers/mtd/mtdconcat.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
> index 6e4d0017c0bd..ea130eeb54d5 100644
> --- a/drivers/mtd/mtdconcat.c
> +++ b/drivers/mtd/mtdconcat.c
> @@ -641,6 +641,7 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
>  	int i;
>  	size_t size;
>  	struct mtd_concat *concat;
> +	struct mtd_info *subdev_master = NULL;
>  	uint32_t max_erasesize, curr_erasesize;
>  	int num_erase_region;
>  	int max_writebufsize = 0;
> @@ -679,17 +680,19 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
>  	concat->mtd.subpage_sft = subdev[0]->subpage_sft;
>  	concat->mtd.oobsize = subdev[0]->oobsize;
>  	concat->mtd.oobavail = subdev[0]->oobavail;
> -	if (subdev[0]->_writev)
> +
> +	subdev_master = mtd_get_master(subdev[0]);
> +	if (subdev_master->_writev)
>  		concat->mtd._writev = concat_writev;
> -	if (subdev[0]->_read_oob)
> +	if (subdev_master->_read_oob)
>  		concat->mtd._read_oob = concat_read_oob;
> -	if (subdev[0]->_write_oob)
> +	if (subdev_master->_write_oob)
>  		concat->mtd._write_oob = concat_write_oob;
> -	if (subdev[0]->_block_isbad)
> +	if (subdev_master->_block_isbad)
>  		concat->mtd._block_isbad = concat_block_isbad;
> -	if (subdev[0]->_block_markbad)
> +	if (subdev_master->_block_markbad)
>  		concat->mtd._block_markbad = concat_block_markbad;
> -	if (subdev[0]->_panic_write)
> +	if (subdev_master->_panic_write)
>  		concat->mtd._panic_write = concat_panic_write;
>  
>  	concat->mtd.ecc_stats.badblocks = subdev[0]->ecc_stats.badblocks;
> @@ -721,14 +724,15 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
>  				    subdev[i]->flags & MTD_WRITEABLE;
>  		}
>  
> +		subdev_master = mtd_get_master(subdev[i]);
>  		concat->mtd.size += subdev[i]->size;
>  		concat->mtd.ecc_stats.badblocks +=
>  			subdev[i]->ecc_stats.badblocks;
>  		if (concat->mtd.writesize   !=  subdev[i]->writesize ||
>  		    concat->mtd.subpage_sft != subdev[i]->subpage_sft ||
>  		    concat->mtd.oobsize    !=  subdev[i]->oobsize ||
> -		    !concat->mtd._read_oob  != !subdev[i]->_read_oob ||
> -		    !concat->mtd._write_oob != !subdev[i]->_write_oob) {
> +		    !concat->mtd._read_oob  != !subdev_master->_read_oob ||
> +		    !concat->mtd._write_oob != !subdev_master->_write_oob) {

Do you really need this change?

>  			kfree(concat);
>  			printk("Incompatible OOB or ECC data on \"%s\"\n",
>  			       subdev[i]->name);

Thanks,
Miquèl
