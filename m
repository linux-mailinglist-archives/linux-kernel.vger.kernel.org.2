Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80253D8E84
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhG1NGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhG1NGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:06:06 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587C0C061757;
        Wed, 28 Jul 2021 06:06:04 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id m12so826036qvt.1;
        Wed, 28 Jul 2021 06:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=liy1+POCmEryPVpmPmrmHopIO/HPXODplF/9XMKXZ5Q=;
        b=iP8gp7c9e3RzxIW5/IIMlF0rrR33MhgrGm/S57hzaThgM7aX5IQpKmwcOPGI4W3r+N
         PUWxm10HCPYM7kz1KtFjbo+CdsL11WfZ17pttdDJ8zaHejJi/WHKQfih7ZRTWOjgcEuX
         rE5r3tN6U5HwsBON/rlSpmdnPkb2SRuS0SF6G5TdDAtPxZe60DDEKSYSj+ePgcFWHML7
         gZHz0APUYslVfJ6lw6YZXx94+eEdSdyr/kGyaJ72KOg4MwImW/mq2dzqnIQMK4vCoBqY
         CodwZjKgPwybtSULcumX1vSR205UyW0HFoaaz+rsCYhEKEhQBPLOgDUPFO7puo6Q7TPX
         +OKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=liy1+POCmEryPVpmPmrmHopIO/HPXODplF/9XMKXZ5Q=;
        b=YpLoAVUQEfl17KnftDLP5wkLCyVq0ZlF5QjXo5EfiR3UPI07RHQ2hT0eP3Q1mHBUN8
         JXS7xJ5t/HDAw8G20nJMriZVKnXNGdQ1/P/R8FEe2GIogcUs7G1oXgVawyrV1R8oYrV7
         dsGAPfLcuc19rqshYx9MnExqNfeSvGJp7SU1KhKbtz6Pl9R0xogKhz+1Zs61qaaCBnw8
         sHWt2tmKUYV3sWEdS7NeMscw/us17INtsM8430erKXtJsi6QvxFq2SqVVNBke+wyMo0p
         oEx5cUMDmkY+96p6X2nKaW8wtdhF/AjW78uGi0953B/br6t+QPvES4RpRmUfPacCR92t
         vSMg==
X-Gm-Message-State: AOAM531dHXd/CSSXKClgt7P21F+PZhDlb1otMRbq5Zxm/gKxwYSFrXZk
        T4b+rqx++HbYrinH7vpC168OhdR+diY=
X-Google-Smtp-Source: ABdhPJxgsrrQSD8I/v7OW2tLKm14CfEXN+NDhyNxsppk9b26bcolFwgiL8VFfo/vLr+bQ9rgD4EluQ==
X-Received: by 2002:ad4:5d6e:: with SMTP id fn14mr11564973qvb.35.1627477563138;
        Wed, 28 Jul 2021 06:06:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r13sm2729431qtt.38.2021.07.28.06.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 06:06:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Guohan Lu <lguohan@gmail.com>,
        Madhava Reddy Siddareddygari <msiddare@cisco.com>,
        Venkat Garigipati <venkatg@cisco.com>,
        Billie Alsup <balsup@cisco.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210728093815.8395-1-pmenzel@molgen.mpg.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC][PATCH] hwmon: (pmbus) Support 4th PSU temperature sensor
Message-ID: <423c6095-52c3-c245-c186-44e936b56cde@roeck-us.net>
Date:   Wed, 28 Jul 2021 06:05:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728093815.8395-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/21 2:38 AM, Paul Menzel wrote:
> From: Madhava Reddy Siddareddygari <msiddare@cisco.com>
> 
> PSU650W has four temperature sensors, while the pmbus driver currently
> only support three temperature sensors.
> 
> So, support a fourth temp sensor, i. e. PSU outlet temperature sensor,
> by copying what is done for temperature sensor 3, and use register 0xDF.
> 
> PSU650W is based on LITE-ON vendor.
> LITE-ON MFG part numbers for the PSU are PS-2651-3SB5 Z and PS-2651-3SA5 Z.
> 
> Signed-off-by: Madhava Reddy Siddareddygari <msiddare@cisco.com>
> Signed-off-by: Venkat Garigipati <venkatg@cisco.com>
> Cc: Billie Alsup <balsup@cisco.com>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> This as a RFC, as we know 0xDF is a manufacturer specific register, and
> cannot be added to the PMBus core driver. It was submitted to SONiC [1]
> by Cisco engineers.
> 
> It’d be great if the maintainers good suggest how to easily implement a
> custom driver for that PSU?
> 

Implement a chip driver with a set of read/write functions.
Claim it has two pages, with the second page only implementing a single
temperature sensor. In the read/write functions, handle page 0 normally,
and access the second sensor whenever page 1 is accessed.

> [1]: https://github.com/Azure/sonic-linux-kernel/pull/214

The comments there are a bit concerning.

"* Virtual registers.
  * Useful to support attributes which are not supported by standard PMBus
  * registers but exist as manufacturer specific registers on individual chips.
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  * Must be mapped to real registers in device specific code.
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
"

