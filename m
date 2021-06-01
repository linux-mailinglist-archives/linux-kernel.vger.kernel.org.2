Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7B6397A02
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhFASZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhFASY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:24:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B0AC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 11:23:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a2so23243284lfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4HQ0zyETBbXwypfTphsYhXQU5jUVi5BzIgs/sw7Qr8=;
        b=J3WL8E4quXYSmlALpA4XqSbRNMkkryxgkK8Ptt0YOOdNVi1/KYdNDnaoduKS8LK9Ge
         +8hEjlbbF6PZpEHEiW6QJQ8UjotEyliXvpGLMrsAVg+d3vsHVhmPK2Dbx6YqMlLN/jqk
         KNjQ2W2p7bXOzJt1psL/Gdw+VOxgShKjU5eB+tDUJMFNw51HL5vvDlU0rMkx8lyK9KPS
         2OOZOf1DCbA6rQHNGOiChXxGknvervBMVdMqENHWVGUMjPOOMxZxeorJAj42uQAoHF8H
         QzoTeHaAgktEa1mDkQ2VxhcU1edRIO970jXe9XT4qv4Or1wYiSBAEvGtg5CS2XforJBA
         z2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4HQ0zyETBbXwypfTphsYhXQU5jUVi5BzIgs/sw7Qr8=;
        b=jU4NFLY9TsFZI01m/t+NrremITnR8Df7/KISn91lyK2nVX6IP4NzKH9nQnwQpQgoTr
         IcRVEvJ7j762c3zJ72cWVoXOCTPpNWA3hRBGoBCL8F+lwdIH9Kcf19Ov/OPW2FCO/X7C
         ULpehMJyB+gqVLKnBa9S1pnymiy9u+DQz5D9zaDzUpTaPrwcVjSoRZaOF7LZwLOyiL/j
         Ku3zfyk6MGer72AtIq1EBbvad4L1s/tXTSoaD8YDy0ePl6tgpbncnrOygLmemX49wbZI
         0yfyq+rpz7hI4VaKZUHlr0YoJkQ+tRM3zof8HuMGOUKBt6Aj0l5zMcvl8W01iLz3/gsr
         P2fw==
X-Gm-Message-State: AOAM5303KGfeP/Rh+rLR8t/ng4fiFEmc6Qru/LL0FCO3VDgx55shajRj
        M1KaQtkUILKL/6Cp8ExUnPxz+etB1/6umoBkgqF35SFKXNEXcg==
X-Google-Smtp-Source: ABdhPJy/zOQjCtEcLcO5Uub6Z8ldJ7DPIhoekfBkdbkETLyqUfALtfTlQTl8mT1jH8Rq5WPnu6ej7VpO/dwlwsmRPc0=
X-Received: by 2002:a05:6512:220c:: with SMTP id h12mr20429141lfu.374.1622571795265;
 Tue, 01 Jun 2021 11:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210528182752.1852002-1-nathan@kernel.org>
In-Reply-To: <20210528182752.1852002-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Jun 2021 11:23:03 -0700
Message-ID: <CAKwvOd=Z60pm4rZw5yhpq-vCKb_xqxKa9xtgsCoknzD4VNj2wQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/barrier: Avoid collision with clang's __lwsync macro
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 11:29 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> A change in clang 13 results in the __lwsync macro being defined as
> __builtin_ppc_lwsync, which emits 'lwsync' or 'msync' depending on what
> the target supports.

Indeed,
$ clang --target=powerpc64le-linux-gnu -mcpu=e500 -m32
for example.

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> This breaks the build because of -Werror in
> arch/powerpc, along with thousands of warnings:
>
>  In file included from arch/powerpc/kernel/pmc.c:12:
>  In file included from include/linux/bug.h:5:
>  In file included from arch/powerpc/include/asm/bug.h:109:
>  In file included from include/asm-generic/bug.h:20:
>  In file included from include/linux/kernel.h:12:
>  In file included from include/linux/bitops.h:32:
>  In file included from arch/powerpc/include/asm/bitops.h:62:
>  arch/powerpc/include/asm/barrier.h:49:9: error: '__lwsync' macro redefined [-Werror,-Wmacro-redefined]
>  #define __lwsync()      __asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
>         ^
>  <built-in>:308:9: note: previous definition is here
>  #define __lwsync __builtin_ppc_lwsync
>         ^
>  1 error generated.
>
> Undefine this macro so that the runtime patching introduced by
> commit 2d1b2027626d ("powerpc: Fixup lwsync at runtime") continues to
> work properly with clang and the build no longer breaks.
>
> Cc: stable@vger.kernel.org
> Link: https://github.com/ClangBuiltLinux/linux/issues/1386
> Link: https://github.com/llvm/llvm-project/commit/62b5df7fe2b3fda1772befeda15598fbef96a614
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/powerpc/include/asm/barrier.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> index 7ae29cfb06c0..f0e687236484 100644
> --- a/arch/powerpc/include/asm/barrier.h
> +++ b/arch/powerpc/include/asm/barrier.h
> @@ -46,6 +46,8 @@
>  #    define SMPWMB      eieio
>  #endif
>
> +/* clang defines this macro for a builtin, which will not work with runtime patching */
> +#undef __lwsync
>  #define __lwsync()     __asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
>  #define dma_rmb()      __lwsync()
>  #define dma_wmb()      __asm__ __volatile__ (stringify_in_c(SMPWMB) : : :"memory")
>
> base-commit: 97e5bf604b7a0d6e1b3e00fe31d5fd4b9bffeaae
> --
> 2.32.0.rc0
>


-- 
Thanks,
~Nick Desaulniers
