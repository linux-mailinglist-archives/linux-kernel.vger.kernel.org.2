Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAE64285B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 06:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhJKELD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 00:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhJKELA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 00:11:00 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDF8C061570;
        Sun, 10 Oct 2021 21:09:00 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so20040183otb.10;
        Sun, 10 Oct 2021 21:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QunyXUt74Gx3GYDTkgdqDinXhHjEbO9JIPtdoMQbpkY=;
        b=DHbZF6KgPcU6w2KvrVB6smtJTD/qX+YmRqw+mcDxwjVuNdIObUKwIPmW+mb3XZu966
         eXi6kgXlFCjkhBQ/MbruKhbA6qI1qDZrTY+FUwELNqhmSan5vjejAghLN7jWjGTcYoSi
         l9wZ/56Mgvkf/nLAkOJQbHz4PQOgGh//Uu+Q33v+pFbYhGHP/lVpNXxwTF00D145QnnR
         eVVmOsiaspsKPHM4YzBdlUD4Gdc+Gr+/oMCZOOrzmf4EuZrgzVRO0uZUz54DLolRXlda
         HVAnNl7oSbfV5pLkFCJfo00Q1HPTTERZPhctrjalhL0QVAUCyjLdEfR6sX6blGBT5Rza
         v1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QunyXUt74Gx3GYDTkgdqDinXhHjEbO9JIPtdoMQbpkY=;
        b=HQTxEjBtQConlcjfmyn3wntAQ31GFYgLzjksR8sUBjb3JmSwmg+UCdrT17Uk8hUrV7
         +KVr1O/FGsXW3RmtftU1WewS03goOeQEwCrevSUpytbpUIYhiiq+lTMjBvfYUQkqjQwF
         b3oRwb3vl+MHUW/lk7xI8+zXpnmWy10IgKrWmlH4JRoXESi+KxdpXYSCk9BdMxoSDbi+
         dSO2qjdG+dVkEHqIRqNBNFQjj6ne56snixhsC4VSHTrICobfeB0gBOfjiL6/Shm0yTuk
         z17D2/mqhJIsAGMUcqxPl+djXeUxkrVfHMKh/xegIyHq4KN86Nuk5E0LmjsuuMxm4W2r
         qYGQ==
X-Gm-Message-State: AOAM530hxxN/CJEXTIzfnakpSVJGcutyE4sCdRBb0yEvg2SnBd5NelZv
        6h9/ldej5tshIv5RgzoPsGzSbIVPjUg=
X-Google-Smtp-Source: ABdhPJwpAcgppMcWBFbG7irS9GGd/OPmt76AGy16JZREt0YxmjivC9nUaV7a0yOkQrlVvXnxkZ65dA==
X-Received: by 2002:a9d:7018:: with SMTP id k24mr5484280otj.168.1633925339859;
        Sun, 10 Oct 2021 21:08:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id az14sm589495oib.51.2021.10.10.21.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 21:08:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v7 2/2] hwmon: (nct7802) Make temperature/voltage sensors
 configurable
To:     Oskar Senft <osk@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211011012212.91357-1-osk@google.com>
 <20211011012212.91357-2-osk@google.com>
 <98dcaa85-d04c-7a9c-1901-8786d361477c@roeck-us.net>
 <CABoTLcTERUpwPSc7fVUAMqs37XCZJhMFbFRT2oyTt_TodE6GnA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <518a6ab3-80af-bbe9-69e5-55e6741bdcbe@roeck-us.net>
Date:   Sun, 10 Oct 2021 21:08:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABoTLcTERUpwPSc7fVUAMqs37XCZJhMFbFRT2oyTt_TodE6GnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/21 6:53 PM, Oskar Senft wrote:
> I wasn't sure if submitting JUST a v7 of nuvoton,nct7802.yaml (i.e.
> the 1/2 in this series) would be the right thing to do and thought it
> would be easier to follow if I dropped both. I couldn't find
> documentation on what's the right thing to do in that case. Would it
> have been better to only submit nuvoton,nct7802.yaml as "PATCH v7" ?
> 

