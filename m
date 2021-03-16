Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FCA33D28F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbhCPLPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:15:31 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:35349 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhCPLPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:15:16 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E751E22238;
        Tue, 16 Mar 2021 12:15:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615893315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/VAnFTM2V5VZe+SHwr7s9BLyFf+rzEmoHeV5Jv7zDYM=;
        b=ST+Y4dMcfT1Difl7Y3AcFpiI0XvWZiES16XX4gu3eYqGXtPxsut/5/mKRZZTlnmJa7+ibX
        INmPzsdxeP1qcaHtvMrrC2eh8QyQuqrkm1T9/lVrX9XaXp/XID0BOdjNVntVBqOMSInX6n
        XHTui+kj89eIqFyeEPpbikG6HghZjM4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Mar 2021 12:15:14 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [RFC PATCH 2/3] mtd: spi-nor: sfdp: fix spi_nor_read_sfdp()
In-Reply-To: <20210316110400.kepjn6b654lhq4dy@ti.com>
References: <20210312190548.6954-1-michael@walle.cc>
 <20210312190548.6954-3-michael@walle.cc>
 <20210316110400.kepjn6b654lhq4dy@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <25579f51e4e0626ad96bcaf2f8015260@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-16 12:04, schrieb Pratyush Yadav:
> On 12/03/21 08:05PM, Michael Walle wrote:
>> If spi_nor_read_sfdp() is used after probe, we have to set read_proto
>> and the read dirmap.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/mtd/spi-nor/sfdp.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
>> index b1814afefc33..47634ec9b899 100644
>> --- a/drivers/mtd/spi-nor/sfdp.c
>> +++ b/drivers/mtd/spi-nor/sfdp.c
>> @@ -179,19 +179,27 @@ static int spi_nor_read_sfdp(struct spi_nor 
>> *nor, u32 addr,
>>  			     size_t len, void *buf)
>>  {
>>  	u8 addr_width, read_opcode, read_dummy;
>> +	struct spi_mem_dirmap_desc *rdesc;
>> +	enum spi_nor_protocol read_proto;
>>  	int ret;
>> 
>>  	read_opcode = nor->read_opcode;
>> +	read_proto = nor->read_proto;
>> +	rdesc = nor->dirmap.rdesc;
>>  	addr_width = nor->addr_width;
>>  	read_dummy = nor->read_dummy;
>> 
>>  	nor->read_opcode = SPINOR_OP_RDSFDP;
>> +	nor->read_proto = SNOR_PROTO_1_1_1;
>> +	nor->dirmap.rdesc = NULL;
>>  	nor->addr_width = 3;
>>  	nor->read_dummy = 8;
> 
> NACK. You can't assume the device is still in 1S-1S-1S mode after 
> probe.
> For example, the s28hs512t flash is switched to 8D-8D-8D mode by the
> time the probe finishes so this would be an invalid command. Same for
> any flash that goes into a stateful mode.

I see.

> And you can't even keep using nor->read_proto to read SFDP because the
> Read SFDP command might not be supported in all modes. xSPI spec
> (JESD251) says that the Read SFDP command is optional in 8D-8D-8D mode.
> 
> I think the best approach for this would be to cache the entire SFDP
> table at parse time. This obviously comes with a memory overhead but I
> don't think it would be too big. For example, the sfdp table on
> s28hs512t is 491 bytes and it has 6 tables. Anyway, if the memory usage
> is too much of a problem we can put the feature behind a config.

I don't like to have it a config option, because then, if you really
need it, i.e. some user has an unknown flash, it might not be there.

The next question would be, should I leave the current parsing code
as is or should I also change that to use the sftp data cache. I'd
prefer to leave it as is.

-michael
