Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906643A1481
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhFIMf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230377AbhFIMfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:35:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B213613B9;
        Wed,  9 Jun 2021 12:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623242011;
        bh=/gF/nMiVYi77wMD7BAky1aCWDTXgkdMSrbE1ZV3y7uM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aI4ts5hTJ5GIU7pNjI+KAZnGPBKg/M19RU0DyrnUtrv1ILRmYnGg2q5r+lpcDnZne
         bGGyQdHt4j+zcp5LfJ0UFZYVkqzPAKfVju+TZffJmkS0x9pZ5idFluGSFRj6I4SZzL
         wRxGo81ddgbjkFLv6ewaEIeWwAMclkKoMy3niI0oU7pPu4dLXKeofViRuyxlLotvqX
         0TGDTx2PJoLRsHPNQ00GxB3sCQevpA2Tph8NXmkkhP7XDhXbQaYqaNxH7vt+aOGcco
         TTeydzG2j+nLpGxcWSotgyJXHvckExq1+VPJS8ipFbnKAw+uywcGA/YjbIUDprtIvT
         EHmyErMec9MNg==
Received: by mail-lf1-f42.google.com with SMTP id n12so30754578lft.10;
        Wed, 09 Jun 2021 05:33:31 -0700 (PDT)
X-Gm-Message-State: AOAM53141tznF0BvznYCaWutGHN0lQ0OhoUgOQuDVvjyMv/j7LOC2ONN
        dOJZBczgaSItdLZBFVKho7r8v6uXtlcsZeKihNY=
X-Google-Smtp-Source: ABdhPJwY7ebyRdwNRhEME05N+z2lxITf6zyGNzyaVgGRhjICH5ZPnlN8ZciSAd5wBCoqmvxTWgDmCyrH+t9jXy71HK8=
X-Received: by 2002:a05:6512:218d:: with SMTP id b13mr19125081lft.346.1623242009380;
 Wed, 09 Jun 2021 05:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210609105019.3626677-1-punitagrawal@gmail.com> <20210609105019.3626677-5-punitagrawal@gmail.com>
In-Reply-To: <20210609105019.3626677-5-punitagrawal@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 9 Jun 2021 20:33:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS_tmOYFNaLYQmJvbwZwksMctPPbE6GAGgUYTwvLLwE=w@mail.gmail.com>
Message-ID: <CAJF2gTS_tmOYFNaLYQmJvbwZwksMctPPbE6GAGgUYTwvLLwE=w@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] csky: ftrace: Drop duplicate implementation of arch_check_ftrace_location()
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

csky using -mcount not -fpatchable-function-entry, so
                /* Given address is not on the instruction boundary */
                if ((unsigned long)p->addr != ftrace_addr)
                        return -EILSEQ;
all right?

On Wed, Jun 9, 2021 at 6:51 PM Punit Agrawal <punitagrawal@gmail.com> wrote:
>
> The csky specific arch_check_ftrace_location() shadows a weak
> implementation of the function in core code that offers the same
> functionality but with additional error checking.
>
> Drop the architecture specific function as a step towards further
> cleanup in core code.
>
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Cc: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/csky/kernel/probes/ftrace.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
> index ef2bb9bd9605..b388228abbf2 100644
> --- a/arch/csky/kernel/probes/ftrace.c
> +++ b/arch/csky/kernel/probes/ftrace.c
> @@ -2,13 +2,6 @@
>
>  #include <linux/kprobes.h>
>
> -int arch_check_ftrace_location(struct kprobe *p)
> -{
> -       if (ftrace_location((unsigned long)p->addr))
> -               p->flags |= KPROBE_FLAG_FTRACE;
> -       return 0;
> -}
> -
>  /* Ftrace callback handler for kprobes -- called under preepmt disabled */
>  void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>                            struct ftrace_ops *ops, struct ftrace_regs *fregs)
> --
> 2.30.2
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
