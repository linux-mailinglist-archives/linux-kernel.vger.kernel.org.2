Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2715375108
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 10:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhEFIsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 04:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21690 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233374AbhEFIsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 04:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620290838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1NN9EUz0j96iBpqR91xd/VX+5RiWkzOOBjSXyS+e2QQ=;
        b=V/az1mZiHo9vgol7L8A/5FBS+z4Qf4OGJkZILO2qOsm3joXe05QGyx7/zaAICbdtQ3XGCo
        QFP3cyyqX+BBQDqhWV+06AJQciGc8BB8NqtHDQQG1PGudpSoSynR1P8ZKOo7wgdikixCp+
        Jez/+9FDl27Fy3yGXOvqG12NFRYsIyI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-bOH2saLFO0CvM4B_pyqqXg-1; Thu, 06 May 2021 04:47:17 -0400
X-MC-Unique: bOH2saLFO0CvM4B_pyqqXg-1
Received: by mail-ej1-f71.google.com with SMTP id ne22-20020a1709077b96b02903803a047edeso1433900ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 01:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1NN9EUz0j96iBpqR91xd/VX+5RiWkzOOBjSXyS+e2QQ=;
        b=lDvG1GFo45DXRbITaN+0ViVJbzuHiZAos23vkbQCGT6kn7dWALMe/NK/hx+X/816vg
         Q29RJ1L0lshgHOUBNPFaisjCRuFBbr90jDj6LgplI87OoILyQdMG7HVwDgZTG2bHDDI0
         qnSaPBYRL1cDz9bKyxNCETFFzqnRAzdLroVmXC5WXSxXWB/lYKpieZ+Mds4i1vtdAygN
         S6dZq5P9l9JHo53elRwlbxKq59CczSxd4FVEj1BINYFEZW9EBdVpzVlcKsuIX7kz8Sgr
         RBUIxUQixZuUPqjYwwnAoMLn9YIqC/e3Iz/SPZJ4iPMZad8WmmMRjnfDV0K3tHN+YX0L
         DmNw==
X-Gm-Message-State: AOAM532jOWtcQL6SUZtr/6EZBSSxVzpS34Y5kefnHhyrPtx2lagKJ7nc
        9KyUDSy9fZktshX3aK5sMI9wP5qPS9PqXEvwYEl4wpHYCd1kRVwiE3sSbtWSERG+7kbvHyteGPh
        aVt8DqWvDnsAhtEA6lOo5+hmj
X-Received: by 2002:a17:906:d1ce:: with SMTP id bs14mr3198247ejb.183.1620290835687;
        Thu, 06 May 2021 01:47:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBMH3p+EN/AiZfi8qCXlKwD+9AP2qTp5z5o+WvRTwM+oObTc4V8+R8N/Juvhk/5erCUtMo9g==
X-Received: by 2002:a17:906:d1ce:: with SMTP id bs14mr3198235ejb.183.1620290835528;
        Thu, 06 May 2021 01:47:15 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id v14sm1125058edx.5.2021.05.06.01.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 01:47:15 -0700 (PDT)
Subject: Re: [v3,1/1] adv_mix955x is a scheme that multiplexes PCA9554/PCA9555
 into LED and GPIO
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?B?eXVlY2hhby56aGFvKOi1tei2iui2hSk=?= 
        <yuechao.zhao@advantech.com.cn>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Campion Kang <campion.kang@advantech.com.tw>
Cc:     "345351830@qq.com" <345351830@qq.com>,
        =?UTF-8?B?UmFpbmJvdy5aaGFuZyjlvLXnjokp?= 
        <Rainbow.Zhang@advantech.com.cn>,
        =?UTF-8?B?eXVueGlhLmxpKOadjuS6kemcnik=?= 
        <yunxia.li@advantech.com.cn>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        =?UTF-8?B?SmlhLlN1aSjotL7nnaIp?= <Jia.Sui@advantech.com.cn>,
        Mark Gross <mgross@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <tencent_F8EEB847E2CD8A6813D0BF4863964CDF3508@qq.com>
 <b787cd95ad7746d9a04e8cd7f6c0b645@ACNMB2.ACN.ADVANTECH.CORP>
 <CAHp75Vce_-m5uXgpyRO300M1Vw8DX2BmnBPsF5OaUK2_hNDb_A@mail.gmail.com>
 <DFBFA86F-1A66-4351-9987-C63CCB40D82A@advantech.com.cn>
 <ec4da512-76c7-acec-f41d-179fd469b615@redhat.com>
Message-ID: <f72fd002-97f7-c121-4230-aa084f054680@redhat.com>
Date:   Thu, 6 May 2021 10:47:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ec4da512-76c7-acec-f41d-179fd469b615@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/5/21 3:23 PM, Hans de Goede wrote:
> Hi,
> 
> On 5/3/21 3:16 PM, yuechao.zhao(赵越超) wrote:
>> Hi Andy
>> Sorry for the late reply
>>
>> The reason for writing this driver is that our customers hope that the LED and GPIO can be used out of the box
>> When they using our X86-Platform
>>
>> About the document and ACPI expert, I will provide them after I improve them. Please wait for a few days.
> 
> So my initial assessment of this code matches Andy's I don't like the idea
> of duplicating the GPIO chip functionality from drivers/gpio/gpio-pca953x.c here.
> 
> I understand that you want to have things working out of the box and I believe
> that we all agree that that is what we want.
> 
> But you can get there without duplicating the code.
> 
> We already have cases where there is an I2C device with an existing driver
> where we need some "glue" code to translate the ACPI provided info to
> what the i2c drivers expect, some examples of these are:
> 
> drivers/platform/x86/i2c-multi-instantiate.c
> drivers/platform/x86/intel_cht_int33fe_typec.c
> 
> So what you need to do is basically start writing a completely new driver
> which:
> 
> 1. Instantiates an i2c-client for the drivers/gpio/gpio-pca953x.c driver
> to bind to.
> 
> 2. Creates and attaches software-fwnodes which provide info for the 
> drivers/leds/leds-gpio.c code to parse and have that code instantiate
> LED class devices which drive the leds through the GPIO interface
> offered by the drivers/gpio/gpio-pca953x.c driver.

I just saw the "Advantech AHC1EC0 embedded controller" patch series
posted by your colleague Campion Kang (added to the Cc) it seems that
that series is using devicetree config bits embedded inside the ACPI
tables. If you can still change / update the ACPI tables then perhaps
using that would be an option here too ?  And then just include the
whole GPIO LED descriptions inside the embedded devicetree bits.

Regards,

Hans



>> ﻿在 2021/5/2 下午6:50，“Andy Shevchenko”<andy.shevchenko@gmail.com> 写入:
>>
>>     On Fri, Apr 30, 2021 at 8:27 AM yuechao.zhao(赵越超)
>>     <yuechao.zhao@advantech.com.cn> wrote:
>>     >
>>     > From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
>>     >
>>     > With this driver, we can multiplex PCA9554/PCA9555 into LED and GPIO
>>     > based on the ACPI data of BIOS.
>>
>>     NAK as per v2.
>>
>>     Please, add a proper documentation and show ACPI excerpt, and last but
>>     not least is missing justification.
>>
>>
>>     -- 
>>     With Best Regards,
>>     Andy Shevchenko
>>

