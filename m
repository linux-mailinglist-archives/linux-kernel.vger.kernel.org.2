Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0858340C1AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbhIOIZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:25:57 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52744
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231672AbhIOIZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:25:56 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E513D3FDC7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 08:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631694276;
        bh=jH5yqZdy0poBMayuZGGYMX7sqt3HTnu/3+K0ZeEsCPk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=NXg5sRQqtkxawT8VFTJgkhZEkArkV7Q58m9LDz3uudZg3LDYpn0W3N6DQNMAQ5PGY
         piPPCl8ikbmSqBZZ2lPv4d0IjRf81vy3YJEhsVZtU41l+qbIorceCbBr7K2RI3PCHj
         Ut6ifBat0rrcHegfXWRKbR0NYtawCk0LlXRV/1wsCL7pbnty68J0njuPLf2DwMAW+B
         8TOUY5cCizW/FaTK44bXbNlQg75tbAS1XM51kvRJ+Vz4z9J/G4bMBPHlJKyra4ny4C
         znjI5ftH6Nca12UL/ojeBiAKN6Q3s8NPN6DHYMbsKcwyMV8PQz+2o0WRQgHHBnU6jD
         fawbTkbBm0zAg==
Received: by mail-ed1-f69.google.com with SMTP id e7-20020aa7d7c7000000b003d3e6df477cso1134183eds.20
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 01:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jH5yqZdy0poBMayuZGGYMX7sqt3HTnu/3+K0ZeEsCPk=;
        b=ZC3C1IFuXTFQnQwiNO0iL8LMPj5SpDNmJHJEdcHgFs0fQDesW05/PaskS/+MW1eIPT
         j7oO3SZENM2LPpqNwM+SrxhbtDh6AC90meL7DWQxg8jzvBCEJ8ZG+m/S08mKVKC8EqyL
         d/Wjqtlctz8wdzmanW1lb/8hbKMXcjzvS9YimOj6LBPTmQMuA0swSzkElNmWhkSbBI27
         XsGo5SBxjFyH79UdsMKV7HQNUwB+Wd1wJy5LqmYpCOfi3rEYuqrxEFKUcszTDVa16HW4
         M6iq3EOWJS3dQsD/bCdAd7WFDh+5pgZHjRQq1tPn7Pu0ENk6HJWafjkocfzP/xbp/WX6
         W1dQ==
X-Gm-Message-State: AOAM530HcROJY37aQ9imGo0dVHqPKco2LVLYfa/BwdC4hbHXiSztlOpO
        slkD7Tu/rHGODi+svGSX6bbix3X+wf/PMgdo395cQKIPYrceoy36IbfbrLU0MmufQRbF9SDfw+G
        mFRjcQZMiXUVOelB6nDwbQ/CK/HmPC9caOBUDZ+fqdg==
X-Received: by 2002:a17:907:d23:: with SMTP id gn35mr24610916ejc.556.1631694276564;
        Wed, 15 Sep 2021 01:24:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsVkw4c2rpKq/jC9r7maHh5NKfix2SH8toBQTvS0RrkMXOk3q+BW0FeTzs/ZNQvvCu8pb6OQ==
X-Received: by 2002:a17:907:d23:: with SMTP id gn35mr24610904ejc.556.1631694276399;
        Wed, 15 Sep 2021 01:24:36 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id d3sm6658015edv.87.2021.09.15.01.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 01:24:35 -0700 (PDT)
Subject: Re: [PATCH 2/6] clk: samsung: clk-pll: Implement pll0822x PLL type
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Ryu Euiyoul <ryu.real@samsung.com>, Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20210914155607.14122-1-semen.protsenko@linaro.org>
 <20210914155607.14122-3-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <47e5b93a-27b4-2188-7b1e-fd2c1b2379d3@canonical.com>
Date:   Wed, 15 Sep 2021 10:24:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914155607.14122-3-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2021 17:56, Sam Protsenko wrote:
> pll0822x PLL is used in Exynos850 SoC for top-level integer PLLs. The
> code was derived from very similar pll35xx type, with next differences:
> 
> 1. Lock time for pll0822x is 150*P_DIV, when for pll35xx it's 270*P_DIV
> 2. It's not suggested in Exynos850 TRM that S_DIV change doesn't require
>    performing PLL lock procedure (which is done in pll35xx
>    implementation)
> 
> When defining pll0822x type, CON3 register offset should be provided as
> a "con" parameter of PLL() macro, like this:
> 
>     PLL(pll_0822x, 0, "fout_shared0_pll", "oscclk",
>         PLL_LOCKTIME_PLL_SHARED0, PLL_CON3_PLL_SHARED0,
>         exynos850_shared0_pll_rates),
> 
> To define PLL rates table, one can use PLL_35XX_RATE() macro, e.g.:
> 
>     PLL_35XX_RATE(26 * MHZ, 1600 * MHZ, 800, 13, 0)
> 
> as it's completely appropriate for pl0822x type and there is no sense in
> duplicating that.
> 
> If bit #1 (MANUAL_PLL_CTRL) is not set in CON1 register, it won't be
> possible to set new rate, with next error showing in kernel log:
> 
>     Could not lock PLL fout_shared1_pll
> 
> That can happen for example if bootloader clears that bit beforehand.
> PLL driver doesn't account for that, so if MANUAL_PLL_CTRL bit was
> cleared, it's assumed it was done for a reason and it shouldn't be
> possible to change that PLL's rate at all.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/clk/samsung/clk-pll.c | 91 +++++++++++++++++++++++++++++++++++
>  drivers/clk/samsung/clk-pll.h |  1 +
>  2 files changed, 92 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
