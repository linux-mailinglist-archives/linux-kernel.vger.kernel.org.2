Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0703A4784
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhFKRMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhFKRMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:12:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9825B613D0;
        Fri, 11 Jun 2021 17:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623431450;
        bh=FfrPBTLS3IBVIVyyeuJrgFZ+eOxNJLAjI5MfDp/aJgE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VU5wP/l85pMtYrSDweQgAaUPIHsusCfDjF07cdtFKfQtoIIaokVemKetVswvZYash
         FkioIRy8dQFOiIQP+5w2TjVopahgobGeAH2i1Qj61jCDGFxqVCrxh+yB9IgQ83Isq3
         xVmhXwKsxZW0kZa7sg/7QmO6gjeV08NXO/IgNZlTiZPzirDqz+Yp5b0YbmXWbkXZBR
         v+g97Eq/G0EhB0EMF7Cf3OnCRSQX1+cqQUGahsTqeN8mlHl+p7INZ+1vcgVljQhmQo
         F0vZ/rKfzxyKNvpYQpvJKP+tZMbZRDXejJYQkwhOesVQ5vkJLY9jmem/0yjWxj9Nyq
         FWXezBTE043+Q==
Received: by mail-ed1-f50.google.com with SMTP id s6so37915329edu.10;
        Fri, 11 Jun 2021 10:10:50 -0700 (PDT)
X-Gm-Message-State: AOAM530nhzcJskyOQIaxbXafy2/dqVqDVQMQIFeWqBzWZi3ce6ipTYX0
        +VWzwfx66vn34CDUYEcBDO3m/ImIoMdDDN/dyA==
X-Google-Smtp-Source: ABdhPJzXen0iXLyQ/Wre3Q5uONhrHhT7pVpH9LXRTjzCQKgCTvYCot0lFJEJNZAnubFnbkobUzQlhicDi0/c0za+Bp0=
X-Received: by 2002:aa7:cac9:: with SMTP id l9mr4773587edt.373.1623431449052;
 Fri, 11 Jun 2021 10:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210611131153.3731147-1-aisheng.dong@nxp.com> <20210611131153.3731147-2-aisheng.dong@nxp.com>
In-Reply-To: <20210611131153.3731147-2-aisheng.dong@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 11 Jun 2021 11:10:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJMyY4iEcJi1z0o7pZdCASYHjnVjf6+fQDqa_ucb-M-MA@mail.gmail.com>
Message-ID: <CAL_JsqJMyY4iEcJi1z0o7pZdCASYHjnVjf6+fQDqa_ucb-M-MA@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: of_reserved_mem: mark nomap memory instead of removing
To:     Dong Aisheng <aisheng.dong@nxp.com>,
        Quentin Perret <qperret@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-mm <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dong Aisheng <dongas86@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 7:13 AM Dong Aisheng <aisheng.dong@nxp.com> wrote:
>
> Since commit 86588296acbf ("fdt: Properly handle "no-map" field in the memory region"),
> nomap memory is changed to call memblock_mark_nomap() instead of
> memblock_remove(). But it only changed the reserved memory with fixed
> addr and size case in early_init_dt_reserve_memory_arch(), not
> including the dynamical allocation by size case in
> early_init_dt_alloc_reserved_memory_arch().
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org

Good practice is to Cc the people involved in referenced commits.
Adding them now. This code is a minefield so I'd like other eyes on
it.

> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/of/of_reserved_mem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 367f298a83b2..ebba88395bf8 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -42,7 +42,7 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
>
>         *res_base = base;
>         if (nomap)
> -               return memblock_remove(base, size);
> +               return memblock_mark_nomap(base, size);
>
>         return memblock_reserve(base, size);
>  }
> @@ -276,7 +276,7 @@ void __init fdt_init_reserved_mem(void)
>                                 pr_info("node %s compatible matching fail\n",
>                                         rmem->name);
>                                 if (nomap)
> -                                       memblock_add(rmem->base, rmem->size);
> +                                       memblock_clear_nomap(rmem->base, rmem->size);
>                                 else
>                                         memblock_free(rmem->base, rmem->size);
>                         }
> --
> 2.25.1
>
