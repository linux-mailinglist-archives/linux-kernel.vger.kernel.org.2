Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2C538AE17
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhETMZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:25:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40564 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhETMYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:24:48 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14KCMx5b000755;
        Thu, 20 May 2021 07:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621513379;
        bh=PHQEjO3386IOiR03Z3Lkca0h/KvRdaxXL9UXwhXPi2o=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xYDuCKJwzk9DXkIKt0oKJy1kDC8kVrB97iX71+eV+xpwCeXghAg398nLBK2RI4TbF
         gokd3VwTUrvgpL0yCRhZ8Hf3IbnjtMm3kmhSG1Tj+7zIJiYycYEfmEg8kDTG4ADXa2
         wZKqVfrIKQVGMXw6JhRT+fvvelHjpzG1X+kuzDPM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14KCMx38004006
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 May 2021 07:22:59 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 20
 May 2021 07:22:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 20 May 2021 07:22:59 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14KCMwdv073349;
        Thu, 20 May 2021 07:22:59 -0500
Date:   Thu, 20 May 2021 17:52:58 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2] mtd: spi-nor: implement OTP erase for Winbond and
 similar flashes
Message-ID: <20210520122256.fhkzpqmu7nxwjoqt@ti.com>
References: <20210510202056.30000-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210510202056.30000-1-michael@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 10/05/21 10:20PM, Michael Walle wrote:
> Winbond flashes with OTP support provide a command to erase the OTP
> data. This might come in handy during development.

I am not very familiar with the OTP feature. It is supposed to be "One 
Time Programmable". So does erasing the OTP area make it programmable 
again? Or it just erases the data and then the OTP region will forever 
be 0xff?

Because if you can erase and reprogram it, how is it OTP at all?

> 
> This was tested with a Winbond W25Q32JW on a LS1028A SoC with the
> NXP FSPI controller.

I got the datasheet for this flash from 
https://www.elinux.org/images/f/f5/Winbond-w25q32.pdf but it doesn't 
seem to mention the erase OTP command (0x44).

> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v1:
>  - fixed kernel doc
> 
> There is also a patch for mtd-utils to add a small tool to issue
> the erase:
> https://lore.kernel.org/linux-mtd/20210510201319.25975-1-michael@walle.cc/
> 
>  drivers/mtd/spi-nor/core.c    |  4 +-
>  drivers/mtd/spi-nor/core.h    |  4 ++
>  drivers/mtd/spi-nor/otp.c     | 73 ++++++++++++++++++++++++++++++++++-
>  drivers/mtd/spi-nor/winbond.c |  1 +
>  4 files changed, 78 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index bd2c7717eb10..fac8717f651f 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -166,8 +166,8 @@ static int spi_nor_controller_ops_read_reg(struct spi_nor *nor, u8 opcode,
>  	return nor->controller_ops->read_reg(nor, opcode, buf, len);
>  }
>  
> -static int spi_nor_controller_ops_write_reg(struct spi_nor *nor, u8 opcode,
> -					    const u8 *buf, size_t len)
> +int spi_nor_controller_ops_write_reg(struct spi_nor *nor, u8 opcode,
> +				     const u8 *buf, size_t len)
>  {
>  	if (spi_nor_protocol_is_dtr(nor->reg_proto))
>  		return -EOPNOTSUPP;
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 28a2e0be97a3..b410e4eec2fb 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -214,6 +214,7 @@ struct spi_nor_otp_ops {
>  	int (*write)(struct spi_nor *nor, loff_t addr, size_t len,
>  		     const u8 *buf);
>  	int (*lock)(struct spi_nor *nor, unsigned int region);
> +	int (*erase)(struct spi_nor *nor, loff_t addr);

No doc update above?

>  	int (*is_locked)(struct spi_nor *nor, unsigned int region);
>  };
>  
> @@ -481,6 +482,8 @@ extern const struct spi_nor_manufacturer spi_nor_xmc;
>  void spi_nor_spimem_setup_op(const struct spi_nor *nor,
>  			     struct spi_mem_op *op,
>  			     const enum spi_nor_protocol proto);
> +int spi_nor_controller_ops_write_reg(struct spi_nor *nor, u8 opcode,
> +				     const u8 *buf, size_t len);
>  int spi_nor_write_enable(struct spi_nor *nor);
>  int spi_nor_write_disable(struct spi_nor *nor);
>  int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
> @@ -507,6 +510,7 @@ ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
>  int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf);
>  int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len,
>  			   const u8 *buf);
> +int spi_nor_otp_erase_secr(struct spi_nor *nor, loff_t addr);
>  int spi_nor_otp_lock_sr2(struct spi_nor *nor, unsigned int region);
>  int spi_nor_otp_is_locked_sr2(struct spi_nor *nor, unsigned int region);
>  
> diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
> index 61036c716abb..d3ca73c8cc53 100644
> --- a/drivers/mtd/spi-nor/otp.c
> +++ b/drivers/mtd/spi-nor/otp.c
> @@ -8,6 +8,7 @@
>  #include <linux/log2.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/spi-nor.h>
> +#include <linux/spi/spi-mem.h>
>  
>  #include "core.h"
>  
> @@ -111,6 +112,48 @@ int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len,
>  	return ret ?: written;
>  }
>  
> +/**
> + * spi_nor_otp_erase_secr() - erase one OTP region

Nitpick: The function is called erase_secr() but the comment says erase 
region. Please use consistent wording.

> + * @nor:        pointer to 'struct spi_nor'
> + * @addr:       offset of the OTP region to be erased
> + *
> + * Erase one OTP region by using the SPINOR_OP_ESECR commands. This method is
> + * used on GigaDevice and Winbond flashes.
> + *
> + * Return: 0 on success, -errno otherwise
> + */
> +int spi_nor_otp_erase_secr(struct spi_nor *nor, loff_t addr)
> +{
> +	int ret;
> +
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +
> +	if (nor->spimem) {
> +		struct spi_mem_op op =
> +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_ESECR, 0),
> +				   SPI_MEM_OP_ADDR(3, addr, 0),

Only 3 address bytes needed? Can the OTP region ever require 4 byte 
addressing? For example, say the flash is switched to 4 byte addressing 
for the main region. Would it still expect 3 byte addressing for OTP 
ops?

> +				   SPI_MEM_OP_NO_DUMMY,
> +				   SPI_MEM_OP_NO_DATA);
> +
> +		spi_nor_spimem_setup_op(nor, &op, nor->write_proto);
> +
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		nor->bouncebuf[2] = addr & 0xff;
> +		nor->bouncebuf[1] = (addr >> 8) & 0xff;
> +		nor->bouncebuf[0] = (addr >> 16) & 0xff;
> +
> +		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_ESECR,
> +						       nor->bouncebuf, 3);

