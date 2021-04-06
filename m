Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F8C354E2D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbhDFH5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 03:57:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58762 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhDFH47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 03:56:59 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1367ucl6016750;
        Tue, 6 Apr 2021 02:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617695798;
        bh=h6QVKj428OEb/p1tBMm9ko3uc+VMcXY9e5qV5qAQa6E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=x0orTvTXov2CRqnKBlSs3RXp8u9VQ85VhNgHV7DuKv778x4GVv4MCRItOLD0mbFrB
         BdY7czmygXDezj2VvH+FFXJTizm5ARgnWHuk+IvFmICV8vmBuiHotf2pqGkU2IGT7T
         t7bPVwr7MX7A6zTheXzi/6WyDKGa0caxqueRM/qs=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1367ucOw022870
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Apr 2021 02:56:38 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Apr
 2021 02:56:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Apr 2021 02:56:37 -0500
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1367uZMT125228;
        Tue, 6 Apr 2021 02:56:35 -0500
Subject: Re: [PATCH 2/2] mtd: spi-nor: add initial sysfs support
To:     Michael Walle <michael@walle.cc>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
References: <20210318092406.5340-1-michael@walle.cc>
 <20210318092406.5340-3-michael@walle.cc>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <658af7ad-c4ee-1c25-b51b-1f66b657aade@ti.com>
Date:   Tue, 6 Apr 2021 13:26:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210318092406.5340-3-michael@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/18/21 2:54 PM, Michael Walle wrote:
> Add support to show the name and JEDEC identifier as well as to dump the
> SFDP table. Not all flashes list their SFDP table contents in their
> datasheet. So having that is useful. It might also be helpful in bug
> reports from users.
> 

Sorry for the delay..

There is already debugfs support for dumping JEDEC ID [1]. Any reason to
add sysfs entry as well?

That brings up another question. Since SFDP dumps are more of a debug
aid, should this be a debugfs entry rather than sysfs entry?

Note that sysfs entries are userspace ABIs just like syscalls and thus
need to be documented in Documentation/ABI/testing/ or
Documentation/ABI/stable. Thus need to be carefully designed compared to
debugfs which are much more flexible.

[1]drivers/mtd/spi-nor/core.c 3380

Regards
Vignesh

> The idea behind the sysfs module is also to have raw access to the SPI
> NOR flash device registers, which can also be useful for debugging.
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
> 
