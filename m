Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE56A3A5160
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 01:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhFLX0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 19:26:34 -0400
Received: from mail-yb1-f179.google.com ([209.85.219.179]:39531 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLX0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 19:26:31 -0400
Received: by mail-yb1-f179.google.com with SMTP id b74so7894795yba.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 16:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJvUpxxUz79lLuDu+DpE+fZYWMRbYUvVJx4ks7pc19U=;
        b=DmQcda/f+RdMVBor+q96+WlzKA7xQ+hmjPcyodk+MrY04fJVhsgzJCIFgInoN8sUyr
         dSCReVdFiwZyiTz4n5wU/E+T05DHiKl/NCWWo5AcMP4X+FoRl2ucOeTg8ARE8ESHgNgI
         tLPhtxXzDD05e+GjF+Np0vP84YRP/Xikp76LcEK1l3wJePDEKYGhveKHel/3rTmPG0xz
         3qJr/9l46D+BvVJ3ubLqp5bW5l/ENFCp5DbyjyZJ7ARXLiRSfrI/Lyrb3Rgmk8nqC6EA
         LbGk0thFsC0NO9Hdu4bCJueqhEMWz8WdLP87nxujJdPm1gw6uW4DeFkw9FGFhVfaafc1
         q91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJvUpxxUz79lLuDu+DpE+fZYWMRbYUvVJx4ks7pc19U=;
        b=JglAWQLDavZQlOTb24A9q012LGJaD8XYl3f0D8jkxycPseYMjjHYeiH1b7+TVhjO5/
         QoOzvh1UiIHcHi8E/RrfqEzjknwwprUiDcUMhRhrgo4j5byYYjlu1zKt3ysS7J1Pk+/P
         TR3+QuwYGTyQJABi4oKxueKc1ECXO3cj8kHNMhcG+tBy9hj2gluwMLmU70IwiSlIzrpZ
         2sTS2RscN+5MTlYEloVRN7fssvR5J2whtQ4odoRzoOwF3IEbEtAJJyPOG2+6dvFmhjji
         9nhFJgxcg5EP2XlftUrMJT0FTVZMWJOJz5qYTWhAy9halSK0fuRGLFdrQuZ2rveleVl6
         5OCg==
X-Gm-Message-State: AOAM531eNo+faLqMBwMWeW67vk2CbbTZW1UMTHNoprsPSZcXD74jEthu
        MPI/ge65/9/Ob/F49eob09fBIW6fpzMVrOFaF2g=
X-Google-Smtp-Source: ABdhPJxL7FtlAhag2R0WiXkfjm9WzWMAW0S5Upbz/p6qgfkPgXylLiQ4hnJcuXVFQQ/MfrvQ0eKivkVuA4TRlGJEDjg=
X-Received: by 2002:a25:d4d4:: with SMTP id m203mr15640674ybf.393.1623540194716;
 Sat, 12 Jun 2021 16:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210604114950.1446390-1-alex@ghiti.fr> <20210604114950.1446390-2-alex@ghiti.fr>
In-Reply-To: <20210604114950.1446390-2-alex@ghiti.fr>
From:   Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date:   Sun, 13 Jun 2021 01:23:03 +0200
Message-ID: <CANBLGcy3HrnmrweSpnDZViVstoWJYh4sCBoaX_24AsgWd=Q9XA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 at 13:51, Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Make the physical RAM base address available for all kernels, not only
> XIP kernels as it will allow to simplify address conversions macros.

Am I just reading it wrong or won't this patch make it so that the same kernel
can't run on two chips with physical ram starting at different addresses?

/Emil

> ---
>  arch/riscv/Kconfig | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b58596b141fc..3d8e7e4bb45c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -493,13 +493,8 @@ config STACKPROTECTOR_PER_TASK
>         def_bool y
>         depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
>
> -config PHYS_RAM_BASE_FIXED
> -       bool "Explicitly specified physical RAM address"
> -       default n
> -
>  config PHYS_RAM_BASE
>         hex "Platform Physical RAM address"
> -       depends on PHYS_RAM_BASE_FIXED
>         default "0x80000000"
>         help
>           This is the physical address of RAM in the system. It has to be
> @@ -512,7 +507,6 @@ config XIP_KERNEL
>         # This prevents XIP from being enabled by all{yes,mod}config, which
>         # fail to build since XIP doesn't support large kernels.
>         depends on !COMPILE_TEST
> -       select PHYS_RAM_BASE_FIXED
>         help
>           Execute-In-Place allows the kernel to run from non-volatile storage
>           directly addressable by the CPU, such as NOR flash. This saves RAM
> --
> 2.30.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
