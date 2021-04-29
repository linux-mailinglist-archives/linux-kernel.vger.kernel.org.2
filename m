Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB1636EE56
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 18:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbhD2Qp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 12:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhD2Qp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 12:45:27 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F4CC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 09:44:40 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 70FBA2224D;
        Thu, 29 Apr 2021 18:44:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619714678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lOnX55mTU7vLL2DHd0LKX5pk2bsXFmUc1Ibom8J1lfI=;
        b=CcpbZ/rOaxtfl/zF/iR0A5KY0G00xotJ3hiJn2IKgCBkyUcrmgaaZxVR6FJ7GQW0C5hulI
        bqMwT4kRo4D6psH4UBHaTNJjCSEc/S/QoDcF4er8GB0dyYpOh23BS5PmouFvUWdWi7jgpN
        TxF/ft3NxxNRxZKXdNmKLQve6HB1Npk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Apr 2021 18:44:38 +0200
From:   Michael Walle <michael@walle.cc>
To:     Alexander Williams <awill@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiko Thiery <heiko.thiery@gmail.com>
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: add initial sysfs support
In-Reply-To: <CACqsJN8mrHUB9Ls3PG5R_B84+xUjf-2VakA=09mP_bodWnUgmw@mail.gmail.com>
References: <20210429155713.28808-1-michael@walle.cc>
 <20210429155713.28808-3-michael@walle.cc>
 <CACqsJN8mrHUB9Ls3PG5R_B84+xUjf-2VakA=09mP_bodWnUgmw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <04bc3eda0fa5a84ffff4b2f05721e2ac@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Am 2021-04-29 18:23, schrieb Alexander Williams:
> On Thu, Apr 29, 2021 at 8:57 AM Michael Walle <michael@walle.cc> wrote:
>> 
>> Add support to show the manufacturer, the partname and JEDEC 
>> identifier
>> as well as to dump the SFDP table. Not all flashes list their SFDP 
>> table
>> contents in their datasheet. So having that is useful. It might also 
>> be
>> helpful in bug reports from users.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> Pratyush, Heiko, I've dropped your Acked and Tested-by because there
>> were some changes.
>> 
>>  .../ABI/testing/sysfs-bus-spi-devices-spi-nor | 31 +++++++
>>  drivers/mtd/spi-nor/Makefile                  |  2 +-
>>  drivers/mtd/spi-nor/core.c                    |  1 +
>>  drivers/mtd/spi-nor/core.h                    |  2 +
>>  drivers/mtd/spi-nor/sysfs.c                   | 92 
>> +++++++++++++++++++
>>  5 files changed, 127 insertions(+), 1 deletion(-)
>>  create mode 100644 
>> Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
>>  create mode 100644 drivers/mtd/spi-nor/sysfs.c
>> 
>> diff --git a/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor 
>> b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
>> new file mode 100644
>> index 000000000000..4c88307759e2
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
>> @@ -0,0 +1,31 @@
>> +What:          /sys/bus/spi/devices/.../jedec_id
>> +Date:          April 2021
>> +KernelVersion: 5.14
>> +Contact:       linux-mtd@lists.infradead.org
>> +Description:   (RO) The JEDEC ID of the SPI NOR flash as reported by 
>> the
>> +               flash device.
>> +
>> +
>> +What:          /sys/bus/spi/devices/.../manufacturer
>> +Date:          April 2021
>> +KernelVersion: 5.14
>> +Contact:       linux-mtd@lists.infradead.org
>> +Description:   (RO) Manufacturer of the SPI NOR flash.
>> +
>> +
>> +What:          /sys/bus/spi/devices/.../partname
>> +Date:          April 2021
>> +KernelVersion: 5.14
>> +Contact:       linux-mtd@lists.infradead.org
>> +Description:   (RO) Part name of the SPI NOR flash.
>> +
>> +
>> +What:          /sys/bus/spi/devices/.../sfdp
>> +Date:          April 2021
>> +KernelVersion: 5.14
>> +Contact:       linux-mtd@lists.infradead.org
>> +Description:   (RO) This attribute is only present if the SPI NOR 
>> flash
>> +               device supports the "Read SFDP" command (5Ah).
>> +
>> +               If present, it contains the complete SFDP (serial 
>> flash
>> +               discoverable parameters) binary data of the flash.
>> diff --git a/drivers/mtd/spi-nor/Makefile 
>> b/drivers/mtd/spi-nor/Makefile
>> index 136f245c91dc..6b904e439372 100644
>> --- a/drivers/mtd/spi-nor/Makefile
>> +++ b/drivers/mtd/spi-nor/Makefile
>> @@ -1,6 +1,6 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> 
>> -spi-nor-objs                   := core.o sfdp.o swp.o otp.o
>> +spi-nor-objs                   := core.o sfdp.o swp.o otp.o sysfs.o
>>  spi-nor-objs                   += atmel.o
>>  spi-nor-objs                   += catalyst.o
>>  spi-nor-objs                   += eon.o
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 20c7ee604731..57d8a4dae5fd 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -3349,6 +3349,7 @@ static struct spi_mem_driver spi_nor_driver = {
>>                 .driver = {
>>                         .name = "spi-nor",
>>                         .of_match_table = spi_nor_of_table,
>> +                       .dev_groups = spi_nor_sysfs_groups,
> 
> Putting these in the driver's dev_groups does create a divergence 
> between
> different spi-nor controllers. For all the controllers supported in
> drivers/mtd/spi-nor/controllers/, would their drivers need to add the 
> same sysfs
> groups to get the same support?

Well, one supports it and one does not, no? If support is added later,
we should keep an eye on it. Unfortunately, I don't have any hardware
to see if just adding the .dev_groups to another driver will just work.

-michael
