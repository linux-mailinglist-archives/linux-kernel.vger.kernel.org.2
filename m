Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6186A442512
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 02:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhKBB0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 21:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhKBB0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 21:26:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD58360296;
        Tue,  2 Nov 2021 01:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635816222;
        bh=pHB+2LvA/NTpkeqz8KeT7ncJiwdAgdeadepH/in3dDg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jvgkfEquB4pWMKLGA8eRvZVWmHOn+Jd9qFQONqEFWHUydd97oQtxQWvBIFdw1aQbM
         C8N1HGQLbE/iexOfFoDL8HVmS2YwbqpSevZIalmtLcZ/xAKKLzgap+8wtL1BUPbMbt
         DEj6TqnChC6VODSGXtSBMJm8vcNlljGFtbPcNy3Gjh/x28qPzzM4uPf4/0wx3k+qr7
         OllAp76QtKxVGwAanlSAeM5/jFTEnH/n+xkQrG8KdHw97z7ACLv66I28biwymQrLhP
         pcJGHiOEH3BxQM5Pqqa3FQz9yONu6XwwtdUph2u6GxB6kCgXS3fMh362qtxWcH9GR6
         ecUmHECrK7Xdw==
Received: by mail-ua1-f42.google.com with SMTP id i6so20860593uae.6;
        Mon, 01 Nov 2021 18:23:42 -0700 (PDT)
X-Gm-Message-State: AOAM532ArRpAcrX2mDeT2BtS21JbuzapVkiHNnQwd4TrvaBZrHxQ0Hmx
        rLJvU1TwC1VH18qu5pbZkDFIP5gXB1Wl9ZyY8Fo=
X-Google-Smtp-Source: ABdhPJxzeQ6fl1rfXujihBXdVjQnt/Rk4SsL/y0+BEWA+rS49WBxpqaiDO84drXXx+CXOBFih6F35DSjyLSsw60BHhk=
X-Received: by 2002:a67:ca1c:: with SMTP id z28mr34852395vsk.11.1635816221773;
 Mon, 01 Nov 2021 18:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211101150502.222969-1-kelly.devilliv@gmail.com>
In-Reply-To: <20211101150502.222969-1-kelly.devilliv@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 2 Nov 2021 09:23:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRzvX1M36cb9MFkM9-3jtCwfxtFsgGY8rVWfWZeavSRJg@mail.gmail.com>
Message-ID: <CAJF2gTRzvX1M36cb9MFkM9-3jtCwfxtFsgGY8rVWfWZeavSRJg@mail.gmail.com>
Subject: Re: [PATCH] csky: fix typo of fpu config macro
To:     Kelly Devilliv <kelly.devilliv@gmail.com>
Cc:     linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Kelly, approved.

On Mon, Nov 1, 2021 at 11:05 PM Kelly Devilliv <kelly.devilliv@gmail.com> wrote:
>
> Fix typo which will cause fpe and privilege exception error.
>
> Signed-off-by: Kelly Devilliv <kelly.devilliv@gmail.com>
> ---
>  arch/csky/kernel/traps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
> index e5fbf8653a21..2020af88b636 100644
> --- a/arch/csky/kernel/traps.c
> +++ b/arch/csky/kernel/traps.c
> @@ -209,7 +209,7 @@ asmlinkage void do_trap_illinsn(struct pt_regs *regs)
>
>  asmlinkage void do_trap_fpe(struct pt_regs *regs)
>  {
> -#ifdef CONFIG_CPU_HAS_FP
> +#ifdef CONFIG_CPU_HAS_FPU
>         return fpu_fpe(regs);
>  #else
>         do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->pc,
> @@ -219,7 +219,7 @@ asmlinkage void do_trap_fpe(struct pt_regs *regs)
>
>  asmlinkage void do_trap_priv(struct pt_regs *regs)
>  {
> -#ifdef CONFIG_CPU_HAS_FP
> +#ifdef CONFIG_CPU_HAS_FPU
>         if (user_mode(regs) && fpu_libc_helper(regs))
>                 return;
>  #endif
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
