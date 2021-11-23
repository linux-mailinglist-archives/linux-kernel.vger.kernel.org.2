Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF8B45A3D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhKWNfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbhKWNfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:35:32 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6394C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 05:32:24 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id az37so43699980uab.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 05:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B656X/R1y6FCwSSXQ7i/LHbUAoP7IzHqASVfbbggNUY=;
        b=hshopLaJihhkFkkj31hvWnH3HhfDSedhdS16l8P8BUlTwc+slNJuullvsqix1QlSPP
         jOKKWR0UsIUvpzP+5AkGf80G1G4Gh0977teS6RLx4rYUAXsHw8RQnuaTzgDXz7LdsDaX
         IjKd9wX0t3/fxqVTJwDinmKdXYYbSbUIMEpRcIEnXJkvlT4y9dC6/s9XA8k4TAMI+ag0
         Mr0dJ9iqcEXaTtEl/Ta3SFm9F3Q3fscmL9g97+dHg3gYaLLZ9wdH8MU37Hb70etOxZ/7
         cIzjUV3q1wMMzkUvT5xjeBjXXUqI/Tacx6elMoT7xMLCUuVI6uI57E83gcPWRpFxICEp
         EMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B656X/R1y6FCwSSXQ7i/LHbUAoP7IzHqASVfbbggNUY=;
        b=A2rpvNgCeNZYJWjRYo2lwaZr5MIxluwD8ygIUQrhyX9aTh6j+oRSJ4kLDPLsjmGu0Z
         G0qT9wZoG4Tz0r7vygJLo6KK4NEFxh7p/MiW+O4tGw6ux9EeSrQMFHfTW4frvldZhQje
         RylF+/WvEXQWSjrAt1DUnY2X2GEU7tJ35tExwkuRmEKqVg0E+AO4e3G6mYz+tS6zrMzw
         Vk6BKsbohKyUGzxyhnup8yRx1v2d7QKMwx9uX7M0po+geTcgkYVAIg965I7YWZqy2y0l
         k55SwBnThJQZJxsYS6SCPKb4uvHIWkxBW24zQB1lqzf7zGa1rhOpSltW4bf0/yvt7BfE
         ud1g==
X-Gm-Message-State: AOAM5329jWcAnIs3oU4VxUJqk0qaNePOKrjqPy8o8bLCJgPk83yw62W2
        Xqu/RxbeesDuHv5NVYQoZlDbc8Ll54lNqO4reoxEpw==
X-Google-Smtp-Source: ABdhPJwWn2i8q1K5r6jyvqhbyn7LJQYZxr/kmf7GlmKjlW2wIMZ4PJXYFF8U0/26ZGfl29gLsnjcKixVq3SpMBlQHEc=
X-Received: by 2002:a67:ab48:: with SMTP id k8mr9826037vsh.30.1637674343887;
 Tue, 23 Nov 2021 05:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20211101193531.15078-1-semen.protsenko@linaro.org>
 <20211101193531.15078-3-semen.protsenko@linaro.org> <163705825120.25687.5616659207045424814.b4-ty@canonical.com>
In-Reply-To: <163705825120.25687.5616659207045424814.b4-ty@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 23 Nov 2021 15:32:11 +0200
Message-ID: <CAPLW+4kYza+oKy5qj8H+_ojdLDrvU6VSEYfQ5K8TkidhC5omrg@mail.gmail.com>
Subject: Re: (subset) [PATCH 2/2] arm64: platform: Enable Exynos Multi-Core
 Timer driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 at 12:24, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On Mon, 1 Nov 2021 21:35:31 +0200, Sam Protsenko wrote:
> > From: Marek Szyprowski <m.szyprowski@samsung.com>
> >
> > Some ARM64 Exynos SoCs have MCT timer block, e.g. Exynos850 and
> > Exynos5433. CLKSRC_EXYNOS_MCT option is not visible unless COMPILE_TEST
> > is enabled. Select CLKSRC_EXYNOS_MCT option for ARM64 ARCH_EXYNOS like
> > it's done in arch/arm/mach-exynos/Kconfig, to enable MCT timer support
> > for ARM64 Exynos SoCs.
> >
> > [...]
>
> Applied, thanks!
>
> [2/2] arm64: platform: Enable Exynos Multi-Core Timer driver
>       commit: ddb0fc6f055d12518b724fd1ee00669e07f03b96
>

Hi Krzysztof,

Can you please let me know where exactly this one is applied? I've
checked your tree and linux-next, but wasn't able to find it.

Thanks!

> Best regards,
> --
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
