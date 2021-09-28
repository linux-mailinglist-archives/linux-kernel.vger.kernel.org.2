Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED17F41B1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241137AbhI1ONf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241103AbhI1ONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632838313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVoo+M6uUaOiYZtopIoxfUEyXOYNBvxexaFRMYrLxg8=;
        b=RCq7u7YClTAixlyC200RUq3D+Klh5eXdadH403o8TFUDQzHbyDor7+r4WeZzO29aLRKZP4
        26n+KsULmJxB5hCPP0BaY5RSHBgtZCXJGXPwtjWHgZFJo6SErY6QVXVUz7MlFmQ9U3zCwI
        YR1D5BIvmv8Gyr9gfo6WBl7tEnM4F0s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-zqrVS2EyOZiEaGkMsD_eQg-1; Tue, 28 Sep 2021 10:11:52 -0400
X-MC-Unique: zqrVS2EyOZiEaGkMsD_eQg-1
Received: by mail-ed1-f71.google.com with SMTP id a6-20020a50c306000000b003da30a380e1so17220895edb.23
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xVoo+M6uUaOiYZtopIoxfUEyXOYNBvxexaFRMYrLxg8=;
        b=4B1/GOhPbzMJNpuwnlvngHZZRy7fs9WoKF5BGDcHUVLfTl7qVeY2xThQ1Z4BzPl/AO
         p75x1FXby3Tr8s0++KYjeFvIkToI8eFWt5SYGhGVxMcE0bmLdYpx5qaaGm+37AgLoVhu
         qzWxJc77gm5wO4qsS0u9MP6dC0PKN+uSHimNMBUZMGhZ8eWCRJeuF5bzBc2K1OL2suMB
         SzjHdv3ss7QwJRMK7GxXVQ9hAmBc0ap+UHWgXq9xPHeqSEGcvIr7D3T4eQAQAd1bxKx0
         sSOKeYJSTAmADSA+x6fzMm1o6i1gC+Yjw2IXHwToeJLY5MxcpxAQRhSEcnD6N68yX/5v
         6tqA==
X-Gm-Message-State: AOAM531YKTZa/CyarFJ+kvprgWHlwr8F++NUfrLnZmJKx7YF4Y8AlcT3
        lVF72atEm8z9QeD3nmoHnhCNQpUqVo3yK0MucUd6LQSqlB6pjM7yedNe/UNgHqm9NcH+zaazoDE
        F0k0+HpI91kY5Ix+dfeAdZaJd
X-Received: by 2002:a05:6402:16d9:: with SMTP id r25mr7760139edx.80.1632838311151;
        Tue, 28 Sep 2021 07:11:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhk0du4D+Vm3+XSAwsmoG7TkvY6f7Qf0gdVsJwR7KL5IvNw8f6IW3WLCZlbkhbATinMWWHMQ==
X-Received: by 2002:a05:6402:16d9:: with SMTP id r25mr7760115edx.80.1632838310858;
        Tue, 28 Sep 2021 07:11:50 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b13sm14713128ede.97.2021.09.28.07.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 07:11:50 -0700 (PDT)
Subject: Re: [PATCH v11] asus-wmi: Add support for custom fan curves
To:     Luke Jones <luke@ljones.dev>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-kernel@vger.kernel.org,
        pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org
References: <20210907232232.5205-1-luke@ljones.dev>
 <20210907232232.5205-2-luke@ljones.dev>
 <1d9d4de26d0c862acf3e579f14de9596027f3c3b.camel@hadess.net>
 <99750R.GZYR2PKX93HX@ljones.dev>
 <10be9244-0d89-ef79-08d0-fe7024609ee2@redhat.com>
 <NY750R.JRUHTBKNLH1F1@ljones.dev>
 <461e3768-7c6d-7351-3482-2545ad0af754@redhat.com>
 <YP850R.AMCS62ND6R8R3@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e809e7eb-3f38-19fe-46aa-ff40f2fde838@redhat.com>
