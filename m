Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90C142ED2C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 11:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbhJOJJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 05:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhJOJJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:09:45 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29FEC061570;
        Fri, 15 Oct 2021 02:07:38 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so12019177ott.2;
        Fri, 15 Oct 2021 02:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2mKeW6qmyrv/RHrWgqdUsvWS3DMvAKhYSymhIVEhK0E=;
        b=mEAukDewtAGyaPCS2Ak9NsjebQ4gono2LW3dOsX+urkCPC5WUSyLsOF4o8VCVZyIlD
         MBjxPvs3/Bn2fcGoBMsHDLXBSiYqRF6My62FGmwzlFUFBf7g07TebB76aHpwGERX3jqH
         l/zMybQcw++s4ZzPKhnF9PbSTQF8OQ7/WnuXJrhv/12pdwzn3WlOvVVtPT0qZlJtfFx0
         hmK0cc+NOEYzJCJRC+jdTO7mlTmPuqvFlQGW+v8m7OPEvhOtTtb6iwGLBqKZQVKT31iM
         qtK60mFrQmjFooZ3Y22S2wza9mW6x8jvwhc8bDL8gzbCbUIxhQA0enaHP4eznwIvtW7H
         N8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2mKeW6qmyrv/RHrWgqdUsvWS3DMvAKhYSymhIVEhK0E=;
        b=g+CXZNTGJ+7O5zdf1FuF+sV7TiVxhpdtqO9VRsyBfzI93y6rB7bkapN80dlksSEDiP
         2wXxqpezTqaP/jUqm4y2oic2jjxIgKC9kZj9f5OZGYMDckTcOLb8AUzjku1++9sZbAep
         M5HNLJgBO0RMm4aP43K5RLXEyIXp3qk0bvZgZTSao8X2vnIZ9WfcbyRcMlSX6/CJeGC/
         6p/kqGAZ4sknmXnZHmb2skRfbvzsJPEbZhIX+OntbSHcp+EBqYEic5+TqhDGbMoX6QIb
         /yfe6cKsPaZpjFBUi9zSrKG1mIQw/iaQOS0yn9gTE9VHBfq/+8Rjnj7TvMkFVGfKLYZK
         PTDQ==
X-Gm-Message-State: AOAM531D2chENKW4DRgmvmSgfYYyGLMW2povgOWjOEdB7mwiXS+Rq5IH
        s8uFkVD5Yv3COw0v7OA28ViFj3CBMPk=
X-Google-Smtp-Source: ABdhPJwpWF3onGYK1cUUSBhR7moTLATHPE1zXaFX+jAzsekbV/QPLK48BsEHjQQcHOGWOjeLT6IYeg==
X-Received: by 2002:a05:6830:57b:: with SMTP id f27mr6700973otc.343.1634288857810;
        Fri, 15 Oct 2021 02:07:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s40sm478827otv.18.2021.10.15.02.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 02:07:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Tor Vic <torvic9@mailbox.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        kernel test robot <lkp@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211015055808.327453-1-pauk.denis@gmail.com>
 <20211015055808.327453-2-pauk.denis@gmail.com>
 <CAHp75VfUYgYT_RSNXCc+_3rkBbywL8ZDcAFPwr=WbPzcD8MF0w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus
 WMI.
Message-ID: <368db744-a717-2d03-e6a9-0b76e6241766@roeck-us.net>
Date:   Fri, 15 Oct 2021 02:07:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfUYgYT_RSNXCc+_3rkBbywL8ZDcAFPwr=WbPzcD8MF0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/21 1:21 AM, Andy Shevchenko wrote:
> On Fri, Oct 15, 2021 at 8:58 AM Denis Pauk <pauk.denis@gmail.com> wrote:
>>
>> Linux HWMON sensors driver for ASUS motherboards to read
>> sensors from the embedded controller.
>>
>> Many ASUS motherboards do not publish all the available
>> sensors via the Super I/O chip but the missing ones are
>> available through the embedded controller (EC) registers.
>>
>> This driver implements reading those sensor data via the
>> WMI method BREC, which is known to be present in all ASUS
>> motherboards based on the AMD 500 series chipsets (and
>> probably is available in other models too). The driver
>> needs to know exact register addresses for the sensors and
>> thus support for each motherboard has to be added explicitly.
>>
>> The EC registers do not provide critical values for the
>> sensors and as such they are not published to the HWMON.
>>
>> Supported motherboards:
>> * PRIME X570-PRO
>> * Pro WS X570-ACE
>> * ROG CROSSHAIR VIII HERO
>> * ROG CROSSHAIR VIII DARK HERO
>> * ROG CROSSHAIR VIII FORMULA
>> * ROG STRIX X570-E GAMING
>> * ROG STRIX B550-E GAMING
> 
> ...
> 
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> New code can't be reported as regression. Or what did you mean by that?
> 
Some people include that after 0-day reported a bug in an earlier
revision of the patch. No idea why (it's like expecting submitters
to add "Reported-by:" for everyone providing code review feedback).