Huh, sending address in the "data" parameter of write_reg() is strange. 
Wouldn't you be better off using spi_nor_controller_ops_erase()? It is 
an erase operation anyway so it should be the natural choice.

This was my first thought anyway. Then I looked at 
spi_nor_erase_sector(). It looks like controller_ops->erase is optional, 
and the fallback is this same technique.

I see a lot of similarities between this function and 
spi_nor_erase_sector(). So you can just swap out nor->erase_opcode and 
nor->addr_width and call that. I am not the biggest fan of this approach 
but it is widely used in the core so it should be fine. In fact, OTP 
read and write also use this approach.

> +	}
> +	if (ret)
> +		return ret;
> +
> +	return spi_nor_wait_till_ready(nor);
> +}
> +
>  static int spi_nor_otp_lock_bit_cr(unsigned int region)
>  {
>  	static const int lock_bits[] = { SR2_LB1, SR2_LB2, SR2_LB3 };
> @@ -316,12 +359,14 @@ static int spi_nor_mtd_otp_write(struct mtd_info *mtd, loff_t to, size_t len,
>  	return spi_nor_mtd_otp_read_write(mtd, to, len, retlen, buf, true);
>  }
>  
> -static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
> +static int spi_nor_mtd_otp_lock_erase(struct mtd_info *mtd, loff_t from,

spi_nor_mtd_otp_lock_or_erase()? Or would it make it too long?

Anyway, maybe I am bikeshedding too much, but I don't like that you 
combine two completely independent operations into the same function 
because they have some common parts. You should make them two separate 
functions and see how many of the common parts can be split into 
independent subroutines.

> +				      size_t len, bool is_erase)
>  {
>  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
>  	const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
>  	const size_t rlen = spi_nor_otp_region_len(nor);
>  	unsigned int region;
> +	loff_t rstart;
>  	int ret;
>  
>  	if (from < 0 || (from + len) > spi_nor_otp_size(nor))
> @@ -337,7 +382,13 @@ static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
>  
>  	while (len) {
>  		region = spi_nor_otp_offset_to_region(nor, from);
> -		ret = ops->lock(nor, region);
> +
> +		if (is_erase) {
> +			rstart = spi_nor_otp_region_start(nor, region);
> +			ret = ops->erase(nor, rstart);

This further highlights my point. There are subtle differences between 
erase and lock and having them in the same function might not be the 
best idea.

> +		} else {
> +			ret = ops->lock(nor, region);
> +		}
>  		if (ret)
>  			goto out;
>  
> @@ -351,6 +402,23 @@ static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
>  	return ret;
>  }
>  
> +static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
> +{
> +	return spi_nor_mtd_otp_lock_erase(mtd, from, len, false);
> +}
> +
> +static int spi_nor_mtd_otp_erase(struct mtd_info *mtd, loff_t from, size_t len)
> +{
> +	struct spi_nor *nor = mtd_to_spi_nor(mtd);
> +	const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
> +
> +	/* OTP erase is optional */
> +	if (!ops->erase)
> +		return -EOPNOTSUPP;
> +
> +	return spi_nor_mtd_otp_lock_erase(mtd, from, len, true);
> +}
> +
>  void spi_nor_otp_init(struct spi_nor *nor)
>  {
>  	struct mtd_info *mtd = &nor->mtd;
> @@ -374,4 +442,5 @@ void spi_nor_otp_init(struct spi_nor *nor)
>  	mtd->_read_user_prot_reg = spi_nor_mtd_otp_read;
>  	mtd->_write_user_prot_reg = spi_nor_mtd_otp_write;
>  	mtd->_lock_user_prot_reg = spi_nor_mtd_otp_lock;
> +	mtd->_erase_user_prot_reg = spi_nor_mtd_otp_erase;
>  }
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 9a81c67a60c6..96573f61caf5 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -139,6 +139,7 @@ static int winbond_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
>  static const struct spi_nor_otp_ops winbond_otp_ops = {
>  	.read = spi_nor_otp_read_secr,
>  	.write = spi_nor_otp_write_secr,
> +	.erase = spi_nor_otp_erase_secr,
>  	.lock = spi_nor_otp_lock_sr2,
>  	.is_locked = spi_nor_otp_is_locked_sr2,
>  };
> -- 
> 2.20.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
