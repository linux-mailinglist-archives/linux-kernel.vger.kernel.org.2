Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE20240A8E2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhINIKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:10:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230413AbhINIIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631606824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7HEiK0pU3fyQjtbG6DJhI84/RgdZ7V7PoWYfFX3Lp88=;
        b=L6Sq4/ckyUTArqPYAkgkiwdMRuPYbEK+W8GiqJTWr+PN08PvI8y3LJqx+2tSPay1Y/wvVV
        u1z22S/KAtMjmoGZAsn/SulWFJ0b6vuD5sujeTVZcw/3CbMhuZ+UuJWmxJjW1IqMYlL3cr
        Y428Yk7NUDeOx8+KaGVd5Yun/ICDjIs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-t5F-afIWNimatHkUAw_wmw-1; Tue, 14 Sep 2021 04:07:02 -0400
X-MC-Unique: t5F-afIWNimatHkUAw_wmw-1
Received: by mail-ej1-f70.google.com with SMTP id o7-20020a170906288700b005bb05cb6e25so4932070ejd.23
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7HEiK0pU3fyQjtbG6DJhI84/RgdZ7V7PoWYfFX3Lp88=;
        b=IthWjI0VKIBy2U9q0RJKDEY5H8DR17TTwAXeLFZESXwXuO6PyKfgF/nwjVAgw/TFC5
         f+aZ7TLI+f1fY4JHsKjLX/yo2P3ZV8X4Q3sB/Z+sQYRK4ABw9zaDLeiT6539NzPnsOdh
         I1ooOZJoAhEgjHUDPknm9s36IwvmLmsdPimBvbmHz8ajgTSgGsb8g6xYwlJRmgy+Or0s
         OtzC3sMIp2pMbQzCqHS3022nFe9+bKMtjAkEtSzBRuM+sRcsOpdZjLkRwWmibhdn4V/Z
         u89M2nGPCOta/UKV0GgabfRPB6oPo/yzf56uIIdfVa2qpEYFrJq2edQo+1uMtbXROAvV
         vp8A==
X-Gm-Message-State: AOAM532K9GAcTZjKQf/GOk6xkWCbtqkW30W+/yPeHzYk3mzp92NRNtZv
        KkOv+nLndMA2KoJwvapDftSgkKk6nKC3BLhlMMU2BjtcFbz2WywnB4w/Lx6mEXYB8EJjL4An0pO
        kjncDD97mGBC3T+Kg1RmqBdlr
X-Received: by 2002:a05:6402:1006:: with SMTP id c6mr14888781edu.301.1631606821347;
        Tue, 14 Sep 2021 01:07:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwy9OkmuOLh6t/FP5Th817x5kUMJbMjTZ1upYpm+2kZdNAGFSMEa2suzyhCvImF4kqt3X4Jiw==
X-Received: by 2002:a05:6402:1006:: with SMTP id c6mr14888755edu.301.1631606820954;
        Tue, 14 Sep 2021 01:07:00 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id a18sm5061666edj.52.2021.09.14.01.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 01:07:00 -0700 (PDT)
Subject: Re: [PATCH v13 1/1] asus-wmi: Add support for custom fan curves
To:     Luke Jones <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc:     pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org
References: <20210912063559.14663-1-luke@ljones.dev>
 <20210912063559.14663-2-luke@ljones.dev> <19MEZQ.UTU6ZTMH35X42@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cb873214-617a-9fca-1f59-72e59ea89517@redhat.com>
Date:   Tue, 14 Sep 2021 10:06:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <19MEZQ.UTU6ZTMH35X42@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 9/14/21 5:12 AM, Luke Jones wrote:
> Hi all,
> 
> I'm painfully aware of how many versions this has gone through now. I have found two small issues to fix unfortunately, after I was certain I had tested everything and dotted the tees. But after implementing the userspace API in asusctl I found the following.
> 
> - V14
>  - Fix incorrect logic in fan_curve_get_factory_default()
>  - Ensure fan_curve_enable_show() displays correct status for state
> 
> I won't submit V14 just yet. I'm going to have some of the community test the API in this and asusctl to ensure all is caught this time.

No worries, I deliberately did not start reviewing v13 yet, with the
idea that given how fast new revisions were coming their might
be a new one, so that it would be better to wait a few days :)

