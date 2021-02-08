Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF4831423F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhBHVuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbhBHVix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:38:53 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A67C061788;
        Mon,  8 Feb 2021 13:38:12 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id b9so27728052ejy.12;
        Mon, 08 Feb 2021 13:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UhATZQNb+FsXcmy+E6aF1bWuHXreHrA4kvCV14Q+lhs=;
        b=oaXzSxWfaEdfWlc/nqkF8sABWQLzdI6j6t2sjsfsnIQ6RiodYQrzf/cqWEfWoSU1Mi
         J5/8RM0sa7VnEHbbR8x+vZq2DuvGQBMJwhyomffCNMC2uIJDpvLd7bmiVjcPWA7TtBS4
         DXj+pQnkzV3i1pJTJYOcrbJdd1bvqkWh/Wun8BUDQtPm7QFU9SrDe6sGHzEyZAeoLHQ5
         0RKHNj4+g0k7P2tXT7dNY1Oxw98unR8n7fnqfqKYQusphCY5OUJTR6hpuxxXZhSkOVU5
         u0n4Q7RFiHRxLOBasygD1aFW2x9ltwnGicPw6vpOtZv8qBjTwiWWzh/49b887Zt0LGg5
         0zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UhATZQNb+FsXcmy+E6aF1bWuHXreHrA4kvCV14Q+lhs=;
        b=ZpNK3OhsaJgAhNkd8rMq3xp1IJSgje9DVXOfxFxMg6dMFxFDu9Y9/hh8zwVFBx36mU
         /xr9epX71EnnDYk8ofrPd2J67VNPtw/gDmA1nBgfb4HCw2XyGuwa9YY0HcS1YP2n58l8
         f93x6p41COF0boeqAw4slMqO4XsOntr89Ksaco1Zj3dYolAlpFzQE9N8POfqn18lrES5
         7q9PeJw6ga+oto5oyTsmDy6yf0L3/Ei3cL60FqaXT/f+X2wBJjls/mJ2RraX8zdGI6Dh
         wjtqfT3mySMcINJBFzlvMUHHqvYhJ15R00i/wTkub3IPWv7IxSaEqMUqs3fCvfsBePJX
         CYeA==
X-Gm-Message-State: AOAM530zgUSVIxL1oxdz6mg8GycwJL/PvsXH3EaPOkFceY147hbXmgoY
        kT5eBQNZo4TXXGQatuwIMxPXOHPF6/Z1VA==
X-Google-Smtp-Source: ABdhPJzzThHuPff0cD1D8jW5MgYOJ7MLnK9xEV76rFZuc1wVtG1HO0w8Fuzct8w7evvEFhN46U3fXg==
X-Received: by 2002:a17:906:3e96:: with SMTP id a22mr18965523ejj.144.1612820289846;
        Mon, 08 Feb 2021 13:38:09 -0800 (PST)
Received: from [10.17.0.29] ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id f6sm10424920edk.13.2021.02.08.13.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 13:38:08 -0800 (PST)
Subject: Re: [PATCH] platform/surface: Add platform profile driver
To:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210208194903.3039142-1-luzmaximilian@gmail.com>
 <cc9d27aa-955d-1cd1-19b8-9b18bdc6b8a2@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <c485a731-4378-239f-95e7-3b588f13cb66@gmail.com>
