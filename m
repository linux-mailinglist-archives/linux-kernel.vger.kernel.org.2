Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B553B1845
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 12:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFWK6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 06:58:10 -0400
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:50027
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230030AbhFWK6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 06:58:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgAwnYCV+Qkj3eLXIabMUVPW1TfKJq6nbadyn/PCDlsTI4/ivG2P7ISjXITbiivsn87RZxrn3rMxZkK1LeOVlDKpWwSqpn9ctPnbLp1QkglPWzB3UudM3kv9AI0iCyedLTLqRoFB/oz8ymLIsiaChqRSpUlyfsxsActFw5kISZRHIli18DxcZlotYioXcnUiZRBFdfj8XMF9JqTuiT831jX5JJ7jjgTHBELrpJtKq0bPAfla+/1VM4VawTMEwFprNREN7R6O6rkKTF35z6jT5xhlQML4Lwhn95sgRwRyjLu+JQv8tG3G6vY7czUonSd2mPrKp2F2vc8e3hgRv4P4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIlmlCulag2UcHOddLycxwP3BgV/EvCsXk62sXITgh0=;
 b=d6y5uSGaO+Pg6MAQLn8NrfSVNyP3EsqGqtoNFPRQYqOi6eGWqHABTbnyigDG4ZXO+K34EhAWHy8c5vPusvay9xrzG1DG0iG7c0flb7K3scXMQmG7RwhmhE4t4/RcyodpL/DQsvfyNXr2+jmiL/RnL7aP/iMesrMqqd0MwD8kJYXss1RcOLKct2tbGJfYqy6lp5pB8Y9BGYe8cK3e2WNDxKmEAIbY7mTn8+2ueK6xiyxNSQULA0LhfQHOGq/bP7vXwycF0mY0g9ETxArMHw3He1Yyc18v/22OgdsaGY5V5z7sbArfH6R1mUWDFKgSMhg5g5u4kWZ2DqCP1teHa20PXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIlmlCulag2UcHOddLycxwP3BgV/EvCsXk62sXITgh0=;
 b=u/raS5d/VnBvGrgpJ0lwbXkgrX192/6STXD5dxVXL0qrTfiq55YI1LRqnk9J78YxVokHptciKr5+SH+TAuKbKiOX4t8uGjirxW77TegmstBxGCJUihLE5ITUuOZmBt40ecHKpHgZ4abLbA6qpoT+Nzzd/VtddvnqGcpnkIILMKdvTcXz7kzvyaFhSaWgzarG/B2oRiCZRmW8jXjA5R5Um+8lkGJnABWOQVoJPApEs19RpIEIbrzYsfydQBa0Zuiwi5O7qTINriMo8m2lYjie8GdmSyFruIFQkTdJGF6n4gIaJe2kzN893iZA+Ed6la1rnO6oD5BJdd9YQCntbselkQ==
Authentication-Results: vaisala.com; dkim=none (message not signed)
 header.d=none;vaisala.com; dmarc=none action=none header.from=vaisala.com;
