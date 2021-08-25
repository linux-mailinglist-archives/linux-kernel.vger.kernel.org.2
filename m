Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DC63F7E64
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhHYWZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhHYWZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:25:27 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17C7C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:24:40 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id w4so1263784ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pefv3vqeuX4St3jq1M8WoFYRA23I6Vantt927BxIQWs=;
        b=BP2XN95TUO4FCewyvtBSKoUYV91MsxpU7QgGaCD8hT4gXyDLb7kDO2ZfMsI+o6H6uT
         cGujPLV11zoBwI+6fSX5RqN6E6pMYPmbgdvZw/qW2Ceoq3yhpO+TFh1gbpwudDndGhRQ
         f8VDUVrrlMiDt3klbqiesvqgz4Dod5LHAg6XC/inw8ieM9rmeq3U16BO8c0Ek5I3Y6ac
         jMr9lur+B9S78rtq8scQZah6tVGPrFXHRh+grDxsCfrtuOQHX+ZSdmrCltFNo23eo9YI
         R/ZdZwf1Yt7N0dVwz/2kZj9Y237lH8Xb1UYCsCuyMZXU7m1b83YOEtjHVXEEnS/yMAwg
         FhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pefv3vqeuX4St3jq1M8WoFYRA23I6Vantt927BxIQWs=;
        b=OHUMuZJtynhmD/6PHrT1xmCUWaRq5kSdGrGG82GA0NG0P35EdxLWrrkD1xw7YS0jIN
         JaJul1Guo1MbCzGO32EcesyfLEburMHTww/k8ynARNefN/O83MmGzo0NdCvBrspGW/pV
         BFgrEJYfcZivXiFcBLPvEoSI0iKo/45/UTB/inGq7Vlh6xkbZoFWQpdN1u3Is95qTxu7
         RrT1UFnQpIHA5cRemU7ISppr9ijuUzhL8PsFA/8RjKeCuOs9e5HR5Mqj457PvJ//+bci
         CKy57DjLd7vbIURdE0yGcb11hvfMvdStfXz1P9Af0b/TjDZJgehwUV+8eD0+ZKxNHlDD
         1KTw==
X-Gm-Message-State: AOAM530+VH0JVGJiVq1997rnQyY5jdwnGLS61okr+5pyFmA/tlz+iyL5
        IZFPoc9BOrnlgBetTLdTCoTficOv34y3zssMNSQ0JA==
X-Google-Smtp-Source: ABdhPJx+FeHmFusBrwqx+OAc5/miMkJd27ZcnkZ41M9LlffmghNx66RVZdIkPMCYD61NPk+oQjdmqd+mdM+X1Z3/b2E=
X-Received: by 2002:a2e:a788:: with SMTP id c8mr401858ljf.116.1629930279047;
 Wed, 25 Aug 2021 15:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210822103107.28974-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20210822103107.28974-1-lukas.bulwahn@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 15:24:27 -0700
Message-ID: <CAKwvOdk4iqT0pW7eLQyQggWMkfeJENTeavehexeCO86yjDcXyw@mail.gmail.com>
Subject: Re: [PATCH] crypto: sha512: remove imaginary and mystifying clearing
 of variables
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 3:31 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> The function sha512_transform() assigns all local variables to 0 before
> returning to its caller with the intent to erase sensitive data.
>
> However, make clang-analyzer warns that all these assignments are dead
> stores, and as commit 7a4295f6c9d5 ("crypto: lib/sha256 - Don't clear
> temporary variables") already points out for sha256_transform():
>
>   The assignments to clear a through h and t1/t2 are optimized out by the
>   compiler because they are unused after the assignments.
>
>   Clearing individual scalar variables is unlikely to be useful, as they
>   may have been assigned to registers, and even if stack spilling was
>   required, there may be compiler-generated temporaries that are
>   impossible to clear in any case.
>
> This applies here again as well. Drop meaningless clearing of local
> variables and avoid this way that the code suggests that data is erased,
> which simply does not happen.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  crypto/sha512_generic.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/crypto/sha512_generic.c b/crypto/sha512_generic.c
> index c72d72ad828e..be70e76d6d86 100644
> --- a/crypto/sha512_generic.c
> +++ b/crypto/sha512_generic.c
> @@ -143,9 +143,6 @@ sha512_transform(u64 *state, const u8 *input)
>
>         state[0] += a; state[1] += b; state[2] += c; state[3] += d;
>         state[4] += e; state[5] += f; state[6] += g; state[7] += h;
> -
> -       /* erase our data */
> -       a = b = c = d = e = f = g = h = t1 = t2 = 0;
>  }
>
>  static void sha512_generic_block_fn(struct sha512_state *sst, u8 const *src,
> --
> 2.26.2
>


-- 
Thanks,
~Nick Desaulniers
