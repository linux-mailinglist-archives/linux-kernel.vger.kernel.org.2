Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370B640ED4D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbhIPWZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240710AbhIPWZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:25:55 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA65C061574;
        Thu, 16 Sep 2021 15:24:34 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so10300003otf.6;
        Thu, 16 Sep 2021 15:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=horqbrKKBh5EaYsFSZBjjI5vv+f1TueHYQcsHmdV28A=;
        b=VvvaGVnSbWz4dIiKBfloJ6w2mPPFDBHtlLPBh5yuGtFJx+JEHzgWzGAGsZH6rzHqmw
         esYp7J40BOoP8eDALEnCqrvgfEaxENWhwHSAtxJJemkAT+RSPbhiZiZ4WGVQU1j4bUbE
         Q9OLiTr/3MFBDUhSrkQhNJD3AbKzPkwk3C+jHAOiiSrzI6szrzOmwKTL66C4tkHupfc0
         U6TPVYpCOWtIYJCCIgSg+QmoCexDsyw3xmqjOs8NjmO61YkGlVUJjujEssRFDlDaiMOD
         dYUWx7tNE4NUyL06H7fHH0lkljq8oEJCsxF9A3Uy2AQzSi7hbrnEhMph9AwUb2Xs8wvT
         MxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=horqbrKKBh5EaYsFSZBjjI5vv+f1TueHYQcsHmdV28A=;
        b=wpcSHfuX7j5CV2BTpbC0WNgDHZP4I10YEAp4Kabzl9tqqX54Clr7aV5oy/TF4OnBVn
         /LJ0N2Zrljg6i2vSy+VszCBKZD4s6SkPvb/FluEsd6gyLoIwreayz6PrOtEd/nfS3m/p
         bcZrjahR/dS22Rx6h4S8vMhnjmr2UbzjBLlypjIlB2BT8x0GBtw8dG3WNc2JWnUmhM8a
         FLNXoWRyzz5l69g3UM2znL2FaMemKIDrY4LKj3p+6LoCsRNlEaaaqSbOIAok8pD/6++S
         0K3CZ1ZBEVje47hJdS4ZP1YyhqUBM67XrPGoEMm7Lh4f+daZevoFRF7hGO9GIDVrPOrs
         f1bg==
X-Gm-Message-State: AOAM5329fVbWOA+Pg+TPqEqi84Zu+6GOJ30D82rD3WcXERQnrKdHpHht
        iIdmGgiQapXqNnNn2f6W9BHluMsGbDs=
X-Google-Smtp-Source: ABdhPJwgEnPqFTwxlO83sbDnELvvxpXn6gR+u1hwhUqZvD2YuvVzqp1QRuH/bGyzj+d4GcggKZsZNQ==
X-Received: by 2002:a05:6830:18c7:: with SMTP id v7mr6709934ote.126.1631831073222;
        Thu, 16 Sep 2021 15:24:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w6sm1005228otp.3.2021.09.16.15.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 15:24:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Bernhard Seibold <mail@bernhard-seibold.de>,
        =?UTF-8?Q?P=c3=a4r_Ekholm?= <pehlm@pekholm.org>,
        to.eivind@gmail.com, "Artem S . Tashkinov" <aros@gmx.com>,
        Vittorio Roberto Alfieri <me@rebtoor.com>,
        Sahan Fernando <sahan.h.fernando@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210916202233.40334-1-pauk.denis@gmail.com>
 <20210916202233.40334-5-pauk.denis@gmail.com>
 <78a08749-5094-b7a6-1672-6087f33c62e3@roeck-us.net>
 <20210917002433.27226146@penguin.lxd>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 3/3] hwmon: (nct6775) Support access via Asus WMI
