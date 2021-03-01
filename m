Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F4D3294E3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 23:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbhCAWZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 17:25:56 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:57557 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238354AbhCARc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:32:57 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 91C2A22178;
        Mon,  1 Mar 2021 18:32:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614619930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cBQ1jAAKy0ohZPrxLCFbi78HgGl90AJpkwg0IurHWLU=;
        b=C9lC4Fp4FqbLvJU0VI5TJ9sSF0z1sd93lynViKA+PRtjjUDGESAsl2b+w9oP1GAoxky047
        guBfpG7xItw1ADCzpsglZBitb3jlQeHODM9IGLFIS+l7Lmy1Kj58aXp+BZCD6xOIzHwVI1
        lB2cO1Z3VU0JXPPcAc+bYNmbWzibf5s=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Mar 2021 18:32:09 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add OTP support
In-Reply-To: <d4f74b1b-fa1b-97ec-858c-d807fe1f9e57@microchip.com>
References: <20210216162807.13509-1-michael@walle.cc>
 <20210216162807.13509-2-michael@walle.cc>
 <d4f74b1b-fa1b-97ec-858c-d807fe1f9e57@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <7d1f770ae750d6ed5fb942b16979cdcb@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

thanks for the review.

Am 2021-02-28 13:00, schrieb Tudor.Ambarus@microchip.com:
> On 2/16/21 6:28 PM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> SPI flashes sometimes have a special OTP area, which can (and is) used 
>> to
>> store immutable properties like board serial number or vendor assigned
>> network hardware addresses.
>> 
>> The MTD subsystem already supports accessing such areas and some (non
>> SPI-NOR) flashes already implement support for it. It differentiates
>> between user and factory areas. User areas can be written by the user 
>> and
>> factory ones are pre-programmed and locked down by the vendor, usually
>> containing an "electrical serial number". This patch will only add 
>> support
>> for the user areas.
>> 
>> Lay the foundation and implement the MTD callbacks for the SPI-NOR and 
>> add
>> necessary parameters to the flash_info structure. If a flash supports 
>> OTP
>> it can be added by the convenience macro OTP_INFO(). Sometimes there 
>> are
>> individual regions, which might have individual offsets. Therefore, it 
>> is
>> possible to specify the starting address of the first regions as well 
>> as
>> the distance between two regions (e.g. Winbond devices uses this 
>> method).
>> 
>> Additionally, the regions might be locked down. Once locked, no 
>> further
>> write access is possible.
>> 
>> For SPI-NOR flashes the OTP area is accessed like the normal memory, 
>> e.g.
>> by offset addressing; except that you either have to use special 
>> read/write
>> commands (Winbond) or you have to enter (and exit) a specific OTP mode
>> (Macronix, Micron).
>> 
>> Thus we introduce four operations to which the MTD callbacks will be
>> mapped: .read(), .write(), .lock() and .is_locked(). The read and the 
>> write
>> ops will be given an address offset to operate on while the locking 
>> ops use
>> regions because locking always affects a whole region. It is up to the
>> flash driver to implement these ops.
>> 
> 
> SPI NORs can support some OTP-like behaviour, meaning that in addition 
> to
> the tipical OTP ops (read, write, lock), the SPI NORs can also erase 
> the
> OTP-like memory before the permanent lock. I find the erase useful, in
> case one writes something wrong from the start, in case of errors where
> what was written differs from what is read back, or simply at 
> development
> stage, to check the implementation. So I think we should add support 
> for
> that too. If not now, maybe later.

As mentioned on IRC, this should be a seperate ioctl() thus the 
mtd-utils
need to be changed, too. I wouldn't like to change the semantics of the
current (more or less well-established) ioctl interface around MTD otp
operations.

Thus maybe there might be OTPERASE ioctl, similar to OTPLOCK. I'm open
to this, but in a seperate patch series.

>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 0522304f52fa..af9d7f194f01 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
> 
> cut
>> @@ -3502,6 +3508,8 @@ int spi_nor_scan(struct spi_nor *nor, const char 
>> *name,
>>                 mtd->_is_locked = spi_nor_is_locked;
>>         }
>> 
>> +       spi_nor_otp_init(nor);
> 
> since this returns void, we can do it the last thing in the 
> spi_nor_scan(), so
> that we don't gratuitously init fields in case of errors.

Mh, it used to be at this point because it sets the mtd ops. In my
previous patch version this was still inline. So sure I can move it,
but I'd move it right before spi_nor_init() because that will actually
interface with the SPI flash.

