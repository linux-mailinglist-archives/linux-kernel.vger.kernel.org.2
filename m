Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A123FF091
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346010AbhIBP42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345966AbhIBP40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630598127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xLvcoxd5ha6N3/QBxzwSOO2ULcQibBEn2kLEl9lpTOY=;
        b=X686lWMT5u6ZwNdeuCkaH45vIEWK5AdxdMjU0/+BkZEcEMfms+cZV5ZH2uZ2i02lXLL9dU
        bzEDdRsa0EBnXgZ+/cqc+gmHL6WQu1XZgcQNQjIbptvsr76MbRI7M0+vb791MsNI5o7/J0
        AxQlQU3zOAbhz2r+bJn2/KCFUeLDzzg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-kipGaicgP_Wy7pHHW7KOEA-1; Thu, 02 Sep 2021 11:55:26 -0400
X-MC-Unique: kipGaicgP_Wy7pHHW7KOEA-1
Received: by mail-ed1-f72.google.com with SMTP id i17-20020aa7c711000000b003c57b06a2caso1159978edq.20
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 08:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xLvcoxd5ha6N3/QBxzwSOO2ULcQibBEn2kLEl9lpTOY=;
        b=Yo3gIz5xnpsZcgJxt0GYONLT6Ip5VDqgvaoqlG13/lYTkBds2XAWXocfUXBlFg+a70
         xWHI9lSO2vBjrKVW1qHYL9zA97u6ekxQvQSQlcGb/ilAUsZwLpHSxq2bMVzpWNRnh6Xe
         mnm9sLy8fwJy4ltdOFGoacH1/+AeIS7yxDv9IxpVuDlcH5OGaVC0IXsLdyiU2U63fQXk
         lRmrQ1ufdjDEZY7hh8lA1EguChqywzv2l9vtZQUZWeFjXj5stLL3kXfgNXvlyH9XOk1I
         FWY//4PSE+9fCNRDBbTCuIHsx3WnoJuFISi2dr+1zoYjscJd7bMQo4rDniBwmJkjuazo
         NP5g==
X-Gm-Message-State: AOAM532ZfIhrTdEsvdIiEBCSTdUOsq50cRBIIZ5vzW+o8wyOqidiqAnV
        iURxJKpAca0eexMqsWvJWezBVYbcdKvKYwkhfXQ/dDjlUpw7vRvZ8oXh88mfyKRtxSWFJFlIZdi
        p0I8SVnGsGtuvSKa0zV7wrz8j
X-Received: by 2002:aa7:c1ca:: with SMTP id d10mr4172482edp.294.1630598124728;
        Thu, 02 Sep 2021 08:55:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNaD4vQ6dvWrwz8alpQZfwAOYU+m/XfhAsQ6tXxZ3FoZMh/XCrIMskxqVfClv8T1jpt1ugZw==
X-Received: by 2002:aa7:c1ca:: with SMTP id d10mr4172465edp.294.1630598124484;
        Thu, 02 Sep 2021 08:55:24 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id k15sm1326083ejb.92.2021.09.02.08.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 08:55:24 -0700 (PDT)
Subject: Re: [PATCH v7] asus-wmi: Add support for custom fan curves
To:     Luke Jones <luke@ljones.dev>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>
References: <20210830113137.1338683-1-luke@ljones.dev>
 <20210830113137.1338683-2-luke@ljones.dev>
 <1o94oJFiia_xvrFrSPI_zG1Xfv4FAlJNY96x39rg-zX3-3N5Czw4KmTiJtzCy1So7kYXLu0FTkRkmwUUudeuTyLHSsx5sJGhfsZaYrXKEic=@protonmail.com>
 <BLFOYQ.DC67MOSNFFNW2@ljones.dev>
 <Z3uTWHyeRPzaHU0iSW56m1ltGsYr5DOfRoJLyGlfnObU0ph-mVf9M6KCbSV66AeY_voEARTrP6bOtqXS1ZubuSj4Cu25VSRu0VMBIf3whow=@protonmail.com>
 <CUZRYQ.HUS5YU6QXUBU@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <742205fb-b712-995a-6e67-15b7f8f0fd2f@redhat.com>
