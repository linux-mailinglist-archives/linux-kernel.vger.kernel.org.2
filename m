Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E243CF9AE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 14:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbhGTLzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 07:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229659AbhGTLzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:55:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6E0860E0C;
        Tue, 20 Jul 2021 12:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626784539;
        bh=asA6l4h5KrepX/z50UVRSC8Q3OvPiGjAUceJKgcJbl0=;
        h=From:To:Cc:Subject:Date:From;
        b=YvNKATWOtShf7swN0mmf2C6ONDPu8XOlH7q70SOroQM5S/MpCDM0YB8g1cad/xpAt
         DZdsiQnk9tGg0td/isJJ2XQ1/izSNXzsQN45DxDXpz3NNJvEIbKKxsa5dpOtaaE+8a
         CdUdXNFjOfsTHCg3WDra+78eNlhSkoOiYmB+mUHEqgyNu/swwAMbVxkpPUHjFZxtCn
         vLm4cfaJXBXxlkBtTY64lP3t/wN/Yd0rcIjowQ8w8CxqZOrgoc7dZgOU7csRBpJ8Qp
         XwqCbdeJMFNQXPGd6+z/3CyrU8g1IAnFcjFSPbUNOMUwmLmsvloD6mVhIG+b4t3vXa
         Qo/vh5hYZ98XQ==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
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
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] Fix arm64 boot regression in 5.14
Date:   Tue, 20 Jul 2021 13:35:10 +0100
Message-Id: <20210720123512.8740-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Jonathan reports [1] that commit c742199a014d ("mm/pgtable: add stubs
for {pmd/pub}_{set/clear}_huge") breaks the boot on arm64 when huge
mappings are used to map the kernel linear map but the VA size is
configured such that PUDs are folded. This is because the non-functional
pud_set_huge() stub is used to create the linear map, which results in
1GB holes and a fatal data abort when the kernel attemps to access them.

Digging further into the issue, it also transpired that huge-vmap is
silently disabled in these configurations as well [2], despite working
correctly in 5.13. The latter issue causes the pgtable selftests to
scream due to a failing consistency check [3].

Rather than leave mainline in a terminally broken state for arm64 while
we figure this out, revert the offending commit to get things working
again. Unfortunately, reverting the change in isolation causes a build
breakage for 32-bit PowerPC 8xx machines which recently started relying
on the problematic stubs to support pte-level huge-vmap entries [4].
Since Christophe is away at the moment, this series first reverts the
PowerPC 8xx change in order to avoid breaking the build.

I would really like this to land for -rc3 and I can take these via the
arm64 fixes queue if the PowerPC folks are alright with them.

Cheers,

Will

[1] https://lore.kernel.org/r/20210717160118.9855-1-jonathan@marek.ca
[2] https://lore.kernel.org/r/20210719104918.GA6440@willie-the-truck
[3] https://lore.kernel.org/r/CAMuHMdXShORDox-xxaeUfDW3wx2PeggFSqhVSHVZNKCGK-y_vQ@mail.gmail.com/
[4] https://lore.kernel.org/r/8b972f1c03fb6bd59953035f0a3e4d26659de4f8.1620795204.git.christophe.leroy@csgroup.eu/

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Jonathan Marek <jonathan@marek.ca>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org

--->8

Jonathan Marek (1):
  Revert "mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge"

Will Deacon (1):
  Revert "powerpc/8xx: add support for huge pages on VMAP and VMALLOC"

 arch/arm64/mm/mmu.c                          | 20 ++++-----
 arch/powerpc/Kconfig                         |  2 +-
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 43 --------------------
 arch/x86/mm/pgtable.c                        | 34 +++++++---------
 include/linux/pgtable.h                      | 26 +-----------
 5 files changed, 25 insertions(+), 100 deletions(-)

-- 
2.32.0.402.g57bb445576-goog

