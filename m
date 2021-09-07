Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBDE40278C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 13:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344103AbhIGLEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 07:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343926AbhIGLEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 07:04:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6238C0613C1;
        Tue,  7 Sep 2021 04:03:13 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t19so18689246lfe.13;
        Tue, 07 Sep 2021 04:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vKynZzUyef3YEbHq6rjNYVfRAyAgOhwz7XpkeW0XvBo=;
        b=iLwpwvx3oyTuygSmzC3tMLhRmUiKw9d+jVgPB2yaZuAvuGFEzHIHqYzmM/Gtc28jNG
         LAPBQHxJxkAEp2q7fABzLugZB6xIhp2rTaBpU9DSD40OJhFLRaHs1zIvwfEWsnomOZxK
         SPVNGJT6Dy57z5I+eSF+6aZ0kwepxnC2HPCnqrke22o5+vjh9etaalm2YszkJWKynIp9
         GzjG7W0d/TLxyNQlK9xnr1mewEBsUrgeVr6oxn9jlXwv9OgbdqywhiCmxPnH2M/9p9zj
         qDfZpDmH6T3/Yr0GlxuLFqv8AJI7LCaWhsZnbarpz34P4JMU7DF1nDKs/lQob98gVSEU
         BoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vKynZzUyef3YEbHq6rjNYVfRAyAgOhwz7XpkeW0XvBo=;
        b=esWClOjJGXHVwbGsYpXPgySLckh+QFGAOjjxjzFdhlsb1BbEPHUmXdss8FOme4wS5w
         JwoQwQKWQ8LHrIj5CtudKvf84bWVsw/Ggi41yAFnVXuoUYQfOY4Bk8nW8oNZNdxDDqCa
         N3KzxRcmU7mHZWeTBn7Wty2bAfPITE6vF6grNPwUzxexSwiSmtUS7r0v/PaPxa/EF6z9
         auJRtrJVL7itzdLJdTj2CXSlBjMIhTdIoDRUX3ywAl7/2lyV/5iv/E0b/S/j5s43fWRU
         eu4TAE4N4KYXlrs7rJ1Z7R+xtBQH4u3OaQ/NKiARg4/p8d9MYV/E8IKxOF3Db4OySSL0
         p9Vw==
X-Gm-Message-State: AOAM532ZlFXLEXQtYfJuOdYW/PDsCIU5g8PS6SIj96xXX75LV6tfYP78
        VV4a6pLH65LN/ybYzaZjlxujOEgvXF0=
X-Google-Smtp-Source: ABdhPJzIIJov8vnuNIFcXuP0p4YJOjKfgpFpWLkWd1rKqsXVI8JMI9Zw/K1lHOveD8W2gYkcPJNZLA==
X-Received: by 2002:ac2:5391:: with SMTP id g17mr11613264lfh.371.1631012590574;
        Tue, 07 Sep 2021 04:03:10 -0700 (PDT)
Received: from [192.168.2.145] (46-138-3-129.dynamic.spd-mgts.ru. [46.138.3.129])
        by smtp.googlemail.com with ESMTPSA id q7sm1397806ljg.137.2021.09.07.04.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 04:03:09 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] ARM: multi_v7_defconfig: Add support for Airoha
 EN7523 SoC
To:     Bert Vermeulen <bert@biot.com>
Cc:     devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Olivier Moysan <olivier.moysan@st.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lionel Debieve <lionel.debieve@st.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210907102722.47543-1-bert@biot.com>
 <20210907102722.47543-6-bert@biot.com>
 <93abbefa-1ee6-7913-a41e-3e587e9a747a@gmail.com>
 <1a04688d-46fc-8885-feba-d2ffa532f2d9@biot.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a1e064f4-702f-c794-6a61-28608e7acadb@gmail.com>
Date:   Tue, 7 Sep 2021 14:03:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1a04688d-46fc-8885-feba-d2ffa532f2d9@biot.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.09.2021 13:41, Bert Vermeulen пишет:
> On 9/7/21 12:39 PM, Dmitry Osipenko wrote:
>> 07.09.2021 13:27, Bert Vermeulen пишет:
>>> From: John Crispin <john@phrozen.org>
>>>
>>> This enables basic bootup support for the Airoha EN7523 SoC.
>>>
>>> Signed-off-by: John Crispin <john@phrozen.org>
>>> Signed-off-by: Bert Vermeulen <bert@biot.com>
>>> ---
>>>  arch/arm/configs/multi_v7_defconfig | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm/configs/multi_v7_defconfig
>>> b/arch/arm/configs/multi_v7_defconfig
>>> index d9abaae118dd..a9370a95dc38 100644
>>> --- a/arch/arm/configs/multi_v7_defconfig
>>> +++ b/arch/arm/configs/multi_v7_defconfig
>>> @@ -31,6 +31,7 @@ CONFIG_MACH_BERLIN_BG2=y
>>>  CONFIG_MACH_BERLIN_BG2CD=y
>>>  CONFIG_MACH_BERLIN_BG2Q=y
>>>  CONFIG_ARCH_DIGICOLOR=y
>>> +CONFIG_ARCH_AIROHA=y
>>>  CONFIG_ARCH_EXYNOS=y
>>>  CONFIG_ARCH_HIGHBANK=y
>>>  CONFIG_ARCH_HISI=y
>>> @@ -983,6 +984,7 @@ CONFIG_STAGING_BOARD=y
>>>  CONFIG_MFD_CROS_EC_DEV=m
>>>  CONFIG_CROS_EC_I2C=m
>>>  CONFIG_CROS_EC_SPI=m
>>> +CONFIG_COMMON_CLK_EN7523=y
>>
>> If SoC doesn't work without clk support, then this option should be
>> auto-selected by the arch option.
>>
>> It also doesn't look like upstream kernel has COMMON_CLK_EN7523 at all.
> 
> Oops, you're right -- the clock driver is coming as soon as the base
> system is in. I guess this option (under ARCH_AIROHA) should come in at
> that time as well? I'll respin after some more comments.

Probably. You may also make clk driver to use ARCH_AIROHA option
directly if driver is supposed to be used only by that single arch, like
some other platform do that.
