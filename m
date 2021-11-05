Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0894469F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhKEUrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 16:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbhKEUq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 16:46:59 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F31DC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 13:44:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f3so21028327lfu.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=senqiBJkxESggfPiWBCUi5fzLmZvRY+Wca6s+ykrVZE=;
        b=tE/oV/4g9EFoy+oty4gmADvSPhF9RtkrPCM8KYsx7S0ZT1o5JCnEvklXoCI9IxsqcM
         gxMTZRmXUvFzJEl/WJLI1x24ObCKPcy3VSYwr/7RGCco7gZ7o2rGHQ9fRMtJcaI+/a+c
         J66muvNcBHI/5CV205/pLwwEDs/to+O8pIu02srpXcku+Js2urLgtLi4nInfWxRMEEen
         W3kZEEEZiayiOotNfIGjhSssobGAjj/2yUKT9PKfKy6MgWilikRQ4VEzfNA96X5OU7B+
         nmXQsZ2j0TFa8BpMuVlLXIU5pBR/m95t+sWiy+LyqN6jGystPHn97oWU5YMZ6LFT8X/L
         NntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=senqiBJkxESggfPiWBCUi5fzLmZvRY+Wca6s+ykrVZE=;
        b=URP7YdpIh2IH+v1UFtXvx7wRTx+MIbJh/xKWReRdXS7bR5HJODV8VYKs4iPPxnXkjh
         lVpYhSlobg612ZWXzYSu3kcUppGNOUvFDN3ie0uDc7vbbbPHesCfODAgxa+73q0q8Sfo
         Ef/2bGJduu9CUTfb7TLOo/SKVOqHTOt+qevr/zfsuy4QcWOOGoeHa45VSKxxNwBLc/k0
         +u200vb8r/gzi2PYqnfKVUWTzbTt20zGJVb0cUsMu8ROoogX8CSvLypQo8zEu6eAs9PS
         nqeEfCAL+5QQ+UMi9U+VEsKQzhLdiFobCIfUU63MZpvcwBJ2IVRbMtJ/kgyTeVNjONQS
         6bqQ==
X-Gm-Message-State: AOAM531hhGgOCDdFNgUW8R9B+HovgvK1ixCjlPsUKL2M+s8Fd4AeaORc
        /zMLmIiPQHkW1AfBuWvFdgMmcBRBSg/g6RPEDYierQ==
X-Google-Smtp-Source: ABdhPJw7IgaZKzrFcRGOUYu89cL7dGi3eKPzT/JXI7SWHD10+wo4CRxvRI9anjQ1vUxykmf481gYxF1btkhuziSU+UI=
X-Received: by 2002:a05:6512:228a:: with SMTP id f10mr55986163lfu.489.1636145057351;
 Fri, 05 Nov 2021 13:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211105163403.3330950-1-anders.roxell@linaro.org>
In-Reply-To: <20211105163403.3330950-1-anders.roxell@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Nov 2021 13:44:06 -0700
Message-ID: <CAKwvOdn0vEyj-EPJG0e39v-Vq+oLFptV0oXYfzfzuy=HPzSzOA@mail.gmail.com>
Subject: Re: [PATCH] selftests: timers: use 'llabs()' over 'abs()'
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, tglx@linutronix.de, john.stultz@linaro.org,
        nathan@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 9:34 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> When building selftests/timers with clang, the compiler warn about the
> function abs() see below:
>
> posix_timers.c:69:6: warning: absolute value function 'abs' given an argument of type 'long long' but has parameter of type 'int' which may cause truncation of value [-Wabsolute-value]
>         if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
>             ^
> posix_timers.c:69:6: note: use function 'llabs' instead
>         if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
>             ^~~
>             llabs
>
> The note indicates what to do, Rework to use the function 'llabs()'.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I wonder why tools/testing/selftests/timers/adjtick.c redefines llabs
when it already includes stdlib.h, and how that doesn't result in some
kind of compiler diagnostic.

> ---
>  tools/testing/selftests/timers/posix_timers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
> index 337424c5c987..73fb27901a1d 100644
> --- a/tools/testing/selftests/timers/posix_timers.c
> +++ b/tools/testing/selftests/timers/posix_timers.c
> @@ -66,7 +66,7 @@ static int check_diff(struct timeval start, struct timeval end)
>         diff = end.tv_usec - start.tv_usec;
>         diff += (end.tv_sec - start.tv_sec) * USECS_PER_SEC;
>
> -       if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
> +       if (llabs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
>                 printf("Diff too high: %lld..", diff);
>                 return -1;
>         }
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
