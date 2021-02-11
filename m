Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B38319099
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhBKRFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:05:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231377AbhBKP5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613058980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wEe/e+2iePPAXg+m/jWaxVS6/UTnTtoIGH2dFZa7Z1s=;
        b=iai8KQsU7tMp7z0awULgtfhJXv7P7ywnZSQXJtlVy2tTnLwXWNC6F0H2IJvlJRPpb298WR
        lnNHeEWIxmMVWa+Q1j8FGpbxZ0kWM6KeCuqwoUdnEHQfQkMHNdQLCpqpXPhvkbJbRxUFTl
        /gWeMjqmi9iCrfUSB588JoN3d/YP+ck=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-vxJMD50uPNir8SCtELrOQw-1; Thu, 11 Feb 2021 10:56:16 -0500
X-MC-Unique: vxJMD50uPNir8SCtELrOQw-1
Received: by mail-ed1-f70.google.com with SMTP id b1so4747429edt.22
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 07:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wEe/e+2iePPAXg+m/jWaxVS6/UTnTtoIGH2dFZa7Z1s=;
        b=ajWj4c2xs5YYT+d9O4B1yw891rQTQ2CXjm62KJw1TJPgy5Bw1I73DB5YeaP6rParEq
         4s4ZkaBHfATzMeDDEZzlDFRzAMMCIpNplOqlkdBwSrsAl3DNuvGE5H+puuZvGx13jD2w
         Lq0LbHTX9sBOJvRtgtqaEdrrIX3TZH51KL9Pe93es1+khPVISz8/Y1eX8T9ob2gpd6WL
         RJ7cZo3OQ0Ix524+bFZmQoGcFNyGkiFVRJEWaKMrZOfo4LuZ7sVQgBMBns8w6zgPJrG8
         fFgDs6rxtf3qX1ceeUYLOPs2LZhH2jAZOjIGJVsw2d45LRKJoCEFjtd/ANwsG/kf4hPm
         5rnw==
X-Gm-Message-State: AOAM531yghi0xP7bkSOJo3p8ING68ooEWufKKr4+iHK+iFjO9FWVeF7I
        ImpHOyL6tViaEEGbIU326XhehpFamCB6Lq1mKPYEIFVB7SzXKImV7naL9BAfgxqrx7fkXUYgtrC
        N2unL+5D07BvGDM3bw1E/pCgZijb+S8eACyJtUqG58BdZFD4jOR2QxScr9P7OptmFyN/sSNJKVy
        AJ
X-Received: by 2002:a17:906:eca5:: with SMTP id qh5mr8861649ejb.161.1613058974483;
        Thu, 11 Feb 2021 07:56:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHx+2ThiYjwm/rv/MTrQ63cX2ER1lkPvBGWN6uWP5SKZ9EqxPVyLDcfAvZHoihVEor/AbxSg==
X-Received: by 2002:a17:906:eca5:: with SMTP id qh5mr8861626ejb.161.1613058974246;
        Thu, 11 Feb 2021 07:56:14 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bk2sm4565360ejb.98.2021.02.11.07.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 07:56:13 -0800 (PST)
Subject: Re: [PATCH] platform/surface: Add platform profile driver
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Bastien Nocera <hadess@hadess.net>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210208194903.3039142-1-luzmaximilian@gmail.com>
 <cc9d27aa-955d-1cd1-19b8-9b18bdc6b8a2@redhat.com>
 <c485a731-4378-239f-95e7-3b588f13cb66@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <dfc90822-d13e-cfc9-af99-0f7b78d2a286@redhat.com>
Date:   Thu, 11 Feb 2021 16:56:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <c485a731-4378-239f-95e7-3b588f13cb66@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/8/21 10:38 PM, Maximilian Luz wrote:
> 
> 
> On 2/8/21 9:27 PM, Hans de Goede wrote:

<snip>

>>> +static int convert_ssam_to_profile(struct ssam_device *sdev, enum ssam_tmp_profile p)
>>> +{
>>> +    switch (p) {
>>> +    case SSAM_TMP_PROFILE_NORMAL:
>>> +        return PLATFORM_PROFILE_QUIET;
>>> +
>>> +    case SSAM_TMP_PROFILE_BATTERY_SAVER:
>>> +        return PLATFORM_PROFILE_LOW_POWER;
>>> +
>>> +    case SSAM_TMP_PROFILE_BETTER_PERFORMANCE:
>>> +        return PLATFORM_PROFILE_BALANCED;
>>> +
>>> +    case SSAM_TMP_PROFILE_BEST_PERFORMANCE:
>>> +        return PLATFORM_PROFILE_PERFORMANCE;
>>> +
>>> +    default:
>>> +        dev_err(&sdev->dev, "invalid performance profile: %d", p);
>>> +        return -EINVAL;
>>> +    }
>>> +}
>>
>> I'm not sure about the mapping which you have chosen here. I know that at least for
>> gnome there are plans to make this stuff available in the UI:
>>
>> https://gitlab.gnome.org/Teams/Design/settings-mockups/-/blob/master/power/power.png
>> http://www.hadess.net/2020/09/power-profiles-daemon-new-project.html
> 
> Thanks for those links!
>  
>> Notice there are only 3 levels in the UI, which will primarily be mapped to:
>>
>> PLATFORM_PROFILE_LOW_POWER
>> PLATFORM_PROFILE_BALANCED
>> PLATFORM_PROFILE_PERFORMANCE
>>
>> (with fallbacks to say QUIET for LOW_POWER of there is no LOW_POWER, but that
>> mostly is something for userspace to worry about).
> 
> Interesting, I wasn't aware of that. I was aware of Bastien's work
> towards implementing user-space support for this but I hadn't yet looked
> at it in detail (e.g. the "fallback to quiet" is new to me).

