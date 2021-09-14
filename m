Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C93740B841
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhINTkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhINTkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:40:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307F0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:39:13 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s12so865447ljg.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aeXwmIgch5WdkpveenJmPeY14PQ1LoSRtKhoZ8R2ZN4=;
        b=E2QZm15xPjr/oWMY3iwMNj1tCXmIb5gTlQ3a8w0mki3WM83ocnAaFZO2cE8qkxJwLR
         aobGFaVqRefIPy2/h78IdfM6qFH+tofHv3K1o0MBA2koB09YYdlzJg9NMwDdGYibx9r+
         N8vo2nAu3SG55qHrSsV1OfPWwYV/u5LP6H0G435Wty9+v9DiDUFC29jPJmJ6wffF4GQ4
         YFw/Sjx5guzRdwJ6tolYpZlyO3DRIeP73/BId7Wc105H+AeVLhIzqSMMO1W6UNpUEun2
         h+2kPvrJ2cXqC9g8iQNqKvWmmy7z1nj1L9AHi3Crme67QTXVqvLcBI4U5TTGj9XdPNOd
         r1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aeXwmIgch5WdkpveenJmPeY14PQ1LoSRtKhoZ8R2ZN4=;
        b=xNtHpaj8GBZSsS+ppBGGtBEOVaaUhyhaQ96DaLbdasnAkkNpADEksjV8sopmvM5qFE
         esz+zrDuuzIw45Fz9MuINIQVD0Q9U2wnGb4l683s3pTyZagmmCPQIv2nkyYpacFTXUIg
         /ngmCQj5u9YwYUUCoKZBmWFkX3JG8ocLt8jtmUeCdF0/WyezXQc1Fs2k0TAkHrTctKtE
         lBY2e4D92q/ZlwUtX2+pzT0Q1k6soM0j+sXFE9nvik77rcWUYQJlRjmg9t5hIKL1y/aW
         0+95hR1LQkMzG9V/oWwOvu52x/P7/wNrV0mQS9rKK+ObzfYhdgij3k8RsctvJ/2+L2F6
         hs/Q==
X-Gm-Message-State: AOAM532xMVm75pErCaSmyFPLbli+aQrBShhMk2EhfmbWSsZQV0LM50w3
        pd5rKpbCvRjHM0MAXdWfcIbENLiYwd0yKVFaQzYE/w==
X-Google-Smtp-Source: ABdhPJxgAXKpry1tlDJug10xY3s3IbKLhBYYOOOqRKPqGpSgDAtG9tD969ZapfyKNyp/uNRFVYGOG2GTwBTdYez5RS0=
X-Received: by 2002:a05:651c:1305:: with SMTP id u5mr16539923lja.198.1631648351403;
 Tue, 14 Sep 2021 12:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com> <20210914191045.2234020-6-samitolvanen@google.com>
In-Reply-To: <20210914191045.2234020-6-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 12:39:00 -0700
Message-ID: <CAKwvOdmx=XTaKfT1-KNz1j8W0E7HDrWNHKdpCCXQUs+ZDPfXvg@mail.gmail.com>
Subject: Re: [PATCH v3 05/16] tracepoint: Exclude tp_stub_func from CFI checking
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:11 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> If allocate_probes fails, func_remove replaces the old function
> with a pointer to tp_stub_func, which is called using a mismatching
> function pointer that's will always trip indirect call checks with
> CONFIG_CFI_CLANG. Use DEFINE_CFI_IMMEDATE_RETURN_STUB to define
> tp_stub_func to allow it to pass CFI checking.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  kernel/tracepoint.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 64ea283f2f86..58acc7d86c3f 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -99,10 +99,7 @@ struct tp_probes {
>  };
>
>  /* Called in removal of a func but failed to allocate a new tp_funcs */
> -static void tp_stub_func(void)
> -{
> -       return;
> -}
> +static DEFINE_CFI_IMMEDIATE_RETURN_STUB(tp_stub_func);
>
>  static inline void *allocate_probes(int count)
>  {
> --
> 2.33.0.309.g3052b89438-goog
>


-- 
Thanks,
~Nick Desaulniers
