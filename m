Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B451E34E0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 07:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhC3FjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 01:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhC3FjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 01:39:10 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD8DC061762;
        Mon, 29 Mar 2021 22:39:09 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so14494642otn.10;
        Mon, 29 Mar 2021 22:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AIRzKy2qJITF37JztXMNuyO5+xlN4Ko8X7QIWCFTxbI=;
        b=EmI96ozrQE90QQBpCGLPDnijm0LrYJFqsYNpFB5OwfFTCsEfOcRFQGrQARAGHtZUCY
         sArld1DOgnz4eSHHn71BNZrbAAUOiIsRepiyLXyekCoanjzLizq86gby14oKk1nK8MG8
         Vec5nXxiGDOG/RZM4t4w4ADq/Q3LDSiDOxthqI5HtaF/vYWLvp9FRTKgCxB1InKXrrUZ
         OCrtC80Uk1VmGLB1644ne81HtxcqfIRPtBzr4gfxTEcEHFPiYiB2Ohhi94zBA4cmlV3B
         Ek7xInTuY3Zrx1M5jTc8qtaOumpr2rlF/geWQiGseU7c3/Q0A2DIEby+10jG2FXOe8Uv
         sWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AIRzKy2qJITF37JztXMNuyO5+xlN4Ko8X7QIWCFTxbI=;
        b=sV0E0m3D/a6S3Z56hGlEXdlWkDlIn8Q6Dp0EaWPy7fcPGtM1zOPwscQjbTKKH7hi9p
         PSXai7nryt8amblPNjTw3KGD8iEKn5NIcg1/NKSRMAaLSKCfB1knSn/YyMY4LSaZCNUt
         93BhQDJwwZZfeQjQn6hFBoviBW2gypTkUfK6SDisW87Z++33UX5axi+miFmBWWvkVHVP
         lEEWdDP8+q1B4wMKqAOjYjoEi9LjGi/53BJWW5utnJaU/IdR07hyM3XVbeTZWbrcI9W6
         JRa/LgRR3FCmb/Fd28Ca7qHUOz2dk9KWwwtX8FAuXslpgwJr5RHAUkNdwuNnZIdGPJX/
         4JfQ==
X-Gm-Message-State: AOAM532QoVFz4aKBwbWFlIoIHyKEHVaEuF6Xp1q60Z7bHdgL0lXEVWU8
        bJq75YWwoOu7nYdFqX4HAuUDwnKlWJs=
X-Google-Smtp-Source: ABdhPJxYG5ZKCCsmxdx+SF7xOkLdLEe02Y98bLBgvRmVhcaKIl3h5qVvw4cF7K6k1Xl/8Pgo3DphUQ==
X-Received: by 2002:a9d:5e92:: with SMTP id f18mr15777253otl.24.1617082748803;
        Mon, 29 Mar 2021 22:39:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x2sm4988033ote.47.2021.03.29.22.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 22:39:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: Add driver for fsp-3y PSUs and PDUs
To:     =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20210329143833.1047539-1-kubernat@cesnet.cz>
 <a5e4ad25-1395-0df5-a128-d0fdb98cc1ea@roeck-us.net>
 <CABKa3nrgjC3ZxG8vCAfBYGE382iDADUS4MTYu6YdHipqH-+QuQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <23a58dda-a1c3-6a93-dac7-67ae1a11e5a1@roeck-us.net>
