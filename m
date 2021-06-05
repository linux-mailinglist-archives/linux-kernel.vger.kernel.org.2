Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21BE39C60C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 07:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhFEFbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 01:31:47 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:49543 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229660AbhFEFbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 01:31:46 -0400
Received: from [192.168.0.3] (ip5f5aeece.dynamic.kabel-deutschland.de [95.90.238.206])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2D75361E64762;
        Sat,  5 Jun 2021 07:29:58 +0200 (CEST)
Subject: Re: [PATCH] hwmon: (pmbus_core) Check adapter PEC support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Madhava Reddy Siddareddygari <msiddare@cisco.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210604135714.529042-1-pmenzel@molgen.mpg.de>
 <20210605005124.GA255680@roeck-us.net>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <8534d106-0936-a41d-b9c7-2f527b315dae@molgen.mpg.de>
Date:   Sat, 5 Jun 2021 07:29:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210605005124.GA255680@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Guenter,


Am 05.06.21 um 02:51 schrieb Guenter Roeck:
> On Fri, Jun 04, 2021 at 03:57:14PM +0200, Paul Menzel wrote:
>> From: Madhava Reddy Siddareddygari <msiddare@cisco.com>
>>
>> Currently, for Packet Error Checking (PEC) only the controller
>> is checked for support. This causes problems on the cisco-8000
>> platform where a SMBUS transaction errors are observed. This is
>> because PEC has to be enabled only if both controller and
>> adapter support it.
>>
>> Added code to check PEC capability for adapter and enable it
>> only if both controller and adapter supports PEC.
>>
>> Signed-off-by: Madhava Reddy Siddareddygari <msiddare@cisco.com>
>> [Upstream from SONiC https://github.com/Azure/sonic-linux-kernel/pull/215]
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> ---
>>   drivers/hwmon/pmbus/pmbus_core.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>> index bbd745178147..7fbd82b7560d 100644
>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>> @@ -2214,11 +2214,13 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>>   		data->has_status_word = true;
>>   	}
>>   
>> -	/* Enable PEC if the controller supports it */
>> -	if (!(data->flags & PMBUS_NO_CAPABILITY)) {
> 
> What is the rationale for removing this check ?
> AFAICS that will render the ibm-cffps driver unusable.

I screwed up forward porting this change. Thank you for spotting this. I 
sent a second iteration/version 2 of this patch.


Kind regards,

Paul


>> -		ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
>> -		if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
>> +	/* Enable PEC if the controller and bus supports it */
>> +	ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
>> +	if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK)) {
>> +		if (i2c_check_functionality(client->adapter,
>> +			I2C_FUNC_SMBUS_PEC)) {
>>   			client->flags |= I2C_CLIENT_PEC;
>> +		}
>>   	}
>>   
>>   	/*
>> -- 
>> 2.32.0.rc2
