Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FC338B7B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbhETToX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:44:23 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:51541 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbhETToV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:44:21 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9A9802224F;
        Thu, 20 May 2021 21:42:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1621539778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PXx0yLjlrtiHDlCEaadb4ABif1Ty0VDPS8v0RFGdt9E=;
        b=Hj9RLYgDfbUIJ+oyLLg/oK8fBaOVdfTMTGVo8fPTW2CGPCwShVd6M/7jbQbXoBQIjyUX6e
        dwpHPuQR7S3XRWPP9PqBM8Danlwa0Ow+ZtSfa7JJFl9e1k9ZtQ+AGYQknOcfhrwVzRklQ4
        su0a3ZcT86SkbTZVUwHosvyJRHKVScc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 May 2021 21:42:57 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 3/3] mtd: spi-nor: otp: implement erase for Winbond and
 similar flashes
In-Reply-To: <20210520175102.hfo3aa3ubpa5gqgi@ti.com>
References: <20210520155854.16547-1-michael@walle.cc>
 <20210520155854.16547-4-michael@walle.cc>
 <20210520175102.hfo3aa3ubpa5gqgi@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <143023b4a6bf2a65f54f604e2a1f9cac@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-05-20 19:51, schrieb Pratyush Yadav:
> On 20/05/21 05:58PM, Michael Walle wrote:
>> Winbond flashes with OTP support provide a command to erase the OTP
>> data. This might come in handy during development.
>> 
>> This was tested with a Winbond W25Q32JW on a LS1028A SoC with the
>> NXP FSPI controller.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
> [...]
>> diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
>> index ec0c1b33f7cc..2dc315b6bffc 100644
>> --- a/drivers/mtd/spi-nor/otp.c
>> +++ b/drivers/mtd/spi-nor/otp.c
>> @@ -111,6 +111,34 @@ int spi_nor_otp_write_secr(struct spi_nor *nor, 
>> loff_t addr, size_t len,
>>  	return ret ?: written;
>>  }
>> 
>> +/**
>> + * spi_nor_otp_erase_secr() - erase a security register
>> + * @nor:        pointer to 'struct spi_nor'
>> + * @addr:       offset of the security register to be erased
>> + *
>> + * Erase a security register by using the SPINOR_OP_ESECR command. 
>> This method
>> + * is used on GigaDevice and Winbond flashes to erase OTP data.
>> + *
>> + * Return: 0 on success, -errno otherwise
>> + */
>> +int spi_nor_otp_erase_secr(struct spi_nor *nor, loff_t addr)
>> +{
>> +	u8 erase_opcode = nor->erase_opcode;
>> +	int ret;
>> +
>> +	ret = spi_nor_write_enable(nor);
>> +	if (ret)
>> +		return ret;
>> +
>> +	nor->erase_opcode = SPINOR_OP_ESECR;
>> +	ret = spi_nor_erase_sector(nor, addr);
>> +	nor->erase_opcode = erase_opcode;
>> +	if (ret)
>> +		return ret;
>> +
>> +	return spi_nor_wait_till_ready(nor);
> 
> The datasheet for W25Q32JW says in Section 8.2.29:
> 
>   The Security Register Lock Bits (LB3-1) in the Status Register-2 can
>   be used to OTP protect the security registers. Once a lock bit is set
>   to 1, the corresponding security register will be permanently locked,
>   Erase Security Register instruction to that register will be ignored
> 
> So if the region is locked, the flash will happily accept the erase and
> simply do nothing. So will the program. So when the OTP region is 
> locked
> and someone does an erase-program cycle, they will think their data 
> went
> through even though it was simply thrown away by the flash.

Btw, this is also how it is handled for the "normal" data write 
protection.
If block protection bits are set, we happily accept erase and write
commands although the flash will discard the commands.

> I think you should check that bit before doing these operations to make
> sure it is actually allowed. If it isn't, return an error code (-EPERM
> maybe).

It's not that easy. You'd have to check the entire range, not just a 
part
of it. Otherwise you'll end up with half of the data committed to the 
flash
and the other half rejected with EPERM. So you'd have to do in
spi_nor_mtd_otp_erase() and spi_nor_mtd_otp_write().

I'm not opposed to it, but I tried to behave in the same way as the
other MTD chips which supports the OTP ops and I thought they would
ignore it, too. But I just had another look:
  - chips/cfi_cmdset_0001.c: seems to return -EROFS (partial writes are
    possible?). I couldn't find any datasheets where command 0xc0 is
    used to write OTP data. Thus I can only guess that status bit 1 is
    program failed or something like that [1]. All the datasheets I found
    will tell you its bit 0.
  - chips/cfi_cmdset_0002.c: seems to ignore errors
  - nand/onenand/onenand_base.c: I really don't know..

If no one opposes I'll add that check with EROFS.

-michael

[1] 
https://elixir.bootlin.com/linux/v5.13-rc2/source/drivers/mtd/chips/cfi_cmdset_0001.c#L1606
