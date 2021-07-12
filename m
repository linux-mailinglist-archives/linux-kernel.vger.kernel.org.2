Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763683C66D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 01:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhGLXSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 19:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhGLXSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 19:18:51 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03887C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 16:16:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x25so33799619lfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 16:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFV3Ph/loXo+FuvqW94oKyOTqGWGGJph3tyBWfseX5w=;
        b=t3Uf+z8dAHA+728DBOXQgJz4rIXWGtud2LuPwUdchixIJb0Ttz6up6+SfJiNOHHjGn
         eM3sG1YqfAlas3RwWRqI1YwgCFSJgbQhGWWXZdt5iEh2qB4zpk3whrky8eliX31Z8xE0
         Lqor0UYEUF5m01V0i550ppBbFCaKzFDgawpU8WQQEMA/rszpy5FacXs1Q6PdQrUjJHho
         SLS7JySlJISaQC7z/iB58zMpZgkZc2FuV2jT8dcThU/uS+eOsqNKtx3FEpRJ66JsHkvc
         mXimulZxg8ZoMV2TyLQKlESb6uyXb/oz/Urw2Oz19poGIXpVoeBkejeFPaoYHsd2swE6
         aIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFV3Ph/loXo+FuvqW94oKyOTqGWGGJph3tyBWfseX5w=;
        b=s4I5xbRb3KaNe3w/qhunpK/Jw72qggBfQKJSNRCGlZ/HBKDbi/na0oyWXw2ELXjpg1
         PWqIlbXloH5F6eaq1O7mNAWBh2MgqeBDz81Ls/JqZ2EaybwwTH2vq6IDZXtLVYsOJ74L
         jFFZZwR481L9F0Av6gDZxxzXxXhTNhiIvK1hxwd8W9DNKniQkH46Y3FBSbUiPp8M09bf
         20l+Ys9bMQefol6zEt8ov+wedSW8O4zL2B/CFsehlq+D0KjuEeouVrxW6HVau+Oh3Iad
         JNLV/vsY4dnD0UtCq8dc50SwLJU7pElaaif5YvpLlgcWMJwmgxAYP69KWdTswDPHzPWb
         k+BQ==
X-Gm-Message-State: AOAM533qwXOeJtidIYW4XNSUAjOU0AEAxeWvCTFxeng/QubvEWu9Pfkb
        s9XzcqRTlmFHpShZnLO4uLPs1s4AW9Gzj41C6jJD2g==
X-Google-Smtp-Source: ABdhPJz6sPhvaLPasdEApq9eC8IB/oU11arDE7pBrQXCFNXGU/iV5CfTfanf072kZ4ImOocpUb1qdsahaw2pfM1K6j8=
X-Received: by 2002:a19:5f04:: with SMTP id t4mr917513lfb.297.1626131759149;
 Mon, 12 Jul 2021 16:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210709000627.3183718-1-nathan@kernel.org> <20210712214636.3134425-1-nathan@kernel.org>
In-Reply-To: <20210712214636.3134425-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Jul 2021 16:15:47 -0700
Message-ID: <CAKwvOdmDOSY4du_6V0Mh5WdqWWU8nC_b-2Eii7Pa5fVhZXbG9A@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Restrict ARM64_BTI_KERNEL to clang 12.0.0 and newer
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 2:51 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Commit 97fed779f2a6 ("arm64: bti: Provide Kconfig for kernel mode BTI")
> disabled CONFIG_ARM64_BTI_KERNEL when CONFIG_GCOV_KERNEL was enabled and
> compiling with clang because of warnings that were seen with
> allmodconfig because LLVM was not emitting PAC/BTI instructions for
> compiler generated functions:
>
> warning: some functions compiled with BTI and some compiled without BTI
> warning: not setting BTI in feature flags
>
> This depedency was fine for avoiding the warnings with allmodconfig
> until commit 51c2ee6d121c ("Kconfig: Introduce ARCH_WANTS_NO_INSTR and
> CC_HAS_NO_PROFILE_FN_ATTR"), which prevents CONFIG_GCOV_KERNEL from
> being enabled with clang 12.0.0 or older because those versions do not
> support the no_profile_instrument_function attribute.
>
> As a result, CONFIG_ARM64_BTI_KERNEL gets enabled with allmodconfig and
> there are more warnings like the ones above due to CONFIG_KASAN, which
> suffers from the same problem as CONFIG_GCOV_KERNEL. This was most
> likely not noticed at the time because allmodconfig +
> CONFIG_GCOV_KERNEL=n was not tested. defconfig + CONFIG_KASAN=y is
> enough to reproduce the same warnings as above.
>
> The root cause of the warnings was resolved in LLVM during the 12.0.0
> release so rather than play whack-a-mole with the dependencies, just
> update CONFIG_ARM64_BTI_KERNEL to require clang 12.0.0, which will have
> all of the issues ironed out.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1428
> Link: https://github.com/ClangBuiltLinux/continuous-integration2/runs/3010034706?check_suite_focus=true
> Link: https://github.com/ClangBuiltLinux/continuous-integration2/runs/3010035725?check_suite_focus=true
> Link: https://github.com/llvm/llvm-project/commit/a88c722e687e6780dcd6a58718350dc76fcc4cc9
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>
> v1 -> v2:
>
> * Fix typo ("compilign" to "compiling") per Will.
>
> * Clarify that these warnings are reproducible back at the time of
>   97fed779f2a6 with allmodconfig + CONFIG_GCOV_KERNEL=n but that
>   configuration was most likely not tested.
>
> * Clarify that the warnings come from CONFIG_KASAN, which suffers from
>   the same issue at CONFIG_GCOV_KERNEL because there are compiler
>   generated functions.
>
> * Clarify that the root cause of the warnings is resolved in 12.0.0 and
>   link to the GitHub commit rather than the Phabricator instance, in
>   case LLVM moves to GitHub reviews in the future.
>
> Hopefully this is adequate explanation for what is going on, thanks to
> Will and Nick for providing input on the commit message.

Perfect, sorry for being a pedant on the commit message, but this
provides much more context should we need to revisit this again in the
future.  Never say never, (again)!  Thanks very much for this patch.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  arch/arm64/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e07e7de9ac49..b5b13a932561 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1605,7 +1605,8 @@ config ARM64_BTI_KERNEL
>         depends on CC_HAS_BRANCH_PROT_PAC_RET_BTI
>         # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94697
>         depends on !CC_IS_GCC || GCC_VERSION >= 100100
> -       depends on !(CC_IS_CLANG && GCOV_KERNEL)
> +       # https://github.com/llvm/llvm-project/commit/a88c722e687e6780dcd6a58718350dc76fcc4cc9
> +       depends on !CC_IS_CLANG || CLANG_VERSION >= 120000
>         depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_REGS)
>         help
>           Build the kernel with Branch Target Identification annotations
>
> base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
> --
> 2.32.0.93.g670b81a890
>


-- 
Thanks,
~Nick Desaulniers
