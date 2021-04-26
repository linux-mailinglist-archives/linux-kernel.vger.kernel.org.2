Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B8836B1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhDZKyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:54:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232266AbhDZKyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:54:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4891AAD69;
        Mon, 26 Apr 2021 10:53:38 +0000 (UTC)
Date:   Mon, 26 Apr 2021 12:53:41 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/build for v5.13
Message-ID: <YIabtQdmN3LmPWzM@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the usual garden variety of build fixes this time around.

Thx.

---

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.13

for you to fetch changes up to 0ef3439cd80ba7770723edb0470d15815914bb62:

  x86/build: Disable HIGHMEM64G selection for M486SX (2021-04-19 14:02:12 +0200)

----------------------------------------------------------------
A bunch of clang build fixes and a Kconfig highmem selection fix for
486SX.

----------------------------------------------------------------
John Millikin (1):
      x86/build: Propagate $(CLANG_FLAGS) to $(REALMODE_FLAGS)

Maciej W. Rozycki (1):
      x86/build: Disable HIGHMEM64G selection for M486SX

Nathan Chancellor (2):
      x86/boot: Add $(CLANG_FLAGS) to compressed KBUILD_CFLAGS
      efi/libstub: Add $(CLANG_FLAGS) to x86 flags

 arch/x86/Kconfig                      | 2 +-
 arch/x86/Makefile                     | 1 +
 arch/x86/boot/compressed/Makefile     | 1 +
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 4 files changed, 5 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
