Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CCF33D25B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbhCPLB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:01:58 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:56157 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbhCPLBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:01:23 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 71D4122238;
        Tue, 16 Mar 2021 12:01:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615892481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WBKI5HqpKGD/CDbdtKBZ6BpnHmwmYnhqrgtw6eCylnw=;
        b=Zb02Wr8c797LE+nu+kZ+tgi/grN+PLND2cXVZzd3yA+U4f2w+ErJFzbRfoftlJINrUWz/8
        9RarBnws8jtYLnxE81djCexekw5vMVCo/5YBljGEF+mlWq3DDgnYmfAok0GCVB+Cfa1UGh
        K/JUZ2vNG6H5zo8JvqVAn6EyaLtsfhk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Mar 2021 12:01:21 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [RFC PATCH 1/3] mtd: spi-nor: sfdp: remember sfdp_size
In-Reply-To: <20210316104223.42tdob3uwjxc5vdz@ti.com>
References: <20210312190548.6954-1-michael@walle.cc>
 <20210312190548.6954-2-michael@walle.cc>
 <20210316104223.42tdob3uwjxc5vdz@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <065642fa4d4282d3d16e1d4f4c176ce8@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

Am 2021-03-16 11:42, schrieb Pratyush Yadav:
> On 12/03/21 08:05PM, Michael Walle wrote:
>> Save the sftp_size in the spi_nor struct so we can use it to dump the
>> SFDP table without parsing the headers again.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/mtd/spi-nor/sfdp.c  | 12 ++++++++++++
>>  include/linux/mtd/spi-nor.h |  1 +
>>  2 files changed, 13 insertions(+)
>> 
>> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
>> index 25142ec4737b..b1814afefc33 100644
>> --- a/drivers/mtd/spi-nor/sfdp.c
>> +++ b/drivers/mtd/spi-nor/sfdp.c
>> @@ -16,6 +16,7 @@
>>  	(((p)->parameter_table_pointer[2] << 16) | \
>>  	 ((p)->parameter_table_pointer[1] <<  8) | \
>>  	 ((p)->parameter_table_pointer[0] <<  0))
>> +#define SFDP_PARAM_HEADER_PARAM_LEN(p) ((p)->length * 4)
>> 
>>  #define SFDP_BFPT_ID		0xff00	/* Basic Flash Parameter Table */
>>  #define SFDP_SECTOR_MAP_ID	0xff81	/* Sector Map Table */
>> @@ -1263,6 +1264,7 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
>>  	struct sfdp_parameter_header *param_headers = NULL;
>>  	struct sfdp_header header;
>>  	struct device *dev = nor->dev;
>> +	size_t param_max_offset;
>>  	size_t psize;
>>  	int i, err;
>> 
>> @@ -1285,6 +1287,9 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
>>  	    bfpt_header->major != SFDP_JESD216_MAJOR)
>>  		return -EINVAL;
>> 
>> +	nor->sfdp_size = SFDP_PARAM_HEADER_PTP(bfpt_header) +
>> +			 SFDP_PARAM_HEADER_PARAM_LEN(bfpt_header);
>> +
>>  	/*
>>  	 * Allocate memory then read all parameter headers with a single
>>  	 * Read SFDP command. These parameter headers will actually be 
>> parsed
>> @@ -1311,6 +1316,13 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
>>  		}
>>  	}
>> 
>> +	for (i = 0; i < header.nph; i++) {
>> +		param_header = &param_headers[i];
>> +		param_max_offset = SFDP_PARAM_HEADER_PTP(param_header) +
>> +				   SFDP_PARAM_HEADER_PARAM_LEN(param_header);
>> +		nor->sfdp_size = max(nor->sfdp_size, param_max_offset);
>> +	}
>> +
> 
> I don't see any mention in the SFDP spec (JESD216D-01) that parameter
> tables have to be contiguous.

ch. 6.1, fig.10 looks like all the headers come after the initial SFDP
header. If that wasn't the case, how would you find the headers then?

Also ch. 6.3
"""All subsequent parameter headers need to be contiguous and may be
specified..."""

> In fact, it says that "Parameter tables
> may be located anywhere in the SFDP space. They do not need to
> immediately follow the parameter headers".

The tables itself, yes, but not the headers for the tables.

> But I guess we can just say
> the sysfs entry exports the entire SFDP space instead of just the 
> tables
> so that is OK.
> 
> This patch looks good to me other than the small nitpick that we can
> merge this loop and the one below that tries to find the latest BFPT
> version.

btw. I've also added an export for the jedec id and the flash name to
this patch, which will be included in the next version.

>>  	/*
>>  	 * Check other parameter headers to get the latest revision of
>>  	 * the basic flash parameter table.
>> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
>> index a0d572855444..a58118b8b002 100644
>> --- a/include/linux/mtd/spi-nor.h
>> +++ b/include/linux/mtd/spi-nor.h
>> @@ -404,6 +404,7 @@ struct spi_nor {
>>  	bool			sst_write_second;
>>  	u32			flags;
>>  	enum spi_nor_cmd_ext	cmd_ext_type;
>> +	size_t			sfdp_size;
> 
> Documentation for this variable missing.
> 
>> 
>>  	const struct spi_nor_controller_ops *controller_ops;
>> 
>> --
>> 2.20.1
>> 

-- 
-michael
