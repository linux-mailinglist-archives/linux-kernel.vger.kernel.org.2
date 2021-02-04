Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C717330F1AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbhBDLKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:10:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235460AbhBDLKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612436947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7n1Zx35K6Deya/aX+emtsNu6Y6NEAEqJ8jR2JgffGJA=;
        b=dgd1rbKdYaNbdXD0CMxWyC5LbzSLp6HqVWbwOD0VQ9LbGPQsCiY88IZRPbhVAyWrj7qKKu
        fBQum82p3Ff7nlHMrhI7xhfmc9I6KbKlZ6Bzp7Ext4/Y7RyjgfDFMgj8Y4JmRmk1EHXPGT
        m837cZWsgi8Gq7mHjTW5WsiDx4GqdoQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-1Cn3eAHrOOS5GWWqtOfrig-1; Thu, 04 Feb 2021 06:09:05 -0500
X-MC-Unique: 1Cn3eAHrOOS5GWWqtOfrig-1
Received: by mail-ed1-f70.google.com with SMTP id w14so2609293edv.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7n1Zx35K6Deya/aX+emtsNu6Y6NEAEqJ8jR2JgffGJA=;
        b=YTUS0z0NBR2JOlVyi/23VQZbFT9EOFft00JYMh9VH2fYpk0W0Ew4bGdcMr9py7tmQn
         Ru070etHlL5joT3ekCUJcGRp+ivGV1R1YS5PmU9XzjZFd5GH1YRXX+47SX/URLlhubNR
         IeL8BgXX7cDEcxeLKSCGjRy1hthtaY0NMm48CzgGSwD9vD1ffURZxScw6ppfERDtaPh6
         rk3WId8hF8FTHE1mU49OD6FHlbOgIx2JQPQAwIaOHM4hu7cwTFDQAqsQDctlk/Vx0hrj
         0+yn9PVzzIcVVkLCOt8tl+LgrI6qMvAkr7e7v0svZxwoTzQZCDz1mf+KjuL/XRI+CE3t
         +STw==
X-Gm-Message-State: AOAM533j3McAhUbxZc5dzyAJMc//ZipHt8c2oDRD1qgxtY0rB4ahWZW/
        E1+uOONay7kr7yscc/46dpHlGWMdPf9GTYptoIM6oHJCrD0J5a9+okB+FoVlVAOrrBXMzE1yUQs
        jvOQwjeAYWN/UsHuxDBhoAFV+
X-Received: by 2002:a50:eacd:: with SMTP id u13mr7277288edp.382.1612436944452;
        Thu, 04 Feb 2021 03:09:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGuuzsbw84IJLIU4lz2LAP6PzugOgBr0KFhBNcmyfRgNpmW6u6KnBMr6frXkyCEaJ8TAHcQA==
X-Received: by 2002:a50:eacd:: with SMTP id u13mr7277258edp.382.1612436943892;
        Thu, 04 Feb 2021 03:09:03 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id u23sm2287523edt.87.2021.02.04.03.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 03:09:03 -0800 (PST)
Subject: Re: [PATCH v4 00/13] MFD/extcon/ASoC: Rework arizona codec
 jack-detect support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
References: <20210123121313.79530-1-hdegoede@redhat.com>
 <20210204110539.GE2789116@dell>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3c996ea7-57dc-11ba-adc1-15fb7b97f107@redhat.com>
Date:   Thu, 4 Feb 2021 12:09:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210204110539.GE2789116@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/4/21 12:05 PM, Lee Jones wrote:
> On Sat, 23 Jan 2021, Hans de Goede wrote:
> 
>> Hi all,
>>
>> Here is v4 of my series to rework the arizona codec jack-detect support
>> to use the snd_soc_jack helpers instead of direct extcon reporting.
>>
>> This is done by reworking the extcon driver into an arizona-jackdet
>> library and then modifying the codec drivers to use that directly,
>> replacing the old separate extcon child-devices and extcon-driver.
>>
>> This brings the arizona-codec jack-detect handling inline with how
>> all other ASoC codec driver do this. This was developed and tested on
>> a Lenovo Yoga Tablet 1051L with a WM5102 codec.
>>
>> There are various interdependencies between the patches in this
>> series, so IMHO it would be best if this entire series would be merged
>> through the MFD tree.
>>
>> Note this series applies on top of my "[PATCH v4 0/5] MFD/ASoC: Add
>> support for Intel Bay Trail boards with WM5102 codec" series.
>>
>> Changes in v4:
>> - Add sound/soc/codecs/arizona-jack.c to the WOLFSON MICROELECTRONICS DRIVERS
>>   MAINTAINERS section
>> - Small codying style tweaks to the "ASoC: arizona-jack: Cleanup logging" patch
>>
>> Changes in v3:
>> - Move the bugfix patches to earlier in the series so that they
>>   apply to drivers/extcon/extcon-arizona.c so that they can be
>>   cherry-picked into the stable series
>> - Split runtime_pm_get -> runtime_pm_get_sync changes out into their
>>   own patch
>> - Simply move drivers/extcon/extcon-arizona.c to
>>   sound/soc/codecs/arizona-jack.c instead of first adding arizona-jack.c
>>   as a copy and then later removing extcon-arizona.c
>> - Some other small tweaks, see individual patch changelogs
>>
>> Regards,
>>
>> Hans
>>
>>
>> Hans de Goede (13):
>>   mfd: arizona: Drop arizona-extcon cells
>>   extcon: arizona: Fix some issues when HPDET IRQ fires after the jack
>>     has been unplugged
>>   extcon: arizona: Fix various races on driver unbind
>>   extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol")
>>     call
>>   extcon: arizona: Always use pm_runtime_get_sync() when we need the
>>     device to be awake
>>   ASoC/extcon: arizona: Move arizona jack code to
>>     sound/soc/codecs/arizona-jack.c
>>   ASoC: arizona-jack: Move jack-detect variables to struct arizona_priv
>>   ASoC: arizona-jack: Use arizona->dev for runtime-pm
>>   ASoC: arizona-jack: convert into a helper library for codec drivers
>>   ASoC: arizona-jack: Use snd_soc_jack to report jack events
>>   ASoC: arizona-jack: Cleanup logging
>>   ASoC: arizona: Make the wm5102, wm5110, wm8997 and wm8998 drivers use
>>     the new jack library
> 
>>   ASoC: Intel: bytcr_wm5102: Add jack detect support
> 
> Can't apply this patch ...
> 
>>  MAINTAINERS                                   |   3 +-
>>  drivers/extcon/Kconfig                        |   8 -
>>  drivers/extcon/Makefile                       |   1 -
>>  drivers/mfd/arizona-core.c                    |  20 -
>>  sound/soc/codecs/Makefile                     |   2 +-
>>  .../soc/codecs/arizona-jack.c                 | 577 +++++++-----------
>>  sound/soc/codecs/arizona.h                    |  44 ++
>>  sound/soc/codecs/wm5102.c                     |  12 +-
>>  sound/soc/codecs/wm5110.c                     |  12 +-
>>  sound/soc/codecs/wm8997.c                     |  14 +-
>>  sound/soc/codecs/wm8998.c                     |   9 +
>>  sound/soc/intel/boards/bytcr_wm5102.c         |  28 +-
> 
> ... since this file doesn't exist?

As mentioned this is a follow-up series on top of the:

"[PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail boards with WM5102 codec"

Series, that series adds that file.

Regards,

Hans

p.s.

Do you want a resend of this one, with the new *-bys added too ?

