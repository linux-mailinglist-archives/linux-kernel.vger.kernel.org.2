Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC2344A945
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 09:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbhKIIjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 03:39:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239047AbhKIIjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636446982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RzwlOsjDvkYyhCM1gJab6TYMZ2M+9RDPU7SdSVVR3oI=;
        b=HOc+ALEAW55xc1TnwxXQwk4Onc2FsrUhq9XHCFce9d1zSv6G+6rogmib7wa8xjVZSeSWou
        VeVkV8UVa0BNRiuGxy5QD4yjzK1C7B/ZLLxxbT1EmHTJdqkpHUmlLngvHoB/5goWLF4Eux
        XKn4hiauKHTW9OR9tKAgosd3eicqIoY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-jJGOPDryMfm7zjgIiYGnpQ-1; Tue, 09 Nov 2021 03:36:21 -0500
X-MC-Unique: jJGOPDryMfm7zjgIiYGnpQ-1
Received: by mail-ed1-f72.google.com with SMTP id o15-20020a056402438f00b003e32b274b24so6751981edc.21
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 00:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RzwlOsjDvkYyhCM1gJab6TYMZ2M+9RDPU7SdSVVR3oI=;
        b=iScEps3pfLAiIqUC46LS0O4IY1/IqaBE+It/x6/eIZYYUe9xKGjoSwvxTrjpvHydR7
         IIbGSPrtmqkw+nREufWCje3oA6wGB91c5Eopiil6/boRIRMKgVm5Xx/uMS2vyNvh3Y+E
         6c25EEAULC48SwosiYTA0Xx0fzFsZi5u3X8Gqf8mCk1Jp7ohdszeyje0G965InJAKq4T
         gljkVUwPaI9wcsrabA20BYkQ2/4bwiKTgx6ARx8eJrgP1ZqxqEOmCXoucHoKMogshRSo
         MoYUu5XR/CD3vCeaF077TUq06oa6SsP1/fgh+a3VxlntrP5EPekcvwoGygvorjgimRRG
         VAyQ==
X-Gm-Message-State: AOAM531sov6S0jvREtl2ElU6McShWKfi+jcdu6qPM8V1wbSisNx6bApX
        /AFO91BDg5HfU0sJFyvR9CxNb6xRJjhmiG/seGOIVWrtbNQ2Q0+FC2PDsxIOWCodBs1S0WsSHuz
        pa47L0NIXOrEZ7ZfKh+5UkwiC
X-Received: by 2002:a17:906:c1da:: with SMTP id bw26mr7575585ejb.253.1636446979423;
        Tue, 09 Nov 2021 00:36:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZQjmIDFIZSXK5GNaT54dl0XMyyAGc9Lyjn4PPicewcZayTjDr5/I3gOLAIGYn1e8nEeMKCg==
X-Received: by 2002:a17:906:c1da:: with SMTP id bw26mr7575557ejb.253.1636446979214;
        Tue, 09 Nov 2021 00:36:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q14sm10574161edj.42.2021.11.09.00.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 00:36:18 -0800 (PST)
Message-ID: <57d8356c-e5f7-b23b-7efe-0be831f3d8c2@redhat.com>
Date:   Tue, 9 Nov 2021 09:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mfd: intel_soc_pmic: Use CPU-id check instead of _HRV
 check to differentiate variants
Content-Language: en-US
To:     Tsuchiya Yuto <kitakar@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211107172641.288491-1-hdegoede@redhat.com>
 <CAHp75Vd+pUGjrW2YxmaKoVehnDLSMPmGt4_45K6g0g7qRg5Smw@mail.gmail.com>
 <c9ab85031655a8c1f07e2c30f4bf9b2e1dadf1e2.camel@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <c9ab85031655a8c1f07e2c30f4bf9b2e1dadf1e2.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/9/21 04:23, Tsuchiya Yuto wrote:
