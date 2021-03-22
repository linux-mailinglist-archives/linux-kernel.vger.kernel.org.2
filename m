Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46513447A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhCVOoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:44:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37758 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhCVOoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:44:00 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12MEhmt1015180;
        Mon, 22 Mar 2021 09:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616424228;
        bh=WJL8DAAbzAlsFa5GLWTVFiPVxPG+FuITJus6PMJQUpM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Uoc8iS1nUOm9YioVY3+/k1OGyDhP8hLCLFh/wykFqtT/639CgjI/ITd2xgo3muAnS
         AcW6bYTXZ4vlNv4bJ8VZXP3suV/wKfrmkvS9dyFLEM2qgp1maesjVSL4WRl2oj9gvI
         pdsJ86mSzVGuxAEXKsmptlczDIWUKo1EIVU3uuzQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12MEhm2s058620
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Mar 2021 09:43:48 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 22
 Mar 2021 09:43:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 22 Mar 2021 09:43:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12MEhlu4019810;
        Mon, 22 Mar 2021 09:43:47 -0500
Date:   Mon, 22 Mar 2021 20:13:46 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 2/2] mtd: spi-nor: add initial sysfs support
Message-ID: <20210322144344.4hys4zs57hnsjyjy@ti.com>
References: <20210318092406.5340-1-michael@walle.cc>
 <20210318092406.5340-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210318092406.5340-3-michael@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

I have not worked with sysfs much so only giving this patch a quick 
overview.

On 18/03/21 10:24AM, Michael Walle wrote:
> Add support to show the name and JEDEC identifier as well as to dump the
> SFDP table. Not all flashes list their SFDP table contents in their
> datasheet. So having that is useful. It might also be helpful in bug
> reports from users.
> 
> The idea behind the sysfs module is also to have raw access to the SPI
> NOR flash device registers, which can also be useful for debugging.

Your current patch does not add this feature. Why do you think it is 
important enough to mention it?

> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/Makefile |  2 +-
>  drivers/mtd/spi-nor/core.c   |  5 +++
>  drivers/mtd/spi-nor/core.h   |  3 ++
>  drivers/mtd/spi-nor/sysfs.c  | 86 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 95 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/spi-nor/sysfs.c
> 
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index 653923896205..aff308f75987 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -spi-nor-objs			:= core.o sfdp.o
> +spi-nor-objs			:= core.o sfdp.o sysfs.o
>  spi-nor-objs			+= atmel.o
>  spi-nor-objs			+= catalyst.o
>  spi-nor-objs			+= eon.o
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 4a315cb1c4db..2eaf4ba8c0f3 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3707,6 +3707,10 @@ static int spi_nor_probe(struct spi_mem *spimem)
>  	if (ret)
>  		return ret;
>  
> +	ret = spi_nor_sysfs_create(nor);
> +	if (ret)
> +		return ret;
> +
>  	return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
>  				   data ? data->nr_parts : 0);
>  }
> @@ -3716,6 +3720,7 @@ static int spi_nor_remove(struct spi_mem *spimem)
>  	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
>  
>  	spi_nor_restore(nor);
> +	spi_nor_sysfs_remove(nor);
>  
>  	/* Clean up MTD stuff. */
>  	return mtd_device_unregister(&nor->mtd);
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 668f22011b1d..dd592f7b62d1 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -488,4 +488,7 @@ static struct spi_nor __maybe_unused *mtd_to_spi_nor(struct mtd_info *mtd)
>  	return mtd->priv;
>  }
>  
> +int spi_nor_sysfs_create(struct spi_nor *nor);
> +void spi_nor_sysfs_remove(struct spi_nor *nor);
> +
>  #endif /* __LINUX_MTD_SPI_NOR_INTERNAL_H */
> diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
> new file mode 100644
> index 000000000000..0de031e246c5
> --- /dev/null
> +++ b/drivers/mtd/spi-nor/sysfs.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/mtd/spi-nor.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
> +#include <linux/sysfs.h>
> +
> +#include "core.h"
> +
> +static ssize_t name_show(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct spi_mem *spimem = spi_get_drvdata(spi);
> +	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
> +
> +	return sprintf(buf, "%s\n", nor->info->name);
> +}
> +static DEVICE_ATTR_RO(name);
> +
> +static ssize_t jedec_id_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct spi_mem *spimem = spi_get_drvdata(spi);
> +	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
> +
> +	return sprintf(buf, "%*phN\n", nor->info->id_len, nor->info->id);
> +}
> +static DEVICE_ATTR_RO(jedec_id);
> +
> +static struct attribute *spi_nor_sysfs_entries[] = {
> +	&dev_attr_name.attr,
> +	&dev_attr_jedec_id.attr,
> +	NULL
> +};
> +
> +static ssize_t sfdp_read(struct file *filp, struct kobject *kobj,
> +			 struct bin_attribute *bin_attr, char *buf,
> +			 loff_t off, size_t count)
> +{
> +	struct spi_device *spi = to_spi_device(kobj_to_dev(kobj));
> +	struct spi_mem *spimem = spi_get_drvdata(spi);
> +	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
> +	struct sfdp *sfdp = nor->sfdp;
> +	size_t sfdp_size = sfdp->num_dwords * sizeof(*sfdp->dwords);

Is a NULL check needed here? If the flash does not have a SFDP table 
nor->sfdp will be NULL.

> +
> +	return memory_read_from_buffer(buf, count, &off, nor->sfdp->dwords,
> +				       sfdp_size);
> +}
> +static BIN_ATTR_RO(sfdp, PAGE_SIZE);
> +
> +static struct bin_attribute *spi_nor_sysfs_bin_entries[] = {
> +	&bin_attr_sfdp,
> +	NULL
> +};
> +
> +static umode_t spi_nor_sysfs_is_bin_visible(struct kobject *kobj,
> +					    struct bin_attribute *attr, int n)
> +{
> +	struct spi_device *spi = to_spi_device(kobj_to_dev(kobj));
> +	struct spi_mem *spimem = spi_get_drvdata(spi);
> +	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
> +
> +	if (attr == &bin_attr_sfdp && nor->sfdp)
> +		return 0444;
> +
> +	return 0;
> +}
> +
> +static struct attribute_group spi_nor_sysfs_attr_group = {
> +	.name		= NULL,
> +	.is_bin_visible	= spi_nor_sysfs_is_bin_visible,
> +	.attrs		= spi_nor_sysfs_entries,
> +	.bin_attrs	= spi_nor_sysfs_bin_entries,
> +};
> +
> +int spi_nor_sysfs_create(struct spi_nor *nor)
> +{
> +	return sysfs_create_group(&nor->dev->kobj, &spi_nor_sysfs_attr_group);
> +}
> +
> +void spi_nor_sysfs_remove(struct spi_nor *nor)
> +{
> +	sysfs_remove_group(&nor->dev->kobj, &spi_nor_sysfs_attr_group);
> +}
> -- 
> 2.20.1
> 

Rest of it looks good to me.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
