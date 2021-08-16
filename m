Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8804B3ED008
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 10:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhHPIMU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Aug 2021 04:12:20 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:58083 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhHPIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:12:18 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 8EFE0100004;
        Mon, 16 Aug 2021 08:11:44 +0000 (UTC)
Date:   Mon, 16 Aug 2021 10:11:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-mtd@lists.infradead.org, richard@nod.at,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] mtd: spinand: add support for Foresee FS35ND0*G
 parts
Message-ID: <20210816101143.2a64d7b9@xps13>
In-Reply-To: <20210811084924.52293-1-daniel@0x0f.com>
References: <20210811084924.52293-1-daniel@0x0f.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Palmer <daniel@0x0f.com> wrote on Wed, 11 Aug 2021 17:49:24
+0900:

> Add support for the various Foresee FS35ND0*G parts manufactured by Longsys.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> 
> Link: https://datasheet.lcsc.com/szlcsc/2008121142_FORESEE-FS35ND01G-S1Y2QWFI000_C719495.pdf
> ---
>  Changes since v2:
>  - Originally I only had the 1Gbit version of this chip, now I have the 2Gbit and 4Gbit
>    variations so I've added support for those too. There is no datasheet for the bigger
>    chips but they are documented in a flashing tool from an SoC vendor so I took the parameters
>    from there.
>  - Previous versions of this patch only had single io read cache variants. My SPI flash driver
>    now supports dual and quad io for reading so I added and tested those modes too.
>    My driver/hardware only supports single io for writing so those are still left out.
>  - Implemented proper logic for checking the ECC status.
>  - Combined with the previous patch for 1-filling the OOB in the page buffer before writing
>    I have been using this for a few months now without anything getting broken.
>  
>  drivers/mtd/nand/spi/Makefile  |   2 +-
>  drivers/mtd/nand/spi/core.c    |   1 +
>  drivers/mtd/nand/spi/longsys.c | 134 +++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h    |   1 +
>  4 files changed, 137 insertions(+), 1 deletion(-)
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
> index 446ba8d43fbc..48f635d5c1ff 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -895,6 +895,7 @@ static const struct nand_ops spinand_ops = {
>  
>  static const struct spinand_manufacturer *spinand_manufacturers[] = {
>  	&gigadevice_spinand_manufacturer,
> +	&longsys_spinand_manufacturer,
>  	&macronix_spinand_manufacturer,
>  	&micron_spinand_manufacturer,
>  	&paragon_spinand_manufacturer,
> diff --git a/drivers/mtd/nand/spi/longsys.c b/drivers/mtd/nand/spi/longsys.c
> new file mode 100644
> index 000000000000..ee38f8728262
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/longsys.c
> @@ -0,0 +1,134 @@
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
> +#define SPINAND_MFR_LONGSYS			0xCD
> +#define FS35ND01G_S1Y2_STATUS_ECC_0_3_BITFLIPS	(0 << 4)
> +#define FS35ND01G_S1Y2_STATUS_ECC_4_BITFLIPS	(1 << 4)
> +#define FS35ND01G_S1Y2_STATUS_ECC_UNCORRECTABLE	(2 << 4)
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
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

Can't you just return -ERANGE directly? (maybe not).
If you can't then just return -ERANGE on if (section), no need for two
additional calls.

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
> +	 */
> +	if (section) {
> +		region->offset = 16 * section;
> +		region->length = 16;
> +	} else {
> +		/* First byte in spare0 area is used for bad block marker */
> +		region->offset = 1;

So far we reserved two bytes for BBM while we know for now we only use
one.

> +		region->length = 15;
> +	}

You can just return

	if (section)
		return -ERANGE;

	offset = 2;
	length = (4 * 16) - offset;

	return 0;


> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops fs35nd01g_s1y2_ooblayout = {
> +	.ecc = fs35nd01g_s1y2_ooblayout_ecc,
> +	.free = fs35nd01g_s1y2_ooblayout_free,
> +};
> +
> +static int fs35nd01g_s1y2_ecc_get_status(struct spinand_device *spinand,
> +					u8 status)
> +{
> +	switch (status & STATUS_ECC_MASK) {
> +	case FS35ND01G_S1Y2_STATUS_ECC_0_3_BITFLIPS:
> +		return 3;
> +	/*
> +	 * The datasheet says *successful* with 4 bits flipped.
> +	 * nandbiterrs always complains that the read reported
> +	 * successful but the data is incorrect.
> +	 */
> +	case FS35ND01G_S1Y2_STATUS_ECC_4_BITFLIPS:
> +		return 4;

This is a real issue. Can you use the nandflipbits tool from the
mtd-utils package (you should take a recent version of the package) and
try to observe what happens when you insert a 4th bitflip in a section?

I generally believe the tool more than the datasheet :)

> +	case FS35ND01G_S1Y2_STATUS_ECC_UNCORRECTABLE:
> +		return -EBADMSG;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
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
> +				     fs35nd01g_s1y2_ecc_get_status)),
> +	SPINAND_INFO("FS35ND02G-S3Y2",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xEB, 0x11),
> +		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(4, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&fs35nd01g_s1y2_ooblayout,
> +				     fs35nd01g_s1y2_ecc_get_status)),
> +	SPINAND_INFO("FS35ND04G-S2Y2",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xEC, 0x11),
> +		     NAND_MEMORG(1, 2048, 64, 64, 4096, 40, 1, 1, 1),
> +		     NAND_ECCREQ(4, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&fs35nd01g_s1y2_ooblayout,
> +				     fs35nd01g_s1y2_ecc_get_status)),
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
> index 6988956b8492..f6c38528bb03 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -261,6 +261,7 @@ struct spinand_manufacturer {
>  
>  /* SPI NAND manufacturers */
>  extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
> +extern const struct spinand_manufacturer longsys_spinand_manufacturer;
>  extern const struct spinand_manufacturer macronix_spinand_manufacturer;
>  extern const struct spinand_manufacturer micron_spinand_manufacturer;
>  extern const struct spinand_manufacturer paragon_spinand_manufacturer;

Otherwise LGTM.

Thanks,
Miquèl
