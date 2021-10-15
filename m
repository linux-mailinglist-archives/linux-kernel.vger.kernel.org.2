Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6248B42EE95
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbhJOKQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:16:49 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46250
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237879AbhJOKQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:16:43 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 648E73FFFE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634292876;
        bh=CdE6XumrF2NcE/za+fvknc1KEQDwW8iRNC51K+hZP/8=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=tAz7uEPHbUf5Sa1SrcMyb2vQoB9hlWRwYcAJDClm1La5Yb1nqBilGWqHnr81RQ4pT
         m+TqlrB8h0Z3I71IW2sfx1Lfayz9N1kXkNZwp54SpmrXUyPIvnQTeBH1ZlSn+yvd4E
         LsfxdthH0BAQ0L2ZLEhixe/Klrx8rV5eZ19gA2HpLn6fQKq4/UReoVroEqAT1DXIG1
         DNdsKzFtGjEkn/sGiU4VxPfQ/p7F/+0ago6GIcOc3jD5NKpOcbawVyS3kj6TH2uDp1
         WxLTBEkAhHBTQD2OY55IGqecLETA7uGZq//H14wCvVAiWCIqBuxP1U6GCxa8eaeSwK
         cZY0TkE/kp8Sw==
Received: by mail-lf1-f71.google.com with SMTP id br42-20020a056512402a00b003fd94a74905so6368454lfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 03:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CdE6XumrF2NcE/za+fvknc1KEQDwW8iRNC51K+hZP/8=;
        b=nat+rSxIkLvAnEN70h5EaspwdzL8t27Dm99bQEVnY8ljYbtYzdfhKTMfAOgJ4sYGj/
         hdnx+345Q/XX4ZbrEURP7rFrXjG+bS5P7sY54sN2Hkt2q+6RW7szlZOH+cimC25JTdBT
         1LTowGIU3ofzUSELMBEudUxGCjJiYhxZzo+bL1fh/ielTHKoHaoZ+ZTg8mPznfTyOiBE
         5kQYeLwRk2lBbinytJ8jkgb+qCpst8mCIb8dLLHRU+Fbgj94XzVzgeNTc5H0cRDeJ5qo
         o9zCVvZaWGAR8bRybJdWS5S5TUjuDu2EvmqKUzdq09skWleyhehYVuTPnJQtZP0VAFQK
         +yLw==
X-Gm-Message-State: AOAM530VRTd8yjIk1B0sFBx/6yN2jQJXtysCTGZnFnP1kgqhKSIGgwpd
        LdRe+QfpkxPH+Ym9vRc1A9Vh0R5OKnze/6qAMH/FuzLOo3fxHiw6YuNzNTZ48y1IKPPN59HeMrI
        h3chGcNjRNtV/yMmpaZnIphODsLdXVSTCJT0xTZUvwQ==
X-Received: by 2002:ac2:5210:: with SMTP id a16mr10411971lfl.279.1634292875712;
        Fri, 15 Oct 2021 03:14:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQgMT9cOGhLuYlrqwp4pUS3jckme2wuIOcB+vqpicsE0eC/dex6Vr1nu/QRypdBcOyi/UfDg==
X-Received: by 2002:ac2:5210:: with SMTP id a16mr10411936lfl.279.1634292875341;
        Fri, 15 Oct 2021 03:14:35 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id s23sm463520lfi.139.2021.10.15.03.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 03:14:34 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] [RFT] clk: samsung: add support for CPU clocks
To:     Will McVicker <willmcvicker@google.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-team@android.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20211014195347.3635601-1-willmcvicker@google.com>
 <20211014195347.3635601-2-willmcvicker@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <0e256e4e-829d-dd3f-9451-e8c4481edf11@canonical.com>
Date:   Fri, 15 Oct 2021 12:14:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211014195347.3635601-2-willmcvicker@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2021 21:53, Will McVicker wrote:
> Adds 'struct samsung_cpu_clock' and corresponding CPU clock registration
> function to the samsung common clk driver. This allows samsung clock
> drivers to register their CPU clocks with the samsung_cmu_register_one()
> API.
> 
> Currently the exynos5433 apollo and atlas clks have their own custom
> init functions to handle registering their CPU clocks. With this patch
> we can drop their custom CLK_OF_DECLARE functions and directly call
> samsung_cmu_register_one().
> 
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  drivers/clk/samsung/clk-cpu.c | 18 ++++++++++++++++++
>  drivers/clk/samsung/clk.c     |  2 ++
>  drivers/clk/samsung/clk.h     | 26 ++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
