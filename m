Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9582B4327CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhJRTl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhJRTlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:41:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854A1C061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:39:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n8so2103530lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53dTe2rF7ypEQLChTk9UR9zffJoI+xjwRznuUDxg9PM=;
        b=oVrqw7nqbDKKNXj7FkG1nDp39AZj/ihwpo3ccpusr9W8YDBTrboX6zOJlo8qgQf8uj
         2mXCiBLRyP4NJSYxE06t12oq4yRsQ4P94PyjB0Pv4nEz9kGTyDR7HzobD1BYVquOJyP1
         KeTx/Zy8xpw/OnxZcK2J6E0hd9qYvxYljd1P7+1V5hCcWlapXPWtt5eCBQHDdh4lPLKA
         6uwdTY7aT2oT9GKoNwD4WRfoHppsPW01qLui37UHjMj3Hz97gYNnqq6mQrpJSxu+qhma
         8J0pxsEQEQZ6EgAqKqXVpU3vjWBoK+9nX8iJiyvXxcpr56s0ojiCwtL3zvjlk9INtmnw
         9iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53dTe2rF7ypEQLChTk9UR9zffJoI+xjwRznuUDxg9PM=;
        b=1vfHBrIazRg2srvZIA8M/0C4LhWjKpjbUVfSO0vQlRTQ4YolhOQvBE3WE+un6AscTf
         hXxWhWrGoS+uV7JcnsLZKS63a/REanA1pXuFC41+NEpDBYNSpLAooiSWuNtSOhYimqc1
         dBQCcNoCnwbBIeyZaHXjOEMiTruEc+lHVL5q8GMwsHada3gOM5jCi48xxk1LHq68QjNV
         Ekfvn1kj3J9rU4j0kDmKmOTQ+Xf3LRZ9Uh72NR6uZmxKmK+Q5PyFOBjUCKFSg7hs4azL
         M8zet9EVy+xFvhXA08JacSTquVUf5AvvyoP+Kd2RaJdSNoH3dK3NzFuRMKekaNtV7RtB
         330A==
X-Gm-Message-State: AOAM530jUyASv+L/o6SzJ3fLXhdoFIzAhlizGMHpzil8x9585BNXfgrN
        ImFUzCwe+/oNZuFU40b2tsNyOQH7obLIxkxUtOXaKv5fvD8=
X-Google-Smtp-Source: ABdhPJywfzfahbWybgKUSAkYKfnjsNWg72Q0n+McXtUeVUF8bB7FuuTdWj1UT27UKWSLFR8V6Gf7E6SLmYOtw1Z2WuQ=
X-Received: by 2002:ac2:434c:: with SMTP id o12mr1646836lfl.82.1634585981601;
 Mon, 18 Oct 2021 12:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211018193101.2340261-1-nathan@kernel.org>
In-Reply-To: <20211018193101.2340261-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Oct 2021 12:39:30 -0700
Message-ID: <CAKwvOdnPotXBRWW4JEEhEYrL1oRv++bQOge8wQCBNbGuA9HYAw@mail.gmail.com>
Subject: Re: [PATCH] nfp: bpf: Fix bitwise vs. logical OR warning
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, oss-drivers@corigine.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 12:31 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> A new warning in clang points out two places in this driver where
> boolean expressions are being used with a bitwise OR instead of a
> logical one:
>
> drivers/net/ethernet/netronome/nfp/nfp_asm.c:199:20: error: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
>         reg->src_lmextn = swreg_lmextn(lreg) | swreg_lmextn(rreg);
>                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                                              ||
> drivers/net/ethernet/netronome/nfp/nfp_asm.c:199:20: note: cast one or both operands to int to silence this warning
> drivers/net/ethernet/netronome/nfp/nfp_asm.c:280:20: error: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
>         reg->src_lmextn = swreg_lmextn(lreg) | swreg_lmextn(rreg);
>                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                                              ||
> drivers/net/ethernet/netronome/nfp/nfp_asm.c:280:20: note: cast one or both operands to int to silence this warning
> 2 errors generated.
>
> The motivation for the warning is that logical operations short circuit
> while bitwise operations do not. In this case, it does not seem like
> short circuiting is harmful so implement the suggested fix of changing
> to a logical operation to fix the warning.

I agree. Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1479
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/net/ethernet/netronome/nfp/nfp_asm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_asm.c b/drivers/net/ethernet/netronome/nfp/nfp_asm.c
> index 2643ea5948f4..154399c5453f 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_asm.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_asm.c
> @@ -196,7 +196,7 @@ int swreg_to_unrestricted(swreg dst, swreg lreg, swreg rreg,
>         }
>
>         reg->dst_lmextn = swreg_lmextn(dst);
> -       reg->src_lmextn = swreg_lmextn(lreg) | swreg_lmextn(rreg);
> +       reg->src_lmextn = swreg_lmextn(lreg) || swreg_lmextn(rreg);
>
>         return 0;
>  }
> @@ -277,7 +277,7 @@ int swreg_to_restricted(swreg dst, swreg lreg, swreg rreg,
>         }
>
>         reg->dst_lmextn = swreg_lmextn(dst);
> -       reg->src_lmextn = swreg_lmextn(lreg) | swreg_lmextn(rreg);
> +       reg->src_lmextn = swreg_lmextn(lreg) || swreg_lmextn(rreg);
>
>         return 0;
>  }
>
> base-commit: 041c61488236a5a84789083e3d9f0a51139b6edf
> --
> 2.33.1.637.gf443b226ca
>
>


-- 
Thanks,
~Nick Desaulniers
