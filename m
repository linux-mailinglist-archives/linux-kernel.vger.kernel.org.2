Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D4042B3B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbhJMDjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhJMDjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:39:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FACE60EE5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634096227;
        bh=hTlf7sTMBOXUv6/B2hQkKRwMWrRMRFh54bzp89OP9DA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RqnCmIv9WhurJLj/9eSsS07KK+ZUpi+9qmCzse5Y83S/LApsXQU3poffL3rWb2sdq
         3r7dkdfXVR+AchA7Zcczl9kzhS+ff3dZFix3+X9UmZgrLCxtt2IzwAiOcor/WBCwBN
         SrO8m50svxi/9GrkJn/o1hWBqdFW7Pc+26+4o8LLqfVZBGZIbjetP7P8AbeqkHlcdM
         KQSc26c6qQ9/pwM2/3D8RxgJAGVRrCZsxMMFWGuE8PUQrfwv7XbciqMnTqPJoZD/uT
         wVfueOpyG3hHzmr2iH9VbvQYZJshGu7jrYb58WNzT/f7Vxtxx2IGlcn2dNjVu2N35m
         RH6T92dWfCpAg==
Received: by mail-ua1-f46.google.com with SMTP id u5so1785361uao.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:37:07 -0700 (PDT)
X-Gm-Message-State: AOAM533cvCbMGiUtGa64DayEWHeBXR64WNDfSsRDYm6d/dqfABa/6Yu6
        dD8bzc0JVxwVcGy7mX8p3T2j5P0D7olIDJ9G93o=
X-Google-Smtp-Source: ABdhPJypr78ABw3NJ+GHflDLyAsmpFGEXSkcC6fwy/AzKQzS5xqcI96oVqxGLyy4dSNrg+uD/WGKOORSYtpwlDzf+pk=
X-Received: by 2002:a67:c08d:: with SMTP id x13mr36141812vsi.43.1634096226559;
 Tue, 12 Oct 2021 20:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211012183344.105637-1-wefu@redhat.com>
In-Reply-To: <20211012183344.105637-1-wefu@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 13 Oct 2021 11:36:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ90iYCniasERD4F1sME8iqt3xqOJa4k0zNxpQcZHgiRA@mail.gmail.com>
Message-ID: <CAJF2gTQ90iYCniasERD4F1sME8iqt3xqOJa4k0zNxpQcZHgiRA@mail.gmail.com>
Subject: Re: [PATCH 0/2] riscv: Add RISC-V svpbmt extension supports
To:     wefu@redhat.com
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com,
        Aniket Ponkshe <aniket.ponkshe@canonical.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Gordan Markus <gordan.markus@canonical.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        "Xinhaoqu (Freddie)" <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Fu Wei <fu.wei@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please add V3 in the prefix, I think you need to resend it with PATCH
V3 and abandon this one.

On Wed, Oct 13, 2021 at 2:34 AM <wefu@redhat.com> wrote:
>
> From: Fu Wei <fu.wei@linaro.org>
>
> This patch follows the standard pure RISC-V Svpbmt extension in
> privilege spec to solve the non-coherent SOC DMA synchronization
> issues.
>
> Wei Fu (2):
>   dt-bindings: riscv: Add mmu-supports with svpbmt
>   riscv: Add RISC-V svpbmt supports
>
>  .../devicetree/bindings/riscv/cpus.yaml       |  5 +++
>  arch/riscv/include/asm/fixmap.h               |  2 +-
>  arch/riscv/include/asm/pgtable-64.h           |  8 ++--
>  arch/riscv/include/asm/pgtable-bits.h         | 41 ++++++++++++++++++-
>  arch/riscv/include/asm/pgtable.h              | 39 ++++++++++++++----
>  arch/riscv/kernel/cpufeature.c                | 32 +++++++++++++++
>  arch/riscv/mm/init.c                          |  5 +++
>  7 files changed, 117 insertions(+), 15 deletions(-)
>
> --
> 2.25.4
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