>> +
>>         if (info->flags & USE_FSR)
>>                 nor->flags |= SNOR_F_USE_FSR;
>>         if (info->flags & SPI_NOR_HAS_TB) {
>> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
>> index 4a3f7f150b5d..5fb54ae08c5b 100644
>> --- a/drivers/mtd/spi-nor/core.h
>> +++ b/drivers/mtd/spi-nor/core.h
>> @@ -175,6 +175,21 @@ struct spi_nor_erase_map {
>>         u8                              uniform_erase_type;
>>  };
>> 
>> +/**
>> + * struct spi_nor_otp_info - Structure to describe the SPI NOR OTP 
>> region
>> + * @otp_size:          size of one OTP region in bytes.
>> + * @n_otps:            number of individual OTP regions.
>> + * @otp_start_addr:    start address of the OTP area.
>> + * @otp_addr_offset:   offset between consecutive OTP regions if 
>> there are
>> + *                     more than one.
>> + */
>> +struct spi_nor_otp_info {
>> +       u32 otp_size;
>> +       int n_otps;
>> +       u32 otp_start_addr;
>> +       u32 otp_addr_offset;
>> +};
> 
> How about the following:
> 
> struct spi_nor_otp_memory_organization {

I've used spi_nor_otp_organization, first because its a shorter name
and second it might or might not have something to do with memory.

> 	loff_t base;
> 	loff_t offset;
> 	size_t len;
> 	unsigned int n_regions;
> };

otherwise I've put the len argument as the first property, because
other flashes usually contain just one region, thus base and offset
are normally unused (or zero).

[..]

>> @@ -341,6 +374,15 @@ struct flash_info {
>> 
>>         /* Part specific fixup hooks. */
>>         const struct spi_nor_fixups *fixups;
>> +
>> +       /* OTP size in bytes */
>> +       u16 otp_size;
>> +       /* Number of OTP banks */
>> +       u16 n_otps;
>> +       /* Start address of OTP area */
>> +       u32 otp_start_addr;
>> +       /* Offset between consecutive OTP banks if there are more than 
>> one */
>> +       u32 otp_addr_offset;
> 
> Let's use the structure that we have already defined:
> struct spi_nor_otp_memory_organization otp_memorg;

Ok, this was due to the convenience macro OTP_INFO(). Which now
looks like:

#define OTP_INFO(_len, _n_regions, _base, _offset)			\
		.otp_org = (struct spi_nor_otp_organization) {		\
			.len = (_len),				\
			.base = (_base),				\
			.offset = (_offset),				\
			.n_regions = (_n_regions),			\
		},

btw there is also a shorter OTP_INFO1(_len) which I used for the
macronix flashes (which for now was dropped in this series).

>> diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
>> new file mode 100644
>> index 000000000000..59bd1a3f450d
>> --- /dev/null
>> +++ b/drivers/mtd/spi-nor/otp.c
>> @@ -0,0 +1,157 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * OTP support for SPI-NOR flashes
>> + *
>> + * Copyright (C) 2021 Michael Walle <michael@walle.cc>
>> + */
>> +
>> +#include <linux/mtd/mtd.h>
>> +#include <linux/mtd/spi-nor.h>
>> +
>> +#include "core.h"
>> +
>> +static loff_t spi_nor_otp_region_start(struct spi_nor *nor, int 
>> region)
> 
> const struct spi_nor *nor, unsigned int region
> 
>> +{
>> +       struct spi_nor_otp_info *info = &nor->params->otp_info;
>> +
>> +       return info->otp_start_addr + region * info->otp_addr_offset;
>> +}
>> +
>> +static loff_t spi_nor_otp_region_end(struct spi_nor *nor, int region)
> 
> same
> 
>> +{
>> +       struct spi_nor_otp_info *info = &nor->params->otp_info;
>> +
>> +       return spi_nor_otp_region_start(nor, region) + info->otp_size 
>> - 1;
>> +}
>> +
>> +static int spi_nor_mtd_otp_info(struct mtd_info *mtd, size_t len,
>> +                               size_t *retlen, struct otp_info *buf)
>> +{
>> +       struct spi_nor *nor = mtd_to_spi_nor(mtd);
> 
> const struct spi_nor *nor

Isn't possible, because is_locked() is called which in turn
calls spi_nor_read_xx() which takes "struct spi_nor".

>> +       int n_otps = nor->params->otp_info.n_otps;
>> +       int locked, i;
> 
> unsigned int i;
> 
>> +
>> +       if (len < n_otps * sizeof(*buf))
>> +               return -ENOSPC;
>> +
>> +       for (i = 0; i < n_otps; i++) {
>> +               buf[i].start = spi_nor_otp_region_start(nor, i);
>> +               buf[i].length = nor->params->otp_info.otp_size;
>> +
>> +               locked = nor->params->otp_ops->is_locked(nor, i);
>> +               if (locked < 0)
>> +                       return locked;
>> +
>> +               buf[i].locked = !!locked;
>> +       }
>> +
>> +       *retlen = n_otps * sizeof(*buf);
>> +
>> +       return 0;
>> +}
>> +
>> +static int spi_nor_otp_addr_to_region(struct spi_nor *nor, loff_t 
>> addr)
>> +{
>> +       int i;
> 
> unsigned int i;
> 
>> +
>> +       for (i = 0; i < nor->params->otp_info.n_otps; i++)
>> +               if (addr >= spi_nor_otp_region_start(nor, i) &&
>> +                   addr <= spi_nor_otp_region_end(nor, i))
>> +                       return i;
>> +
>> +       return -EINVAL;
>> +}
>> +
>> +static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t 
>> ofs,
>> +                                     size_t len, size_t *retlen, 
>> u_char *buf,
>> +                                     bool is_write)
>> +{
>> +       struct spi_nor *nor = mtd_to_spi_nor(mtd);
> 
> const

likewise

> 
>> +       int region;
>> +       int ret;
>> +
>> +       *retlen = 0;
>> +
>> +       region = spi_nor_otp_addr_to_region(nor, ofs);
>> +       if (region < 0)
>> +               return 0;
>> +
>> +       if (ofs < spi_nor_otp_region_start(nor, region))
>> +               return 0;
>> +
>> +       if ((ofs + len - 1) > spi_nor_otp_region_end(nor, region))
>> +               return 0;
>> +
>> +       ret = spi_nor_lock_and_prep(nor);
> 
> please check the ret value

good catch.

> 
>> +
>> +       if (is_write)
>> +               ret = nor->params->otp_ops->write(nor, ofs, len, buf);
>> +       else
>> +               ret = nor->params->otp_ops->read(nor, ofs, len, buf);
>> +
>> +       spi_nor_unlock_and_unprep(nor);
>> +
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       *retlen = len;
>> +       return 0;
>> +}
>> +
>> +static int spi_nor_mtd_otp_read(struct mtd_info *mtd, loff_t from, 
>> size_t len,
>> +                               size_t *retlen, u_char *buf)
>> +{
>> +       return spi_nor_mtd_otp_read_write(mtd, from, len, retlen, buf, 
>> false);
>> +}
>> +
>> +static int spi_nor_mtd_otp_write(struct mtd_info *mtd, loff_t to, 
>> size_t len,
>> +                                size_t *retlen, u_char *buf)
>> +{
>> +       return spi_nor_mtd_otp_read_write(mtd, to, len, retlen, buf, 
>> true);
>> +}
>> +
>> +static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, 
>> size_t len)
>> +{
>> +       struct spi_nor *nor = mtd_to_spi_nor(mtd);
> 
> const

likewise

> 
>> +       int region;
>> +       int ret;
>> +
>> +       region = spi_nor_otp_addr_to_region(nor, from);
>> +       if (region < 0)
>> +               return -EINVAL;
>> +
>> +       if (len != nor->params->otp_info.otp_size)
>> +               return -EINVAL;
> 
> Does the otp memory organization matter for the end user?
> Can't we lock/read/write past region size, for example 2 or 3 regions 
> in a row,
> depending on length?

Mhh tough one. I guess the question really is: Do we want
to remap the 0x1000, 0x2000, 0x3000 offsets?
  - 0x1000 -> 0
  - 0x2000 -> 1 * region_size
  - 0x3000 -> 2 * region_size

This is just an example, some devices may us other offsets.

I'd see this as a prerequsite for handling multiple regions
in one write, because otherwise you'll have to handle the
holes which makes it impossible I guess. For example what
would happen with (given an otp size of 0x100):
  (1) lock(0, 0x100)
  (2) lock(0x100, 0xf00)
  (3) lock(0, 0x1000)

(1) will work, (2) should return -EINVAL; but what will (3)
return. -EINVAL too, I guess. But then, ops spanning multiple
regions doesn't make sense at all, because they will always
return -EINVAL.

Unfortunately, I don't know how userspace might access it.

This is how it looks like at the moment:

# flash_otp_info -u /dev/mtd1
Number of OTP user blocks on /dev/mtd1: 3
block  0:  offset = 0x1000  size = 256 bytes  [unlocked]
block  1:  offset = 0x2000  size = 256 bytes  [unlocked]
block  2:  offset = 0x3000  size = 256 bytes  [unlocked]

-michael