Date:   Tue, 28 Sep 2021 16:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YP850R.AMCS62ND6R8R3@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/28/21 2:15 PM, Luke Jones wrote:
> 
> 
> On Tue, Sep 28 2021 at 14:03:54 +0200, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 9/28/21 1:59 PM, Luke Jones wrote:
>>>
>>>
>>>  On Tue, Sep 28 2021 at 13:56:05 +0200, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>  Hi,
>>>>
>>>>  On 9/28/21 1:43 PM, Luke Jones wrote:
>>>>>   Sure, the path is similar to /sys/devices/platform/asus-nb-wmi/hwmon/hwmon4/pwm1_enable where hwmon4 will likely be different depending on init, and pwm2_enable is the second fan if it exists. The values are 1,2,3 - where 1 = fan curve enabled/manual, 2 = auto. 3 here is custom extra that writes default curve back then defaults to 2.
>>>>>
>>>>>   As I understand it, this should be adhering to the accepted kernel standard, so if you use this for ASUS laptops, then it should carry over to other brands that implement it also.
>>>>
>>>>  Ah, so this is a bit different then how I thought this would work
>>>>  (this is probably better though).
>>>>
>>>>  <snip>
>>>>
>>>>>>>    The fans have settings [1,2,3] under pwm<N>_enable:
>>>>>>>    1. Enable and write settings out
>>>>>>>    2. Disable and use factory fan mode
>>>>>>>    3. Same as 2, additionally restoring default factory curve.
>>>>
>>>>  Quoting Documentation/hwmon/sysfs-interface.rst
>>>>
>>>>  `pwm[1-*]_enable`
>>>>                  Fan speed control method:
>>>>
>>>>                  - 0: no fan speed control (i.e. fan at full speed)
>>>>                  - 1: manual fan speed control enabled (using `pwm[1-*]`)
>>>>                  - 2+: automatic fan speed control enabled
>>>>
>>>>  1 normally means the fans runs at a fixed speed, but you are using it
>>>>  for the custom/manual profile, which is still a temp<->pwm table,
>>>>  right?
>>>>
>>>>  I guess this make sense since full manual control is not supported
>>>>  and this keeps "2" aka auto as being the normal factory auto
>>>>  setting which is good.
>>>>
>>>>  Bastien is this interface usable for p-p-d ?
>>>>
>>>>  I guess that it is a bit annoying that you need to figure out
>>>>  the # in the hwmon# part of the path, but there will be only
>>>>  one hwmon child.
>>>>
>>>>  You could also go through /sys/class/hwmon but then you really
>>>>  have no idea which one to use. Ideally we would have some way
>>>>  to indicate that there is a hmwon class-dev associated with
>>>>  /sys/firmware/acpi/platform_profile but as we mentioned before
>>>>  we should defer coming up with a generic solution for this
>>>>  until we have more then 1 user, so that we hopefully get the
>>>>  generic solution right in one go.
>>>
>>>  If it's at all helpful, I named the interface as "asus_custom_fan_curve". I use this to verify I have the correct hwmon for asusctl. Open to suggestions on that.
>>
>> Ah yes, that means the interface could be looked up through /sys/class/hwmon
>> too, that is probably the safest route to go then, as the
>> /sys/devices/platform/asus-nb-wmi/ path might change if we e.g. ever
>> convert the asus-wmi code to use the new wmi bus interface.
> 
> Oh man... can you link me to relevant bits? I'll stick this on my to-do for future. There will be more patches from me over time so this might be good to have done?

This is not something which we have made mandatory for old code to
switch too. The idea is that you get one wmi_device per guid
under: /sys/bus/wmi/devices/

And then the old platform_drivers (which do typically use
"wmi:GUID" as modalias) are converted to wmi_drivers which
bind to a wmi_device and can make calls on that using e.g. :

wmidev_evaluate_method(wmi_dev, ...)

instead of:

wmi_evaluate_method(GUID, ...)

Grep for module_wmi_driver in drivers/platform/x86
for drivers which have been converted to use this.

I see that the asus code uses 3 GUIDs:

ASUS_WMI_MGMT_GUID
ASUS_NB_WMI_EVENT_GUID
EEEPC_WMI_EVENT_GUID

With the first one being shared and the modalias-es
for the asus-nb-wmi resp eeepc-wmi drivers actually
pointing to the 2 EVENT_GUIDs.

So you could change things to have the 2 drivers
bind to the 2 different event_guids, they can
then also have a notify callback as part of their
driver structure instead of having to call

wmi_install_notify_handler() / wmi_remove_notify_handler()

###

Actually, never mind, switching to the new way of doing things
will move all the sysfs attributes from
/sys/devices/platform/asus-nb-wmi/...
to some thing like:
/sys/devices/platform/PNP0C14:07/wmi_bus/wmi_bus-PNP0C14:07/D931B4CF-F54E-4D07-9420-42858CC6A234

So this would be a clear userspace API break :|

IOW we are stuck with using the old way of doing things
in asus-wmi.

Regards,

Hans







> 
>>
>> Now that you have confirmed that any writes to
>> /sys/firmware/acpi/platform_profile override any custom profiles
>> I wonder if p-p-d needs to take this into account at all though.
>>
>> The easiest way to deal with this in p-p-d, is just to not deal
>> with it at all...    If that turns out to be a bad idea, we
>> can always reconsider and add some special handling to p-p-d for
>> this later.
> 
> I believe Bastiens concern here will be that manual control can still be enabled and ppd won't be aware of it without a check. For example the user may switch profile then re-enable the fan-curve. If some problem arises due to manual control of fan then there is no way for ppd to determine if manual was enabled without actually looking.
> 
> This does mean the pwm name here is set in stone. But also means it's special-cased I guess. Perhaps a check for pwm<N>_enable, then check for the pairs of pwm<N>_auto_<xX> that come with it?
> 
> Ciao,
> Luke.
> 
>>
>> Regards,
>>
>> Hans
>>
> 
> 