Message-ID: <e2329d97-3d9f-3579-f24f-b1e3d9660f9f@roeck-us.net>
Date:   Thu, 16 Sep 2021 15:24:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210917002433.27226146@penguin.lxd>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 2:24 PM, Denis Pauk wrote:
> On Thu, 16 Sep 2021 14:10:49 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On 9/16/21 1:22 PM, Denis Pauk wrote:
>>> Support accessing the NCT677x via Asus WMI functions.
>>>
>>> On mainboards that support this way of accessing the chip, the
>>> driver will usually not work without this option since in these
>>> mainboards, ACPI will mark the I/O port as used.
>>>
>>> Code uses ACPI firmware interface to communicate with sensors with
>>> ASUS motherboards:
>>> * PRIME B460-PLUS,
>>> * ROG CROSSHAIR VIII IMPACT,
>>> * ROG STRIX B550-E GAMING,
>>> * ROG STRIX B550-F GAMING,
>>> * ROG STRIX B550-F GAMING (WI-FI),
>>> * ROG STRIX Z490-I GAMING,
>>> * TUF GAMING B550M-PLUS,
>>> * TUF GAMING B550M-PLUS (WI-FI),
>>> * TUF GAMING B550-PLUS,
>>> * TUF GAMING X570-PLUS,
>>> * TUF GAMING X570-PRO (WI-FI).
>>>
>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
>>> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
>>> Co-developed-by: Bernhard Seibold <mail@bernhard-seibold.de>
>>> Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
>>> Tested-by: Pär Ekholm <pehlm@pekholm.org>
>>> Tested-by: <to.eivind@gmail.com>
>>> Tested-by: Artem S. Tashkinov <aros@gmx.com>
>>> Tested-by: Vittorio Roberto Alfieri <me@rebtoor.com>
>>> Tested-by: Sahan Fernando <sahan.h.fernando@gmail.com>
>>> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>>
>>> ---
>>> Changes in v7:
>>>     - Remove unrequred & 0xff with int8 variables.
>>>     - Make ASUSWMI_UNSUPPORTED_METHOD as default value for WMI
>>> responce, before run wmi_evaluate_method().
>>>     - Rename ASUSWMI_MGMT2_GUID to ASUSWMI_MONITORING_GUID.
>>>     - Replace checks of 'err != -EINVAL' with 'err >= 0' for
>>> match_string result.
>>>
>>> Changes in v6:
>>>     - Minimaze codes inside code inside defined(CONFIG_ACPI_WMI).
>>>
>>> Changes in v5:
>>>     - Use IS_ENABLED(CONFIG_ACPI_WMI) instead
>>> defined(CONFIG_ACPI_WMI)
>>>
>>> Changes in v4:
>>>     - Fix build without ACPI WMI.
>>>
>>> Changes in v3:
>>>     - Remove unrequired type conversions.
>>>     - Save result of match_string before check.
>>>
>>> Changes in v2:
>>>     - Split changes to separate patches.
>>>     - Limit WMI usage by DMI_BOARD_NAME in checked ASUS motherboards.
>>> ---
>>>    drivers/hwmon/Kconfig   |   1 +
>>>    drivers/hwmon/nct6775.c | 230
>>> ++++++++++++++++++++++++++++++++++++---- 2 files changed, 210
>>> insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>> index e3675377bc5d..9eefb1014b53 100644
>>> --- a/drivers/hwmon/Kconfig
>>> +++ b/drivers/hwmon/Kconfig
>>> @@ -1423,6 +1423,7 @@ config SENSORS_NCT6683
>>>    config SENSORS_NCT6775
>>>    	tristate "Nuvoton NCT6775F and compatibles"
>>>    	depends on !PPC
>>> +	depends on ACPI_WMI || ACPI_WMI=n
>>>    	select HWMON_VID
>>>    	help
>>>    	  If you say yes here you get support for the hardware
>>> monitoring diff --git a/drivers/hwmon/nct6775.c
>>> b/drivers/hwmon/nct6775.c index 4253eed7f5b0..46262d9d3bd9 100644
>>> --- a/drivers/hwmon/nct6775.c
>>> +++ b/drivers/hwmon/nct6775.c
>>> @@ -55,6 +55,7 @@
>>>    #include <linux/dmi.h>
>>>    #include <linux/io.h>
>>>    #include <linux/nospec.h>
>>> +#include <linux/wmi.h>
>>>    #include "lm75.h"
>>>    
>>>    #define USE_ALTERNATE
>>> @@ -132,10 +133,13 @@ MODULE_PARM_DESC(fan_debounce, "Enable
>>> debouncing for fan RPM signal"); #define SIO_ID_MASK
>>> 0xFFF8
>>>    enum pwm_enable { off, manual, thermal_cruise, speed_cruise, sf3,
>>> sf4 }; +enum sensor_access { access_direct, access_asuswmi };
>>>    
>>>    struct nct6775_sio_data {
>>>    	int sioreg;
>>> +	int ld;
>>>    	enum kinds kind;
>>> +	enum sensor_access access;
>>>    
>>>    	/* superio_() callbacks  */
>>>    	void (*sio_outb)(struct nct6775_sio_data *sio_data, int
>>> reg, int val); @@ -145,6 +149,90 @@ struct nct6775_sio_data {
>>>    	void (*sio_exit)(struct nct6775_sio_data *sio_data);
>>>    };
>>>    
>>> +#define ASUSWMI_MONITORING_GUID
>>> "466747A0-70EC-11DE-8A39-0800200C9A66" +#define
>>> ASUSWMI_METHODID_RSIO		0x5253494F +#define
>>> ASUSWMI_METHODID_WSIO		0x5753494F +#define
>>> ASUSWMI_METHODID_RHWM		0x5248574D +#define
>>> ASUSWMI_METHODID_WHWM		0x5748574D +#define
>>> ASUSWMI_UNSUPPORTED_METHOD	0xFFFFFFFE +
>>> +static int asuswmi_evaluate_method(u32 method_id, u8 bank, u8 reg,
>>> u8 val, u32 *retval) +{
> What do you thin about rename asuswmi_evaluate_method() to
> asuswmi_monitoring_method()? I have found that kernel already have
> asus_wmi_evaluate_method() that has used different method GUID, so
> looks as make sense to use different function name. It uses different
> constants with different names/values and does not intersect with this
> one.

nct6775_asuswmi_evaluate_method or similar, maybe, if you really
want to rename it.

Guenter