First, please don't top-post.

Second, no, submitting both patches was the right thing to do, but
you should not drop a Reviewed-by: tag if there was no change to
the patch.

Guenter

> Oskar.
> 
> On Sun, Oct 10, 2021 at 9:49 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 10/10/21 6:22 PM, Oskar Senft wrote:
>>> This change allows LTD and RTD inputs to be configured via
>>> device tree bindings. If the DT bindings are not present or
>>> invalid, the input configuration is not modified and left at
>>> HW defaults.
>>>
>>> Signed-off-by: Oskar Senft <osk@google.com>
>>
>> I sent a Reviewed-by: for v6 of this patch.
>>
>>> ---
>>> Changes from PATCH v6:
>>> - None (resubmitted due to changes in nuvoton,nct7802.yaml).
>>>
>>
>> Why did you drop it if there was no change ?
>>
>> Guenter
>>
>>> Changes from PATCH v5:
>>> - Removed unused "found_channel_config" variable.
>>> - Initialize mode_mask and mode_val to defaults.
>>> ---
>>>    drivers/hwmon/nct7802.c | 129 ++++++++++++++++++++++++++++++++++++++--
>>>    1 file changed, 125 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
>>> index 604af2f6103a..d56f78327619 100644
>>> --- a/drivers/hwmon/nct7802.c
>>> +++ b/drivers/hwmon/nct7802.c
>>> @@ -51,6 +51,23 @@ static const u8 REG_VOLTAGE_LIMIT_MSB_SHIFT[2][5] = {
>>>    #define REG_CHIP_ID         0xfe
>>>    #define REG_VERSION_ID              0xff
>>>
>>> +/*
>>> + * Resistance temperature detector (RTD) modes according to 7.2.32 Mode
>>> + * Selection Register
>>> + */
>>> +#define RTD_MODE_CURRENT     0x1
>>> +#define RTD_MODE_THERMISTOR  0x2
>>> +#define RTD_MODE_VOLTAGE     0x3
>>> +
>>> +#define MODE_RTD_MASK                0x3
>>> +#define MODE_LTD_EN          0x40
>>> +
>>> +/*
>>> + * Bit offset for sensors modes in REG_MODE.
>>> + * Valid for index 0..2, indicating RTD1..3.
>>> + */
>>> +#define MODE_BIT_OFFSET_RTD(index) ((index) * 2)
>>> +
>>>    /*
>>>     * Data structures and manipulation thereof
>>>     */
>>> @@ -1038,7 +1055,112 @@ static const struct regmap_config nct7802_regmap_config = {
>>>        .volatile_reg = nct7802_regmap_is_volatile,
>>>    };
>>>
>>> -static int nct7802_init_chip(struct nct7802_data *data)
>>> +static int nct7802_get_channel_config(struct device *dev,
>>> +                                   struct device_node *node, u8 *mode_mask,
>>> +                                   u8 *mode_val)
>>> +{
>>> +     u32 reg;
>>> +     const char *type_str, *md_str;
>>> +     u8 md;
>>> +
>>> +     if (!node->name || of_node_cmp(node->name, "channel"))
>>> +             return 0;
>>> +
>>> +     if (of_property_read_u32(node, "reg", &reg)) {
>>> +             dev_err(dev, "Could not read reg value for '%s'\n",
>>> +                     node->full_name);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     if (reg > 3) {
>>> +             dev_err(dev, "Invalid reg (%u) in '%s'\n", reg,
>>> +                     node->full_name);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     if (reg == 0) {
>>> +             if (!of_device_is_available(node))
>>> +                     *mode_val &= ~MODE_LTD_EN;
>>> +             else
>>> +                     *mode_val |= MODE_LTD_EN;
>>> +             *mode_mask |= MODE_LTD_EN;
>>> +             return 0;
>>> +     }
>>> +
>>> +     /* At this point we have reg >= 1 && reg <= 3 */
>>> +
>>> +     if (!of_device_is_available(node)) {
>>> +             *mode_val &= ~(MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1));
>>> +             *mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
>>> +             return 0;
>>> +     }
>>> +
>>> +     if (of_property_read_string(node, "sensor-type", &type_str)) {
>>> +             dev_err(dev, "No type for '%s'\n", node->full_name);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     if (!strcmp(type_str, "voltage")) {
>>> +             *mode_val |= (RTD_MODE_VOLTAGE & MODE_RTD_MASK)
>>> +                          << MODE_BIT_OFFSET_RTD(reg - 1);
>>> +             *mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
>>> +             return 0;
>>> +     }
>>> +
>>> +     if (strcmp(type_str, "temperature")) {
>>> +             dev_err(dev, "Invalid type '%s' for '%s'\n", type_str,
>>> +                     node->full_name);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     if (reg == 3) {
>>> +             /* RTD3 only supports thermistor mode */
>>> +             md = RTD_MODE_THERMISTOR;
>>> +     } else {
>>> +             if (of_property_read_string(node, "temperature-mode",
>>> +                                         &md_str)) {
>>> +                     dev_err(dev, "No mode for '%s'\n", node->full_name);
>>> +                     return -EINVAL;
>>> +             }
>>> +
>>> +             if (!strcmp(md_str, "thermal-diode"))
>>> +                     md = RTD_MODE_CURRENT;
>>> +             else if (!strcmp(md_str, "thermistor"))
>>> +                     md = RTD_MODE_THERMISTOR;
>>> +             else {
>>> +                     dev_err(dev, "Invalid mode '%s' for '%s'\n", md_str,
>>> +                             node->full_name);
>>> +                     return -EINVAL;
>>> +             }
>>> +     }
>>> +
>>> +     *mode_val |= (md & MODE_RTD_MASK) << MODE_BIT_OFFSET_RTD(reg - 1);
>>> +     *mode_mask |= MODE_RTD_MASK << MODE_BIT_OFFSET_RTD(reg - 1);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int nct7802_configure_channels(struct device *dev,
>>> +                                   struct nct7802_data *data)
>>> +{
>>> +     /* Enable local temperature sensor by default */
>>> +     u8 mode_mask = MODE_LTD_EN, mode_val = MODE_LTD_EN;
>>> +     struct device_node *node;
>>> +     int err;
>>> +
>>> +     if (dev->of_node) {
>>> +             for_each_child_of_node(dev->of_node, node) {
>>> +                     err = nct7802_get_channel_config(dev, node, &mode_mask,
>>> +                                                      &mode_val);
>>> +                     if (err)
>>> +                             return err;
>>> +             }
>>> +     }
>>> +
>>> +     return regmap_update_bits(data->regmap, REG_MODE, mode_mask, mode_val);
>>> +}
>>> +
>>> +static int nct7802_init_chip(struct device *dev, struct nct7802_data *data)
>>>    {
>>>        int err;
>>>
>>> @@ -1047,8 +1169,7 @@ static int nct7802_init_chip(struct nct7802_data *data)
>>>        if (err)
>>>                return err;
>>>
>>> -     /* Enable local temperature sensor */
>>> -     err = regmap_update_bits(data->regmap, REG_MODE, 0x40, 0x40);
>>> +     err = nct7802_configure_channels(dev, data);
>>>        if (err)
>>>                return err;
>>>
>>> @@ -1074,7 +1195,7 @@ static int nct7802_probe(struct i2c_client *client)
>>>        mutex_init(&data->access_lock);
>>>        mutex_init(&data->in_alarm_lock);
>>>
>>> -     ret = nct7802_init_chip(data);
>>> +     ret = nct7802_init_chip(dev, data);
>>>        if (ret < 0)
>>>                return ret;
>>>
>>>
>>

