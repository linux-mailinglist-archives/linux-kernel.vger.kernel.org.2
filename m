Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1D5435E44
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhJUJuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhJUJuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:50:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFD5C061749
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:47:59 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k7so18820wrd.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lKGVjbL49C9IWIYQqpjC2PXsmPulEO+l/Pat1ptIc3E=;
        b=Hq4yXSuTlkDVT0gxY31GJkYapw+cEGZi4ao1uuG4Y2cSsVLxtvZPySdjsDvusd7dZv
         EScrvyyDMBKRi+A+hDMgaNFD37ttve+vTh6cW3e23bEhBc1eCrfKft6vfYCy7ouwn2Fi
         AA+rMf6Q729RXCcgc3vMaaS6nwxIcyguE4sHok444G8RlMcV3TQp7nU/4LET9DfGuwnK
         cVhGIzwQhZdlRTzVYFwavoNfCjjGsNWHh4tud2yY9szuC6MqemK/32u+hx6gZqZY4ZGg
         TjLm64elX8yFZk+4rB8Ysqqo43AD8KCB75YuwptbBnBxV3u1ztpA5TkiHfX6JEiFy01n
         dP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lKGVjbL49C9IWIYQqpjC2PXsmPulEO+l/Pat1ptIc3E=;
        b=Oz/xJ+SyrSLVkwXGhQem+UaNObRC6x2+gQlVZWBRLBV8/C5mJKz/TmnCDdnyB8FWjf
         7DVbgkKQDytWF79OQp/Ca4LITHq9q94qmR3dVHz0pNx8mJfBJwOH9yEygg95TwrPVYNG
         qyHJK+9NeQPLwPakksEwo0J/l27zoEydB3364O3rdYTsf4DdyajNI9uMeY/U+r3TTmNP
         CH6zHZlPoGo2dSYCJDnEBfyD5J/TMGrt0Bnoxu8jQMzPH4dVdpIqJvSQRL6OtBINRQiq
         LEQYzlNNKxxSx/Z8Ay/NhpzdwExOsbcgLZ/CYztXVoDJ7qjXEOMEXb+Cf7HAeSko+q/w
         4zdg==
X-Gm-Message-State: AOAM530sssYREq4MZ2c0Nyshpmxp57zvZbOR6mmBpXD0UWp/4CpZiTnr
        4NyGbzT+wCLbMsbAbRS3NTJMbw==
X-Google-Smtp-Source: ABdhPJyMd7PYTTUtErxJ+Ablsp0A2GmiaEtRDtLp8CzGC++lJt5dl29tYXcUwrc9vhWVkwdVcQZhgA==
X-Received: by 2002:a5d:6501:: with SMTP id x1mr6073818wru.77.1634809678520;
        Thu, 21 Oct 2021 02:47:58 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id o6sm7569355wms.3.2021.10.21.02.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 02:47:58 -0700 (PDT)
Date:   Thu, 21 Oct 2021 10:47:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 09/10] dt-bindings: mfd: samsung,s5m8767: convert to
 dtschema
Message-ID: <YXE3TK5JXjkjC9k0@google.com>
References: <20211008113723.134648-1-krzysztof.kozlowski@canonical.com>
 <20211008113931.134847-6-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211008113931.134847-6-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Oct 2021, Krzysztof Kozlowski wrote:

> Convert the MFD part of Samsung S5M8767 PMIC to DT schema format.
> Previously the bindings were mostly in mfd/samsung,sec-core.txt.
> 
> Since all of bindings for Samsung S2M and S5M family of PMICs were
> converted from mfd/samsung,sec-core.txt to respective dtschema file,
> remove the former one.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/samsung,s5m8767.yaml         | 269 ++++++++++++++++++
>  .../bindings/mfd/samsung,sec-core.txt         |  86 ------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 270 insertions(+), 87 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/samsung,sec-core.txt

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
