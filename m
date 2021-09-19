Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0E1410D25
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 21:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhISTm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 15:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhISTmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 15:42:53 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35A6C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 12:41:26 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id e15so19548104lfr.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 12:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYTzOdcrX47mnET/O6IbbirI1g0RFSgGZ65Y7f58LeQ=;
        b=spwp/KpEFJhDnqy54onPk162/G5pw8dUturgYEWZX1FMOfciExMa+ChSfIm0Gy8Tp7
         RNSSNAW0C+T4WiMO9tsEYzDiJxApm2db0Lb18vFiJkAV7CXWDtn1ZQIUcel6NuhM6XO0
         E2sfuU7GPsSaC3q+V8/6z/J+CXq3s+xXYp7LsdlTVP7y5Kljis25gsYra++pXnn8PUFN
         Hr0J0gZOrwJKACWnGNs2mThrmdJ4MVHy+kRHw674eHZZ7d419xVC3Uq1nhQ3jvAackV9
         0yw9zsy+BNOq6NecZQqOLfpn/7rax4qcEgSGCOrJyTaNhjGQBZked2iOG8LBCcWpqwkZ
         zyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYTzOdcrX47mnET/O6IbbirI1g0RFSgGZ65Y7f58LeQ=;
        b=EsNvemPs/lvjMcaUFK0OMfiFXRHpR34C8+LloF1i8i5TWv3Kod1pN7TSddCAIzf4rC
         4W/yVSGGhNUprJGCxkL8AagGNbwFOMXkbfu4dMRVQEFoFY+vPTeTPKtg6EsRUr9AraB7
         8/5D3K/P25TePf2UEt2hsZJdiOy+SIArLZcQ/SfTTjEUlPdbGALyelW9S0T47zyz2ypx
         KlaZ9NM5PRCpxsG5eLh7A54HKS6J3XhZX5qwWiU8n6wrSYP74rR4Cg4t3WybGwiwrajK
         lvvoLwwBG/JiJwi7lazt9WQEtECJtI5JyAcveJWI4NphRXV9r51vVJKJE7CNAJi67rXb
         2sOw==
X-Gm-Message-State: AOAM5325FAXljzLEGPti7sfm+OtDaPzxLuMnCISDXNSOtBWbv1MdnSBY
        oQs8R0XZTo7HMIGeLq6mISnOEU45u6QPd6I+6+Rzkg==
X-Google-Smtp-Source: ABdhPJw+a+RYqW7LREzMJdZrkeqv0faFTmrJBsxG9VYISXMESJvXoq5ic1siEmlwm2VnTvDad1sJr+wxcffypYWMwso=
X-Received: by 2002:a05:651c:11c7:: with SMTP id z7mr18829959ljo.288.1632080484878;
 Sun, 19 Sep 2021 12:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210917105412.595539-1-thierry.reding@gmail.com>
In-Reply-To: <20210917105412.595539-1-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 19 Sep 2021 21:41:14 +0200
Message-ID: <CACRpkdb+-6dQ4F-asb0K+_9d2JtP7LXyMgjC45V=C0kpBiuAJA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: tegra186: Force one interrupt per bank
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 12:54 PM Thierry Reding
<thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> Newer chips support up to 8 interrupts per bank, which can be useful to
> balance the load and decrease latency. However, it also required a very
> complicated interrupt routing to be set up. To keep things simple for
> now, ensure that a single interrupt per bank is enforced, even if all
> possible interrupts are described in device tree.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
