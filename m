Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9EA38B57E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhETRwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:52:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39594 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbhETRwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:52:37 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14KHp6FP012774;
        Thu, 20 May 2021 12:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621533066;
        bh=71SRxWPp32oLiCpyyS/3q/lgTgU5j3YxVkv6LXLizQ0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Gd00o//4mpY3WFzdmof2Pzp5IZo7SJ4CzVZ0VTCVI+Usdzh/IslLIwrWRQuIgiI/o
         wk/edE51k4gHOs4DBT/9UVSJYivIMkXJt0bCrMvbYofDjUNVysGbzPTx12W7UsP5PW
         esOcm/gUDJxMbJkUCbNq2YGZRMFd0QpO64bPHNZ4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14KHp6MM081412
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 May 2021 12:51:06 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 20
 May 2021 12:51:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 20 May 2021 12:51:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14KHp59Y039957;
        Thu, 20 May 2021 12:51:05 -0500
Date:   Thu, 20 May 2021 23:21:04 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 3/3] mtd: spi-nor: otp: implement erase for Winbond
 and similar flashes
Message-ID: <20210520175102.hfo3aa3ubpa5gqgi@ti.com>
References: <20210520155854.16547-1-michael@walle.cc>
 <20210520155854.16547-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210520155854.16547-4-michael@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/21 05:58PM, Michael Walle wrote:
> Winbond flashes with OTP support provide a command to erase the OTP
> data. This might come in handy during development.
> 
> This was tested with a Winbond W25Q32JW on a LS1028A SoC with the
> NXP FSPI controller.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
[...]
> diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
> index ec0c1b33f7cc..2dc315b6bffc 100644
> --- a/drivers/mtd/spi-nor/otp.c
> +++ b/drivers/mtd/spi-nor/otp.c
> @@ -111,6 +111,34 @@ int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len,
>  	return ret ?: written;
>  }
>  
> +/**
> + * spi_nor_otp_erase_secr() - erase a security register
> + * @nor:        pointer to 'struct spi_nor'
> + * @addr:       offset of the security register to be erased
> + *
> + * Erase a security register by using the SPINOR_OP_ESECR command. This method
> + * is used on GigaDevice and Winbond flashes to erase OTP data.
> + *
> + * Return: 0 on success, -errno otherwise
> + */
> +int spi_nor_otp_erase_secr(struct spi_nor *nor, loff_t addr)
> +{
> +	u8 erase_opcode = nor->erase_opcode;
> +	int ret;
> +
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +
> +	nor->erase_opcode = SPINOR_OP_ESECR;
> +	ret = spi_nor_erase_sector(nor, addr);
> +	nor->erase_opcode = erase_opcode;
> +	if (ret)
> +		return ret;
> +
> +	return spi_nor_wait_till_ready(nor);

The datasheet for W25Q32JW says in Section 8.2.29:
  
  The Security Register Lock Bits (LB3-1) in the Status Register-2 can 
  be used to OTP protect the security registers. Once a lock bit is set 
  to 1, the corresponding security register will be permanently locked,  
  Erase Security Register instruction to that register will be ignored

So if the region is locked, the flash will happily accept the erase and 
simply do nothing. So will the program. So when the OTP region is locked 
and someone does an erase-program cycle, they will think their data went 
through even though it was simply thrown away by the flash.

I think you should check that bit before doing these operations to make 
sure it is actually allowed. If it isn't, return an error code (-EPERM 
maybe).

> +}
> +
>  static int spi_nor_otp_lock_bit_cr(unsigned int region)
>  {
>  	static const int lock_bits[] = { SR2_LB1, SR2_LB2, SR2_LB3 };
[...]

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