Received: from AM8PR06MB7793.eurprd06.prod.outlook.com (2603:10a6:20b:369::19)
 by AM0PR06MB6354.eurprd06.prod.outlook.com (2603:10a6:208:192::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 10:55:45 +0000
Received: from AM8PR06MB7793.eurprd06.prod.outlook.com
 ([fe80::e012:5f2:e678:7c16]) by AM8PR06MB7793.eurprd06.prod.outlook.com
 ([fe80::e012:5f2:e678:7c16%6]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 10:55:45 +0000
Subject: Re: [PATCH v4 2/4] nvmem: bootcount: add bootcount driver
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nandor Han <nandor.han@vaisala.com>, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Tomas Melin <tomas.melin@vaisala.com>
References: <cover.1620211180.git.nandor.han@vaisala.com>
 <43e36704e9acbf89b3b29113554d3a79417d42db.1620211180.git.nandor.han@vaisala.com>
 <b973f433-5aa6-5c93-4d60-1017495ae0a7@linaro.org>
 <a456396b-3950-7bd2-8f5c-af2699276f82@vaisala.com>
 <78af96b3-b07b-342b-edf2-c898c31e956e@linaro.org>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= 
        <vesa.jaaskelainen@vaisala.com>
Message-ID: <c965fa10-9296-e611-9515-675daa602538@vaisala.com>
Date:   Wed, 23 Jun 2021 13:55:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <78af96b3-b07b-342b-edf2-c898c31e956e@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [193.143.230.131]
X-ClientProxiedBy: HE1PR0101CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::17) To AM8PR06MB7793.eurprd06.prod.outlook.com
 (2603:10a6:20b:369::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.24.185.93] (193.143.230.131) by HE1PR0101CA0007.eurprd01.prod.exchangelabs.com (2603:10a6:3:77::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 10:55:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a19c896-1cbf-4a68-55bd-08d936357394
X-MS-TrafficTypeDiagnostic: AM0PR06MB6354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR06MB63542E0F64C0AE522C8A70E9ED089@AM0PR06MB6354.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+AAvr0XSP7CbAT4rydCifdc85FaspIplT+fYkqwU/z+nZ3FstO4qp4G25SKSZRoVGWVNWq4kL1RcaQ9OLJHSj4/914PQbwQYbQqkVerj2XW2NSXC5s9NlQwLj6ZAWGwK+u528OtuEd1WqcZsiOCt/XrpUMPoeA+lvRWACT3JLwmn2xCVPobABicK4oJ07eHU4dtpQlLCmhDcsk73laCIuDkz9e/c/LTMG2AZoCtIOvGxXHXk9s+1IjrishXg3rn0f+zgAOeoOjbTEPFagJi2d0LSFgCJWpV5ZXI9BuZ1X/Zj5mCgGaXWIak3Y4I+I0AOQ2SNHnd/c97YLZn9yCfIW/2OXKkPxw7UVuIFaBKbj448htEQxTcwM5W1nyAGLsGfN2PebwqUVyhyJy0z/aAc+FIk+w8ZGg6o5tamYvGczZ8SMIHs9RKckXzA3CXnM9LbgxWvfTOVve7raJyo5sM1cb3XnlHWf+VMM30hTBKDxyLGuFLItV4vMvomxWqAskmg2+SK1AiKauxYjMVnRJLs4eOAVR/XdxeOrX9on0MSA9rYExvPhvzllVfwfW20FhZf2+ADnJYEuRPa+fpLskJMRft9LQDFYQcVWwQ1jkETxg2wtTLWpPvqtv7tAVVPps0gIbtIo2os7CH6lgCaznAQgpf0EOXmGJu6xDOEnaIbpSixa6APxkGdTZtTgwN5lOU27lClkRxJn1a6X95MYXTyAdwG7ejbHXFoiiGJG6GGsNKpBwjbFR30nfc4Rfl5iF6e+W9RC7uiRj5dBrUgSz0DcclnOzz0uiEQ6dQ8Y7vW2/9xzZDrXQAaoK4yKruxvcD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7793.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39850400004)(346002)(366004)(478600001)(53546011)(31696002)(66946007)(52116002)(110136005)(966005)(186003)(85182001)(4326008)(38100700002)(107886003)(66574015)(38350700002)(26005)(31686004)(316002)(5660300002)(16576012)(6486002)(86362001)(16526019)(956004)(2616005)(6666004)(36756003)(8936002)(2906002)(8676002)(83380400001)(66556008)(66476007)(85202003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d240Qm1rNUhXMmhPSWFHNE9jYlhhekpOMW41NlZDWWJtWk8rK0h4WmdYRVUw?=
 =?utf-8?B?cEs5VURFZFFaZHg4T0ZGMnNwYkdYR2hiK2JMSEVUdm52dGFkMTlVdnZYRTNH?=
 =?utf-8?B?VStMYWNVWitMci83Q09MdzVoSkxyUGcxY3BXb0NYdGIwT2ZzT3kwRXZqODFq?=
 =?utf-8?B?cFRRTUQ1Y3RKbXE1WllWWk5MM0ZVVGpNMndSM2F5dEFyMVNrdzFCMHFiVTBD?=
 =?utf-8?B?TUVNMHdkU0RwNXhJQWNSeGJyUW44eDU3eU54ZVQ5a1RrNzhZVndDbUdCM3JN?=
 =?utf-8?B?cnV1NktEc1MxcjZSZ25mR0I2ZlMzTmxxdEVaeHZuV3h3SlZyaGJ5Yng3VUo2?=
 =?utf-8?B?WHAySFJta002OE1JdTV1bC9ycFRxM0swaTZjalN6bHc4ZTNSWDhrUk9iWTYw?=
 =?utf-8?B?Z3pPbGRnallEdFBteVVQcVA0amdvV2l2QUdVKzVNL043TlRBYUI4RGZSRWdG?=
 =?utf-8?B?b29mSlhzeFcySUNzOGtkUUtwR1dJclh1dHI2ZDFNZzM3cGRBb3JlRU9zM1NW?=
 =?utf-8?B?d0tTeUE0WnZLbWpxT1c3UFJRcFlJRVhjT3BRNEFucTBxeWN2cEhpalFXU1NP?=
 =?utf-8?B?NzhGdVkzNTJWajN6dTBMRHRwa2ZzU0lBSmd0UEtGQUFZUEZZbjlRVXNEbWVI?=
 =?utf-8?B?MTBXQjhqNFpQdUNDNCthcTI2UHZLaWJUcEJ1TVFmMHByc0NndWRiZFB3TmhY?=
 =?utf-8?B?N1Q3UWtuMWJEcnpWeXNNZWJzZi9kSU9qeENvam1rSE1iMENCczZ0bk9GTllR?=
 =?utf-8?B?MDhRMzhtS3Q4aU1xS0Yvb2greWhTQkhsWUUrajg2bDdCQjNCUWtjZVBlbXc4?=
 =?utf-8?B?MGNINGdEcVZHaDE0dzFPMDJ6Y04vQzR4SzhSMjZrUUFxZlBEcEMyK3BNcXJ1?=
 =?utf-8?B?Z2pqNDRMYVRucGEwTHllSEJZYXBPYjhXY0prWUVEb2dDaEZjOXpvTE14dkVQ?=
 =?utf-8?B?cGNtWEg2cGVxdUlSVmJ6NWVFZ0c0MDFEa1dRRVlITmY4RkJvRjdOa3ZYZEJB?=
 =?utf-8?B?UmtJZGJiNFBNZGt2REo2WGVYM21RZWxKMHRBR2hIR2FjNHBXVVgzanJZVVhx?=
 =?utf-8?B?MVFFOVppRjNDdlUxd1ZpV1lqNXo2T2VGTk9VVkxwL2k2Y0hBWStHczB5cDFu?=
 =?utf-8?B?VkU4TllnWWgxL0RrcDZobldyWmlqYXVyS0hXd1ZlRjh1YkUxd2loYUkzUUJv?=
 =?utf-8?B?d0t4RVZXL0xZRU5qNFl3QXc5dHF6VHJSRVNhWm9TVFUwM1A5VzhpRkdtK3p0?=
 =?utf-8?B?L0N2WUxncEdLSUZEc3RUN3hITmgzS1hHa0oxcUd1NytCYm0raFErTUhtMFh1?=
 =?utf-8?B?K1M4enRzTFZpTTFKQWJ3bmtUaU1uM1BvRjlRTmlrb2IycjI3RWJqVCtCRjZT?=
 =?utf-8?B?Zno5ZVllRW1TK1FtaVlzWTM4SEx0RE4rTENyQlpVNGN0SU5uL3JNOFoxS2hw?=
 =?utf-8?B?ZGtESjd3WVpOUC93SDdZcmlxUUh1Q3hoMXN6YkVrbFdhZlFyeG9CbVMxbE1L?=
 =?utf-8?B?ZXlDckVjczhacElIYWF0SXB5MFhyMUs2UCtOWERuQ1VEQzI4bkxJZXdSVlFU?=
 =?utf-8?B?NkhMN2QxZmsxUXFGSjRzYWl6bm5SaUhUYjg2cEpnZ3FsVFd0L1IyditpcG5F?=
 =?utf-8?B?N0xFOEpPT0UzcmdhRFBuaHRIUkpPNXpjVVJtWWx1QVZRYWdKendaNS9xQUh5?=
 =?utf-8?B?V3NhTUZ3aVkxS0VtVCt3VFVGeTVTc0gyS3AyK25xb1dWc1hiMGg0c1Z5dmFM?=
 =?utf-8?Q?DI3LfoE0Q17YlTrVQHLoRqYRiElrUEUimjBzB7P?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a19c896-1cbf-4a68-55bd-08d936357394
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7793.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 10:55:45.1377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uysJli7cph8XfqyJApdFItR0Nej1B3NMnkFaMKoeHqm1+Il1B0xSeEOV05ZXApz2Z2hBBnfE6n0tmdpX1m2lfcUWgE1gSsVb6mWbbJ1sZMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6354
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-03 11:03, Srinivas Kandagatla wrote:
> On 01/06/2021 08:58, Nandor Han wrote:
>> On 5/28/21 11:23 AM, Srinivas Kandagatla wrote:
>>> On 05/05/2021 11:42, Nandor Han wrote:
>>>> In order to have a robust system we want to be able to identify and 
>>>> take
>>>> actions if a boot loop occurs. This is possible by using the bootcount
>>>> feature, which can be used to identify the number of times device has
>>>> booted since bootcount was last time reset. Bootcount feature (1)
>>>> requires a collaboration between bootloader and user-space, where
>>>> the bootloader will increase a counter and user-space reset it.
>>>> If the counter is not reset and a pre-established threshold is reached,
>>>> bootloader can react and take action.
>>>>
>>>> This is the kernel side implementation, which can be used to
>>>> identify the number of times device has booted since bootcount was
>>>> last time reset.
>>>>
>>>
>>> If I understand this correctly, this driver is basically exposing a 
>>> nvmem cell via sysfs.
>>>
>>> Firstly, This sounds like totally a generic functionality that needs 
>>> to go into nvmem core rather than individual drivers.
>>>
>>> Do you see any reason for this not be in core?
>>
>> I agree that exposing a NVMEM cell via sysfs does look as a generic 
>> functionality. However, the bootcount feature contains also a magic
>> value that needs to be taken in consideration when extracting the
>> bootcount value. The size of the field storing the magic and value combo
>> is configurable as well. The driver will handle this values 
>> transparentlry for the user and expose only the validated
>> bootcount value. In case we will only use a generic implementation for
>> exposing a NVMEM cell via sysfs the aformention functionality will have
>> to be handled by userspace and this will force the userspace to have
>> knolwdge about bootcount value format and magic since they will have
>> to implement it's own functionality about this. In the current solution
>> the user only have to reset the value to 0 and that's it, the driver
>> will take care of the rest.
> 
> Should this not live in userspace HAL, kernel would provide an abstract 
> interface. User space in this case which is programming the bootcount is 
> already aware of this, so am hoping that it would be able to encapsulate 
> the magic as well with in.
> 
> Instead of accessing sysfs directly, its always recommended to access it 
> via a some abstraction HAL programs, so as to not break the userspace 
> across kernel releases, more info at 
> ./Documentation/admin-guide/sysfs-rules.rst
> 
> Other problem with having this in kernel is that we would endup with 
> endless number of drivers for each nvmem cell which is totally not 
> necessary.
> 
> Personally I do not want to endup in such a situation where people start 
> writing drivers for each cell.

If we look from U-Boot source code (for which the boot count support has 
been there for long time):

https://source.denx.de/u-boot/u-boot/-/tree/master/drivers/bootcount

In there we do have solutions for:

- Atmel AT91 -- one specific CPU register

- Davinci/Omap/beaglebone -- Uses internal RTC's scratcpad #2 register
   - In here Scratcpad #0/#1 were at least one point of time used for 
deep sleep recovery addresses -- and probably should not be exposed at 
all to user space

- As U-Boot environment variable -- what ever storage would be

- File system interface -- store as a file

- I2C (version 1) -- store in (volatile) 16 bit RTC register

- RAM -- Use multiple addreses for storing magics and actual boot count 
value

- I2C EEPROM -- Store in persistent cells in EEPROM

- RTC -- Store in RTC if the chip has support for it

- SPI flash -- Store in special location in serial flash

So we are already in situation that there exists multiple technical 
solutions :| And best bit here is that some of them can be customized by 
Kconfig options.

Another observation of that list is that those all are not NVMEM cells 
-- so more generic solution abstracting it away would be better. 
Actually the best solution for boot count is probably volatile register 
that persist over reset of the device and is not subject of flash endurance.

So perhaps there should be "core boot count internal API" for which 
driver (in this case nvmem specific) can register itself and then that 
"boot count core" would then expose it to user space. That would most 
likely be quite slim implementation. And most likely there would only be 
one solution per device but in theory it could also support case if 
device supports more than one place to store it then it would handle 
this transparently from the driver.

I believe the sysfs would be perfect for this especially when the path 
for the entry would stay the same independent of the solution behind the 
boot count. This would make it easy for user space to read the boot 
count in shell scripts or in applications and then resetting would be as 
easy as echoing "0" to sysfs entry.

Thanks,
Vesa Jääskeläinen
