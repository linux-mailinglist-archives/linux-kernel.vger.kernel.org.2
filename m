Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA583796EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhEJSUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhEJSUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:20:48 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D63C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 11:19:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j10so24733163lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 11:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLEPdHE/lUDqSfzKgjlnQIQkgZHfxgrF+vujnKkyTIM=;
        b=cS3HdG8156DCaEKIJ+gTF1weCypb9gV1HaJjmr1Aqq0coGamkyOxKt3YpLZLmcRAOi
         zAKb2gl2KQnO+XP/itg7MwOmO/ebuGOZ044jSVLRZfBrIqC2t2jleOBLqT7xmc0Wc9B4
         C6CFtQrFxWqJ0cwLcve8MBErb+lO0oE+VQu4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLEPdHE/lUDqSfzKgjlnQIQkgZHfxgrF+vujnKkyTIM=;
        b=rcvu17bvn36QvzezjELIM51pZG5lB2joVicDmY0OjvGdmwMr+jZzDalvjuLOQ7qGF2
         z9dAOSbxumr0vAmZUb9imiJy5LFQgTfW37GLN6nAirp9Hsn4trD6w03BnhHP+L6lDzu1
         XX94839O/Wz8MlTlHs61iYt1t8T3VylO8arRwFjMTh0NVBpIiF1uZ/m6E8WviWwe9xio
         hcNfYg+sBcZbhD4KrfjVXESr3LytBH1yl3W5nsjP/k2lsYsIEg8rO4ZzSvGPHyiRCI0C
         Icq4Fp/9Bg8hBziVTtUp9EsH8WdvX+FAcKad1G/s2kXxl8EFapCxEe4klFrKB8AbjnsR
         f/cw==
X-Gm-Message-State: AOAM5329WK5J9sgd9bkEeaQGRx9w/HO9lqaIe3wVZnSA7Zj2wBT86pos
        /cFhT2aNFUbNy8xfGqtYQPGB1+/ArnAwNzvd3Hic6A==
X-Google-Smtp-Source: ABdhPJxs4LHfNXqgUxARz6fo8mRzkAZgx4ftO6ABggMu744wQqHYQJ+4SXfGJhXSiabP8RKsd02US/YzOyc1q9fHTjs=
X-Received: by 2002:ac2:5a07:: with SMTP id q7mr3615365lfn.407.1620670781305;
 Mon, 10 May 2021 11:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210511002838.7b3cb1e7@xhacker>
In-Reply-To: <20210511002838.7b3cb1e7@xhacker>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Mon, 10 May 2021 20:19:30 +0200
Message-ID: <CAM4kBBJqF=AxTu50PF=EshLSyqn0=yeC2dwf4JJj_Grsi_Tccg@mail.gmail.com>
Subject: Re: [PATCH] riscv: code patching only works on !XIP_KERNEL
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 6:35 PM Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
>
> From: Jisheng Zhang <jszhang@kernel.org>
>
> Some features which need code patching such as KPROBES, DYNAMIC_FTRACE
> KGDB can only work on !XIP_KERNEL. Add dependencies for these features
> that rely on code patching.

Since we can define extra RW sections to place some tiny code bits in
RAM, I would suggest that you hold back this patch for a while.
I am not going to support the idea of e. g. compiling KGDB support
into a XIP kernel, but disabling the whole HAVE_ARCH_JUMP_LABEL is
hardly the way to go.

Best regards,
   Vitaly

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> Hi,
>
> Currently, the RISCV_ERRATA_ALTERNATIVE also only works on !XIP_KERNEL
> but from the maillist it seem there's effort to make the co-exist, so
> I drop RISCV_ERRATA_ALTERNATIVE dependency on !XIP_KERNEL.
>
> Thanks
>
>  arch/riscv/Kconfig | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a8ad8eb76120..61320b94ef97 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -60,11 +60,11 @@ config RISCV
>         select GENERIC_TIME_VSYSCALL if MMU && 64BIT
>         select HANDLE_DOMAIN_IRQ
>         select HAVE_ARCH_AUDITSYSCALL
> -       select HAVE_ARCH_JUMP_LABEL
> -       select HAVE_ARCH_JUMP_LABEL_RELATIVE
> +       select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
> +       select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
>         select HAVE_ARCH_KASAN if MMU && 64BIT
>         select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
> -       select HAVE_ARCH_KGDB
> +       select HAVE_ARCH_KGDB if !XIP_KERNEL
>         select HAVE_ARCH_KGDB_QXFER_PKT
>         select HAVE_ARCH_MMAP_RND_BITS if MMU
>         select HAVE_ARCH_SECCOMP_FILTER
> @@ -79,9 +79,9 @@ config RISCV
>         select HAVE_GCC_PLUGINS
>         select HAVE_GENERIC_VDSO if MMU && 64BIT
>         select HAVE_IRQ_TIME_ACCOUNTING
> -       select HAVE_KPROBES
> -       select HAVE_KPROBES_ON_FTRACE
> -       select HAVE_KRETPROBES
> +       select HAVE_KPROBES if !XIP_KERNEL
> +       select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> +       select HAVE_KRETPROBES if !XIP_KERNEL
>         select HAVE_PCI
>         select HAVE_PERF_EVENTS
>         select HAVE_PERF_REGS
> @@ -230,11 +230,11 @@ config ARCH_RV64I
>         bool "RV64I"
>         select 64BIT
>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && GCC_VERSION >= 50000
> -       select HAVE_DYNAMIC_FTRACE if MMU && $(cc-option,-fpatchable-function-entry=8)
> +       select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> -       select HAVE_FTRACE_MCOUNT_RECORD
> +       select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>         select HAVE_FUNCTION_GRAPH_TRACER
> -       select HAVE_FUNCTION_TRACER
> +       select HAVE_FUNCTION_TRACER if !XIP_KERNEL
>         select SWIOTLB if MMU
>
>  endchoice
> --
> 2.31.0
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
