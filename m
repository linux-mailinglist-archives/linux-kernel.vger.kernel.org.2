Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF15833AE98
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 10:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhCOJXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 05:23:47 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:45047 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhCOJX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:23:26 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 59BE72223A;
        Mon, 15 Mar 2021 10:23:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615800204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HSAo8MN9eLx6dlCvahOrBuExf77o/pwrYn4Qjk9ZL7c=;
        b=n8OAOmOTpI2KUv8Eh2f1RFSF0hJns4Q90AN5vSXYUbnnPiE6CCpI7GtpwHuc+Yf0nhi3SZ
        9CBCnxCSI0LzYAJ7cCEwXz2B6Q3XweAS7/BKUH5yOsJ551zA/FhnsV63RFnl6VYo1ziODb
        R7vwgyUuCo1W2a3YSvdV2obKW8+tfms=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Mar 2021 10:23:24 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH v4 1/4] mtd: spi-nor: add OTP support
In-Reply-To: <7dd4bfb0-bb38-20c8-68e1-ece836c847fa@microchip.com>
References: <20210306000535.9890-1-michael@walle.cc>
 <20210306000535.9890-2-michael@walle.cc>
 <7dd4bfb0-bb38-20c8-68e1-ece836c847fa@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <b83dbbcdee6bdeee0d494ba79fd792e4@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-15 08:28, schrieb Tudor.Ambarus@microchip.com:
> Michael,
> 
> Just cosmetic suggestions this time.
> 
> On 3/6/21 2:05 AM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> SPI flashes sometimes have a special OTP area, which can (and is) used 
>> to
>> store immutable properties like board serial number or vendor assigned
>> network hardware addresses.
>> 
>> The MTD subsystem already supports accessing such areas and some (non
>> SPI NOR) flashes already implement support for it. It differentiates
>> between user and factory areas. User areas can be written by the user 
>> and
>> factory ones are pre-programmed and locked down by the vendor, usually
>> containing an "electrical serial number". This patch will only add 
>> support
>> for the user areas.
>> 
>> Lay the foundation and implement the MTD callbacks for the SPI NOR and 
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
>> For SPI NOR flashes the OTP area is accessed like the normal memory, 
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
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/mtd/spi-nor/Makefile |   1 +
>>  drivers/mtd/spi-nor/core.c   |   5 +
>>  drivers/mtd/spi-nor/core.h   |  54 +++++++++
>>  drivers/mtd/spi-nor/otp.c    | 218 
>> +++++++++++++++++++++++++++++++++++
>>  4 files changed, 278 insertions(+)
>>  create mode 100644 drivers/mtd/spi-nor/otp.c
>> 
>> diff --git a/drivers/mtd/spi-nor/Makefile 
>> b/drivers/mtd/spi-nor/Makefile
>> index 653923896205..2ed2e76ce4f1 100644
>> --- a/drivers/mtd/spi-nor/Makefile
>> +++ b/drivers/mtd/spi-nor/Makefile
>> @@ -12,6 +12,7 @@ spi-nor-objs                  += intel.o
>>  spi-nor-objs                   += issi.o
>>  spi-nor-objs                   += macronix.o
>>  spi-nor-objs                   += micron-st.o
>> +spi-nor-objs                   += otp.o
> 
> spi-nor-objs                    := core.o sfdp.o otp.o
> 
> This better indicates that otp is part of the "core" driver, while
> the rest are manufacturer drivers (that are too part of the core).

That is already fixed here. Didn't want to send yet another version ;)

