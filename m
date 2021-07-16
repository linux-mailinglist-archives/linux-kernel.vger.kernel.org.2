Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7C93CB922
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 16:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240691AbhGPO4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 10:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240636AbhGPO4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:56:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5B27613F5;
        Fri, 16 Jul 2021 14:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626447206;
        bh=fAr0rmGViYqlwVkfpLAmvCG23vFxE1LwgWrueNzxFNs=;
        h=Date:From:To:Cc:Subject:From;
        b=oybHhD2owJBr+DDJQLwAwtMaXo8xUHDu7BRMlVo2RwggCG9+DVo9OTD3GzU0iqYfq
         GH20Yi0G2Acbkj3YJkneWWdTTdbJ3n5Or/xtpnbqd1aHj+HtIvoW9grZVV9TT0Orvv
         MCYSCYoTmq7plz1xraJqSAcSUi6VsbkN7IiDspFKkynHAaj7lIYQJ1lucXjaocNT/1
         0hQxs8GpkQW9QsO7ee+Nrx3niVYwjeHaUloS8N9ls7tBqrfuF7r+FaorWP7JHeqXGv
         Gyuc10aSeWrLMY+Y4WbtbDLHyWbM4HQEX4htI7vHCenO75JsBP4MaKBrz+RwQOCOxM
         m5ZTJJ4mtKz8w==
Date:   Fri, 16 Jul 2021 15:53:21 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc2
Message-ID: <20210716145320.GB3161@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc2. The bulk of the diffstat consists
of changes to our uaccess routines so that they fall back to bytewise
copying prior to reporting complete failure when the initial (multi-byte)
access faults. However, the most disappointing change here is that we've
had to bump ARCH_DMA_MINALIGN back to 128 bytes thanks to Qualcomm's "Kryo"
CPU, which ended up in the MSM8996 mobile SoC. Still, at least we're now
aware of this design and one of the hardware designers confirmed the
L2 cacheline size for us.

Cheers,

Will

--->8

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to e6f85cbeb23bd74b8966cf1f15bf7d01399ff625:

  arm64: entry: fix KCOV suppression (2021-07-15 17:37:55 +0100)

----------------------------------------------------------------
arm64 fixes for -rc2

- Fix instrumentation annotations for entry code

- Ensure kernel MTE state is restored correctly on resume from suspend

- Fix MTE fault from new strlen() routine

- Fallback to byte-wise accesses on initial uaccess fault

- Bump Clang requirement for BTI

- Revert ARCH_DMA_MINALIGN back to 128 bytes (shakes fist at Qualcomm)

----------------------------------------------------------------
Carlos Bilbao (1):
      arm64: Add missing header <asm/smp.h> in two files

Mark Rutland (4):
      arm64: fix strlen() with CONFIG_KASAN_HW_TAGS
      arm64: mte: fix restoration of GCR_EL1 from suspend
      arm64: entry: add missing noinstr
      arm64: entry: fix KCOV suppression

Nathan Chancellor (1):
      arm64: Restrict ARM64_BTI_KERNEL to clang 12.0.0 and newer

Robin Murphy (1):
      arm64: Avoid premature usercopy failure

Will Deacon (1):
      Revert "arm64: cache: Lower ARCH_DMA_MINALIGN to 64 (L1_CACHE_BYTES)"

 arch/arm64/Kconfig                |  3 ++-
 arch/arm64/include/asm/cache.h    |  2 +-
 arch/arm64/include/asm/smp_plat.h |  1 +
 arch/arm64/kernel/Makefile        |  2 +-
 arch/arm64/kernel/cpufeature.c    |  1 +
 arch/arm64/kernel/entry-common.c  |  2 +-
 arch/arm64/kernel/mte.c           | 15 ++-------------
 arch/arm64/lib/copy_from_user.S   | 13 ++++++++++---
 arch/arm64/lib/copy_in_user.S     | 21 ++++++++++++++-------
 arch/arm64/lib/copy_to_user.S     | 14 +++++++++++---
 arch/arm64/lib/strlen.S           | 10 ++++++++++
 11 files changed, 54 insertions(+), 30 deletions(-)
