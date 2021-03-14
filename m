Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC7E33A411
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 11:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbhCNKCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 06:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhCNKBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 06:01:22 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8A2C061762
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 03:01:21 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Dyw734P9Lz9sWK; Sun, 14 Mar 2021 21:01:19 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <cf61345912c078c96f171afd0fcc48ef27cbdc3f.1614443418.git.christophe.leroy@csgroup.eu>
References: <cf61345912c078c96f171afd0fcc48ef27cbdc3f.1614443418.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Force inlining of mmu_has_feature to fix build failure
Message-Id: <161571587146.138988.4861060770867592113.b4-ty@ellerman.id.au>
Date:   Sun, 14 Mar 2021 21:01:19 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Feb 2021 16:30:48 +0000 (UTC), Christophe Leroy wrote:
> The test robot has managed to generate a random config leading
> to following build failure:
> 
>   LD      .tmp_vmlinux.kallsyms1
> powerpc64-linux-ld: arch/powerpc/mm/pgtable.o: in function `ptep_set_access_flags':
> pgtable.c:(.text.ptep_set_access_flags+0xf0): undefined reference to `hash__flush_tlb_page'
> powerpc64-linux-ld: arch/powerpc/mm/book3s32/mmu.o: in function `MMU_init_hw_patch':
> mmu.c:(.init.text+0x452): undefined reference to `patch__hash_page_A0'
> powerpc64-linux-ld: mmu.c:(.init.text+0x45e): undefined reference to `patch__hash_page_A0'
> powerpc64-linux-ld: mmu.c:(.init.text+0x46a): undefined reference to `patch__hash_page_A1'
> powerpc64-linux-ld: mmu.c:(.init.text+0x476): undefined reference to `patch__hash_page_A1'
> powerpc64-linux-ld: mmu.c:(.init.text+0x482): undefined reference to `patch__hash_page_A2'
> powerpc64-linux-ld: mmu.c:(.init.text+0x48e): undefined reference to `patch__hash_page_A2'
> powerpc64-linux-ld: mmu.c:(.init.text+0x49e): undefined reference to `patch__hash_page_B'
> powerpc64-linux-ld: mmu.c:(.init.text+0x4aa): undefined reference to `patch__hash_page_B'
> powerpc64-linux-ld: mmu.c:(.init.text+0x4b6): undefined reference to `patch__hash_page_C'
> powerpc64-linux-ld: mmu.c:(.init.text+0x4c2): undefined reference to `patch__hash_page_C'
> powerpc64-linux-ld: mmu.c:(.init.text+0x4ce): undefined reference to `patch__flush_hash_A0'
> powerpc64-linux-ld: mmu.c:(.init.text+0x4da): undefined reference to `patch__flush_hash_A0'
> powerpc64-linux-ld: mmu.c:(.init.text+0x4e6): undefined reference to `patch__flush_hash_A1'
> powerpc64-linux-ld: mmu.c:(.init.text+0x4f2): undefined reference to `patch__flush_hash_A1'
> powerpc64-linux-ld: mmu.c:(.init.text+0x4fe): undefined reference to `patch__flush_hash_A2'
> powerpc64-linux-ld: mmu.c:(.init.text+0x50a): undefined reference to `patch__flush_hash_A2'
> powerpc64-linux-ld: mmu.c:(.init.text+0x522): undefined reference to `patch__flush_hash_B'
> powerpc64-linux-ld: mmu.c:(.init.text+0x532): undefined reference to `patch__flush_hash_B'
> powerpc64-linux-ld: arch/powerpc/mm/book3s32/mmu.o: in function `update_mmu_cache':
> mmu.c:(.text.update_mmu_cache+0xa0): undefined reference to `add_hash_page'
> powerpc64-linux-ld: mm/memory.o: in function `zap_pte_range':
> memory.c:(.text.zap_pte_range+0x160): undefined reference to `flush_hash_pages'
> powerpc64-linux-ld: mm/memory.o: in function `handle_pte_fault':
> memory.c:(.text.handle_pte_fault+0x180): undefined reference to `hash__flush_tlb_page'
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: Force inlining of mmu_has_feature to fix build failure
      https://git.kernel.org/powerpc/c/acdad8fb4a1574323db88f98a38b630691574e16

cheers
