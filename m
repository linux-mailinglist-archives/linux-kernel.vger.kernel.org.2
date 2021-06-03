Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759F439ABFA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 22:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFCUw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 16:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCUw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 16:52:26 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C49C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 13:50:30 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id d2so4656302ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 13:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFtpiwNW4KLJeXVYDPJIFJ4JjYTJQN5IziHpM5XenKM=;
        b=tPdzhjkBMFZeUaSvkaoNmsbA0mixzlvilV5zFbinUt6EsDg290BVc+Jn/zjt0pPEOQ
         yqSdS+4YyAv3HHelO5Rry7oytqWTRFqg87jO+1JIl7+mPTrQP7OdS6BhuRqUMNHiyOWX
         Sv5w++F7JTRcK6W3bIroztXeyn4DnOYHirMyPbkW1UiO3lpmUSy9uT6UtpSyHygxK85b
         +w9396XVTWWa9fAY1MEM+fRG8KV/izJf9uCO9RBp1cE1x9nmK/FMheMzKCL1K2RH9HdN
         ClN2jqSNYfgJ4chfP01P7zvQQTGECqU50PVwbIVLLiGFFnu8Ylo9QB1J+iQ5087JT/TF
         8SBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFtpiwNW4KLJeXVYDPJIFJ4JjYTJQN5IziHpM5XenKM=;
        b=U1uIl8RXV0yo18Gu5a+c8c2EslfjSPVc0DlPJKkXr2dpzQeu1/3z5baGMP12RyQuAD
         gmAu6w8YHRqdP5j55qJEP6s9nXdl0xHgvmYyNaopPCvXAuaNcHiT7GeEdXhGXnRgBqi1
         nqSIbr0mkHrviUF7oAL60XlaL650x7/HN2y9A2aOKLSNPqDqUv6p/cfwNHk4B4ttW8OQ
         qbPdgoYWdaVSfu+Sp/soy297rbwmZi68VpfawI7FUcN/seBI7tM6ZUX3w89WjG48t5Wy
         fMFkdgfQP9AGAtaAXX396pQM/K9u1z9dZ+KRSfv32kRgqNTp6RKxlHMC6h7w4kEAoZWy
         FQXg==
X-Gm-Message-State: AOAM533++vQrnMiAg+3036FR5TZLs0/+Pzq0uygfrAtbebbeockCsbK9
        tNg9AFVmIjVGZxhxOzlv0p2pRaqL+A8l3WmmR69F4g==
X-Google-Smtp-Source: ABdhPJzjX7jFwPZR7KnjnwzitAWKp0I6YhcpBAcIVkQkjKJPqGg+XeIoDAJEnzghsq5U0zx4Yb5n6AtXW5yp88sHlLg=
X-Received: by 2002:a2e:6e13:: with SMTP id j19mr882738ljc.116.1622753428492;
 Thu, 03 Jun 2021 13:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210603133853.5383-1-jarmo.tiitto@gmail.com>
In-Reply-To: <20210603133853.5383-1-jarmo.tiitto@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Jun 2021 13:50:17 -0700
Message-ID: <CAKwvOd=ygrySyMkJuGwyG7OPCOrTagcFn02RfEKANvhhuZJdOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pgo: Fix allocate_node() v2
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

On Thu, Jun 3, 2021 at 6:41 AM Jarmo Tiitto <jarmo.tiitto@gmail.com> wrote:
>
> Based on Kees and others feedback here is v2 patch
> that clarifies why the current checks in allocate_node()
> are flawed. I did fair amount of KGDB time on it.

Kees can probably cut it when merging, but the above paragraph might
be better "below the fold" below next time (doesn't necessitate a v3).

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

^ ie. here. If you put text between the `---` and the diffstat, git
just discards it when applying. It's a good way to hide commentary
just meant for reviewers when sending a patch.


>  kernel/pgo/instrument.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
> index 0e07ee1b17d9..afe9982b07a3 100644
> --- a/kernel/pgo/instrument.c
> +++ b/kernel/pgo/instrument.c
> @@ -23,6 +23,7 @@
>  #include <linux/export.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> +#include <asm-generic/sections.h>
>  #include "pgo.h"
>
>  /*
> @@ -55,17 +56,19 @@ void prf_unlock(unsigned long flags)
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

Sorry, where was prf_vnds_count() defined? I don't see it in
linux-next, but I'm also not sure which tree has
5d0cda65918279ada060417c5fecb7e86ccb3def.

> +       /* Check that p is within vmlinux __llvm_prf_data section.
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
