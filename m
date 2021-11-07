Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A7C447251
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 10:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhKGJOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 04:14:31 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60588
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235051AbhKGJO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 04:14:29 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6F2E74000F
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 09:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636276306;
        bh=v5niVFCGzjcvHtkOVfPQzUCnQqm1fNGK/DVDsxchA1E=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ggsFaguezjL5VxkohxptVglfXBwvP1zOWdTIx5DlrGdI7Elppi8QNIrups0CCzkXj
         oP9N8tKDVrqEXExdGuesyII9MmSD+Y09N1W+BivzuSZ949PObiGtxEJztSBpfsqz9c
         YobyaMYqbcFyASYz/yZccfDyJ3QQYkwFu0weqv3uvGTu+aqqaZUEXCB0AkJnjjszBF
         kgm+Rr9isZHjoj7AZwibbZhsL4YH4RIUqfE6N1+x9EXY1/iSmbqVBxMPRCdlayOve0
         xGsRCVQ+eDTOoQ8f9Cv6M7fQPRD4Garc22M3ej4SBu0GFzaIIT4nCgeG/9Ckx8V3+8
         oId2MXKY8Kx7A==
Received: by mail-lf1-f71.google.com with SMTP id i1-20020a056512318100b003ffd4e89eb9so5117250lfe.19
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 01:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v5niVFCGzjcvHtkOVfPQzUCnQqm1fNGK/DVDsxchA1E=;
        b=EXy6iOEQzCFexH/eWdRrlwOoTwgqyhlNS+VHsXPnXi8gf9UzfrbMJjfIaWd8CeHWo1
         OM7fh6lH+j8Ho7Kw7g72VCBXOlkRdei+iIlKI2y3xfaphzJxugdNz6jvUXai1iUQM953
         31JLVQVb8ZaHMShoesKg5eCxZ2RQT/FwdbeG100nMTl8FljUrHOzHKJKtWpPSmdsCEzt
         IzJ03jHAq4m16e7t8S+JLOBVbs0B2goOHxPxJP88R15aDltf/WwI+Y34NZSLUqBCyf5t
         cSQ+VxJnVIRcd2n9lRRh1NqctzJBLYIpHAfle7o78GYIRWuBOjdxRfdKtSI7y2SkMTQL
         qm6g==
X-Gm-Message-State: AOAM5337XOfPC3YOHh5AH9dH1vU5noFHj1vw+ztDWehjU8jAFRQ6eVPP
        Jc74dJkgpn9NkKyrG4KRRV7HaDpDTnKZYjtXEwQZhVL+o+ZwPfoUgdeFCveL76df2RoVDHWcweH
        ZB3iwxc3FGsaA19oE/0PKPQrtqDegmtWlpkksEzdgiw==
X-Received: by 2002:a05:651c:990:: with SMTP id b16mr69957867ljq.79.1636276305765;
        Sun, 07 Nov 2021 01:11:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzc6yvva3qxjFU1A6k4MTvA9X4cMUY+t3uIRmHmRIwmUVnLRgWqIwxyGM1kDvB39l5aXiGpQA==
X-Received: by 2002:a05:651c:990:: with SMTP id b16mr69957830ljq.79.1636276305473;
        Sun, 07 Nov 2021 01:11:45 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o16sm407493lfk.109.2021.11.07.01.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 01:11:45 -0800 (PST)
Message-ID: <3ab9583f-de50-e403-955d-89e085d4274a@canonical.com>
Date:   Sun, 7 Nov 2021 10:11:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC PATCH] ARM: s3c: mark as deprecated and schedule removal
 after 2022
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Cedric Roux <sed@free.fr>, Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sam Van Den Berge <sam.van.den.berge@telenet.be>,
        Lihua Yao <ylhuajnu@outlook.com>
References: <20211102110519.142434-1-krzysztof.kozlowski@canonical.com>
 <c4bcafd0-f614-78c8-4d72-5d2b672f7e32@free.fr>
 <08c8f447-dcae-83b4-e5b3-a13704a5b158@canonical.com>
 <4062510.I3n91tvSNF@diego>
 <CAK8P3a2Pg8CkXgN8YNhp2U5Kgwf08kQGpLeTsyWKgNpGChC4uQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAK8P3a2Pg8CkXgN8YNhp2U5Kgwf08kQGpLeTsyWKgNpGChC4uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2021 21:13, Arnd Bergmann wrote:
> On Sat, Nov 6, 2021 at 8:33 PM Heiko Stübner <heiko@sntech.de> wrote:
>> Am Samstag, 6. November 2021, 19:20:05 CET schrieb Krzysztof Kozlowski:
>>> On 05/11/2021 18:49, Cedric Roux wrote:
>>>>
>>>> Anyway, there is at least one s3c2440 server on Earth powered
>>>> by the linux kernel. Now you know! :)
>>>
>>> Thanks for coming back! We will see how much of feedback we gather.
>>
>> I do believe all (or at least most) of s3c24xx could run with a devicetree
>> base with core peripherals enabled.
>>
>> So one possible alternative way could be to just deprecate (and then drop)
>> all the board-files + their platform-data parts in mach-s3c.
> 
> Yes, and this would be similar to what we've done for mach-imx and
> mach-omap2 in the past.
> 
> However, I think the Cragganmore/Speyside board that Mark mentioned
> is not in the category of easily converted machines, so leaving only the
> DT-enabled machines around would not help him.
> 
> If this is actually the case, one other possibility would be to remove
> all the board files except for that one, in the hope that the transformation
> (even a partial one) to DT becomes easier when there is no risk of
> breaking other machines.

Dropping board files would be a nice step but only a half-way, because
we could not remove the S3C support from the drivers.

The platform to stay should have either:
1. real users in the production who need updates
or
2. hackers who have hardware, like to play with it and will do the
testing/development.

In the second case (the hackers) having only the hardware but not
testing or running newest kernels does not revive the platform from the
almost-dead stage.


Best regards,
Krzysztof
