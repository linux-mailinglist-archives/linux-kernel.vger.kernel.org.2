Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C344D3F9C13
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245389AbhH0QGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbhH0QGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:06:47 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA83BC061757;
        Fri, 27 Aug 2021 09:05:58 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso8553217ots.5;
        Fri, 27 Aug 2021 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E3nWqqymEsD8xi96PiTnovSC4uvNmDWk9kCUiPeQGPM=;
        b=lZuWp4nXRr7vx5qKPQcInnC1MbQsAONq1nqw2RkpPYzk4VKZHDebxj6TxT7ssnb2sz
         77HdJUZA7TB/IZW2G1OLhXb+CJ+UInieJADBQwS+DTuzIQFNwmDSD1m90TEhHMPFa143
         5FWOeaKRy8fAYrJyKAJ4kwZJWbkTPd978gngS9zhTfQ3dsJEwh2s+ZmEZ2PNu6S4eJao
         rydJSbreNrFmEqMjzpYBOrcakNWxX+oqCgzYwcITQnvrBIc8sGkVTapPQD72v2aBnRYu
         MOrIjP2OOwEdIlxjMYcuKgNxKgEYri4G026p5ojt4vYm2NMgBS+s5imCiruDfvMeDwkq
         kQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E3nWqqymEsD8xi96PiTnovSC4uvNmDWk9kCUiPeQGPM=;
        b=PJp+KUxBlLU6xWgbXtC7SREShb/hnGPTRN9l0AzsArEJ4I0FgHcGIdiNRGUwP+ge+s
         QehAI+mBMdJK3UJm5wkvF+qveHK+IaQqXy6faNlHqA2P16kq3kpaY+u5QjEACmQJdP4k
         VXmcwz3pp7egt8d9Uq1p/lMg35iPCzAksxQa4P7Onw1l+mLOiOw6UMXPW5zmfCbmCXC4
         mTC5Yd6JsQLNQkkQDsvHcueemgPKeoEFrnjjgWfBzDhIJ8XxvMzcuoI0RP2BOSYJxbA7
         PCtI1/rvvsJqbfHN2w+ut0/aDOSWFO7yjTS3oA6tf+Dj02GynGJn97KL1I2+0yEupkEP
         n+hA==
X-Gm-Message-State: AOAM5323YaQlTVeBSv4fFn5q6tzxNWUiDLJpFjgVx3tg1ALh4B3kaNmE
        YXuHcOUfaXz27tfmQxffHMjPYIabx1w=
X-Google-Smtp-Source: ABdhPJxTgLgfKv/xOpgZHgV5DnwAOIuldacQXYbWpieWoDZs05FcYH7gACC1Pz879doLVILw1E+RFg==
X-Received: by 2002:a9d:3ae:: with SMTP id f43mr8693215otf.171.1630080357663;
        Fri, 27 Aug 2021 09:05:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q5sm1284366ooa.1.2021.08.27.09.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 09:05:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        "Luke D. Jones" <luke@ljones.dev>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        hadess@hadess.net, platform-driver-x86@vger.kernel.org
References: <20210826234259.5980-1-luke@ljones.dev>
 <20210826234259.5980-2-luke@ljones.dev>
 <l_wjZlSh5I-iPC46H7er23ScdheWKul7iVjIbCUAKyz1sMPoZsFiAMVZa7N2W8Kv8RnFiksYwnWkPv9X428OYZtN5Q1OtI0L8zyHc-6cs2g=@protonmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5] asus-wmi: Add support for custom fan curves
Message-ID: <29734901-e986-c77b-30bd-86a57f189e36@roeck-us.net>
Date:   Fri, 27 Aug 2021 09:05:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <l_wjZlSh5I-iPC46H7er23ScdheWKul7iVjIbCUAKyz1sMPoZsFiAMVZa7N2W8Kv8RnFiksYwnWkPv9X428OYZtN5Q1OtI0L8zyHc-6cs2g=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 8:26 AM, Barnabás Pőcze wrote:
> Hi
> 
> 
> +CC Guenter Roeck as he may be able to tell us if there's an established
> way to export fan curves.
> 

If I understand the context correctly, one would normally define pairs
of pwmX_auto_pointN_temp and pwmX_auto_pointN_pwm, with _temp
being the temperature in milli-degrees C and _pwm being a pwm value
between 0 and 255. Normally the X would refer to different fans/pwm
channels, but one could "tweak" that and declare that pwm1 is quiet,
pwm2 is default, and pwm3 is performance. One could then use pwm1_enable
values (2..4) to select the active mode.

The format isn't documented here, though, so it is hard to say if that
would be a good match. And I won't start analyzing the code trying
to understand in detail what it actually does.

Guenter

