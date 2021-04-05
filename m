Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0221535432A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 17:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241444AbhDEPIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 11:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbhDEPH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 11:07:59 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF95C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 08:07:48 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2431722205;
        Mon,  5 Apr 2021 17:07:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1617635263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dkzk/XuxAoT4NuqBOZKEIzbWMyV0vN0c27tlDqeS7k4=;
        b=UGXUJ9DWxlscAmuyflJXLDFekQainDg/YiAD84/cT4fpWR9Ps+mrcjUMpwAjk0iKEjmAkb
        EBd/SVKXee7My08W37WEd1UuT3jrDwjbey/p9BVQOTqePbj3VzYyssdqcHg44Vrp/JpuQE
        yK33FyyJ1NcmlY8jvN3BpqV8I/qHoJI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 05 Apr 2021 17:07:42 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Subject: Re: [PATCH 1/2] mtd: spi-nor: sfdp: save a copy of the SFDP data
In-Reply-To: <e28e7cd3-9728-3428-1bae-9cda258174bc@microchip.com>
References: <20210318092406.5340-1-michael@walle.cc>
 <20210318092406.5340-2-michael@walle.cc>
 <e28e7cd3-9728-3428-1bae-9cda258174bc@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <5359aa6ade80ff6d39e969c3be2957dd@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2021-04-05 15:11, schrieb Tudor.Ambarus@microchip.com:
> On 3/18/21 11:24 AM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Due to possible mode switching to 8D-8D-8D, it might not be possible 
>> to
>> read the SFDP after the initial probe. To be able to dump the SFDP via
>> sysfs afterwards, make a complete copy of it.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/mtd/spi-nor/core.h  | 10 ++++++++
>>  drivers/mtd/spi-nor/sfdp.c  | 49 
>> +++++++++++++++++++++++++++++++++++++
>>  include/linux/mtd/spi-nor.h |  3 +++
>>  3 files changed, 62 insertions(+)
>> 
>> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
>> index 4a3f7f150b5d..668f22011b1d 100644
>> --- a/drivers/mtd/spi-nor/core.h
>> +++ b/drivers/mtd/spi-nor/core.h
>> @@ -407,6 +407,16 @@ struct spi_nor_manufacturer {
>>         const struct spi_nor_fixups *fixups;
>>  };
>> 
>> +/**
>> + * struct sfdp - SFDP data
>> + * @num_dwords: number of entries in the dwords array
>> + * @dwords: array of double words of the SFDP data
>> + */
>> +struct sfdp {
>> +       size_t  num_dwords;
>> +       u32     *dwords;
>> +};
>> +
>>  /* Manufacturer drivers. */
>>  extern const struct spi_nor_manufacturer spi_nor_atmel;
>>  extern const struct spi_nor_manufacturer spi_nor_catalyst;
>> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
>> index 25142ec4737b..2b6c96e02532 100644
>> --- a/drivers/mtd/spi-nor/sfdp.c
>> +++ b/drivers/mtd/spi-nor/sfdp.c
>> @@ -16,6 +16,7 @@
>>         (((p)->parameter_table_pointer[2] << 16) | \
>>          ((p)->parameter_table_pointer[1] <<  8) | \
>>          ((p)->parameter_table_pointer[0] <<  0))
>> +#define SFDP_PARAM_HEADER_PARAM_LEN(p) ((p)->length * 4)
>> 
>>  #define SFDP_BFPT_ID           0xff00  /* Basic Flash Parameter Table 
>> */
>>  #define SFDP_SECTOR_MAP_ID     0xff81  /* Sector Map Table */
>> @@ -1263,6 +1264,8 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
>>         struct sfdp_parameter_header *param_headers = NULL;
>>         struct sfdp_header header;
>>         struct device *dev = nor->dev;
>> +       struct sfdp *sfdp;
>> +       size_t sfdp_size;
>>         size_t psize;
>>         int i, err;
>> 
>> @@ -1285,6 +1288,9 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
>>             bfpt_header->major != SFDP_JESD216_MAJOR)
>>                 return -EINVAL;
>> 
>> +       sfdp_size = SFDP_PARAM_HEADER_PTP(bfpt_header) +
>> +                   SFDP_PARAM_HEADER_PARAM_LEN(bfpt_header);
>> +
>>         /*
>>          * Allocate memory then read all parameter headers with a 
>> single
>>          * Read SFDP command. These parameter headers will actually be 
>> parsed
>> @@ -1311,6 +1317,49 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
>>                 }
>>         }
>> 
>> +       /*
>> +        * Cache the complete SFDP data. It is not (easily) possible 
>> to fetch
>> +        * SFDP after probe time and we need it for the sysfs access.
>> +        */
>> +       for (i = 0; i < header.nph; i++) {
>> +               param_header = &param_headers[i];
>> +               sfdp_size = max_t(size_t, sfdp_size,
>> +                                 SFDP_PARAM_HEADER_PTP(param_header) 
>> +
>> +                                 
>> SFDP_PARAM_HEADER_PARAM_LEN(param_header));
>> +       }
> 
> Michael, I like the idea of saving the SFDP data, but I think this can 
> be
> improved a little. For example, it is not mandatory for the tables to 
> be
> continuous in memory, there can be some gaps between BFPT and SMPT for 
> example,
> thus we can improve the memory allocation logic.

I want to parse the SFDP as little as possible. Keep in mind, that this 
should
help to debug SFDP (errors). Therefore, I don't want to rely on the SFDP 
saying
"hey there is a hole, please skip it". Who knows if there is some useful 
data?

> Also, we can make the saved sfdp
> data table-agnostic so that we don't duplicate the reads in
> parse_bfpt/smpt/4bait.

This falls into the same category as above. While it might be reused, 
the
primary use case is to have the SFDP data available to a developer/user. 
Eg.
what will you do with some holes in the sysfs read()? Return zeros?

FWIW I'm planning to refactor the read code so the cached values are 
used.

-michael
