Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A2A3F889F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbhHZNSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232909AbhHZNSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:18:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40A8260FDC;
        Thu, 26 Aug 2021 13:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629983872;
        bh=+0WhsOGBAXJiCcnRXoWh8bBxwlXxEbX15/FAjmhMtj0=;
        h=Date:From:To:Cc:Subject:From;
        b=iNynZXTJ+HKm6H3Fk8u67CRapIyxXvrcKOleq9BQIuHtdfhuJiIWGjbayfy7/Lfor
         M+E2iqd1yIHxGQ0zen14D1fQ0wmvyEccsornwQU2Czm5Jnc7TF0ExpirjfefPPbVt6
         l1cCWALw8Wf1cgTgtgEYrGD89DhftKc2NDl42vWhPBF/uC2aaAOvVUHw0GKCow28n5
         a8A7FEH9UytHWrEfLw2BzXItMyJeAAjs4Y7Jk0EkBPxSo2erMtt9mDiIgYnlQ1nooY
         FMYrO1qN7x6NfbvWH8RSoPqZ0uvy/fjkeb9B9i8X8KowDLYzPKcSt3CUZup7s0Lrq0
         7OikZ2J2Q8gcA==
Date:   Thu, 26 Aug 2021 14:17:48 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fix for 5.14
Message-ID: <20210826131747.GE26318@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this single arm64 fix for 5.14. We received a report this week
that the generic version of pfn_valid(), which we switched to this merge
window in 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID"), interacts
badly with dma_map_resource() due to the following check:

        /* Don't allow RAM to be mapped */
        if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
                return DMA_MAPPING_ERROR;

Since the ongoing saga to determine the semantics of pfn_valid() is
unlikely to be resolved this week (does it indicate valid memory, or
just the presence of a struct page, or whether that struct page has been
initialised?), just revert back to our old version of pfn_valid() for
5.14.

Thanks,

Will

--->8

The following changes since commit bde8fff82e4a4b0f000dbf4d5eadab2079be0b56:

  arm64: initialize all of CNTHCTL_EL2 (2021-08-19 10:02:10 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 3eb9cdffb39701743973382860f214026f4d7825:

  Partially revert "arm64/mm: drop HAVE_ARCH_PFN_VALID" (2021-08-25 11:33:24 +0100)

----------------------------------------------------------------
arm64 fix for 5.14

- Fix dma_map_resource() by reverting back to old pfn_valid() code

----------------------------------------------------------------
Will Deacon (1):
      Partially revert "arm64/mm: drop HAVE_ARCH_PFN_VALID"

 arch/arm64/Kconfig            |  1 +
 arch/arm64/include/asm/page.h |  1 +
 arch/arm64/mm/init.c          | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)
