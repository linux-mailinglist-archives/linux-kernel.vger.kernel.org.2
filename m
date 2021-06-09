Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6E93A1310
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbhFILoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:44:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40220 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239186AbhFILnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:43:32 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lqwaX-0005hV-FI
        for linux-kernel@vger.kernel.org; Wed, 09 Jun 2021 11:41:37 +0000
Received: by mail-wr1-f70.google.com with SMTP id n4-20020a5d42040000b0290119fef97609so816636wrq.18
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=upOJA9RE5vdAmyuKTS/wMi+tsqj8ittlIe4tXbPXaRk=;
        b=BGeUHFpkWZXLNTivnOBV2pB967PhsbSt8ZoWq4BQlYfsIPcHne2djK/2nLQVtCvQnF
         UPbTarXf3lbT71w3k6G+m+PgixUuBZxDLqzwd5rNQHNfNbOzg4faEI4Tl59/HPkFZFGH
         CbHk8kz8tttFn9i7LjE3EXWU1HatgXqptKFsa+kjGeIaRUsgEVaDxfQErZwDjstmPoBn
         XiQU8TCty586qQn0CdsOOr+ZAy0EapHVC9JoJWnju83dR7TQHwjG1qFERdA2iTzaKQ3i
         u7ovso4Pjd80cXSUpIcIdGetI/cppx+jHfXGF1J08kgnGOLfuYE5A1VGxjPI+DWfCilh
         nSuA==
X-Gm-Message-State: AOAM533CkieOJpiZga0oBPaNgLzjYbvdv/Qp8G7Oe4EZX3A8WOGLPn78
        5BqjmcJGBT/SjagLQuTszEs8O2mNLnW83Z0nktOzVVfBAWSwSmU18BXxChOkqCZfcLsW+mAt1vt
        44cc5VFyTiS5iosCCWOPfclNW5ITDWW7TfaMWTgwYEg==
X-Received: by 2002:a1c:bc09:: with SMTP id m9mr27809339wmf.143.1623238896527;
        Wed, 09 Jun 2021 04:41:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUpLz6zKKGLggAFA7+FVPvlclfbwWyQInR0T0RTysQGQfgiE2ya9oVBkUdprDeUukUMSlo9g==
X-Received: by 2002:a1c:bc09:: with SMTP id m9mr27809326wmf.143.1623238896405;
        Wed, 09 Jun 2021 04:41:36 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id n10sm10856124wri.77.2021.06.09.04.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 04:41:35 -0700 (PDT)
Subject: Re: [PATCH 1/2] clocksource/drivers/exynos_mct: Prioritise Arm arch
 timer on arm64
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20210608154341.10794-1-will@kernel.org>
 <20210608154341.10794-2-will@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <7a3213a4-5f35-17b3-3d05-a5c6f032d1f5@canonical.com>
Date:   Wed, 9 Jun 2021 13:41:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608154341.10794-2-will@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2021 17:43, Will Deacon wrote:
> All arm64 CPUs feature an architected timer, which offers a relatively
> low-latency interface to a per-cpu clocksource and timer. For the most
> part, using this interface is a no-brainer, with the exception of SoCs
> where it cannot be used to wake up from deep idle state (i.e.
> CLOCK_EVT_FEAT_C3STOP is set).
> 
> On the contrary, the Exynos MCT is extremely slow to access yet can be
> used as a wakeup source. In preparation for using the Exynos MCT as a
> potential wakeup timer for the Arm architected timer, reduce its ratings
> so that the architected timer is preferred.
> 
> This effectively reverts the decision made in 6282edb72bed
> ("clocksource/drivers/exynos_mct: Increase priority over ARM arch timer")
> for arm64, as the reasoning for the original change was to work around
> a 32-bit SoC design.
> 
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/clocksource/exynos_mct.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index fabad79baafc..804d3e01c8f4 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -51,6 +51,15 @@
>  
>  #define TICK_BASE_CNT	1
>  
> +#ifdef CONFIG_ARM
> +/* Use values higher than ARM arch timer. See 6282edb72bed. */
> +#define MCT_CLKSOURCE_RATING		450
> +#define MCT_CLKEVENTS_RATING		500
> +#else
> +#define MCT_CLKSOURCE_RATING		350
> +#define MCT_CLKEVENTS_RATING		350
> +#endif
> +

Tested on Exynos5422 (32-bit ARM) and it seems to work. I don't have
ARMv8 board to check it. We want Exynos MCT on ARMv8 as well, because
unfortunately it shares the block with Arch timer. This was investigated
by Marek:
https://lore.kernel.org/linux-samsung-soc/20181017123622eucas1p14654c89a8590fd094d638b60ab9af8f0~eZY3j27rs0422004220eucas1p1M@eucas1p1.samsung.com/

Best regards,
Krzysztof
