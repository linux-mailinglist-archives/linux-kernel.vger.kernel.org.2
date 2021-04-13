Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B8635D636
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 06:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhDMEBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 00:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbhDMEBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 00:01:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1F18613A9;
        Tue, 13 Apr 2021 04:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618286479;
        bh=hpnw2nKPb9Ndm4uluaVicDCXqdjQyhxlgbyqbyFTc4Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dqauZ3xPo0/bdFXc76b11NTV8nDKgb7sDfPmXKaIZoMkwEAWYQSodkE1kwfDuNsW2
         4878b5STczcPmNei+CN4YoY96/5D5uzxjHotjyoiUeMcq/uvgl/Lc7QDKt5d1hoccH
         xJPmYMrmPy9yz3Js+G7fZknuwRU0Tapa0QQ91143dnGFokVz37B09ouaz1qZsSouSe
         1dFeltQd2XgXufobO8Yi5f3kj10UNAOcfEoiletrx2di9SLB+rMVYAwyzB4uyc5PqC
         uxunyRdhAwyOSBcN5bfYBE1GMrgv1k2J1q062D8x6EAL91LrBJKhSt418vz/Zq9jZP
         O8oJk2YvtFt4g==
Received: by mail-lj1-f173.google.com with SMTP id l22so10495482ljc.9;
        Mon, 12 Apr 2021 21:01:18 -0700 (PDT)
X-Gm-Message-State: AOAM5305lAA5cQJ8cf86eCKLDh+OqdiqwaKgWpsiS2+Q8UMqzZI2Pasy
        bFrNWUDedmI1Qy1li+QJIBiaaAgT0dVj2EtMVao=
X-Google-Smtp-Source: ABdhPJxyyf7wuYe5t3m6rhMQkWarqEbvh1027JXKnM916KJl2gEXkV4Xyx6lFrHcTNe0PKO6y3vIutlI7ZvHv+/beng=
X-Received: by 2002:a05:651c:3c3:: with SMTP id f3mr19661680ljp.105.1618286477301;
 Mon, 12 Apr 2021 21:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210411164104.5734-1-rdunlap@infradead.org>
In-Reply-To: <20210411164104.5734-1-rdunlap@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 13 Apr 2021 12:01:06 +0800
X-Gmail-Original-Message-ID: <CAJF2gTThvx36XmatbxyuYBEj5b264ueA8NGrS_KuFVtcA_CD-g@mail.gmail.com>
Message-ID: <CAJF2gTThvx36XmatbxyuYBEj5b264ueA8NGrS_KuFVtcA_CD-g@mail.gmail.com>
Subject: Re: [PATCH] csky: fix syscache.c fallthrough warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

It's a fallthrough is for BCACHE, but affects ICACHE with more
expensive. I'll fix up it later.

        }

On Mon, Apr 12, 2021 at 12:41 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> This case of the switch statement falls through to the following case.
> This appears to be on purpose, so declare it as OK.
>
> ../arch/csky/mm/syscache.c: In function '__do_sys_cacheflush':
> ../arch/csky/mm/syscache.c:17:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    17 |   flush_icache_mm_range(current->mm,
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    18 |     (unsigned long)addr,
>       |     ~~~~~~~~~~~~~~~~~~~~
>    19 |     (unsigned long)addr + bytes);
>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../arch/csky/mm/syscache.c:20:2: note: here
>    20 |  case DCACHE:
>       |  ^~~~
>
> Fixes: 997153b9a75c ("csky: Add flush_icache_mm to defer flush icache all")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
> @Guo, should this be a "break" instead of fallthrough?
>
>  arch/csky/mm/syscache.c |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20210409.orig/arch/csky/mm/syscache.c
> +++ linux-next-20210409/arch/csky/mm/syscache.c
> @@ -17,6 +17,7 @@ SYSCALL_DEFINE3(cacheflush,
>                 flush_icache_mm_range(current->mm,
>                                 (unsigned long)addr,
>                                 (unsigned long)addr + bytes);
> +               fallthrough;
>         case DCACHE:
>                 dcache_wb_range((unsigned long)addr,
>                                 (unsigned long)addr + bytes);



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
