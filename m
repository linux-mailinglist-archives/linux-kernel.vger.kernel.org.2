Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289E945C9F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 17:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348728AbhKXQ2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 11:28:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241963AbhKXQ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 11:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637771120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b05r8bg61U2tfmYfrS/b95cSni3VCYdBhNiv79D86/Y=;
        b=dFSqO8Qi679PJY3U67vgc3kvK6arBlqSKIpeHWdR3f82r9rJCxYlmVm6Ji+2qVizTjobzA
        E4XImH2g2MEeU+lN9C20Ndjqs/HzZhf4acsFHOshZuAJyfzOqJHD8CuTkoba1qKFJledz3
        YI/+9Cahcq66gnhrJEeqSyqDo4biwjU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-mkGXK5soPDaV6ReEbIIMjQ-1; Wed, 24 Nov 2021 11:25:19 -0500
X-MC-Unique: mkGXK5soPDaV6ReEbIIMjQ-1
Received: by mail-ed1-f71.google.com with SMTP id t9-20020aa7d709000000b003e83403a5cbso2823343edq.19
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 08:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b05r8bg61U2tfmYfrS/b95cSni3VCYdBhNiv79D86/Y=;
        b=qhnU9QWmwRZxZzkHFpmSm4GUQWK2127usABPXpswifgTGq9RFbIRy6O/mOOalbNHQ8
         bm5IHx3n8AsSThbpe9ayZ0gNyf5Z6gzdy4zZWpVkxzeK20sca9iwZRZLrypsRuKWOYoP
         qY4Qa7NchmtfjMCrba8u9kcFlyOCcGMCmXGufdn86C6Rgne5VS98FTDexsMU7EtueQg2
         EOwLDG6DRPTNrbaoUmDL91GAecz2o9JzBkoZ4hFGBp2xTeGdquxhnI3NkrBpq/qSAMqH
         VEMzdVrGOmawHWTehC+QhTTyIYSKOzFlwiDI3ilTXCHuLLJmv4iXmS9yn9sziEZ4ihpn
         w+mA==
X-Gm-Message-State: AOAM533eONzCholYTnbWXgShhhswx7NLntpfwLLGHwS7wUz+2IXA/bpU
        FD7FHw7/w7eoBwknjHxAnMfcB71UhIEeiKIztlCzMZBOnyKLsyVHdh/FH8SD4dhHTU0dcKleLn0
        EJOTrGiwLch48dh9gQk1k/yKi
X-Received: by 2002:a17:907:c02:: with SMTP id ga2mr21267823ejc.217.1637771118364;
        Wed, 24 Nov 2021 08:25:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLK9wcKJCYunKoTMTbcApoDX+YWEAbrWYdDpFE64/RXe9wSr/7j7frqiDhBIkDIsI/DeLZpA==
X-Received: by 2002:a17:907:c02:: with SMTP id ga2mr21267785ejc.217.1637771118148;
        Wed, 24 Nov 2021 08:25:18 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id qf8sm176974ejc.8.2021.11.24.08.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 08:25:17 -0800 (PST)
Message-ID: <ed1e0e2f-25a0-91a9-9f0b-a41b391ee869@redhat.com>
Date:   Wed, 24 Nov 2021 17:25:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mfd: Kconfig: change INTEL_SOC_PMIC_CHTDC_TI to bool
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        linux-kernel@vger.kernel.org
References: <f12ed3dea697e6fdcfcaf9b6cc862ffa7aac005b.1635490923.git.mchehab+huawei@kernel.org>
 <YZ5c0LO5Ocaq+B7c@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YZ5c0LO5Ocaq+B7c@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/24/21 16:40, Lee Jones wrote:
> On Fri, 29 Oct 2021, Mauro Carvalho Chehab wrote:
> 
>> The INTEL_SOC_PMIC_CHTDC_TI should be initialized early, before
>> loading the fbcon driver, as otherwise the i915 driver will
>> fail to configure pwm:
>>
>> [   13.674287] fb0: switching to inteldrmfb from EFI VGA
>> [   13.682380] Console: switching to colour dummy device 80x25
>> [   13.682468] i915 0000:00:02.0: vgaarb: deactivate vga console
>> [   13.682686] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>> [   13.685773] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
>> [   13.686219] i915 0000:00:02.0: [drm] *ERROR* Failed to configure the pwm chip
>> [   13.699572] [drm] Initialized i915 1.6.0 20200313 for 0000:00:02.0 on minor 0
>> [   13.739044] fbcon: i915drmfb (fb0) is primary device
>> [   14.037792] intel_soc_pmic_exec_mipi_pmic_seq_element: No PMIC registered
>> ...
>> [   24.621403] intel_pmic_install_opregion_handler: Ask to register OpRegion for bus ID=PMI2, HID=INT33F5
>> [   24.630540] intel_pmic_install_opregion_handler: OpRegion registered
>>
>> (some extra debug printk's were added to the above)
>>
>> As suggested by Hans, this patch also addresses an issue with
>> the dependencies, as, for this driver to be a bool, it also
>> need the I2C core and the I2C_DESIGNWARE driver to be builtin.
>>
>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> ---
>>  drivers/mfd/Kconfig | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index ca0edab91aeb..f9092c79c4e8 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -632,7 +632,7 @@ config INTEL_SOC_PMIC_CHTWC
>>  config INTEL_SOC_PMIC_CHTDC_TI
>>  	tristate "Support for Intel Cherry Trail Dollar Cove TI PMIC"
>>  	depends on GPIOLIB
>> -	depends on I2C
>> +	depends on I2C = y && I2C_DESIGNWARE_PLATFORM=y
> 
> The lack of formatting consistency here is eating me up inside!
> 
>>  	depends on ACPI
>>  	depends on X86
>>  	select MFD_CORE
>> @@ -642,6 +642,10 @@ config INTEL_SOC_PMIC_CHTDC_TI
>>  	  Select this option for supporting Dollar Cove (TI version) PMIC
>>  	  device that is found on some Intel Cherry Trail systems.
>>  
>> +	  This option is a bool as it provides an ACPI OpRegion which must be
>> +	  available before any devices using it are probed. This option also
>> +	  needs the designware-i2c driver to be builtin for the same reason.
> 
> Is there no way around this?

No unfortunately not, the ACPI device-scan is done really early,
and in ACPI everything is a function, including e.g. _HID,
so I've seen _HID method-s reading e.g. GPIOs. So while the
initial ACPI scan is figuring out what sort of devices it
is dealing with, we already need working GPIOs (for example).

Various early ACPI code (AML / the DSDT) tends to access the
PMICs OpRegion and various problems happen when it is not
available. For the same reason the other BYT/CHT related
INTEL_SOC_PMIC_FOO options are already bools.

I guess that the DSDTs for other Intel SoCs then the BYT/CHT
SoCs might be a bit cleaner. BYT/CHT was Intel's first serious
attempt at standard x86 tablet SoC and this shows in various
places.

Regards,

Hans

