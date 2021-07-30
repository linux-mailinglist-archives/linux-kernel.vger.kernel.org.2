Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4EF3DC0B2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhG3WER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhG3WEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:04:16 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99D6C06175F;
        Fri, 30 Jul 2021 15:04:09 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id y16-20020a4ad6500000b0290258a7ff4058so2835790oos.10;
        Fri, 30 Jul 2021 15:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wUP1BgseC6tSB6JNAuINIIrW5cUErVIle+viqWt4Iuo=;
        b=P9UdE1XewAPggorFpMw/zMxUcpbk8l+M4UkKvLqGtLkEIAO1MbXAOpBRuLFHmu6d42
         eJY33J9aFqgEQf9ZkmM2bv/V3s9WWJsfRkmNJFV6YIQXnskuayz+A44w5vh33P8HYyMk
         /1UM0ZQfrCLSvunbXMbMWoGrMforyQiiqCpHrIaMI2z6tOc8PWg0+ha0TIyA5QxZOqMc
         hsDn/t/uhcqziPMcJCyWQ67AdlYi38rfIbySGl+8QuuqluHHQsyqza6Tfi/eTVI5L+t8
         tRpFly3VGC7hukiXkwyy2RkkmRSzAtGsvGvdIlACazq4Y8EYfU4bgUWK+LgCpb7V2CMI
         PnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wUP1BgseC6tSB6JNAuINIIrW5cUErVIle+viqWt4Iuo=;
        b=oEWHLtZ6JE60gJWYxkbD6FQsPHlobyRo10pY4FGqSjqRHrf2rZPyyh7W4QV4KEMA4E
         HIY0j0MBlFAem0qm/cwKIosh6MzSpzDRsdmHFcxUTVrJXIIQglApcp8TSzfTx0ry+Zz1
         pPps0A8BN3N+g7Zj66y/zAI5uu0h4YTfyef6SaI48zsfve0NRmViz01bxUMzGZxN/Rc2
         xfBJgPDriIEx9CwUFEmcx396wImL4U2XH7g7b6HmWaWgxSpxvzIdG/dRWuI3MqDGAI1O
         SKrmsmIAoq9WWUoyK8YZHRvIjn6i423v33tk4nKlT2e10h5rk2H/3jNqP8CtFQ7D8Swf
         aAvQ==
X-Gm-Message-State: AOAM532rYBsAENKUcKn8DycGxPQE8uUuJuZ1b0kBku1Nfc56ZxgmVzns
        PcHdm55MreTIPW4HxnJo7tc=
X-Google-Smtp-Source: ABdhPJyMBvekK204B3pdaOAubKIaxxGLbkUU6FXTQw39m6gYKgcRxNFKnFTk2O3560uAR2Mtl9SU3w==
X-Received: by 2002:a4a:3f01:: with SMTP id e1mr3349644ooa.86.1627682649248;
        Fri, 30 Jul 2021 15:04:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c11sm518006otm.37.2021.07.30.15.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 15:04:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 11/14] hwmon: peci: Add cputemp driver
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>,
        "zweiss@equinix.com" <zweiss@equinix.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-12-iwona.winiarska@intel.com>
 <20210727070651.GP8018@packtop>
 <fb4ace5c357832e8b5131a5e6f8e07ed42c7f634.camel@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5613c531-5c6a-c2ec-9081-63db50a108b3@roeck-us.net>
