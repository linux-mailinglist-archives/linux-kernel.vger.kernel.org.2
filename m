Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE02E42E026
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 19:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhJNRjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 13:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbhJNRjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 13:39:10 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC75CC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 10:37:04 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p16so30455470lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TG82cb8k19zHpAL9FdWnZQlAfRFvy8vXZs/tg7DrT90=;
        b=PsYmOwIaA6SW28RHw4uShKZGnUBkMKs5xKslaJXBr801sbw6wiPu2+L2JyB6DSwZMn
         jRE77P/1DkPtFqr5hKnI+RM5TVXsQmOElVICMdwkGCzCY4bKx9GSImX5JFo1w1L/QBOv
         BIcViMM5K+csDr3heoSxISZSSMzT38x6HxyXs2xx26x/LgeTtqVwhc1PTrKMgQ9v0YrX
         ifBytItD9R1TTuGkFi67XEWRwfZYEBwUfEyER6+lGiSqowv/t+cCtM09Z+X4y0YFL0I0
         Bsq1kvylyj6Yspqkm1MT/vp3J+1ybR/3Df6nldo5NAHLVoVXtBBy41gOo6XQ+mdYVvUS
         Yifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TG82cb8k19zHpAL9FdWnZQlAfRFvy8vXZs/tg7DrT90=;
        b=2miHR0IX1fF/+gASLPtVCn/NTlDYDdGLcCKLXNHc5D6HzEzdFT7B+HlbK1Icvv1fV4
         2d2OtLIElycQ9PVNH3GWzLMEePwuXxO6K844yH1Um8MlTQbQff4v1ekJE1f0yVjA2KFi
         EIOR+Fi5vHAZ4bvDAGfhlUdKPRuIqI/Q82hcFQgmcMLGABBy+FDTmKZBl50uL1Gy3AiS
         njYeHaZmODPvcuacvLtim1dV/AuHoiPOgvVsxedjbxo0pVtEJ3x5+rEuP2RXkrmUaU99
         fd24TI1rUpqV59bWnthheOMw8NnHksBuHTKycftDGAuRWI4ug/1MqVS4b6JuYX2KNcuz
         mdyA==
X-Gm-Message-State: AOAM530aRMPL6Q/03Mu8tGYxSrvv0Nf5YRPGqe73pDSbnjVj6HKV3U1a
        I8wHjvxASOhqvHGxJrVG1kZWG7PwGLj5B+NwSm0njw==
X-Google-Smtp-Source: ABdhPJwLuGDqGNdh9VmnJlwA9ickYFs0m0NfCTWjKYsobjDvnlHNs6x3zmHGmKGPD9Yqp98LaxnCTLwfD0UtGenptcg=
X-Received: by 2002:a05:6512:1103:: with SMTP id l3mr6353419lfg.550.1634233022848;
 Thu, 14 Oct 2021 10:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211014132331.GA4811@kernel.org>
In-Reply-To: <20211014132331.GA4811@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Oct 2021 10:36:51 -0700
Message-ID: <CAKwvOdntTcMdXKCYLjPnNxgxMZTZWRFOsMEMp0MQSCoz30mOMg@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: mark __compiletime_assert failure as __noreturn
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 6:25 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> `__compiletime_assert` declares a fake `extern` function
> which appears (to the compiler) to be called when the test fails.
>
> Therefore, compilers may emit possibly-uninitialized warnings
> in some cases, even if it will be an error anyway (for compilers
> supporting the `error` attribute, e.g. GCC and Clang >= 14)
> or a link failure (for those that do not, e.g. Clang < 14).
>
> Annotating the fake function as `__noreturn` gives them
> the information they need to avoid the warning,
> e.g. see https://godbolt.org/z/x1v69jjYY.

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Link: https://lore.kernel.org/llvm/202110100514.3h9CI4s0-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  include/linux/compiler_types.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index b6ff83a714ca..ca1a66b8cd2f 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -298,7 +298,13 @@ struct ftrace_likely_data {
>  #ifdef __OPTIMIZE__
>  # define __compiletime_assert(condition, msg, prefix, suffix)          \
>         do {                                                            \
> -               extern void prefix ## suffix(void) __compiletime_error(msg); \
> +               /*                                                      \
> +                * __noreturn is needed to give the compiler enough     \
> +                * information to avoid certain possibly-uninitialized  \
> +                * warnings (regardless of the build failing).          \
> +                */                                                     \
> +               __noreturn extern void prefix ## suffix(void)           \
> +                       __compiletime_error(msg);                       \
>                 if (!(condition))                                       \
>                         prefix ## suffix();                             \
>         } while (0)
> --
> 2.33.1
>
>


-- 
Thanks,
~Nick Desaulniers
