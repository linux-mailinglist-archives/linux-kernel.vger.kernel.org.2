Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7F9413978
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhIUSF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:05:59 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58078
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232289AbhIUSFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:05:55 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0107C40257
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 18:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632247466;
        bh=E+U9M1hOnkJj7BjeE3jXuEWq5COKAKZc20zg2UQGqwg=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=E4Tpw2VtkkYkmzX/9/r0Yob0hHIlSSWudii5+rhPv/mYbTpRFyEhI/OON+tUjFg4y
         LDD1bKItJ89Co2YfUL6Kyua2Vd5lqg+r0mSxcnGR//8H1kZVZQAB4+2DT5S6/o9wTz
         1e3sz2yD/iRV0sKMwwpxQCGDCWdHqNkz8Z2boFfOUSlDUfp1JARZI2AfKPONN7dC6+
         7Zipirni4ikxJ+6LSe3a6cMHXP4WlluPVTWod5GjmN6D7YupAjgfu9kL2nuItO1NCr
         s+ygtEhQNZdDdBc8c8pGw24gYX+rmqR5MjLK6jooqIhrWsRp7ttbLfb1E/SZYiACt4
         L2llOXULKIn9A==
Received: by mail-wr1-f72.google.com with SMTP id v1-20020adfc401000000b0015e11f71e65so9542539wrf.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E+U9M1hOnkJj7BjeE3jXuEWq5COKAKZc20zg2UQGqwg=;
        b=t25ZmDQwwrgCUWxLWdjHm1wG44AwMLgolVvf4GntpS2hKCmxCd8JTanpXqaNl8BJNT
         t/hVqNDnSY84wRtVszAg3NLjHpV2nHULc0mzoOT3HIbKmK5TexiiGGPu/Szvfs4vgame
         GqL0CtwxrgsS2YF4filKClOcOorUG9t3RYvphjS1TSjXaFklWj/p+QK6qD1sONONyOAi
         lROHXFVaAMY8CKgyF3DBP1+J4/Ng3UKfjcmmq+YbQCRbTy+Ss8vKELe/zPmpRLLQ+b7e
         RuWNFcszVYJsg2PCeTIzujOJ+LzHX+9JzM28daHcwU51lr1EHmRRaGYAidgWZP5ugJwc
         z0Ig==
X-Gm-Message-State: AOAM5326BWLB81jm4ym4M8+Ui2dkSvfFGsBhBJ7jb8w+a7Nd03WwfAK5
        1aJWYxeBDNk9s0IgZRe5xnkQiqR4F9mLZnqzyoK4UVLGG/WzGak+a8L4B5EKgBU22IEM33fnMcU
        f9PHWsOZZ2Cz8JNJhmbU+ikWhDMI5m23eIrhuj7Ngng==
X-Received: by 2002:a05:600c:4a16:: with SMTP id c22mr6106903wmp.72.1632247465503;
        Tue, 21 Sep 2021 11:04:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0/tb/AS73ULX2b3IOIxReTNR7zjlkrcMrJj7f6rnKykXODM+qPZZEH9ABX/TMOHQ2+StX+g==
X-Received: by 2002:a05:600c:4a16:: with SMTP id c22mr6106863wmp.72.1632247465152;
        Tue, 21 Sep 2021 11:04:25 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id a72sm3736431wme.5.2021.09.21.11.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 11:04:24 -0700 (PDT)
Subject: Re: [PATCH v1 1/4] clk: samsung: change COMMON_CLK_SAMSUNG default
 config logic
To:     Will McVicker <willmcvicker@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <20210920190350.3860821-1-willmcvicker@google.com>
 <20210920190350.3860821-2-willmcvicker@google.com>
 <a8d40b96-bcb2-5eb6-b0e5-c20c14471c8a@kernel.org>
 <CAMuHMdWdHF49qj+qV-DnbDDv14J3y98TPHd_6y_i7o7_azhErg@mail.gmail.com>
 <2c8a79f7-711a-b075-745f-ea77b82a1117@canonical.com>
 <CABYd82bzKh=QQHyk-kPXekzCKx+Uy-z2TY5qAQQNfuew=h=O-w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <001cd621-53d1-fe22-0eaa-d13137827297@canonical.com>