Then,

"... is Manufacturer specific command. These are not Virtual registers."

Isn't that exactly what the "Virtual registers" description states ?
How can that be explained better ?

Either case, I see no need to define a virtual register for a 4th temperature
sensor. This can easily be implemented with the mechanism described above.

Guenter

> 
>   drivers/hwmon/pmbus/pmbus.c      |  4 +++-
>   drivers/hwmon/pmbus/pmbus.h      |  3 +++
>   drivers/hwmon/pmbus/pmbus_core.c | 38 ++++++++++++++++++++++++++++++++
>   3 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
> index d0d386990af5..df2a782a1105 100644
> --- a/drivers/hwmon/pmbus/pmbus.c
> +++ b/drivers/hwmon/pmbus/pmbus.c
> @@ -60,8 +60,10 @@ static void pmbus_find_sensor_groups(struct i2c_client *client,
>   		info->func[0] |= PMBUS_HAVE_TEMP2;
>   	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_3))
>   		info->func[0] |= PMBUS_HAVE_TEMP3;
> +	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_4))
> +		info->func[0] |= PMBUS_HAVE_TEMP4;
>   	if (info->func[0] & (PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
> -			     | PMBUS_HAVE_TEMP3)
> +			     | PMBUS_HAVE_TEMP3 | PMBUS_HAVE_TEMP4)
>   	    && pmbus_check_byte_register(client, 0,
>   					 PMBUS_STATUS_TEMPERATURE))
>   			info->func[0] |= PMBUS_HAVE_STATUS_TEMP;
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index e0aa8aa46d8c..1522c8c7cade 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -135,6 +135,8 @@ enum pmbus_regs {
>   	PMBUS_MFR_MAX_TEMP_2		= 0xC1,
>   	PMBUS_MFR_MAX_TEMP_3		= 0xC2,
>   
> +	PMBUS_READ_TEMPERATURE_4	= 0xDF,
> +
>   /*
>    * Virtual registers.
>    * Useful to support attributes which are not supported by standard PMBus
> @@ -401,6 +403,7 @@ enum pmbus_sensor_classes {
>   #define PMBUS_HAVE_PWM12	BIT(20)
>   #define PMBUS_HAVE_PWM34	BIT(21)
>   #define PMBUS_HAVE_SAMPLES	BIT(22)
> +#define PMBUS_HAVE_TEMP4	BIT(23)
>   
>   #define PMBUS_PHASE_VIRTUAL	BIT(30)	/* Phases on this page are virtual */
>   #define PMBUS_PAGE_VIRTUAL	BIT(31)	/* Page is virtual */
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 776ee2237be2..b084b5ba6d45 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -1810,6 +1810,32 @@ static const struct pmbus_limit_attr temp_limit_attrs3[] = {
>   	},
>   };
>   
> +static const struct pmbus_limit_attr temp_limit_attrs4[] = {
> +	{
> +		.reg = PMBUS_UT_WARN_LIMIT,
> +		.low = true,
> +		.attr = "min",
> +		.alarm = "min_alarm",
> +		.sbit = PB_TEMP_UT_WARNING,
> +	}, {
> +		.reg = PMBUS_UT_FAULT_LIMIT,
> +		.low = true,
> +		.attr = "lcrit",
> +		.alarm = "lcrit_alarm",
> +		.sbit = PB_TEMP_UT_FAULT,
> +	}, {
> +		.reg = PMBUS_OT_WARN_LIMIT,
> +		.attr = "max",
> +		.alarm = "max_alarm",
> +		.sbit = PB_TEMP_OT_WARNING,
> +	}, {
> +		.reg = PMBUS_OT_FAULT_LIMIT,
> +		.attr = "crit",
> +		.alarm = "crit_alarm",
> +		.sbit = PB_TEMP_OT_FAULT,
> +	}
> +};
> +
>   static const struct pmbus_sensor_attr temp_attributes[] = {
>   	{
>   		.reg = PMBUS_READ_TEMPERATURE_1,
> @@ -1847,6 +1873,18 @@ static const struct pmbus_sensor_attr temp_attributes[] = {
>   		.gbit = PB_STATUS_TEMPERATURE,
>   		.limit = temp_limit_attrs3,
>   		.nlimit = ARRAY_SIZE(temp_limit_attrs3),
> +	}, {
> +		.reg = PMBUS_READ_TEMPERATURE_4,
> +		.class = PSC_TEMPERATURE,
> +		.paged = true,
> +		.update = true,
> +		.compare = true,
> +		.func = PMBUS_HAVE_TEMP4,
> +		.sfunc = PMBUS_HAVE_STATUS_TEMP,
> +		.sbase = PB_STATUS_TEMP_BASE,
> +		.gbit = PB_STATUS_TEMPERATURE,
> +		.limit = temp_limit_attrs4,
> +		.nlimit = ARRAY_SIZE(temp_limit_attrs4),
>   	}
>   };
>   
> 

