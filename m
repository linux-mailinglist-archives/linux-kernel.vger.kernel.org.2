Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E3C3EDDD5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhHPTXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhHPTXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:23:38 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD096C061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:23:06 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id a93so34978976ybi.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFPwTBww7HCfgcrya8tDZnP7/RkqO96aoh1ArMM5DY4=;
        b=vZ6ODT6K51FYe7v5j1ZJgTBaKdzBTUpxqFN4KAFDzaFqZcJzKDfjAT3i2rMh2HGSgJ
         iv06p1rxGJElyiNNUKJjZQcS4YSPt65aq4BuuoFJ8wFOXX76OyPKDK4dllYXKjiHIK2t
         uTnY+/frCK20rCUslEWC5xUe3cxqCCZSeJc/Z9P25kURFA2crXd9KJCjPq5HbChAKmp7
         gx8eBw6qmNkXBeUwFdXacMIVsvsX136dGL5jOIRWMQmH2jwym2xoxLhDtRgP+TcTyiep
         wlIwPqibVKE3eLWmauWhtEp7xORuNwrDFrVf6Y3rExuTKMTR/3u05+gGvF6lvk39jca2
         3/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFPwTBww7HCfgcrya8tDZnP7/RkqO96aoh1ArMM5DY4=;
        b=ItOqU+4Fp+CKLLsVSyUQkAbur71o9LNsxGHRH2klJTW2q9Uh8woRQJOior7vjDP303
         ZjMcn+s5wSZT8KbV8llNuz7pp974bPkWq/pS5tiP8GJPCZZEytDryaayxKEn4tjwRpmE
         oJq6hOS3dHTwMDzY4DjNM7uQELTDQaPL6LPXl0XC3y1GG505qeEgWZlyic1Af8E7OGpv
         yGLnFQbUUjeAXHwf8CYDkui5U0d/if7bebXktr9T8Wx3jeSRoP/OdY59BFmBRjC7ekil
         jvIQtSu0Ej0a2moSmWMgYLeyHOc+1LOa14qfRsICBR1u4Kiedz3qM9lmBfYGs8WWpty1
         wTpQ==
X-Gm-Message-State: AOAM532YhtYeyvIHJEazHLHxfHuR9JUBh6WsH5oN5cqqu0aej6SaDhq9
        MCSoapJxH9Rg05hbDz9T53je7rIDwqW4/MA73Ghsdg==
X-Google-Smtp-Source: ABdhPJxwXZrFe4LWrpZFpwgg7gLZvKHb3ZIrP9S0LtYkOZmaPsEtio72uZa7F9r34JcVRyMCEwKaL7zFY0sq8jjEgQs=
X-Received: by 2002:a25:505:: with SMTP id 5mr23079960ybf.157.1629141786081;
 Mon, 16 Aug 2021 12:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210816115953.72533-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210816115953.72533-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 16 Aug 2021 21:22:55 +0200
Message-ID: <CAMpxmJURiWN5dj_CQsEeE2zh1q-gvWK4HF6FXS2=ZK=yPUP_zw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] gpio: mlxbf2: Introduce proper interrupt handling
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Thompson <davthompson@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Asmaa Mnebhi <asmaa@nvidia.com>,
        Liming Sun <limings@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 2:00 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> This is just a WIP / TODO series based on the discussion [1].
> I hope nVidia will finish it and fix the initial problem sooner than later.
>
> Bart, Linus, First 4 patches may be directly applied to the tree (they are
> at least compile-tested, but I believe they won't change any functionality.
>
> Patch 5 is some stubs that should have been done in the driver.
> Patch 6 is follow up removal of custom GPIO IRQ handling from
> Mellanox GBE driver. Both of them are quite far from finishing,
> but it's a start for nVidia to develop and test proper solution.
>
> In any case, I will probably sent end this week the ACPI IRQ abuse
> part from the GBE driver (I won't touch OF path).
>
> ARs for nVidia:
> 0) review this series;
> 1) properly develop GPIO driver;
> 2) replace custom code with correct one;
> 3) send the work for review to GPIO and ACPI maintainers (basically list
>    of this series).
>
> On my side I will help you if you have any questions regarding to GPIO
> and ACPI.
>
> Andy Shevchenko (6):
>   gpio: mlxbf2: Convert to device PM ops
>   gpio: mlxbf2: Drop wrong use of ACPI_PTR()
>   gpio: mlxbf2: Use devm_platform_ioremap_resource()
>   gpio: mlxbf2: Use DEFINE_RES_MEM_NAMED() helper macro
>   TODO: gpio: mlxbf2: Introduce IRQ support
>   TODO: net: mellanox: mlxbf_gige: Replace non-standard interrupt
>     handling
>
>  drivers/gpio/gpio-mlxbf2.c                    | 151 ++++++++++---
>  .../mellanox/mlxbf_gige/mlxbf_gige_gpio.c     | 212 ------------------
>  2 files changed, 120 insertions(+), 243 deletions(-)
>  delete mode 100644 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_gpio.c
>
> --
> 2.30.2
>

Applied first four patches.

Bart
