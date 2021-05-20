Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A31389E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 08:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhETG6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 02:58:03 -0400
Received: from router.aksignal.cz ([62.44.4.214]:60886 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhETG6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 02:58:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id E376247F79;
        Thu, 20 May 2021 08:56:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id qgsJZ187gLUn; Thu, 20 May 2021 08:56:39 +0200 (CEST)
Received: from [172.25.162.36] (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 4ABF243DA9;
        Thu, 20 May 2021 08:56:39 +0200 (CEST)
From:   =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
Subject: Re: [PATCH v4 4/4] nvmem: eeprom: at25: export FRAM serial num
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210520054714.8736-1-jiri.prchal@aksignal.cz>
 <20210520054714.8736-5-jiri.prchal@aksignal.cz> <YKX5Iqm3AoCXsDV6@kroah.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Message-ID: <f0951762-8067-e353-f585-2cb17f7be134@aksignal.cz>
Date:   Thu, 20 May 2021 08:56:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKX5Iqm3AoCXsDV6@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: cs
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here I'm completlly lost:

On 20. 05. 21 7:52, Greg Kroah-Hartman wrote:
> On Thu, May 20, 2021 at 07:47:14AM +0200, Jiri Prchal wrote:
>> This exports serial number of FRAM in sysfs file named "sernum".
>> Formatted in hex, each byte separated by space.
>> Example:
>> $ cat /sys/class/spi_master/spi0/spi0.0/sernum
> 
> No new Documentation/ABI/ entry for this?
No, should I do and how / where?

>> +static ssize_t sernum_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct at25_data *at25;
>> +	int i;
>> +
>> +	at25 = dev_get_drvdata(dev);
>> +	for (i = 0; i < FM25_SN_LEN; i++)
>> +		buf += sprintf(buf, "%02x ", at25->sernum[i]);
>> +	sprintf(--buf, "\n");
>> +	return (3 * i);
> 
> No, that is not how sysfs files work, sorry.  They are "one value per
> file".  This looks like multiple values in the same file, why not just
> one file per "sernum"?
It's formatted by spaces. It's one long number like MAC addr, so is 
better to expose it as hex string without spaces? Or like MAC separated 
by colon?

> 
> Also, please use sysfs_emit() in the future.
Will do...

> 
> 
> 
>> +}
>> +static DEVICE_ATTR_RO(sernum);
>> +
>>   static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
>>   {
>>   	struct at25_data *at25 = priv;
>> @@ -427,8 +441,13 @@ static int at25_probe(struct spi_device *spi)
>>   		else
>>   			at25->chip.flags |= EE_ADDR2;
>>
>> -		if (id[8])
>> +		if (id[8]) {
>>   			at25->has_sernum = 1;
>> +			at25->sernum = kzalloc(FM25_SN_LEN, GFP_KERNEL);
>> +			if (!at25->sernum)
>> +				return -ENOMEM;
>> +			fm25_aux_read(at25, at25->sernum, FM25_RDSN, FM25_SN_LEN);
>> +		}
>>   		else
>>   			at25->has_sernum = 0;
>>
>> @@ -467,6 +486,13 @@ static int at25_probe(struct spi_device *spi)
>>   	if (IS_ERR(at25->nvmem))
>>   		return PTR_ERR(at25->nvmem);
>>
>> +	/* Export the FM25 serial number */
>> +	if (at25->has_sernum) {
>> +		err = device_create_file(&spi->dev, &dev_attr_sernum);
> 
> You just raced with userspace and lost :(
?
> 
> Please do this correctly, by setting the driver group if you need a file
> like this.
Any example, please?
> 
> thanks,
> 
> greg k-h
> 
thanks
Jiri
