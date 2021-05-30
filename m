Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D7E394E9F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 02:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhE3AY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 20:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhE3AY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 20:24:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EE3D6109E;
        Sun, 30 May 2021 00:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622334199;
        bh=l7fJ1rvgich0C3XV0SqFIRoaMcntzInwVPHPG2ByWUA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tvuVKUC9i7AtzrAGyPQhmQq4cjZnBICps6GSMn9R1r2rdCYx7WK75y1QRYvN3D78Z
         Xnb9P5bNfW7jgw8oxSew0mQ4QNDFTXqwELh3f2pOd+pkkNhlzAYp3pg59FnEu9RGP9
         yMu6OTRkefFzcz2AM48MHcXs+kWSv1Tjwg3cHKffVsd82b9Dm1BiBCStiHETVcVQv8
         ai3Osw/z7+rzwaNMvuJdjil67mTXRb5bggtrD0T4lW0m2oNf0Vibd0U2FLUR5caki9
         G6TgXcaTBdIdeG01EedyQjXJCZ/prQlJfbHQgPi9Jc8Kmh0ZCJeelb/aNL1LgEaolP
         +sCijt3jOrWSQ==
Received: by mail-lf1-f52.google.com with SMTP id q7so11077246lfr.6;
        Sat, 29 May 2021 17:23:19 -0700 (PDT)
X-Gm-Message-State: AOAM530dSiVUeuiAEm9k5gEsVz6WGHDNNGt/t/YYgxiK7EuTNbAR88A1
        mvQqzccQaVeQZipqsKMaeS68+eWXj/wResvDhpg=
X-Google-Smtp-Source: ABdhPJxi9g+STuD26tX0+U15VfZZUiRc0hXknd0ey6aTNrm609q1LUvr8g/CxShqaeL3MUWpZHv3P6kfdJl4e7V/SvY=
X-Received: by 2002:a05:6512:3993:: with SMTP id j19mr10942351lfu.231.1622334197446;
 Sat, 29 May 2021 17:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210529105504.180544-1-wangkefeng.wang@huawei.com> <20210529105504.180544-6-wangkefeng.wang@huawei.com>
In-Reply-To: <20210529105504.180544-6-wangkefeng.wang@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 30 May 2021 08:23:05 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQpjgKrO72aSt-wzs77N7Lu6uahgURL1YDZ89sARYoFRw@mail.gmail.com>
Message-ID: <CAJF2gTQpjgKrO72aSt-wzs77N7Lu6uahgURL1YDZ89sARYoFRw@mail.gmail.com>
Subject: Re: [PATCH 05/15] csky: convert to setup_initial_init_mm()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

Thx

On Sat, May 29, 2021 at 6:46 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> Use setup_initial_init_mm() helper to simplify code.
>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/csky/kernel/setup.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
> index e93bc6f74432..c64e7be2045b 100644
> --- a/arch/csky/kernel/setup.c
> +++ b/arch/csky/kernel/setup.c
> @@ -78,10 +78,7 @@ void __init setup_arch(char **cmdline_p)
>         pr_info("Phys. mem: %ldMB\n",
>                 (unsigned long) memblock_phys_mem_size()/1024/1024);
>
> -       init_mm.start_code = (unsigned long) _stext;
> -       init_mm.end_code = (unsigned long) _etext;
> -       init_mm.end_data = (unsigned long) _edata;
> -       init_mm.brk = (unsigned long) _end;
> +       setup_initial_init_mm(_stext, _etext, _edata, _end);
>
>         parse_early_param();
>
> --
> 2.26.2
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
