Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BCE44800A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 14:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhKHNLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 08:11:20 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60724
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236570AbhKHNLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 08:11:19 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7D0D840020
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 13:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636376907;
        bh=/ySngP9TOMBOgvGkesTjnWFyMrTzkSO4ZS4YMXYfRzE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=PLut7+oBVWX7CFMYanxq4SIVrK9D8kOKV5ibRsqKIcsrgKfQqfkVQoPlLRvoECt8A
         TcoU49MF67F+w503HssJcJOTh510zVXriQnL80LIkji6fjNYmMNJW1yOty3GLgF2QY
         2hrY4yc/JxUqZXnyHbNZx51KA8xBpsp2Gb06vVgDYDERSJwCg+GjlUZ20sXWvOonKF
         +HkLcvdavDq/INy9du4sqq2R3RP9wOA9krf/wQ0ABn4s7fdcqa/JvjbXGi2KjGdAqG
         beBxlGZqPRLK/dTF83dtzwAKPEfefsqEzynmf2RB7H9m8ky6xq+90C40L2p0Shif/i
         CO7mLKnrH+L5Q==
Received: by mail-lj1-f197.google.com with SMTP id f6-20020a2e9e86000000b00211349f9ce3so5225299ljk.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 05:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/ySngP9TOMBOgvGkesTjnWFyMrTzkSO4ZS4YMXYfRzE=;
        b=iWsyPSePsS8sREJlPYFdCYUxrFeYLUQO5bzdKt19P/TzlXMoRe32CfC74ePSmSRSmx
         ugUIc2N1yNC3duEg5wEFAODg+jrHRiWXgCDE2WKb/mfmy6ILXFNY3oAJ24JO3ceXiXqq
         WzvKvzW1JFcGoucZ8nwk2trXo7wFQP0Mblz15O2W9zYop/nuXJt/6bUh5/WmDkctSwM8
         e0d0nz/l4s+rCztScXJV5IJOjamJ+InHle2IlIojmQfxo0ANc18Vl2OH95ESMY5cYzxw
         TdJFO5UwiiQp29VArwsezU2C6kaCl3smzzdvGq8UP6MrpaWFg7wbxHJuVbV+tdFTXclq
         LPqg==
X-Gm-Message-State: AOAM530QQAMLPyWtZ1rWCgRQQ0qWYyPoUpr92H5aq1FsKJ0mqrr6WiaH
        xM7xfoMr7U+SOWgOegB2l707s6krDg/noCS8HxNcrZz0vLiDh7e0ZtXTEdS9IXG08TPQpyQax2E
        sCn8V2VWnh0Yd7PIkjbHzqbBGRGYhoop4/XfY3MDGkg==
X-Received: by 2002:a19:7902:: with SMTP id u2mr51154106lfc.644.1636376906516;
        Mon, 08 Nov 2021 05:08:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHuzpnBktBqI6ilkx+6XnxlpOfg0UhbRIfSUF/hD5lAIIYjIFaiyVDsreV9FymtsbnDRMVoQ==
X-Received: by 2002:a19:7902:: with SMTP id u2mr51154085lfc.644.1636376906335;
        Mon, 08 Nov 2021 05:08:26 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id s4sm2011138lfi.180.2021.11.08.05.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 05:08:25 -0800 (PST)
Message-ID: <806de5b0-a7ab-9d87-589e-9fc5e6f5a400@canonical.com>
Date:   Mon, 8 Nov 2021 14:08:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 02/12] dt-bindings: watchdog: Document Exynos850
 watchdog bindings
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20211107202943.8859-1-semen.protsenko@linaro.org>
 <20211107202943.8859-3-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211107202943.8859-3-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2021 21:29, Sam Protsenko wrote:
> Exynos850 SoC has two CPU clusters:
>   - cluster 0: contains CPUs #0, #1, #2, #3
>   - cluster 1: contains CPUs #4, #5, #6, #7
> 
> Each cluster has its own dedicated watchdog timer. Those WDT instances
> are controlled using different bits in PMU registers, new
> "samsung,index" property is added to tell the driver which bits to use
> for defined watchdog node.
> 
> Also on Exynos850 the peripheral clock and the source clock are two
> different clocks. Provide a way to specify two clocks in watchdog device
> tree node.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v3:
>   - Renamed "samsung,index" property to more descriptive
>     "samsung,cluster-index"
>   - Disabled "samsung,cluster-index" property for SoCs other than
>     Exynos850
> 
> Changes in v2:
>   - Stated explicitly that Exynos850 driver requires 2 clocks
>   - Used single compatible for Exynos850
>   - Added "index" property to specify CPU cluster index
>   - Fixed a typo in commit message: dedicater -> dedicated
> 
>  .../bindings/watchdog/samsung-wdt.yaml        | 45 +++++++++++++++++--
>  1 file changed, 41 insertions(+), 4 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
