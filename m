Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD6A39F315
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhFHJ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:59:03 -0400
Received: from router.aksignal.cz ([62.44.4.214]:59732 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhFHJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:59:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id BE08640F98;
        Tue,  8 Jun 2021 11:57:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id aN8x4IOG1YVK; Tue,  8 Jun 2021 11:57:05 +0200 (CEST)
Received: from [172.25.161.48] (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 2FB0D40F93;
        Tue,  8 Jun 2021 11:57:05 +0200 (CEST)
Subject: Re: [PATCH v8 2/5] nvmem: eeprom: at25: add support for FRAM
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
References: <20210607161201.223697-1-jiri.prchal@aksignal.cz>
 <20210607161201.223697-3-jiri.prchal@aksignal.cz>
 <YL8zZraFXTvGr3dE@kroah.com>
From:   =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
Message-ID: <cc57eb8a-bfd6-f314-b408-0c4c8fe01a03@aksignal.cz>
Date:   Tue, 8 Jun 2021 11:57:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YL8zZraFXTvGr3dE@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08. 06. 21 11:07, Greg Kroah-Hartman wrote:
>> +	int has_sernum;
> 
> bool?

OK.
> 
>> +	spi_message_init(&m);
>> +	memset(t, 0, sizeof(t));
> 
> Are you allowed to send spi messages off of the stack?

I don't know, but it's functional. Copied from read function.
> 
> 
>> -	dev_info(&spi->dev, "%d %s %s eeprom%s, pagesize %u\n",
>> -		(chip.byte_len < 1024) ? chip.byte_len : (chip.byte_len / 1024),
>> -		(chip.byte_len < 1024) ? "Byte" : "KByte",
>> -		at25->chip.name,
>> -		(chip.flags & EE_READONLY) ? " (readonly)" : "",
>> -		at25->chip.page_size);
>> +	dev_info(&spi->dev, "%d %s %s %s%s, pagesize %u\n",
>> +		 (chip.byte_len < 1024) ? chip.byte_len : (chip.byte_len / 1024),
>> +		 (chip.byte_len < 1024) ? "Byte" : "KByte",
>> +		 at25->chip.name, is_fram ? "fram" : "eeprom",
>> +		 (chip.flags & EE_READONLY) ? " (readonly)" : "",
>> +		 at25->chip.page_size);
> 
> When drivers work properly, they should be quiet.  This whole dev_info()
> should be removed in a later patch.

OK, didn't know, originally there is such info output. And keeping 
simplest smallest patch changes.
