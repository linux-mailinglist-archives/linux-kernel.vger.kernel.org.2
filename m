Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409544410E5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 22:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhJaVC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 17:02:58 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34988
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229982AbhJaVC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 17:02:57 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6CAF73F176
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 21:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635714024;
        bh=zheIVMutPuHbjBVIRXc38wY0mKtLk1cbTYGUFxhZUio=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=EnU26aWJ3YKrLzLPqbyEuoqajF6nLOWIrcCulFPghloBigJu0oinsn73/r5wyJuXb
         0VzZyUCk8BZ9sz7g4N378hpjHcPkSNJ96HzZahUNQL19BrRoBQzRvKHIc5EuJNaQnQ
         9UjU3tyBuOZ7YhQbDEkmKIaA72h8y8gWG6iuNOM8VdYzwQxNB9/xFA3nrBhladCZDd
         5VBdeBBE4AHnC90K08FygOFGeVsR/LIRhdz728Iibdc9udRbzFq9kBFvg1jJwT+HrE
         m76pT9OeTswlfDo/1cGKfvcdXTrGg0lkZWAc7QuhwEu33FTZYCPr6UvjcGAln1Xit3
         oHqHAgTq+zOSA==
Received: by mail-lj1-f197.google.com with SMTP id p19-20020a2e8053000000b002119ff434a2so5102215ljg.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 14:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zheIVMutPuHbjBVIRXc38wY0mKtLk1cbTYGUFxhZUio=;
        b=KeFK4eMRprZT6+yN9ZA/Gy8Ux0Jvfyqukttb1HCBORJMSb8daC4VBUwWgyU8qGi3h1
         jpEwHIVn+Zf6UKCKf5q2dMyAd8Jrw5FvAEdxzMDUHVTj9UYLAFPK69ofAZq9H+/KhKkY
         tvqA1MtG5JIka3hOqVzXGT5/zm3OGXP7+UesOhLgNglSka+QBzbfqztCvkusDrSxIYoR
         ZR+UBmRN6iLwPWQYR2BQgB6VMSJ6/E9pi3wtlWTprI07aetc4EWRZ+b6hM3NBF6zT+9K
         N8qyIIi1GaGIpKmtqMwPpkZEWhuSVzJ4LQKE6TK0jUSLwusOihayC0g8HBofHndXazgy
         TgQQ==
X-Gm-Message-State: AOAM53085+LxwvJ27S97A+X9gngnBt+2Q/d3iuYhrEmoenmI3BtXPquF
        B/Ke4LTOj0YublVncqaeqJslRkha8sZyQiX22Ogrrb56LxEQQ12yfC+HOv/3ZpezLQP5sIRFxlp
        swL0AlmxSe8gDaPbpxSySUgPmX3wV8gv1N1GQNA9DRA==
X-Received: by 2002:a2e:9f4a:: with SMTP id v10mr26023903ljk.395.1635714023800;
        Sun, 31 Oct 2021 14:00:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQgxaVccPsVk2p8N4zrDSCPgDRB8wGv/7lN8lCli8P2SYaBslAbu1btY9ELLw0aOnw0CsyMw==
X-Received: by 2002:a2e:9f4a:: with SMTP id v10mr26023889ljk.395.1635714023661;
        Sun, 31 Oct 2021 14:00:23 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id c20sm307723lfr.149.2021.10.31.14.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 14:00:23 -0700 (PDT)
Message-ID: <1eb3e513-8795-6544-8ff6-964197a87eaf@canonical.com>
Date:   Sun, 31 Oct 2021 22:00:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 2/2] pinctrl: samsung: Add Exynos7885 SoC specific data
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211031154851.20103-1-virag.david003@gmail.com>
 <20211031155102.20225-1-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211031155102.20225-1-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2021 16:51, David Virag wrote:
> Add Samsung Exynos7885 SoC specific data to enable pinctrl support for
> all platforms based on Exynos7885.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
>  .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 81 +++++++++++++++++++
>  drivers/pinctrl/samsung/pinctrl-samsung.c     |  2 +
>  drivers/pinctrl/samsung/pinctrl-samsung.h     |  1 +
>  3 files changed, 84 insertions(+)
> 
> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
> index 6b77fd24571e..8bad82e709d3 100644
> --- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
> +++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
> @@ -441,6 +441,87 @@ const struct samsung_pinctrl_of_match_data exynos7_of_data __initconst = {
>  	.num_ctrl	= ARRAY_SIZE(exynos7_pin_ctrl),
>  };
>  
> +/* pin banks of exynos7885  pin-controller 0 (ALIVE) */
> +static const struct samsung_pin_bank_data exynos7885_pin_banks0[] = {

Please take existing code as an example. You missed here and all other
places the initconst.


Best regards,
Krzysztof