Date:   Mon, 8 Feb 2021 22:38:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <cc9d27aa-955d-1cd1-19b8-9b18bdc6b8a2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/21 9:27 PM, Hans de Goede wrote:
> Hi,
> 
> On 2/8/21 8:49 PM, Maximilian Luz wrote:
>> Add a driver to provide platform profile support on 5th- and later
>> generation Microsoft Surface devices with a Surface System Aggregator
>> Module. On those devices, the platform profile can be used to influence
>> cooling behavior and power consumption.
>>
>> For example, the default 'quiet' profile limits fan noise and in turn
>> sacrifices performance of the discrete GPU found on Surface Books. Its
>> full performance can only be unlocked on the 'performance' profile.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>> ---
>>
>> Note: This patch builds ontop of the
>>
>>      platform/surface: Add Surface Aggregator device registry
>>
>> series. While that series is not strictly required for building this
>> driver, it provides the device against which it loads. So (at the moment
>> at least) this patch is essentially useless without that series.
> 
> Oh, another user of the new platform-profile stuff, great, that means
> that the time to get this in place was probably well spend :)
> 
> A few review remarks inline.
> 
>>
>> ---
>>   MAINTAINERS                                   |   6 +
>>   drivers/platform/surface/Kconfig              |  27 +++
>>   drivers/platform/surface/Makefile             |   1 +
>>   .../surface/surface_platform_profile.c        | 190 ++++++++++++++++++
>>   4 files changed, 224 insertions(+)
>>   create mode 100644 drivers/platform/surface/surface_platform_profile.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 000a82f59c76..a08d65f8f0df 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11811,6 +11811,12 @@ L:	platform-driver-x86@vger.kernel.org
>>   S:	Maintained
>>   F:	drivers/platform/surface/surface_hotplug.c
>>   
>> +MICROSOFT SURFACE PLATFORM PROFILE DRIVER
>> +M:	Maximilian Luz <luzmaximilian@gmail.com>
>> +L:	platform-driver-x86@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/platform/surface/surface_platform_profile.c
>> +
>>   MICROSOFT SURFACE PRO 3 BUTTON DRIVER
>>   M:	Chen Yu <yu.c.chen@intel.com>
>>   L:	platform-driver-x86@vger.kernel.org
>> diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
>> index 1cd37c041710..e12c65909bcc 100644
>> --- a/drivers/platform/surface/Kconfig
>> +++ b/drivers/platform/surface/Kconfig
>> @@ -131,6 +131,33 @@ config SURFACE_HOTPLUG
>>   	  Select M or Y here, if you want to (fully) support hot-plugging of
>>   	  dGPU devices on the Surface Book 2 and/or 3 during D3cold.
>>   
>> +config SURFACE_PLATFORM_PROFILE
>> +	tristate "Surface Platform Profile Driver"
>> +	depends on SURFACE_AGGREGATOR_BUS
>> +	depends on ACPI_PLATFORM_PROFILE
> 
> Not really about this patch, but it seems to me that it would be better
> to make ACPI_PLATFORM_PROFILE not user selectable and use select here
> and in the other 2 Kconfig bits which have depends on ACPI_PLATFORM_PROFILE ATM.
> I would certainly welcome a patch for this.

That sounds like a good idea.
  
> Note such a patch should probably sit on top of this one, as it will need
> some coordination with Rafael to get that upstream.
> 
> Although we may need some other changes to drivers/acpi/platform_profile.c
> too, see below.
> 
>> +	help
>> +	  Provides support for the ACPI platform profile on 5th- and later
>> +	  generation Microsoft Surface devices.
>> +
>> +	  More specifically, this driver provides ACPI platform profile support
>> +	  on Microsoft Surface devices with a Surface System Aggregator Module
>> +	  (SSAM) connected via the Surface Serial Hub (SSH / SAM-over-SSH). In
>> +	  other words, this driver provides platform profile support on the
>> +	  Surface Pro 5, Surface Book 2, Surface Laptop, Surface Laptop Go and
>> +	  later. On those devices, the platform profile can significantly
>> +	  influence cooling behavior, e.g. setting it to 'quiet' (default) or
>> +	  'low-power' can significantly limit performance of the discrete GPU on
>> +	  Surface Books, while in turn leading to lower power consumption and/or
>> +	  less fan noise.
>> +
>> +	  Note that this driver currently relies on the Surface Aggregator
>> +	  registry (CONFIG_SURFACE_AGGREGATOR_REGISTRY) to provide the device it
>> +	  loads against. Thus, without that registry, this module is essentially
>> +	  of no use.
> 
> I would prefer if you dropped this paragraph and just add a:
> 
> depends on SURFACE_AGGREGATOR_REGISTRY
> 
> Technically this could be builtin while SURFACE_AGGREGATOR_REGISTRY is a module,
> while adding the depends on will disallow that, but I see no reason why someone
> would want to make this builtin without also having SURFACE_AGGREGATOR_REGISTRY
> builtin.

That's fair, I'll change that. My hope was that we someday may find a
way to dynamically query devices, but then we'll have to update the
registry anyway.

