Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EEE3EAD73
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbhHLXGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhHLXGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:06:03 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD11CC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 16:05:37 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id k65so15109227yba.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 16:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WAs5yGGrrPs05Rwlue3cPAfgQcKWa7aULg+SByGEVDk=;
        b=DVRYoece1BGsz/06lnEBAmoea9LRG/ssByvuEa6EbtN/vGaHRqJTi+4VqY8lrjo1/n
         inq31Tc2qMj6Ii5gIJK0fMljbZR029n7Oyg0oiNnJ/rsj8hjvrWVRtI2kgYbal5DtX6C
         lI+O5XvkK4QFeYF4fk9QPJ6k7bJ/KfRItEpaOOYykYzD+IrWnQS7chEfbTzpbFGWvTxn
         U6JAsB5maJ6OouHqJuDLNXX2UKcGjFAMTBpjBQs9nkyKy0kpPX4bZz3Q/rRObFvud1El
         CkF/NgQAU4fswhKtEyQOYPXKHywpZUqGMgZFoDnl9I1aoMzKfRNL8cjn7F+VAHcKkNma
         wxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAs5yGGrrPs05Rwlue3cPAfgQcKWa7aULg+SByGEVDk=;
        b=K5vLBY1zK8FJDz00TZpPWFjh7jHxs8mpCJ6qFewUFwkXobwnPVXSPdLbZhpmVXD+P+
         39d4wIymH233tpjqfhf1CJEwPDsTHMqtK89dPgw6A/Ddoo/BjaTZkT2HpWEurHN8C0Cb
         5epC8cPIto6EgWRLg8h54r5jJ1z36IePeHAYyMTSi/+oDXXRq2ahcklsX7ScGrFgA70j
         aD+PZzuO7AMQ3Z8nfAeXS7nqpvnkmiX22qBsqJR8ewFbVkO9+ewBSPhUwv0l54twQ9tX
         c/q4igtk17mgsYIQJ/9UU57znXhKYpmhdLpGadNUeFRi0PUVZVbw2QsA7XGgT0RIC7mT
         SHFQ==
X-Gm-Message-State: AOAM530YtMFQ36yjYH99cbNPSeFEAjMgMG/BM1YHjf3mzytD71lmtbau
        l4mWJVXJaR9G3JI3BjHOMTMlXY+eKca5G8Xx3VXotQ==
X-Google-Smtp-Source: ABdhPJxOhN1WWF+ghRCdAoAp4e2y0Wdx+un+FLwmZbDM55mLfWw9ekjQy1GiOYx+jl4S1KpwWKoVGaXZkj5TFbQPs2Q=
X-Received: by 2002:a25:26c3:: with SMTP id m186mr7496137ybm.293.1628809536796;
 Thu, 12 Aug 2021 16:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <CABCJKuei==gaaKw0qH1WkshcRyUbqdS_WGRWr6anYAew1HHT2w@mail.gmail.com>
 <20210805232741.9501-1-treasure4paddy@gmail.com>
In-Reply-To: <20210805232741.9501-1-treasure4paddy@gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 12 Aug 2021 16:05:25 -0700
Message-ID: <CABCJKue6dYBYTJtyX6oE8Lq1LVHcS+vq+Z4cRE2-Tut8GRHjPQ@mail.gmail.com>
Subject: Re: [PATCH v4] kallsyms: strip CLANG CFI postfix ".cfi_jt"
To:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Stephen Boyd <swboyd@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 4:28 PM Padmanabha Srinivasaiah
<treasure4paddy@gmail.com> wrote:
>
> Clang CFI adds a postfix ".cfi_jt" to a symbols of extern functions.
> For e.g. this breaks syscall tracer that doesn't expect such postfix,
> so strip out the postfix from the expanded symbol.
>
> Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
> ---
> Change in v4:
>   - Remove redundant check; irrespective of LTO type (THIN/FULL),
>     LTO_CLANG will be always enabled. Hence will be used as entry flag
>     to check various postfix patterns.
>   - And prior to stripping postfix ".cfi_jt", added a comment to
>     justify why we are doing so.
>
> Change in v3:
>   - Modified commit message to indicate fix is for Clang CFI postfix
>   - Rebased on recent patch from ndesaulniers@google.com.
>     https://lore.kernel.org/lkml/
>         20210707181814.365496-1-ndesaulniers@google.com/#t
>   - Fix is enabled even for CONFIG_LTO_CLANG
>
> Change in v2:
>   - Use existing routine in kallsyms to strip postfix ".cfi_jt" from
>     extern function name.
>   - Modified the commit message accordingly
>
>  kernel/kallsyms.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 5cabe4dd3ff4..1b40bcf20fe6 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -174,13 +174,15 @@ static bool cleanup_symbol_name(char *s)
>          * foo.llvm.974640843467629774. This can break hooking of static
>          * functions with kprobes.
>          */
> -       if (!IS_ENABLED(CONFIG_LTO_CLANG_THIN))
> +       if (!IS_ENABLED(CONFIG_LTO_CLANG))
>                 return false;
>
> -       res = strstr(s, ".llvm.");
> -       if (res) {
> -               *res = '\0';
> -               return true;
> +       if (IS_ENABLED(CONFIG_LTO_CLANG_THIN)) {
> +               res = strstr(s, ".llvm.");
> +               if (res) {
> +                       *res = '\0';
> +                       return true;
> +               }
>         }

I confirmed that LLVM renames these also with full LTO, so the config
check can be dropped here.

>
>         /*
> @@ -194,6 +196,17 @@ static bool cleanup_symbol_name(char *s)
>                 return false;
>
>         res = strrchr(s, '$');
> +       if (!res) {
> +               /*
> +                * In case of non static function symbol <funcsym>,
> +                * the local jump table will have entry as <funcsym>.cfi_jt.
> +                *
> +                * Such expansion breaks some built-in components,
> +                * e.g. syscall tracer. Hence remove postfix ".cfi_jt".
> +                */
> +               res = strstr(s, ".cfi_jt");
> +       }
> +
>         if (res) {
>                 *res = '\0';
>                 return true;

Otherwise, the logic looks pretty good to me. Nick, are you planning
to resend your earlier patch? Should this be just folded into the next
version?

Sami
