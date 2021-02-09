Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E594C315351
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhBIP7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:59:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232691AbhBIP7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:59:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A82CC64E9A;
        Tue,  9 Feb 2021 15:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612886331;
        bh=IJua//cqqqUinix7gwbjM/4QR9mThGu9yQZFBL4FJAc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DUTaEpWg6YtP/Y715uqas5BYgqMYlljI70fK3Z9WU5BV60MoCuNStORz4eTiHX1g9
         iqloBYh/jLcM8UZF674lGCoHBVYmuith8LBZzOnAsNSl4Y/M2Ct6uDhySxjN3ia+6V
         1k088O8bEunSjDtI4kGriAbG/H5TQ+U2bu84gYK6kxStyCsXJEK7lgPedk1V1Ng37i
         1JnCAYBBWNztjn0gBqK7c4HeuBufSyAXyYUN7rRTw5rCk45lpbho7KJiycjDUrXF9j
         JUvYYNT6W4zrpJC0A+AGlV+yjUcubpqe8OoN9u0QwZr5jTz06MVKzs58lZXEoxlJru
         qh2uVL8p5wogg==
Received: by mail-lj1-f177.google.com with SMTP id c18so22979675ljd.9;
        Tue, 09 Feb 2021 07:58:50 -0800 (PST)
X-Gm-Message-State: AOAM5303fIi16gvN3SIXh2h2FmHOmQjQUoJUSNXfZ3c1tSrCnAlTWPq/
        z+PCiL6MWA3PKpuINF+i/vtv9wHGBRduPeo67zw=
X-Google-Smtp-Source: ABdhPJx1dhxMv52yuwMuToREGb1ahOpSTyrG7IShQ3g5bh+l8we587A5yLJ9OxpqcXaSZl2LC076s2qUiJaFpfZk+e0=
X-Received: by 2002:a2e:8945:: with SMTP id b5mr8282318ljk.508.1612886328943;
 Tue, 09 Feb 2021 07:58:48 -0800 (PST)
MIME-Version: 1.0
References: <1612865275-67721-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1612865275-67721-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 9 Feb 2021 23:58:37 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRxd2Bv8o_bTqYd-FFtLhkvsb4==gVwxUckDCNjG=52Mw@mail.gmail.com>
Message-ID: <CAJF2gTRxd2Bv8o_bTqYd-FFtLhkvsb4==gVwxUckDCNjG=52Mw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/csky: Use true and false for bool variable
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me, thx.

On Tue, Feb 9, 2021 at 6:08 PM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
>
> ./drivers/irqchip/irq-csky-apb-intc.c:139:9-10: WARNING: return of 0/1
> in function 'handle_irq_perbit' with return type bool.
>
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/irqchip/irq-csky-apb-intc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
> index 5a2ec43..5e18ba9 100644
> --- a/drivers/irqchip/irq-csky-apb-intc.c
> +++ b/drivers/irqchip/irq-csky-apb-intc.c
> @@ -136,11 +136,11 @@ static inline bool handle_irq_perbit(struct pt_regs *regs, u32 hwirq,
>                                      u32 irq_base)
>  {
>         if (hwirq == 0)
> -               return 0;
> +               return false;
>
>         handle_domain_irq(root_domain, irq_base + __fls(hwirq), regs);
>
> -       return 1;
> +       return true;
>  }
>
>  /* gx6605s 64 irqs interrupt controller */
> --
> 1.8.3.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
