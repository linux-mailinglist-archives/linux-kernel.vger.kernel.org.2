Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2CD42EC01
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbhJOIZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbhJOIYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:24:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DF5C0613E3;
        Fri, 15 Oct 2021 01:22:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z20so35116148edc.13;
        Fri, 15 Oct 2021 01:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VrNt/o1nSa4MO5VitUgo1gh5ZbHCnm6V9nLtUmAkb7I=;
        b=i4gbiwmRnCV0DehbtrRYKr9MsrTjzWHvG9/DAZOuZjfO3gwr0gBifehKCNJd8KjZfc
         /0zGdGLVVne8PE/UcyabuP9GWakU9gPziEmLk6NcisHh6REihNFnLqqiAynryLaFwz/n
         hhpFfQRNhNuPZAB21MY39jBh+CATMo7Qvim6Jc44IGcvESbpDlh7cVB4LddoB85Pmz6z
         1qqSREoh6Ag4/mJNIdpqT9hUEe972Or8nt5d9JsdedFuY8Mcc95QXmVEyVatNkRiQmMC
         NVezkgx1Kpf1t9t5IQkkJB70TwKS4FXNjMDS/g6PhVfPpIAfux7AaRsDnLCc+Al3tc+7
         13bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VrNt/o1nSa4MO5VitUgo1gh5ZbHCnm6V9nLtUmAkb7I=;
        b=URLCHig4Hs37oq/zRtrIfM88Zw6DLMoBPuE0mnHiBYkl7zfVZhVDs/dXLnZwawTY55
         Ir0via1rUwKFjq6ob4Fg0j3LIks0oNwdHYC3t1FhRbkZV4HsJ/s9UIgVgAAL6Y6uiLa/
         9/aO0/j1IrDirEBEiwGeG5BODtiIZf5HPRJ/zDhty/qjjZNFsqz4HWE74cywFcludjRv
         RlqjNbEQFo1sStJlaiATREPyaLilpXFgOdW4QbOz40Vziqwzid+IGq4KutCQxqHmKkrU
         w/99ebIAt1vFCJZxklUqnZ9SxTbgFoSD6DosVlyrfmjkgdw959I3P2gYWZnuFzWP25NX
         Pvrg==
X-Gm-Message-State: AOAM531zoJWi2nEXK0sHB0nqmjJryGtWUM5AlxwEmQ5AwU7CiVulsgsQ
        SK2f/MdDyBqwlq3cUWWd9zfMQ8tZVImTumqkv/g=
X-Google-Smtp-Source: ABdhPJwv/ExlTDSry1jLJBW9JfIk31scH5Z7zEfPwN/7wDwFoY9c1bFn4NLJEn9bhxHfMjB+s/13Hoi/JD1IdPRkgAU=
X-Received: by 2002:a17:906:a158:: with SMTP id bu24mr4830546ejb.356.1634286145843;
 Fri, 15 Oct 2021 01:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211015055808.327453-1-pauk.denis@gmail.com> <20211015055808.327453-2-pauk.denis@gmail.com>
In-Reply-To: <20211015055808.327453-2-pauk.denis@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Oct 2021 11:21:49 +0300
Message-ID: <CAHp75VfUYgYT_RSNXCc+_3rkBbywL8ZDcAFPwr=WbPzcD8MF0w@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Tor Vic <torvic9@mailbox.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        kernel test robot <lkp@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 8:58 AM Denis Pauk <pauk.denis@gmail.com> wrote:
>
> Linux HWMON sensors driver for ASUS motherboards to read
> sensors from the embedded controller.
>
> Many ASUS motherboards do not publish all the available
> sensors via the Super I/O chip but the missing ones are
> available through the embedded controller (EC) registers.
>
> This driver implements reading those sensor data via the
> WMI method BREC, which is known to be present in all ASUS
> motherboards based on the AMD 500 series chipsets (and
> probably is available in other models too). The driver
> needs to know exact register addresses for the sensors and
> thus support for each motherboard has to be added explicitly.
>
> The EC registers do not provide critical values for the
> sensors and as such they are not published to the HWMON.
>
> Supported motherboards:
> * PRIME X570-PRO
> * Pro WS X570-ACE
> * ROG CROSSHAIR VIII HERO
> * ROG CROSSHAIR VIII DARK HERO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX X570-E GAMING
> * ROG STRIX B550-E GAMING

