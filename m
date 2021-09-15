Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B422C40C1AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhIOI1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:27:31 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46724
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231672AbhIOI1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:27:30 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CCAF040257
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 08:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631694370;
        bh=ptvhp8j3x8Ftji47LhZR4Wys0W2gMYnRB4nsbyxXHrA=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=FGjhIH9ECSBf4weqHJCueAM9m9b68EzO82vksw4V2IsfesDcNHl5PT3ab4YbgTm6Z
         oVH7Np4n4SSR2gyCFvgqREbCQPkCt2bvAo2K6c2SjgRvip9Oz6EM/OkLWue9D6UNC2
         GA27UTqWpKu6btiXavsyVHNFQHwNN0cNFtG37pPIK82qL0zGiiBtg7y3sA/0gXPC2u
         c1e+h8VcRDHMTfnxB+nrJkVLYX1xo75P0lbiABpr8HJoO5ScaYcvJBrxWyN3u2surI
         isaNZAI8c8dmY5YK1Pyv/QlrzhUYpAIhWQY5jnFIht3HdgS/hEMDpsGHIVZ8+cOL1S
         Xq1UxAci+711g==
Received: by mail-ed1-f71.google.com with SMTP id s15-20020a056402520f00b003cad788f1f6so1135877edd.22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 01:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ptvhp8j3x8Ftji47LhZR4Wys0W2gMYnRB4nsbyxXHrA=;
        b=yy2AT07T0YuGKx9xbNy6wJeZIRwUbxf5V4+sQz87ozHGBm9JoQk4uYoIi8EBXZGqYg
         WBlHhOjRi7lfejDoOIhyhKv3wv8fuUXwSEOicT0dPGcrc8v2bF1NJy7p75Pqoktd4CQn
         MWExnXGnGkKc/oCyb/QJrJVEW51wrsVg+8bsJODvnrk+kGwap6gnqmVcthh69hs542hw
         hBvzQGgZmW9IkG4Il+sUVGqCQbkGigozPVWTXaozTCCUCAkmaLcPJdXyjY9ChTLYOAX4
         J6zq4818U6v2V6TFBNnSBhhxaXMSeLsgl8fyzJ+7YCeMATvE0i3COKGc8xmgcxfnLrUm
         hnUw==
X-Gm-Message-State: AOAM531wPL0nR3H+VDJV3eXZnWMfFwKrvrSw02fJ3YWkU16btsNBtEa7
        IF/a0rNLKOYs5+r8ntLRoxfpqeprwjH2fwroK2bY9I6PesCbpD21tmDay0La6gnio5/DpeyBqxS
        2Uz2p0RN0oBoah3D5nLkZvSQaZr0fT38dEipzb6jl4Q==
X-Received: by 2002:a17:906:72d0:: with SMTP id m16mr23559520ejl.282.1631694370556;
        Wed, 15 Sep 2021 01:26:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy40iZHAYHG7of77gqMHSsEjCU0O3RP/sEGAl+pwIJiNsr9dTKA2Dzu3UElI7w7k0XRmYtnuw==
X-Received: by 2002:a17:906:72d0:: with SMTP id m16mr23559504ejl.282.1631694370363;
        Wed, 15 Sep 2021 01:26:10 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id a12sm2689234eje.27.2021.09.15.01.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 01:26:09 -0700 (PDT)
Subject: Re: [PATCH 3/6] clk: samsung: clk-pll: Implement pll0831x PLL type
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
 <20210914155607.14122-4-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <4a6e73bb-617d-d849-d64a-7f0de46ea03b@canonical.com>
Date:   Wed, 15 Sep 2021 10:26:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914155607.14122-4-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2021 17:56, Sam Protsenko wrote:
> pll0831x PLL is used in Exynos850 SoC for top-level fractional PLLs. The
> code was derived from very similar pll36xx type, with next differences:
> 
> 1. Lock time for pll0831x is 500*P_DIV, when for pll36xx it's 3000*P_DIV
> 2. It's not suggested in Exynos850 TRM that S_DIV change doesn't require
>    performing PLL lock procedure (which is done in pll36xx
>    implementation)
> 3. The offset from PMS-values register to K-value register is 0x8 for
>    pll0831x, when for pll36xx it's 0x4
> 
> When defining pll0831x type, CON3 register offset should be provided as
> a "con" parameter of PLL() macro, like this:
> 
>     PLL(pll_0831x, 0, "fout_mmc_pll", "oscclk",
>         PLL_LOCKTIME_PLL_MMC, PLL_CON3_PLL_MMC, pll0831x_26mhz_tbl),
> 
> To define PLL rates table, one can use PLL_36XX_RATE() macro, e.g.:
> 
>     PLL_36XX_RATE(26 * MHZ, 799999877, 31, 1, 0, -15124)
> 
> as it's completely appropriate for pl0831x type and there is no sense in
> duplicating that.
> 
> If bit #1 (MANUAL_PLL_CTRL) is not set in CON1 register, it won't be
> possible to set new rate, with next error showing in kernel log:
> 
>     Could not lock PLL fout_mmc_pll
> 
> That can happen for example if bootloader clears that bit beforehand.
> PLL driver doesn't account for that, so if MANUAL_PLL_CTRL bit was
> cleared, it's assumed it was done for a reason and it shouldn't be
> possible to change that PLL's rate at all.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/clk/samsung/clk-pll.c | 105 ++++++++++++++++++++++++++++++++++
>  drivers/clk/samsung/clk-pll.h |   1 +
>  2 files changed, 106 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
