Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692A43067D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbhA0XZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhA0W4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:56:32 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5A6C061353
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 14:54:49 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id j12so2380957pfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 14:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RpK9qYNeNCq2pBdqCqkQh3HL9e9C4g0oYh/5JBoHmU=;
        b=FmWfoKd2vkDyNPB+kGcAXpUUXSxLadJT011qSU424/rGXfvREarCmJfZrPS0DBI46O
         vKAhoBDa/Dk7sPvnKJHN2MmOs2WsOqnXEN0MAdk0a+qHt4bHDUTLk7DUct9ZSjyLx/DW
         CZSJdByoqDCgbVisVKgSfJAjVtzZ0g9GcAZPAgm3l/UdYtn+NkCEDC6IWrEfRhWYFsv0
         9bSlpl+L/g5QNKQ+YwSFhTwAVZ6T6l94u/bbEp7CfADhzV7rB0qFfzKto3qNcASIDzFd
         WH3OGFGFWDmFMPHNbHBYNk/bjK1Ur1p9eJr3v44+Fchc3r6yDjv5IaVRvf+zPW3BZwMB
         c7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RpK9qYNeNCq2pBdqCqkQh3HL9e9C4g0oYh/5JBoHmU=;
        b=TlrgflqUXpWd75DN9KNnsifswsp2nm5CKTMogdBVMjHyPQ9o3s58QKzq5hBJKLEZOL
         U5tlcAzLRba9HTueuIHCkt1Np47wzUP1+mpcEuzMZONuAIAUfSfOX/BymLDKWfTOT4/X
         Q885xvCNENN5Lmf8frsOTbw+guwsUs86CFqP/JelPnc/w3Wc4RYEuT+IpHTuv5mRH6X/
         Kbk3cgKWRM5JSOzvI8fbC29EFP6YZ9bHF0i6lHhcINIAUSirVBmC1LlRYoyjchJC6n61
         CQgVdzykbeUk9NpOxELaBvxgcUWFw4JaMFWtI7rjtvtehZTXcmDwCfzZS1h7XDRcuM21
         g8SA==
X-Gm-Message-State: AOAM532Y7Jah39RcfNAHSDDnQI2hAz17NhtHbZk1i8U714u29zm0RoBA
        q1KxuXprOinLwFfPvLsyRvxYkzSJECcDrTDTi36YFA==
X-Google-Smtp-Source: ABdhPJxCSx7pbZtXe1W9hj8tTSMNXYf/E4Q8iHLIMhYKnYXOKSoI1UyOAhesjq4kQr1nCuDdHdqbKXIpWJPdx7FbhAE=
X-Received: by 2002:a63:5701:: with SMTP id l1mr13438877pgb.381.1611788088801;
 Wed, 27 Jan 2021 14:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20210113001242.1662786-1-natechancellor@gmail.com> <20210127224451.2587372-1-nathan@kernel.org>
In-Reply-To: <20210127224451.2587372-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 27 Jan 2021 14:54:37 -0800
Message-ID: <CAKwvOd=t3jT8cWREvKpZCn4pP=dszNgWK0uShnxBBk-xKW53CQ@mail.gmail.com>
Subject: Re: [PATCH v3] ubsan: Implement __ubsan_handle_alignment_assumption
To:     Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 2:46 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> When building ARCH=mips 32r2el_defconfig with CONFIG_UBSAN_ALIGNMENT:
>
> ld.lld: error: undefined symbol: __ubsan_handle_alignment_assumption
> >>> referenced by slab.h:557 (include/linux/slab.h:557)
> >>>               main.o:(do_initcalls) in archive init/built-in.a
> >>> referenced by slab.h:448 (include/linux/slab.h:448)
> >>>               do_mounts_rd.o:(rd_load_image) in archive init/built-in.a
> >>> referenced by slab.h:448 (include/linux/slab.h:448)
> >>>               do_mounts_rd.o:(identify_ramdisk_image) in archive init/built-in.a
> >>> referenced 1579 more times
>
> Implement this for the kernel based on LLVM's
> handleAlignmentAssumptionImpl because the kernel is not linked against
> the compiler runtime.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1245
> Link: https://github.com/llvm/llvm-project/blob/llvmorg-11.0.1/compiler-rt/lib/ubsan/ubsan_handlers.cpp#L151-L190
> Acked-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> v2 -> v3:
>
> * Add prototype right above definition to avoid introducing a warning
>   with W=1.
>
> v1 -> v2:
>
> * Use __ffs instead of ffs because due to size of input (unsigned long
>   vs int) and we want a zero based index (Nick Desaulniers).
>
> * Pick up Kees's ack.
>
>  lib/ubsan.c | 31 +++++++++++++++++++++++++++++++
>  lib/ubsan.h |  6 ++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index 3e3352f3d0da..bec38c64d6a6 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -427,3 +427,34 @@ void __ubsan_handle_load_invalid_value(void *_data, void *val)
>         ubsan_epilogue();
>  }
>  EXPORT_SYMBOL(__ubsan_handle_load_invalid_value);
> +
> +void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
> +                                        unsigned long align,
> +                                        unsigned long offset);
> +void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
> +                                        unsigned long align,
> +                                        unsigned long offset)
> +{
> +       struct alignment_assumption_data *data = _data;
> +       unsigned long real_ptr;
> +
> +       if (suppress_report(&data->location))
> +               return;
> +
> +       ubsan_prologue(&data->location, "alignment-assumption");
> +
> +       if (offset)
> +               pr_err("assumption of %lu byte alignment (with offset of %lu byte) for pointer of type %s failed",
> +                      align, offset, data->type->type_name);
> +       else
> +               pr_err("assumption of %lu byte alignment for pointer of type %s failed",
> +                      align, data->type->type_name);
> +
> +       real_ptr = ptr - offset;
> +       pr_err("%saddress is %lu aligned, misalignment offset is %lu bytes",
> +              offset ? "offset " : "", BIT(real_ptr ? __ffs(real_ptr) : 0),
> +              real_ptr & (align - 1));
> +
> +       ubsan_epilogue();
> +}
> +EXPORT_SYMBOL(__ubsan_handle_alignment_assumption);
> diff --git a/lib/ubsan.h b/lib/ubsan.h
> index 7b56c09473a9..9a0b71c5ff9f 100644
> --- a/lib/ubsan.h
> +++ b/lib/ubsan.h
> @@ -78,6 +78,12 @@ struct invalid_value_data {
>         struct type_descriptor *type;
>  };
>
> +struct alignment_assumption_data {
> +       struct source_location location;
> +       struct source_location assumption_location;
> +       struct type_descriptor *type;
> +};
> +
>  #if defined(CONFIG_ARCH_SUPPORTS_INT128)
>  typedef __int128 s_max;
>  typedef unsigned __int128 u_max;
>
> base-commit: 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04
> --
> 2.30.0
>


-- 
Thanks,
~Nick Desaulniers
