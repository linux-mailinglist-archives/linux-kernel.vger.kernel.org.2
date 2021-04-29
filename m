Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E2B36ED93
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbhD2Pr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:47:27 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:51789 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhD2PrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:47:25 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 380082226E;
        Thu, 29 Apr 2021 17:46:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619711196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=apqOvtdROCdFE2hHJqMrA9fP9E6tUl9T38xewx2r7fM=;
        b=bNt571yoyNSvca/gE7YzhRaW01w4kAD1V7xNQdxnuVVrswjahXtxkVh9w0R2YHcIfwUJHy
        SnAuDRRHMgkz5LzcW+lvuaWfNbD2iykg5cuPqWls87Nuq+n5NOb8m7yu3x9KJroV91ngYa
        YRMJkDiGJSRq/7IFp1SnpJSpo4v9qHg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Apr 2021 17:46:36 +0200
From:   Michael Walle <michael@walle.cc>
To:     Alexander Williams <awill@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, p.yadav@ti.com, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH 2/2] mtd: spi-nor: add initial sysfs support
In-Reply-To: <20210429153725.15970-1-awill@google.com>
References: <20210318092406.5340-3-michael@walle.cc>
 <20210429153725.15970-1-awill@google.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <9b0f13aba55e1a25054303dd1dc719eb@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Am 2021-04-29 17:37, schrieb Alexander Williams:
> Hi Michael,
> 
>> On Thu, Mar 18, 2021 at 10:24 AM Michael Walle <michael@walle.cc>
>> wrote:
>> Add support to show the name and JEDEC identifier as well as to dump 
>> the
>> SFDP table. Not all flashes list their SFDP table contents in their
>> datasheet. So having that is useful. It might also be helpful in bug
>> reports from users.
>> 
>> The idea behind the sysfs module is also to have raw access to the SPI
>> NOR flash device registers, which can also be useful for debugging.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/mtd/spi-nor/Makefile |  2 +-
>>  drivers/mtd/spi-nor/core.c   |  5 +++
>>  drivers/mtd/spi-nor/core.h   |  3 ++
>>  drivers/mtd/spi-nor/sysfs.c  | 86 
>> ++++++++++++++++++++++++++++++++++++
>>  4 files changed, 95 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/mtd/spi-nor/sysfs.c
>> 
>> diff --git a/drivers/mtd/spi-nor/Makefile 
>> b/drivers/mtd/spi-nor/Makefile
>> index 653923896205..aff308f75987 100644
>> --- a/drivers/mtd/spi-nor/Makefile
>> +++ b/drivers/mtd/spi-nor/Makefile
>> @@ -1,6 +1,6 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> 
>> -spi-nor-objs			:= core.o sfdp.o
>> +spi-nor-objs			:= core.o sfdp.o sysfs.o
>>  spi-nor-objs			+= atmel.o
>>  spi-nor-objs			+= catalyst.o
>>  spi-nor-objs			+= eon.o
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 4a315cb1c4db..2eaf4ba8c0f3 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -3707,6 +3707,10 @@ static int spi_nor_probe(struct spi_mem 
>> *spimem)
>>  	if (ret)
>>  		return ret;
>> 
>> +	ret = spi_nor_sysfs_create(nor);
> 
> This appears to be racing with user space. By the time we reach 
> probe(), the
> device embedded in the spi_device has already been registered, with the 
> uevent
> sent out, right? udev may not see the new attributes created here.
> 
> Since we reuse a preexisting device throughout spi-nor, it seems 
> awfully
> challenging to be able to safely add sysfs attributes. Would it make 
> sense to
> create a spi-nor-specific device/class? Or perhaps attach these 
> attributes to
> the device in mtd_info like I've done in
> https://lore.kernel.org/linux-mtd/20210428052725.530939-1-awill@google.com/ 
> ?

Do you encounter this problem? I'm currently working on this and dropped
the sysfs_create() and use dev_groups of the driver spi nor driver.

But I'm not sure how it will be handled anyway. Because we know the
content/size SFDP only after the probe and in any case the probe could
also fail. So I don't really understand how that is handled.

I've looked at your patch and it seems that the surpress_uevent() is
rarely used in the kernel.

I don't want to attach it to an MTD device because you might have
multiple ones which has the same SPI flash device as parent. The
SFDP is really a property of the flash device and not one of the
MTD partition.

-michael