> On Sun, 2021-11-07 at 20:17 +0200, Andy Shevchenko wrote:
>> On Sun, Nov 7, 2021 at 7:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> The Intel Crystal Cove PMIC has 2 different variants, one for use with
>>> Bay Trail (BYT) SoCs and one for use with Cherry Trail (CHT) SoCs.
>>>
>>> So far we have been using an ACPI _HRV check to differentiate between
>>> the 2, but at least on the Microsoft Surface 3, which is a CHT device,
>>> the wrong _HRV value is reported by ACPI.
>>>
>>> So instead switch to a CPU-ID check which avoids us relying on the
>>> possibly wrong ACPI _HRV value.
>>
>> Thanks, I hope Tsuchiya will test this soon, from code perspective it
>> looks good to me,
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Hi, thank you for the patch. I tried this patch (plus the patch ("ASoC:
> Intel: Move soc_intel_is_foo() helpers to a generic header") [1],

Right, this patch needs to be applie don top of the upcoming v5.16-rc1
which has that patch, I wanted to mention that but I forgot.

> which
> this patch needs) on my Surface 3 and can confirm it's using CHT variant
> of Crystal Cove PMIC driver as expected.
> 
> Tested-by: Tsuchiya Yuto <kitakar@gmail.com>

Thank you.

Regards,

Hans



> 
> [1] https://lore.kernel.org/all/20211018143324.296961-2-hdegoede@redhat.com/
> 
>>> Reported-by: Tsuchiya Yuto <kitakar@gmail.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>  drivers/mfd/intel_soc_pmic_core.c | 28 +++-------------------------
>>>  1 file changed, 3 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
>>> index ddd64f9e3341..47cb7f00dfcf 100644
>>> --- a/drivers/mfd/intel_soc_pmic_core.c
>>> +++ b/drivers/mfd/intel_soc_pmic_core.c
>>> @@ -14,15 +14,12 @@
>>>  #include <linux/module.h>
>>>  #include <linux/mfd/core.h>
>>>  #include <linux/mfd/intel_soc_pmic.h>
>>> +#include <linux/platform_data/x86/soc.h>
>>>  #include <linux/pwm.h>
>>>  #include <linux/regmap.h>
>>>
>>>  #include "intel_soc_pmic_core.h"
>>>
>>> -/* Crystal Cove PMIC shares same ACPI ID between different platforms */
>>> -#define BYT_CRC_HRV            2
>>> -#define CHT_CRC_HRV            3
>>> -
>>>  /* PWM consumed by the Intel GFX */
>>>  static struct pwm_lookup crc_pwm_lookup[] = {
>>>         PWM_LOOKUP("crystal_cove_pwm", 0, "0000:00:02.0", "pwm_pmic_backlight", 0, PWM_POLARITY_NORMAL),
>>> @@ -34,31 +31,12 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
>>>         struct device *dev = &i2c->dev;
>>>         struct intel_soc_pmic_config *config;
>>>         struct intel_soc_pmic *pmic;
>>> -       unsigned long long hrv;
>>> -       acpi_status status;
>>>         int ret;
>>>
>>> -       /*
>>> -        * There are 2 different Crystal Cove PMICs a Bay Trail and Cherry
>>> -        * Trail version, use _HRV to differentiate between the 2.
>>> -        */
>>> -       status = acpi_evaluate_integer(ACPI_HANDLE(dev), "_HRV", NULL, &hrv);
>>> -       if (ACPI_FAILURE(status)) {
>>> -               dev_err(dev, "Failed to get PMIC hardware revision\n");
>>> -               return -ENODEV;
>>> -       }
>>> -
>>> -       switch (hrv) {
>>> -       case BYT_CRC_HRV:
>>> +       if (soc_intel_is_byt())
>>>                 config = &intel_soc_pmic_config_byt_crc;
>>> -               break;
>>> -       case CHT_CRC_HRV:
>>> +       else
>>>                 config = &intel_soc_pmic_config_cht_crc;
>>> -               break;
>>> -       default:
>>> -               dev_warn(dev, "Unknown hardware rev %llu, assuming BYT\n", hrv);
>>> -               config = &intel_soc_pmic_config_byt_crc;
>>> -       }
>>>
>>>         pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
>>>         if (!pmic)
>>> --
>>> 2.31.1
>>>
>>
>>
> 
> 

