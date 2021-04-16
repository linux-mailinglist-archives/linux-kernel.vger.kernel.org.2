Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39892361E28
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbhDPKm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 06:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241749AbhDPKm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:42:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AA3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 03:42:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id w186so9515552wmg.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zex7i7Gm7ilDvh/qRtb14tTVDUsTiPnIyJ8lJBlTVDY=;
        b=o+NE8pGADgY4FrSGIXWUfJDlnJ1juLdQCdEiocUx/f4kBswMU6EacEfCbch4zfDr8H
         +8aCGjJXpl6SK20MOt1VpdXaX4BbkHmki5A2hh1gmZ20w2EMJP1VjnEsC8VADb9byTqY
         lE+sl5rG/g22g2pLcBDdBqPUtuuihLLbi7A6mVCOjdUC+LZqLYwD2VrW6Q33ZmABcitG
         osCWWS16aeTjD/SapJryOxU2/k5hi64Zs2KKTkPikhugxITJ9wbjvvaZwkFN1zhfoIGY
         lMbuOFwM6i8S1cr0T1JDeA7IJyAS5SdymT8sxxaVslfrawq50NfS7neQz6FJIXPKg4kh
         wuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zex7i7Gm7ilDvh/qRtb14tTVDUsTiPnIyJ8lJBlTVDY=;
        b=jwsc84bR8ypJJ9OItgfq02Vwyd94tr8DPZxzpVuMF82GtpnFdxzhluI0WIwK3ZOtgT
         rpT/KSbtwuKs2B3yJs/HoSmaRQNoLZcBIH2DFgEYB3Qlr+CuTxPy2oQ8/dFjxgWO4RXq
         e5mWc+umXC6xEjfY6N0r8CLH4dYbq8dNohdrvfG+5fjbEos9H4DC/33pOfo+az1QGlCM
         CVatzFxM53bc59abbH7WBKA0Mq5y1yEifyrNLCRMAk68osIoka4UFecguKPsEayxrlql
         zmIJapMku60Tdt7vYIVC5JK4zTRw/VfYqk/RDCPLCdUETAsPQXOT3CThpKa4Y0d82gnJ
         4b8w==
X-Gm-Message-State: AOAM532d6XinD/P3fGYrzB1eRu1FSgPs5fPJ+sHs4XGJdQLuMe3EhfxQ
        pN77dxQGU6LQrAktEEAEbhJs5q+ywjEkbvaq/fpr7A==
X-Google-Smtp-Source: ABdhPJzSZVwXQXIP/gEzyKiBpeLInXpc+75cZ3dvpf3JNqEHMcXwCYZIJpV2ZQZVzZT+LiXa+F2urN3JdQz1K4fuTB0=
X-Received: by 2002:a7b:c348:: with SMTP id l8mr7746989wmj.152.1618569721686;
 Fri, 16 Apr 2021 03:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210415110426.2238-1-alex@ghiti.fr>
In-Reply-To: <20210415110426.2238-1-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 16 Apr 2021 16:11:50 +0530
Message-ID: <CAAhSdy2pD2q99-g3QSSHbpqw1ZD402fStFmbKNFzht2m=MS8mQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Protect kernel linear mapping only if
 CONFIG_STRICT_KERNEL_RWX is set
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-doc@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 4:34 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> If CONFIG_STRICT_KERNEL_RWX is not set, we cannot set different permissions
> to the kernel data and text sections, so make sure it is defined before
> trying to protect the kernel linear mapping.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Maybe you should add "Fixes:" tag in commit tag ?

Otherwise it looks good.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kernel/setup.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 626003bb5fca..ab394d173cd4 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -264,12 +264,12 @@ void __init setup_arch(char **cmdline_p)
>
>         sbi_init();
>
> -       if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
> +       if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
>                 protect_kernel_text_data();
> -
> -#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
> -       protect_kernel_linear_mapping_text_rodata();
> +#ifdef CONFIG_64BIT
> +               protect_kernel_linear_mapping_text_rodata();
>  #endif
> +       }
>
>  #ifdef CONFIG_SWIOTLB
>         swiotlb_init(1);
> --
> 2.20.1
>
