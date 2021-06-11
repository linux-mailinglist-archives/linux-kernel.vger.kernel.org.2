Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D54F3A4453
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhFKOtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:49:10 -0400
Received: from router.aksignal.cz ([62.44.4.214]:41480 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhFKOtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:49:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 161A6484DF;
        Fri, 11 Jun 2021 16:47:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id Ne5tC4B7MD-f; Fri, 11 Jun 2021 16:47:08 +0200 (CEST)
Received: from [172.25.161.48] (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 4E52C484DE;
        Fri, 11 Jun 2021 16:47:08 +0200 (CEST)
Subject: Re: [PATCH] nvmem: eeprom: at25: fix type compiler warnings
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
References: <20210611142706.27336-1-jiri.prchal@aksignal.cz>
 <YMN29rIlPDCL0w3A@kroah.com>
From:   =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
Message-ID: <84769ab5-ff30-6c6a-8362-864bd069066d@aksignal.cz>
Date:   Fri, 11 Jun 2021 16:47:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMN29rIlPDCL0w3A@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11. 06. 21 16:45, Greg Kroah-Hartman wrote:
> On Fri, Jun 11, 2021 at 04:27:06PM +0200, Jiri Prchal wrote:
>> Fixes:
>> drivers/misc/eeprom/at25.c:181:28: warning: field width should have type 'int',
>> but argument has type 'unsigned long'
>>
>> drivers/misc/eeprom/at25.c:386:13: warning: cast to smaller integer type 'int'
>> from 'const void *'
>>
>> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>>   drivers/misc/eeprom/at25.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
>> index 6e26de68a001..744f7abb22ee 100644
>> --- a/drivers/misc/eeprom/at25.c
>> +++ b/drivers/misc/eeprom/at25.c
>> @@ -178,7 +178,7 @@ static ssize_t sernum_show(struct device *dev, struct device_attribute *attr, ch
>>   	struct at25_data *at25;
>>   
>>   	at25 = dev_get_drvdata(dev);
>> -	return sysfs_emit(buf, "%*ph\n", sizeof(at25->sernum), at25->sernum);
>> +	return sysfs_emit(buf, "%*ph\n", (int)sizeof(at25->sernum), at25->sernum);
>>   }
>>   static DEVICE_ATTR_RO(sernum);
>>   
>> @@ -379,11 +379,11 @@ static int at25_probe(struct spi_device *spi)
>>   	u8 sernum[FM25_SN_LEN];
>>   	int i;
>>   	const struct of_device_id *match;
>> -	int is_fram = 0;
>> +	unsigned long is_fram = 0;
>>   
>>   	match = of_match_device(of_match_ptr(at25_of_match), &spi->dev);
>>   	if (match)
>> -		is_fram = (int)match->data;
>> +		is_fram = (unsigned long)match->data;
>>   
>>   	/* Chip description */
>>   	if (!spi->dev.platform_data) {
>> -- 
>> 2.25.1
>>
> 
> Looks good, now queued up.

Thanks Greg for patience and guiding me...
Jiri
