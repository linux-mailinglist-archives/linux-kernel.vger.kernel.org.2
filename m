Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA6F3CF9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 14:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbhGTMAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236193AbhGTL72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:59:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14A2E61209
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626784807;
        bh=j5yVgUcbPHo9edWrwfukxKJRljArTBYReyh1q8GZdBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i2UbOfBgZahLU5oZHcy8xfhCmwtSLiE38CoeUbTaM7a0Qyjd+lynHPFItMnu+awu2
         XPzU9u6C83A5j/HsVvQKQM7NGPcMdlKhWJmInEsgppF4iKBbxGE3gxWxyQ+TAZ0+If
         rzulp6ApCaalvE6Z/fiO9gNNPW/QTEXXv00ezjjs9JpQv6wN3h11+G5hqBcNM/LLWN
         kL1beiTmW3cS7Fydh4+JQTM6YEYmhGXH5DvL8BZugsu604aShJQjQbB9aeFeRNaSPb
         5zv8b0pAXQiagXtKsl353tcPqUb7zO2Z57pLVdG5q6eRmUHgxRy1ZzwHpokaXcgy9H
         zdgGmMK98H4cA==
Received: by mail-oi1-f172.google.com with SMTP id y66so14908876oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 05:40:07 -0700 (PDT)
X-Gm-Message-State: AOAM533BVzqrPk5oM7vty8lEz6xvO9snHk7rBJftsdVT4SwzvllkhpNV
        4poX4kfZ3KbRBIzEUjNVffTCz0y3wZmWvjGYwmM=
X-Google-Smtp-Source: ABdhPJznCVFG5AVEcej6pWCLuP8cHM9+9oqtLT/DitSVAeRRS1AIHXu2wfgZgjTZstv04lK9BZUf9hoBKzTnupH4WmE=
X-Received: by 2002:aca:4c49:: with SMTP id z70mr20356509oia.174.1626784806378;
 Tue, 20 Jul 2021 05:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210720123512.8740-1-will@kernel.org>
In-Reply-To: <20210720123512.8740-1-will@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 20 Jul 2021 14:39:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXECb+yvrCegNUu35=K0Drbr6hDoM1_or9b13QPPiCW4fw@mail.gmail.com>
Message-ID: <CAMj1kXECb+yvrCegNUu35=K0Drbr6hDoM1_or9b13QPPiCW4fw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix arm64 boot regression in 5.14
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2021 at 14:35, Will Deacon <will@kernel.org> wrote:
>
> Hi folks,
>
> Jonathan reports [1] that commit c742199a014d ("mm/pgtable: add stubs
> for {pmd/pub}_{set/clear}_huge") breaks the boot on arm64 when huge
> mappings are used to map the kernel linear map but the VA size is
> configured such that PUDs are folded. This is because the non-functional
> pud_set_huge() stub is used to create the linear map, which results in
> 1GB holes and a fatal data abort when the kernel attemps to access them.
>
> Digging further into the issue, it also transpired that huge-vmap is
> silently disabled in these configurations as well [2], despite working
> correctly in 5.13. The latter issue causes the pgtable selftests to
> scream due to a failing consistency check [3].
>
> Rather than leave mainline in a terminally broken state for arm64 while
> we figure this out, revert the offending commit to get things working
> again. Unfortunately, reverting the change in isolation causes a build
> breakage for 32-bit PowerPC 8xx machines which recently started relying
> on the problematic stubs to support pte-level huge-vmap entries [4].
> Since Christophe is away at the moment, this series first reverts the
> PowerPC 8xx change in order to avoid breaking the build.
>
> I would really like this to land for -rc3 and I can take these via the
> arm64 fixes queue if the PowerPC folks are alright with them.
>
> Cheers,
>
> Will
>
> [1] https://lore.kernel.org/r/20210717160118.9855-1-jonathan@marek.ca
> [2] https://lore.kernel.org/r/20210719104918.GA6440@willie-the-truck
> [3] https://lore.kernel.org/r/CAMuHMdXShORDox-xxaeUfDW3wx2PeggFSqhVSHVZNKCGK-y_vQ@mail.gmail.com/
> [4] https://lore.kernel.org/r/8b972f1c03fb6bd59953035f0a3e4d26659de4f8.1620795204.git.christophe.leroy@csgroup.eu/
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Jonathan Marek <jonathan@marek.ca>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nicholas Piggin <npiggin@gmail.com
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
>
> --->8
>
> Jonathan Marek (1):
>   Revert "mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge"
>
> Will Deacon (1):
>   Revert "powerpc/8xx: add support for huge pages on VMAP and VMALLOC"
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


>  arch/arm64/mm/mmu.c                          | 20 ++++-----
>  arch/powerpc/Kconfig                         |  2 +-
>  arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 43 --------------------
>  arch/x86/mm/pgtable.c                        | 34 +++++++---------
>  include/linux/pgtable.h                      | 26 +-----------
>  5 files changed, 25 insertions(+), 100 deletions(-)
>
> --
> 2.32.0.402.g57bb445576-goog
>
