Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FF441E1FB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 21:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346582AbhI3TH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 15:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346497AbhI3THz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 15:07:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14630C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 12:06:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j5so24634993lfg.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+gCA8R/q8DA5l/Yv1Vf3OioGIfO849q423Tpx5LPaTM=;
        b=AECqIrUylRKEXCIN5T+00SF+0yJ8GxO/5Agylwk+EUD5TXDWvWc9SUhEh+QdyepOCF
         JPrIGC96e+MeBJ9zmDLh1QGETXM6EfAdKicHFpyRhX6JBv0LJdAdJGHWgBkrO9iA/5nB
         2k9Z+EmR+JJQlScEIAfrpAhXWE9yhHU2gY03pTxXTmVz0t1csyMutOc0oPWHwYYFwtkW
         awy0OAB3G0YzSf8Ij8kREE1a1S4dXle1vXTEAl1ZEJljKw3EvDleYVzIjO58TCxZ3p+I
         D4LBkltjSBPDo/xHrgill2DgT658i7/jxgkxOjyKyuK3PAGF26Gk0ckenc7PV4p2fOX7
         7ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+gCA8R/q8DA5l/Yv1Vf3OioGIfO849q423Tpx5LPaTM=;
        b=YtE3krZ+oOWGaGEXJ8bru9SViTRGbVCxPMfOd1AItsAu97vF7IZuGKKjEAJfSiVcrI
         j5ALwNE2eemfM+cD3iUOu70xQ6ZHoi35RG76EUXutdwkBMJFQ8qwOp/qi+bFbPg0tfw6
         e1O6/SFaaUp0QjPQSiioDRXCXAdboutngMhfgEArSU+4uvVI9hNjppmqTdXg+gL8GDY0
         uFXRjgO9Kv0SgIW0KvIY28RG/sHo/OoT1yfid3YRwOhH0S28Y9cJF6dmFY8lJgb8RmBf
         IJzLE50kARVR+CcDw9+712KqEM1N3yORKuCRdaWd+GIMAjeul3juMaMdgixNq+K+B7k/
         SRmw==
X-Gm-Message-State: AOAM5309KNgdKOTfOP96TtuC4yUfbjFcZTtu2EBQGE7RXX5lhJvYUiRk
        KSBQ76CF5A4QDrx/4kCtBr3nIedOHLm+A8EWzx8N/w==
X-Google-Smtp-Source: ABdhPJy9zs84yOnD/x9yZpPrFP29J5YMCsH3vIcOjsBghvbxT/aOAXOzDmJlgx+sg0EByBaMvjAzsaR0WMTd9DlVW/4=
X-Received: by 2002:a05:6512:2294:: with SMTP id f20mr814723lfu.489.1633028770167;
 Thu, 30 Sep 2021 12:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com> <20210930180531.1190642-11-samitolvanen@google.com>
In-Reply-To: <20210930180531.1190642-11-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 Sep 2021 12:05:58 -0700
Message-ID: <CAKwvOdkcjAAzxTvYGSi4XD3DEFfESDTyCynQNWjdQ2zssF9sHw@mail.gmail.com>
Subject: Re: [PATCH v4 10/15] x86/purgatory: Disable CFI
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:06 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/x86/purgatory/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 95ea17a9d20c..911954fec31c 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -55,6 +55,10 @@ ifdef CONFIG_RETPOLINE
>  PURGATORY_CFLAGS_REMOVE                += $(RETPOLINE_CFLAGS)
>  endif
>
> +ifdef CONFIG_CFI_CLANG
> +PURGATORY_CFLAGS_REMOVE                += $(CC_FLAGS_CFI)
> +endif
> +
>  CFLAGS_REMOVE_purgatory.o      += $(PURGATORY_CFLAGS_REMOVE)
>  CFLAGS_purgatory.o             += $(PURGATORY_CFLAGS)
>
> --
> 2.33.0.800.g4c38ced690-goog
>


-- 
Thanks,
~Nick Desaulniers
