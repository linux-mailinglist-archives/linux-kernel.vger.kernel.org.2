Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A286B388ED9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353569AbhESNUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241309AbhESNUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:20:46 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F2EC06175F;
        Wed, 19 May 2021 06:19:26 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id k4so1523397qkd.0;
        Wed, 19 May 2021 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l7WK/M3lA/Yv8SDSY01CJgdiUdDmvmZ7Z8gBSbNOKVI=;
        b=UW5+TVVh+Zj5pqwhBiWVAxsAguCsW59a5ZzuFT9fMgX3eNM6vxKn62L+1u1/kHfRtG
         s33UD940Ms5bu3FxhNACS6MyO1TP2Qy0XconqdVaWgQ0N6Sr9tNmB4lmsPRIpyJ5WDeI
         4sCAmgmVAHOzf0TsWhd/na9Ka48n5n1VPPVeGSLqmT6EEE6f4RUc1d/oYCmv9XsTWaF8
         c2l2dUOELj4/gCIG5cm7Qp8BKye/KOoQLyyWPgRMiUC82GJ2vNe+51LN5EdbVjge5rRH
         IHz5KDyOuuDWAmJmfI51mywSRu8MaUb+7TgZYINT6F9uTnHKocUfpe2GBcmYpARk2/bY
         M2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l7WK/M3lA/Yv8SDSY01CJgdiUdDmvmZ7Z8gBSbNOKVI=;
        b=ZTWGAIOuOu5f0ximDuL8uCgX7aH+UCzH7ELkDqkhLTpO+a/qkn83KUWMLUlzr+ddZa
         GxQyoGw/kz2IUuZaYJ1O5vXRATeC0ENu7ZYTtLt4Y4zsrgDhpxvRxA6ZtQpY9HKheUSW
         OrT1rgq0/dcWHCav6a3+xdn0DwkHZQuDCyu6hIVHSfgm0D6pfGKOvJPALuQXlcz8ayQG
         gkPlA+IXqg7UZCycKEb9KNnpbrsxV6vZp6pu6K84RncF7T3kZK3CO5LbmVdNaHe2KHP5
         M17hKWlo0IUQkpSamhQz4zjVtJ+6ZpkMrgZHyIKN/zJv11o5OsUbAV81l4r4X1rpr7gN
         ABFA==
X-Gm-Message-State: AOAM531tGKUg4MTwSWeJz5uoQAsAtCW/XM0IArWsnpp+TBwiJYMUQstS
        XTSUunGzsIjgh9nH2tYwvvs=
X-Google-Smtp-Source: ABdhPJy6yVjHFdhdEo+lWoYbh/CXfd5R5dsbndMc19ridqWlOXajoryZPdmUzmZOethi85dahoCxtQ==
X-Received: by 2002:a37:9a16:: with SMTP id c22mr11857749qke.0.1621430365457;
        Wed, 19 May 2021 06:19:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d23sm14837868qtg.69.2021.05.19.06.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 06:19:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>, jmp@epiphyte.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
References: <20210430132735.127342-1-robert.marko@sartura.hr>
 <20210430134810.GA2714262@roeck-us.net>
 <CA+HBbNH+gQOmu_Ho0ivFuGHdu0zBtOrr1474z+7FA1zmNb4bug@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/3] hwmon: (pmbus) Add driver for Delta DPS-920AB PSU
