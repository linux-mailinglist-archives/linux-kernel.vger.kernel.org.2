Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D903D019A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 20:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhGTRmS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jul 2021 13:42:18 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35866 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232589AbhGTRkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 13:40:42 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GTn8p11xBzB61P;
        Tue, 20 Jul 2021 20:21:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id azco6Acv840f; Tue, 20 Jul 2021 20:21:14 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GTn8n6vwfzB61K;
        Tue, 20 Jul 2021 20:21:13 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 182D3702; Tue, 20 Jul 2021 20:26:27 +0200 (CEST)
Received: from 37-165-28-27.coucou-networks.fr
 (37-165-28-27.coucou-networks.fr [37.165.28.27]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Tue, 20 Jul 2021 20:26:27 +0200
Date:   Tue, 20 Jul 2021 20:26:27 +0200
Message-ID: <20210720202627.Horde.vlszNhxkKrLIg0-3Sn2ucw5@messagerie.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix arm64 boot regression in 5.14
In-Reply-To: <20210720123512.8740-1-will@kernel.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon <will@kernel.org> a écrit :

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

If you can drop patch 1,

Change patch 2 to add the two following functions in  
arch/powerpc/mm/nohash/8xx.c :

int pud_clear_huge(pud_t *pud)
{
         return 0;
}

int pmd_clear_huge(pmd_t *pmd)
{
         return 0;
}

Then feel free to take it via ARM fixes with my acked-by as maintainer  
of PPC8XX.

Christophe


> Cheers,
>
> Will
>
> [1] https://lore.kernel.org/r/20210717160118.9855-1-jonathan@marek.ca
> [2] https://lore.kernel.org/r/20210719104918.GA6440@willie-the-truck
> [3]  
> https://lore.kernel.org/r/CAMuHMdXShORDox-xxaeUfDW3wx2PeggFSqhVSHVZNKCGK-y_vQ@mail.gmail.com/
> [4]  
> https://lore.kernel.org/r/8b972f1c03fb6bd59953035f0a3e4d26659de4f8.1620795204.git.christophe.leroy@csgroup.eu/
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
>  arch/arm64/mm/mmu.c                          | 20 ++++-----
>  arch/powerpc/Kconfig                         |  2 +-
>  arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 43 --------------------
>  arch/x86/mm/pgtable.c                        | 34 +++++++---------
>  include/linux/pgtable.h                      | 26 +-----------
>  5 files changed, 25 insertions(+), 100 deletions(-)
>
> --
> 2.32.0.402.g57bb445576-goog