Date:   Fri, 30 Jul 2021 15:04:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fb4ace5c357832e8b5131a5e6f8e07ed42c7f634.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/21 2:51 PM, Winiarska, Iwona wrote:
> On Tue, 2021-07-27 at 07:06 +0000, Zev Weiss wrote:
>> On Mon, Jul 12, 2021 at 05:04:44PM CDT, Iwona Winiarska wrote:
>>> Add peci-cputemp driver for Digital Thermal Sensor (DTS) thermal
>>> readings of the processor package and processor cores that are
>>> accessible via the PECI interface.
>>>
>>> The main use case for the driver (and PECI interface) is out-of-band
>>> management, where we're able to obtain the DTS readings from an external
>>> entity connected with PECI, e.g. BMC on server platforms.
>>>
>>> Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
>>> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>> ---
>>> MAINTAINERS                  |   7 +
>>> drivers/hwmon/Kconfig        |   2 +
>>> drivers/hwmon/Makefile       |   1 +
>>> drivers/hwmon/peci/Kconfig   |  18 ++
>>> drivers/hwmon/peci/Makefile  |   5 +
>>> drivers/hwmon/peci/common.h  |  46 ++++
>>> drivers/hwmon/peci/cputemp.c | 503 +++++++++++++++++++++++++++++++++++
>>> 7 files changed, 582 insertions(+)
>>> create mode 100644 drivers/hwmon/peci/Kconfig
>>> create mode 100644 drivers/hwmon/peci/Makefile
>>> create mode 100644 drivers/hwmon/peci/common.h
>>> create mode 100644 drivers/hwmon/peci/cputemp.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index f47b5f634293..35ba9e3646bd 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -14504,6 +14504,13 @@ L:     platform-driver-x86@vger.kernel.org
>>> S:      Maintained
>>> F:      drivers/platform/x86/peaq-wmi.c
>>>
>>> +PECI HARDWARE MONITORING DRIVERS
>>> +M:     Iwona Winiarska <iwona.winiarska@intel.com>
>>> +R:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>> +L:     linux-hwmon@vger.kernel.org
>>> +S:     Supported
>>> +F:     drivers/hwmon/peci/
>>> +
>>> PECI SUBSYSTEM
>>> M:      Iwona Winiarska <iwona.winiarska@intel.com>
>>> R:      Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>> index e3675377bc5d..61c0e3404415 100644
>>> --- a/drivers/hwmon/Kconfig
>>> +++ b/drivers/hwmon/Kconfig
>>> @@ -1507,6 +1507,8 @@ config SENSORS_PCF8591
>>>            These devices are hard to detect and rarely found on mainstream
>>>            hardware. If unsure, say N.
>>>
>>> +source "drivers/hwmon/peci/Kconfig"
>>> +
>>> source "drivers/hwmon/pmbus/Kconfig"
>>>
>>> config SENSORS_PWM_FAN
>>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>>> index d712c61c1f5e..f52331f212ed 100644
>>> --- a/drivers/hwmon/Makefile
>>> +++ b/drivers/hwmon/Makefile
>>> @@ -202,6 +202,7 @@ obj-$(CONFIG_SENSORS_WM8350)        += wm8350-hwmon.o
>>> obj-$(CONFIG_SENSORS_XGENE)     += xgene-hwmon.o
>>>
>>> obj-$(CONFIG_SENSORS_OCC)       += occ/
>>> +obj-$(CONFIG_SENSORS_PECI)     += peci/
>>> obj-$(CONFIG_PMBUS)             += pmbus/
>>>
>>> ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
>>> diff --git a/drivers/hwmon/peci/Kconfig b/drivers/hwmon/peci/Kconfig
>>> new file mode 100644
>>> index 000000000000..e10eed68d70a
>>> --- /dev/null
>>> +++ b/drivers/hwmon/peci/Kconfig
>>> @@ -0,0 +1,18 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +config SENSORS_PECI_CPUTEMP
>>> +       tristate "PECI CPU temperature monitoring client"
>>> +       depends on PECI
>>> +       select SENSORS_PECI
>>> +       select PECI_CPU
>>> +       help
>>> +         If you say yes here you get support for the generic Intel PECI
>>> +         cputemp driver which provides Digital Thermal Sensor (DTS) thermal
>>> +         readings of the CPU package and CPU cores that are accessible via
>>> +         the processor PECI interface.
>>> +
>>> +         This driver can also be built as a module. If so, the module
>>> +         will be called peci-cputemp.
>>> +
>>> +config SENSORS_PECI
>>> +       tristate
>>> diff --git a/drivers/hwmon/peci/Makefile b/drivers/hwmon/peci/Makefile
>>> new file mode 100644
>>> index 000000000000..e8a0ada5ab1f
>>> --- /dev/null
>>> +++ b/drivers/hwmon/peci/Makefile
>>> @@ -0,0 +1,5 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +peci-cputemp-y := cputemp.o
>>> +
>>> +obj-$(CONFIG_SENSORS_PECI_CPUTEMP)     += peci-cputemp.o
>>> diff --git a/drivers/hwmon/peci/common.h b/drivers/hwmon/peci/common.h
>>> new file mode 100644
>>> index 000000000000..54580c100d06
>>> --- /dev/null
>>> +++ b/drivers/hwmon/peci/common.h
>>> @@ -0,0 +1,46 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/* Copyright (c) 2021 Intel Corporation */
>>> +
>>> +#include <linux/types.h>
>>> +
>>> +#ifndef __PECI_HWMON_COMMON_H
>>> +#define __PECI_HWMON_COMMON_H
>>> +
>>> +#define UPDATE_INTERVAL_DEFAULT                HZ
>>> +
>>> +/**
>>> + * struct peci_sensor_data - PECI sensor information
>>> + * @valid: flag to indicate the sensor value is valid
>>> + * @value: sensor value in milli units
>>> + * @last_updated: time of the last update in jiffies
>>> + */
>>> +struct peci_sensor_data {
>>> +       unsigned int valid;
>>
>>  From what I can see it looks like the 'valid' member here is strictly a
>> one-shot has-this-value-ever-been-set indicator, which seems a bit
>> wasteful to keep around forever post initialization; couldn't the same
>> information be inferred from checking last_updated != 0 or something?
> 
> That's just expressed in jiffies, which means it can overflow (we're just
> unlikely to hit it - but IIUC it can happen).
> Doing it this way would require making sure that last_updated is never set to 0
> in code that does the update. I don't think it's worth to add more complexity
> there just to save a couple of bytes.
> 

