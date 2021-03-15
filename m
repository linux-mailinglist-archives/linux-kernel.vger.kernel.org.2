Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2BC33AFFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhCOKaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:30:22 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38097 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhCOK3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:29:47 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 15E532223A;
        Mon, 15 Mar 2021 11:29:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615804184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+G0aHtxYhQhsAv27r0UhYEFH5PYNNiTmAc6FMMstIQ=;
        b=aInZ0BfuvttaSH0mW2556X+pvfz9pLyLrfE3jANCutDE71/K2EE5q1wQ57ep8UN/E2WmKu
        Z5YhD2f+ys713msS7MpBsvrfJXyZTrKqJeVbgZJVdVpmWo6BehpZErRtBFWSTfF1qsYB84
        0ol8tXZyG+OJArdoxTXBF/GtW+mfxso=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Mar 2021 11:29:44 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH v4 2/4] mtd: spi-nor: implement OTP support for Winbond
 and similar flashes
In-Reply-To: <b2baa942-6018-16a6-a5b7-76ed61b5eb8b@microchip.com>
References: <20210306000535.9890-1-michael@walle.cc>
 <20210306000535.9890-3-michael@walle.cc>
 <b2baa942-6018-16a6-a5b7-76ed61b5eb8b@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <81b861a5340fc300293f46e583b412cd@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-15 09:20, schrieb Tudor.Ambarus@microchip.com:
> On 3/6/21 2:05 AM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Use the new OTP ops to implement OTP access on Winbond flashes. Most
>> Winbond flashes provides up to four different OTP regions ("Security
>> Registers").
>> 
>> Winbond devices use a special opcode to read and write to the OTP
>> regions, just like the RDSFDP opcode. In fact, it seems that the
>> (undocumented) first OTP area of the newer flashes is the actual SFDP
>> table.
>> 
>> On a side note, Winbond devices also allow erasing the OTP regions as
>> long as the area isn't locked down.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/mtd/spi-nor/core.c  |   2 +-
>>  drivers/mtd/spi-nor/core.h  |   6 ++
>>  drivers/mtd/spi-nor/otp.c   | 164 
>> ++++++++++++++++++++++++++++++++++++
>>  include/linux/mtd/spi-nor.h |   9 ++
>>  4 files changed, 180 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 0c5c757fa95b..ef7df26896f1 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -1034,7 +1034,7 @@ static int 
>> spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 sr1)
>>   *
>>   * Return: 0 on success, -errno otherwise.
>>   */
>> -static int spi_nor_write_16bit_cr_and_check(struct spi_nor *nor, u8 
>> cr)
>> +int spi_nor_write_16bit_cr_and_check(struct spi_nor *nor, u8 cr)
>>  {
>>         int ret;
>>         u8 *sr_cr = nor->bouncebuf;
>> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
>> index ec8da1243846..dfbf6ba42b57 100644
>> --- a/drivers/mtd/spi-nor/core.h
>> +++ b/drivers/mtd/spi-nor/core.h
>> @@ -496,6 +496,7 @@ int spi_nor_read_sr(struct spi_nor *nor, u8 *sr);
>>  int spi_nor_read_cr(struct spi_nor *nor, u8 *cr);
>>  int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len);
>>  int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 sr1);
>> +int spi_nor_write_16bit_cr_and_check(struct spi_nor *nor, u8 cr);
>> 
>>  int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr);
>>  ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t 
>> len,
>> @@ -503,6 +504,11 @@ ssize_t spi_nor_read_data(struct spi_nor *nor, 
>> loff_t from, size_t len,
>>  ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t 
>> len,
>>                            const u8 *buf);
>> 
>> +int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t 
>> len, u8 *buf);
>> +int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t 
>> len, u8 *buf);
>> +int spi_nor_otp_lock_sr2(struct spi_nor *nor, unsigned int region);
>> +int spi_nor_otp_is_locked_sr2(struct spi_nor *nor, unsigned int 
>> region);
>> +
>>  int spi_nor_hwcaps_read2cmd(u32 hwcaps);
>>  u8 spi_nor_convert_3to4_read(u8 opcode);
>>  void spi_nor_set_read_settings(struct spi_nor_read_command *read,
>> diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
>> index 4e301fd5156b..4e8da9108c77 100644
>> --- a/drivers/mtd/spi-nor/otp.c
>> +++ b/drivers/mtd/spi-nor/otp.c
>> @@ -15,6 +15,170 @@
>>  #define spi_nor_otp_region_len(nor) ((nor)->params->otp.org->len)
>>  #define spi_nor_otp_n_regions(nor) 
>> ((nor)->params->otp.org->n_regions)
>> 
>> +/**
>> + * spi_nor_otp_read_secr() - read OTP data
>> + * @nor:       pointer to 'struct spi_nor'
>> + * @from:       offset to read from
>> + * @len:        number of bytes to read
>> + * @buf:        pointer to dst buffer
> 
> is buf DMA-able?

That's actually the same description as spi_nor_read_data().
Looks like the spimem will provide a DMA-able buffer on
the fly if necessary. I'm not sure about the the
spi_nor_controller_ops.

>> + *
>> + * Read OTP data from one region by using the SPINOR_OP_RSECR 
>> commands. This
>> + * method is used on GigaDevice and Winbond flashes.
>> + *
>> + * Return: number of bytes read successfully, -errno otherwise
>> + */
>> +int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t 
>> len, u8 *buf)
>> +{
>> +       u8 addr_width, read_opcode, read_dummy;
>> +       struct spi_mem_dirmap_desc *rdesc;
>> +       enum spi_nor_protocol read_proto;
>> +       int ret;
>> +
>> +       read_opcode = nor->read_opcode;
>> +       addr_width = nor->addr_width;
>> +       read_dummy = nor->read_dummy;
>> +       read_proto = nor->read_proto;
>> +       rdesc = nor->dirmap.rdesc;
>> +
>> +       nor->read_opcode = SPINOR_OP_RSECR;
>> +       nor->addr_width = 3;
>> +       nor->read_dummy = 8;
>> +       nor->read_proto = SNOR_PROTO_1_1_1;
> 
> any winbond/gigadevice flashes with octal dtr support? Do they
> provide SEC Register opcodes for octal dtr?

AFAIK there are no winbond flashes with 8 bit I/O. There are
4bit/DTR modes, but not for the security registers.

I don't know what you had in mind. But I don't think it is
worth to read the 3x 256byte data faster than single bit I/O.

-michael
