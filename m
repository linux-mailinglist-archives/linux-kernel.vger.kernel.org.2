Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D76532BADE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358411AbhCCMGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451608AbhCCGKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 01:10:22 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B25C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 22:09:42 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m1so5047090wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 22:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4qCl2xTMEnGwHMZihEf6F2RLD0MFzn8n767BOSW3ZLY=;
        b=BTDWTl9GOreLmZ99H7YpSxoCsdIGP0UpXFOj2rko3R8s/1aCDQBa6S1fXptXgN++5r
         31JbnhHu89/UMruITL6C+lfaQrZE+7uoAeu6wPNHKmXObekmOYkWEgKXr38xJOYG3hsL
         U7fc61CHWHQN/ko9psybOPR080Wh1/hs6X3KC6pzgVa2ay3jYnrd8ykDcFoQW8GusOnu
         1+jJ9S9Xi1yqm112/oUxVOWYVifzj6voHwgw3r/itHtjDN9I+8kk2Zo4Fwbg02f8kEWu
         SEjA/AuxYZaUEgASqOzdLkqs7Ngw1eU70gzI6/RZw52edxiNoQ1GsItvf57utuDCbjNK
         62eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4qCl2xTMEnGwHMZihEf6F2RLD0MFzn8n767BOSW3ZLY=;
        b=H+Wc50htuCKxbfmVj1yZ0uNkOssQ+w5t4H/3PoU21cfVgR0V6jhtq7ZxLhXYRNkCjg
         wPiK4gHukKeZlAJJKY9YLGgwQMgZSBvpRBl6IwVxRRnX0OQRJNwuMCo7/O/A6q+lPB45
         +vavKiIlWOpYN0+HLgWwAaYfB2nsyUpsbLRXoEenoFvulVwenDGXrINuy3Fo9Dk2xl9N
         bf6NzCGJWmaG0T+pXQFtouHUwZ0DhRM6BHbjAhIyhjI0db9sBHgVNXG/tJtM2pgUVAwg
         HJQI+6MXN3ktiRn5KxzrdRenJxs3fvIx/6j2uHEBjdGBe6SmRK1WxIlVgkVzN5+1MNb7
         dPAw==
X-Gm-Message-State: AOAM5338q2XIKn6botwnbkGwQUGSnSDOBWwOWG8iSwidQlXTWGBGyKjC
        7mrI0vZgLxi8wG6RUJhOmvdksw==
X-Google-Smtp-Source: ABdhPJyATzAN6BDlUtwLGCxJi1UOsYOTLnb1sE8MN9Ef75tsKP+GyZxuwvb1JuD/r1uQUvdtXGO73A==
X-Received: by 2002:a7b:c7ca:: with SMTP id z10mr1307886wmk.117.1614751780934;
        Tue, 02 Mar 2021 22:09:40 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id u20sm4088170wru.6.2021.03.02.22.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 22:09:40 -0800 (PST)
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
 <e44809f1-63a6-8c8b-a05f-52516fb2141f@linaro.org>
 <YD8hNs98g172DiF8@vkoul-mobl>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <207d37f7-f99f-03ab-7914-d2b82977a95f@linaro.org>
Date:   Wed, 3 Mar 2021 07:09:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YD8hNs98g172DiF8@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2021 06:40, Vinod Koul wrote:
> On 02-03-21, 18:03, Daniel Lezcano wrote:
>> On 02/03/2021 17:32, Vinod Koul wrote:
>>> On 24-02-21, 15:42, Daniel Lezcano wrote:
>>>> HZ unit conversion macros are available in units.h, use them and
>>>> remove the duplicate definition.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>>  drivers/phy/st/phy-stm32-usbphyc.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
>>>> index a54317e96c41..02dd12bb4692 100644
>>>> --- a/drivers/phy/st/phy-stm32-usbphyc.c
>>>> +++ b/drivers/phy/st/phy-stm32-usbphyc.c
>>>> @@ -14,6 +14,7 @@
>>>>  #include <linux/of_platform.h>
>>>>  #include <linux/phy/phy.h>
>>>>  #include <linux/reset.h>
>>>> +#include <linux/units.h>
>>>>  
>>>>  #define STM32_USBPHYC_PLL	0x0
>>>>  #define STM32_USBPHYC_MISC	0x8
>>>> @@ -48,7 +49,6 @@ static const char * const supplies_names[] = {
>>>>  #define PLL_FVCO_MHZ		2880
>>>>  #define PLL_INFF_MIN_RATE_HZ	19200000
>>>>  #define PLL_INFF_MAX_RATE_HZ	38400000
>>>> -#define HZ_PER_MHZ		1000000L
>>>
>>> I dont see this in units.h, can you send this once it is merged upstream
>>
>> Actually, it is the first patch of the series.
>>
>> I asked Rafael if he can merge the entire series.
> 
> Pls cc folks on cover at least so that they are aware.

Yeah, sorry for that. I tend to rely too much on the default 'cccmd'.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