> 
>> +
>> +	  Select M or Y here, if you want to include ACPI platform profile
>> +	  support on the above mentioned devices.
>> +
>>   config SURFACE_PRO3_BUTTON
>>   	tristate "Power/home/volume buttons driver for Microsoft Surface Pro 3/4 tablet"
>>   	depends on INPUT
>> diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
>> index 80035ee540bf..99372c427b73 100644
>> --- a/drivers/platform/surface/Makefile
>> +++ b/drivers/platform/surface/Makefile
>> @@ -13,4 +13,5 @@ obj-$(CONFIG_SURFACE_AGGREGATOR_CDEV)	+= surface_aggregator_cdev.o
>>   obj-$(CONFIG_SURFACE_AGGREGATOR_REGISTRY) += surface_aggregator_registry.o
>>   obj-$(CONFIG_SURFACE_GPE)		+= surface_gpe.o
>>   obj-$(CONFIG_SURFACE_HOTPLUG)		+= surface_hotplug.o
>> +obj-$(CONFIG_SURFACE_PLATFORM_PROFILE)	+= surface_platform_profile.o
>>   obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
>> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
>> new file mode 100644
>> index 000000000000..548ad8af9cf1
>> --- /dev/null
>> +++ b/drivers/platform/surface/surface_platform_profile.c
>> @@ -0,0 +1,190 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Surface Platform Profile / Performance Mode driver for Surface System
>> + * Aggregator Module (thermal subsystem).
>> + *
>> + * Copyright (C) 2021 Maximilian Luz <luzmaximilian@gmail.com>
>> + */
>> +
>> +#include <asm/unaligned.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_profile.h>
>> +#include <linux/types.h>
>> +
>> +#include <linux/surface_aggregator/device.h>
>> +
>> +enum ssam_tmp_profile {
>> +	SSAM_TMP_PROFILE_NORMAL             = 1,
>> +	SSAM_TMP_PROFILE_BATTERY_SAVER      = 2,
>> +	SSAM_TMP_PROFILE_BETTER_PERFORMANCE = 3,
>> +	SSAM_TMP_PROFILE_BEST_PERFORMANCE   = 4,
>> +};
>> +
>> +struct ssam_tmp_profile_info {
>> +	__le32 profile;
>> +	__le16 unknown1;
>> +	__le16 unknown2;
>> +} __packed;
>> +
>> +struct ssam_tmp_profile_device {
>> +	struct ssam_device *sdev;
>> +	struct platform_profile_handler handler;
>> +};
>> +
>> +static SSAM_DEFINE_SYNC_REQUEST_CL_R(__ssam_tmp_profile_get, struct ssam_tmp_profile_info, {
>> +	.target_category = SSAM_SSH_TC_TMP,
>> +	.command_id      = 0x02,
>> +});
>> +
>> +static SSAM_DEFINE_SYNC_REQUEST_CL_W(__ssam_tmp_profile_set, __le32, {
>> +	.target_category = SSAM_SSH_TC_TMP,
>> +	.command_id      = 0x03,
>> +});
>> +
>> +static int ssam_tmp_profile_get(struct ssam_device *sdev, enum ssam_tmp_profile *p)
>> +{
>> +	struct ssam_tmp_profile_info info;
>> +	int status;
>> +
>> +	status = ssam_retry(__ssam_tmp_profile_get, sdev, &info);
>> +	if (status < 0)
>> +		return status;
>> +
>> +	*p = le32_to_cpu(info.profile);
>> +	return 0;
>> +}
>> +
>> +static int ssam_tmp_profile_set(struct ssam_device *sdev, enum ssam_tmp_profile p)
>> +{
>> +	__le32 profile_le = cpu_to_le32(p);
>> +
>> +	return ssam_retry(__ssam_tmp_profile_set, sdev, &profile_le);
>> +}
>> +
>> +static int convert_ssam_to_profile(struct ssam_device *sdev, enum ssam_tmp_profile p)
>> +{
>> +	switch (p) {
>> +	case SSAM_TMP_PROFILE_NORMAL:
>> +		return PLATFORM_PROFILE_QUIET;
>> +
>> +	case SSAM_TMP_PROFILE_BATTERY_SAVER:
>> +		return PLATFORM_PROFILE_LOW_POWER;
>> +
>> +	case SSAM_TMP_PROFILE_BETTER_PERFORMANCE:
>> +		return PLATFORM_PROFILE_BALANCED;
>> +
>> +	case SSAM_TMP_PROFILE_BEST_PERFORMANCE:
>> +		return PLATFORM_PROFILE_PERFORMANCE;
>> +
>> +	default:
>> +		dev_err(&sdev->dev, "invalid performance profile: %d", p);
>> +		return -EINVAL;
>> +	}
>> +}
> 
> I'm not sure about the mapping which you have chosen here. I know that at least for
> gnome there are plans to make this stuff available in the UI:
> 
> https://gitlab.gnome.org/Teams/Design/settings-mockups/-/blob/master/power/power.png
> http://www.hadess.net/2020/09/power-profiles-daemon-new-project.html

