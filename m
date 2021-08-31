Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37713FC75E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhHaMh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 08:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:32876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhHaMh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 08:37:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BA3061057;
        Tue, 31 Aug 2021 12:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630413392;
        bh=x8oUKMfborzd7l4Mojdt9/GypT+QHo0b8aTbPaWCkUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KC0tIRrGzym9C655ioN6vFUH8Oel7PuxjzZkDE5LUW5AhQmUt52Mwfco0E7vnjXHB
         O0fQrL8kmnnZLmkA93EFcAtB2GUV48bWVHw9P7byxhzPtnuhVuqfVEek1Li/jOUVms
         tl8ttmZyg1Kq5yQwjC8qw5bY8YoucOU2PZdPRhnoGiGVLSMj6/vP1oeJtVn/zrot29
         z+6uGddIZEhEtGrm/2thfOYBz7ma1ko8hUIkvzfUpSTxCGlTnUB0EZ4iXP+sHdP8wr
         vYbYW3UHgqoEKY1Svp9Bj1AFcIgEcS6qoFzU+PBjKC24w+Bob7IhuNbVQjxuIwX48C
         +4Wr3PphwPH8g==
Received: by mail-ed1-f48.google.com with SMTP id d6so26579605edt.7;
        Tue, 31 Aug 2021 05:36:32 -0700 (PDT)
X-Gm-Message-State: AOAM5331iCKbfG/cJrnfe032hn3hXtPCHW9WcRHhlXtKDUepBNl7Cw3j
        sSSOGzTT15bC+ApdiOPUg8QA2z2HHLM7pWpAig==
X-Google-Smtp-Source: ABdhPJyrimAddu7eb/68CAUFgIsoiS92nfSltev5lnlT0f3afCmS1xxQmOWHFdOGHBmyvrD2nbCt3gzcMFRuWkNLknM=
X-Received: by 2002:a50:9b52:: with SMTP id a18mr29228117edj.165.1630413390777;
 Tue, 31 Aug 2021 05:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210825134056.219884-1-krzysztof.kozlowski@canonical.com> <20210825134056.219884-6-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210825134056.219884-6-krzysztof.kozlowski@canonical.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 31 Aug 2021 07:36:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJvEgqvnTokdNjOR=XdY89TdZxUXR4--P1FXVj75z3tgA@mail.gmail.com>
Message-ID: <CAL_JsqJvEgqvnTokdNjOR=XdY89TdZxUXR4--P1FXVj75z3tgA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] dt-bindings: clock: samsung: convert Exynos4 to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 8:41 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Merge Exynos4210 and Exynos4412 clock controller bindings to existing DT
> schema.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/clock/exynos4-clock.txt          | 86 -------------------
>  .../bindings/clock/samsung,exynos-clock.yaml  |  3 +
>  .../clock/samsung,exynos4412-isp-clock.yaml   | 64 ++++++++++++++
>  3 files changed, 67 insertions(+), 86 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/exynos4-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos4412-isp-clock.yaml

[...]

> +examples:
> +  - |
> +    #include <dt-bindings/clock/exynos4412.h>

Where is this header? linux-next is now failing:

Documentation/devicetree/bindings/clock/samsung,exynos4412-isp-clock.example.dts:19:18:
fatal error: dt-bindings/clock/exynos4412.h: No such file or directory
   19 |         #include <dt-bindings/clock/exynos4412.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:398:
Documentation/devicetree/bindings/clock/samsung,exynos4412-isp-clock.example.dt.yaml]
Error 1

Rob
