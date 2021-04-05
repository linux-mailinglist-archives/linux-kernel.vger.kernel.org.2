Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9203835440A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbhDEQDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:03:49 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:34313 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241868AbhDEQDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:03:48 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CA0DD22205;
        Mon,  5 Apr 2021 18:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1617638621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ZfqeNGyzqUDKZMxr8tUac4KbrzJTM57ysOqdQMXrOA=;
        b=Rwroboqc7+ROi893umJeMMCBBHp6rOn0jaS5KkgXRV/HMdtSvJcGxXSnDrMFwrS1u9b9Aw
        JqkBcM7MXv6R1FOfJR3UM+AzFBBExH9nBVwLQ0rZemU55+kwGULArGdAJGyhj6knRIV7hP
        p2298NNvnzl9MikQ34qS90NdMxJcfjo=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 05 Apr 2021 18:03:40 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Subject: Re: [PATCH 1/2] mtd: spi-nor: sfdp: save a copy of the SFDP data
In-Reply-To: <d14cbc96-43ab-8f1e-82e6-e1999a1972c5@microchip.com>
References: <20210318092406.5340-1-michael@walle.cc>
 <20210318092406.5340-2-michael@walle.cc>
 <e28e7cd3-9728-3428-1bae-9cda258174bc@microchip.com>
 <5359aa6ade80ff6d39e969c3be2957dd@walle.cc>
 <d14cbc96-43ab-8f1e-82e6-e1999a1972c5@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <50f2c48caea79df169f38f7345fd405f@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-04-05 17:42, schrieb Tudor.Ambarus@microchip.com:
