Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE770426D9E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243106AbhJHPiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243078AbhJHPiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:38:09 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8D5C061762
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 08:36:13 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id p2so10957888vst.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 08:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4nhDBFpkQ3OhvI2g1AWzivpWE6KcpjBPd9f1M1K7TQ=;
        b=Z17btP/q62dX74apbspcHVfFEYuIY9LywOEq1+kEEUCR/9ca+UDdhXGxqCGzX7NBPe
         qQ9muapped+nrWuea8jTtpVp4FHJ5FVZcexaUb7JAnAKLNCUcMXtSHWaVyxYr0eOJM2f
         TXRNhvEqqYi1Y4Mu//FAJN/gNUtBtrVmkiFoaiNDA+li2ix+nC5Z3LAK9MQdGzdtgU35
         ++yJc42IN9UeXwrBV0gUWX87VyUybSeC1+k2afGjS0KRO4zwNM9cvadLg+3fxjg+p1V/
         EZ1i+Y1vNt8r8U7F0HODWTrCQ9utu16oaflIHVK71EJ149IpCVQfHaxqyyxArQpSCH2m
         Jwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4nhDBFpkQ3OhvI2g1AWzivpWE6KcpjBPd9f1M1K7TQ=;
        b=COKoPx6i6MiJEOzv4OfVGyl0l7dClXCQPS20aQNVlDqwLye5vNvfzXogbOrPSapb+H
         e3SH1MUJ0OxM/ucJCpRuXJqifxdoHbH3P3qtt95P/gavi8f37tIMC5+75l0pq95OPMxX
         yPkQmjMYez+btF0tYODkhZ/Yuuv6eQ+kZE35MoE2mz5CAvWOeMvhF39Zg7/oadhYBlOI
         NKCODVG5hp+mwV8okGvzWMld3umPWm7zIAecDHP7RvRCE18yGByUMiPYa/LyM2+zvdLv
         UJIDrBgF0XVKWe6CyELNzv3XODUiFksrLdhOXz/XVw2HWdPx6mVLiQ+XDm3QO7FGuyiO
         1fzg==
X-Gm-Message-State: AOAM531Ts0BRRlzVTyjECCoWmtI5OcFAm0m0kSbUnRtHih9w8RaGKGIt
        EZi2inh28Kin8/GJWn833te2s13kxGCkCKFcRWwrhQ==
X-Google-Smtp-Source: ABdhPJyMQrRYQwHnfarCdub52YE0GDbV1FpxQ2BM2K6D7ApqiYrKumsl13YX6wTzgVFXKvbgkf36xNYUGoWwBIwzLcw=
X-Received: by 2002:a67:ab48:: with SMTP id k8mr11390612vsh.30.1633707372648;
 Fri, 08 Oct 2021 08:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211007194113.10507-1-semen.protsenko@linaro.org>
 <20211007194113.10507-6-semen.protsenko@linaro.org> <7e255da8-cb4c-6960-a68e-3d9c0399f51c@canonical.com>
In-Reply-To: <7e255da8-cb4c-6960-a68e-3d9c0399f51c@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 8 Oct 2021 18:36:01 +0300
Message-ID: <CAPLW+4nVd1C+H3VmHMD1yzkkxtyhz62Y91h7oUm7uw6q_5s_sw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] clk: samsung: Introduce Exynos850 clock driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021 at 09:54, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 07/10/2021 21:41, Sam Protsenko wrote:
> > This is the initial implementation adding only basic clocks like UART,
> > MMC, I2C and corresponding parent clocks. Design is influenced by
> > Exynos5433 clock driver.
> >
> > Bus clock is enabled by default (in probe function) for all CMUs except
> > CMU_TOP, the reasoning is as follows. By default if bus clock has no
> > users its "enable count" value is 0. It might be actually running if
> > it's already enabled in bootloader, but then in some cases it can be
> > disabled by mistake. For example, such case was observed when
> > dw_mci_probe() enabled the bus clock, then failed to do something and
> > disabled that bus clock on error path. After that, even the attempt to
> > read the 'clk_summary' file in DebugFS freezed forever, as CMU bus clock
> > ended up being disabled and it wasn't possible to access CMU registers
> > anymore.
> >
> > To avoid such cases, CMU driver must increment the ref count for that
> > bus clock by running clk_prepare_enable(). There is already existing
> > '.clk_name' field in struct samsung_cmu_info, exactly for that reason.
> > It was added in commit 523d3de41f02 ("clk: samsung: exynos5433: Add
> > support for runtime PM"), with next mentioning in commit message:
> >
> >   > Also for each CMU there is one special parent clock, which has to be
> >   > enabled all the time when any access to CMU registers is being done.
> >
> > But that clock is actually only enabled in Exynos5433 clock driver right
> > now. So the same code is added to exynos850_cmu_probe() function,
> > As was described above, it might be helpful not only for PM reasons, but
> > also to prevent possible erroneous clock gating on error paths.
> >
> > Another way to workaround that issue would be to use CLOCK_IS_CRITICAL
> > flag for corresponding gate clocks. But that might be not very good
> > design decision, as we might still want to disable that bus clock, e.g.
> > on PM suspend.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> > Changes in v2:
> >   - Used of_iomap() for the whole CMU range instead of ioremap() in
> >     exynos850_init_clocks()
> >   - Used readl/writel functions in exynos850_init_clocks() for consistency
> >     with other drivers
> >   - Added all clock ids
> >   - Added CMU_DPU
> >   - Implemented platform_driver for all Power Domain capable CMUs
> >   - Moved bus clock enablement code here to probe function
> >   - Used clk_get() instead of __clk_lookup()
> >
> >  drivers/clk/samsung/Makefile        |   1 +
> >  drivers/clk/samsung/clk-exynos850.c | 835 ++++++++++++++++++++++++++++
> >  2 files changed, 836 insertions(+)
> >  create mode 100644 drivers/clk/samsung/clk-exynos850.c
> >
>
> Thanks for the changes, awesome work, I appreciate it.
>

Thank you for review, Krzysztof! I'll send v3 soon. Hope this series
can be applied before next merge window.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
> Best regards,
> Krzysztof
