Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD0C40DB06
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbhIPNW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhIPNW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:22:27 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF690C061574;
        Thu, 16 Sep 2021 06:21:06 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u22so773504oie.5;
        Thu, 16 Sep 2021 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fnvFZU4t4JKCcm67yrZgVuulCn+FZOBZrSk1UPp4tZw=;
        b=TJtsvPq368Kvb986/6VFZ27gSq44lFm6vrtSIwRFgqQAhuzBoe7yUh7kdkROsBrHCG
         s9nvzfkPNT3YCKjl+FFb6XsIpNKvgvk8wEN/KRNLH0WUWJx1R6p5waTOnq19HjwueSyB
         uvDTiB3lQeLHK8UzdykO0AnxHYt8JrtNlwijZcDPESyfepWq/keZhpIE04Q/UFM1hwMz
         KnWCcZIvCByHEXphu34WYDi0eWuFLawJm6FcWRcaddrFHNPyWoT/ZGU4zgSxUZFx2Crn
         D+CRCVVPN2yoSXszev73ERocKIX6PRWOxJcGDoRu2sEsBvrKNqeN4KFZp+u02XVPAgKc
         MClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fnvFZU4t4JKCcm67yrZgVuulCn+FZOBZrSk1UPp4tZw=;
        b=Q1HhPzdqleYlU8Q/y0aybA0J9UHb/FXJSuDC5BQmuytAeWWXQFIIR9enKIGRA7lVah
         NfwuOflFKViCwhL0nmZU3npARbIqWdt/cPBl4iZaGsvvDMfdZDW+DP5a2HS3/iBZTXZJ
         EU9R84hINyPjnklO9j9LURupkG2eEDs/UQ87xKNziUAOeemwlw+n42b2ijcucHVwRx8c
         1pAYkijWJ+iHUwW6d1OMJVeI42owqa4j+N0dAsTn9U/mzlohhicpOlw8nFLnVZw6HBRA
         W5/wfdTbKoD3M1/8vDn3B9gJ1ysPQpWoYnnSrsR/7aZHGV40fO7PBvA5eWcNKgovaui9
         /3rg==
X-Gm-Message-State: AOAM533cVs6qn+4JrhUhs5Nz4ajENgb6pDhLHje0Qxsf8o0n4YsjiF7c
        KnqFXe15A7tz+bVIaGDbvNRjgijCKqM=
X-Google-Smtp-Source: ABdhPJwd96yECOsZatk0o1RCjho5JDpfoAsV6rb/zhfvzzXHpoOjV6ckt2kaTIKr3H4YkvNfrQTKPg==
X-Received: by 2002:a05:6808:1294:: with SMTP id a20mr9056561oiw.4.1631798466102;
        Thu, 16 Sep 2021 06:21:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p64sm762690oih.29.2021.09.16.06.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:21:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>
Cc:     Bernhard Seibold <mail@bernhard-seibold.de>,
        =?UTF-8?Q?P=c3=a4r_Ekholm?= <pehlm@pekholm.org>,
        to.eivind@gmail.com, "Artem S . Tashkinov" <aros@gmx.com>,
        Vittorio Roberto Alfieri <me@rebtoor.com>,
        Sahan Fernando <sahan.h.fernando@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210915204251.26081-1-pauk.denis@gmail.com>
 <20210915204251.26081-4-pauk.denis@gmail.com>
 <CAHp75Vfj6yUrYxbCmYuw=poVjY3GmEBrhF2tJHqkKDVtQ4mywA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 3/3] hwmon: (nct6775) Support access via Asus WMI.