Thanks for those links!
  
> Notice there are only 3 levels in the UI, which will primarily be mapped to:
> 
> PLATFORM_PROFILE_LOW_POWER
> PLATFORM_PROFILE_BALANCED
> PLATFORM_PROFILE_PERFORMANCE
> 
> (with fallbacks to say QUIET for LOW_POWER of there is no LOW_POWER, but that
> mostly is something for userspace to worry about).

Interesting, I wasn't aware of that. I was aware of Bastien's work
towards implementing user-space support for this but I hadn't yet looked
at it in detail (e.g. the "fallback to quiet" is new to me).

> And the power-profile-daemon will likely restore the last used setting on boot,
> meaning with your mapping that it will always switch the profile away from
> SSAM_TMP_PROFILE_NORMAL, which I assume is the default profile picked at boot ?

Pretty much, yeah. AFAICT booting doesn't reset it, but hard-resetting
the EC does. Same difference though.
  
> So ideally we would map PLATFORM_PROFILE_BALANCED (which will be the default
> GNOME / power-profile-daemon setting) to SSAM_TMP_PROFILE_NORMAL.
> 
> I know the ABI docs say that drivers should try to use existing values, but
> this seems like a good case to add a new value or 2 to the PLATFORM_PROFILE enum.
> 
> During the discussion the following 2 options were given because some devices
> may have more then one balanced profile:
> 
> PLATFORM_PROFILE_BALANCED_LOW_POWER:
> 
>                  balanced-low-power:     Balances between low power consumption
>                                          and performance with a slight bias
>                                          towards low power
> 
> PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> 
>                  balanced-performance:   Balances between performance and low
>                                          power consumption with a slight bias
>                                          towards performance
> 
> I think it would be better to add 1 or both of these, if we add both
> we could e.g. do the following mappings:
> 
> SSAM_TMP_PROFILE_BATTERY_SAVER      ->  PLATFORM_PROFILE_LOW_POWER
> SSAM_TMP_PROFILE_NORMAL             ->  PLATFORM_PROFILE_BALANCED_LOW_POWER
> SSAM_TMP_PROFILE_BETTER_PERFORMANCE ->  PLATFORM_PROFILE_BALANCED_PERFORMANCE
> SSAM_TMP_PROFILE_BEST_PERFORMANCE   ->  PLATFORM_PROFILE_PERFORMANCE
> 
> or we could do:
> 
> SSAM_TMP_PROFILE_BATTERY_SAVER      ->  PLATFORM_PROFILE_LOW_POWER
> SSAM_TMP_PROFILE_NORMAL             ->  PLATFORM_PROFILE_BALANCED
> SSAM_TMP_PROFILE_BETTER_PERFORMANCE ->  PLATFORM_PROFILE_BALANCED_PERFORMANCE
> SSAM_TMP_PROFILE_BEST_PERFORMANCE   ->  PLATFORM_PROFILE_PERFORMANCE
> 
> I'm not sure which is best, I hope you have a better idea of that then me.
> 
> I might even be wrong here and NORMAL might really be more about being QUIET
> then it really being BALANCED ? In which case the mapping is fine as is.

I can only really speak on the behavior of my Surface Book 2. On that
device, the CPU is passively cooled, but the discrete GPU is actively
cooled, so I can actually only really talk about active cooling behavior
for the dGPU.