...

> Reported-by: kernel test robot <lkp@intel.com>

New code can't be reported as regression. Or what did you mean by that?

...

> +Kernel driver asus-wmi-ec-sensors
> +=================================
> +
> +Supported boards:
> + * PRIME X570-PRO,
> + * Pro WS X570-ACE,
> + * ROG CROSSHAIR VIII DARK HERO,
> + * ROG CROSSHAIR VIII FORMULA,
> + * ROG CROSSHAIR VIII HERO,
> + * ROG STRIX B550-E GAMING,
> + * ROG STRIX X570-E GAMING.
> +

> +Authors:
> +        Eugene Shalygin <eugene.shalygin@gmail.com>

reST has a special keyword for that.

...

> +/*
> + * HWMON driver for ASUS B550/X570 motherboards that publish sensor
> + * values via the embedded controller registers.
> + *
> + * Copyright (C) 2021 Eugene Shalygin <eugene.shalygin@gmail.com>
> + * Copyright (C) 2018-2019 Ed Brindley <kernel@maidavale.org>
> + *
> + * EC provides:
> + * Chipset temperature,
> + * CPU temperature,
> + * Motherboard temperature,
> + * T_Sensor temperature,
> + * VRM  temperature,
> + * Water In temperature,
> + * Water Out temperature,
> + * CPU Optional Fan RPM,
> + * Chipset Fan RPM,
> + * Water Flow Fan RPM,
> + * CPU current.

> + *

Redundant line.

> + */

> +#include <asm/unaligned.h>

The common rule is to go from generic to particular, hence
linux/*
followed by
asm/*
followed by local subsystem / local headers like
linux/hwmon*

with a blank line between each group.

> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/init.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/nls.h>
> +#include <linux/units.h>
> +#include <linux/wmi.h>

...

> +/* BLOCK_READ_EC */

Not sure what this means, but...

> +#define        ASUSWMI_METHODID_BREC   0x42524543

...above has definitely an ASCII combination in hex format, care to
decode it in the comment?

...

> +/* from the ASUS DSDT source */

Keep the same style for all comments, i.e. here "From ..."

...

> +#define        MAKE_SENSOR_ADDRESS(size_i, bank_i, index_i) \
> +       { .size = size_i,\
> +          .bank = bank_i,\
> +          .index = index_i}

You should choose one style for all macros. Here is one, there is
another... I would recommend to use one of

#define ... { \
... \
}

or

#define ... \
{ \
... \
}

In the second case the indentation of the {} is defined by the
semantics of the macro: in case of function-like macro it starts from
the first column, in case of data structure filler usually with one
TAB.

...

> +/*
> + * All the known sensors for ASUS EC controllers
> + */

One line and "All known sensors..."

...

> +struct asus_wmi_ec_info {
> +       struct ec_sensor sensors[SENSOR_MAX];

> +       char read_arg[((ASUSWMI_BREC_REGISTERS_MAX * 4) + 1) * 2];

Too many parentheses.

> +       u8 read_buffer[ASUSWMI_BREC_REGISTERS_MAX];
> +       unsigned int nr_sensors;
> +       unsigned int nr_registers;
> +       unsigned long last_updated;
> +};

...

> +       for (i = 0; i < SENSOR_MAX && bsi[i] != SENSOR_MAX; i++) {
> +               s[i].info_index = bsi[i];

> +               s[i].cached_value = 0;

Isn't it filled by kzalloc() or alike?

> +               ec->nr_sensors++;
> +               ec->nr_registers += known_ec_sensors[bsi[i]].addr.size;
> +       }

...

