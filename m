Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231F3434FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhJTQHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhJTQHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:07:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ECEC061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:04:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b189-20020a1c1bc6000000b0030da052dd4fso11392936wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6LK3dgO19Er8A0Vy4HuLuhd8am1JO5JwDs4yYmEsMCo=;
        b=tGO2NXmyYBwerSCN1mWMRMkZqppRDAJWppgejQTRXFqjUCOOoVZInPDt/Z/v5CqTwH
         17M6dBOHDGrlNzPZ7qwbIZSAMToixKv1isD01pR/2CjNf2/PVFSAt77d77QGNuSK1FTk
         JMclBtzWNiSg5nCgYEliLj9xYQCXccmeaRETE/nom/EgpuiRyRyiDai87z0GDsdn/Ed+
         7abMC8TglZiLM1muRh5D50kqVK/z4vV1lfhdl+X4Q6mBwSOsVkAs1gkX6sn54O/1VFIi
         0c31BVO/Ak/Ku2he2II+yThklRSRsMt9Q6tduehVhmQOciHNNXYsO2QZZg8lbYOW9ntC
         itvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6LK3dgO19Er8A0Vy4HuLuhd8am1JO5JwDs4yYmEsMCo=;
        b=Q2mPYZATBSE8BUjhLl2FCHoqvrfMZtMKmm6UBtKLLmM1fgoa8/L+p6t5i3pA2mzFQ+
         y7U+7Jp+bYnQy0zq+FkpTeAprp8tI0ffHT5yzi3cUEOCleCtdOjMv13nQhU8czRci914
         7ZLPmY3k3rp+dV/N5xlcoN9N9N3QjZq52GAD0vfN6KRPUv1yusO7JBZRW489ZzzZYoQe
         7AfedaJMuADIme9LwwTkZ/6kVXUFhhs4m71foVCJSodh4k859K0VTHO3TteekCE0v1PV
         QmRo+khBd9I7kPrhaTS0KT0SwFEGLKlW3zSVcJoLux0+loT7RYWlAVBdODUnVyE9cOCo
         0QBA==
X-Gm-Message-State: AOAM5323SSYxUesTFuwBWi8+kN2f5DnBpm/cgWKpwxuSBQBgAwIbZbDE
        ZewB/prFsrRXvjvIV44rxFjaEg==
X-Google-Smtp-Source: ABdhPJxKzqGnu0kt8uL8SHSZ9aX357bKN0VD4bfSXdYMzAhgxn6H1uxkKKKo97ooott+OzBeU6J+eg==
X-Received: by 2002:adf:c986:: with SMTP id f6mr138627wrh.216.1634745884615;
        Wed, 20 Oct 2021 09:04:44 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id g25sm2433383wrc.88.2021.10.20.09.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 09:04:44 -0700 (PDT)
Date:   Wed, 20 Oct 2021 17:04:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 00/10] regulator/mfd/clock: dt-bindings: Samsung S2M
 and S5M to dtschema
Message-ID: <YXA+GoTf6u/Y4qLX@google.com>
References: <20211006132324.76008-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211006132324.76008-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Oct 2021, Krzysztof Kozlowski wrote:

> Hi All,
> 
> Changes since v2
> ================
> 1. Add Rob's tags.
> 2. Remove "regulator-name" from properties (all regulator dtschema).
> 3. Move "unevaluatedProperties" higher to make code easier to read (all regulator dtschema).
> 4. Add ref-type to op-mode property (patch 6: s5m8767 regulators).
> 
> Changes since v1
> ================
> 1. Drop DTS patches - applied.
> 2. Fully remove bindings/regulator/samsung,s5m8767.txt .
> 3. Minor subject reformatting and few typos in text.
> 
> 
> Intro
> =====
> This patchset converts all devicetree bindings of Samsung S2M and S5M
> PMIC devices from txt to dtschema.
> 
> It includes also two fixes because later conversion depends on it
> (contextually).
> 
> 
> Merging/dependencies
> ====================
> 1. Regulator related binding changes depend on first two commits (the
>    fixes), because of context.
> 2. The mfd bindings depend on clock and regulator bindings.
> 
> The fixes and bindings changes (patches 1-10) should go via the same
> tree.  For example regulator or mfd tree.
> 
> Another alternative is that regulator patches (1-2, 4-6) go via Mark who
> later gives MFD a stable branch/tag to pull. Then the clock and MFD
> bindings would go on top via MFD tree. Or any other setup you would like
> to have. :)
> 
> 
> Overview of devices
> ===================
> Essentially all Samsung S2M and S5M PMICs are very similar devices. They
> provide the same functionality: regulators, RTC, 2 or 3 clocks and main
> power management (e.g. power cut to SoC).
> 
> The differences are mostly in registers layout and number of regulators.
> 
> The drivers are built around one common part, mfd/sec-core.c, and share
> some drivers between devices:
> 1. MFD sec-core for all devices,
> 1. one clock driver for most of devices,
> 2. one RTC driver for all devices,
> 3. three regulator drivers.
> 
> The regulator drivers were implementing slightly different features,
> therefore one regulator binding for all devices does not make much
> sense.  However the clock device binding can be shared.
> 
> The final dtschema bindings try to implement this - share only the clock
> bindings.
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (10):
>   regulator: s5m8767: do not use reset value as DVS voltage if GPIO DVS
>     is disabled
>   regulator: dt-bindings: samsung,s5m8767: correct
>     s5m8767,pmic-buck-default-dvs-idx property
>   dt-bindings: clock: samsung,s2mps11: convert to dtschema
>   regulator: dt-bindings: samsung,s2m: convert to dtschema
>   regulator: dt-bindings: samsung,s2mpa01: convert to dtschema
>   regulator: dt-bindings: samsung,s5m8767: convert to dtschema
>   dt-bindings: mfd: samsung,s2mps11: convert to dtschema
>   dt-bindings: mfd: samsung,s2mpa01: convert to dtschema
>   dt-bindings: mfd: samsung,s5m8767: convert to dtschema
>   dt-bindings: mfd: samsung,s5m8767: document buck and LDO supplies

Looks like these are ready to be pushed.

However, I am not in receipt of patches 1-2.

Am I okay to merge 3-10 right now?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
