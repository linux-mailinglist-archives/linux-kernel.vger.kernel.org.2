Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4C34563C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 20:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhKRT6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 14:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbhKRT6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 14:58:43 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B992C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 11:55:43 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id n6so16374626uak.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 11:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SSd0Cyuv9cBODmrFRgSe8o1nIwm4sr0eWjwIoBSPHXk=;
        b=UX5927ShpKzjRcmzPgd3fgzWkbVY15csEPbZfVFBxK2meRkhSSSd31OQQNPuxyP+9h
         naNuw606mUpB7J3afr6Mhbc1xEGznUtN9nA08LFrwBGTO6NP8r7cZ5dnpYRNPOzkMaKs
         nkPAHtyCMekP3Y8aFPmRcy0guFRBpdbzBNWGVPRRzGTrzEkw5GNMNzUh8e3dN9F+5EHh
         VCKLfUtSceYkGtwxiT0QHSvCp0hCEHgKG1a3XhqQgSXBRpH7ubwniI/JW8tun4oT1E5Y
         yO89lEuJm2ZVT5xdul3rI2XPG6KIIPQhZTgIqqqhy3b6KngxbDyPuVzBBGrgl6AfL+2A
         ki1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSd0Cyuv9cBODmrFRgSe8o1nIwm4sr0eWjwIoBSPHXk=;
        b=ybMtf1FMADNwRlg8HYr0HM3xwTMHTmG1QvnDgJtJczcxpqU2To3lRYEt9qJAfPD8SD
         KxKM4RhmeUL2uIS7AUwoQCWu8aMHD6/ejnCScscvhpY3xoMGMXO7uCMD1wmzl7dKqtZH
         IGziN0qZnHjAJ0QpGeSFGHV/hM07dIQEnomJx/ixKkWXUXHH8FbZs66mfLfhTbZd8G1g
         iQbqKGBxcQlsSSWFpMdKHwgrFinkDuv/xnxH8ohWzrvpeXan4X8UgkLiNvZpt61uzu+u
         fmki362zLuN5arJGwaZqlsYs+LiKAl2xRJjzL04NHUjXQ0IoNmO1/CF7NGrVGBi5Avak
         i+Ag==
X-Gm-Message-State: AOAM531UmJ6zdaG1PECGd+4jG6I5fM2U5f3guHjeKBoQcolH4kTS3nqE
        lpUlEkq3S/xnHnoKGHTCSl9UAUN7ATkwnlLUJLgLoKv5wncvIiWp
X-Google-Smtp-Source: ABdhPJza1OFpR9DqJC5nA8lGb/hAIiBNmJcgpCYVHmRO/QWzHosbmHDHX32aMabXVmkISVpvhcg0aigUuqaZ0tjo0Hs=
X-Received: by 2002:a05:6102:4192:: with SMTP id cd18mr85905750vsb.35.1637265342337;
 Thu, 18 Nov 2021 11:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20211109164436.11098-1-semen.protsenko@linaro.org>
In-Reply-To: <20211109164436.11098-1-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 18 Nov 2021 21:55:30 +0200
Message-ID: <CAPLW+4nphz7WEVAFye4tZNsYC3XqVGNCpVACCF6UAKXoUFthJQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] clk: samsung: exynos850: Implement CMU_CMGP
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-clk@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2021 at 18:44, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> This series adds CMU_CMGP clock domain to Exynos850 clock driver. In
> particular it needs to enable HSI2C (High-Speed I2C) nodes. This series
> depends on CMU_APM series [1].
>
> Tested via /sys/kernel/debug/clk/clk_summary:
>
> <<<<<<<<<<<<<<<<<<<<<<<<<<<< cut here >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>                                  enable  prepare  protect
>    clock                          count    count    count        rate
> ---------------------------------------------------------------------
>
> clk_rco_cmgp                         0        0        0    49152000
> oscclk                               1        1        0    26000000
>     mout_cmgp_adc                    0        0        0    26000000
> ...
>     gout_clkcmu_cmgp_bus             1        1        0   399750000
>        gout_cmgp_usi1_pclk           0        0        0   399750000
>        gout_cmgp_usi0_pclk           0        0        0   399750000
>        gout_gpio_cmgp_pclk           0        0        0   399750000
>        dout_cmgp_adc                 0        0        0    28553572
>        mout_cmgp_usi1                0        0        0   399750000
>           dout_cmgp_usi1             0        0        0   199875000
>              gout_cmgp_usi1_ipclk    0        0        0   199875000
>        mout_cmgp_usi0                0        0        0   399750000
>           dout_cmgp_usi0             0        0        0   199875000
>              gout_cmgp_usi0_ipclk    0        0        0   199875000
> <<<<<<<<<<<<<<<<<<<<<<<<<<<< cut here >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>
> [1] https://lkml.org/lkml/2021/10/22/979
>
> Sam Protsenko (2):
>   dt-bindings: clock: samsung: Document Exynos850 CMU_CMGP
>   clk: samsung: exynos850: Implement CMU_CMGP domain
>
>  .../clock/samsung,exynos850-clock.yaml        |  19 ++++
>  drivers/clk/samsung/clk-exynos850.c           | 100 ++++++++++++++++++
>  include/dt-bindings/clock/exynos850.h         |  17 +++
>  3 files changed, 136 insertions(+)
>
> --

Hi Sylwester,

Can you please review my patches I've submitted recently? Those are:

  - [PATCH 1/2] dt-bindings: clock: samsung: Document Exynos850 CMU_APM
  - [PATCH 2/2] clk: samsung: exynos850: Implement CMU_APM domain
  - [PATCH 1/1] clk: samsung: exynos850: Register clocks early
  - [PATCH 0/2] clk: samsung: exynos850: Implement CMU_CMGP
  - [PATCH 1/2] dt-bindings: clock: samsung: Document Exynos850 CMU_CMGP
  - [PATCH 2/2] clk: samsung: exynos850: Implement CMU_CMGP domain

My further series (like device tree patches for new dev board support)
depend on the status of above patches. So it'd great if those can be
reviewed and applied if it's feasible.

Thanks!

> 2.30.2
>
