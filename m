Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C40351280
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhDAJjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhDAJiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:38:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D36C0613E6;
        Thu,  1 Apr 2021 02:38:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j9so1121909wrx.12;
        Thu, 01 Apr 2021 02:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zqr07vO7upTy6e/RfoTA/s/3/fiA55XFyYEasLBQqAs=;
        b=p0kuOLQzv7pOsdzulIw0amiLHAVOfPGe5DwWjMeFJf5AzMxzaCYEMUgM9T3FypvUdv
         e/bMIZ8nI3hxskYZiOGabqQ4a+/Y2k/My3Yt/DKyaMyNASskHbtDMWQ3q8/7FH/ZPl4L
         ZCO3Q2Nu61go8RTQSXpvJB7nkG6W82+rnPyxrx29La6dgk2z/4Jg/y4LcEAmRJDzOMxu
         y5NUQuQIkAkl+CMJ8ZpHUU48CBTdBLBgCE5jpe8XiDZI+GB6tGs2zefrZXHfZl/bREwq
         VlowOiql+sUl6pTygLI9Fh98sNyvqagzrvW29OPzuieF3oUykBrV6XSh0h718fGf8Znv
         kriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zqr07vO7upTy6e/RfoTA/s/3/fiA55XFyYEasLBQqAs=;
        b=drY/OHU4H66uXTe6HY1W17InV+EaE9bqf6HvvEPh0bwtFAI9uEm1m+1vz3f0Gv3jZh
         5wdVqC3oyq03AenYry2zEilJ30hyL55fek17oADMBZahFOiUbJ668hKm8pwi6WcCJ4Ma
         RMN8/L/AFgSln6nQyiFPZpy0Ejz+c+Gyca/1qVPX8LO80r5Cora+m/HAFR4RxTvTbLaq
         ee626qCCyRu2gh5Rz32sA8f2NlziwWZIcKCJfEOU/lI09nE7i7+TSmI9vGEE0pV269vo
         vzeOQ4amvX5Ks25UCgJzZG6GTnKA4deKGu/Estwp7IBYhu6QnjuAk5ekqQ+lucPRcZSY
         KrSQ==
X-Gm-Message-State: AOAM530a4zI0BaaiaAkFH/D/HF44Hw7ECmctQw2MabmwUSz70JYrOUsf
        7D7Wxr1CbkEw2ZESg/TzZKc=
X-Google-Smtp-Source: ABdhPJweFebP/Y9EsngFkTBEoYEMOAIhx/IutptK0Pf+C/0UMSu2/tnCwPdU/DZEPTl2HAr4BMnZeA==
X-Received: by 2002:adf:f587:: with SMTP id f7mr8572552wro.147.1617269925248;
        Thu, 01 Apr 2021 02:38:45 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id k4sm12625016wrd.9.2021.04.01.02.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 02:38:44 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: mt8183: Add power-domains properity to mfgcfg
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
References: <20210224091742.1060508-1-ikjn@chromium.org>
 <CAFqH_50BWF4sQnJAnVZDf3Dbuw+LaN67q39DvOh7ipzqNeNEMw@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <6df6486e-89fc-6ea8-2b36-59e2bf49eb3a@gmail.com>
Date:   Thu, 1 Apr 2021 11:38:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAFqH_50BWF4sQnJAnVZDf3Dbuw+LaN67q39DvOh7ipzqNeNEMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/02/2021 11:30, Enric Balletbo Serra wrote:
> Hi Ikjoon,
> 
> Thank you for your patch.
> 
> Missatge de Ikjoon Jang <ikjn@chromium.org> del dia dc., 24 de febr.
> 2021 a les 10:21:
>>
>> mfgcfg clock is under MFG_ASYNC power domain
>>
>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
>> ---
>>
>>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> index 5b782a4769e7..3384df5284c0 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> @@ -962,6 +962,7 @@ mfgcfg: syscon@13000000 {
>>                         compatible = "mediatek,mt8183-mfgcfg", "syscon";
>>                         reg = <0 0x13000000 0 0x1000>;
>>                         #clock-cells = <1>;
>> +                       power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_ASYNC>;
> 
> I don't think this will work in mainline, at least, the reference name
> should be &spm
> 

Correct. Would you mind to resend with the comment from Enric. Apart from that,
patch looks fine to me.

Regards,
Matthias

> Thanks,
>   Enric
>>                 };
>>
>>                 mmsys: syscon@14000000 {
>> --
>> 2.30.0.617.g56c4b15f3c-goog
>>
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