Date:   Mon, 29 Mar 2021 22:39:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABKa3nrgjC3ZxG8vCAfBYGE382iDADUS4MTYu6YdHipqH-+QuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 8:31 PM, Václav Kubernát wrote:
> Hi Guenter,
> 
> Thank you for the review.
> 
> po 29. 3. 2021 v 19:47 odesílatel Guenter Roeck <linux@roeck-us.net> napsal:
>>
>> On 3/29/21 7:38 AM, Václav Kubernát wrote:
>>> After some testing, I have found out there is a timing issue with this
>>> device. After setting page, the device doesn't immediately react and
>>> gives values from the previous page for some time. This is why there
>>> needs to be a delay between pmbus_set_page and the actual read.
>>>
>>> Also, a lot of the standard commands don't work with the devices, so
>>> they are filtered out in the custom read function.
>>>
>>
>> This is not an appropriate patch description. Describe the driver here,
>> not the workarounds / quirks. The reason for the delay should be a
>> comment in the patch, not in the patch description.
>>
>> Also, "don't work" is inappropriate (and, again, does not belong into
>> the patch description). It is perfectly appropriate for the core
>> to try those commands to see if they are supported. The only reason
>> to mask them out would be that the device reacts badly to seeing
>> them. If that is the case, "don't work" should be replaced with
>> a more detailed comment in the code. Describe what happens, and why
>> the commands needs to be caught.
>>
>>
>> What might be useful is a note indicating if you have a manual for
>> those power supplies available, or if the driver is based on reverse
>> engineering.
>>
> 
> I will rework the commit message in a V2 patch.
> 
>>> Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
>>> ---
>>>  drivers/hwmon/pmbus/Kconfig  |   9 ++
>>>  drivers/hwmon/pmbus/Makefile |   1 +
>>>  drivers/hwmon/pmbus/fsp-3y.c | 164 +++++++++++++++++++++++++++++++++++
>>
>> Documentation/hwmon/fsp-3y.rst is missing.
>>
>>>  3 files changed, 174 insertions(+)
>>>  create mode 100644 drivers/hwmon/pmbus/fsp-3y.c
>>>
>>> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
>>> index 03606d4298a4..66d1655b6750 100644
>>> --- a/drivers/hwmon/pmbus/Kconfig
>>> +++ b/drivers/hwmon/pmbus/Kconfig
>>> @@ -56,6 +56,15 @@ config SENSORS_BEL_PFE
>>>         This driver can also be built as a module. If so, the module will
>>>         be called bel-pfe.
>>>
>>> +config SENSORS_FSP_3Y
>>> +     tristate "FSP/3Y-Power power supplies"
>>> +     help
>>> +       If you say yes here you get hardware monitoring support for
>>> +       FSP/3Y-Power hot-swap power supplies.
>>> +
>>
>> This should list the supported models - if not here, then at least in the
>> (missing) documentation.
>>
> 
> Okay.
> 
>>> +       This driver can also be built as a module. If so, the module will
>>> +       be called fsp-3y.
>>> +
>>>  config SENSORS_IBM_CFFPS
>>>       tristate "IBM Common Form Factor Power Supply"
>>>       depends on LEDS_CLASS
>>> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
>>> index 6a4ba0fdc1db..bfe218ad898f 100644
>>> --- a/drivers/hwmon/pmbus/Makefile
>>> +++ b/drivers/hwmon/pmbus/Makefile
>>> @@ -8,6 +8,7 @@ obj-$(CONFIG_SENSORS_PMBUS)   += pmbus.o
>>>  obj-$(CONFIG_SENSORS_ADM1266)        += adm1266.o
>>>  obj-$(CONFIG_SENSORS_ADM1275)        += adm1275.o
>>>  obj-$(CONFIG_SENSORS_BEL_PFE)        += bel-pfe.o
>>> +obj-$(CONFIG_SENSORS_FSP_3Y) += fsp-3y.o
>>>  obj-$(CONFIG_SENSORS_IBM_CFFPS)      += ibm-cffps.o
>>>  obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
>>>  obj-$(CONFIG_SENSORS_IR35221)        += ir35221.o
>>> diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.c
>>> new file mode 100644
>>> index 000000000000..7f3c3de3a1e6
>>> --- /dev/null
>>> +++ b/drivers/hwmon/pmbus/fsp-3y.c
>>> @@ -0,0 +1,164 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Hardware monitoring driver for FSP 3Y-Power PSUs
>>> + *
>>> + * Copyright (c) 2021 Václav Kubernát, CESNET
>>> + */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/i2c.h>
>>
>> Alphabetic include file order, please.
>>
>>> +#include "pmbus.h"
>>> +
>>> +#define YM2151_PAGE_12V              0x00
>>> +#define YM2151_PAGE_5V               0x20
>>> +#define YH5151E_PAGE_12V     0x00
>>> +#define YH5151E_PAGE_5V              0x10
>>> +#define YH5151E_PAGE_3V3     0x11
>>> +
>>> +enum chips {
>>> +     ym2151e,
>>> +     yh5151e
>>> +};
>>> +
>>> +static int set_page(struct i2c_client *client, int page)
>>> +{
>>> +     int rv;
>>> +
>>> +     rv = i2c_smbus_read_byte_data(client, PMBUS_PAGE);
>>> +
>> Please no empty line here.
>>
>> You might want to consider caching the current page to avoid having to read it
>> for each access, similar to the code implemented in the pmbus core.
>>
> 
> This was actually what I wanted to do at first, but I wasn't able to
> get i2c_set_clientdata to work. Later I found out that it is because
> pmbus_do_probe uses sets it own data. What do you think I should use
> to cache the page?
> 

Several other PMBus drivers use local data. The trick is to put
the pmbus_driver_info data structure into that local data, then use
container_of() to access it.

>>> +     if (rv < 0)
>>> +             return rv;
>>> +
>>> +     if (rv != page) {
>>> +             rv = pmbus_set_page(client, page, 0xff);
>>> +             if (rv < 0)
>>> +                     return rv;
>>> +
>>> +             msleep(20);
>>
>> Please use usleep_range(), and make sure that this huge delay is actually needed.
>>
> 
> As is written in the original commit message, the devices have some
> kind of timing issues and this delay really is needed. I have tested
> smaller delays (10ms), they are compared to no delay, but I would
> still sometimes get wrong values. I will move this explanation into
> the code.
> Ok.

>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int fsp3y_read_byte_data(struct i2c_client *client, int page, int reg)
>>> +{
>>> +     int rv;
>>> +
>>> +     rv = set_page(client, page);
>>> +     if (rv < 0)
>>> +             return rv;
>>> +
>>> +     return i2c_smbus_read_byte_data(client, reg);
>>> +}
>>> +
>>> +static int fsp3y_read_word_data(struct i2c_client *client, int page, int phase, int reg)
>>> +{
>>> +     int rv;
>>> +
>>> +     if (reg >= PMBUS_VIRT_BASE)
>>> +             return -ENXIO;
>>> +
>>> +     switch (reg) {
>>> +     case PMBUS_OT_WARN_LIMIT:
>>> +     case PMBUS_OT_FAULT_LIMIT:
>>> +     case PMBUS_UT_WARN_LIMIT:
>>> +     case PMBUS_UT_FAULT_LIMIT:
>>> +     case PMBUS_VIN_UV_WARN_LIMIT:
>>> +     case PMBUS_VIN_UV_FAULT_LIMIT:
>>> +     case PMBUS_VIN_OV_FAULT_LIMIT:
>>> +     case PMBUS_VIN_OV_WARN_LIMIT:
>>> +     case PMBUS_IOUT_OC_WARN_LIMIT:
>>> +     case PMBUS_IOUT_UC_FAULT_LIMIT:
>>> +     case PMBUS_IOUT_OC_FAULT_LIMIT:
>>> +     case PMBUS_IIN_OC_WARN_LIMIT:
>>> +     case PMBUS_IIN_OC_FAULT_LIMIT:
>>> +     case PMBUS_VOUT_UV_WARN_LIMIT:
>>> +     case PMBUS_VOUT_UV_FAULT_LIMIT:
>>> +     case PMBUS_VOUT_OV_WARN_LIMIT:
>>> +     case PMBUS_VOUT_OV_FAULT_LIMIT:
>>> +     case PMBUS_MFR_VIN_MIN:
>>> +     case PMBUS_MFR_VIN_MAX:
>>> +     case PMBUS_MFR_IIN_MAX:
>>> +     case PMBUS_MFR_VOUT_MIN:
>>> +     case PMBUS_MFR_VOUT_MAX:
>>> +     case PMBUS_MFR_IOUT_MAX:
>>> +     case PMBUS_MFR_PIN_MAX:
>>> +     case PMBUS_POUT_MAX:
>>> +     case PMBUS_POUT_OP_WARN_LIMIT:
>>> +     case PMBUS_POUT_OP_FAULT_LIMIT:
>>> +     case PMBUS_MFR_MAX_TEMP_1:
>>> +     case PMBUS_MFR_MAX_TEMP_2:
>>> +     case PMBUS_MFR_MAX_TEMP_3:
>>> +     case PMBUS_MFR_POUT_MAX:
>>> +             return -ENXIO;
>>> +     }
>>
>> If that many commands indeed cause trouble (ie cause the device
>> to get into a bad state), it might be better to list the _supported_
>> commands instead of the unsupported ones. There is no guarantee
>> that the core won't start to send other commands to the device
>> in the future.
>>
>> The underlying question is if those commands are indeed not supported,
>> or if they report values in an unexpected format (ie not linear11).
>> The data format that is auto-selected below (because it is not specified)
>> is "linear". Is this what the device actually uses ? If not, just disabling
>> reading the limits without explanation what exactly "does not work" is
>> inappropriate.
>>
> 
> The reason I masked these commands is because when I was reading from
> the associated files, I would get weird values (like -500). But it's
> not like the commands confuse the device. If you think it isn't a good
> idea to mask them like that, I'm fine with removing the masking.
> 

The problem is that the power supplies do support those commands. The question
is what data format they use. Given that we know which pages map which voltage,
it should be possible to figure that out based on the raw data reported on
the multiple pages. Also, another question is if all those commands
are affected. If it is PMBUS_VOUT_xxx, it is probably because they are
(wrongly) reported in LINEAR 11 instead of LINEAR16 format. It may as well be
that other limits are reported as LINEAR16 when it should be LINEAR11.
All that is difficult to determine without seeing the raw data and without
datasheet.

>>> +
>>> +     rv = set_page(client, page);
>>> +     if (rv < 0)
>>> +             return rv;
>>> +
>>> +     return i2c_smbus_read_word_data(client, reg);
>>> +}
>>> +
>>> +struct pmbus_driver_info fsp3y_info[] = {
>>> +     [ym2151e] = {
>>> +             .pages = 0x21,
>>> +             .func[YM2151_PAGE_12V] =
>>> +                     PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
>>> +                     PMBUS_HAVE_PIN | PMBUS_HAVE_POUT  |
>>> +                     PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
>>> +                     PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
>>> +                     PMBUS_HAVE_FAN12,
>>> +             .func[YM2151_PAGE_5V] =
>>> +                     PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT,
>>> +                     PMBUS_HAVE_IIN,
>>
>> It doesn't really make sense to claim support for 0x21 = 33
>> pages, especially since the pmbus core (and the pmbus standard)
>> only supports 32 pages. Since page handling is all local anyway,
>> I would suggest  to claim two pages and map the logical page
>> to the physical page in the set_page command.
>>
>> How does this work (compile) anyway ? .func[] array size
>> is 32, meaning .func[0x20] goes beyond the end of the array.
>> The compiler should complain about that.
>>
>> Wait, how does this even instantiate ? The PMBus core
>> should reject a page count larger than 32, and pmbus_do_probe()
>> should return -ENODEV. How did you test this code ?
>>
> 
> Sorry, I forgot I was building this patch on top of another patch
> (written by my colleague), which increases the page limit. The pmbus
> specification does say that pages 0x00 through 0x1F are "reserved
> specifically for multiple outputs on a device with a single physical
> address", but it does not say that there is a page limit. Anyway, The

Ah yes, sorry, too long ago.

> PSU really does use the 0x20 page. Either way, I'm fine with doing a
> mapping between a logical a page and physical, if you decide you don't
> want to change the page limit.
> 

Unless there is a good reason to do so (ie a device with more than 32
legitimate pages) I do not really want to increase that limit since that
would affect all PMBus drivers.

>>> +             .read_word_data = fsp3y_read_word_data,
>>> +             .read_byte_data = fsp3y_read_byte_data,
>>> +     },
>>> +     [yh5151e] = {
>>> +             .pages = 0x12,
>>
>> Same as above.
>>
>>> +             .func[YH5151E_PAGE_12V] =
>>> +                     PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
>>> +                     PMBUS_HAVE_POUT  |
>>> +                     PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3,
>>> +             .func[YH5151E_PAGE_5V] =
>>> +                     PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
>>> +                     PMBUS_HAVE_POUT,
>>> +             .func[YH5151E_PAGE_3V3] =
>>> +                     PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
>>> +                     PMBUS_HAVE_POUT,

Assuming this is really YH5151-1EBR, doesn't it also support
-12V (possibly on page 0x22) and +5Vsb ?

>>> +             .read_word_data = fsp3y_read_word_data,
>>> +             .read_byte_data = fsp3y_read_byte_data,
>>> +     }
>>> +};
>>> +
>>> +static int fsp3y_probe(struct i2c_client *client,
>>> +                    const struct i2c_device_id *id)
>>> +{
>>
>> This vendor sells dozens of different power supplies. Apparently
>> they do not have compatible PMBus attributes (or at least the pages
>> are not compatible to each other). Given that, I think there should
>> be a model validation here.
> 
> How should I go about doing model validation? I'm already using
> i2c_device_id to differentiate between the PDU and the PSU, but I
> suppose, that's not the best thing. Maybe I should use an identify
> function in pmbus_driver_info?
> 

By reading PMBUS_MFR_ID ? PMBUS_MFR_MODEL ? PMBUS_IC_DEVICE_ID ?

I don't have the manual, and manuals from this manufacturer are not
public, so I have no idea what those power supplies report.

>>
>> This is even more important since an earlier discussion suggests that
>> at least some of the 3Y power supplies use LINEAR11 instead of LINEAR16
>> for output voltages (eg YH5301-1EAR, FSP550-50ERS). We need to ensure
>> that affected power supplies are not enabled with this driver, and that
>> the enabled power supplies have been tested and are not only confirmed
>> to work and report correct data.
>>
> 
> 
>>> +     return pmbus_do_probe(client, &fsp3y_info[id->driver_data]);
>>> +}
>>> +
>>> +static const struct i2c_device_id pmbus_id[] = {
>>> +     {"fsp3y_ym2151e", ym2151e},
>>> +     {"fsp3y_yh5151e", yh5151e},> +  {}
>>> +};
>>> +
>>> +MODULE_DEVICE_TABLE(i2c, pmbus_id);
>>> +
>>> +/* This is the driver that will be inserted */
>>> +static struct i2c_driver fsp3y_driver = {
>>> +     .driver = {
>>> +                .name = "fsp3y",
>>> +                },
>>> +     .probe = fsp3y_probe,
>>
>> Please use the .probe_new callback.
>>
>>> +     .id_table = pmbus_id
>>> +};
>>> +
>>> +module_i2c_driver(fsp3y_driver);
>>> +
>>> +MODULE_AUTHOR("Václav Kubernát");
>>> +MODULE_DESCRIPTION("PMBus driver for FSP/3Y-Power power supplies");
>>> +MODULE_LICENSE("GPL");
>>>
>>
> 
> Václav
> 