Correct. There are ways around that (eg by setting 'last_updated' to some time
in the past), but that isn't really worth the trouble.

'valid' should be bool, though, not "unsigned int".

Guenter

>>
>>> +       s32 value;
>>> +       unsigned long last_updated;
>>> +};
>>> +
>>> +/**
>>> + * peci_sensor_need_update() - check whether sensor update is needed or not
>>> + * @sensor: pointer to sensor data struct
>>> + *
>>> + * Return: true if update is needed, false if not.
>>> + */
>>> +
>>> +static inline bool peci_sensor_need_update(struct peci_sensor_data *sensor)
>>> +{
>>> +       return !sensor->valid ||
>>> +              time_after(jiffies, sensor->last_updated +
>>> UPDATE_INTERVAL_DEFAULT);
>>> +}
>>> +
>>> +/**
>>> + * peci_sensor_mark_updated() - mark the sensor is updated
>>> + * @sensor: pointer to sensor data struct
>>> + */
>>> +static inline void peci_sensor_mark_updated(struct peci_sensor_data
>>> *sensor)
>>> +{
>>> +       sensor->valid = 1;
>>> +       sensor->last_updated = jiffies;
>>> +}
>>> +
>>> +#endif /* __PECI_HWMON_COMMON_H */
>>> diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
>>> new file mode 100644
>>> index 000000000000..56a526471687
>>> --- /dev/null
>>> +++ b/drivers/hwmon/peci/cputemp.c
>>> @@ -0,0 +1,503 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +// Copyright (c) 2018-2021 Intel Corporation
>>> +
>>> +#include <linux/auxiliary_bus.h>
>>> +#include <linux/bitfield.h>
>>> +#include <linux/bitops.h>
>>> +#include <linux/hwmon.h>
>>> +#include <linux/jiffies.h>
>>> +#include <linux/module.h>
>>> +#include <linux/peci.h>
>>> +#include <linux/peci-cpu.h>
>>> +#include <linux/units.h>
>>> +#include <linux/x86/intel-family.h>
>>> +
>>> +#include "common.h"
>>> +
>>> +#define CORE_NUMS_MAX          64
>>> +
>>> +#define DEFAULT_CHANNEL_NUMS   5
>>
>> DEFAULT_ seems like a slightly odd prefix for this (it's not something
>> that can really be overridden or anything); would BASE_ perhaps be a bit
>> more appropriate?
> 
> Ack.
> 
>>
>>> +#define CORETEMP_CHANNEL_NUMS  CORE_NUMS_MAX
>>> +#define CPUTEMP_CHANNEL_NUMS   (DEFAULT_CHANNEL_NUMS +
>>> CORETEMP_CHANNEL_NUMS)
>>> +
>>> +#define TEMP_TARGET_FAN_TEMP_MASK      GENMASK(15, 8)
>>> +#define TEMP_TARGET_REF_TEMP_MASK      GENMASK(23, 16)
>>> +#define TEMP_TARGET_TJ_OFFSET_MASK     GENMASK(29, 24)
>>> +
>>> +#define DTS_MARGIN_MASK                GENMASK(15, 0)
>>> +#define PCS_MODULE_TEMP_MASK   GENMASK(15, 0)
>>> +
>>> +#define DTS_FIXED_POINT_FRACTION       64
>>> +
>>> +struct resolved_cores_reg {
>>> +       u8 bus;
>>> +       u8 dev;
>>> +       u8 func;
>>> +       u8 offset;
>>> +};
>>> +
>>> +struct cpu_info {
>>> +       struct resolved_cores_reg *reg;
>>> +       u8 min_peci_revision;
>>
>> As with the dimmtemp driver, min_peci_revision appears unused here,
>> though in this case if it were removed there'd only be one (pointer)
>> member left in struct cpu_info, so we could perhaps remove it as well
>> and then also a level of indirection in peci_cputemp_ids/cpu_{hsx,icx}
>> too?
> 
> As I mentioned in reply to previous patch comment, it'll be used to validate if
> PECI device revision matches driver requirements.
> 
>>
>>> +};
>>> +
>>> +struct peci_cputemp {
>>> +       struct peci_device *peci_dev;
>>> +       struct device *dev;
>>> +       const char *name;
>>> +       const struct cpu_info *gen_info;
>>> +       struct {
>>> +               struct peci_sensor_data die;
>>> +               struct peci_sensor_data dts;
>>> +               struct peci_sensor_data tcontrol;
>>> +               struct peci_sensor_data tthrottle;
>>> +               struct peci_sensor_data tjmax;
>>> +               struct peci_sensor_data core[CORETEMP_CHANNEL_NUMS];
>>> +       } temp;
>>> +       const char **coretemp_label;
>>> +       DECLARE_BITMAP(core_mask, CORE_NUMS_MAX);
>>> +};
>>> +
>>> +enum cputemp_channels {
>>> +       channel_die,
>>> +       channel_dts,
>>> +       channel_tcontrol,
>>> +       channel_tthrottle,
>>> +       channel_tjmax,
>>> +       channel_core,
>>> +};
>>> +
>>> +static const char *cputemp_label[DEFAULT_CHANNEL_NUMS] = {
>>
>> static const char * const cputemp_label?  (That is, const pointer to
>> const char, rather than non-const pointer to const char.)
> 
> Ack.
> 
>>
>>> +       "Die",
>>> +       "DTS",
>>> +       "Tcontrol",
>>> +       "Tthrottle",
>>> +       "Tjmax",
>>> +};
>>> +
>>> +static int get_temp_targets(struct peci_cputemp *priv)
>>> +{
>>> +       s32 tthrottle_offset, tcontrol_margin;
>>> +       u32 pcs;
>>> +       int ret;
>>> +
>>> +       /*
>>> +        * Just use only the tcontrol marker to determine if target values
>>> need
>>> +        * update.
>>> +        */
>>> +       if (!peci_sensor_need_update(&priv->temp.tcontrol))
>>> +               return 0;
>>> +
>>> +       ret = peci_pcs_read(priv->peci_dev, PECI_PCS_TEMP_TARGET, 0, &pcs);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       priv->temp.tjmax.value = FIELD_GET(TEMP_TARGET_REF_TEMP_MASK, pcs) *
>>> MILLIDEGREE_PER_DEGREE;
>>> +
>>> +       tcontrol_margin = FIELD_GET(TEMP_TARGET_FAN_TEMP_MASK, pcs);
>>> +       tcontrol_margin = sign_extend32(tcontrol_margin, 7) *
>>> MILLIDEGREE_PER_DEGREE;
>>> +       priv->temp.tcontrol.value = priv->temp.tjmax.value -
>>> tcontrol_margin;
>>> +
>>> +       tthrottle_offset = FIELD_GET(TEMP_TARGET_TJ_OFFSET_MASK, pcs) *
>>> MILLIDEGREE_PER_DEGREE;
>>> +       priv->temp.tthrottle.value = priv->temp.tjmax.value -
>>> tthrottle_offset;
>>> +
>>> +       peci_sensor_mark_updated(&priv->temp.tcontrol);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +/*
>>> + * Processors return a value of DTS reading in S10.6 fixed point format
>>> + * (sign, 10 bits signed integer value, 6 bits fractional).
>>
>> This parenthetical reads to me like it's describing 17 bits -- I'm not a
>> PECI expert, but from my reading of the (somewhat skimpy) docs I've got
>> on it I'd suggest a description more like "sign, 9-bit magnitude, 6-bit
>> fraction".
> 
> You're right, adding "sign" here was not intentional.
> I'll change it to:
> "16 bits: sign, 9-bit magnitude, 6-bit fraction"
> or
> "16 bits: 10-bit signed magnitude, 6-bit fraction"
> 
> Thanks
> -Iwona
> 