> However I was very much hoping to get this in to 5.15 kernel, it feels like that window is closing?

Ah, that window has closed a long time ago, to get into 5.(x + 1)
a patch needs to be fully ready for merging when 5.x-rc6 is released.

Then it can bake 1-2 weeks in -next and be send to Linus during
the 2 week merge window before 5.(x + 1)-rc1 is released.

So for this to have gotten into 5.15-rc1 it would have need to be
ready for merging in the week that 5.14-rc6 was released.

After rc1 (which came out for 5.15 yesterday) only bugfixes are
accepted. rc2-rc7 is meant to stabilize the kernel before the
official release.

So you have till 5.15-rc6 now to get this ready, and with
1 rc per week that gives you 5-6 weeks.

Regards,

Hans


> On Sun, Sep 12 2021 at 18:35:59 +1200, Luke D. Jones <luke@ljones.dev> wrote:
>> Add support for custom fan curves found on some ASUS ROG laptops.
>>
>> These laptops have the ability to set a custom curve for the CPU
>> and GPU fans via two ACPI methods.
>>
>> This patch adds two pwm<N> attributes to the hwmon sysfs,
>> pwm1 for CPU fan, pwm2 for GPU fan. Both are under the hwmon of the
>> name `asus_custom_fan_curve`. There is no safety check of the set
>> fan curves - this must be done in userspace.
>>
>> The fans have settings [1,2,3] under pwm<N>_enable:
>> 1. Enable and write settings out
>> 2. Disable and use factory fan mode
>> 3. Same as 2, additionally restoring default factory curve.
>>
>> Use of 2 means that the curve the user has set is still stored and
>> won't be erased, but the laptop will be using its default auto-fan
>> mode. Re-enabling the manual mode then activates the curves again.
>>
>> Notes:
>> - pwm<N>_enable = 0 is an invalid setting.
>> - pwm is actually a percentage and is scaled on writing to device.
>>
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>> ---
>>  drivers/platform/x86/asus-wmi.c            | 607 ++++++++++++++++++++-
>>  include/linux/platform_data/x86/asus-wmi.h |   2 +
>>  2 files changed, 601 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>> index e14fb5fa7324..097e41a48947 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -106,8 +106,17 @@ module_param(fnlock_default, bool, 0444);
>>
>>  #define WMI_EVENT_MASK            0xFFFF
>>
>> +#define FAN_CURVE_POINTS        8
>> +#define FAN_CURVE_BUF_LEN        (FAN_CURVE_POINTS * 2)
>> +#define FAN_CURVE_DEV_CPU        0x00
>> +#define FAN_CURVE_DEV_GPU        0x01
>> +/* Mask to determine if setting temperature or percentage */
>> +#define FAN_CURVE_PWM_MASK        0x04
>> +
>>  static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
>>
>> +static int throttle_thermal_policy_write(struct asus_wmi *);
>> +
>>  static bool ashs_present(void)
>>  {
>>      int i = 0;
>> @@ -122,7 +131,8 @@ struct bios_args {
>>      u32 arg0;
>>      u32 arg1;
>>      u32 arg2; /* At least TUF Gaming series uses 3 dword input buffer. */
>> -    u32 arg4;
>> +    u32 arg3;
>> +    u32 arg4; /* Some ROG laptops require a full 5 input args */
>>      u32 arg5;
>>  } __packed;
>>
>> @@ -173,6 +183,19 @@ enum fan_type {
>>      FAN_TYPE_SPEC83,    /* starting in Spec 8.3, use CPU_FAN_CTRL */
>>  };
>>
>> +/*
>> + * The related ACPI method for testing availability also returns the factory
>> + * default fan curves. We save them here so that a user can reset custom
>> + * settings if required.
>> + */
>> +struct fan_curve_data {
>> +    bool enabled;
>> +    u8 temps[FAN_CURVE_POINTS];
>> +    u8 percents[FAN_CURVE_POINTS];
>> +    u8 default_temps[FAN_CURVE_POINTS];
>> +    u8 default_percents[FAN_CURVE_POINTS];
>> +};
>> +
>>  struct asus_wmi {
>>      int dsts_id;
>>      int spec;
>> @@ -220,6 +243,10 @@ struct asus_wmi {
>>      bool throttle_thermal_policy_available;
>>      u8 throttle_thermal_policy_mode;
>>
>> +    bool cpu_fan_curve_available;
>> +    bool gpu_fan_curve_available;
>> +    struct fan_curve_data custom_fan_curves[2];
>> +
>>      struct platform_profile_handler platform_profile_handler;
>>      bool platform_profile_support;
>>
>> @@ -285,6 +312,103 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
>>  }
>>  EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
>>
>> +static int asus_wmi_evaluate_method5(u32 method_id,
>> +        u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 *retval)
>> +{
>> +    struct bios_args args = {
>> +        .arg0 = arg0,
>> +        .arg1 = arg1,
>> +        .arg2 = arg2,
>> +        .arg3 = arg3,
>> +        .arg4 = arg4,
>> +    };
>> +    struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
>> +    struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
>> +    acpi_status status;
>> +    union acpi_object *obj;
>> +    u32 tmp = 0;
>> +
>> +    status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
>> +                     &input, &output);
>> +
>> +    if (ACPI_FAILURE(status))
>> +        return -EIO;
>> +
>> +    obj = (union acpi_object *)output.pointer;
>> +    if (obj && obj->type == ACPI_TYPE_INTEGER)
>> +        tmp = (u32) obj->integer.value;
>> +
>> +    if (retval)
>> +        *retval = tmp;
>> +
>> +    kfree(obj);
>> +
>> +    if (tmp == ASUS_WMI_UNSUPPORTED_METHOD)
>> +        return -ENODEV;
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Returns as an error if the method output is not a buffer. Typically this
>> + * means that the method called is unsupported.
>> + */
>> +static int asus_wmi_evaluate_method_buf(u32 method_id,
>> +        u32 arg0, u32 arg1, u8 *ret_buffer, size_t size)
>> +{
>> +    struct bios_args args = {
>> +        .arg0 = arg0,
>> +        .arg1 = arg1,
>> +        .arg2 = 0,
>> +    };
>> +    struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
>> +    struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
>> +    acpi_status status;
>> +    union acpi_object *obj;
>> +    int err = 0;
>> +
>> +    status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
>> +                     &input, &output);
>> +
>> +    if (ACPI_FAILURE(status))
>> +        return -EIO;
>> +
>> +    obj = (union acpi_object *)output.pointer;
>> +
>> +    switch (obj->type) {
>> +    case ACPI_TYPE_BUFFER:
>> +        if (obj->buffer.length > size)
>> +            err = -ENOSPC;
>> +        if (obj->buffer.length == 0)
>> +            err = -ENODATA;
>> +
>> +        memcpy(ret_buffer, obj->buffer.pointer, obj->buffer.length);
>> +        break;
>> +    case ACPI_TYPE_INTEGER:
>> +        err = (u32)obj->integer.value;
>> +
>> +        if (err == ASUS_WMI_UNSUPPORTED_METHOD)
>> +            err = -ENODEV;
>> +        /*
>> +         * At least one method returns a 0 with no buffer if no arg
>> +         * is provided, such as ASUS_WMI_DEVID_CPU_FAN_CURVE
>> +         */
>> +        if (err == 0)
>> +            err = -ENODATA;
>> +        break;
>> +    default:
>> +        err = -ENODATA;
>> +        break;
>> +    }
>> +
>> +    kfree(obj);
>> +
>> +    if (err)
>> +        return err;
>> +
>> +    return 0;
>> +}
>> +
>>  static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer args)
>>  {
>>      struct acpi_buffer input;
>> @@ -1806,6 +1930,13 @@ static ssize_t pwm1_enable_store(struct device *dev,
>>      }
>>
>>      asus->fan_pwm_mode = state;
>> +
>> +    /* Must set to disabled if mode is toggled */
>> +    if (asus->cpu_fan_curve_available)
>> +        asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled = false;
>> +    if (asus->gpu_fan_curve_available)
>> +        asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled = false;
>> +
>>      return count;
>>  }
>>
>> @@ -1953,9 +2084,9 @@ static int fan_boost_mode_check_present(struct asus_wmi *asus)
>>
>>  static int fan_boost_mode_write(struct asus_wmi *asus)
>>  {
>> -    int err;
>> -    u8 value;
>>      u32 retval;
>> +    u8 value;
>> +    int err;
>>
>>      value = asus->fan_boost_mode;
>>
>> @@ -2013,10 +2144,10 @@ static ssize_t fan_boost_mode_store(struct device *dev,
>>                      struct device_attribute *attr,
>>                      const char *buf, size_t count)
>>  {
>> -    int result;
>> -    u8 new_mode;
>>      struct asus_wmi *asus = dev_get_drvdata(dev);
>>      u8 mask = asus->fan_boost_mode_mask;
>> +    u8 new_mode;
>> +    int result;
>>
>>      result = kstrtou8(buf, 10, &new_mode);
>>      if (result < 0) {
>> @@ -2043,6 +2174,454 @@ static ssize_t fan_boost_mode_store(struct device *dev,
>>  // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
>>  static DEVICE_ATTR_RW(fan_boost_mode);
>>
>> +/* Custom fan curves per-profile **********************************************/
>> +
>> +static void fan_curve_copy_from_buf(struct fan_curve_data *data, u8 *buf)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < FAN_CURVE_POINTS; i++) {
>> +        data->temps[i] = buf[i];
>> +        data->default_temps[i] = buf[i];
>> +    }
>> +
>> +    for (i = 0; i < FAN_CURVE_POINTS; i++) {
>> +        data->percents[i] =
>> +            255 * buf[i + FAN_CURVE_POINTS] / 100;
>> +        data->default_percents[i] =
>> +            255 * buf[i + FAN_CURVE_POINTS] / 100;
>> +    }
>> +}
>> +
>> +static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
>> +{
>> +    struct fan_curve_data *curves;
>> +    u8 buf[FAN_CURVE_BUF_LEN];
>> +    int fan_idx = 0;
>> +    u8 mode = 0;
>> +    int err;
>> +
>> +    if (asus->throttle_thermal_policy_available)
>> +        mode = asus->throttle_thermal_policy_mode;
>> +    /* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
>> +    if (mode == 2)
>> +        mode = 1;
>> +    if (mode == 1)
>> +        mode = 2;
>> +
>> +    if (fan_dev == ASUS_WMI_DEVID_GPU_FAN_CURVE)
>> +        fan_idx = FAN_CURVE_DEV_GPU;
>> +
>> +    curves = &asus->custom_fan_curves[fan_idx];
>> +    err = asus_wmi_evaluate_method_buf(asus->dsts_id, fan_dev, mode, buf,
>> +                       FAN_CURVE_BUF_LEN);
>> +    if (err)
>> +        return err;
>> +
>> +    fan_curve_copy_from_buf(curves, buf);
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Check if capability exists, and populate defaults.
>> + */
>> +static int fan_curve_check_present(struct asus_wmi *asus, bool *available,
>> +                   u32 fan_dev)
>> +{
>> +    int err;
>> +
>> +    *available = false;
>> +
>> +    err = fan_curve_get_factory_default(asus, fan_dev);
>> +    if (err) {
>> +        if (err == -ENODEV)
>> +            return 0;
>> +        return err;
>> +    }
>> +
>> +    *available = true;
>> +    return 0;
>> +}
>> +
>> +static struct fan_curve_data *fan_curve_data_select(struct asus_wmi *asus,
>> +                        struct device_attribute *attr)
>> +{
>> +    /* Determine which fan the attribute is for */
>> +    int nr = to_sensor_dev_attr_2(attr)->nr;
>> +    int fan = nr & FAN_CURVE_DEV_GPU;
>> +
>> +    return &asus->custom_fan_curves[fan];
>> +}
>> +
>> +static ssize_t fan_curve_show(struct device *dev,
>> +                  struct device_attribute *attr, char *buf)
>> +{
>> +    struct asus_wmi *asus = dev_get_drvdata(dev);
>> +    /* Determine if temperature or pwm */
>> +    int nr = to_sensor_dev_attr_2(attr)->nr;
>> +    struct fan_curve_data *data;
>> +    int value, index;
>> +
>> +    data = fan_curve_data_select(asus, attr);
>> +    index = to_sensor_dev_attr_2(attr)->index;
>> +
>> +    if (nr & FAN_CURVE_PWM_MASK)
>> +        value = data->percents[index];
>> +    else
>> +        value = data->temps[index];
>> +
>> +    return sysfs_emit(buf, "%d\n", value);
>> +}
>> +
>> +/*
>> + * "fan_dev" is the related WMI method such as ASUS_WMI_DEVID_CPU_FAN_CURVE.
>> + */
>> +static int fan_curve_write(struct asus_wmi *asus,
>> +               struct device_attribute *attr, u32 fan_dev)
>> +{
>> +    struct fan_curve_data *data = fan_curve_data_select(asus, attr);
>> +    u32 arg1 = 0, arg2 = 0, arg3 = 0, arg4 = 0;
>> +    u8 *percents = data->percents;
>> +    u8 *temps = data->temps;
>> +    int ret, i, shift = 0;
>> +
>> +    for (i = 0; i < FAN_CURVE_POINTS / 2; i++) {
>> +        arg1 += (temps[i]) << shift;
>> +        arg2 += (temps[i + 4]) << shift;
>> +        /* Scale to percentage for device */
>> +        arg3 += (100 * percents[i] / 255) << shift;
>> +        arg4 += (100 * percents[i + 4] / 255) << shift;
>> +        shift += 8;
>> +    }
>> +
>> +    return asus_wmi_evaluate_method5(ASUS_WMI_METHODID_DEVS, fan_dev, arg1,
>> +                     arg2, arg3, arg4, &ret);
>> +}
>> +
>> +/*
>> + * Called on curve enable/disable. This should be the only way to write out the
>> + * fan curves. This avoids potential lockups on write to ACPI for every change.
>> + */
>> +static int fan_curve_write_data(struct asus_wmi *asus,
>> +                struct device_attribute *attr)
>> +{
>> +    int err;
>> +
>> +    if (asus->cpu_fan_curve_available) {
>> +        err = fan_curve_write(asus, attr, ASUS_WMI_DEVID_CPU_FAN_CURVE);
>> +        if (err)
>> +            return err;
>> +    }
>> +
>> +    if (asus->gpu_fan_curve_available) {
>> +        err = fan_curve_write(asus, attr, ASUS_WMI_DEVID_GPU_FAN_CURVE);
>> +        if (err)
>> +            return err;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static ssize_t fan_curve_store(struct device *dev,
>> +                   struct device_attribute *attr, const char *buf,
>> +                   size_t count)
>> +{
>> +    struct asus_wmi *asus = dev_get_drvdata(dev);
>> +    struct fan_curve_data *data;
>> +    u8 value;
>> +    int err;
>> +
>> +    int index = to_sensor_dev_attr_2(attr)->index;
>> +    int nr = to_sensor_dev_attr_2(attr)->nr;
>> +    int pwm = nr & FAN_CURVE_PWM_MASK;
>> +
>> +    data = fan_curve_data_select(asus, attr);
>> +
>> +    err = kstrtou8(buf, 10, &value);
>> +    if (err < 0)
>> +        return err;
>> +
>> +    if (pwm) {
>> +        data->percents[index] = value;
>> +    } else {
>> +        data->temps[index] = value;
>> +    }
>> +
>> +    /*
>> +     * Mark as disabled so the user has to explicitly enable to apply a
>> +     * changed fan curve. This prevents potential lockups from writing out
>> +     * many changes as one-write-per-change.
>> +     */
>> +    data->enabled = false;
>> +
>> +    return count;
>> +}
>> +
>> +static ssize_t fan_curve_enable_show(struct device *dev,
>> +                     struct device_attribute *attr, char *buf)
>> +{
>> +    struct asus_wmi *asus = dev_get_drvdata(dev);
>> +    struct fan_curve_data *data = fan_curve_data_select(asus, attr);
>> +
>> +    return sysfs_emit(buf, "%d\n", data->enabled);
>> +}
>> +
>> +static int fan_curve_set_default(struct asus_wmi *asus)
>> +{
>> +    int err;
>> +
>> +    err = fan_curve_get_factory_default(
>> +        asus, ASUS_WMI_DEVID_CPU_FAN_CURVE);
>> +    if (err)
>> +        return err;
>> +
>> +    err = fan_curve_get_factory_default(
>> +        asus, ASUS_WMI_DEVID_GPU_FAN_CURVE);
>> +    if (err)
>> +        return err;
>> +    return 0;
>> +}
>> +
>> +static ssize_t fan_curve_enable_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf, size_t count)
>> +{
>> +    struct asus_wmi *asus = dev_get_drvdata(dev);
>> +    struct fan_curve_data *data;
>> +    int value;
>> +    int err;
>> +
>> +    data = fan_curve_data_select(asus, attr);
>> +
>> +    err = kstrtoint(buf, 10, &value);
>> +    if (err < 0)
>> +        return err;
>> +
>> +    switch (value) {
>> +    case 1:
>> +        data->enabled = true;
>> +        break;
>> +    case 2:
>> +        data->enabled = false;
>> +        break;
>> +    /*
>> +     * Auto + reset the fan curve data to defaults. Make it an explicit
>> +     * option so that users don't accidentally overwrite a set fan curve.
>> +     */
>> +    case 3:
>> +        err = fan_curve_set_default(asus);
>> +        if (err)
>> +            return err;
>> +        data->enabled = false;
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    };
>> +
>> +    /*
>> +     * For machines with throttle this is the only way to reset fans to
>> +     * default mode of operation (does not erase curve data).
>> +     */
>> +    if (asus->throttle_thermal_policy_available && !data->enabled) {
>> +        err = throttle_thermal_policy_write(asus);
>> +        if (err)
>> +            return err;
>> +    }
>> +    /* Similar is true for laptops with this fan */
>> +    if (asus->fan_type == FAN_TYPE_SPEC83) {
>> +        err = asus_fan_set_auto(asus);
>> +        if (err)
>> +            return err;
>> +    }
>> +    /*
>> +     * Machines without either need to write their defaults back always.
>> +     * This is more of a safeguard against ASUS faulty ACPI tables.
>> +     */
>> +    if (!asus->throttle_thermal_policy_available
>> +        && asus->fan_type != FAN_TYPE_SPEC83 && !data->enabled) {
>> +        err = fan_curve_set_default(asus);
>> +        if (err)
>> +            return err;
>> +        err = fan_curve_write_data(asus, attr);
>> +        if (err)
>> +            return err;
>> +    }
>> +
>> +    if (data->enabled) {
>> +        err = fan_curve_write_data(asus, attr);
>> +        if (err)
>> +            return err;
>> +    }
>> +
>> +    return count;
>> +}
>> +
>> +/* CPU */
>> +static SENSOR_DEVICE_ATTR_RW(pwm1_enable, fan_curve_enable, FAN_CURVE_DEV_CPU);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point1_temp, fan_curve,
>> +                   FAN_CURVE_DEV_CPU, 0);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point2_temp, fan_curve,
>> +                   FAN_CURVE_DEV_CPU, 1);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point3_temp, fan_curve,
>> +                   FAN_CURVE_DEV_CPU, 2);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point4_temp, fan_curve,
>> +                   FAN_CURVE_DEV_CPU, 3);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point5_temp, fan_curve,
>> +                   FAN_CURVE_DEV_CPU, 4);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point6_temp, fan_curve,
>> +                   FAN_CURVE_DEV_CPU, 5);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point7_temp, fan_curve,
>> +                   FAN_CURVE_DEV_CPU, 6);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point8_temp, fan_curve,
>> +                   FAN_CURVE_DEV_CPU, 7);
>> +
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point1_pwm, fan_curve,
>> +                   FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 0);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point2_pwm, fan_curve,
>> +                   FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 1);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point3_pwm, fan_curve,
>> +                   FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 2);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point4_pwm, fan_curve,
>> +                   FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 3);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point5_pwm, fan_curve,
>> +                   FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 4);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point6_pwm, fan_curve,
>> +                   FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 5);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point7_pwm, fan_curve,
>> +                   FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 6);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point8_pwm, fan_curve,
>> +                   FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 7);
>> +
>> +/* GPU */
>> +static SENSOR_DEVICE_ATTR_RW(pwm2_enable, fan_curve_enable, FAN_CURVE_DEV_GPU);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point1_temp, fan_curve,
>> +                   FAN_CURVE_DEV_GPU, 0);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point2_temp, fan_curve,
>> +                   FAN_CURVE_DEV_GPU, 1);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point3_temp, fan_curve,
>> +                   FAN_CURVE_DEV_GPU, 2);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point4_temp, fan_curve,
>> +                   FAN_CURVE_DEV_GPU, 3);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point5_temp, fan_curve,
>> +                   FAN_CURVE_DEV_GPU, 4);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point6_temp, fan_curve,
>> +                   FAN_CURVE_DEV_GPU, 5);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point7_temp, fan_curve,
>> +                   FAN_CURVE_DEV_GPU, 6);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point8_temp, fan_curve,
>> +                   FAN_CURVE_DEV_GPU, 7);
>> +
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point1_pwm, fan_curve,
>> +                   FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 0);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point2_pwm, fan_curve,
>> +                   FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 1);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point3_pwm, fan_curve,
>> +                   FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 2);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point4_pwm, fan_curve,
>> +                   FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 3);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point5_pwm, fan_curve,
>> +                   FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 4);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point6_pwm, fan_curve,
>> +                   FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 5);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point7_pwm, fan_curve,
>> +                   FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 6);
>> +static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point8_pwm, fan_curve,
>> +                   FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 7);
>> +
>> +static struct attribute *asus_fan_curve_attr[] = {
>> +    /* CPU */
>> +    &sensor_dev_attr_pwm1_enable.dev_attr.attr,
>> +    &sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
>> +    &sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
>> +    &sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
>> +    &sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
>> +    &sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr,
>> +    &sensor_dev_attr_pwm1_auto_point6_temp.dev_attr.attr,
>> +    &sensor_dev_attr_pwm1_auto_point7_temp.dev_attr.attr,
>> +    &sensor_dev_attr_pwm1_auto_point8_temp.dev_attr.attr,
>> +    &sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
>> +    &sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
>> +    &sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr,
>> +    &sensor_dev_attr_pwm1_auto_point4_pwm.dev_attr.attr,
>> +    &sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr,
>> +    &sensor_dev_attr_pwm1_auto_point6_pwm.dev_attr.attr,
>> +    &sensor_dev_attr_pwm1_auto_point7_pwm.dev_attr.attr,
>> +    &sensor_dev_attr_pwm1_auto_point8_pwm.dev_attr.attr,
>> +    /* GPU */
>> +    &sensor_dev_attr_pwm2_enable.dev_attr.attr,
>> +    &sensor_dev_attr_pwm2_auto_point1_temp.dev_attr.attr,
>> +    &sensor_dev_attr_pwm2_auto_point2_temp.dev_attr.attr,
>> +    &sensor_dev_attr_pwm2_auto_point3_temp.dev_attr.attr,
>> +    &sensor_dev_attr_pwm2_auto_point4_temp.dev_attr.attr,
>> +    &sensor_dev_attr_pwm2_auto_point5_temp.dev_attr.attr,
>> +    &sensor_dev_attr_pwm2_auto_point6_temp.dev_attr.attr,
>> +    &sensor_dev_attr_pwm2_auto_point7_temp.dev_attr.attr,
>> +    &sensor_dev_attr_pwm2_auto_point8_temp.dev_attr.attr,
>> +    &sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
>> +    &sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
>> +    &sensor_dev_attr_pwm2_auto_point3_pwm.dev_attr.attr,
>> +    &sensor_dev_attr_pwm2_auto_point4_pwm.dev_attr.attr,
>> +    &sensor_dev_attr_pwm2_auto_point5_pwm.dev_attr.attr,
>> +    &sensor_dev_attr_pwm2_auto_point6_pwm.dev_attr.attr,
>> +    &sensor_dev_attr_pwm2_auto_point7_pwm.dev_attr.attr,
>> +    &sensor_dev_attr_pwm2_auto_point8_pwm.dev_attr.attr,
>> +    NULL
>> +};
>> +
>> +static umode_t asus_fan_curve_is_visible(struct kobject *kobj,
>> +                     struct attribute *attr, int idx)
>> +{
>> +    struct device *dev = container_of(kobj, struct device, kobj);
>> +    struct asus_wmi *asus = dev_get_drvdata(dev->parent);
>> +
>> +    if (asus->cpu_fan_curve_available)
>> +        return 0644;
>> +
>> +    if (asus->gpu_fan_curve_available)
>> +        return 0644;
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct attribute_group asus_fan_curve_attr_group = {
>> +    .is_visible = asus_fan_curve_is_visible,
>> +    .attrs = asus_fan_curve_attr,
>> +};
>> +__ATTRIBUTE_GROUPS(asus_fan_curve_attr);
>> +
>> +/*
>> + * Must be initialised after throttle_thermal_policy_check_present() as
>> + * we check the status of throttle_thermal_policy_available during init.
>> + */
>> +static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
>> +{
>> +    struct device *dev = &asus->platform_device->dev;
>> +    struct device *hwmon;
>> +    int err;
>> +
>> +    err = fan_curve_check_present(asus, &asus->cpu_fan_curve_available,
>> +                      ASUS_WMI_DEVID_CPU_FAN_CURVE);
>> +    if (err)
>> +        return err;
>> +
>> +    err = fan_curve_check_present(asus, &asus->gpu_fan_curve_available,
>> +                      ASUS_WMI_DEVID_GPU_FAN_CURVE);
>> +    if (err)
>> +        return err;
>> +
>> +    hwmon = devm_hwmon_device_register_with_groups(
>> +        dev, "asus_custom_fan_curve", asus, asus_fan_curve_attr_groups);
>> +
>> +    if (IS_ERR(hwmon)) {
>> +        dev_err(dev,
>> +            "Could not register asus_custom_fan_curve device\n");
>> +        return PTR_ERR(hwmon);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>  /* Throttle thermal policy ****************************************************/
>>
>>  static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
>> @@ -2053,8 +2632,8 @@ static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
>>      asus->throttle_thermal_policy_available = false;
>>
>>      err = asus_wmi_get_devstate(asus,
>> -                    ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
>> -                    &result);
>> +        ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
>> +        &result);
>>      if (err) {
>>          if (err == -ENODEV)
>>              return 0;
>> @@ -2092,6 +2671,12 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
>>          return -EIO;
>>      }
>>
>> +    /* Must set to disabled if mode is toggled */
>> +    if (asus->cpu_fan_curve_available)
>> +        asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled = false;
>> +    if (asus->gpu_fan_curve_available)
>> +        asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled = false;
>> +
>>      return 0;
>>  }
>>
>> @@ -2901,7 +3486,7 @@ static int show_call(struct seq_file *m, void *data)
>>      if (ACPI_FAILURE(status))
>>          return -EIO;
>>
>> -    obj = (union acpi_object *)output.pointer;
>> +    obj = output.pointer;
>>      if (obj && obj->type == ACPI_TYPE_INTEGER)
>>          seq_printf(m, "%#x(%#x, %#x) = %#x\n", asus->debug.method_id,
>>                 asus->debug.dev_id, asus->debug.ctrl_param,
>> @@ -3035,6 +3620,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>>      if (err)
>>          goto fail_hwmon;
>>
>> +    err = asus_wmi_custom_fan_curve_init(asus);
>> +    if (err)
>> +        goto fail_custom_fan_curve;
>> +
>>      err = asus_wmi_led_init(asus);
>>      if (err)
>>          goto fail_leds;
>> @@ -3106,6 +3695,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>>      asus_wmi_sysfs_exit(asus->platform_device);
>>  fail_sysfs:
>>  fail_throttle_thermal_policy:
>> +fail_custom_fan_curve:
>>  fail_platform_profile_setup:
>>      if (asus->platform_profile_support)
>>          platform_profile_remove();
>> @@ -3131,6 +3721,7 @@ static int asus_wmi_remove(struct platform_device *device)
>>      asus_wmi_debugfs_exit(asus);
>>      asus_wmi_sysfs_exit(asus->platform_device);
>>      asus_fan_set_auto(asus);
>> +    throttle_thermal_policy_set_default(asus);
>>      asus_wmi_battery_exit(asus);
>>
>>      if (asus->platform_profile_support)
>> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
>> index 17dc5cb6f3f2..a571b47ff362 100644
>> --- a/include/linux/platform_data/x86/asus-wmi.h
>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>> @@ -77,6 +77,8 @@
>>  #define ASUS_WMI_DEVID_THERMAL_CTRL    0x00110011
>>  #define ASUS_WMI_DEVID_FAN_CTRL        0x00110012 /* deprecated */
>>  #define ASUS_WMI_DEVID_CPU_FAN_CTRL    0x00110013
>> +#define ASUS_WMI_DEVID_CPU_FAN_CURVE    0x00110024
>> +#define ASUS_WMI_DEVID_GPU_FAN_CURVE    0x00110025
>>
>>  /* Power */
>>  #define ASUS_WMI_DEVID_PROCESSOR_STATE    0x00120012
>> -- 
>> 2.32.0
>>
> 
> 

