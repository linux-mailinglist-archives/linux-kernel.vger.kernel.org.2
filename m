Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73633191E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhBKSJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbhBKRna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:43:30 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62805C061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:42:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id v5so9238094lft.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jZSkmFMKUaJrbCLhz//LG/yQTwJ20UA+ZhLO4rlMv6Q=;
        b=T0oWKSDZPG/YK5zvZWGUzjfovRYMpGkdb/XjTgqTwQpfBTvZrXN1ttGWBZYE53e45Z
         qQPGnAJ0ZzD9fU3yX3VY77mBHIdbs4osp5iy125l706vTtcz1U4AJuDSV/fqoi51ld2T
         /8GeYToa3kWrJeF22TVKfHT3sdNL6YtPI4Mdvcb1VfRFfnBVkxypyv1mkJBhtUqf4Gqg
         4V35P+VzD+huWSKOvWG2lLLrRfBa0BOfZYzBsRAfBRirG70+lfcCVy/nA78+z6/ZS3BX
         qtayzEr3pCLZNW7F6YxJ57Bwb/86ldNI6ATHi8uVfc9LnrObvdraWWLqwRbjymDYIqZq
         SADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jZSkmFMKUaJrbCLhz//LG/yQTwJ20UA+ZhLO4rlMv6Q=;
        b=LWmOmG4ZPzru0+XO+5J29utLpbVwrK3Tc8ws85Efn8gtWBL9+yeM03vPV+PWJX5f3V
         t0YWXyO4mb4iWDuMZfimxiGOYPthJ2kFaZM1rGyYrzcGWblXv6n3/k8Tj+B4tQALhPEi
         Rl1k4qqV7G+Gzge+VBy3o6zpAV4tjsI6GzNxG3zJ8Y01P48q+92CLv62vDej7tT132HZ
         k5IoanMgv804ELMXNNitWql9jpFPKaWE2Y93l7uRIWY9z7XjScVqPDb4giMYlmM3tcKy
         eVfKVUJfvbp19+ogdhD5hKaJN9oznMpfDzXcHC7Fg+SO0KxnZ6xmi04ddKO5hfo22BcX
         UQaw==
X-Gm-Message-State: AOAM532CN0+Vwjo73P9lyu5gBNZDCnw20dOe0rgiqM5+7MgwUzhtexTX
        VRiaYbEcFHqzrk2YA7Qa2biWknRhaRihun1oLpFWcA==
X-Google-Smtp-Source: ABdhPJwEjxAOyjeJEGLXRk58/2TU35873Io9Pa2XEehSvA8ZGSM3T+mkDQJ8L+qf+TMBP6LCCheKFu71WNaebuV6V6k=
X-Received: by 2002:a19:6748:: with SMTP id e8mr4983032lfj.224.1613065356718;
 Thu, 11 Feb 2021 09:42:36 -0800 (PST)
MIME-Version: 1.0
References: <20210211152208.23811-1-vincenzo.frascino@arm.com>
In-Reply-To: <20210211152208.23811-1-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 11 Feb 2021 18:42:25 +0100
Message-ID: <CAAeHK+yBrWeXTXoR=_jrH55YORf6YPfcXYZOZNuEzRsuwq_CQQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Fix warning in mte_get_random_tag()
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 4:22 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> The simplification of mte_get_random_tag() caused the introduction of the
> warning below:
>
> In file included from arch/arm64/include/asm/kasan.h:9,
>                  from include/linux/kasan.h:16,
>                  from mm/kasan/common.c:14:
> mm/kasan/common.c: In function =E2=80=98mte_get_random_tag=E2=80=99:
> arch/arm64/include/asm/mte-kasan.h:45:9: warning: =E2=80=98addr=E2=80=99 =
is used
>                                          uninitialized [-Wuninitialized]
>    45 |         asm(__MTE_PREAMBLE "irg %0, %0"
>       |
>
> Fix the warning using "=3Dr" for the address in the asm inline.
>
> Fixes: c8f8de4c0887 ("arm64: kasan: simplify and inline MTE functions")
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>
> This patch is based on linux-next/akpm
>
>  arch/arm64/include/asm/mte-kasan.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/=
mte-kasan.h
> index 3d58489228c0..7ab500e2ad17 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -43,7 +43,7 @@ static inline u8 mte_get_random_tag(void)
>         void *addr;
>
>         asm(__MTE_PREAMBLE "irg %0, %0"
> -               : "+r" (addr));
> +               : "=3Dr" (addr));
>
>         return mte_get_ptr_tag(addr);
>  }
> --
> 2.30.0
>

Acked-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