> On 4/5/21 6:07 PM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Hi,
>> 
>> Am 2021-04-05 15:11, schrieb Tudor.Ambarus@microchip.com:
>>> On 3/18/21 11:24 AM, Michael Walle wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you 
>>>> know
>>>> the content is safe
>>>> 
>>>> Due to possible mode switching to 8D-8D-8D, it might not be possible
>>>> to
>>>> read the SFDP after the initial probe. To be able to dump the SFDP 
>>>> via
>>>> sysfs afterwards, make a complete copy of it.
>>>> 
>>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>>> ---
>>>>  drivers/mtd/spi-nor/core.h  | 10 ++++++++
>>>>  drivers/mtd/spi-nor/sfdp.c  | 49
>>>> +++++++++++++++++++++++++++++++++++++
>>>>  include/linux/mtd/spi-nor.h |  3 +++
>>>>  3 files changed, 62 insertions(+)
>>>> 
>>>> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
>>>> index 4a3f7f150b5d..668f22011b1d 100644
>>>> --- a/drivers/mtd/spi-nor/core.h
>>>> +++ b/drivers/mtd/spi-nor/core.h
>>>> @@ -407,6 +407,16 @@ struct spi_nor_manufacturer {
>>>>         const struct spi_nor_fixups *fixups;
>>>>  };
>>>> 
>>>> +/**
>>>> + * struct sfdp - SFDP data
>>>> + * @num_dwords: number of entries in the dwords array
>>>> + * @dwords: array of double words of the SFDP data
>>>> + */
>>>> +struct sfdp {
>>>> +       size_t  num_dwords;
>>>> +       u32     *dwords;
>>>> +};
>>>> +
>>>>  /* Manufacturer drivers. */
>>>>  extern const struct spi_nor_manufacturer spi_nor_atmel;
>>>>  extern const struct spi_nor_manufacturer spi_nor_catalyst;
>>>> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
>>>> index 25142ec4737b..2b6c96e02532 100644
>>>> --- a/drivers/mtd/spi-nor/sfdp.c
>>>> +++ b/drivers/mtd/spi-nor/sfdp.c
>>>> @@ -16,6 +16,7 @@
>>>>         (((p)->parameter_table_pointer[2] << 16) | \
>>>>          ((p)->parameter_table_pointer[1] <<  8) | \
>>>>          ((p)->parameter_table_pointer[0] <<  0))
>>>> +#define SFDP_PARAM_HEADER_PARAM_LEN(p) ((p)->length * 4)
>>>> 
>>>>  #define SFDP_BFPT_ID           0xff00  /* Basic Flash Parameter 
>>>> Table
>>>> */
>>>>  #define SFDP_SECTOR_MAP_ID     0xff81  /* Sector Map Table */
>>>> @@ -1263,6 +1264,8 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
>>>>         struct sfdp_parameter_header *param_headers = NULL;
>>>>         struct sfdp_header header;
>>>>         struct device *dev = nor->dev;
>>>> +       struct sfdp *sfdp;
>>>> +       size_t sfdp_size;
>>>>         size_t psize;
>>>>         int i, err;
>>>> 
>>>> @@ -1285,6 +1288,9 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
>>>>             bfpt_header->major != SFDP_JESD216_MAJOR)
>>>>                 return -EINVAL;
>>>> 
>>>> +       sfdp_size = SFDP_PARAM_HEADER_PTP(bfpt_header) +
>>>> +                   SFDP_PARAM_HEADER_PARAM_LEN(bfpt_header);
>>>> +
>>>>         /*
>>>>          * Allocate memory then read all parameter headers with a
>>>> single
>>>>          * Read SFDP command. These parameter headers will actually 
>>>> be
>>>> parsed
>>>> @@ -1311,6 +1317,49 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
>>>>                 }
>>>>         }
>>>> 
>>>> +       /*
>>>> +        * Cache the complete SFDP data. It is not (easily) possible
>>>> to fetch
>>>> +        * SFDP after probe time and we need it for the sysfs 
>>>> access.
>>>> +        */
>>>> +       for (i = 0; i < header.nph; i++) {
>>>> +               param_header = &param_headers[i];
>>>> +               sfdp_size = max_t(size_t, sfdp_size,
>>>> +                                 
>>>> SFDP_PARAM_HEADER_PTP(param_header)
>>>> +
>>>> +
>>>> SFDP_PARAM_HEADER_PARAM_LEN(param_header));
>>>> +       }
>>> 
>>> Michael, I like the idea of saving the SFDP data, but I think this 
>>> can
>>> be
>>> improved a little. For example, it is not mandatory for the tables to
>>> be
>>> continuous in memory, there can be some gaps between BFPT and SMPT 
>>> for
>>> example,
>>> thus we can improve the memory allocation logic.
>> 
>> I want to parse the SFDP as little as possible. Keep in mind, that 
>> this
>> should
>> help to debug SFDP (errors). Therefore, I don't want to rely on the 
>> SFDP
>> saying
>> "hey there is a hole, please skip it". Who knows if there is some 
>> useful
>> data?
> 
> What kind of useful data? Do we care about data that doesn't follow the 
> jesd216
> standard?

Yes because, it should be a raw dump of the SFDP data (of whatever
the flash vendor thinks is valid). You want to be able to debug
non-compliant SFDP data. Otherwise, this doesn't make any sense to
have it in the first place.

>>> Also, we can make the saved sfdp
>>> data table-agnostic so that we don't duplicate the reads in
>>> parse_bfpt/smpt/4bait.
>> 
>> This falls into the same category as above. While it might be reused,
>> the
>> primary use case is to have the SFDP data available to a 
>> developer/user.
>> Eg.
>> what will you do with some holes in the sysfs read()? Return zeros?
> 
> We don't have to have gaps in our internal buffer, we just allocate as 
> much
> as we need and we write into our internal buffer just the sfdp tables, 
> without
> the gaps.

There are two use cases:
  (1) cache the data for the SFDP table parsing
  (2) provide a raw dump of the SFDP

This patch targets (2). So first, you'd need to allocate multiple
buffers, then you'd have to combine them again for the raw SFDP dump
and finally you'd need to fill the gaps for the dump again. Because
what I expect is to have a contiguous "sfdp" sysfs file.

-michael
