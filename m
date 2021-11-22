Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62260458A37
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 08:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbhKVIAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 03:00:32 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60906
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238774AbhKVIAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 03:00:30 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5A19A3F1C0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 07:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637567840;
        bh=PcxoRBTZGSYTTVWVxfthK4uXynQwbLiAr353aFZB84s=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=p5T2qcZ7KDTuDJwXxKe2m5bZhj5EWvEhLTD46E8K1vlGTXOxXPDpVTYKx1873/7HE
         H0btM6J3CXQn46pqXzVVvLETXZSuhtnYgTyioCYfQcSG16zaxL5URDIAWjdCytljTw
         ugUMAEe1HwC+gbWxBW8haaa1sXTSOwXxeVeF+3efRviOt0JyA3I2lE7ux/UAvi9fYS
         g0MGgNksjWmKJ3WOFpELBZivJdEXPNRR0zKUsumu4BbIam0VJnHlgVsxDEzOAdNPu1
         c+MkCSlv64H6GIZdZ7yFlUEfPXrIAyRCbeQySz/QBX0y2WdllBpgGcNx0oRjyozF44
         fdUS1waTgQQ8w==
Received: by mail-lf1-f71.google.com with SMTP id bi30-20020a0565120e9e00b00415d0e471e0so6190702lfb.19
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 23:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PcxoRBTZGSYTTVWVxfthK4uXynQwbLiAr353aFZB84s=;
        b=DzEC6DJ/s7JCIXVfw6q6Q1m3GIh5gsE5LsMlcBR4z8ABf/FwEhx8/y777guMg1JKW9
         3cxf7cadJEXOk4QyaYEDh63bFqSOB3JNrjQBqZCdJ08PQMGPn8Bg+u5EfQnr6zETX7nM
         PFtRGZXpWdoTRmxpaES0SYjYx0RGMNrwY1blIIJT74ITdXs65TgXzB4bmmTUNAh0eccu
         THhYbuHPZJqfDlGtw5jM10OwA9c5W8fgmmi2Akti+ssyMOa1N51bLml7BZg7a+yJoQDh
         9yzYznEnokbbGw1yQvE5e74+y7ErwkJqoHMtopbC1x7LgoEzcz6VEjVkYzHBD+RJ1zvF
         1hRw==
X-Gm-Message-State: AOAM533ZKf8aFh34jw0e36RmKXMPaupani9FOqwJzUPOAEE+zDjJJEfs
        zfnqOC3qJNIjafBd0o9cvWycxup0ONPbqVZSMKI7nSc9oqNFbuKcvwIxl9z0h0fEfcm430fhJdR
        Tp8+H9ko7zi5MP1r1aLTLbH22cA+59RH6AWmhNAqrFg==
X-Received: by 2002:a05:6512:1296:: with SMTP id u22mr54114411lfs.296.1637567838222;
        Sun, 21 Nov 2021 23:57:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxm5yi0jg4wyKx59FrIXG+M0rioU4VgvmaVZqCRxWzwHhoZyOEN8fz79drw2KNpAE4E/QC5YQ==
X-Received: by 2002:a05:6512:1296:: with SMTP id u22mr54114381lfs.296.1637567837963;
        Sun, 21 Nov 2021 23:57:17 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o11sm837418ljc.100.2021.11.21.23.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Nov 2021 23:57:17 -0800 (PST)
Message-ID: <706cd9c2-5eeb-fd56-a7de-045796584797@canonical.com>
Date:   Mon, 22 Nov 2021 08:57:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 6/6] clk: samsung: exynos850: Keep some crucial clocks
 running
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     David Virag <virag.david003@gmail.com>,
        =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20211121232741.6967-1-semen.protsenko@linaro.org>
 <20211121232741.6967-7-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211121232741.6967-7-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2021 00:27, Sam Protsenko wrote:
> Some clocks shouldn't be automatically disabled in clk_disable_unused(),
> otherwise kernel hangs. Mark those clocks with:
>   - CLK_IS_CRITICAL flag, when there won't be any consumers for that
>     clock, but system can't function when it's gated
>   - CLK_IGNORE_UNUSED flag, when consumer driver will be probably added
>     later
> 
> That makes it possible to run the kernel without passing the
> "clk_ignore_unused" param.
> 
> Next clocks were modified:
>   - "gout_dpu_cmu_dpu_pclk":	CLK_IGNORE_UNUSED
> 
>     Will be enabled later in DSIM driver (Display Serial Interface
>     Master).
> 
>   - "gout_gpio_peri_pclk":	CLK_IGNORE_UNUSED
>     "gout_gpio_cmgp_pclk":	CLK_IGNORE_UNUSED
>     "gout_gpio_hsi_pclk":	CLK_IGNORE_UNUSED
> 
>     Should be probably enabled in corresponding GPIO driver later, or
>     made CLK_IS_CRITICAL. "gout_gpio_peri_clk" is actually used by LEDs
>     on Exynos850-based dev board, so kernel hangs if this clock is not
>     running. Other clocks were marked as "ignore unused" to prevent
>     similar issues for other use cases or boards that might be added
>     later.
> 
>   - "gout_cci_aclk":		CLK_IS_CRITICAL
> 
>     CCI (Cache Coherent Interconnect): obviously is critical.
> 
>   - "gout_gic_clk":		CLK_IS_CRITICAL
> 
>     GIC (Generic Interrupt Controller): obviously is critical.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/clk/samsung/clk-exynos850.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
