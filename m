Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F193DC46D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 09:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhGaH36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 03:29:58 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:54210
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229715AbhGaH34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 03:29:56 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id C07703F0FE
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 07:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627716589;
        bh=7szpzek0sYJQJU9q3jPOrpIZQhKhL2Waoumc2yNvU78=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Ltb875sNfqwY7YAl1z4Mm/vz1/OiTDIL9DWK6vhSWJDjcEnrpvOac3nF32VmrpIpj
         9rP47Tvb3g7g5FJ+lihdzgZzyhComUFnyoKqMNBmb6Qrz99UtS/volhU8U7ImpmyYJ
         7NHSc4tfmAbBeSu3zrxCcc4OMMehxlQ3Kbe1g2BrSgbzI6x9aiiU8dyM0YzDtqf0qN
         2MWwFvbPr4yGz5NLfduzDG7M0PWwbNCfUafJvuZDGdQgG8D//FBFTNeWYUJl22QfZ5
         /QOi2Wt1maWyBc9u+f5K/rFRt58AwLuHjryI0cHrMki61/RjpJw3UE5yWFdnmSGKHC
         UKHYBi2BkjfkQ==
Received: by mail-ed1-f70.google.com with SMTP id c16-20020aa7d6100000b02903bc4c2a387bso5713231edr.21
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 00:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7szpzek0sYJQJU9q3jPOrpIZQhKhL2Waoumc2yNvU78=;
        b=EKHMAJTFHYFjoPnqmTJgajZva8sPZjxr1/KIuQ2IMUdKynooiYZkXMnNJktKyL3SWV
         ft/4zTXX2JpzsLd3yThkgtO+1RN+RM/NGvT+CsUckl4H5kNtyX4irn3lFtPu5XWfvqrE
         OtLWDV5khqfAErbnhAaRUI/a9xOJ+7dXI3fRMXlYLCl28AG+fzhMc1ary0zSWnrlXm9P
         DvQPb1omGAk4AXkTnt6fkj9iSOCyhVfho0fWGL8rFtiqFZBMhp77pIHSi7lVCtXk3cCW
         aGZl9RIImtOKBcEEPbSy/54zNF5sBL311eQNQQVG1i29NEiDW8qEVSjR4hvKHzEmUPyo
         uelw==
X-Gm-Message-State: AOAM531INkJcjgQBbdvrOYV4KPpjk/s5DwNgR+Pue5VBx+RH0/VBxklm
        lypo9hJqEjZfWP89FkFrQ10Oew2+RXhesrNofMy6ZySQcEJyoqPHpUlw7Wqis16Ziy2L+Z6yQXw
        OLj55ZavmTarqwUYo0JOluG+KBlH04oSXqjAnW7vCfA==
X-Received: by 2002:a05:6402:299:: with SMTP id l25mr7768598edv.283.1627716579303;
        Sat, 31 Jul 2021 00:29:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUxBOyxyGNdZMeniqKHPWuWGs2AKaZZj7ShbIHSxUlg3RJCNhhDtExvwhxpbohpRLzf5RItQ==
X-Received: by 2002:a05:6402:299:: with SMTP id l25mr7768575edv.283.1627716579171;
        Sat, 31 Jul 2021 00:29:39 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id v13sm1361312ejh.62.2021.07.31.00.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jul 2021 00:29:38 -0700 (PDT)
To:     Sam Protsenko <semen.protsenko@linaro.org>
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
 <5e35b0a7-13aa-3c62-ca49-14af2fcb2a08@canonical.com>
 <c3486111-0ec9-9679-d2a2-68b2f33a2450@canonical.com>
 <CAPLW+4kbnJEBkc0D=RWt59JxBan8X1uDy6sSXBiYAq8N9FDV6A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 00/12] Add minimal support for Exynos850 SoC
Message-ID: <13f166bb-7103-25d5-35a6-8ec53a1f1817@canonical.com>
Date:   Sat, 31 Jul 2021 09:29:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPLW+4kbnJEBkc0D=RWt59JxBan8X1uDy6sSXBiYAq8N9FDV6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2021 21:02, Sam Protsenko wrote:
> Hi Krzysztof,
> 
> On Fri, 30 Jul 2021 at 20:21, Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 30/07/2021 17:18, Krzysztof Kozlowski wrote:
>>> On 30/07/2021 16:49, Sam Protsenko wrote:
>>>> This patch series adds initial platform support for Samsung Exynos850
>>>> SoC [1]. With this patchset it's possible to run the kernel with BusyBox
>>>> rootfs as a RAM disk. More advanced platform support (like MMC driver
>>>> additions) will be added later. The idea is to keep the first submission
>>>> minimal to ease the review, and then build up on top of that.
>>>>
>>>> [1] https://www.samsung.com/semiconductor/minisite/exynos/products/mobileprocessor/exynos-850/
>>>>
>>>
>>> Great work!
>>>
> 
> Thanks, Krzysztof! And thank you for reviewing the whole series.
> 
>>> What's the SoC revision number (should be accessible via
>>> /sys/bus/soc/devices/soc0/)? Recent wrap in numbering of Exynos chips
>>> might bring confusion...
> 
> # cat /sys/devices/soc0/revision
> 0

soc_id but you're right it won't be set for unknown SoCs. You need to
extend drivers/soc/samsung/exynos-chipid.c to parse new values (E3830000
for product ID) and maybe new register offsets (previous offset is 0x0,
for 3830 is 0x10 I think). Also revision mask might change.

>> Judging by vendor's sources it is quite confusing. It looks mostly like
>> Exynos3830 but in few other cases it uses Exynos9 compatibles (Exynos9,
>> Exynos9820). Only in few places there is Exynos850. Marketing department
>> made it so confusing...  The revision embedded in SoC would be very
>> interesting.
>>
> 
> As I understand, this SoC is called Exynos850 everywhere now.
> Exynos3830 is its old name, not used anymore. As you noticed from
> patch #2, it shares some definitions with Exynos9 SoC, so I guess some
> software is similar for both architectures. Not sure about hardware
> though, never worked with Exynos9 CPUs. Anyway, I asked Samsung
> representatives about naming, and it seems like we should stick to
> "Exynos850" name, even in code.


Since the chip identifies itself as E3830000, I would prefer naming
matching real product ID instead of what is pushed by marketing or sales
representatives. The marketing names don't have to follow any
engineering rules, they can be changed and renamed. Sales follows rather
money and corporate rules, not consistency for upstream project.


Best regards,
Krzysztof
