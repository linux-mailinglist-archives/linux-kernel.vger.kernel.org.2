Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B98038E67C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbhEXMXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhEXMXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:23:13 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA23AC061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 05:21:44 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id o21so27599073iow.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 05:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVj2UZLoMatA9yLbqF3L/VCYiqsHaiAQE0zqsL8wIdI=;
        b=rQwLftt4nazyTM34MEcdzFm95kKw/qDb+lj/oJ/fCUsvLe/wdkYqO/KnXYEMjVUCpD
         P1Bx0a4WNhRfTuJYPJfy4dga2js92QzTzgSkTGxLxs37cy8aKDJ3NJTOF/YLrRYdzuTm
         4MsnNyRMFp1xydtGY1ZFXH5TpsvVUAAu+Yl/csGOhQh8d/WI2hFpTQeWLU1NSYDFIxJA
         RFc9y9UXBzhNgGGL+b0fufm74NZhWJok+XInSBdYt/vgaiKT90U6feTMPyV9Anw+sn+3
         mgIiiTaYjStbw/SXqXSROBX570lqdyB8oku4MBldxIhmTxPua67nhU/8xATEzT/HN/Yq
         KG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVj2UZLoMatA9yLbqF3L/VCYiqsHaiAQE0zqsL8wIdI=;
        b=g9UJB/ksAvZEy/r1N8HOMLzXpRvQ0sXfrAdxnH6giqrzd6rHmd8cnO+LmlSdQ+Z/Vk
         dy+pNVGdPFWHQljWa2M89pyNi///5x1F2dLXK4i+r5vCZuSHksqVTS0fUYmVhPh4kQSn
         5dqICLBcbs77jzLQ21u4HhnqGMtty2fXt9mNuK/dwIEkSH/dKR+NxX10GO4/UvKFSEuL
         qaDJPxcI1++De+HUbiePAdcHG5c/XU5qOpX2kyfCYUuzKdXqgyGPxQXTmjALr4zfTZaj
         VVhtsAVy+Yk3hQQZp7UVt6vdVBNos/tHh/fRe2lYUihBPu4dgqYzVDLDmwDGqE4RiFzC
         ytIQ==
X-Gm-Message-State: AOAM533ThEcLvZBUydymrHp79XgVQuQJsD0quK8K+4vfKAzio/tV4cLn
        V1nuChKBUA39HDu4q+RAICVzkmgiQ02IweiHp8Loww==
X-Google-Smtp-Source: ABdhPJyeZDM2ESdYBWhK72Pzpr2jdq4nGIYT5vBUDR2knIjSdQ6ct1SFTbKu8JCA8XzfkHrQ79RdUX9Sz42QLZDmiy4=
X-Received: by 2002:a05:6602:134c:: with SMTP id i12mr15667249iov.175.1621858903879;
 Mon, 24 May 2021 05:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210430132735.127342-1-robert.marko@sartura.hr>
 <20210430134810.GA2714262@roeck-us.net> <CA+HBbNH+gQOmu_Ho0ivFuGHdu0zBtOrr1474z+7FA1zmNb4bug@mail.gmail.com>
 <2b990feb-dc26-debb-4f81-430bbc89b51c@roeck-us.net> <CA+HBbNHQHqD-wgryaBLZ5M2Lxafb0OwNcbiQJmRQPcZfprmUEg@mail.gmail.com>
 <2a1a63c7-c9b0-e38d-df1d-7643ad493aba@roeck-us.net> <CA+HBbNF62xzBt2r60qfzn9iveiusLKp6R-T4KU-NgoHaE6c3kQ@mail.gmail.com>
 <dec7d641-2954-29f0-124b-d0020866bf7b@roeck-us.net>
