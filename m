Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0386C457FAD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 17:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbhKTQ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 11:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbhKTQ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 11:57:43 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A41EC061748
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 08:54:40 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id y5so27635869ual.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 08:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPe5rIg5TAJI+Z4BdmZVWGXS9QlQ4oinDcrlr5ohhMI=;
        b=hk+V1mjCFyV7kWilf668mlvKtSxX46rCHM1Y+gJ5vLFU8C4AZXmNM67255K2CEQYuA
         MB+vbS6TstZbRrARWMzRcx5+jsdVXT4f6nOukmW2bGldXyBXIuFSTwIB0JoEAqsKVIFC
         JsNPLZu8XLrQXqGIaJuT07+zv1D0Pcb4llROOHbAkmI3Mrtw9o5wTEQLf0BTrCWJS2uY
         DWIV4nakBajx9KWf4Zf9megx7KgIjE69XsIjQmFmwkg4ItrYngS8vTy7+mdl8hMPfuc2
         eiGnVWGCanDdQfD+YInqB/9gjUPcsRmL+dWikVhHBW1rgJBZw+6unJCPLCn50QG0TMHb
         kn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPe5rIg5TAJI+Z4BdmZVWGXS9QlQ4oinDcrlr5ohhMI=;
        b=ysG5PKYdWoJf0PURRRUmLolSm9RCv92aNm6EpFJpR2/VAonXzjIF+qDQ7E4JtjtU4M
         nOvzhzw4Oyu7uR9MpiHguxgyRcy7AtkAshbt8ne5Cpeyepztw2ej3NZY+ftZ1vDurad6
         oYDPCUWB0DeQEALFIzXyubbV/VVwV0KEWsyNAcfgOy7SeSE8/j9nTgC8fLX/1xBRZmO3
         v3M/DUNZ2lGCK8kLsLWSlJ27hpNgQMDtQdND3pmrFwR2pe4keFbsyQuD+DJefLTSDLos
         RWaSW2MtiQ5d5lR10H4ZtrHC1K4kWkOKSJ+b6xQbsuevId7xadpxJ7uGEEE4rifrOf4x
         eyWQ==
X-Gm-Message-State: AOAM531C/ohE2grbb4llsezpncFpuIyi3Ns6BHASJzbUPGZEbxbP30Mr
        H9mMJZo5SNv9DuqfkMHbVL2HJg46edrfJJ/iCjFqjA==
X-Google-Smtp-Source: ABdhPJyqXt7//qPUJhC6V71L3N6YBn8dxnpYFuoyKTVt4HRPFa5PUvUogS3a/dbak0HIiFSvASmvXDNaeHDC45Sr6N4=
X-Received: by 2002:a05:6102:4192:: with SMTP id cd18mr109156605vsb.35.1637427279366;
 Sat, 20 Nov 2021 08:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20211022224556.18742-1-semen.protsenko@linaro.org>
 <20211022224556.18742-2-semen.protsenko@linaro.org> <81df1c60-36b7-7b42-3bc8-2c3c7cc02c33@kernel.org>
In-Reply-To: <81df1c60-36b7-7b42-3bc8-2c3c7cc02c33@kernel.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Sat, 20 Nov 2021 18:54:27 +0200
Message-ID: <CAPLW+4m5X5LK0TLbzo40c4JC+Be21rgr_0Qck2=FsRGRVeHQnw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: samsung: exynos850: Implement CMU_APM domain
To:     Sylwester Nawrocki <snawrocki@kernel.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Nov 2021 at 14:26, Sylwester Nawrocki <snawrocki@kernel.org> wrote:
>
> On 23.10.2021 00:45, Sam Protsenko wrote:
> > CMU_APM clock domain provides clocks for APM IP-core (Active Power
> > Management). According to Exynos850 TRM, CMU_APM generates I3C, Mailbox,
> > Speedy, Timer, WDT, RTC and PMU clocks for BLK_ALIVE.
> >
> > This patch adds next clocks:
> >    - bus clocks in CMU_TOP needed for CMU_APM
> >    - all internal CMU_APM clocks
> >    - leaf clocks for I3C, Speedy and RTC IP-cores
> >    - bus clocks for CMU_CMGP and CMU_CHUB
> >
> > CMU_APM doesn't belong to Power Domains, but platform driver is used for
> > its registration to keep its bus clock always running. Otherwise rtc-s3c
> > driver disables that clock and system freezes.
> >
> > Signed-off-by: Sam Protsenko<semen.protsenko@linaro.org>
> > Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@canonical.com>
> > ---
> > Changes in v2:
> >    - Reworked clock IDs to be contiguous (don't break ABI)
> >    - Added R-b tag by Krzysztof Kozlowski
> >
> >   drivers/clk/samsung/clk-exynos850.c   | 142 +++++++++++++++++++++++++-
>
> >   include/dt-bindings/clock/exynos850.h |  29 +++++-
>
> Looks good, could you just resend with the DT binding header changes moved
> to the first patch?
>

Thanks, will do.

> Regards,
> Sylwester