Note that the fallback stuff would not apply here, since you do provide
all 3 of low-power, balanced and performance. But the current way gnome
will handle this means that it will be impossible to select "normal" from
the GNOME ui which feels wrong.

>> And the power-profile-daemon will likely restore the last used setting on boot,
>> meaning with your mapping that it will always switch the profile away from
>> SSAM_TMP_PROFILE_NORMAL, which I assume is the default profile picked at boot ?
> 
> Pretty much, yeah. AFAICT booting doesn't reset it, but hard-resetting
> the EC does. Same difference though.
>  
>> So ideally we would map PLATFORM_PROFILE_BALANCED (which will be the default
>> GNOME / power-profile-daemon setting) to SSAM_TMP_PROFILE_NORMAL.
>>
>> I know the ABI docs say that drivers should try to use existing values, but
>> this seems like a good case to add a new value or 2 to the PLATFORM_PROFILE enum.
>>
>> During the discussion the following 2 options were given because some devices
>> may have more then one balanced profile:
>>
>> PLATFORM_PROFILE_BALANCED_LOW_POWER:
>>
>>                  balanced-low-power:     Balances between low power consumption
>>                                          and performance with a slight bias
>>                                          towards low power
>>
>> PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>>
>>                  balanced-performance:   Balances between performance and low
>>                                          power consumption with a slight bias
>>                                          towards performance
>>
>> I think it would be better to add 1 or both of these, if we add both
>> we could e.g. do the following mappings:
>>
>> SSAM_TMP_PROFILE_BATTERY_SAVER      ->  PLATFORM_PROFILE_LOW_POWER
>> SSAM_TMP_PROFILE_NORMAL             ->  PLATFORM_PROFILE_BALANCED_LOW_POWER
>> SSAM_TMP_PROFILE_BETTER_PERFORMANCE ->  PLATFORM_PROFILE_BALANCED_PERFORMANCE
>> SSAM_TMP_PROFILE_BEST_PERFORMANCE   ->  PLATFORM_PROFILE_PERFORMANCE
>>
>> or we could do:
>>
>> SSAM_TMP_PROFILE_BATTERY_SAVER      ->  PLATFORM_PROFILE_LOW_POWER
>> SSAM_TMP_PROFILE_NORMAL             ->  PLATFORM_PROFILE_BALANCED
>> SSAM_TMP_PROFILE_BETTER_PERFORMANCE ->  PLATFORM_PROFILE_BALANCED_PERFORMANCE
>> SSAM_TMP_PROFILE_BEST_PERFORMANCE   ->  PLATFORM_PROFILE_PERFORMANCE
>>
>> I'm not sure which is best, I hope you have a better idea of that then me.
>>
>> I might even be wrong here and NORMAL might really be more about being QUIET
>> then it really being BALANCED ? In which case the mapping is fine as is.
> 
> I can only really speak on the behavior of my Surface Book 2. On that
> device, the CPU is passively cooled, but the discrete GPU is actively
> cooled, so I can actually only really talk about active cooling behavior
> for the dGPU.
> 
> On that, at least, the normal (Windows calls this 'recommended') profile
> feels like it targets quiet operation. Using the dGPU with that profile
> pretty much ensures that the dGPU will be limited in performance by a
> thermal limiter (around 75°C to 80°C; at least it feels that way), while
> the fan is somewhat audible but definitely not at maximum speed.
> Changing the profile to any higher profile (Windows calls those 'better
> performance' and 'best performance'), the fan becomes significantly more
> audible. I'm not entirely sure if the performance increase can solely be
> attributed to cooling though.
> 
> As far as I've heard, that behavior seems to be similar on other devices
> with fans for CPU cooling, but I can try to get some more feedback on
> that.
> 
> Based on all of this, I thought that this would most resemble a 'quiet'
> profile. But I'd also be fine with your second suggestion. Calling the
> last two options 'balanced performance' and 'performance' might be a bit
> closer to the Windows naming scheme. It doesn't seem like the normal
> profile does much power limiting in terms of actually capping the power
> limit of the dGPU, so I think calling this 'balanced' would also make
> sense to me, especially in light of Gnome's defaults.

Ack.

So that means that this is going to need to have a preparation patch
adding the 2 balanced variants which I mention above. Can you take care
of that in the next version?

And since that prep. patch needs to go through Rafael's PM tree anyways,
maybe also throw in a patch to make ACPI_PLATFORM_PROFILE not user selectable
and use select on it in the thinkpad_acpi and ideapad_laptop drivers?

Regards,

Hans




>>> +
>>> +static int convert_profile_to_ssam(struct ssam_device *sdev, enum platform_profile_option p)
>>> +{
>>> +    switch (p) {
>>> +    case PLATFORM_PROFILE_LOW_POWER:
>>> +        return SSAM_TMP_PROFILE_BATTERY_SAVER;
>>> +
>>> +    case PLATFORM_PROFILE_QUIET:
>>> +        return SSAM_TMP_PROFILE_NORMAL;
>>> +
>>> +    case PLATFORM_PROFILE_BALANCED:
>>> +        return SSAM_TMP_PROFILE_BETTER_PERFORMANCE;
>>> +
>>> +    case PLATFORM_PROFILE_PERFORMANCE:
>>> +        return SSAM_TMP_PROFILE_BEST_PERFORMANCE;
>>> +
>>> +    default:
>>> +        /* This should have already been caught by platform_profile_store(). */
>>> +        WARN(true, "unsupported platform profile");
>>> +        return -EOPNOTSUPP;
>>> +    }
>>> +}
>>> +
>>> +static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
>>> +                     enum platform_profile_option *profile)
>>> +{
>>> +    struct ssam_tmp_profile_device *tpd;
>>> +    enum ssam_tmp_profile tp;
>>> +    int status;
>>> +
>>> +    tpd = container_of(pprof, struct ssam_tmp_profile_device, handler);
>>> +
>>> +    status = ssam_tmp_profile_get(tpd->sdev, &tp);
>>> +    if (status)
>>> +        return status;
>>> +
>>> +    status = convert_ssam_to_profile(tpd->sdev, tp);
>>> +    if (status < 0)
>>> +        return status;
>>> +
>>> +    *profile = status;
>>> +    return 0;
>>> +}
>>> +
>>> +static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
>>> +                     enum platform_profile_option profile)
>>> +{
>>> +    struct ssam_tmp_profile_device *tpd;
>>> +    int tp;
>>> +
>>> +    tpd = container_of(pprof, struct ssam_tmp_profile_device, handler);
>>> +
>>> +    tp = convert_profile_to_ssam(tpd->sdev, profile);
>>> +    if (tp < 0)
>>> +        return tp;
>>> +
>>> +    return ssam_tmp_profile_set(tpd->sdev, tp);
>>> +}
>>> +
>>> +static int surface_platform_profile_probe(struct ssam_device *sdev)
>>> +{
>>> +    struct ssam_tmp_profile_device *tpd;
>>> +
>>> +    tpd = devm_kzalloc(&sdev->dev, sizeof(*tpd), GFP_KERNEL);
>>> +    if (!tpd)
>>> +        return -ENOMEM;
>>> +
>>> +    tpd->sdev = sdev;
>>> +
>>> +    tpd->handler.profile_get = ssam_platform_profile_get;
>>> +    tpd->handler.profile_set = ssam_platform_profile_set;
>>> +
>>> +    set_bit(PLATFORM_PROFILE_LOW_POWER, tpd->handler.choices);
>>> +    set_bit(PLATFORM_PROFILE_QUIET, tpd->handler.choices);
>>> +    set_bit(PLATFORM_PROFILE_BALANCED, tpd->handler.choices);
>>> +    set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
>>> +
>>> +    platform_profile_register(&tpd->handler);
>>> +    return 0;
>>> +}
>>> +
>>> +static void surface_platform_profile_remove(struct ssam_device *sdev)
>>> +{
>>> +    platform_profile_remove();
>>> +}
>>> +
>>> +static const struct ssam_device_id ssam_platform_profile_match[] = {
>>> +    { SSAM_SDEV(TMP, 0x01, 0x00, 0x01) },
>>> +    { },
>>> +};
>>> +MODULE_DEVICE_TABLE(ssam, ssam_platform_profile_match);
>>> +
>>> +static struct ssam_device_driver surface_platform_profile = {
>>> +    .probe = surface_platform_profile_probe,
>>> +    .remove = surface_platform_profile_remove,
>>> +    .match_table = ssam_platform_profile_match,
>>> +    .driver = {
>>> +        .name = "surface_platform_profile",
>>> +        .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>>> +    },
>>> +};
>>> +module_ssam_device_driver(surface_platform_profile);
>>> +
>>> +MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
>>> +MODULE_DESCRIPTION("Platform Profile Support for Surface System Aggregator Module");
>>> +MODULE_LICENSE("GPL");
>>>
>>
> 

