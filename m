Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663023E2AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 14:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241760AbhHFMuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 08:50:25 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:51302
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343816AbhHFMsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 08:48:41 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 20B484064A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 12:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628254105;
        bh=+iMOfeE6Vf9NGHS30HYXv4eokVZ3e25K5G9GYGN0DC8=;
        h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=WqvaRauOWhO/kq67C1Wcqr/0CrxxntpgAfIBUjyF1v0XquXJUOPMcvjG0trXFxWef
         BjSiJNVGNx7HkBEKWBw13wdIAIZIdn4+PnzZI8PWG4MHtLaUI2xHUOBvgQ8LlAZqjA
         fK9hQDg4yFd6RhFURvJFF0BuvbfY3dmtylHPcrdYnfodE4n/hEumamZnRHCT7HnCAR
         V/p0AN3ryXxrRyBwiv3DzR4Urj834uN2FqX1HThgguvazMC2Ymmo/zEGAYzwrblDjk
         geklryHbfGdoosrl8cLU+wLtx3F1XBnlbLSV2UzjAYIyA4u02u5dCSCScVbesF7+PW
         Lu3HCuDDSQlog==
Received: by mail-ej1-f71.google.com with SMTP id n9-20020a1709063789b02905854bda39fcso1276141ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 05:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+iMOfeE6Vf9NGHS30HYXv4eokVZ3e25K5G9GYGN0DC8=;
        b=FRwJVDA90bnp7MDP+/vI+HfioZmeN/qO6xWEyaPqmtO6UTLJTQXZg6udDB7fT/5rAl
         ZuBbl2KCOOZqB2U4pK2NZLa1susvG/7sc/7WCMgfDge2hYOlEcDSv45+xfEwdGK41ojm
         hcpTw/cC2FyBB7Qv0wXNIbKqZ7/xh/JFF3T6vutVnVTGZWwdamRT6bBkpwhYLqmf8zkN
         Pp/5u/P09lUnnYxD4CAKRpt6hVnf5HLeWhixNTQhMEn8hQXzn6tfMhObTEdeRC3oUlq0
         FtLVeZXqipYeMjJpzSteB02LVJcyQlZDTjyxsIjo4LiZDLXWZKj9zFzaHRDYydnGvTbb
         u4GQ==
X-Gm-Message-State: AOAM530w9wbBc7pGq7j57OB7mHO2dG1TzQNb51CxLBv5kdaS1m2qAjwv
        DZYP+oj6KPDyU+nfuseWg168MENZKre+b0ikdDQZnCvDT7F7/RKdza5LigLfnRsKOr3fmorllDw
        NAxbcHmDAlmeOXEMtcTMLwO7x04EUoEIc88RYWxMGhw==
X-Received: by 2002:a17:906:2dc5:: with SMTP id h5mr9916674eji.515.1628254094625;
        Fri, 06 Aug 2021 05:48:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyw0Ophi5VEEXPM4XZ0YWYJmokSCe46iXLol1mXc81JTaSdAe1qWBzFoVyacX3XeKr/xC3Vqg==
X-Received: by 2002:a17:906:2dc5:: with SMTP id h5mr9916653eji.515.1628254094423;
        Fri, 06 Aug 2021 05:48:14 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id lw22sm2849189ejb.74.2021.08.06.05.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 05:48:13 -0700 (PDT)
Subject: Re: [PATCH 12/12] arm64: dts: exynos: Add Exynos850 SoC support
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
 <20210730144922.29111-13-semen.protsenko@linaro.org>
 <455cfb5e-dff7-a5c0-3875-49abe3e900f3@canonical.com>
 <CAPLW+4nDS0atrbUFagDA0W_Ky5MvOiY+N+NQoQ+me4pndp_iWg@mail.gmail.com>
 <68734f6c-fc76-595c-8d34-8924dbbbb845@canonical.com>
 <CAPLW+4n_JKj5xeBHXONcv__vyAFvx3fhXoxJa17NTHK1RSJFJw@mail.gmail.com>
 <b753796c-2ce6-4166-7c20-289e950237ad@canonical.com>
Message-ID: <bb08f7a4-1da9-fb20-f091-6a3c37a1f898@canonical.com>
Date:   Fri, 6 Aug 2021 14:48:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b753796c-2ce6-4166-7c20-289e950237ad@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2021 14:32, Krzysztof Kozlowski wrote:
> On 06/08/2021 14:07, Sam Protsenko wrote:
>> On Fri, 6 Aug 2021 at 10:49, Krzysztof Kozlowski
>> <krzysztof.kozlowski@canonical.com> wrote:
>>>
>>> On 06/08/2021 01:06, Sam Protsenko wrote:
>>>> On Sat, 31 Jul 2021 at 12:03, Krzysztof Kozlowski
>>>> <krzysztof.kozlowski@canonical.com> wrote:
>>>>
>>>>>>
>>>>>> This patch adds minimal SoC support. Particular board device tree files
>>>>>> can include exynos850.dtsi file to get SoC related nodes, and then
>>>>>> reference those nodes further as needed.
>>>>>>
>>>>>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>>>>>> ---
>>>>>>  .../boot/dts/exynos/exynos850-pinctrl.dtsi    | 782 ++++++++++++++++++
>>>>>>  arch/arm64/boot/dts/exynos/exynos850-usi.dtsi |  30 +
>>>>>>  arch/arm64/boot/dts/exynos/exynos850.dtsi     | 245 ++++++
>>>>>
>>>>> Not buildable. Missing Makefile, missing DTS. Please submit with initial
>>>>> DTS, otherwise no one is able to verify it even compiles.
>>>>>
>>>>
>>>> This device is not available for purchase yet. I'll send the patch for
>>>> board dts once it's announced. I can do all the testing for now, if
>>>> you have any specific requests. Would it be possible for us to review
>>>> and apply only SoC support for now? Will send v2 soon...
>>>
>>> What you propose is equal to adding a driver (C source code) without
>>> ability to compile it. What's the point of having it in the kernel? It's
>>> unverifiable, unbuildable and unusable.
>>>
>>
>> Yes, I understand. That's adding code with no users, and it's not a
>> good practice.
>>
>>> We can review the DTSI however merging has to be with a DTS. Usually the
>>> SoC vendor adds first an evalkit (e.g. SMDK board). Maybe you have one
>>> for Exynos850? Otherwise if you cannot disclose the actual board, the
>>> DTSI will have to wait. You can submit drivers, though.
>>>
>>
>> Sure, let's go this way. I'll send v2 soon. Improving patches and
>> having Reviewed-by tag for those would good enough for me at this
>> point. I'll continue to prepare another Exynos850 related patches
>> until the actual board is announced, like proper clock driver, reset,
>> MMC, etc. Is it ok if I send those for a review too (so I can fix all
>> issues ahead)?
> 
> Sure, prepare all necessary drivers earlier. I suspect clocks will be a
> real pain because of significant changes modeled in vendor kernel. I
> remember Paweł Chmiel (+Cc) was doing something for these:
> https://github.com/PabloPL/linux/tree/exynos7420
> 
> I mentioned before - you should also modify the chipid driver. Check
> also other drivers in drivers/soc/samsung, although some are needed only
> for suspend&resume.
> 

You can also take a look at Exynos8895 efforts:
https://github.com/ivoszbg/linux/commits/for-upstream/exynos8895

Since knowledge, datasheets and efforts are quite spread all over, I
keep track of some work here:
https://exynos.wiki.kernel.org/community


Best regards,
Krzysztof
