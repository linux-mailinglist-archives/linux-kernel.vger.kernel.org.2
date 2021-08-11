Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDFD3E959E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhHKQMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhHKQMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:12:47 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D847CC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 09:12:23 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id l3so5667138ybt.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOlciA6vtlJMb8eANGuXG565LMPmIqAD042FvFbmc3M=;
        b=kWX7HSvZpwDicpEEyAqQXwLKqMA5DsCTfoHNs3IlX3yFtQgXgFpKL89C3YhyRwh1oA
         8tquosY9qswYpw6ZnTyZ9ESHavcw0bfUdQ88jU7BCHY6w1iCnMTR84fwx5XiUtfHr63x
         90+fMovuAEeih6I5DZWYZzAqfV4tIgNEF78lLUGj5oLGHI1LmeB1hxdAPrnoy/y7OTxA
         i3qwfHeccPJDwRvxCNieZqgR9Xh+TqyZP2gGI9TKcohTfQ0QptBQcfhpHnIs1yyGK+us
         ZeahZc++a+OjannODS4s++mDW6kI6T238t6VtRxgul0wqCUzJ/jjW3vN/AaiTeKvRjvZ
         vwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOlciA6vtlJMb8eANGuXG565LMPmIqAD042FvFbmc3M=;
        b=smTEanYaITFbsX3/f3xXVtNYgMPMoK7SpFOhdMMtXd94zX/i9Gs2wAH8wT428BgXID
         Efg7v3b0MfOzH88PB/Lh57SNfhxWHFQJDLXtTWxUgHdGZx2mN2Taph/OymfmIInFsXim
         WgPYSSPzC30Ykz2z6Dae24Vqlb1wY+znIuXAsDG2WCpvYVOEuYKT1DLBTkTPrmBVykjY
         Sr2uw1tqI2pYVpW7ESnyQQ1oXh5VFHhwpdIGhtkbv78OGz0GUfPMR2GQI1DrNno0gKY1
         ctr0z/B3LU9JymAdbUCQxX3n6e+tXkbcuoTIp3TzvRyE1dRw2LoHfvcUug9hw6oXzJtx
         /qiw==
X-Gm-Message-State: AOAM531ZlxB3/qNuIR1AvYhTnp5evgEvLBPu9EhoMevFw24g51GR06Oc
        pZ+xaIkHIIhCHxoJzqGAMfca1/qi8FOzaR+ctTeQyQ==
X-Google-Smtp-Source: ABdhPJwWPk8K6QqajpqAEgXWGv5cA1mIwhQAccUmbhMeq6y6F1Aksf3Ipry6Bxd4KJyHb/iY0S+w/CgegSRWx+ZXnEo=
X-Received: by 2002:a25:c4:: with SMTP id 187mr50710409yba.498.1628698342789;
 Wed, 11 Aug 2021 09:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210811155914.19550-1-quic_eberman@quicinc.com>
In-Reply-To: <20210811155914.19550-1-quic_eberman@quicinc.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 11 Aug 2021 09:12:11 -0700
Message-ID: <CABCJKueDLEqxu1OVM4bWGmeX1aQQXVKsnr6_jCXcPpcW3H_A3g@mail.gmail.com>
Subject: Re: [PATCH 1/1] cfi: Use rcu_read_{un}lock_sched_notrace
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jinlong Mao <jinlmao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliot,

On Wed, Aug 11, 2021 at 9:00 AM Elliot Berman <quic_eberman@quicinc.com> wrote:
>
> If rcu_read_lock_sched tracing is enabled, the tracing subsystem can
> perform a jump which needs to be checked by CFI. For example, stm_ftrace
> source is enabled as a module and hooks into enabled ftrace events. This
> can cause an recursive loop where find_shadow_check_fn ->
> rcu_read_lock_sched -> (call to stm_ftrace generates cfi slowpath) ->
> find_shadow_check_fn -> rcu_read_lock_sched -> ...
>
> To avoid the recursion, either the ftrace codes needs to be marked with
> __no_cfi or CFI should not trace. Use the "_notrace" in CFI to avoid
> tracing so that CFI can guard ftrace.
>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  kernel/cfi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/cfi.c b/kernel/cfi.c
> index e17a56639766..9594cfd1cf2c 100644
> --- a/kernel/cfi.c
> +++ b/kernel/cfi.c
> @@ -248,9 +248,9 @@ static inline cfi_check_fn find_shadow_check_fn(unsigned long ptr)
>  {
>         cfi_check_fn fn;
>
> -       rcu_read_lock_sched();
> +       rcu_read_lock_sched_notrace();
>         fn = ptr_to_check_fn(rcu_dereference_sched(cfi_shadow), ptr);
> -       rcu_read_unlock_sched();
> +       rcu_read_unlock_sched_notrace();
>
>         return fn;
>  }
> @@ -269,11 +269,11 @@ static inline cfi_check_fn find_module_check_fn(unsigned long ptr)
>         cfi_check_fn fn = NULL;
>         struct module *mod;
>
> -       rcu_read_lock_sched();
> +       rcu_read_lock_sched_notrace();
>         mod = __module_address(ptr);
>         if (mod)
>                 fn = mod->cfi_check;
> -       rcu_read_unlock_sched();
> +       rcu_read_unlock_sched_notrace();
>
>         return fn;
>  }

Thanks for the patch! I agree, this looks like a better solution than
littering tracing code with __nocfi annotations.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
