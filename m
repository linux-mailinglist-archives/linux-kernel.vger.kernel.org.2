Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AFE342F33
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 20:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhCTTR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 15:17:29 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:33433 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCTTRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 15:17:25 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DA6E922238;
        Sat, 20 Mar 2021 20:17:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616267844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=btr13Yp+4POSyeTxRd5R5ehu+2XAC6Qyi7g35AeUOa4=;
        b=TgwNGqO6gPJf0+cIgj6ExhDbg+IgTiQKZy2Z/SXP8utb6hFdLYuB/1Fp/5uX1txXnV9cZH
        QtjtsY0uX0fepunadRdKwA6bTlOp3Qlwj1Q8+RgN66Ubis4vOx+r4aO2VvfenJXvZnYnKJ
        JYgPtelBQ1tplzK2ErqWBC43SN3Yxtk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 20 Mar 2021 20:17:23 +0100
From:   Michael Walle <michael@walle.cc>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 2/2] mtd: spi-nor: add initial sysfs support
In-Reply-To: <925fb92b-39da-ebc5-c0ac-6dba02628956@hisilicon.com>
References: <20210318092406.5340-1-michael@walle.cc>
 <20210318092406.5340-3-michael@walle.cc>
 <925fb92b-39da-ebc5-c0ac-6dba02628956@hisilicon.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <94797376448f4a276dea8489b2ac9e44@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicong,

Am 2021-03-20 05:16, schrieb Yicong Yang:
> On 2021/3/18 17:24, Michael Walle wrote:
>> Add support to show the name and JEDEC identifier as well as to dump 
>> the
>> SFDP table. Not all flashes list their SFDP table contents in their
>> datasheet. So having that is useful. It might also be helpful in bug
>> reports from users.
>> 
>> The idea behind the sysfs module is also to have raw access to the SPI
>> NOR flash device registers, which can also be useful for debugging.
> 
> I like the idea to dump the sfdp data,it will make debug easier.
> should it go in debugfs?
> we already have debugfs files for partname and partid of the flash.

I've seen that, but thats for the MTD subsystem and is per MTD. Well,
one could add an own debugfs for spi-nor, but I still fear it might
not be available just when its needed. Of course a developer can
easily enable it for its debugging kernel. But I'm not sure if thats
the only use case.

I'd guess it boils down to, whether there could also be tooling
around this. Eg. think of something like "lssfdp".

I'd prefer sysfs, but lets hear what the maintainers think.

[..]

>> +static ssize_t name_show(struct device *dev,
>> +			 struct device_attribute *attr, char *buf)
>> +{
>> +	struct spi_device *spi = to_spi_device(dev);
>> +	struct spi_mem *spimem = spi_get_drvdata(spi);
>> +	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
>> +
>> +	return sprintf(buf, "%s\n", nor->info->name);
> 
> perhaps sysfs_emit() instead if we go sysfs? as suggested by [1].

Thanks, didn't know about that new helper.

-michael