> I have added a couple comments.
> There are places where spaces are used instead of tabs.
> 
> 
> 2021. augusztus 27., péntek 1:42 keltezéssel, Luke D. Jones írta:
>> Add support for custom fan curves found on some ASUS ROG laptops.
>>
>> These laptops have the ability to set a custom curve for the CPU
>> and GPU fans via an ACPI method call. This patch enables this,
>> additionally enabling custom fan curves per-profile, where profile
>> here means each of the 3 levels of "throttle_thermal_policy".
>>
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>> ---
>>   drivers/platform/x86/asus-wmi.c            | 616 ++++++++++++++++++++-
>>   include/linux/platform_data/x86/asus-wmi.h |   2 +
>>   2 files changed, 616 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>> index cc5811844012..944644ae0acd 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -108,6 +108,11 @@ module_param(fnlock_default, bool, 0444);
>>
>>   static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
>>
>> +static int throttle_thermal_policy_write(struct asus_wmi*);
>> +static ssize_t fan_curve_store(struct asus_wmi *asus, const char *buf,
>> +								size_t count, u32 dev, char **curve,
>> +								char *default_curve);
>> +
>>   static bool ashs_present(void)
>>   {
>>   	int i = 0;
>> @@ -122,7 +127,8 @@ struct bios_args {
>>   	u32 arg0;
>>   	u32 arg1;
>>   	u32 arg2; /* At least TUF Gaming series uses 3 dword input buffer. */
>> -	u32 arg4;
>> +	u32 arg3;
>> +	u32 arg4; /* Some ROG laptops require a full 5 input args */
>>   	u32 arg5;
>>   } __packed;
>>
>> @@ -173,6 +179,21 @@ enum fan_type {
>>   	FAN_TYPE_SPEC83,	/* starting in Spec 8.3, use CPU_FAN_CTRL */
>>   };
>>
>> +struct fan_curve {
>> +	char *balanced;
>> +	char *balanced_default;
>> +	char *performance;
>> +	char *performance_default;
>> +	char *quiet;
>> +	char *quiet_default;
>> +};
>> +
>> +struct enabled_fan_curves {
>> +	bool balanced;
>> +	bool performance;
>> +	bool quiet;
>> +};
>> +
>>   struct asus_wmi {
>>   	int dsts_id;
>>   	int spec;
>> @@ -220,6 +241,14 @@ struct asus_wmi {
>>   	bool throttle_thermal_policy_available;
>>   	u8 throttle_thermal_policy_mode;
>>
>> +	bool cpu_fan_curve_available;
>> +	struct fan_curve cpu_fan_curve;
>> +
>> +    bool gpu_fan_curve_available;
>> +	struct fan_curve gpu_fan_curve;
>> +
>> +	struct enabled_fan_curves enabled_fan_curve_profiles;
> 
> I would suggest something like the following:
> 
>    struct fan_curve {
>      /* bool enabled; */
>      u8 temps[FAN_CURVE_SIZE];
>      u8 percents[FAN_CURVE_SIZE];
>    };
> 
>    struct fan {
>      bool available;
>      struct fan_curve curves[NUM_PERF_PROFILES];
>    };
> 
>    struct asus_wmi {
>      ...
> 
>      struct fan fans[NUM_FANS];
> 
>      bool fan_curve_enabled_for_profile[NUM_PERF_PROFILES];
>      /* or maybe you could add it as `bool enabled;` into the inner struct */
>    };
> 
> see the reason later.
> 
> 
>> +
>>   	struct platform_profile_handler platform_profile_handler;
>>   	bool platform_profile_support;
>>
>> @@ -285,6 +314,85 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
>>   }
>>   EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
>>
>> +static int asus_wmi_evaluate_method5(u32 method_id,
>> +		u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 *retval)
>> +{
>> +	struct bios_args args = {
>> +		.arg0 = arg0,
>> +		.arg1 = arg1,
>> +		.arg2 = arg2,
>> +		.arg3 = arg3,
>> +		.arg4 = arg4,
>> +	};
>> +	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
>> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
>> +	acpi_status status;
>> +	union acpi_object *obj;
>> +	u32 tmp = 0;
>> +
>> +	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
>> +				     &input, &output);
>> +
>> +	if (ACPI_FAILURE(status))
>> +		return -EIO;
>> +
>> +	obj = (union acpi_object *)output.pointer;
> 
> Small thing, but this cast is unnecessary.
> 
> 
>> +	if (obj && obj->type == ACPI_TYPE_INTEGER)
>> +		tmp = (u32) obj->integer.value;
> 
> Same here.
> 
> 
>> +
>> +	if (retval)
>> +		*retval = tmp;
>> +
>> +	kfree(obj);
>> +
>> +	if (tmp == ASUS_WMI_UNSUPPORTED_METHOD)
>> +		return -ENODEV;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Returns as an error if the method output is not a buffer. Typically this
>> + * means that the method called is unsupported.
>> +*/
>> +static int asus_wmi_evaluate_method_buf(u32 method_id,
>> +		u32 arg0, u32 arg1, u8 *ret_buffer)
>> +{
>> +	struct bios_args args = {
>> +		.arg0 = arg0,
>> +		.arg1 = arg1,
>> +		.arg2 = 0,
>> +	};
>> +	struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
>> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
>> +	acpi_status status;
>> +	union acpi_object *obj;
>> +	u32 int_tmp = 0;
>> +
>> +	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
>> +				     &input, &output);
>> +
>> +	if (ACPI_FAILURE(status))
>> +		return -EIO;
>> +
>> +	obj = (union acpi_object *)output.pointer;
>> +
>> +	if (obj && obj->type == ACPI_TYPE_INTEGER) {
>> +		int_tmp = (u32) obj->integer.value;
>> +		if (int_tmp == ASUS_WMI_UNSUPPORTED_METHOD)
>> +			return -ENODEV;
>> +		return int_tmp;
>> +	}
>> +
>> +	if (obj && obj->type == ACPI_TYPE_BUFFER) {
>> +		memcpy(ret_buffer, obj->buffer.pointer, obj->buffer.length);
>> +	}
>> +
>> +	kfree(obj);
>> +
>> +	return 0;
>> +}
>> +
>>   static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer args)
>>   {
>>   	struct acpi_buffer input;
>> @@ -1813,7 +1921,7 @@ static ssize_t fan1_label_show(struct device *dev,
>>   					  struct device_attribute *attr,
>>   					  char *buf)
>>   {
>> -	return sprintf(buf, "%s\n", ASUS_FAN_DESC);
>> +	return sprintf(buf, "%s", ASUS_FAN_DESC);
> 
> What is the reason for this change?
> 
> 
>>   }
>>
>>   static ssize_t asus_hwmon_temp1(struct device *dev,
>> @@ -2043,6 +2151,458 @@ static ssize_t fan_boost_mode_store(struct device *dev,
>>   // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
>>   static DEVICE_ATTR_RW(fan_boost_mode);
>>
>> +/* Custom fan curves per-profile **********************************************/
>> +
>> +/*
>> + * Check if the ability to set fan curves on either fan exists, and store the
>> + * defaults for recall later plus to provide users with a starting point.
>> + *
>> + * "dev" is either CPU_FAN_CURVE or GPU_FAN_CURVE.
>> +*/
>> +static int custom_fan_check_present(struct asus_wmi *asus,
>> +									bool *available, u32 dev)
>> +{
>> +	struct fan_curve *curves = &asus->cpu_fan_curve;
>> +	u8 *buf = kzalloc(16 * sizeof(u8), GFP_KERNEL);
> 
> Is dynamic allocation needed here? No early return frees it.
> 
> 
>> +	/* 15 punctuation marks + 16 sets of numbers up to 3 char each */
>> +	int str_len = 15 + 16 * 3;
> 
> It appears to me that the terminating null byte is not accounted for. E.g.:
> 
>    255:255,255:255,255:255,255:255,255:255,255:255,255:255,255:255
> 
> is itself already 63 (= 15 + 16 x 3) characters.
> 
> And if the maximum length is known, and it's reasonably small, why is it not
> part of the struct as a char array? E.g.:
> 
>    struct fan_curve {
>      char balanced[FAN_CURVE_STR_SIZE]; /* #define FAN_CURVE_STR_SIZE 64 */
>      ...
>    };
> 
> I would actually suggest storing the u8 array itself in the fan curve struct,
> and not a string representation of it. I think the data is easier to deal with
> that way, and the price of formatting it for the sysfs attribute is not
> significant.
> 
> 
>> +	int err;
>> +
>> +	*available = false;
>> +
>> +	if (dev == ASUS_WMI_DEVID_GPU_FAN_CURVE)
>> +		curves = &asus->gpu_fan_curve;
>> +
>> +	/* Balanced default */
>> +	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 0, buf);
>> +	if (err) {
>> +		if (err == -ENODEV)
>> +			return 0;
>> +		return err;
>> +	}
>> +
>> +	curves->balanced = kzalloc(str_len * sizeof(char), GFP_KERNEL);
>> +	if (!curves->balanced)
>> +		return -ENOMEM;
>> +
>> +	curves->balanced_default = kzalloc(str_len * sizeof(char), GFP_KERNEL);
>> +	if (!curves->balanced_default)
>> +		return -ENOMEM;
>> +
>> +	sprintf(curves->balanced, "%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d",
>> +		buf[0], buf[8], buf[1], buf[9], buf[2], buf[10], buf[3], buf[11],
>> +		buf[4], buf[12], buf[5], buf[13], buf[6], buf[14], buf[7], buf[15]);
>> +	sprintf(curves->balanced_default, curves->balanced);
>> +
>> +	/* Quiet default */
>> +	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 1, buf);
>> +	if (err) {
>> +		if (err == -ENODEV)
>> +			return 0;
>> +		return err;
>> +	}
>> +
>> +	curves->quiet = kzalloc(str_len * sizeof(char), GFP_KERNEL);
>> +	if (!curves->quiet)
>> +		return -ENOMEM;
>> +
>> +	curves->quiet_default = kzalloc(str_len * sizeof(char), GFP_KERNEL);
>> +	if (!curves->quiet_default)
>> +		return -ENOMEM;
>> +
>> +	sprintf(curves->quiet, "%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d",
>> +		buf[0], buf[8], buf[1], buf[9], buf[2], buf[10], buf[3], buf[11],
>> +		buf[4], buf[12], buf[5], buf[13], buf[6], buf[14], buf[7], buf[15]);
>> +	sprintf(curves->quiet_default, curves->quiet);
>> +
>> +	/* Performance default */
>> +	err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 2, buf);
>> +	if (err) {
>> +		if (err == -ENODEV)
>> +			return 0;
>> +		return err;
>> +	}
>> +
>> +	curves->performance = kzalloc(str_len * sizeof(char), GFP_KERNEL);
>> +	if (!curves->performance)
>> +		return -ENOMEM;
>> +
>> +	curves->performance_default = kzalloc(str_len * sizeof(char), GFP_KERNEL);
>> +	if (!curves->performance_default)
>> +		return -ENOMEM;
>> +
>> +	sprintf(curves->performance,
>> +		"%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d",
>> +		buf[0], buf[8], buf[1], buf[9], buf[2], buf[10], buf[3], buf[11],
>> +		buf[4], buf[12], buf[5], buf[13], buf[6], buf[14], buf[7], buf[15]);
>> +	sprintf(curves->performance_default, curves->performance);
> 
> More or less the same code is repeated three times, I'd consider adding an e.g.
> 
>    void fan_curve_to_str(..., char[static FAN_CURVE_STR_SIZE]);
> 
> function.
> 
> 
>> +
>> +	kfree(buf);
>> +
>> +	*available = true;
>> +	return 0;
>> +}
>> +
>> +/*
>> + * The expected input is of the format
>> + *     "30:1,49:2,59:3,69:4,79:31,89:49,99:56,109:58"
>> + * where a pair is 30:1, with 30 = temperature, and 1 = percentage
>> +*/
>> +static int fan_curve_write(struct asus_wmi *asus, u32 dev, char *curve)
>> +{
>> +    char * buf, *set, *pair_tmp, *pair, *set_end, *pair_end;
>> +    int err, ret;
>> +
>> +	char *set_delimiter = ",";
>> +	char *pair_delimiter = ":";
>> +	bool half_complete = false;
>> +	bool pair_start = true;
>> +	u32 prev_percent = 0;
>> +	u32 prev_temp = 0;
>> +	u32 percent = 0;
>> +	u32 shift = 0;
>> +	u32 temp = 0;
>> +    u32 arg1 = 0;
>> +    u32 arg2 = 0;
>> +    u32 arg3 = 0;
>> +    u32 arg4 = 0;
>> +
>> +    buf = set_end = pair_end = kstrdup(curve, GFP_KERNEL);
>> +
>> +	while( (set = strsep(&set_end, set_delimiter)) != NULL ) {
>> +		pair_tmp = kstrdup(set, GFP_KERNEL);
>> +        pair_start = true;
>> +		while( (pair = strsep(&pair_tmp, pair_delimiter)) != NULL ) {
>> +			err = kstrtouint(pair, 10, &ret);
>> +            if (err) {
>> +                kfree(pair_tmp);
>> +                kfree(buf);
>> +                return err;
>> +            }
>> +
>> +            if (pair_start) {
>> +                temp = ret;
>> +                pair_start = false;
>> +            } else {
>> +                percent = ret;
>> +            }
>> +		}
>> +		kfree(pair_tmp);
>> +
>> +		if (temp < prev_temp || percent < prev_percent || percent > 100) {
>> +            pr_info("Fan curve invalid");
>> +			pr_info("A value is sequentially lower or percentage is > 100");
>> +            kfree(buf);
>> +            return -EINVAL;
>> +        }
>> +
>> +        prev_temp = temp;
>> +        prev_percent = percent;
>> +
>> +        if (!half_complete) {
>> +            arg1 += temp << shift;
>> +            arg3 += percent << shift;
>> +        } else {
>> +            arg2 += temp << shift;
>> +            arg4 += percent << shift;
>> +        }
> 
> As far as I see using 64-bit integers would avoid the need for `half_complete`, et al.
> 
> 
>> +        shift += 8;
>> +
>> +        if (shift == 32) {
>> +            shift = 0;
>> +            half_complete = true;
>> +        }
>> +	}
>> +	kfree(buf);
>> +
> 
> If you don't insist on using commas, I think it is much simpler to
> parse it using `sscanf()`, e.g.:
> 
>    unsigned int temp, prct;
>    int at = 0, len;
> 
>    while (sscanf(&buf[at], "%u:%u %n", &temp, &prct, &len) == 2) {
>      /* process `temp` and `prct` */
> 
>      at += len;
>    }
> 
>    if (buf[at] != '\0')
>      /* error */;
> 
> This also has the advantage that you don't need dynamic memory allocation.
> 
> 
>> +    return asus_wmi_evaluate_method5(ASUS_WMI_METHODID_DEVS, dev,
>> +									 arg1, arg2, arg3, arg4, &ret);
>> +}
>> +
>> +static int fan_curve_cpu_write(struct asus_wmi *asus)
>> +{
>> +	char *curve = NULL;
>> +	int err, mode;
>> +
>> +	mode = asus->throttle_thermal_policy_mode;
>> +
>> +	if (mode == ASUS_THROTTLE_THERMAL_POLICY_DEFAULT
>> +					&& asus->enabled_fan_curve_profiles.balanced) {
>> +		curve = asus->cpu_fan_curve.balanced;
>> +	} else if (mode == ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST
>> +					&& asus->enabled_fan_curve_profiles.performance) {
>> +		curve = asus->cpu_fan_curve.performance;
>> +	} else if (mode == ASUS_THROTTLE_THERMAL_POLICY_SILENT
>> +					&& asus->enabled_fan_curve_profiles.quiet) {
>> +		curve = asus->cpu_fan_curve.quiet;
>> +	}
>> +
>> +	if (curve != NULL) {
>> +		err = fan_curve_write(asus, ASUS_WMI_DEVID_CPU_FAN_CURVE, curve);
>> +		if (err)
>> +			return err;
>> +	}
>> +	return 0;
>> +}
>> +
>> +
>> +static int fan_curve_gpu_write(struct asus_wmi *asus)
>> +{
>> +	char *curve = NULL;
>> +	int err, mode;
>> +
>> +	mode = asus->throttle_thermal_policy_mode;
>> +
>> +	if (mode == ASUS_THROTTLE_THERMAL_POLICY_DEFAULT
>> +					&& asus->enabled_fan_curve_profiles.balanced) {
>> +		curve = asus->gpu_fan_curve.balanced;
>> +	} else if (mode == ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST
>> +					&& asus->enabled_fan_curve_profiles.performance) {
>> +		curve = asus->gpu_fan_curve.performance;
>> +	} else if (mode == ASUS_THROTTLE_THERMAL_POLICY_SILENT
>> +					&& asus->enabled_fan_curve_profiles.quiet) {
>> +		curve = asus->gpu_fan_curve.quiet;
>> +	}
>> +
>> +	if (curve != NULL) {
>> +		err = fan_curve_write(asus, ASUS_WMI_DEVID_GPU_FAN_CURVE, curve);
>> +		if (err)
>> +			return err;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static ssize_t fan_curve_store(struct asus_wmi *asus, const char *buf,
>> +								size_t count, u32 dev, char **curve,
>> +								char *default_curve)
>> +{
>> +    int err;
>> +
>> +	/* Allow a user to write "" or " " to erase a curve setting */
>> +	if (strlen(buf) <= 1 || strcmp(buf, " \n") == 0) {
>> +		kfree(*curve);
>> +		*curve = kstrdup(default_curve, GFP_KERNEL);
>> +		err = throttle_thermal_policy_write(asus);
>> +		if (err)
>> +			return err;
>> +		return count;
>> +	}
>> +
>> +	if (*curve)
>> +		kfree(*curve);
>> +    *curve = kstrdup(buf, GFP_KERNEL);
>> +
>> +	/* Maybe activate fan curve if in associated mode */
>> +	err = throttle_thermal_policy_write(asus);
>> +	if (err) {
>> +		kfree(*curve);
>> +		*curve = kstrdup(default_curve, GFP_KERNEL);
>> +		return err;
>> +	}
>> +
>> +    return count;
>> +}
>> +
>> +/*
>> + * CPU Fan Curves
>> +*/
>> +
>> +static ssize_t cpu_fan_curve_balanced_show(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	struct asus_wmi *asus = dev_get_drvdata(dev);
>> +	return scnprintf(buf, PAGE_SIZE, "%s", asus->cpu_fan_curve.balanced);
>> +}
>> +
>> +static ssize_t cpu_fan_curve_balanced_store(struct device *dev,
>> +				    struct device_attribute *attr,
>> +				    const char *buf, size_t count)
>> +{
>> +    struct asus_wmi *asus = dev_get_drvdata(dev);
>> +    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_CPU_FAN_CURVE,
>> +							&asus->cpu_fan_curve.balanced,
>> +							asus->cpu_fan_curve.balanced_default);
>> +}
>> +
>> +static DEVICE_ATTR_RW(cpu_fan_curve_balanced);
>> +
>> +static ssize_t cpu_fan_curve_performance_show(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	struct asus_wmi *asus = dev_get_drvdata(dev);
>> +	return scnprintf(buf, PAGE_SIZE, "%s", asus->cpu_fan_curve.performance);
>> +}
>> +
>> +static ssize_t cpu_fan_curve_performance_store(struct device *dev,
>> +				    struct device_attribute *attr,
>> +				    const char *buf, size_t count)
>> +{
>> +    struct asus_wmi *asus = dev_get_drvdata(dev);
>> +    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_CPU_FAN_CURVE,
>> +							&asus->cpu_fan_curve.performance,
>> +							asus->cpu_fan_curve.performance_default);
>> +}
>> +
>> +static DEVICE_ATTR_RW(cpu_fan_curve_performance);
>> +
>> +static ssize_t cpu_fan_curve_quiet_show(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	struct asus_wmi *asus = dev_get_drvdata(dev);
>> +	return scnprintf(buf, PAGE_SIZE, "%s", asus->cpu_fan_curve.quiet);
>> +}
>> +
>> +static ssize_t cpu_fan_curve_quiet_store(struct device *dev,
>> +				    struct device_attribute *attr,
>> +				    const char *buf, size_t count)
>> +{
>> +    struct asus_wmi *asus = dev_get_drvdata(dev);
>> +    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_CPU_FAN_CURVE,
>> +							&asus->cpu_fan_curve.quiet,
>> +							asus->cpu_fan_curve.quiet_default);
>> +}
>> +
>> +static DEVICE_ATTR_RW(cpu_fan_curve_quiet);
>> +
>> +/*
>> + * GPU Fan Curves
>> +*/
>> +
>> +static ssize_t gpu_fan_curve_balanced_show(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	struct asus_wmi *asus = dev_get_drvdata(dev);
>> +	return scnprintf(buf, PAGE_SIZE, "%s", asus->gpu_fan_curve.balanced);
>> +}
>> +
>> +static ssize_t gpu_fan_curve_balanced_store(struct device *dev,
>> +				    struct device_attribute *attr,
>> +				    const char *buf, size_t count)
>> +{
>> +    struct asus_wmi *asus = dev_get_drvdata(dev);
>> +    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_GPU_FAN_CURVE,
>> +							&asus->gpu_fan_curve.balanced,
>> +							asus->gpu_fan_curve.balanced_default);
>> +}
>> +
>> +static DEVICE_ATTR_RW(gpu_fan_curve_balanced);
>> +
>> +static ssize_t gpu_fan_curve_performance_show(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	struct asus_wmi *asus = dev_get_drvdata(dev);
>> +	return scnprintf(buf, PAGE_SIZE, "%s", asus->gpu_fan_curve.performance);
>> +}
>> +
>> +static ssize_t gpu_fan_curve_performance_store(struct device *dev,
>> +				    struct device_attribute *attr,
>> +				    const char *buf, size_t count)
>> +{
>> +    struct asus_wmi *asus = dev_get_drvdata(dev);
>> +    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_GPU_FAN_CURVE,
>> +							&asus->gpu_fan_curve.performance,
>> +							asus->gpu_fan_curve.performance_default);
>> +}
>> +
>> +static DEVICE_ATTR_RW(gpu_fan_curve_performance);
>> +
>> +static ssize_t gpu_fan_curve_quiet_show(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	struct asus_wmi *asus = dev_get_drvdata(dev);
>> +	return scnprintf(buf, PAGE_SIZE, "%s", asus->gpu_fan_curve.quiet);
>> +}
>> +
>> +static ssize_t gpu_fan_curve_quiet_store(struct device *dev,
>> +				    struct device_attribute *attr,
>> +				    const char *buf, size_t count)
>> +{
>> +    struct asus_wmi *asus = dev_get_drvdata(dev);
>> +    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_GPU_FAN_CURVE,
>> +							&asus->gpu_fan_curve.quiet,
>> +							asus->gpu_fan_curve.quiet_default);
>> +}
>> +
>> +static DEVICE_ATTR_RW(gpu_fan_curve_quiet);
> 
> Even though it is a hwmon thing, I think `SENSOR_ATTR_2()` (from linux/hwmon-sysfs.h)
> would be very useful here as you'd avoid creating n+1 functions, e.g:
> 
>    static ssize_t fan_curve_show(struct device *dev, struct device_attribute *attr, char *buf)
>    {
>      struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
>      struct asus_wmi *asus = dev_get_drvdata(dev);
> 
>      /*
>       * if you stored fan curves in an array, you could then access the fan
>       * curve in `asus->fans[sattr->index].curves[sattr->nr]`
>       * /
>    }
> 
>    static SENSOR_DEVICE_ATTR_2(some_name1, 0644, fan_curve_show, fan_curve_store,
>                                FAN_CPU /* index in the "fans" array */,
>                                ASUS_THROTTLE_THERMAL_POLICY_SILENT /* index in the "curves" array */);
> 
> 
>> +
>> +/*
>> + * Profiles with enabled fan curve setting
>> +*/
>> +
>> +static int enabled_fan_curve_profiles_write(struct asus_wmi *asus,
>> +											const char *names)
>> +{
>> +    char *buf, *set, *set_end;
>> +    int err;
>> +
>> +    buf = set_end = kstrdup(names, GFP_KERNEL);
>> +
>> +	/* Reset before checking */
>> +	asus->enabled_fan_curve_profiles.balanced = false;
>> +	asus->enabled_fan_curve_profiles.quiet = false;
>> +	asus->enabled_fan_curve_profiles.performance = false;
>> +
>> +	while( (set = strsep(&set_end, " ")) != NULL ) {
>> +		if (set == NULL)
> 
> When is this possible?
> 
> 
>> +			set = buf;
>> +
>> +		if (strcmp(set, "balanced") == 0
>> +				|| strcmp(set, "balanced\n") == 0)
>> +			asus->enabled_fan_curve_profiles.balanced = true;
>> +
>> +		if (strcmp(set, "quiet") == 0
>> +				|| strcmp(set, "quiet\n") == 0)
>> +			asus->enabled_fan_curve_profiles.quiet = true;
>> +
>> +		if (strcmp(set, "performance") == 0
>> +				|| strcmp(set, "performance\n") == 0)
>> +			asus->enabled_fan_curve_profiles.performance = true;
> 
> If you store the enabled curves in an array, and you have a list of profile names,
> then `sysfs_match_string()`, will be very helpful here. You could do something like:
> 
>    int profile = sysfs_match_string(profile_names, set);
>    if (profile < 0) {
>      /* not found */
>    }
> 
>    asus->fan_curve_enabled_for_profile[profile] = true;
> 
> 
>> +	}
>> +
>> +	err = throttle_thermal_policy_write(asus);
>> +	if (err)
>> +		return err;
>> +
>> +	kfree(buf);
>> +
>> +	return 0;
>> +}
>> +
>> +static ssize_t enabled_fan_curve_profiles_show(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	struct asus_wmi *asus = dev_get_drvdata(dev);
>> +	int len = 0;
>> +
>> +	if (asus->enabled_fan_curve_profiles.balanced)
>> +		len += sysfs_emit_at(buf, len, "balanced ");
>> +
>> +	if (asus->enabled_fan_curve_profiles.performance)
>> +		len += sysfs_emit_at(buf, len, "performance ");
>> +
>> +	if (asus->enabled_fan_curve_profiles.quiet)
>> +		len += sysfs_emit_at(buf, len, "quiet ");
>> +
>> +	len += sysfs_emit_at(buf, len, "\n");
>> +	return len;
>> +}
>> +
>> +static ssize_t enabled_fan_curve_profiles_store(struct device *dev,
>> +				    struct device_attribute *attr,
>> +				    const char *buf, size_t count)
>> +{
>> +    struct asus_wmi *asus = dev_get_drvdata(dev);
>> +	int err;
>> +
>> +	err = enabled_fan_curve_profiles_write(asus, buf);
>> +	if (err)
>> +		return err;
>> +
>> +    return count;
>> +}
>> +
>> +static DEVICE_ATTR_RW(enabled_fan_curve_profiles);
>> +
>>   /* Throttle thermal policy ****************************************************/
>>
>>   static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
>> @@ -2092,6 +2652,26 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
>>   		return -EIO;
>>   	}
>>
>> +	if (asus->cpu_fan_curve_available) {
>> +		err = fan_curve_cpu_write(asus);
>> +		if (err) {
>> +			dev_warn(&asus->platform_device->dev,
>> +				"Failed to set custom CPU curve for thermal policy: %d\n",
>> +				err);
>> +			return err;
>> +		}
>> +	}
>> +
>> +	if (asus->gpu_fan_curve_available) {
>> +		err = fan_curve_gpu_write(asus);
>> +		if (err) {
>> +			dev_warn(&asus->platform_device->dev,
>> +				"Failed to set custom GPU curve for thermal policy: %d\n",
>> +				err);
>> +			return err;
>> +		} >> +	}
>> +
>>   	return 0;
>>   }
>>
>> @@ -2711,6 +3291,13 @@ static struct attribute *platform_attributes[] = {
>>   	&dev_attr_als_enable.attr,
>>   	&dev_attr_fan_boost_mode.attr,
>>   	&dev_attr_throttle_thermal_policy.attr,
>> +	&dev_attr_cpu_fan_curve_balanced.attr,
>> +	&dev_attr_cpu_fan_curve_performance.attr,
>> +	&dev_attr_cpu_fan_curve_quiet.attr,
>> +    &dev_attr_gpu_fan_curve_balanced.attr,
>> +	&dev_attr_gpu_fan_curve_performance.attr,
>> +	&dev_attr_gpu_fan_curve_quiet.attr,
>> +	&dev_attr_enabled_fan_curve_profiles.attr,
>>   	&dev_attr_panel_od.attr,
>>   	NULL
>>   };
>> @@ -2741,6 +3328,20 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>>   		ok = asus->fan_boost_mode_available;
>>   	else if (attr == &dev_attr_throttle_thermal_policy.attr)
>>   		ok = asus->throttle_thermal_policy_available;
>> +	else if (attr == &dev_attr_cpu_fan_curve_balanced.attr)
>> +		ok = asus->cpu_fan_curve_available;
>> +	else if (attr == &dev_attr_cpu_fan_curve_performance.attr)
>> +		ok = asus->cpu_fan_curve_available;
>> +	else if (attr == &dev_attr_cpu_fan_curve_quiet.attr)
>> +		ok = asus->cpu_fan_curve_available;
>> +    else if (attr == &dev_attr_gpu_fan_curve_balanced.attr)
>> +		ok = asus->gpu_fan_curve_available;
>> +	else if (attr == &dev_attr_gpu_fan_curve_performance.attr)
>> +		ok = asus->gpu_fan_curve_available;
>> +	else if (attr == &dev_attr_gpu_fan_curve_quiet.attr)
>> +		ok = asus->gpu_fan_curve_available;
>> +	else if (attr == &dev_attr_enabled_fan_curve_profiles.attr)
>> +		ok = asus->cpu_fan_curve_available || asus->gpu_fan_curve_available;
>>   	else if (attr == &dev_attr_panel_od.attr)
>>   		ok = asus->panel_overdrive_available;
>>
>> @@ -3016,6 +3617,16 @@ static int asus_wmi_add(struct platform_device *pdev)
>>   	else
>>   		throttle_thermal_policy_set_default(asus);
>>
>> +	err = custom_fan_check_present(asus, &asus->cpu_fan_curve_available,
>> +			ASUS_WMI_DEVID_CPU_FAN_CURVE);
>> +	if (err)
>> +		goto fail_custom_fan_curve;
>> +
>> +    err = custom_fan_check_present(asus, &asus->gpu_fan_curve_available,
>> +			ASUS_WMI_DEVID_GPU_FAN_CURVE);
>> +	if (err)
>> +		goto fail_custom_fan_curve;
>> +
>>   	err = platform_profile_setup(asus);
>>   	if (err)
>>   		goto fail_platform_profile_setup;
>> @@ -3109,6 +3720,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>>   	asus_wmi_sysfs_exit(asus->platform_device);
>>   fail_sysfs:
>>   fail_throttle_thermal_policy:
>> +fail_custom_fan_curve:
>>   fail_platform_profile_setup:
>>   	if (asus->platform_profile_support)
>>   		platform_profile_remove();
>> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
>> index 17dc5cb6f3f2..a571b47ff362 100644
>> --- a/include/linux/platform_data/x86/asus-wmi.h
>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>> @@ -77,6 +77,8 @@
>>   #define ASUS_WMI_DEVID_THERMAL_CTRL	0x00110011
>>   #define ASUS_WMI_DEVID_FAN_CTRL		0x00110012 /* deprecated */
>>   #define ASUS_WMI_DEVID_CPU_FAN_CTRL	0x00110013
>> +#define ASUS_WMI_DEVID_CPU_FAN_CURVE	0x00110024
>> +#define ASUS_WMI_DEVID_GPU_FAN_CURVE	0x00110025
>>
>>   /* Power */
>>   #define ASUS_WMI_DEVID_PROCESSOR_STATE	0x00120012
>> --
>> 2.31.1
> 
> 
> Best regards,
> Barnabás Pőcze
> 