In-Reply-To: <dec7d641-2954-29f0-124b-d0020866bf7b@roeck-us.net>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Mon, 24 May 2021 14:21:32 +0200
Message-ID: <CA+HBbNGU4d4g0JrUKBhj07OsC7=s9qoubxNDi3MxPjmV457C+Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (pmbus) Add driver for Delta DPS-920AB PSU
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>, jmp@epiphyte.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 4:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 5/21/21 4:56 AM, Robert Marko wrote:
> > On Fri, May 21, 2021 at 12:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On 5/21/21 1:36 AM, Robert Marko wrote:
> >>> On Wed, May 19, 2021 at 3:19 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>>>
> >>>> On 5/19/21 5:38 AM, Robert Marko wrote:
> >>>>> On Fri, Apr 30, 2021 at 3:48 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>>>>>
> >>>>>> On Fri, Apr 30, 2021 at 03:27:33PM +0200, Robert Marko wrote:
> >>>>>>> This adds support for the Delta DPS-920AB PSU.
> >>>>>>>
> >>>>>>> Only missing feature is fan control which the PSU supports.
> >>>>>>>
> >>>>>>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> >>>>>>> ---
> >>>>>>>     Documentation/hwmon/dps920ab.rst | 80 ++++++++++++++++++++++++++++++++
> >>>>>>>     Documentation/hwmon/index.rst    |  1 +
> >>>>>>>     drivers/hwmon/pmbus/Kconfig      |  9 ++++
> >>>>>>>     drivers/hwmon/pmbus/Makefile     |  1 +
> >>>>>>>     drivers/hwmon/pmbus/dps920ab.c   | 63 +++++++++++++++++++++++++
> >>>>>>>     5 files changed, 154 insertions(+)
> >>>>>>>     create mode 100644 Documentation/hwmon/dps920ab.rst
> >>>>>>>     create mode 100644 drivers/hwmon/pmbus/dps920ab.c
> >>>>>>>
> >>>>>>> diff --git a/Documentation/hwmon/dps920ab.rst b/Documentation/hwmon/dps920ab.rst
> >>>>>>> new file mode 100644
> >>>>>>> index 000000000000..df0aef530c7e
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/Documentation/hwmon/dps920ab.rst
> >>>>>>> @@ -0,0 +1,80 @@
> >>>>>>> +.. SPDX-License-Identifier: GPL-2.0-or-later
> >>>>>>> +
> >>>>>>> +Kernel driver dps920ab
> >>>>>>> +========================
> >>>>>>> +
> >>>>>>> +Supported chips:
> >>>>>>> +
> >>>>>>> +  * Delta DPS920AB
> >>>>>>> +
> >>>>>>> +    Prefix: 'dps920ab'
> >>>>>>> +
> >>>>>>> +    Addresses scanned: -
> >>>>>>> +
> >>>>>>> +Authors:
> >>>>>>> +    Robert Marko <robert.marko@sartura.hr>
> >>>>>>> +
> >>>>>>> +
> >>>>>>> +Description
> >>>>>>> +-----------
> >>>>>>> +
> >>>>>>> +This driver implements support for Delta DPS920AB 920W 54V DC single output
> >>>>>>> +power supply with PMBus support.
> >>>>>>> +
> >>>>>>> +The driver is a client driver to the core PMBus driver.
> >>>>>>> +Please see Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
> >>>>>>> +
> >>>>>>> +
> >>>>>>> +Usage Notes
> >>>>>>> +-----------
> >>>>>>> +
> >>>>>>> +This driver does not auto-detect devices. You will have to instantiate the
> >>>>>>> +devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
> >>>>>>> +details.
> >>>>>>> +
> >>>>>>> +
> >>>>>>> +Sysfs entries
> >>>>>>> +-------------
> >>>>>>> +
> >>>>>>> +======================= ======================================================
> >>>>>>> +curr1_label          "iin"
> >>>>>>> +curr1_input          Measured input current
> >>>>>>> +curr1_crit           Critical maximum current
> >>>>>>> +curr1_crit_alarm     Current critical high alarm
> >>>>>>> +
> >>>>>>> +curr2_label          "iout1"
> >>>>>>> +curr2_input          Measured output current
> >>>>>>> +curr2_crit           Critical maximum current
> >>>>>>> +curr2_crit_alarm     Current critical high alarm
> >>>>>>> +
> >>>>>>> +in1_label            "vin"
> >>>>>>> +in1_input            Measured input voltage
> >>>>>>> +in1_lcrit            Critical minimum input voltage
> >>>>>>> +in1_lcrit_alarm              Input voltage critical low alarm
> >>>>>>> +in1_crit             Critical maximum input voltage
> >>>>>>> +in1_crit_alarm               Input voltage critical high alarm
> >>>>>>> +
> >>>>>>> +in2_label            "vout1"
> >>>>>>> +in2_input            Measured output voltage
> >>>>>>> +in2_lcrit            Critical minimum output voltage
> >>>>>>> +in2_lcrit_alarm              Output voltage critical low alarm
> >>>>>>> +in2_crit             Critical maximum output voltage
> >>>>>>> +in2_crit_alarm               Output voltage critical high alarm
> >>>>>>> +
> >>>>>>> +power1_label         "pin"
> >>>>>>> +power1_input         Measured input power
> >>>>>>> +power1_alarm         Input power high alarm
> >>>>>>> +
> >>>>>>> +power2_label         "pout1"
> >>>>>>> +power2_input         Measured output power
> >>>>>>> +
> >>>>>>> +temp[1-2]_input              Measured temperature
> >>>>>>> +temp[1-2]_crit               Critical high temperature
> >>>>>>> +temp[1-2]_crit_alarm Chip temperature critical high alarm
> >>>>>>> +temp[1-2]_max                Maximum temperature
> >>>>>>> +temp[1-2]_max_alarm  Chip temperature high alarm
> >>>>>>> +
> >>>>>>> +fan1_alarm           Fan 1 warning.
> >>>>>>> +fan1_fault           Fan 1 fault.
> >>>>>>> +fan1_input           Fan 1 speed in RPM.
> >>>>>>> +======================= ======================================================
> >>>>>>> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> >>>>>>> index 8d5a2df1ecb6..b24436f22052 100644
> >>>>>>> --- a/Documentation/hwmon/index.rst
> >>>>>>> +++ b/Documentation/hwmon/index.rst
> >>>>>>> @@ -54,6 +54,7 @@ Hardware Monitoring Kernel Drivers
> >>>>>>>        dell-smm-hwmon
> >>>>>>>        dme1737
> >>>>>>>        drivetemp
> >>>>>>> +   dps920ab
> >>>>>>>        ds1621
> >>>>>>>        ds620
> >>>>>>>        emc1403
> >>>>>>> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> >>>>>>> index 32d2fc850621..865ade0aa205 100644
> >>>>>>> --- a/drivers/hwmon/pmbus/Kconfig
> >>>>>>> +++ b/drivers/hwmon/pmbus/Kconfig
> >>>>>>> @@ -66,6 +66,15 @@ config SENSORS_IBM_CFFPS
> >>>>>>>            This driver can also be built as a module. If so, the module will
> >>>>>>>            be called ibm-cffps.
> >>>>>>>
> >>>>>>> +config SENSORS_DPS920AB
> >>>>>>> +     tristate "Delta DPS920AB Power Supply"
> >>>>>>> +     help
> >>>>>>> +       If you say yes here you get hardware monitoring support for Delta
> >>>>>>> +       DPS920AB Power Supplies.
> >>>>>>> +
> >>>>>>> +       This driver can also be built as a module. If so, the module will
> >>>>>>> +       be called dps920ab.
> >>>>>>> +
> >>>>>>>     config SENSORS_INSPUR_IPSPS
> >>>>>>>          tristate "INSPUR Power System Power Supply"
> >>>>>>>          help
> >>>>>>> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> >>>>>>> index 6a4ba0fdc1db..f59ba0123d68 100644
> >>>>>>> --- a/drivers/hwmon/pmbus/Makefile
> >>>>>>> +++ b/drivers/hwmon/pmbus/Makefile
> >>>>>>> @@ -9,6 +9,7 @@ obj-$(CONFIG_SENSORS_ADM1266) += adm1266.o
> >>>>>>>     obj-$(CONFIG_SENSORS_ADM1275)        += adm1275.o
> >>>>>>>     obj-$(CONFIG_SENSORS_BEL_PFE)        += bel-pfe.o
> >>>>>>>     obj-$(CONFIG_SENSORS_IBM_CFFPS)      += ibm-cffps.o
> >>>>>>> +obj-$(CONFIG_SENSORS_DPS920AB)       += dps920ab.o
> >>>>>>>     obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
> >>>>>>>     obj-$(CONFIG_SENSORS_IR35221)        += ir35221.o
> >>>>>>>     obj-$(CONFIG_SENSORS_IR38064)        += ir38064.o
> >>>>>>> diff --git a/drivers/hwmon/pmbus/dps920ab.c b/drivers/hwmon/pmbus/dps920ab.c
> >>>>>>> new file mode 100644
> >>>>>>> index 000000000000..d579ed9f879c
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/drivers/hwmon/pmbus/dps920ab.c
> >>>>>>> @@ -0,0 +1,63 @@
> >>>>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
> >>>>>>> +/*
> >>>>>>> + * Driver for Delta DPS920AB PSU
> >>>>>>> + *
> >>>>>>> + * Copyright (C) 2021 Delta Networks, Inc.
> >>>>>>> + * Copyright (C) 2021 Sartura Ltd.
> >>>>>>> + */
> >>>>>>> +
> >>>>>>> +#include <linux/i2c.h>
> >>>>>>> +#include <linux/module.h>
> >>>>>>> +#include <linux/of_device.h>
> >>>>>>> +#include "pmbus.h"
> >>>>>>> +
> >>>>>>> +static struct pmbus_driver_info dps920ab_info = {
> >>>>>>> +     .pages = 1,
> >>>>>>> +
> >>>>>>> +     .format[PSC_VOLTAGE_IN] = linear,
> >>>>>>> +     .format[PSC_VOLTAGE_OUT] = linear,
> >>>>>>> +     .format[PSC_CURRENT_IN] = linear,
> >>>>>>> +     .format[PSC_CURRENT_OUT] = linear,
> >>>>>>> +     .format[PSC_POWER] = linear,
> >>>>>>> +     .format[PSC_FAN] = linear,
> >>>>>>> +     .format[PSC_TEMPERATURE] = linear,
> >>>>>>> +
> >>>>>>> +     .func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN  |
> >>>>>>> +     PMBUS_HAVE_VOUT  | PMBUS_HAVE_STATUS_VOUT   |
> >>>>>>> +     PMBUS_HAVE_IOUT  | PMBUS_HAVE_STATUS_IOUT   |
> >>>>>>> +     PMBUS_HAVE_TEMP  | PMBUS_HAVE_TEMP2         |
> >>>>>>> +     PMBUS_HAVE_PIN   | PMBUS_HAVE_POUT          |
> >>>>>>> +     PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12  |
> >>>>>>> +     PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +static int dps920ab_probe(struct i2c_client *client)
> >>>>>>> +{
> >>>>>>> +     if (!i2c_check_functionality(client->adapter,
> >>>>>>> +                                  I2C_FUNC_SMBUS_BYTE_DATA |
> >>>>>>> +                                  I2C_FUNC_SMBUS_WORD_DATA))
> >>>>>>> +             return -ENODEV;
> >>>>>>
> >>>>>> This check is done in pmbus_do_probe(), and repeating it here does not add
> >>>>>> any value.
> >>>>>
> >>>>> Ok, makes sense.
> >>>>>>
> >>>>>> That makes me wonder: Is this driver needed in the first place, or could
> >>>>>> it be added to drivers/hwmon/pmbus/pmbus.c ?
> >>>>>
> >>>>> It could be added as a generic driver, but that creates properties in
> >>>>> the sysfs that this thing
> >>>>> does not support like 3 voltage readings, 3 fans, and so on.
> >>>>>
> >>>>
> >>>> Can you be more specific ? What additional unsupported attributes
> >>>> are added, and why ? Are you saying the PSU reports registers as
> >>>> existing which do not really exist ? If so, which registers are those ?
> >>>
> >>> Sure, when core does probing and autodiscovery, then the following
> >>> sysfs attributes are created:
> >>>>
> >>>> curr1_crit         fan3_fault       in3_min_alarm      temp1_max
> >>>> curr1_crit_alarm   fan3_input       in3_rated_max      temp1_max_alarm
> >>>> curr1_input        fan3_target      in3_rated_min      temp1_min
> >>>> curr1_label        in1_crit         name               temp1_min_alarm
> >>>> curr1_max          in1_crit_alarm   of_node            temp1_rated_max
> >>>> curr1_max_alarm    in1_input        power              temp2_crit
> >>>> curr1_rated_max    in1_label        power1_alarm       temp2_crit_alarm
> >>>> curr2_crit         in1_lcrit        power1_input       temp2_input
> >>>> curr2_crit_alarm   in1_lcrit_alarm  power1_label       temp2_lcrit
> >>>> curr2_input        in1_max          power1_max         temp2_lcrit_alarm
> >>>> curr2_label        in1_max_alarm    power1_rated_max   temp2_max
> >>>> curr2_lcrit        in1_min          power2_cap         temp2_max_alarm
> >>>> curr2_lcrit_alarm  in1_min_alarm    power2_cap_alarm   temp2_min
> >>>> curr2_max          in1_rated_max    power2_crit        temp2_min_alarm
> >>>> curr2_max_alarm    in1_rated_min    power2_crit_alarm  temp2_rated_max
> >>>> curr2_rated_max    in2_input        power2_input       temp3_crit
> >>>> device             in2_label        power2_label       temp3_crit_alarm
> >>>> fan1_alarm         in3_crit         power2_max         temp3_input
> >>>> fan1_fault         in3_crit_alarm   power2_max_alarm   temp3_lcrit
> >>>> fan1_input         in3_input        power2_rated_max   temp3_lcrit_alarm
> >>>> fan1_target        in3_label        subsystem          temp3_max
> >>>> fan2_alarm         in3_lcrit        temp1_crit         temp3_max_alarm
> >>>> fan2_fault         in3_lcrit_alarm  temp1_crit_alarm   temp3_min
> >>>> fan2_input         in3_max          temp1_input        temp3_min_alarm
> >>>> fan2_target        in3_max_alarm    temp1_lcrit        temp3_rated_max
> >>>> fan3_alarm         in3_min          temp1_lcrit_alarm  uevent
> >>>
> >>> The following return -1, or -500 so they are not supported.
> >>> * fan2
> >>> * in2
> >>>
> >>> Weirdly, with the external driver both fan2 and in2 are enabled and work fine,
> >>> but when auto probing they are fan3 and in3.
> >>>
> >>> temp3 actually seems to return a valid temperature despite it not being used in
> >>> the vendor driver that features were picked from.
> >>>
> >>
> >> Can you run "grep . *" in the hwmon directory so I can see actual values ?
> >>
> > Sure:
> >>
> >> curr1_crit:-500
> >> curr1_crit_alarm:0
> >> curr1_input:195
> >> curr1_label:iin
> >> curr1_max:-500
> >> curr1_max_alarm:0
> >> curr1_rated_max:-500
> >> curr2_crit:-500
> >> curr2_crit_alarm:0
> >> curr2_input:320
> >> curr2_label:iout1
> >> curr2_lcrit:-500
> >> curr2_lcrit_alarm:0
> >> curr2_max:18625
> >> curr2_max_alarm:0
> >> curr2_rated_max:16875
> >> grep: device: Is a directory
> >> fan1_alarm:0
> >> fan1_fault:0
> >> fan1_input:10000
> >> fan1_target:0
> >> fan2_alarm:1
> >> fan2_fault:1
> >> fan2_input:-1
> >> fan2_target:-1
> >> fan3_alarm:1
> >> fan3_fault:1
> >> fan3_input:-1
> >> fan3_target:-1
> >> in1_crit:-500
> >> in1_crit_alarm:0
> >> in1_input:245250
> >> in1_label:vin
> >> in1_lcrit:-500
> >> in1_lcrit_alarm:0
> >> in1_max:-500
> >> in1_max_alarm:0
> >> in1_min:-500
> >> in1_min_alarm:0
> >> in1_rated_max:-500
> >> in1_rated_min:-500
> >> in2_input:-500
> >> in2_label:vcap
> >> in3_crit:255996
> >> in3_crit_alarm:0
> >> in3_input:54511
> >> in3_label:vout1
> >> in3_lcrit:255996
> >> in3_lcrit_alarm:0
> >> in3_max:255996
> >> in3_max_alarm:0
> >> in3_min:255996
> >> in3_min_alarm:0
> >> in3_rated_max:56136
> >> in3_rated_min:52863
> >> name:dps920ab
> >> grep: of_node: Is a directory
> >> grep: power: Is a directory
> >> power1_alarm:0
> >> power1_input:33250000
> >> power1_label:pin
> >> power1_max:-500000
> >> power1_rated_max:-500000
> >> power2_cap:-500000
> >> power2_cap_alarm:0
> >> power2_crit:-500000
> >> power2_crit_alarm:0
> >> power2_input:17750000
> >> power2_label:pout1
> >> power2_max:-500000
> >> power2_max_alarm:0
> >> power2_rated_max:920000000
> >> grep: subsystem: Is a directory
> >> temp1_crit:-500
> >> temp1_crit_alarm:0
> >> temp1_input:23000
> >> temp1_lcrit:-500
> >> temp1_lcrit_alarm:0
> >> temp1_max:-500
> >> temp1_max_alarm:0
> >> temp1_min:-500
> >> temp1_min_alarm:0
> >> temp1_rated_max:-500
> >> temp2_crit:-500
> >> temp2_crit_alarm:0
> >> temp2_input:26000
> >> temp2_lcrit:-500
> >> temp2_lcrit_alarm:0
> >> temp2_max:-500
> >> temp2_max_alarm:0
> >> temp2_min:-500
> >> temp2_min_alarm:0
> >> temp2_rated_max:-500
> >> temp3_crit:-500
> >> temp3_crit_alarm:0
> >> temp3_input:30000
> >> temp3_lcrit:-500
> >> temp3_lcrit_alarm:0
> >> temp3_max:-500
> >> temp3_max_alarm:0
> >> temp3_min:-500
> >> temp3_min_alarm:0
> >> temp3_rated_max:-500
> >> uevent:OF_NAME=psu
> >> uevent:OF_FULLNAME=/ap806/config-space@f0000000/i2c@511000/psu@5a
> >> uevent:OF_COMPATIBLE_0=delta,dps920ab
> >> uevent:OF_COMPATIBLE_N=1
> >
> Ok, good enough. It looks like the PSU reports values for pretty much everything,
> including registers which don't exist. With that in mind, please check
> the attributes generated by your driver - I suspect that some of the limit
> attributes are not really supported (maybe none of them is supported).

Yeah, I also think that none of those limits are actually supported.
Does the core expose a way to not register those?

Regards,
Robert
>
> Thanks,
> Guenter



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
