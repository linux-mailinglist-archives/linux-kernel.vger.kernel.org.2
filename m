Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97BD39BEC6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhFDRaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhFDRap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:30:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923EAC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 10:28:58 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id d2so8384561ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 10:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QKFzPq8aab5JwJksCUS9Z59L9/ulxj+Lc/VprNH13LY=;
        b=NvFLRGLWJoBbV338vFlpCo0SypqpweiEyvqNSS+SB3IVq4iJQ+a6pDPw5Hp03GOyN1
         c4DHOUviS777xvd845ZHxosqMB+z3MbGQX2OIhsZe9wyPgbPAQ6f6MbIfQgHnFJiWX7I
         8Mo45+CrTG5RNw6gR8ttpOKDu8qkhpsYo6A+ir6xeqXjcEoYsCqH//Nu8b+B78FWPsx4
         4EKOeKu4jjP7i2qciro1kCeg6gv5jLM1ZfFUbQ4RxtOPAwSTXDfg+EnW4bXvA5xcu5np
         D8rJefPHtT+jykrnXx03F9vbDM8LKXe9Pov/NvLvsgtSkQH+Kv7wqpvj7sfRz1ZJFSYS
         uZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QKFzPq8aab5JwJksCUS9Z59L9/ulxj+Lc/VprNH13LY=;
        b=DsKMdDcS4NwPDsIPXCLYtubu3KuefVPY10gwxGlJ/LDG4EyUnoRDm/dUcVfWZaFxNw
         nopEpJMpOTVElfotBM/1yf8hwmcjlPEwGMD+pld8zyAfA2wX2AZVdbEExYv8ohbTE5fZ
         z33lp1fRddWtN1Y+7B2W3+Ix6p/d1eAFzq8q7oKZODBQ57wNjLGzIKr4+2uhHZAB11FD
         y7kdziFTi9HDK1ddfydm6ujFTxFJKzOeDwR+JZUs7TOBKpmkmySUGLpCpjsG2A8vWYy8
         cQLwiG2WK3ihiS8Kn6cAwLopGNqQ/seb2h7iplS/D/hMBloqbwopoUBPiEHKmktBiIXR
         dF9Q==
X-Gm-Message-State: AOAM533tHSxGv5SJeRCW2Ic08xKkGkEuOz4/HmvisfToRdGGslDxqk2z
        eXJVudTpiwqTUPJcEj20vsicCXGTYboTi78ZBnNWkA==
X-Google-Smtp-Source: ABdhPJwMjB2dQ59ntRmT2WCd4qUlMDeXqDqO1Sxb4JWJbevgSnSeWhJ/LwkzOq2beacXcZ2+67t4wmxGltsufLDv0Lg=
X-Received: by 2002:a2e:8056:: with SMTP id p22mr4222936ljg.341.1622827736693;
 Fri, 04 Jun 2021 10:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210604165819.7947-1-jarmo.tiitto@gmail.com>
In-Reply-To: <20210604165819.7947-1-jarmo.tiitto@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 4 Jun 2021 10:28:45 -0700
Message-ID: <CAKwvOd=4yRVZGCK36M-X_9TSxfJNWBWKfVnWO4-MQr47YkMPPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] pgo: Fix allocate_node() v2
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 10:03 AM Jarmo Tiitto <jarmo.tiitto@gmail.com> wrote:
>
> When clang instrumentation eventually calls allocate_node()
> the struct llvm_prf_data *p argument tells us from what section
> we should reserve the vnode: It either points into vmlinux's
> core __llvm_prf_data section or some loaded module's
> __llvm_prf_data section.
>
> But since we don't have access to corresponding
> __llvm_prf_vnds section(s) for any module, the function
> should return just NULL and ignore any profiling attempts
> from modules for now.
>
> Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> ---
> Based on Kees and others feedback here is v3 patch
> that clarifies why the current checks in allocate_node()
> are flawed. I did fair amount of KGDB time on it.
>
> The commit is based on kees/for-next/clang/features tree,
> hopefully this is ok. Should I have based it on linux-next
> instead?
>
> I grep -R'd where the memory_contains() can be found and it is only
> found in #include <asm-generic/sections.h>
>
> I cross my fingers and await if this is my first accepted patch. :-)
> ---
>  kernel/pgo/instrument.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
> index 0e07ee1b17d9..c69b4f7ebaad 100644
> --- a/kernel/pgo/instrument.c
> +++ b/kernel/pgo/instrument.c
> @@ -18,6 +18,7 @@
>
>  #define pr_fmt(fmt)    "pgo: " fmt
>
> +#include <asm-generic/sections.h>

^ What about Nathan's feedback on this being just `<asm/sections.h>`?

>  #include <linux/bitops.h>
>  #include <linux/kernel.h>
>  #include <linux/export.h>
> @@ -55,17 +56,21 @@ void prf_unlock(unsigned long flags)
>  static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
>                                                  u32 index, u64 value)
>  {
> -       if (&__llvm_prf_vnds_start[current_node + 1] >= __llvm_prf_vnds_end)
> -               return NULL; /* Out of nodes */
> -
> -       current_node++;
> -
> -       /* Make sure the node is entirely within the section */
> -       if (&__llvm_prf_vnds_start[current_node] >= __llvm_prf_vnds_end ||
> -           &__llvm_prf_vnds_start[current_node + 1] > __llvm_prf_vnds_end)
> +       const int max_vnds = prf_vnds_count();
> +
> +       /*
> +        * Check that p is within vmlinux __llvm_prf_data section.
> +        * If not, don't allocate since we can't handle modules yet.
> +        */
> +       if (!memory_contains(__llvm_prf_data_start,
> +               __llvm_prf_data_end, p, sizeof(*p)))
>                 return NULL;
>
> -       return &__llvm_prf_vnds_start[current_node];
> +       if (WARN_ON_ONCE(current_node >= max_vnds))
> +               return NULL; /* Out of nodes */
> +
> +       /* reserve vnode for vmlinux */
> +       return &__llvm_prf_vnds_start[current_node++];
>  }
>
>  /*
>
> base-commit: 5d0cda65918279ada060417c5fecb7e86ccb3def
> --
> 2.31.1
>


-- 
Thanks,
~Nick Desaulniers
