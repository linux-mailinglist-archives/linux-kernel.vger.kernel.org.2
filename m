Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A81454D03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbhKQSYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbhKQSYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:24:17 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE27C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:21:18 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id c32so12870683lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxZZyaqSeECbHShUU1e6nyZolvCataFx7XMR5EnugzQ=;
        b=nV6v3kvHfDOsEHa//unuk7hKY+T8Ur2ySWyOBtNUwXxGo0Q+OZS2LIzQDzIbLzJ+Dm
         j/dOowu1LlkmuceMaozN0Jwv9xLst7l/Paoe/ND/GUMSezAzhHMjzKwEGCXqcT1kStLQ
         nnRJvjqZWtSNg4jDeQydDlmuCmtoZVNmVrCT1u4hJ6hlqfx8Ki4rUqp1dxQgiE7elSfH
         CDRRP8Lr/nS2+RawPguXhxIfRYQZ2ITy8MaFmJAlQfOk0e8+kdpdWprwhyMwJtFK32Ss
         aD8T4mLfBwvcw2mGvQVIB52ntFSDqcarxp8kHMzHD4um+7z7u+2np3tCbrnDO6vbgEO3
         T2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxZZyaqSeECbHShUU1e6nyZolvCataFx7XMR5EnugzQ=;
        b=dVYXoLmTBuLpBsP3TdowZKwzcmCb3XTn/1PLSU45RA6ZzEYJ9GCI9J+6PFU935Qpq4
         IJBNDbRruupeMN71Bxir2lrmh+7FwkngSrBttsvmOct/B+OUd1+4ZC2SY4UjhXdFbxBL
         CYxaz2k4kcVfo+o8FPrJLKs8sT0vqDnQ9iRWvWhUpKoEekOpTKHFCTHuwzF6i+D5tzfr
         j07Z3px+cGKdla72RZpAguXhm0n5SEQFu5+vyMCa646gPQyuZ5nK6JtJrorlLa6ROGJD
         ClG1b0J9eVfB4Z2zCFmPsTzJWm5uksFN6aDR3/jCfjNfKEIVULb8KyEwL1F8uS2teNGD
         lSGw==
X-Gm-Message-State: AOAM5304wzyBzEvdleq+BafHlEA9RbHct5v6f8mYYMUSrqmF/a+DhVBv
        WwuMAtDMV5TmExvoyFG5UBO+vCrOwKtGSYKlY9IENG+3hbk5Yw==
X-Google-Smtp-Source: ABdhPJyFikjXXqzOj6YkMgayYjCdOOLM33cYMaMMto7XQuyQf9aixUnlVx2PnbTYswd4ixaLlpqH/pKdJwSf4lvJCf0=
X-Received: by 2002:a05:6512:3b9c:: with SMTP id g28mr17505579lfv.651.1637173276868;
 Wed, 17 Nov 2021 10:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20211021214500.2388146-1-nathan@kernel.org>
In-Reply-To: <20211021214500.2388146-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 Nov 2021 10:21:05 -0800
Message-ID: <CAKwvOd=Y50SvJiu=cxtEoogxJabdREh2tEX+wYn8FWs0si8vSg@mail.gmail.com>
Subject: Re: [PATCH] soc/tegra: fuse: Fix bitwise vs. logical OR warning
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Anders (combining
https://lore.kernel.org/all/20211117142115.694316-1-anders.roxell@linaro.org/).

On Thu, Oct 21, 2021 at 2:45 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> A new warning in clang points out two instances where boolean
> expressions are being used with a bitwise OR instead of logical OR:
>
> drivers/soc/tegra/fuse/speedo-tegra20.c:72:9: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
>                 reg = tegra_fuse_read_spare(i) |
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
>                                                ||
> drivers/soc/tegra/fuse/speedo-tegra20.c:72:9: note: cast one or both operands to int to silence this warning
> drivers/soc/tegra/fuse/speedo-tegra20.c:87:9: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
>                 reg = tegra_fuse_read_spare(i) |
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
>                                                ||
> drivers/soc/tegra/fuse/speedo-tegra20.c:87:9: note: cast one or both operands to int to silence this warning
> 2 warnings generated.
>
> The motivation for the warning is that logical operations short circuit
> while bitwise operations do not. In this case, it does not seem like
> short circuiting is harmful so implement the suggested fix of changing
> to a logical operation to fix the warning.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1488
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Fixes: 25cd5a391478 ("ARM: tegra: Add speedo-based process identification")

> ---
>  drivers/soc/tegra/fuse/speedo-tegra20.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/tegra/fuse/speedo-tegra20.c b/drivers/soc/tegra/fuse/speedo-tegra20.c
> index 2546bddbab93..4984246605ae 100644
> --- a/drivers/soc/tegra/fuse/speedo-tegra20.c
> +++ b/drivers/soc/tegra/fuse/speedo-tegra20.c
> @@ -69,7 +69,7 @@ void __init tegra20_init_speedo_data(struct tegra_sku_info *sku_info)
>
>         val = 0;
>         for (i = CPU_SPEEDO_MSBIT; i >= CPU_SPEEDO_LSBIT; i--) {
> -               reg = tegra_fuse_read_spare(i) |
> +               reg = tegra_fuse_read_spare(i) ||
>                         tegra_fuse_read_spare(i + CPU_SPEEDO_REDUND_OFFS);
>                 val = (val << 1) | (reg & 0x1);
>         }
> @@ -84,7 +84,7 @@ void __init tegra20_init_speedo_data(struct tegra_sku_info *sku_info)
>
>         val = 0;
>         for (i = SOC_SPEEDO_MSBIT; i >= SOC_SPEEDO_LSBIT; i--) {
> -               reg = tegra_fuse_read_spare(i) |
> +               reg = tegra_fuse_read_spare(i) ||
>                         tegra_fuse_read_spare(i + SOC_SPEEDO_REDUND_OFFS);
>                 val = (val << 1) | (reg & 0x1);
>         }
>
> base-commit: 519d81956ee277b4419c723adfb154603c2565ba
> --
> 2.33.1.637.gf443b226ca
>


-- 
Thanks,
~Nick Desaulniers
