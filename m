Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0446443829A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 11:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhJWJWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 05:22:00 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33402
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230100AbhJWJV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 05:21:59 -0400
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6D3F23FFF6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 09:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634980779;
        bh=y64xiDh6vWon4cWBdDBfcLK61yfVRep3b0Jy8edoaN8=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=g2dReMlOgRw5zIEIFNIIVS8pRI8Aj/+8wOcjajiYXQoox2qurcgd/x1jTxvaq1WXg
         UECcbCo8RcNELruYNadsjzoaLamz44Ji8Xs79s5chH+Y5mV+PDhmWRlEtuc+sUCgSY
         tpHxDMaoummWnfmYvnnko1Vmnwb5qPwVtLp3tuJtB6JE6v1kki3olBFnAQ2kYnqgVY
         phGsl4Cpet8+grDDnx18fLkgnvceTD8NqqtR27Z1PTjs25MUhR41Jz1KyMp+QVKBPg
         +SmM8/43fQbY5nf7bIM5xKdUDZWdjQK5LaWrvsR9tjH1VA8qnQg+7g+PphDoa6oDJZ
         eTfLL7Uog1nbw==
Received: by mail-lj1-f200.google.com with SMTP id j8-20020a2e3c08000000b00210e2890d61so1683163lja.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 02:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y64xiDh6vWon4cWBdDBfcLK61yfVRep3b0Jy8edoaN8=;
        b=NYgbN7R98URqVe0bj1VOaxwp9fBl3RfZmBgWiULuv7w5mstSdd4zpMEMb5sN9q/8HV
         BgYv9xAyMiBWFF+YORZOEdbyKQ6EnDpJacejh10Ci9zdSsnAgQ+1+yP9lOopItAmm055
         rwolRg/Z30Qs54VCYsC1JpejV4XeA100f0vFq17VMgLrFpB7pid4pkiRxPVo6JMsNCOv
         c0VKkpWOZbRLi6wsr6mUDZ3COUiynUz7RA+lV5lfqQH/pqAW+hR20uQNNEeOOleycysR
         XTU3TEFKXHJrjczIDQwbW9yWcFzp3DBmpN8XXhy5EIQxTVua1f+P6nAbJmZzrUWxv5bP
         4mWw==
X-Gm-Message-State: AOAM5311w1RbtIFBSKrZOnCun6vaUra9eGZSJnsiqrvnUmg1wArIzOVX
        UOxJHIjDfLKBRxCc19Lm/hP97YA7s3x+k97LLobbBduh86q1uV4kkeV7OlcSfupUFhvFV/2OGCc
        NIvNJ6YoAkQJ/jnL6tWzmQRvs/q6mYulzZvBr1lPPpA==
X-Received: by 2002:a05:651c:54d:: with SMTP id q13mr5473314ljp.239.1634980778501;
        Sat, 23 Oct 2021 02:19:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL6bUdYP/vNZocag+kLgsuqN8HkdqCGAQeo+c4eDzv5bJjhAGZA+w9SVfJJijfQ+FXwtHJhg==
X-Received: by 2002:a05:651c:54d:: with SMTP id q13mr5473283ljp.239.1634980778202;
        Sat, 23 Oct 2021 02:19:38 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id s3sm973085lfp.264.2021.10.23.02.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Oct 2021 02:19:37 -0700 (PDT)
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211022215635.31128-1-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH] clk: samsung: exynos850: Register clocks early
Message-ID: <f8f1121a-f9ba-e231-ece2-646d9de8b22b@canonical.com>
Date:   Sat, 23 Oct 2021 11:19:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211022215635.31128-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2021 23:56, Sam Protsenko wrote:
> Some clocks must be registered before init calls. For example MCT clock
> (from CMU_PERI) is needed for MCT timer driver, which is registered
> with TIMER_OF_DECLARE(). By the time we get to core_initcall() used for
> clk-exynos850 platform driver init, it's already too late. Inability to
> get "mct" clock in MCT driver leads to kernel panic, as functions
> registered with *_OF_DECLARE() can't do deferred calls. MCT timer driver
> can't be fixed either, as it's acting as a clock source and it's
> essential to register it in start_kernel() -> time_init().
> 
> Let's register all Exynos850 clocks early, using
> CLK_OF_DECLARE_DRIVER(), and do all stuff relying on "struct dev" object
> (like runtime PM and enabling bus clock) later in platform driver probe.
> Basically CLK_OF_DECLARE_DRIVER() matches CMU compatible, but clears
> OF_POPULATED flag, which allows the same device to be matched again
> later.
> 
> Similar issue was discussed at [1] and addressed in commit 1f7db7bbf031
> ("clk: renesas: cpg-mssr: Add early clock support"), as well as in
> drivers/clk/mediatek/clk-mt2712.c.
> 
> [1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20180829132954.64862-2-chris.brandt@renesas.com/
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Notes:
>   - This patch should be applied on top of CMU_APM series
>     (clk: samsung: exynos850: Implement CMU_APM domain)
>   - I considered introducing some macro to reduce the code duplication
>     (actually created one), but decided to go with plain code: this way
>     it's easier to understand and navigate
>   - Also considered registering only *some* clocks early: won't be
>     possible, as leaf clocks (like MCT) depend on the whole clock tree.
>     Registering early only *some* CMUs (like CMU_PERI) looks possible,
>     but I'm not sure what is the best way to implement this, and that
>     won't be consistent with other CMUs (too much code variation as for
>     my taste)
> 

In the long term it is better for entire kernel and SoC to support
deferred probes and register clocks as devices, not as CLK_OF_DECLARE. I
understand that it's not possible now to get rid of CLK_OF_DECLARE
entirely, but we could meet half-way.

The Exynos5433 has the same problem and it registers few core CMUs
early: the TOP, CPUs, memory bus, peripheral buses including PERIS with
MCT. I prefer this approach than yours. The only domains needing
CLK_OF_DECLARE are TOP and PERIS. Maybe also CORE - one would have to
check if GIC and CCI are needed early.


Best regards,
Krzysztof