Message-ID: <2b990feb-dc26-debb-4f81-430bbc89b51c@roeck-us.net>
Date:   Wed, 19 May 2021 06:19:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CA+HBbNH+gQOmu_Ho0ivFuGHdu0zBtOrr1474z+7FA1zmNb4bug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 5:38 AM, Robert Marko wrote:
> On Fri, Apr 30, 2021 at 3:48 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Fri, Apr 30, 2021 at 03:27:33PM +0200, Robert Marko wrote:
>>> This adds support for the Delta DPS-920AB PSU.
>>>
>>> Only missing feature is fan control which the PSU supports.
>>>
>>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>>> ---
>>>   Documentation/hwmon/dps920ab.rst | 80 ++++++++++++++++++++++++++++++++
>>>   Documentation/hwmon/index.rst    |  1 +
>>>   drivers/hwmon/pmbus/Kconfig      |  9 ++++
>>>   drivers/hwmon/pmbus/Makefile     |  1 +
>>>   drivers/hwmon/pmbus/dps920ab.c   | 63 +++++++++++++++++++++++++
>>>   5 files changed, 154 insertions(+)
>>>   create mode 100644 Documentation/hwmon/dps920ab.rst
>>>   create mode 100644 drivers/hwmon/pmbus/dps920ab.c
>>>
>>> diff --git a/Documentation/hwmon/dps920ab.rst b/Documentation/hwmon/dps920ab.rst
>>> new file mode 100644
>>> index 000000000000..df0aef530c7e
>>> --- /dev/null
>>> +++ b/Documentation/hwmon/dps920ab.rst
>>> @@ -0,0 +1,80 @@
>>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +Kernel driver dps920ab
>>> +========================
>>> +
>>> +Supported chips:
>>> +
>>> +  * Delta DPS920AB
>>> +
>>> +    Prefix: 'dps920ab'
>>> +
>>> +    Addresses scanned: -
>>> +
>>> +Authors:
>>> +    Robert Marko <robert.marko@sartura.hr>
>>> +
>>> +
>>> +Description
>>> +-----------
>>> +
>>> +This driver implements support for Delta DPS920AB 920W 54V DC single output
>>> +power supply with PMBus support.
>>> +
>>> +The driver is a client driver to the core PMBus driver.
>>> +Please see Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
>>> +
>>> +
>>> +Usage Notes
>>> +-----------
>>> +
>>> +This driver does not auto-detect devices. You will have to instantiate the
>>> +devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
>>> +details.
>>> +
>>> +
>>> +Sysfs entries
>>> +-------------
>>> +
>>> +======================= ======================================================
>>> +curr1_label          "iin"
>>> +curr1_input          Measured input current
>>> +curr1_crit           Critical maximum current
>>> +curr1_crit_alarm     Current critical high alarm
>>> +
>>> +curr2_label          "iout1"
>>> +curr2_input          Measured output current
>>> +curr2_crit           Critical maximum current
>>> +curr2_crit_alarm     Current critical high alarm
>>> +
>>> +in1_label            "vin"
>>> +in1_input            Measured input voltage
>>> +in1_lcrit            Critical minimum input voltage
>>> +in1_lcrit_alarm              Input voltage critical low alarm
>>> +in1_crit             Critical maximum input voltage
>>> +in1_crit_alarm               Input voltage critical high alarm
>>> +
>>> +in2_label            "vout1"
>>> +in2_input            Measured output voltage
>>> +in2_lcrit            Critical minimum output voltage
>>> +in2_lcrit_alarm              Output voltage critical low alarm
>>> +in2_crit             Critical maximum output voltage
>>> +in2_crit_alarm               Output voltage critical high alarm
>>> +
>>> +power1_label         "pin"
>>> +power1_input         Measured input power
>>> +power1_alarm         Input power high alarm
>>> +
>>> +power2_label         "pout1"
>>> +power2_input         Measured output power
>>> +
>>> +temp[1-2]_input              Measured temperature
>>> +temp[1-2]_crit               Critical high temperature
>>> +temp[1-2]_crit_alarm Chip temperature critical high alarm
>>> +temp[1-2]_max                Maximum temperature
>>> +temp[1-2]_max_alarm  Chip temperature high alarm
>>> +
>>> +fan1_alarm           Fan 1 warning.
>>> +fan1_fault           Fan 1 fault.
>>> +fan1_input           Fan 1 speed in RPM.
>>> +======================= ======================================================
>>> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
>>> index 8d5a2df1ecb6..b24436f22052 100644
>>> --- a/Documentation/hwmon/index.rst
>>> +++ b/Documentation/hwmon/index.rst
>>> @@ -54,6 +54,7 @@ Hardware Monitoring Kernel Drivers
>>>      dell-smm-hwmon
>>>      dme1737
>>>      drivetemp
>>> +   dps920ab
>>>      ds1621
>>>      ds620
>>>      emc1403
>>> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
>>> index 32d2fc850621..865ade0aa205 100644
>>> --- a/drivers/hwmon/pmbus/Kconfig
>>> +++ b/drivers/hwmon/pmbus/Kconfig
>>> @@ -66,6 +66,15 @@ config SENSORS_IBM_CFFPS
>>>          This driver can also be built as a module. If so, the module will
>>>          be called ibm-cffps.
>>>
>>> +config SENSORS_DPS920AB
>>> +     tristate "Delta DPS920AB Power Supply"
>>> +     help
>>> +       If you say yes here you get hardware monitoring support for Delta
>>> +       DPS920AB Power Supplies.
>>> +
>>> +       This driver can also be built as a module. If so, the module will
>>> +       be called dps920ab.
>>> +
>>>   config SENSORS_INSPUR_IPSPS
>>>        tristate "INSPUR Power System Power Supply"
>>>        help
>>> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
>>> index 6a4ba0fdc1db..f59ba0123d68 100644
>>> --- a/drivers/hwmon/pmbus/Makefile
>>> +++ b/drivers/hwmon/pmbus/Makefile
>>> @@ -9,6 +9,7 @@ obj-$(CONFIG_SENSORS_ADM1266) += adm1266.o
>>>   obj-$(CONFIG_SENSORS_ADM1275)        += adm1275.o
>>>   obj-$(CONFIG_SENSORS_BEL_PFE)        += bel-pfe.o
>>>   obj-$(CONFIG_SENSORS_IBM_CFFPS)      += ibm-cffps.o
>>> +obj-$(CONFIG_SENSORS_DPS920AB)       += dps920ab.o
>>>   obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
>>>   obj-$(CONFIG_SENSORS_IR35221)        += ir35221.o
>>>   obj-$(CONFIG_SENSORS_IR38064)        += ir38064.o
>>> diff --git a/drivers/hwmon/pmbus/dps920ab.c b/drivers/hwmon/pmbus/dps920ab.c
>>> new file mode 100644
>>> index 000000000000..d579ed9f879c
>>> --- /dev/null
>>> +++ b/drivers/hwmon/pmbus/dps920ab.c
>>> @@ -0,0 +1,63 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Driver for Delta DPS920AB PSU
>>> + *
>>> + * Copyright (C) 2021 Delta Networks, Inc.
>>> + * Copyright (C) 2021 Sartura Ltd.
>>> + */
>>> +
>>> +#include <linux/i2c.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_device.h>
>>> +#include "pmbus.h"
>>> +
>>> +static struct pmbus_driver_info dps920ab_info = {
>>> +     .pages = 1,
>>> +
>>> +     .format[PSC_VOLTAGE_IN] = linear,
>>> +     .format[PSC_VOLTAGE_OUT] = linear,
>>> +     .format[PSC_CURRENT_IN] = linear,
>>> +     .format[PSC_CURRENT_OUT] = linear,
>>> +     .format[PSC_POWER] = linear,
>>> +     .format[PSC_FAN] = linear,
>>> +     .format[PSC_TEMPERATURE] = linear,
>>> +
>>> +     .func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN  |
>>> +     PMBUS_HAVE_VOUT  | PMBUS_HAVE_STATUS_VOUT   |
>>> +     PMBUS_HAVE_IOUT  | PMBUS_HAVE_STATUS_IOUT   |
>>> +     PMBUS_HAVE_TEMP  | PMBUS_HAVE_TEMP2         |
>>> +     PMBUS_HAVE_PIN   | PMBUS_HAVE_POUT          |
>>> +     PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12  |
>>> +     PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
>>> +};
>>> +
>>> +static int dps920ab_probe(struct i2c_client *client)
>>> +{
>>> +     if (!i2c_check_functionality(client->adapter,
>>> +                                  I2C_FUNC_SMBUS_BYTE_DATA |
>>> +                                  I2C_FUNC_SMBUS_WORD_DATA))
>>> +             return -ENODEV;
>>
>> This check is done in pmbus_do_probe(), and repeating it here does not add
>> any value.
> 
> Ok, makes sense.
>>
>> That makes me wonder: Is this driver needed in the first place, or could
>> it be added to drivers/hwmon/pmbus/pmbus.c ?
> 
> It could be added as a generic driver, but that creates properties in
> the sysfs that this thing
> does not support like 3 voltage readings, 3 fans, and so on.
> 

Can you be more specific ? What additional unsupported attributes
are added, and why ? Are you saying the PSU reports registers as
existing which do not really exist ? If so, which registers are those ?

In this context, I have a hard time finding a reference for
this power supply. Do you have a datasheet or some other documents
you can share ?

Thanks,
Guenter

> Is it okay to keep it as a separate driver then?
> 
> Regards,
> Robert
>>
>> Thanks,
>> Guenter
>>
>>> +
>>> +     return pmbus_do_probe(client, &dps920ab_info);
>>> +}
>>> +
>>> +static const struct of_device_id __maybe_unused dps920ab_of_match[] = {
>>> +     { .compatible = "delta,dps920ab", },
>>> +     {}
>>> +};
>>> +
>>> +MODULE_DEVICE_TABLE(of, dps920ab_of_match);
>>> +
>>> +static struct i2c_driver dps920ab_driver = {
>>> +     .driver = {
>>> +                .name = "dps920ab",
>>> +                .of_match_table = of_match_ptr(dps920ab_of_match),
>>> +     },
>>> +     .probe_new = dps920ab_probe,
>>> +};
>>> +
>>> +module_i2c_driver(dps920ab_driver);
>>> +
>>> +MODULE_AUTHOR("Robert Marko <robert.marko@sartura.hr>");
>>> +MODULE_DESCRIPTION("PMBus driver for Delta DPS920AB PSU");
>>> +MODULE_LICENSE("GPL");
>>> --
>>> 2.31.1
>>>
> 
> 
> 

