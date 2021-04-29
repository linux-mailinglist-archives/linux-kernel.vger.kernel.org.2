Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012E636ED82
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbhD2Pjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhD2Pju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:39:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DFDC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:39:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l17-20020a25ad510000b02904ee2dd236d5so10116353ybe.18
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xC3KmY9xAqwoVwsFDm4WXfd4THuTAizTawn6IKvDgFU=;
        b=N0GXApwTiwBnsTEHsxkhgW5osS2p2oNCf0cDSCUhCQOqGYZdaMUFoO8QuCsvVaxrBj
         OYL8XeShTQR2Om4Fr+8v4AjqUd5AOc5tzdG3y7IKvVDyTOWNwcZWVVcMT1GKlrQzW+2O
         KzBLpl2ECnPPMW9uNkFMmPmuSjKD94OsHg/yiowdywrwCmKrMiPIkfBCfc+30vA0AbKO
         lPYQOjJY23z2Z2y+Ssnk8NfoCXVxRptjp3MnjiAHgbv9zZ0SvkpF1tk97stcQ+2OKYSZ
         IK+6qGTb74FbWocm2eyWrEYyGB7Pl7UdHPnxpCQsb+KeQbjwoQS3yshEKs43zO6ZCDyX
         EawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xC3KmY9xAqwoVwsFDm4WXfd4THuTAizTawn6IKvDgFU=;
        b=ced/sdS4Ds6ckB6fJYf+1e1mo3Zcy/XS+l+Cop7ho8gPYQYbZY2axcpP07vH20VNNG
         Ez8gb27SUGf2OrlP5K5TVAChz+jF8ysjQ+QzNc6Y2OLfI6dIv/wcHoS6H+8NCmax/eGg
         +PYf0wjfdGG7AwIt3XTz9Fg9HDn7mSblcWs85WrzD/Df0RaSF9tMrXuyyl39KJdkghUv
         QiDX8dL/E2FI3rBQrlRzKJazDMdnJNPVfq1JeP3bhLe+5HVqNqtm1sia2WVZT/wxTD28
         m9rkp0KTp5H24ymJlaBZ9Bo9h4xCB2IP7AXsAhjtvoCpTWSAd3RvM2x7O+8kCIYXNrkp
         opzQ==
X-Gm-Message-State: AOAM532TxjwPTSo8mldnxl5/69R5uEfKnPKW5LpAbOqPxf/BqiNcLvn1
        4fumHiKRpybMJQdOjjWnHVUBo8v2bg==
X-Google-Smtp-Source: ABdhPJw8uCV+h3myux52+v9N6YFEXe/P/hczAhYH5IttRWYlc7BUcBirw8eoSB00nHMwQueL14wRbk8opQ==
X-Received: from peanut.svl.corp.google.com ([2620:15c:2c5:1:544d:6c9a:2020:fc52])
 (user=awill job=sendgmr) by 2002:a25:6fc5:: with SMTP id k188mr121216ybc.109.1619710743354;
 Thu, 29 Apr 2021 08:39:03 -0700 (PDT)
Date:   Thu, 29 Apr 2021 08:37:26 -0700
In-Reply-To: <20210318092406.5340-3-michael@walle.cc>
Message-Id: <20210429153725.15970-1-awill@google.com>
Mime-Version: 1.0
References: <20210318092406.5340-3-michael@walle.cc>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: Re: [PATCH 2/2] mtd: spi-nor: add initial sysfs support
From:   Alexander Williams <awill@google.com>
To:     michael@walle.cc
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, p.yadav@ti.com, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com,
        Alexander Williams <awill@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> On Thu, Mar 18, 2021 at 10:24 AM Michael Walle <michael@walle.cc>
> wrote:
> Add support to show the name and JEDEC identifier as well as to dump the
> SFDP table. Not all flashes list their SFDP table contents in their
> datasheet. So having that is useful. It might also be helpful in bug
> reports from users.
> 
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

This appears to be racing with user space. By the time we reach probe(), the
device embedded in the spi_device has already been registered, with the uevent
sent out, right? udev may not see the new attributes created here.

Since we reuse a preexisting device throughout spi-nor, it seems awfully
challenging to be able to safely add sysfs attributes. Would it make sense to
create a spi-nor-specific device/class? Or perhaps attach these attributes to
the device in mtd_info like I've done in
https://lore.kernel.org/linux-mtd/20210428052725.530939-1-awill@google.com/ ?

- Alex

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
> -- 
> 2.20.1