> +/*
> + * The next four functions converts to/from BRxx string argument format
> + * The format of the string is as follows:
> + * The string consists of two-byte UTF-16 characters
> + * The value of the very first byte int the string is equal to the total length
> + * of the next string in bytes, thus excluding the first two-byte character
> + * The rest of the string encodes pairs of (bank, index) pairs, where both
> + * values are byte-long (0x00 to 0xFF)
> + * Numbers are encoded as UTF-16 hex values

The comment above misses a lot of punctuation. Also it would be nice
to indent the list of items if any and so on.

> + */
> +static void asus_wmi_ec_decode_reply_buffer(const u8 *inp, u8 *out, u32 length)
> +{
> +       char buffer[ASUSWMI_MAX_BUF_LEN * 2];
> +       const char *pos = buffer;
> +       const u8 *data = inp + 2;
> +       unsigned int i;
> +       u32 len;

> +       len = min3((u32)ASUSWMI_MAX_BUF_LEN, (length - 2) / 4, (u32)inp[0] / 4);

Instead I would prefer to have to min_t() calls without adding castings.
Also might be useful to have a short comment explaining this choice.

> +       utf16s_to_utf8s((wchar_t *)data, len * 2,  UTF16_LITTLE_ENDIAN, buffer, len * 2);

> +       for (i = 0; i < len; i++, pos += 2)
> +               out[i] = (hex_to_bin(pos[0]) << 4) + hex_to_bin(pos[1]);

NIH hex2bin().

> +}

...

> +       for (i = 0; i < len; i++) {
> +               byte = registers[i] >> 8;
> +               *pos = hex_asc_hi(byte);
> +               pos++;
> +               *pos = hex_asc_lo(byte);
> +               pos++;
> +               byte = registers[i];
> +               *pos = hex_asc_hi(byte);
> +               pos++;
> +               *pos = hex_asc_lo(byte);
> +               pos++;
> +       }

NIH bin2hex()

...

> +               for (j = 0; j < si->addr.size;
> +                    j++, register_idx++) {

One line.

> +                       registers[register_idx] = (si->addr.bank << 8) + si->addr.index + j;
> +               }

...

> +       /* the first byte of the BRxx() argument string has to be the string size */

Comment style.

...

> +       input.length = (acpi_size)query[0] + 2;

Why is casting needed?

...

> +       status = wmi_evaluate_method(ASUSWMI_MONITORING_GUID, 0, method_id, &input,
> +                                    &output);

Logically better to keep &input and &output on the same line, i.e.
second one here.

> +       obj = output.pointer;
> +       if (!obj || obj->type != ACPI_TYPE_BUFFER) {

> +               acpi_os_free(obj);

What's the point of calling acpi_os_free(obj) when you already know it's NULL?

On top of that is the acpi_os_free() high-level enough API for this?

> +               return -EIO;
> +       }
> +       asus_wmi_ec_decode_reply_buffer(obj->buffer.pointer, out, obj->buffer.length);

> +       acpi_os_free(obj);

Ditto.

...

> +       switch (data_type) {
> +       case hwmon_curr:
> +       case hwmon_temp:
> +       case hwmon_in:

> +               return value * KILO;

Thanks for using KILO, but do you think it's the correct one and not MILLI?
MILLI means that we got value in <units> and we would like to convert
it to <milliunits>.
KILO would mean the opposite, like we got in <milliunits> and we would
like to have <units>.

> +       default:
> +               return value;
> +       }

...

> +/*
> + * Now follow the functions that implement the hwmon interface
> + */

One line.

...

> +       int index;
> +       const struct asus_wmi_sensors *sensor_data = drvdata;

Here and elsewhere, perhaps reversed xmas tree order?

...

> +       int nr_count[hwmon_max] = { 0 }, nr_types = 0;

{} will work as well.

...

> +       /*
> +        * if we can get values for all the registers in a single query,
> +        * the query will not change from call to call

"If..."
And period at the end since it's a multi-line comment.

> +        */

...

> +       sensor_data = devm_kzalloc(dev, sizeof(struct asus_wmi_sensors),
> +                                  GFP_KERNEL);

One line?

...

> +       /* ec init */

Usefulness of this comment?

> +       return asus_wmi_ec_configure_sensor_setup(dev,
> +                                                 sensor_data, bsi);

One line?

...

> +       .driver = {

> +               .name = KBUILD_MODNAME,

It's kinda semi-ABI, please be not dependent on compile-time variables.

> +       },

-- 
With Best Regards,
Andy Shevchenko
