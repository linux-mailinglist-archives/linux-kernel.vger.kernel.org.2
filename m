Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8188F31B716
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 11:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhBOKZ7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 Feb 2021 05:25:59 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37407 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhBOKZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 05:25:00 -0500
X-Originating-IP: 92.184.108.178
Received: from xps13 (pop.92-184-108-178.mobile.abo.orange.fr [92.184.108.178])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1DB981BF208;
        Mon, 15 Feb 2021 10:24:11 +0000 (UTC)
Date:   Mon, 15 Feb 2021 11:24:09 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spinand: add support for Foresee FS35ND01G-S1Y2
Message-ID: <20210215112409.1a755bf0@xps13>
In-Reply-To: <20210213095724.3411058-1-daniel@0x0f.com>
References: <20210213095724.3411058-1-daniel@0x0f.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Palmer <daniel@0x0f.com> wrote on Sat, 13 Feb 2021 18:57:24
+0900:

> Add support for the Foresee FS35ND01G-S1Y2 manufactured by Longsys.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> 
> Link: https://datasheet.lcsc.com/szlcsc/2008121142_FORESEE-FS35ND01G-S1Y2QWFI000_C719495.pdf
> ---

Can you please add a changelog here when you send a new version of a
patch?

>  drivers/mtd/nand/spi/Makefile  |  2 +-
>  drivers/mtd/nand/spi/core.c    |  1 +
>  drivers/mtd/nand/spi/longsys.c | 86 ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h    |  1 +
>  4 files changed, 89 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/nand/spi/longsys.c
> 
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 9662b9c1d5a9..1d6819022e43 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
> +spinand-objs := core.o gigadevice.o longsys.o macronix.o micron.o paragon.o toshiba.o winbond.o
>  obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 61d932c1b718..8c36f0f6b1c9 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -864,6 +864,7 @@ static const struct nand_ops spinand_ops = {
>  
>  static const struct spinand_manufacturer *spinand_manufacturers[] = {
>  	&gigadevice_spinand_manufacturer,
> +	&longsys_spinand_manufacturer,
>  	&macronix_spinand_manufacturer,
>  	&micron_spinand_manufacturer,
>  	&paragon_spinand_manufacturer,
> diff --git a/drivers/mtd/nand/spi/longsys.c b/drivers/mtd/nand/spi/longsys.c
> new file mode 100644
> index 000000000000..418bd5a1f20d
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/longsys.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 Daniel Palmer <daniel@thingy.jp>
> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_LONGSYS		0xCD
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +
> +static int fs35nd01g_s1y2_ooblayout_ecc(struct mtd_info *mtd, int section,
> +					struct mtd_oob_region *region)
> +{
> +	if (section > 3)
> +		return -ERANGE;
> +
> +	/* ECC is not user accessible */
> +	region->offset = 0;
> +	region->length = 0;
> +
> +	return 0;
> +}
> +
> +static int fs35nd01g_s1y2_ooblayout_free(struct mtd_info *mtd, int section,
> +				    struct mtd_oob_region *region)
> +{
> +	if (section > 3)
> +		return -ERANGE;
> +
> +	/*
> +	 * No ECC data is stored in the accessible OOB so the full 16 bytes
> +	 * of each spare region is available to the user. Apparently also
> +	 * covered by the internal ECC.

How is this even possible? ECC must be stored somewhere, maybe it is
not possible to retrieve it but I guess you cannot use the 32 bytes of
OOB for user data. Can you please verify that?

> +	 */
> +	if (section) {
> +		region->offset = 16 * section;
> +		region->length = 16;
> +	} else {
> +		/* First byte in spare0 area is used for bad block marker */
> +		region->offset = 1;
> +		region->length = 15;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops fs35nd01g_s1y2_ooblayout = {
> +	.ecc = fs35nd01g_s1y2_ooblayout_ecc,
> +	.free = fs35nd01g_s1y2_ooblayout_free,
> +};
> +
> +static const struct spinand_info longsys_spinand_table[] = {
> +	SPINAND_INFO("FS35ND01G-S1Y2",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xEA, 0x11),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(4, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&fs35nd01g_s1y2_ooblayout,
> +				     NULL)),
> +};
> +
> +static const struct spinand_manufacturer_ops longsys_spinand_manuf_ops = {
> +};
> +
> +const struct spinand_manufacturer longsys_spinand_manufacturer = {
> +	.id = SPINAND_MFR_LONGSYS,
> +	.name = "Longsys",
> +	.chips = longsys_spinand_table,
> +	.nchips = ARRAY_SIZE(longsys_spinand_table),
> +	.ops = &longsys_spinand_manuf_ops,
> +};
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 6bb92f26833e..8651e63a2f8a 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -239,6 +239,7 @@ struct spinand_manufacturer {
>  
>  /* SPI NAND manufacturers */
>  extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
> +extern const struct spinand_manufacturer longsys_spinand_manufacturer;
>  extern const struct spinand_manufacturer macronix_spinand_manufacturer;
>  extern const struct spinand_manufacturer micron_spinand_manufacturer;
>  extern const struct spinand_manufacturer paragon_spinand_manufacturer;

Thanks,
Miquèl