Date:   Tue, 21 Sep 2021 20:04:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABYd82bzKh=QQHyk-kPXekzCKx+Uy-z2TY5qAQQNfuew=h=O-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2021 19:58, Will McVicker wrote:
> On Tue, Sep 21, 2021 at 1:35 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 21/09/2021 09:50, Geert Uytterhoeven wrote:
>>> On Tue, Sep 21, 2021 at 9:31 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>> On 20/09/2021 21:03, Will McVicker wrote:
>>>>> COMMON_CLK_SAMSUNG is selected by ARCH_EXYNOS which forces this config
>>>>> to be built-in when ARCH_EXYNOS is enabled. Switch the logic to use a
>>>>> "default y if ARCH_EXYNOS" to provide flexibilty for vendors to disable
>>>>> or modularize this driver.
>>>>
>>>> The clock drivers are essential, you cannot disable them for a generic
>>>> kernel supporting ARCH_EXYNOS. Such kernel won't work properly on platforms.
>>>
>>> Obviously it's not gonna work if the clock driver is not enabled
>>> at all.  But does it work if you make the clock driver modular, and
>>> put it with all other essential driver modules in initramfs?  Debugging
>>> would be hard, as the serial console driver also relies on clocks
>>> and PM Domains etc.
>>
>> The kernel could boot without clock drivers (default settings from
>> bootloader), probe clocks from initramfs and proceed with rootfs from
>> eMMC/SD/net.
>>
>> In theory.
>>
>> However I have no reports that it ever worked. If there is such working
>> upstream configuration, I don't mind here. Just please explain this in
>> the commit msg.
>>
>>>
>>> If not, this patch should be NAKed, until it works with a modular
>>> clock driver.
>>>
>>> If yes, perhaps another line should be added (_before_ the other line)?
>>>
>>>   + default m if ARCH_EXYNOS && MODULES
>>>     default y if ARCH_EXYNOS
>>>
>>> However, many developers may want MODULES=y, but not want to bother
>>> with an initramfs.  So perhaps we need a new symbol
>>> MINIMUM_GENERIC_KERNEL or so, protected by EXPERT, and make the
>>> driver default to m if that is enabled?
>>
>> Yeah, that's indeed a problem to solve. For most users (and distros)
>> building kernel for Exynos this should be built-in by default.
>>
>> Anyway, the option is non-selectable so it cannot be converted to "m" or
>> disabled. And this is claimed in the commit msg:
>> "provide flexibilty for vendors to disable or modularize this driver."
>>
>> The commit does not achieve it.
>>
>> Best regards,
>> Krzysztof
> 
> Thanks for the reviews! As Lee has explained in his replies, the
> intent of this series is to provide config flexibility to create a
> defconfig that allows us to move out SoC specific drivers in order to
> create a generic kernel that can be used across multiple devices with
> different SoCs.

That's quite generic statement... or let me put it that way - we already
have this ability to create a generic kernel supporting different SoCs.
Exynos and other ARMv7 and ARMv8 platforms are multiplatform.

Task is done.

Please be more specific about use case and describe what exactly in
current upstream multiplatform kernel is missing, what is not
multiplatform enough.


> I'm sorry I added confusion by mentioning
> modularization. All of these drivers that I am modifying in this
> series can be modularized which is an ongoing effort, but is not
> addressed here and I don't believe that modularizing them should be a
> requirement before supporting enabling/disabling them.

Since the disabling the driver for a kernel supporting Exynos does not
make any sense, then making it at least modular unfortunately it is a
requirement.

> I will update the series with my patch that refactors the Samsung SoC
> drivers menuconfig to make these visible as well.

I would first recommend to really describe your use case because my
questions about this are still unanswered.

Best regards,
Krzysztof
