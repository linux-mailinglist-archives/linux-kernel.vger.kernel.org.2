Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F2542C460
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbhJMPFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:05:09 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45834
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237775AbhJMPDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:03:21 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8B23A40016
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634137276;
        bh=xYuV2MmQladXcPP7bw44n/vAd85hc1wnSNxzKdpoKHU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=h/QXGNQ6m1uR7tRK3CIgv+bWw+nupVn7pe1kAe5t9gLcWICbqxFktHubqMlefJyXZ
         r9h/t08O0MBlx3IK3OB0k+exGFDs55Zs+JezlrzE6UtYngOOJQsf6SVXd2+QPql2Ex
         omo5Zh/p+ywpyP2Z4NPqn0X9bmxlz2Bzi3lDwV4tC5uZ9Vg8Wbs93ORlvyuZRZ20rQ
         9o69lMx7hNW9oRyHC/o09MJSDcgx8mpp4P/vShDjdMR/yR1U1xyQFxyumsND5uE59I
         I9+CwOPfynNFba8zHE7e7RDXwvUUBp03k6Le/XRWTqfNbsXtAIR2jD6uK+8cDnHxem
         T9zFtS9pJZ13w==
Received: by mail-ed1-f71.google.com with SMTP id l10-20020a056402230a00b003db6977b694so2445591eda.23
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYuV2MmQladXcPP7bw44n/vAd85hc1wnSNxzKdpoKHU=;
        b=ltUUrL17yt3erkk+/2+sUzh9dBzYembEGncne4DgFkoDw0i28fxR86VfcwCHN5h8E9
         NLEHBUWGgDseE7AgPDmQTjBoom4QRbU6w62XsXABNK7yolS5G2VIpq79ipKmm0ZvqO47
         m/ColVl/s1I/IJKR9SkuhN8PxoVaSWHASq/V5S/FmHJfOu1xZdFp/wFsDSIq3TqCT5YK
         iFD+7KvnleVplE3PEZ34fVpStLgF0XTPYZhgk5Vb9x6vgXKL9k4E3OUz+ZJyLhlGY60I
         EADBg76VF70yf7vDzu3hAWMfkysnjRxELAeK8uo9uKFH3tHn2VW+xet+/ucwlMhMtkGs
         8BWA==
X-Gm-Message-State: AOAM532JXzxmiwYejEUk1BUKC9htKGZyzzFSfWAt5ji4FAs74rtv+AcM
        F5GtLQMJki3nead859Pih3+H3bVEmgVZT5iiAd1oFBLaxi5cDs9aOzIAFIVxS9/3OLcfyLCHl3R
        0qOOFQ15JZqvldU7XoLUFNxsdUspKvfNCWBK7oLp5/3FKMBQvo06gIKw2/Q==
X-Received: by 2002:a50:cf87:: with SMTP id h7mr10281324edk.330.1634137275951;
        Wed, 13 Oct 2021 08:01:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwegVNQSzIUZzqwL+kBl/pg71DIpq9sCZIiDU4Wb8xJespMOYwK9v10kYYfIdkQ4bJOR0ucGyI5yMK1rTxX1ro=
X-Received: by 2002:a50:cf87:: with SMTP id h7mr10281285edk.330.1634137275716;
 Wed, 13 Oct 2021 08:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211013143810.2101838-1-arnd@kernel.org> <20211013143810.2101838-2-arnd@kernel.org>
In-Reply-To: <20211013143810.2101838-2-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Wed, 13 Oct 2021 17:01:04 +0200
Message-ID: <CA+Eumj5Fx6tQv9B9R9iBCP4C=f2dk3szCGcisvPHYfMWpsCCfw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: exynos: fix cpu unit name warnings
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanho Park <chanho61.park@samsung.com>, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 at 16:38, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> dtc started warning about some of the CPU addresses:
>
> arch/arm64/boot/dts/exynos/exynosautov9.dtsi:78.20-83.5: Warning (unit_address_format): /cpus/cpu@000000: unit name should not have leading 0s
> arch/arm64/boot/dts/exynos/exynosautov9.dtsi:85.20-90.5: Warning (unit_address_format): /cpus/cpu@000100: unit name should not have leading 0s
> arch/arm64/boot/dts/exynos/exynosautov9.dtsi:92.20-97.5: Warning (unit_address_format): /cpus/cpu@000200: unit name should not have leading 0s
> arch/arm64/boot/dts/exynos/exynosautov9.dtsi:99.20-104.5: Warning (unit_address_format): /cpus/cpu@000300: unit name should not have leading 0s
>
> Remove the leading zeroes.
>
> Fixes: f695b3f4c45d ("arm64: dts: exynos: add initial support for exynosautov9 SoC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks Arnd, but this was fixed with the next version of patchset.
It's my bad because I did not drop the patch from my next branch after
spotting it, knowing that Chanho will resubmit the next day and then I
would replace it. This replacement happened next day but linux next
got the older/buggy patch.


Best regards,
Krzysztof
