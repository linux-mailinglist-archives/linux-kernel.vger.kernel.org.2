Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86F2442B59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 11:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhKBKIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 06:08:36 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33082
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbhKBKIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 06:08:35 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 803143F1B3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 10:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635847559;
        bh=iopnLDRT4PEv0iqGKO5r/URHpGpD2WP/l0pXso7TuIU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=buNO03doEFc57glcY6LrCyK/i1i/9E6enX71AzZ2OSTSqz9oMh2XEZuH+xPDMOyYC
         rHXiY23bfQXFQRpQWA691tjHsQsCoBlJcsBaxUb6iyF1wL8zJ3B6OsfDjhQzj6+KiR
         sqduqa9CgDay0dtW34UjJMP2iiESnm7leDYrRaHFdO1hL07Za1TUulEb3DlUwkF4LJ
         f+emjLiTmwQSSETIEP1SULPRx5YwiByeYDUS9RxRZFwkeD3Z1vpen6ChNb9cUe/EIX
         VuoaU9NHHx8hbd2/L0wrqtrPlbsKDy3Jxkzk+tE4GuBICEm75jSf6HZHRTzBti3Khb
         d6BA54bNkrdHQ==
Received: by mail-lf1-f72.google.com with SMTP id x7-20020a056512130700b003fd1a7424a8so6817784lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 03:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iopnLDRT4PEv0iqGKO5r/URHpGpD2WP/l0pXso7TuIU=;
        b=ETqradbB+dqKbADWR1V4z3U0SGoGN6SGC1HOcgZkbFyAGkGomOQGp4QfFh6myry/uk
         zzke9OlXRQlef28SnGjYFQUlgP9M53CyQI1r/UbsN+vqfA/wodpg1fYXSqVFodXkEdT1
         D4AlWZsP335iliCSDRWEjwhXcK+JjM8jxdRCteDCN3Qq/ke8rEJD8lwpypPTqXMz5x87
         tWlVUmMHaBRkaRFlCr6a6uJySCkJhZy5PVqbgpZuog8Cr8CZ0ucqXK82J8+2ebsXebwS
         j8Ccv7AmmJsOQ2UAKp6FfunKL4jvm3eL7VS72qN8zm5Ay/a5Uudq8h+97FgMY5KCzv2P
         lnkQ==
X-Gm-Message-State: AOAM530COye8vW4gsGlSSUUZwfAXU29z+EAgb1W55bqYwYXK95ewhD5s
        9NVGqYzoJBp1n0saFl8DLJlnsg6Z7bMziLbPDkbpRj56PWZvhn+pjRdhJkIzyHyKLVtoKwpJrxb
        U+zZ0TIfgf5uVllDp3c4Fxk7pdho6g6/8W2u5UOuhZQ==
X-Received: by 2002:ac2:4db9:: with SMTP id h25mr33415058lfe.494.1635847558946;
        Tue, 02 Nov 2021 03:05:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyE6ArjJ7fk1tGDyreqp3vN6bbCH+FJsIaRpHdwMJlu2PO4wJnIKSVH1nnwqQgz4k97JTDUIA==
X-Received: by 2002:ac2:4db9:: with SMTP id h25mr33415035lfe.494.1635847558677;
        Tue, 02 Nov 2021 03:05:58 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id t17sm220669ljk.101.2021.11.02.03.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 03:05:58 -0700 (PDT)
Message-ID: <30b190ec-ec71-6b13-12cc-2822b1032d80@canonical.com>
Date:   Tue, 2 Nov 2021 11:05:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2 08/12] watchdog: s3c2410: Add support for WDT counter
 enable register
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20211031122216.30212-1-semen.protsenko@linaro.org>
 <20211031122216.30212-9-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211031122216.30212-9-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2021 13:22, Sam Protsenko wrote:
> On new Exynos chips (e.g. Exynos850) new CLUSTERx_NONCPU_OUT register is
> introduced, where CNT_EN_WDT bit must be enabled to make watchdog
> counter running. Add corresponding quirk and proper infrastructure to
> handle that register if the quirk is set.
> 
> This commit doesn't bring any functional change to existing devices, but
> merely provides an infrastructure for upcoming chips support.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Used quirks instead of callbacks for all added PMU registers
>   - Used BIT() macro
>   - Extracted cleanup code to separate patch to minimize changes and
>     ease the review and porting
> 
>  drivers/watchdog/s3c2410_wdt.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