On that, at least, the normal (Windows calls this 'recommended') profile
feels like it targets quiet operation. Using the dGPU with that profile
pretty much ensures that the dGPU will be limited in performance by a
thermal limiter (around 75°C to 80°C; at least it feels that way), while
the fan is somewhat audible but definitely not at maximum speed.
Changing the profile to any higher profile (Windows calls those 'better
performance' and 'best performance'), the fan becomes significantly more
audible. I'm not entirely sure if the performance increase can solely be
attributed to cooling though.

As far as I've heard, that behavior seems to be similar on other devices
with fans for CPU cooling, but I can try to get some more feedback on
that.

Based on all of this, I thought that this would most resemble a 'quiet'
profile. But I'd also be fine with your second suggestion. Calling the
last two options 'balanced performance' and 'performance' might be a bit
closer to the Windows naming scheme. It doesn't seem like the normal
profile does much power limiting in terms of actually capping the power
limit of the dGPU, so I think calling this 'balanced' would also make
sense to me, especially in light of Gnome's defaults.

Regards,
Max

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> 
> 
> 
>> +
>> +static int convert_profile_to_ssam(struct ssam_device *sdev, enum platform_profile_option p)
>> +{
>> +	switch (p) {
>> +	case PLATFORM_PROFILE_LOW_POWER:
>> +		return SSAM_TMP_PROFILE_BATTERY_SAVER;
>> +
>> +	case PLATFORM_PROFILE_QUIET:
>> +		return SSAM_TMP_PROFILE_NORMAL;
>> +
>> +	case PLATFORM_PROFILE_BALANCED:
>> +		return SSAM_TMP_PROFILE_BETTER_PERFORMANCE;
>> +
>> +	case PLATFORM_PROFILE_PERFORMANCE:
>> +		return SSAM_TMP_PROFILE_BEST_PERFORMANCE;
>> +
>> +	default:
>> +		/* This should have already been caught by platform_profile_store(). */
>> +		WARN(true, "unsupported platform profile");
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>> +static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
>> +				     enum platform_profile_option *profile)
>> +{
>> +	struct ssam_tmp_profile_device *tpd;
>> +	enum ssam_tmp_profile tp;
>> +	int status;
>> +
>> +	tpd = container_of(pprof, struct ssam_tmp_profile_device, handler);
>> +
>> +	status = ssam_tmp_profile_get(tpd->sdev, &tp);
>> +	if (status)
>> +		return status;
>> +
>> +	status = convert_ssam_to_profile(tpd->sdev, tp);
>> +	if (status < 0)
>> +		return status;
>> +
>> +	*profile = status;
>> +	return 0;
>> +}
>> +
>> +static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
>> +				     enum platform_profile_option profile)
>> +{
>> +	struct ssam_tmp_profile_device *tpd;
>> +	int tp;
>> +
>> +	tpd = container_of(pprof, struct ssam_tmp_profile_device, handler);
>> +
>> +	tp = convert_profile_to_ssam(tpd->sdev, profile);
>> +	if (tp < 0)
>> +		return tp;
>> +
>> +	return ssam_tmp_profile_set(tpd->sdev, tp);
>> +}
>> +
>> +static int surface_platform_profile_probe(struct ssam_device *sdev)
>> +{
>> +	struct ssam_tmp_profile_device *tpd;
>> +
>> +	tpd = devm_kzalloc(&sdev->dev, sizeof(*tpd), GFP_KERNEL);
>> +	if (!tpd)
>> +		return -ENOMEM;
>> +
>> +	tpd->sdev = sdev;
>> +
>> +	tpd->handler.profile_get = ssam_platform_profile_get;
>> +	tpd->handler.profile_set = ssam_platform_profile_set;
>> +
>> +	set_bit(PLATFORM_PROFILE_LOW_POWER, tpd->handler.choices);
>> +	set_bit(PLATFORM_PROFILE_QUIET, tpd->handler.choices);
>> +	set_bit(PLATFORM_PROFILE_BALANCED, tpd->handler.choices);
>> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
>> +
>> +	platform_profile_register(&tpd->handler);
>> +	return 0;
>> +}
>> +
>> +static void surface_platform_profile_remove(struct ssam_device *sdev)
>> +{
>> +	platform_profile_remove();
>> +}
>> +
>> +static const struct ssam_device_id ssam_platform_profile_match[] = {
>> +	{ SSAM_SDEV(TMP, 0x01, 0x00, 0x01) },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(ssam, ssam_platform_profile_match);
>> +
>> +static struct ssam_device_driver surface_platform_profile = {
>> +	.probe = surface_platform_profile_probe,
>> +	.remove = surface_platform_profile_remove,
>> +	.match_table = ssam_platform_profile_match,
>> +	.driver = {
>> +		.name = "surface_platform_profile",
>> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +	},
>> +};
>> +module_ssam_device_driver(surface_platform_profile);
>> +
>> +MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
>> +MODULE_DESCRIPTION("Platform Profile Support for Surface System Aggregator Module");
>> +MODULE_LICENSE("GPL");
>>
> 
