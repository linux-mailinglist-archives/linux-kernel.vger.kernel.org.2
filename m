Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D12032AA6B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581905AbhCBT2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579863AbhCBRLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:11:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74624C061226
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 09:03:26 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o2so2986187wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 09:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FSLB6bwvcceEbYUIq7Kx78eQMei40IgrAI2OU/cApK0=;
        b=bOsWX3IkRuVjIW/3Rb02KgbgfXirqc+6uiUMTGwkCN3XDS4HQQkXb7GqB6Mbg5IajP
         bEba5IuO4g4zOL9bOQIIuBDcdjv1L+jE7NzIJdqLrj6f4Vj6eQWEcSYpuToTBQkUK1Ke
         zQy2O6wz9NbCW8+Xq0eMfTDs6uW0jTmHPq2W8A0Wkys6h3BN3SzdZEQNXcUR3Ekv8/zz
         1y3z6oQUq6Dzv/4b2CvUGlpx2jdiU0xi52XvZH4CXVvLrxwI6icDW90tjiCnoKDuefwH
         5hsex/v/B2FHf7sM1KoW4sz234J/7dShqxjXV6MpyopRkSsJOZ9DTCtSypv9VsoTP9vB
         sVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FSLB6bwvcceEbYUIq7Kx78eQMei40IgrAI2OU/cApK0=;
        b=cUr9lghAKTyx+nF8Vc2jvvikErnzqT80OEkHM6KH5r+k23+NRu5HbEdGTYb2L6KlcQ
         juhH86miua5tgGClHb/u4jnmxiKamEXW6Vfk4R9JWDMhxwMa5LrZYi/3r0jEaUYn7NwA
         hPuE6fOBGZuz4YMOsO2qWeuevD6paT+hQ4/xWux1NuKjCfwHfkCuxcNoD3w8aUfmGRaV
         Xff4FbLYlgLo08q3NIH1bt6E0uM0zilcJXMH0/WlG8mvDt7YsipVo1sL/BqUQ1bcIQEp
         G8Jc0fsQC3XZ4sSC1D4Sv8+mZGnYKFIzIpkg4F0f3X69guUJX0hm8VjCaWWhLd2Jtsvu
         YbkQ==
X-Gm-Message-State: AOAM531PMqQmoiVMHUTz9VHxHFgzYniRkKaDC1mlZqJ268Et63Dj5oRA
        05QhAP6pDj3zUEPzEWtPe+UVeg==
X-Google-Smtp-Source: ABdhPJzvAINR+SaWATC/3ozKIK+bgArnfBET/ow62+RdQBcc5eOgV9EchW3VcrZ84iFTERtdnPHikw==
X-Received: by 2002:a1c:a543:: with SMTP id o64mr4999421wme.107.1614704605010;
        Tue, 02 Mar 2021 09:03:25 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id j20sm2878076wmp.30.2021.03.02.09.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 09:03:24 -0800 (PST)
Subject: Re: [PATCH v2 9/9] phy/drivers/stm32: Use HZ macros
To:     Vinod Koul <vkoul@kernel.org>
Cc:     rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Etienne Carriere <etienne.carriere@st.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
 <20210224144222.23762-9-daniel.lezcano@linaro.org>
 <YD5olWDZ50sLVn7w@vkoul-mobl>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e44809f1-63a6-8c8b-a05f-52516fb2141f@linaro.org>
Date:   Tue, 2 Mar 2021 18:03:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YD5olWDZ50sLVn7w@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2021 17:32, Vinod Koul wrote:
> On 24-02-21, 15:42, Daniel Lezcano wrote:
>> HZ unit conversion macros are available in units.h, use them and
>> remove the duplicate definition.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/phy/st/phy-stm32-usbphyc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
>> index a54317e96c41..02dd12bb4692 100644
>> --- a/drivers/phy/st/phy-stm32-usbphyc.c
>> +++ b/drivers/phy/st/phy-stm32-usbphyc.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/of_platform.h>
>>  #include <linux/phy/phy.h>
>>  #include <linux/reset.h>
>> +#include <linux/units.h>
>>  
>>  #define STM32_USBPHYC_PLL	0x0
>>  #define STM32_USBPHYC_MISC	0x8
>> @@ -48,7 +49,6 @@ static const char * const supplies_names[] = {
>>  #define PLL_FVCO_MHZ		2880
>>  #define PLL_INFF_MIN_RATE_HZ	19200000
>>  #define PLL_INFF_MAX_RATE_HZ	38400000
>> -#define HZ_PER_MHZ		1000000L
> 
> I dont see this in units.h, can you send this once it is merged upstream

Actually, it is the first patch of the series.

I asked Rafael if he can merge the entire series.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
