Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05988389122
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348235AbhESOiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348055AbhESOiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:38:06 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5861FC06175F;
        Wed, 19 May 2021 07:36:46 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id k4so8726641ili.4;
        Wed, 19 May 2021 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDAFEEzvC0GMNw2+sRgzLq7AM8Ry0p0VtseioN3JgBw=;
        b=HJY7pYpY+CZGqyohBnzZrSYjIxma7o1SWQKjak/BF9q27IVx940a4DxjjzYrJYVaiN
         r66VAb89UPun6CBe17/HtDYZZeZGTaDe9EgludyZf/LiK9GNK81M6T1igRE+/5XJ3gji
         6+a5eVmOBYnlcen++VG6aw9WESGI4VlvklcovfDUHyCVxwfhssczWnyoJnphOcn/5jrE
         Or8pdz0NEWp0O43Sy6OTEdheRTm0DvQ0JGrtvhsa9WxQ6Iw1G8q7JBxlcYP7oZt0k57n
         AQy2eMHgsGIA1sLIZ8JOPB+zbd6TWLkTiQ2Ytx5x4H6DDZvLhenxscsyCHiqc0BhUCko
         6xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDAFEEzvC0GMNw2+sRgzLq7AM8Ry0p0VtseioN3JgBw=;
        b=RkXZZV9OZvrWBPj1D27Rav8CG34CQGGujRPBCm+Iqgmx5nCDAXzH95po9tZ6bTsMd3
         f2BvfLenDJIv4CqMKq+MFhq6h993iJhB7ZMgUwiTBrOf1f/W/dRCtI3G1zKD1o3EFF1o
         R4Q0jg7QtPkDqevdEfKtCEWhSQ6UL5fejpkdyZqOGZCRuEBOqxIFpJRFQIYdcUAsGt/N
         I3hBJw9YqhA5heGydOlqxHWP4Ltc8K+cWynP+s7vhzDDfAo7QRmPmkhF+TNKSlczK98D
         X8MYUrTaG3dV8H4HjyKu5K+MY8kSIG3t8wGn4pE7CXPSui1OGCvuy9Xq1szyMT+xE9QT
         oH0w==
X-Gm-Message-State: AOAM532/l1ssASBRUuvNtGrJDZBzCEpxZ5rQ/F1qFQOKoVhV2owPEl3a
        RAiDyPqkHBJWjcSlDLe1mOEna6bwgc8RCjaFdZK3D8Yo
X-Google-Smtp-Source: ABdhPJygUotjLagydKprqOXosGKm1YtHQhsptK/ZWsH6PbwWZqJsXqIrH8j0U0FBUjxgEKaLhqfmH+QjkPZdpaZw9Q0=
X-Received: by 2002:a05:6e02:1bce:: with SMTP id x14mr6898550ilv.287.1621435005534;
 Wed, 19 May 2021 07:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210517141250.55655-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210517141250.55655-1-krzysztof.kozlowski@canonical.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Wed, 19 May 2021 20:06:02 +0530
Message-ID: <CAGOxZ524m0tYy2Y8xnkfoSg9PQj7uA6PohYC9u23Je3F+gHjDA@mail.gmail.com>
Subject: Re: [PATCH] soc: samsung: pmu: fix BUT->BIT macro typo
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof

On Mon, May 17, 2021 at 7:59 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The macro EXYNOS5_USE_STANDBYWFI_ARM_CORE1 should use BIT, not BUT.  Fix
> does not have real effect as the macro is not used in the code.
>
Can we consider removing this? As this is not used in code.

> Fixes: af2e0a0754ac ("ARM: EXYNOS: Add PMU support for exynos5420")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---


>  include/linux/soc/samsung/exynos-regs-pmu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
> index fc9250fb3133..4bfd9a210da2 100644
> --- a/include/linux/soc/samsung/exynos-regs-pmu.h
> +++ b/include/linux/soc/samsung/exynos-regs-pmu.h
> @@ -613,7 +613,7 @@
>
>  /* For EXYNOS_CENTRAL_SEQ_OPTION */
>  #define EXYNOS5_USE_STANDBYWFI_ARM_CORE0                       BIT(16)
> -#define EXYNOS5_USE_STANDBYWFI_ARM_CORE1                       BUT(17)
> +#define EXYNOS5_USE_STANDBYWFI_ARM_CORE1                       BIT(17)
>  #define EXYNOS5_USE_STANDBYWFE_ARM_CORE0                       BIT(24)
>  #define EXYNOS5_USE_STANDBYWFE_ARM_CORE1                       BIT(25)
>
> --
> 2.27.0
>


-- 
Regards,
Alim
