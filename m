Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6503D2712
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhGVPOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 11:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhGVPOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 11:14:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE53C6101E;
        Thu, 22 Jul 2021 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626969315;
        bh=QUR6QNDvRdcJPSeR2Cm6YLmShamr5QXRO3rk1PHR2lo=;
        h=Date:From:To:Cc:Subject:From;
        b=OPZoGJlqlCo/IaBWy7NOJgQSGbH4YbgtRX+TXJr8ZM4ETtJnDvbfl3/44FbPWnH6N
         H6LBxwYlV2gvJD8oaIe8RCxUoFuSKA8mVpTQm/eP9nq3GLTStbCJyKOOjc1/1p5T2+
         jR26SgHGAYZNdOuBnWgCz3ZRozP7D+Ep7CMl0OA5///BOD3c0hRnzv7XsbMPOWxbHB
         xardrtdITXxRblI0R8Ya1rQvPXDGlmz9ZpZ3ndFnZjweClC5Wh8rI9XYWgHaYQqoyX
         IpF01gjoWWSl+97FTKjybw1JpTnREt0fD/0totAcsPMtwX/ZBnxgmbneEMjHW0f4A0
         vAuoD8Lm+KyrQ==
Date:   Thu, 22 Jul 2021 16:55:10 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, mpe@ellerman.id.au
Subject: [GIT PULL] arm64 fixes for -rc3
Message-ID: <20210722155509.GA12627@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this pair of arm64 fixes for -rc3. The straightforward one
is a fix to our firmware calling stub, which accidentally started
corrupting the link register on machines with SVE. Since these machines
don't really exist yet, it wasn't spotted in -next.

The other fix is a revert-and-a-bit of a patch originally intended to
allow PTE-level huge mappings for the VMAP area on 32-bit PPC 8xx. A
side-effect of this change was that our pXd_set_huge() implementations
could be replaced with generic dummy functions depending on the levels
of page-table being used, which in turn broke the boot if we fail to
create the linear mapping as a result of using these functions to
operate on the pgd. Huge thanks to Michael Ellerman for modifying the
revert so as not to regress PPC 8xx in terms of functionality.

Anyway, that's the background and it's also available in the commit
message along with Link tags pointing at all of the fun. Please pull.

Cheers,

Will

--->8

The following changes since commit e6f85cbeb23bd74b8966cf1f15bf7d01399ff625:

  arm64: entry: fix KCOV suppression (2021-07-15 17:37:55 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to d8a719059b9dc963aa190598778ac804ff3e6a87:

  Revert "mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge" (2021-07-21 11:28:09 +0100)

----------------------------------------------------------------
arm64 fixes for -rc3

- Fix hang when issuing SMC on SVE-capable system due to clobbered LR

- Fix boot failure due to missing block mappings with folded page-table

----------------------------------------------------------------
Jean-Philippe Brucker (1):
      arm64: smccc: Save lr before calling __arm_smccc_sve_check()

Jonathan Marek (1):
      Revert "mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge"

 arch/arm64/kernel/smccc-call.S |  9 ++++++---
 arch/arm64/mm/mmu.c            | 20 ++++++++------------
 arch/powerpc/mm/nohash/8xx.c   | 10 ++++++++++
 arch/x86/mm/pgtable.c          | 34 +++++++++++++++-------------------
 include/linux/pgtable.h        | 26 +-------------------------
 5 files changed, 40 insertions(+), 59 deletions(-)
