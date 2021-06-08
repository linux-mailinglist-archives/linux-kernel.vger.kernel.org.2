Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47F639F2D3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhFHJwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:52:07 -0400
Received: from router.aksignal.cz ([62.44.4.214]:59342 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHJwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:52:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 50832406FE;
        Tue,  8 Jun 2021 11:50:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id xsdHTSOUdbTu; Tue,  8 Jun 2021 11:50:03 +0200 (CEST)
Received: from [172.25.161.48] (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 429DF405B3;
        Tue,  8 Jun 2021 11:50:03 +0200 (CEST)
Subject: Re: [PATCH v8 5/5] nvmem: eeprom: add documentation of sysfs fram and
 sernum file
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
References: <20210607161201.223697-1-jiri.prchal@aksignal.cz>
 <20210607161201.223697-6-jiri.prchal@aksignal.cz>
 <YL8yveuSWTC9iEEz@kroah.com>
From:   =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
Message-ID: <d0aa3003-0cb7-53c8-6d0e-f1c2dcd90479@aksignal.cz>
Date:   Tue, 8 Jun 2021 11:50:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YL8yveuSWTC9iEEz@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08. 06. 21 11:05, Greg Kroah-Hartman wrote:
> On Mon, Jun 07, 2021 at 06:12:01PM +0200, Jiri Prchal wrote:
>> Added sysfs fram and sernum file documentation.
>>
>> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
>> ---
>> v5: new
>> v6: no change here
>> v7: no change here
>> v8: added fram file doc
>> ---
>>   Documentation/ABI/testing/sysfs-class-spi-eeprom | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-class-spi-eeprom
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-spi-eeprom b/Documentation/ABI/testing/sysfs-class-spi-eeprom
>> new file mode 100644
>> index 000000000000..b41420fe1329
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-spi-eeprom
>> @@ -0,0 +1,13 @@
>> +What:		/sys/class/spi_master/spi<bus>/spi<bus>.<dev>/sernum
>> +Date:		May 2021
>> +KernelVersion:	5.13
>> +Contact:	Jiri Prchal <jiri.prchal@aksignal.cz>
>> +Description:
>> +		(RO) Exports serial number of Cypress FRAM (FM25VN). 8 bytes as is in chip in hex string.
> 
> Please properly wrap your lines.
> 
> What is "(RO)" here?

Read Only, as seen in another doc.

> 
> And the grammer is a bit odd, what is the second sentence supposed to
> mean?
> 
>> +
>> +What:		/sys/class/spi_master/spi<bus>/spi<bus>.<dev>/fram
>> +Date:		June 2021
>> +KernelVersion:	5.13
> 
> Obviously it can not make 5.13, right?

Sorry for missunderstanding, what number should be here?

