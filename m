Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A695045655F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhKRWLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 17:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhKRWLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:11:18 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FF6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:08:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f18so33326708lfv.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYg5uRA+tu1JqcQE8rlr/QJGe6qG9Ux78+pZZQSXsFM=;
        b=pqcwefPtl2C39bPh39Zo+SthZ5QeY4Z0B7iPMHhCZiGqS0+a+IWsPsHHd2pELUPVaP
         RzPQUggCQB8feReTKi9yP3Y0Lr7K4swjqErpSuLoXOfrm7JNrfNQBDzuv+66m7VFza3e
         A0b1mtwuk2BFICkHr0xHPJxXFbICL9JYAytVha0+2kt+SIZEC9eB+vvXgd6rbP4mqJIL
         oREe9BWspd1OCukaf8d68mciIecpbFAIcpt2sEsd4VgFDYWIwnbsRzzfQ695H/CC+YO4
         qH04/mt6nGHaE1hZKbl2BxAPqQ0lc4DXhHLS73PMVVkX4v+D58k/RBmmADGzF2zRd0dy
         /w2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYg5uRA+tu1JqcQE8rlr/QJGe6qG9Ux78+pZZQSXsFM=;
        b=rfcInm285b78hipS8jfVszXsl2pgSfRuAkQHCoFcnjORu2jQaSIl+EyTAYnbx+7lsb
         BGLXWrvM34/bzzxPXXzP+gESIf2N1uzbAk5ldi5m9+CXSH2pBsbxjpilT87su6MU2TG8
         DcG0VEiK3LZn9hGqccrWrpD02XIKKO/QBZr85umwnYV0Tl2PdwxKHzgfeGFHDII2EBzr
         2Abqti7ZAr5P4i2Kg7WQjC9kGhEtEUtz2xAmfXncKQiQ+X9r2sai9/pyywR9+i99fxyx
         xdX5/EshN0bJ9blUoqO4px40JZM/w2a3LVwX61zqDpvihIsoxeIaIpN5LB5gSJzbBuBV
         jA6w==
X-Gm-Message-State: AOAM532j8D9DhssrI9wOfOnonjUgMM8Jdw2V+rFni0JkTP88lmJh9mIJ
        kLuq9CpJFNQEyeQ+XF4AONFbRGfV5D6lX8VqIS0omQ==
X-Google-Smtp-Source: ABdhPJw4l5qkRrzNZ0ISMkYnecapXw8Nfhqb+OjXZGolwknTDbYOtM2AUW4b+qX0d1MjvXR9nV0H6GZ7wEqyAv946KI=
X-Received: by 2002:a05:6512:3d16:: with SMTP id d22mr26621791lfv.523.1637273296109;
 Thu, 18 Nov 2021 14:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20211118185421.GK174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211118185421.GK174703@worktop.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Nov 2021 14:08:04 -0800
Message-ID: <CAKwvOdkrN0tLMrEyx98JY6wGdwi0Be3Z8fbTQ3vNHckM4dmG8g@mail.gmail.com>
Subject: Re: [PATCH] x86: Use -mindirect-branch-cs-prefix for RETPOLINE builds
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H.J. Lu" <hjl.tools@gmail.com>, llvm@lists.linux.dev,
        linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 10:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> In order to further enable commit:
>
>   bbe2df3f6b6d ("x86/alternative: Try inline spectre_v2=retpoline,amd")
>
> add the new GCC flag -mindirect-branch-cs-prefix:
>
>   https://gcc.gnu.org/g:2196a681d7810ad8b227bf983f38ba716620545e
>
> to RETPOLINE=y builds. This should allow fully inlining retpoline,amd
> for GCC builds.

Do you mind adding the following link tags:

Link: https://gcc.gnu.org/g:2196a681d7810ad8b227bf983f38ba716620545e
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102952
Link: https://bugs.llvm.org/show_bug.cgi?id=52323

If the feature would be helpful to implement in Clang, would you mind
keeping the cc-option, but moving the check outside of the `ifdef
CONFIG_CC_IS_GCC` block? That way, we don't need to revisit the
Makefile?

(Tangential: I wonder why RETPOLINE_CFLAGS aren't defined in
arch/x86/Makefile; they seem to be x86 specific at the moment).

With the above link tags, and with or without moving this outside the
gcc-specific guard:
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 9e12c14ea0fb..5fd5b5f091ae 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -690,6 +690,7 @@ endif
>
>  ifdef CONFIG_CC_IS_GCC
>  RETPOLINE_CFLAGS       := $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
> +RETPOLINE_CFLAGS       += $(call cc-option,-mindirect-branch-cs-prefix)
>  RETPOLINE_VDSO_CFLAGS  := $(call cc-option,-mindirect-branch=thunk-inline -mindirect-branch-register)
>  endif
>  ifdef CONFIG_CC_IS_CLANG



-- 
Thanks,
~Nick Desaulniers
