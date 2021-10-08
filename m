Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA33C4264D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 08:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhJHGrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 02:47:39 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37138
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229828AbhJHGrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 02:47:37 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B755C3FFFA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 06:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633675541;
        bh=K6iXGmH+Xr2/o1b+hKgXwSDn2IBjQQPNyuaqrgkHtGo=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=PT1NqoZzVjJyUPAMWHuwBpPsRVP70IS/83vS9DgwnUXfSSMrJGkQGPVOXzymbuSMa
         6aG9hoH5DffhPZ6lMrGDK5nvw6LE44LJBgh374OEXA/JpXTmOrpM3gg5/9RZ0YgYxP
         ZPJeJf040IzOzOs/GOeddNGds+slas7Y2RRzP85GGB3nGShUcpHb7jOvpuafMqkkIL
         NhBQb7t6Iqv/8Za+NgXew3zMnNy9N4HDVzHV/WCBfQOhH3AKAA1cXD6uUXbPm8i4kE
         Hd3sZPCpetsX5xF3wk+RqLyp07793NU0dIXk+ucUFJHR859a2940eJ4zAeetYvHlzS
         K1rzKgOqVvjHw==
Received: by mail-wr1-f72.google.com with SMTP id e12-20020a056000178c00b001606927de88so6488237wrg.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 23:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K6iXGmH+Xr2/o1b+hKgXwSDn2IBjQQPNyuaqrgkHtGo=;
        b=q0BUNNm5Khwhxw8BN24ahIicdOwRxQxpYV+02Te8QKOv6RjlxsOJwT6EiN/1Q+Bdv9
         irMlPTQXPbUug8NISfdBadP6m75ugJVE/MXWLS9NYivPtbbMiDoEVQH0wXcAzIUQ4584
         qQrtYgQVg4kSR4IDi1E6zcDevOVsvRQ68/lESxrnEaBbhJ1DD5ooKyM2KR785r+gAULB
         d74u+wyzOMGq7G2Dr03fspJpYUd9/S6hotN9CrOl/Ofp3PXhvrEeeNRUA71NZtZp+Aqw
         Kfw0GKXYWhkYZM7EP9zCu3SBBjnLCTOvFT/OYT/5YD28MDeUCvl7pbXDwAInCeo9mG50
         h5JA==
X-Gm-Message-State: AOAM532kIci/jWUXsSNTu95eHUvtN3BwFWYAdGblh8hFi3Saf+2bhoVy
        JtF2vQZYyzQS/4gyjtGpaS+9uBQKdK0Ht1zNyBAhrOtAhGO8hnMtW7aZ9znw0w+mqjdVuEcaLLi
        mWkgch3e/tyC/zmSJa8OypxnwNWCrKstKkYoT3ceGNw==
X-Received: by 2002:a5d:5986:: with SMTP id n6mr1798224wri.75.1633675540602;
        Thu, 07 Oct 2021 23:45:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOmryVllHENNzxlkya8eUdoqWDAGCtwrtq2AttxUID67l6XccGUczuhDVl0y/YrmmVswUgeg==
X-Received: by 2002:a5d:5986:: with SMTP id n6mr1798196wri.75.1633675540394;
        Thu, 07 Oct 2021 23:45:40 -0700 (PDT)
Received: from [192.168.1.24] (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id q12sm1467343wrp.75.2021.10.07.23.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 23:45:39 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] dt-bindings: clock: Add bindings definitions for
 Exynos850 CMU
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
References: <20211007194113.10507-1-semen.protsenko@linaro.org>
 <20211007194113.10507-4-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <abe4bdeb-ee15-d8c8-54af-1cdf7282b004@canonical.com>
Date:   Fri, 8 Oct 2021 08:45:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007194113.10507-4-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2021 21:41, Sam Protsenko wrote:
> Clock controller driver is designed to have separate instances for each
> particular CMU. So clock IDs in this bindings header also start from 1
> for each CMU.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v2:
>   - Added all clock ids
>   - Added CLK_ prefix for all clock constants
>   - Added R-b tag by Krzysztof Kozlowski
>   - Added Ack tag by Rob Herring
> 
>  include/dt-bindings/clock/exynos850.h | 141 ++++++++++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 include/dt-bindings/clock/exynos850.h
> 
> diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
> new file mode 100644
> index 000000000000..a44c5f91d3c7
> --- /dev/null
> +++ b/include/dt-bindings/clock/exynos850.h
> @@ -0,0 +1,141 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

The bindings are preferred to be under GPL-2.0+BSD. I don't know about
such policy for the headers but it seems reasonable - allows re-usage in
other systems. Do you mind licensing it under:
GPL-2.0-only or BSD-2-Clause
?

Best regards,
Krzysztof

> +/*
> + * Copyright (C) 2021 Linaro Ltd.
> + * Author: Sam Protsenko <semen.protsenko@linaro.org>
> + *
> + * Device Tree binding constants for Exynos850 clock controller.
> + */
> +
> +#ifndef _DT_BINDINGS_CLOCK_EXYNOS_850_H
> +#define _DT_BINDINGS_CLOCK_EXYNOS_850_H
> +
> +/* CMU_TOP */