Guenter

> ...
> 
>> +Kernel driver asus-wmi-ec-sensors
>> +=================================
>> +
>> +Supported boards:
>> + * PRIME X570-PRO,
>> + * Pro WS X570-ACE,
>> + * ROG CROSSHAIR VIII DARK HERO,
>> + * ROG CROSSHAIR VIII FORMULA,
>> + * ROG CROSSHAIR VIII HERO,
>> + * ROG STRIX B550-E GAMING,
>> + * ROG STRIX X570-E GAMING.
>> +
> 
>> +Authors:
>> +        Eugene Shalygin <eugene.shalygin@gmail.com>
> 
> reST has a special keyword for that.
> 
> ...
> 
>> +/*
>> + * HWMON driver for ASUS B550/X570 motherboards that publish sensor
>> + * values via the embedded controller registers.
>> + *
>> + * Copyright (C) 2021 Eugene Shalygin <eugene.shalygin@gmail.com>
>> + * Copyright (C) 2018-2019 Ed Brindley <kernel@maidavale.org>
>> + *
>> + * EC provides:
>> + * Chipset temperature,
>> + * CPU temperature,
>> + * Motherboard temperature,
>> + * T_Sensor temperature,
>> + * VRM  temperature,
>> + * Water In temperature,
>> + * Water Out temperature,
>> + * CPU Optional Fan RPM,
>> + * Chipset Fan RPM,
>> + * Water Flow Fan RPM,
>> + * CPU current.
> 
>> + *
> 
> Redundant line.
> 
>> + */
> 
>> +#include <asm/unaligned.h>
> 
> The common rule is to go from generic to particular, hence
> linux/*
> followed by
> asm/*
> followed by local subsystem / local headers like
> linux/hwmon*
> 
> with a blank line between each group.
> 
>> +#include <linux/acpi.h>
>> +#include <linux/dmi.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +#include <linux/init.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/nls.h>
>> +#include <linux/units.h>
>> +#include <linux/wmi.h>
> 
> ...
> 
>> +/* BLOCK_READ_EC */
> 
> Not sure what this means, but...
> 
>> +#define        ASUSWMI_METHODID_BREC   0x42524543
> 
> ...above has definitely an ASCII combination in hex format, care to
> decode it in the comment?
> 
> ...
> 
>> +/* from the ASUS DSDT source */
> 
> Keep the same style for all comments, i.e. here "From ..."
> 
> ...
> 
>> +#define        MAKE_SENSOR_ADDRESS(size_i, bank_i, index_i) \
>> +       { .size = size_i,\
>> +          .bank = bank_i,\
>> +          .index = index_i}
> 
> You should choose one style for all macros. Here is one, there is
> another... I would recommend to use one of
> 
> #define ... { \
> ... \
> }
> 
> or
> 
> #define ... \
> { \
> ... \
> }
> 
> In the second case the indentation of the {} is defined by the
> semantics of the macro: in case of function-like macro it starts from
> the first column, in case of data structure filler usually with one
> TAB.
> 
> ...
> 
>> +/*
>> + * All the known sensors for ASUS EC controllers
>> + */
> 
> One line and "All known sensors..."
> 
> ...
> 
>> +struct asus_wmi_ec_info {
>> +       struct ec_sensor sensors[SENSOR_MAX];
> 
>> +       char read_arg[((ASUSWMI_BREC_REGISTERS_MAX * 4) + 1) * 2];
> 
> Too many parentheses.
> 
>> +       u8 read_buffer[ASUSWMI_BREC_REGISTERS_MAX];
>> +       unsigned int nr_sensors;
>> +       unsigned int nr_registers;
>> +       unsigned long last_updated;
>> +};
> 
> ...
> 
>> +       for (i = 0; i < SENSOR_MAX && bsi[i] != SENSOR_MAX; i++) {
>> +               s[i].info_index = bsi[i];
> 
>> +               s[i].cached_value = 0;
> 
> Isn't it filled by kzalloc() or alike?
> 
>> +               ec->nr_sensors++;
>> +               ec->nr_registers += known_ec_sensors[bsi[i]].addr.size;
>> +       }
> 
> ...
> 
>> +/*
>> + * The next four functions converts to/from BRxx string argument format
>> + * The format of the string is as follows:
>> + * The string consists of two-byte UTF-16 characters
>> + * The value of the very first byte int the string is equal to the total length
>> + * of the next string in bytes, thus excluding the first two-byte character
>> + * The rest of the string encodes pairs of (bank, index) pairs, where both
>> + * values are byte-long (0x00 to 0xFF)
>> + * Numbers are encoded as UTF-16 hex values
> 
> The comment above misses a lot of punctuation. Also it would be nice
> to indent the list of items if any and so on.
> 
>> + */
>> +static void asus_wmi_ec_decode_reply_buffer(const u8 *inp, u8 *out, u32 length)
>> +{
>> +       char buffer[ASUSWMI_MAX_BUF_LEN * 2];
>> +       const char *pos = buffer;
>> +       const u8 *data = inp + 2;
>> +       unsigned int i;
>> +       u32 len;
> 
>> +       len = min3((u32)ASUSWMI_MAX_BUF_LEN, (length - 2) / 4, (u32)inp[0] / 4);
> 
> Instead I would prefer to have to min_t() calls without adding castings.
> Also might be useful to have a short comment explaining this choice.
> 
>> +       utf16s_to_utf8s((wchar_t *)data, len * 2,  UTF16_LITTLE_ENDIAN, buffer, len * 2);
> 
>> +       for (i = 0; i < len; i++, pos += 2)
>> +               out[i] = (hex_to_bin(pos[0]) << 4) + hex_to_bin(pos[1]);
> 
> NIH hex2bin().
> 
>> +}
> 
> ...
> 
>> +       for (i = 0; i < len; i++) {
>> +               byte = registers[i] >> 8;
>> +               *pos = hex_asc_hi(byte);
>> +               pos++;
>> +               *pos = hex_asc_lo(byte);
>> +               pos++;
>> +               byte = registers[i];
>> +               *pos = hex_asc_hi(byte);
>> +               pos++;
>> +               *pos = hex_asc_lo(byte);
>> +               pos++;
>> +       }
> 
> NIH bin2hex()
> 
> ...
> 
>> +               for (j = 0; j < si->addr.size;
>> +                    j++, register_idx++) {
> 
> One line.
> 
>> +                       registers[register_idx] = (si->addr.bank << 8) + si->addr.index + j;
>> +               }
> 
> ...
> 
>> +       /* the first byte of the BRxx() argument string has to be the string size */
> 
> Comment style.
> 
> ...
> 
>> +       input.length = (acpi_size)query[0] + 2;
> 
> Why is casting needed?
> 
> ...
> 
>> +       status = wmi_evaluate_method(ASUSWMI_MONITORING_GUID, 0, method_id, &input,
>> +                                    &output);
> 
> Logically better to keep &input and &output on the same line, i.e.
> second one here.
> 
>> +       obj = output.pointer;
>> +       if (!obj || obj->type != ACPI_TYPE_BUFFER) {
> 
>> +               acpi_os_free(obj);
> 
> What's the point of calling acpi_os_free(obj) when you already know it's NULL?
> 
> On top of that is the acpi_os_free() high-level enough API for this?
> 
>> +               return -EIO;
>> +       }
>> +       asus_wmi_ec_decode_reply_buffer(obj->buffer.pointer, out, obj->buffer.length);
> 
>> +       acpi_os_free(obj);
> 
> Ditto.
> 
> ...
> 
>> +       switch (data_type) {
>> +       case hwmon_curr:
>> +       case hwmon_temp:
>> +       case hwmon_in:
> 
>> +               return value * KILO;
> 
> Thanks for using KILO, but do you think it's the correct one and not MILLI?
> MILLI means that we got value in <units> and we would like to convert
> it to <milliunits>.
> KILO would mean the opposite, like we got in <milliunits> and we would
> like to have <units>.
> 
>> +       default:
>> +               return value;
>> +       }
> 
> ...
> 
>> +/*
>> + * Now follow the functions that implement the hwmon interface
>> + */
> 
> One line.
> 
> ...
> 
>> +       int index;
>> +       const struct asus_wmi_sensors *sensor_data = drvdata;
> 
> Here and elsewhere, perhaps reversed xmas tree order?
> 
> ...
> 
>> +       int nr_count[hwmon_max] = { 0 }, nr_types = 0;
> 
> {} will work as well.
> 
> ...
> 
>> +       /*
>> +        * if we can get values for all the registers in a single query,
>> +        * the query will not change from call to call
> 
> "If..."
> And period at the end since it's a multi-line comment.
> 
>> +        */
> 
> ...
> 
>> +       sensor_data = devm_kzalloc(dev, sizeof(struct asus_wmi_sensors),
>> +                                  GFP_KERNEL);
> 
> One line?
> 
> ...
> 
>> +       /* ec init */
> 
> Usefulness of this comment?
> 
>> +       return asus_wmi_ec_configure_sensor_setup(dev,
>> +                                                 sensor_data, bsi);
> 
> One line?
> 
> ...
> 
>> +       .driver = {
> 
>> +               .name = KBUILD_MODNAME,
> 
> It's kinda semi-ABI, please be not dependent on compile-time variables.
> 
>> +       },
> 