> 
>>  spi-nor-objs                   += spansion.o
>>  spi-nor-objs                   += sst.o
>>  spi-nor-objs                   += winbond.o
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 4a315cb1c4db..0c5c757fa95b 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -3009,6 +3009,8 @@ static void spi_nor_info_init_params(struct 
>> spi_nor *nor)
>>         spi_nor_set_erase_type(&map->erase_type[i], info->sector_size,
>>                                SPINOR_OP_SE);
>>         spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
>> +
>> +       nor->params->otp.org = &info->otp_org;
> 
> Init this immediately after the setup init, something like:
> 	params->setup = spi_nor_default_setup;
> 	params->otp.org = &info->otp_org;
> 
>>  }
>> 
>>  /**
>> @@ -3550,6 +3552,9 @@ int spi_nor_scan(struct spi_nor *nor, const char 
>> *name,
>>         if (ret)
>>                 return ret;
>> 
>> +       /* Configure OTP parameters and ops */
>> +       spi_nor_otp_init(nor);
> 
> Please move this as the last init thing in spi_nor_scan, immediately 
> after
> spi_nor_init(nor);
> 
> MTD OTP ops are not used accross spi_nor_scan(), there's no need to 
> init
> these earlier.

Makes sense.

> 
>> +
>>         /* Send all the required SPI flash commands to initialize 
>> device */
>>         ret = spi_nor_init(nor);
>>         if (ret)
>> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
>> index 4a3f7f150b5d..ec8da1243846 100644
>> --- a/drivers/mtd/spi-nor/core.h
>> +++ b/drivers/mtd/spi-nor/core.h
>> @@ -187,6 +187,45 @@ struct spi_nor_locking_ops {
>>         int (*is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t 
>> len);
>>  };
>> 
>> +/**
>> + * struct spi_nor_otp_organization - Structure to describe the SPI 
>> NOR OTP regions
>> + * @len:       size of one OTP region in bytes.
>> + * @base:      start address of the OTP area.
>> + * @offset:    offset between consecutive OTP regions if there are 
>> more
>> + *              than one.
>> + * @n_regions: number of individual OTP regions.
>> + */
>> +struct spi_nor_otp_organization {
>> +       size_t len;
>> +       loff_t base;
>> +       loff_t offset;
>> +       unsigned int n_regions;
>> +};
>> +
>> +/**
>> + * struct spi_nor_otp_ops - SPI NOR OTP methods
>> + * @read:      read from the SPI NOR OTP area.
>> + * @write:     write to the SPI NOR OTP area.
>> + * @lock:      lock an OTP region.
>> + * @is_locked: check if an OTP region of the SPI NOR is locked.
>> + */
>> +struct spi_nor_otp_ops {
>> +       int (*read)(struct spi_nor *nor, loff_t addr, size_t len, u8 
>> *buf);
>> +       int (*write)(struct spi_nor *nor, loff_t addr, size_t len, u8 
>> *buf);
>> +       int (*lock)(struct spi_nor *nor, unsigned int region);
>> +       int (*is_locked)(struct spi_nor *nor, unsigned int region);
>> +};
>> +
>> +/**
>> + * struct spi_nor_otp - SPI NOR OTP grouping structure
>> + * @org:       OTP region organization
>> + * @ops:       OTP access ops
>> + */
>> +struct spi_nor_otp {
>> +       const struct spi_nor_otp_organization *org;
>> +       const struct spi_nor_otp_ops *ops;
>> +};
>> +
>>  /**
>>   * struct spi_nor_flash_parameter - SPI NOR flash parameters and 
>> settings.
>>   * Includes legacy flash parameters and settings that can be 
>> overwritten
>> @@ -208,6 +247,7 @@ struct spi_nor_locking_ops {
>>   *                      higher index in the array, the higher 
>> priority.
>>   * @erase_map:         the erase map parsed from the SFDP Sector Map 
>> Parameter
>>   *                      Table.
>> + * @otp_info:          describes the OTP regions.
>>   * @octal_dtr_enable:  enables SPI NOR octal DTR mode.
>>   * @quad_enable:       enables SPI NOR quad mode.
>>   * @set_4byte_addr_mode: puts the SPI NOR in 4 byte addressing mode.
>> @@ -219,6 +259,7 @@ struct spi_nor_locking_ops {
>>   *                      e.g. different opcodes, specific address 
>> calculation,
>>   *                      page size, etc.
>>   * @locking_ops:       SPI NOR locking methods.
>> + * @otp:               SPI NOR OTP methods.
>>   */
>>  struct spi_nor_flash_parameter {
>>         u64                             size;
>> @@ -232,6 +273,7 @@ struct spi_nor_flash_parameter {
>>         struct spi_nor_pp_command       
>> page_programs[SNOR_CMD_PP_MAX];
>> 
>>         struct spi_nor_erase_map        erase_map;
>> +       struct spi_nor_otp              otp;
>> 
>>         int (*octal_dtr_enable)(struct spi_nor *nor, bool enable);
>>         int (*quad_enable)(struct spi_nor *nor);
>> @@ -341,6 +383,8 @@ struct flash_info {
>> 
>>         /* Part specific fixup hooks. */
>>         const struct spi_nor_fixups *fixups;
>> +
>> +       const struct spi_nor_otp_organization otp_org;
> 
> Can we move otp_org just before fixups? Fixups are usually the last 
> thing
> that we want to specify in a flash info.

sure.

>>  };
>> 
>>  /* Used when the "_ext_id" is two bytes at most */
>> @@ -393,6 +437,14 @@ struct flash_info {
>>                 .addr_width = 3,                                       
>>  \
>>                 .flags = SPI_NOR_NO_FR | SPI_NOR_XSR_RDY,
>> 
>> +#define OTP_INFO(_len, _n_regions, _base, _offset)                    
>>  \
>> +               .otp_org = {                                           
>>  \
>> +                       .len = (_len),                                 
>>  \
>> +                       .base = (_base),                               
>>  \
>> +                       .offset = (_offset),                           
>>  \
>> +                       .n_regions = (_n_regions),                     
>>  \
>> +               },
>> +
>>  /**
>>   * struct spi_nor_manufacturer - SPI NOR manufacturer object
>>   * @name: manufacturer name
>> @@ -473,6 +525,8 @@ int spi_nor_post_bfpt_fixups(struct spi_nor *nor,
>>                              const struct sfdp_bfpt *bfpt,
>>                              struct spi_nor_flash_parameter *params);
>> 
>> +void spi_nor_otp_init(struct spi_nor *nor);
>> +
>>  static struct spi_nor __maybe_unused *mtd_to_spi_nor(struct mtd_info 
>> *mtd)
>>  {
>>         return mtd->priv;
>> diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
>> new file mode 100644
>> index 000000000000..4e301fd5156b
>> --- /dev/null
>> +++ b/drivers/mtd/spi-nor/otp.c
>> @@ -0,0 +1,218 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * OTP support for SPI NOR flashes
>> + *
>> + * Copyright (C) 2021 Michael Walle <michael@walle.cc>> + */
>> +
>> +#include <linux/log2.h>
>> +#include <linux/mtd/mtd.h>
>> +#include <linux/mtd/spi-nor.h>
>> +
>> +#include "core.h"
>> +
>> +#define spi_nor_otp_ops(nor) ((nor)->params->otp.ops)
>> +#define spi_nor_otp_region_len(nor) ((nor)->params->otp.org->len)
>> +#define spi_nor_otp_n_regions(nor) 
>> ((nor)->params->otp.org->n_regions)
> 
> I don't like these wrappers because they gratuiously hide what's really 
> there.
> I find the code more easier to read without these wrappers, because I 
> don't
> have to memorize what these wrappers are doing, and I better see how 
> the code
> is organized.

TBH I find it easier on the eye and I've never seen so much dereferences
as in mtd/spi-nor.

>> +
>> +static loff_t spi_nor_otp_region_start(const struct spi_nor *nor, int 
>> region)
>> +{
>> +       const struct spi_nor_otp_organization *org = 
>> nor->params->otp.org;
> 
> how about s/org/otp_org?

Yeah, as it is just a one line function, I don't really care ;)

>> +
>> +       return org->base + region * org->offset;
>> +}
>> +
>> +static size_t spi_nor_otp_size(struct spi_nor *nor)
>> +{
>> +       return spi_nor_otp_n_regions(nor) * 
>> spi_nor_otp_region_len(nor);
>> +}
>> +
>> +/*
>> + * Translate the file offsets from and to OTP regions. See also
>> + * spi_nor_mtd_otp_do_op().
>> + */
>> +static loff_t spi_nor_otp_region_to_offset(struct spi_nor *nor, 
>> unsigned int region)
>> +{
>> +       return region * spi_nor_otp_region_len(nor);
>> +}
>> +
>> +static unsigned int spi_nor_otp_offset_to_region(struct spi_nor *nor, 
>> loff_t ofs)
>> +{
>> +       return ofs / spi_nor_otp_region_len(nor);
>> +}
>> +
>> +static int spi_nor_mtd_otp_info(struct mtd_info *mtd, size_t len,
>> +                               size_t *retlen, struct otp_info *buf)
>> +{
>> +       struct spi_nor *nor = mtd_to_spi_nor(mtd);
>> +       const struct spi_nor_otp_ops *ops = spi_nor_otp_ops(nor);
>> +       unsigned int n_regions = spi_nor_otp_n_regions(nor);
>> +       unsigned int region;
>> +       int ret, locked;
>> +
>> +       if (len < n_regions * sizeof(*buf))
>> +               return -ENOSPC;
>> +
>> +       ret = spi_nor_lock_and_prep(nor);
>> +       if (ret)
>> +               return ret;
>> +
>> +       for (region = 0; region < spi_nor_otp_n_regions(nor); 
>> region++) {
> 
> for (i = 0; i <  n_regions; i++)
> 
> already indicates that i is the index of a region, no need to have an 
> explicit
> name. Also, if you want to introduce a local variable, n_regions, use 
> it here
> too.

Mh, thas was a left over, from when I had a for_each_ helper. But the
new version just has this one occurence, so I've removed that. I
already felt there was some resistance on these helpers ;)

> 
>> +               buf->start = spi_nor_otp_region_to_offset(nor, 
>> region);
>> +               buf->length = spi_nor_otp_region_len(nor);
>> +
>> +               locked = ops->is_locked(nor, region);
>> +               if (locked < 0) {
>> +                       ret = locked;
>> +                       goto out;
>> +               }
>> +
>> +               buf->locked = !!locked;
>> +               buf++;
>> +       }
>> +
>> +       *retlen = n_regions * sizeof(*buf);
>> +
>> +out:
>> +       spi_nor_unlock_and_unprep(nor);
>> +
>> +       return ret;
>> +}
>> +
>> +static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t 
>> ofs,
>> +                                     size_t total_len, size_t 
>> *retlen,
>> +                                     u_char *buf, bool is_write)
> 
> not related to this patch, but the list of arguments is quite big, 
> maybe
> we can update mtd to pass a pointer to a struct.

For external functions, sure. But this is internal so I don't
see any advantage here. Also this is kinda special because its
the argument list of the mtd ops appended with the is_write
parameter.

>> +{
>> +       struct spi_nor *nor = mtd_to_spi_nor(mtd);
>> +       const struct spi_nor_otp_ops *ops = spi_nor_otp_ops(nor);
>> +       const size_t rlen = spi_nor_otp_region_len(nor);
>> +       loff_t rstart, rofs;
>> +       unsigned int region;
>> +       size_t len;
>> +       int ret;
>> +
>> +       if (ofs < 0 || ofs >= spi_nor_otp_size(nor))
>> +               return 0;
>> +
>> +       ret = spi_nor_lock_and_prep(nor);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* don't access beyond the end */
>> +       total_len = min_t(size_t, total_len, spi_nor_otp_size(nor) - 
>> ofs);
>> +
>> +       *retlen = 0;
>> +       while (total_len) {
>> +               /*
>> +                * The OTP regions are mapped into a contiguous area 
>> starting
>> +                * at 0 as expected by the MTD layer. This will map 
>> the MTD
>> +                * file offsets to the address of an OTP region as 
>> used in the
>> +                * actual SPI commands.
>> +                */
>> +               region = spi_nor_otp_offset_to_region(nor, ofs);
>> +               rstart = spi_nor_otp_region_start(nor, region);
> 
> Maybe it's just me, but I don't like the helpers :).
> Especially spi_nor_otp_offset_to_region.

Ha, I actually had this open coded. But in the end, I wanted to
keep the translation from MTD offsets to OTP offsets in one place.
That is spi_nor_otp_region_to_offset() and 
spi_nor_otp_offset_to_region().

> And spi_nor_otp_region_start()
> is used just here. Maybe discard them and s/region/i?

I'm not sure what you mean by use i? Here is no for loop.
And regarding the helper, it is used in 4/4 again. So it is
quite handy ;)

>> +
>> +               /*
>> +                * The size of a OTP region is expected to be a power 
>> of two,
>> +                * thus we can just mask the lower bits and get the 
>> offset into
>> +                * a region.
>> +                */
>> +               rofs = ofs & (rlen - 1);
>> +
>> +               /* don't access beyond one OTP region */
>> +               len = min_t(size_t, total_len, rlen - rofs);
>> +
>> +               if (is_write)
>> +                       ret = ops->write(nor, rstart + rofs, len, 
>> buf);
>> +               else
>> +                       ret = ops->read(nor, rstart + rofs, len, buf);
>> +               if (ret == 0)
>> +                       ret = -EIO;
>> +               if (ret < 0)
>> +                       goto out;
>> +
>> +               *retlen += ret;
>> +               ofs += ret;
>> +               buf += ret;
>> +               total_len -= ret;
>> +       }
>> +       ret = 0;
>> +
>> +out:
>> +       spi_nor_unlock_and_unprep(nor);
>> +       return ret;
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
>> +       const struct spi_nor_otp_ops *ops = spi_nor_otp_ops(nor);
>> +       unsigned int region;
>> +       int ret;
>> +
>> +       if (from < 0 || (from + len) > spi_nor_otp_size(nor))
>> +               return -EINVAL;
>> +
>> +       /* the user has to explicitly ask for whole regions */
>> +       if (len % spi_nor_otp_region_len(nor))
>> +               return -EINVAL;
>> +
>> +       if (from % spi_nor_otp_region_len(nor))
>> +               return -EINVAL;
>> +
>> +       ret = spi_nor_lock_and_prep(nor);
>> +       if (ret)
>> +               return ret;
>> +
>> +       while (len) {
>> +               region = spi_nor_otp_offset_to_region(nor, from);
>> +               ret = ops->lock(nor, region);
>> +               if (ret)
>> +                       goto out;
>> +
>> +               len -= spi_nor_otp_region_len(nor);
>> +               from += spi_nor_otp_region_len(nor);
>> +       }
>> +
>> +out:
>> +       spi_nor_unlock_and_unprep(nor);
>> +
>> +       return ret;
>> +}
>> +
>> +void spi_nor_otp_init(struct spi_nor *nor)
>> +{
>> +       struct mtd_info *mtd = &nor->mtd;
>> +
>> +       if (!nor->params->otp.ops)
>> +               return;
>> +
>> +       if (WARN_ON(!is_power_of_2(spi_nor_otp_region_len(nor))))
> 
> Why WARN_ON and not just a debug message?

Because it really is a programming error, but I don't want to use
BUG_ON(). That is, the developer has either used a OTP_INFO() wrong
or he wants to add a flash which isn't yet supported. I don't see
a reason to "hide" that behind a debug message. It just depends
on the static OTP configuration and can't change at runtime.

-michael
