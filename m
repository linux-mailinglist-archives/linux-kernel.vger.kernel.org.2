Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528F43F7BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbhHYSA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 14:00:28 -0400
Received: from mail-oo1-f44.google.com ([209.85.161.44]:41815 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhHYSAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 14:00:25 -0400
Received: by mail-oo1-f44.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso61901ooq.8;
        Wed, 25 Aug 2021 10:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZrM5Epoo74sm/kt4wx9mo69TrpmEQ3qMo82ZHzdzhGo=;
        b=fEnwNCwTN8dKXPFegHgqFQs9h5Mnu7rtMTszr/ONDdwYJfLioSSaItCTNC0JRM5Ihm
         /szpLCj8gsb/ZFpPKnTvn6WV9wHVaRNLBU6JS5CBQGqNhyNSx+ZoElgOg5VXpsSAjviY
         jFKhrh/Fap2WjmlnIXYdMlo9OoR/xrUSDVM0x0R8aSP7ivZbHRXdDYV0uksa7TV80d5X
         WbG0X8kwgFcDqbBp002/jCojzZ81cMJWLzwOItBsFFIy4kWNffzO2hY+lriVNOgTK8AL
         L9avh/IW1G/994lvdAzh5p98qkbzySBfnx59Q7DV4LBSXETrJM/ja22FuIqSRN9nd+WT
         ZLsw==
X-Gm-Message-State: AOAM530aQiGZp0E1MtM3JOJIaztmk3xUA2fik+IDoDQq8cvuCOJTf6YN
        +I18LT+xwncd1tDRz9Q85w==
X-Google-Smtp-Source: ABdhPJw7ri7y/07bKnMFJT3Wt2+BTJxAWa45zytD0FdTHGGzylw1Wx617wSCb5O/A+c+duS7VJ3hxw==
X-Received: by 2002:a4a:e923:: with SMTP id a3mr35184661ooe.45.1629914379560;
        Wed, 25 Aug 2021 10:59:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u18sm101188ooi.40.2021.08.25.10.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 10:59:38 -0700 (PDT)
Received: (nullmailer pid 3021286 invoked by uid 1000);
        Wed, 25 Aug 2021 17:59:37 -0000
Date:   Wed, 25 Aug 2021 12:59:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: samsung: convert Exynos5250
 to dtschema
Message-ID: <YSaFCcsNGp9Ut5fS@robh.at.kernel.org>
References: <20210825134056.219884-1-krzysztof.kozlowski@canonical.com>
 <20210825134056.219884-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825134056.219884-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 15:40:49 +0200, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos5250 clock controller bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../bindings/clock/exynos5250-clock.txt       | 41 -----------------
>  .../bindings/clock/samsung,exynos-clock.yaml  | 46 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 47 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/exynos5250-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
