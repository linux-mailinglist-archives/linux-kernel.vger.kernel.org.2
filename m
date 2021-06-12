Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5323A4DE3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhFLJZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 05:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFLJZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 05:25:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58A6C061574;
        Sat, 12 Jun 2021 02:23:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so9946540wmg.4;
        Sat, 12 Jun 2021 02:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SLFVhursGu66Uj/3K3eYasv4quV8R1dSmz2H6vx5rpU=;
        b=WK28YEY+mxu0dajuAkqICfBIey1HTQatNZpyxGFo9qbiP9NBSr6fYEGQvGgZht6PvO
         zgZ3hO18JVXKaAmM5D+5Inm/QkSMB7qXQbOQMcjwXtI7AAGd9Ds6z+FYgTdRksPvHV9K
         NRddoj35bs0eD2qSjrmIN2XTtz9Sj39v/8mp/NQ0Hiizde9SEIpqONigfIa8lP7VWcFS
         +/oUqFA8gS2wSPDguVPykI/8tTIbcYVfG8Q7ozpdmng2VRC6U5s/yctnI7Y+29vn4FV5
         ajmyKmYRbD4drWDkWw9aUhJJtnFT2ke+bxA1q0v9yiwYG/hvWurJMQqq5/CXSvr/AVqv
         ohFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SLFVhursGu66Uj/3K3eYasv4quV8R1dSmz2H6vx5rpU=;
        b=gMSYslX46VfJUMyJo7w+qr8vTf/DU4chNO+JQ5nyYcUyyMTg9He65XOIJ6hp43YV3U
         WY5oi67b4cRJk4zttt1eR2PD0LZuHeWJ0Lly12SyNlMcUwkXJIFFjfe71QKkMQs+n0lF
         eH5pDxdZPVv9Sx+5BeE/bnFGtTm5krQnMtbbWS3bsdmlymz8uo5zD7iR1AoZIhb4iw5J
         lWodxwgsYOH+waFMs5tJ3Ztb7sDkDDuUvGsTE4a3dGa5BWz+3FSR8VO6VyXkTk/m+lo1
         NsLjxPv73efSh3DQ56QVTzij/UiWOkZlnHaybVp+VBeWeXNkTPWdN/dqSdtQQR/KkpIZ
         lYGw==
X-Gm-Message-State: AOAM533YV8fBpcaWomcOFM/cZi0+WdA7diaG+Dt7XR/0g6+xH1/Vlp2J
        BrbfIxF3/zqTM/F+3V6CZeU=
X-Google-Smtp-Source: ABdhPJzgicMpzLh5bZMPsx62eBNKrcy04WIKYCttKwTTO0YhKS4Ms+svmfp8nsdqmDgGKwUZ4BIHQw==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr24077747wmj.180.1623489788393;
        Sat, 12 Jun 2021 02:23:08 -0700 (PDT)
Received: from localhost.localdomain (haganm.plus.com. [212.159.108.31])
        by smtp.gmail.com with ESMTPSA id a3sm10262253wra.4.2021.06.12.02.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jun 2021 02:23:08 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] ARM: dts: NSP: Add Meraki MX64/MX65 to Makefile
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210610232727.1383117-1-mnhagan88@gmail.com>
 <20210610232727.1383117-3-mnhagan88@gmail.com>
 <20210611202434.flnqrzbbxicw5c3t@skbuf>
From:   Matthew Hagan <mnhagan88@gmail.com>
Message-ID: <e9d5fffd-4483-8342-c97e-a115894ca93b@gmail.com>
Date:   Sat, 12 Jun 2021 10:23:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210611202434.flnqrzbbxicw5c3t@skbuf>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/06/2021 21:24, Vladimir Oltean wrote:
> On Fri, Jun 11, 2021 at 12:27:14AM +0100, Matthew Hagan wrote:
>> Add Makefile entries for the Meraki MX64/MX65 series devices.
>>
>> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
>> ---
>>  arch/arm/boot/dts/Makefile | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index f8f09c5066e7..033d9604db60 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -154,6 +154,12 @@ dtb-$(CONFIG_ARCH_BCM_NSP) += \
>>  	bcm958525xmc.dtb \
>>  	bcm958622hr.dtb \
>>  	bcm958623hr.dtb \
>> +	bcm958625-meraki-mx64.dtb \
>> +	bcm958625-meraki-mx64-a0.dtb \
>> +	bcm958625-meraki-mx64w.dtb \
>> +	bcm958625-meraki-mx64w-a0.dtb \
>> +	bcm958625-meraki-mx65.dtb \
>> +	bcm958625-meraki-mx65w.dtb \
>>  	bcm958625hr.dtb \
>>  	bcm988312hr.dtb \
>>  	bcm958625k.dtb
>> -- 
>> 2.26.3
>>
> It is odd to add the device trees to the Makefile in a separate patch
> compared to their actual introduction. Does the tree even compile at
> this stage?

Will rectify this. Thanks!

