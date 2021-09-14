Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D8F40B853
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhINTrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhINTrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:47:39 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC424C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:46:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id l11so887177lfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJoP/OqIzovh+f7RN/ZmhSCTt8+2LJh5ljOOfisx8/A=;
        b=CCXklwHg9kiNvnZWRukTby2pDIPeoMSxmSeHJzt+vLgD8NR5uPjZwbE6bx7MH4vGHZ
         QY1wW/6RJzP6zW7pfLxLTSw+QnhAbhj+XtHwjkJRVCqUsLQ7WTLcEr3rhT8fp1IAGUR/
         z3ksXpK5imnJv2Xzo5Nz4/p1ysDmSUwVGZS3HgEsoYYHKQ+OJ3oyqbOUvLViN4hZEvbs
         afwNVOmQGGTyCJOf9WsOaSB237K1IdfgmZIWgQ7CAbgXO9h2xo5DID/FvNVQLOmoC/Wd
         P5fJcPNEgddzeiE6a5ZiNE3kYhwlVatVfen/Nue2r9zMfroBicCRPstvt89qbsQszfHp
         lQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJoP/OqIzovh+f7RN/ZmhSCTt8+2LJh5ljOOfisx8/A=;
        b=yXErMy3yxd3Of1BGY1Fzt2ArPRq8f2cPb2ksK33+9R5zjan65kjuToGVby4d1CkYMa
         vRVYABLrb19IawXTJGUFf/RiTiY54g5WsnZuxQ3KW49P/vW40k6YytLfmTlUfvTbvyxu
         bWx3KhGnVWGJm4HB741Kk8PBJEKrDTZmcEKy/4LnUpuO5FipcjkYmxY4pZTDimeY1atf
         rkB33GkA/oGBo25X86bsYRawnUPqp2Y12ETBfpzv6QJkvX7qqdWB7tAaostdQYexXDiC
         8ZfNO7pQAbIJxx0nNv+fAnOHK34R6ZRaBjtXCnwog6TH8k/x/Y0hahehuT3VUAHwUNi8
         4yeQ==
X-Gm-Message-State: AOAM531vev5OKXBiPCD7YAGMfcKGtBPS4fQ0xK0OiFqwre35qkNefTbY
        H7EGFvdAq3V9CTpHL+UMMQ3nQ8zx8/bmvPYUqTm10A==
X-Google-Smtp-Source: ABdhPJwxMW3WhfPkamXqYeMSjNTgE7RuclPcDOmDe8a9WaD1GnvpXOb90wRrGwAG4pV7hkqsRsXFiR5LDQ/Egb+xexI=
X-Received: by 2002:a05:6512:2291:: with SMTP id f17mr14633288lfu.489.1631648779874;
 Tue, 14 Sep 2021 12:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com> <20210914191045.2234020-15-samitolvanen@google.com>
In-Reply-To: <20210914191045.2234020-15-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 12:46:08 -0700
Message-ID: <CAKwvOdm1dy7RiSfP1Ra1ek08OQ=8o8FDnrMdW44e6ZssgPbCAw@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] x86, cpu: Use LTO for cpu.c with CFI
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
> Allow LTO to be used for cpu.c when CONFIG_CFI_CLANG is enabled to avoid
> indirect call failures. CFI requires Clang >= 13, which doesn't have the
> stack protector inlining bug.

True, that was fixed in clang-12. I hope to one day use
__attribute__((no_stack_protector)) to clean up this chem spill.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Technically, GCC still has this bug.

>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/x86/power/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
> index 379777572bc9..a0532851fed7 100644
> --- a/arch/x86/power/Makefile
> +++ b/arch/x86/power/Makefile
> @@ -4,9 +4,11 @@
>  # itself be stack-protected
>  CFLAGS_cpu.o   := -fno-stack-protector
>
> +ifndef CONFIG_CFI_CLANG
>  # Clang may incorrectly inline functions with stack protector enabled into
>  # __restore_processor_state(): https://bugs.llvm.org/show_bug.cgi?id=47479
>  CFLAGS_REMOVE_cpu.o := $(CC_FLAGS_LTO)
> +endif
>
>  obj-$(CONFIG_PM_SLEEP)         += cpu.o
>  obj-$(CONFIG_HIBERNATION)      += hibernate_$(BITS).o hibernate_asm_$(BITS).o hibernate.o
> --
> 2.33.0.309.g3052b89438-goog
>


-- 
Thanks,
~Nick Desaulniers
