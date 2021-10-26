Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA4843B59C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhJZPcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:32:15 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41878
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230342AbhJZPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:32:13 -0400
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6E4DE40278
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635262188;
        bh=WSJF9KCqXo5B633RP/TS84McxX2RgkL3V5mZBciirmg=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=SpFEJpiCSMyUIFGSrjANcYREQx3NFW09vYCzAsM89Vcql+U/oItlal9xkoJ+BCUcP
         6eK8IppgrvYjQC/u/rU54jp6NUdxFqSwHS7UqSR2UA3pP3T7sv4POaKPdUaMcnDt6T
         8J2ePsZb8+TsFgcrZ925i7ZhZjrCEaLKACCojaJ21AVc34T6chtWZ46gboME0N5ONM
         SmoZ7eUlSW8witUuAj3sMe8rvovxRKuN9A91rB8zLx/dRzY/z0teb3JkbNLtVrtAvi
         hje9ubp12df/bTwvfe7t7v0u81yK5Dk8uM9jmFHnzoWY+rSekSzlOtud8MLVzmqcNC
         hoVOej4tIG7dA==
Received: by mail-lj1-f200.google.com with SMTP id v13-20020a2e2f0d000000b0021126b5cca2so4510008ljv.19
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WSJF9KCqXo5B633RP/TS84McxX2RgkL3V5mZBciirmg=;
        b=RCgLZJ0InYphI7gIUdZkasBsloPtUpcAGfDcVs10IaY3pGxVLw3bq25gpCJhYGv4s3
         hmwUK1a+qPO5wTbup3YpvfcHhy3Xeec9RsaamVu1tnh0wJ36/66tpWAun8NVKhY1aI0o
         Jwxrzby5MADProLtiGJ4eOmJ0S22wAV4gLKu5pTazui9Z1imSl6ciJcjf5eNRDGckNHp
         15NFXVV7zUOrSTYxogHK1DXYEeRWsn5j9L30DMTBQ+iyVJMWrbx5Q4eCAzudUn0RigKe
         8DxzRAxd/ZPsrdBafqtXbcpSC3D6gAA+m4NTiEhqBUVPaXA05TLyH49yfDZ2qf90XKV7
         gfdg==
X-Gm-Message-State: AOAM530kAy9zRJokQYGr+r3xS15P5rAYToN0WXFKvXjnd20k0ZsXPOXY
        zahfUCKEGQe4WkjdeAjxlYnQvNwpUOoji8yRmPZO7vImx0n1s6pAMD1pYY6ojU700lRkU4RQ/0/
        oHThMD9Vr/H0pVviFXskCXxXrBp9LW+BXlhyfmpp1zQ==
X-Received: by 2002:a05:651c:230e:: with SMTP id bi14mr26414048ljb.467.1635262187756;
        Tue, 26 Oct 2021 08:29:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyk7sNJbWjdv3xhjfE+UFgqNsGbUUen1K1mx8YhCM7+SWcWNWstn2HGR1lnvG7kYqDxBpr9RA==
X-Received: by 2002:a05:651c:230e:: with SMTP id bi14mr26414022ljb.467.1635262187572;
        Tue, 26 Oct 2021 08:29:47 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id bp40sm441461lfb.78.2021.10.26.08.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 08:29:47 -0700 (PDT)
To:     Will McVicker <willmcvicker@google.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-team@android.com, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20211015190515.3760577-1-willmcvicker@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v1] clk: samsung: update CPU clk registration
Message-ID: <cbdbf565-6403-39d3-a4cd-817e515d89a0@canonical.com>
Date:   Tue, 26 Oct 2021 17:29:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015190515.3760577-1-willmcvicker@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2021 21:05, Will McVicker wrote:
> Convert the remaining exynos clock drivers to use
> samsung_clk_register_cpu() or if possible use
> samsung_cmu_register_one(). With this we can now make
> exynos_register_cpu_clock() a static function so that future CPU clock
> registration changes will use the samsung common clock driver.
> 
> The main benefit of this change is that it standardizes the CPU clock
> registration for the samsung clock drivers.
> 
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  drivers/clk/samsung/clk-cpu.c        |  2 +-
>  drivers/clk/samsung/clk-cpu.h        |  7 ----
>  drivers/clk/samsung/clk-exynos3250.c | 54 ++++++++++++++--------------
>  drivers/clk/samsung/clk-exynos4.c    | 25 +++++++------
>  drivers/clk/samsung/clk-exynos5250.c | 13 +++----
>  drivers/clk/samsung/clk-exynos5420.c | 27 +++++++++-----
>  6 files changed, 67 insertions(+), 61 deletions(-)
> 

Looks good. Tested also on Exynos5422 board:
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
