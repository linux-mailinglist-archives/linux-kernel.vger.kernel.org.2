Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41EB3FB182
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 08:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhH3HAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:00:15 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46310
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232358AbhH3HAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:00:10 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 527274076F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 06:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630306756;
        bh=TfCd6FiaT8DSxbI3Ba5RISkJ5knMWyV+1tKQL4oN4Pk=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=g9TwuTwcsWlworIL0foJevvgTkc3ttp9FhHFWRpF7p3AwO5JXlb3QS0zwsQ4RcyhK
         3/5vIoL9dvLBy33Uln5bcwUF/H4kGjCwKQlrwMaC+K/Rd/XbYks9B65y5OVVLUdbYb
         3CRWzRNbXWYRS7V2DzeMzQ8YL0ZrUI50f3vTnI7emzAGBhLLDB7Dwi4zKrh34PL/7z
         bDLdA93voZ84cjHGLacZtRSwyFNNQGZR/M0w2gi8zPbffeIbb+UotW3ncgu6qIY6tq
         MsWIyAj6uSQxKrSpihTLYgt867XfRL+7r3p+MZaLgzKADNpm6r82H1hgB+tt7dhGA3
         nI1JaVxdgmx2g==
Received: by mail-wm1-f71.google.com with SMTP id g3-20020a1c2003000000b002e751c4f439so9645308wmg.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 23:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TfCd6FiaT8DSxbI3Ba5RISkJ5knMWyV+1tKQL4oN4Pk=;
        b=HK/x+cJwMjCo9kPlIM1xnLNghyNIk9ImCInqfzSyRS+7cfqxiwwjqylmAs7SmMCQ80
         MfC2VP3/xei3rKkDHWByUBS6As5YbugiZOUjstW0sQMFiDsBCNTK/7mcGEwgdKczx160
         Fnh3zJcdwTnBjiS9siyOEPM2eLtwRjOAe/c/CPUPwbaeI96jgamEI7iw8oex6fswIVLU
         lLUNV+5Tzu2Lm24AVdXA2QeVMxbTfZTEl3tLNO55ildyohvlCighJbhMPue9OFPq09Ei
         +0qkwrpA732jN2uXcHUcXKIO8SuRy6UqUl9vz1pbM9nKMreTIdCB0QEy0Bi+CNtR1R8T
         bl1A==
X-Gm-Message-State: AOAM533+9uNpaaekMphNZNzGzClTghDFWOrqjYAYVJMee3mkWZ/R1ZRn
        NP65FPF/kwstdgyCg0uzImLg6z+qHn/1W/0yeTo+vobnZqYozPDoffQkEeU2GrVA0AbwDQuvmid
        FI9HlkwjmchUozUSKSiY3T2+UoTVAEnoczzcHI9aX8g==
X-Received: by 2002:adf:e509:: with SMTP id j9mr24038746wrm.320.1630306756045;
        Sun, 29 Aug 2021 23:59:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0ZqYN0bkagHGWkHbzTZbv9x4AkRZKERJlpklYIFSr1ahy2vKEcx4g1ux82suPSSvCeeexxg==
X-Received: by 2002:adf:e509:: with SMTP id j9mr24038730wrm.320.1630306755877;
        Sun, 29 Aug 2021 23:59:15 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.112.21])
        by smtp.gmail.com with ESMTPSA id z17sm10180474wrh.66.2021.08.29.23.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 23:59:15 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: clock: samsung: include S3C/S5P header
 bindings
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210830065647.5386-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <69d4b87b-74f8-8107-d4b2-19b4c28910b4@canonical.com>
Date:   Mon, 30 Aug 2021 08:59:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210830065647.5386-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2021 08:56, Krzysztof Kozlowski wrote:
> Include S3C24xx, S3C64xx and S5Pv210 SoC clock headers with bindings in
> the Samsung SoC Clock drivers entry.  The clock drivers for these SoCs
> are already covered.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eee4c926003b..c17299c30ea7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16582,6 +16582,9 @@ F:	Documentation/devicetree/bindings/clock/samsung,s3c*
>  F:	Documentation/devicetree/bindings/clock/samsung,s5p*
>  F:	drivers/clk/samsung/
>  F:	include/dt-bindings/clock/exynos*.h
> +F:	include/dt-bindings/clock/s3c24*.h
> +F:	include/dt-bindings/clock/s5pv210*.h
> +F:	include/dt-bindings/clock/samsung,s3c64xx-clock.h
>  F:	include/linux/clk/samsung.h
>  F:	include/linux/platform_data/clk-s3c2410.h

Ignore it, please. I just sent the same patch second time... I need more
coffee.


Best regards,
Krzysztof