Date:   Thu, 2 Sep 2021 17:55:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CUZRYQ.HUS5YU6QXUBU@ljones.dev>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/2/21 12:01 AM, Luke Jones wrote:
> 
> 
> On Wed, Sep 1 2021 at 15:24:40 +0000, Barnabás Põcze <pobrn@protonmail.com> wrote:
>> Hi
>>
>>
>>>  [...]
>>>  >>  --- a/drivers/platform/x86/asus-wmi.c
>>>  >>  +++ b/drivers/platform/x86/asus-wmi.c
>>>  >>  [...]
>>>  >>  +/*
>>>  >>  + * Returns as an error if the method output is not a buffer.
>>>  >> Typically this
>>>  >
>>>  > It seems to me it will simply leave the output buffer uninitialized
>>>  > if something
>>>  > other than ACPI_TYPE_BUFFER and ACPI_TYPE_INTEGER is encountered and
>>>  > return 0.
>>>
>>>  Oops, see below inline reply:
>>>
>>>  >
>>>  >
>>>  >>  + * means that the method called is unsupported.
>>>  >>  + */
>>>  >>  +static int asus_wmi_evaluate_method_buf(u32 method_id,
>>>  >>  +        u32 arg0, u32 arg1, u8 *ret_buffer)
>>>  >>  +{
>>>  >>  +    struct bios_args args = {
>>>  >>  +        .arg0 = arg0,
>>>  >>  +        .arg1 = arg1,
>>>  >>  +        .arg2 = 0,
>>>  >>  +    };
>>>  >>  +    struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
>>>  >>  +    struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
>>>  >>  +    acpi_status status;
>>>  >>  +    union acpi_object *obj;
>>>  >>  +    u32 int_tmp = 0;
>>>  >>  +
>>>  >>  +    status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
>>>  >>  +                     &input, &output);
>>>  >>  +
>>>  >>  +    if (ACPI_FAILURE(status))
>>>  >>  +        return -EIO;
>>>  >>  +
>>>  >>  +    obj = (union acpi_object *)output.pointer;
>>>  >>  +
>>>  >>  +    if (obj && obj->type == ACPI_TYPE_INTEGER) {
>>>  >>  +        int_tmp = (u32) obj->integer.value;
>>>  >>  +        if (int_tmp == ASUS_WMI_UNSUPPORTED_METHOD)
>>>  >>  +            return -ENODEV;
>>>  >>  +        return int_tmp;
>>>  >
>>>  > Is anything known about the possible values? You are later
>>>  > using it as if it was an errno (e.g. in `custom_fan_check_present()`).
>>>  >
>>>  > And `obj` is leaked in both of the previous two returns.
>>>
>>>  The return for the method we're calling in this patch returns 0 if the
>>>  input arg has no match.
>>>
>>>  >
>>>  >
>>>  >>  +    }
>>>  >>  +
>>>  >>  +    if (obj && obj->type == ACPI_TYPE_BUFFER)
>>>  >>  +        memcpy(ret_buffer, obj->buffer.pointer, obj->buffer.length);
>>>  >
>>>  > I would suggest you add a "size_t size" argument to this function, and
>>>  > return -ENOSPC/-ENODATA depending on whether the returned buffer is
>>>  > too
>>>  > big/small. Maybe return -ENODATA if `obj` is NULL, too.
>>>
>>>  Got it. So something like this would be suitable?
>>>
>>>      if (obj && obj->type == ACPI_TYPE_BUFFER)
>>>          if (obj->buffer.length < size)
>>>              err = -ENOSPC;
>>>          if (!obj->buffer.length)
>>>              err = -ENODATA;
>>>          if (err) {
>>>              kfree(obj);
>>>              return err;
>>>          }
>>>          memcpy(ret_buffer, obj->buffer.pointer, obj->buffer.length);
>>>      }
>>>
>>>      if (obj && obj->type == ACPI_TYPE_INTEGER)
>>>          int_tmp = (u32) obj->integer.value;
>>>
>>>      kfree(obj);
>>>
>>>      if (int_tmp == ASUS_WMI_UNSUPPORTED_METHOD)
>>>          return -ENODEV;
>>>
>>>      /* There is at least one method that returns a 0 with no buffer */
>>>      if (obj == NULL || int_tmp == 0)
>>>          return -ENODATA;
>>>
>>>      return 0;
>>>
>>
>> I had something like the following in mind:
>>
>>   int err = 0;
>>   /* ... */
>>   obj = output.pointer;
>>   if (!obj)
>>     return -ENODATA;
>>
>>   switch (obj->type) {
>>   case ACPI_TYPE_BUFFER:
>>     if (obj->buffer.length < size)
>>       err = -ENODATA;
>>     else if (obj->buffer.length > size)
>>       err = -ENOSPC;
>>     else
>>       memcpy(ret_buffer, obj->buffer.pointer, size);
>>     break;
>>   case ACPI_TYPE_INTEGER:
>>     switch (obj->integer.value) {
>>       case ASUS_WMI_UNSUPPORTED_METHOD:
>>         err = -EOPNOTSUPP;
>>     break;
>>       default:
>>         err = -ENODATA;
>>     break;
>>     }
>>     break;
>>   default:
>>     err = -ENODATA;
>>     break;
>>   }
>>
>>   kfree(obj);
>>
>>   return err;
>>
> 
> Got it. Sometimes I forget switch/case exists. I'll adjust the v8 patch I sent out earlier.
> 
>>
>>>  >
>>>  >
>>>  >>  +
>>>  >>  +    kfree(obj);
>>>  >>  +
>>>  >>  +    return 0;
>>>  >>  +}
>>>  [...]
>>>  >>  +/*
>>>  >>  + * Called only by throttle_thermal_policy_write()
>>>  >>  + */
>>>  >
>>>  > Am I correct in thinking that the firmware does not actually
>>>  > support specifying fan curves for each mode, only a single one,
>>>  > and the fan curve switching is done by this driver when
>>>  > the performance mode is changed?
>>>
>>>  I'm not 100% certain on this. The WMI method 0x00110024 takes an arg
>>>  0,1,2 which then returns some factory stored fan profiles, these fit
>>>  the profiles of ASUS_THROTTLE_THERMAL_POLICY_*, but with 1 and 2
>>>  swapped.
>>>
>>>  Looking at the SET part, it seems to write to a different location than
>>>  where the GET is fetching information.
>>>
>>
>> The, unfortunately, that is not as simple as I initially thought...
> 
> We can add the fact that a variation exists with a more typical setup also. The G713Q has no throttle_thermal and in the dsdt dump looks like it possible can read back the curve that is set by the user. This works in our favour though.
> 
>>
>>
>>>  Because of the fact there are three sets of curves to get, I thought it
>>>  would be good for users to be able to set per profile. I don't think
>>>  the set is retained in acpi if the profile is switched.
>>>
>>>  Do you think it would be best to not have the ability to store per
>>>  profile in kernel?
>>
>> If there was a method to set a fan curve, and one to retrieve it,
>> I would suggest just exposing that via the pwmN_auto_pointM_{pwm,temp}
>> attributes on a hwmon device, and that the profile-dependent switching
>> be implemented somewhere else. As far as I see, there is already
>> existing infrastructure for integrating such a feature [0]
>> (but please correct me if I'm wrong).
> 
> There is. I develop asusctl in conjunction with these patches. I'd certainly like to find the best way to fit all of this together.
> 
>>
>> This would simplify the kernel code, add no new ABI, and
>> potentially provide greater control over policy for the
>> user space.
> 
> I agree.
> 
>>
>>
>>>  How would I choose which profile get to populate the
>>>  initial data with if so?
>>
>> I assume there isn't a method that can query
>> the current fan curve (or it is unknown)?
> 
> It looks like I need to adjust how pwm[n]_enable works anyway:
> 
> `pwm[1-*]_enable`
> Fan speed control method:
> - 0: no fan speed control (i.e. fan at full speed)
> - 1: manual fan speed control enabled (using `pwm[1-*]`)
> - 2+: automatic fan speed control enabled

Notice the 2+ here, AFAIK the API allows defining extra
settings / custom profiles when the value is higher then 2.

So you could do:

2: automatic fan speed control with factory default profiles
   (with all the pwm1_auto_point#... attributes ro perhaps ?)
3: automatic fan speed control with custom profile

Note you could swap 2 and 3 here, not sure which order makes
the most sense.

Guenter, what do you think about the above?

This will also nicely give power-profiles-daemon a nice way
to check if a custom profile is being used, which Bastien
requested to have.

Regards,

Hans







> 
> So maybe on "manual" I can make it so the get method does what is in fan_curve_check_present() (and change that part also) and fetches the "defaults" on enable. This might even give us the fan curve that was set (and looks like it will on the machine that has no thermal throttle profile, v8 patch) - I'll try this anyway and see what it looks like. This seems to be the best approach given how the G713Q works anyway.
> 
> The issue I have with the above is that it overwrites any curve set. But given that it'll most likely be managed in userspace that's maybe *not* an issue. Otherwise would it be sensible to add something like `pwm1_reset`? I don't see anything like that in the related docs though. `pwm1_reset` would be to re-read the defaults from the acpi method.
> 
> Central to the above is that we can still read 0, 1, 2 curves from acpi - I was thinking to use the throttle_thermal mode to choose which one and that would be the only use of it. And won't store them as per-profile, which becomes a moot point when userspace is managing it anyway.
> 
> Many thanks,
> Luke.
> 
> 
>>
>>
>>>  [...]
>>
>> [0]: https://gitlab.com/asus-linux/asusctl
>>
>>
>> Best regards,
>> Barnabás Põcze
> 
> 