Message-ID: <2b0965e4-13b7-0179-fa1f-09d9e444ab96@roeck-us.net>
Date:   Thu, 16 Sep 2021 06:21:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfj6yUrYxbCmYuw=poVjY3GmEBrhF2tJHqkKDVtQ4mywA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 1:34 AM, Andy Shevchenko wrote:
> On Wed, Sep 15, 2021 at 11:45 PM Denis Pauk <pauk.denis@gmail.com> wrote:
>>
>> Support accessing the NCT677x via Asus WMI functions.
>>
>> On mainboards that support this way of accessing the chip, the driver will
>> usually not work without this option since in these mainboards, ACPI will
>> mark the I/O port as used.
>>
>> Code uses ACPI firmware interface to commucate with sensors with ASUS
> 
> communicate
> 
>> motherboards:
>> * PRIME B460-PLUS,
>> * ROG CROSSHAIR VIII IMPACT,
>> * ROG STRIX B550-E GAMING,
>> * ROG STRIX B550-F GAMING,
>> * ROG STRIX B550-F GAMING (WI-FI),
>> * ROG STRIX Z490-I GAMING,
>> * TUF GAMING B550M-PLUS,
>> * TUF GAMING B550M-PLUS (WI-FI),
>> * TUF GAMING B550-PLUS,
>> * TUF GAMING X570-PLUS,
>> * TUF GAMING X570-PRO (WI-FI).
> 
> ...
> 
>> +static int asuswmi_evaluate_method(u32 method_id, u8 bank, u8 reg, u8 val, u32 *retval)
>> +{
> 
>> +#if IS_ENABLED(CONFIG_ACPI_WMI)
> 
> The idea behind IS_ENABLED() macro is that it may be used in C
> conditionals, like
> 
> if (IS_ENABLED(...))
> 

It can be and is used either way.

$ git grep "#if IS_ENABLED" | wc
    3126    6529  199841

$ git grep "if (IS_ENABLED" | wc
    1624    6871  120270

>> +       u32 args = bank | (reg << 8) | (val << 16);
>> +       struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
>> +       struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
>> +       acpi_status status;
>> +       union acpi_object *obj;
>> +       u32 tmp = 0;
> 
>> +       obj = output.pointer;
>> +       if (obj && obj->type == ACPI_TYPE_INTEGER)
>> +               tmp = obj->integer.value;
>> +
>> +       if (retval)
>> +               *retval = tmp;
>> +
>> +       kfree(obj);
> 
>> +       if (tmp == ASUSWMI_UNSUPPORTED_METHOD)
> 
> This is uninitialized tmp in case when no obj, or obj is of the wrong type.
> 

In this situation, we know that the ACPI call succeeded. My assumption was
that this code explicitly checks for a specific error code returned from
the ASUS WMI code, which would be returned as integer. This is an additional
error check on top of previous error checks, and it looks perfectly valid to me.

Other WMI code doesn't check for errors other than "if (ACPI_FAILURE(status))".

>> +               return -ENODEV;
>> +       return 0;
>> +#else
>> +       return -EOPNOTSUPP;
>> +#endif
>> +}
> 
> ...
> 
>> +static u16 nct6775_wmi_read_value(struct nct6775_data *data, u16 reg)
>> +{
>> +       int res, word_sized = is_word_sized(data, reg);
>> +       u8 tmp;
>> +
>> +       nct6775_wmi_set_bank(data, reg);
>> +
>> +       nct6775_asuswmi_read(data->bank, reg, &tmp);
> 
>> +       res = (tmp & 0xff);
> 
> Too many parentheses.
> tnp is u8, ' & 0xff' is redundant.
> 
>> +       if (word_sized) {
>> +               nct6775_asuswmi_read(data->bank, (reg & 0xff) + 1, &tmp);
>> +               res = (res << 8) + (tmp & 0xff);
> 
> Ditto.
> 
>> +       }
>> +       return res;
>> +}
>> +
>> +static int nct6775_wmi_write_value(struct nct6775_data *data, u16 reg, u16 value)
>> +{
>> +       int word_sized = is_word_sized(data, reg);
>> +
>> +       nct6775_wmi_set_bank(data, reg);
>> +
>> +       if (word_sized) {
> 
>> +               nct6775_asuswmi_write(data->bank, (reg & 0xff),
> 
> Too many parentheses
> 
>> +                                     (value >> 8) & 0xff);
> 
> ' & 0xff' part is redundant.
> 
>> +               nct6775_asuswmi_write(data->bank, (reg & 0xff) + 1,
>> +                                     value & 0xff);
>> +       } else {
>> +               nct6775_asuswmi_write(data->bank, (reg & 0xff), value);
>> +       }
>> +
>> +       return 0;
>> +}
> 
> ...
> 
>> +               err = match_string(asus_wmi_boards, ARRAY_SIZE(asus_wmi_boards),
>> +                                  board_name);
> 
>> +               if (err != -EINVAL) {
> 
> I believe I commented on this in the way as
> 
> if (err >= 0)
> 
> The rationale behind is that you shouldn't really care what kind of
> error codes the API may return.
> 
>> +                       /* if reading chip id via WMI succeeds, use WMI */
>> +                       if (!nct6775_asuswmi_read(0, NCT6775_PORT_CHIPID, &tmp)) {
>> +                               pr_info("Using Asus WMI to access %#x chip.\n", tmp);
>> +                               access = access_asuswmi;
>> +                       } else {
>> +                               pr_err("Can't read ChipID by Asus WMI.\n");
>> +                       }
>> +               }
> 

