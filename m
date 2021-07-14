Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82F83C91CB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbhGNUHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:07:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:32872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235870AbhGNUGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:06:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 439F9613C0;
        Wed, 14 Jul 2021 20:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626292992;
        bh=nJrytn0I+MJykV0m0Dz87seolw0QnFNLAadswtmO1ME=;
        h=Date:From:To:Cc:Subject:From;
        b=tOVolJ7oZ2YxyG535LgmwrKZvMcKQIN66corYHlWeD5HcqHrdcx0jQcxQAjtB5vic
         zPfqq/lGnBrkadKNxWJTJ0liCoDwfNK8Q3KijvHu2DKRx9OKa2SyAOUEsGSl6yOArW
         GStMvK0llNimmXr4HdutL8CAMAlXYEURJyQ85A4Vd7RzR2pSnrS40as4JP54NjKTJq
         lS5ZexjWBk/XEIGUGxNPdnw9TytbNFqTrxnpnfDZtCYpzxPUJJhwc9QOYVxJ5sDsbB
         xo1o7AcNm4IijxJGyOh/zrck7fnWJIVYwTGxxJQj6yGunzvKcV4P3PWvCJM8+Xrugd
         RTNvpijHoRqFQ==
Date:   Wed, 14 Jul 2021 15:05:23 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] fallthrough fixes for Clang for 5.14-rc2
Message-ID: <20210714200523.GA10606@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-clang-5.14-rc2

for you to fetch changes up to b7eb335e26a9c7f258c96b3962c283c379d3ede0:

  Makefile: Enable -Wimplicit-fallthrough for Clang (2021-07-14 11:12:21 -0500)

----------------------------------------------------------------
fallthrough fixes for Clang for 5.14-rc2

Hi Linus,

Please, pull the following patches that fix many fall-through
warnings when building with Clang and -Wimplicit-fallthrough.

This pull-request also contains the patch for Makefile that enables
-Wimplicit-fallthrough for Clang, globally.

It's also important to notice that since we have adopted the use of
the pseudo-keyword macro fallthrough; we also want to avoid having
more /* fall through */ comments being introduced. Notice that contrary
to GCC, Clang doesn't recognize any comments as implicit fall-through
markings when the -Wimplicit-fallthrough option is enabled. So, in
order to avoid having more comments being introduced, we have to use
the option -Wimplicit-fallthrough=5 for GCC, which similar to Clang,
will cause a warning in case a code comment is intended to be used
as a fall-through marking. The patch for Makefile also enforces this.

We had almost 4,000 of these issues for Clang in the beginning,
and there might be a couple more out there when building some
architectures with certain configurations. However, with the
recent fixes I think we are in good shape and it is now possible
to enable -Wimplicit-fallthrough for Clang. :)

Thanks!

----------------------------------------------------------------
Gustavo A. R. Silva (27):
      xfs: Fix multiple fall-through warnings for Clang
      mt76: mt7921: Fix fall-through warning for Clang
      nfp: flower-ct: Fix fall-through warning for Clang
      drm/i915: Fix fall-through warning for Clang
      kernel: debug: Fix unreachable code in gdb_serial_stub()
      fcntl: Fix unreachable code in do_fcntl()
      mtd: cfi_util: Fix unreachable code issue
      drm/msm: Fix fall-through warning in msm_gem_new_impl()
      cpufreq: Fix fall-through warning for Clang
      math-emu: Fix fall-through warning
      video: fbdev: Fix fall-through warning for Clang
      scsi: libsas: Fix fall-through warning for Clang
      PCI: Fix fall-through warning for Clang
      mmc: jz4740: Fix fall-through warning for Clang
      iommu/arm-smmu-v3: Fix fall-through warning for Clang
      dmaengine: ipu: Fix fall-through warning for Clang
      s390: Fix fall-through warnings for Clang
      dmaengine: ti: k3-udma: Fix fall-through warning for Clang
      power: supply: Fix fall-through warnings for Clang
      ASoC: Mediatek: MT8183: Fix fall-through warning for Clang
      MIPS: Fix fall-through warnings for Clang
      MIPS: Fix unreachable code issue
      powerpc/powernv: Fix fall-through warning for Clang
      usb: gadget: fsl_qe_udc: Fix fall-through warning for Clang
      dmaengine: mpc512x: Fix fall-through warning for Clang
      powerpc/smp: Fix fall-through warning for Clang
      Makefile: Enable -Wimplicit-fallthrough for Clang

 Makefile                                              |  9 +++------
 arch/mips/include/asm/fpu.h                           |  2 +-
 arch/mips/mm/tlbex.c                                  |  2 ++
 arch/powerpc/platforms/powermac/smp.c                 |  1 +
 arch/s390/kernel/uprobes.c                            |  1 +
 drivers/char/powernv-op-panel.c                       |  1 +
 drivers/cpufreq/longhaul.c                            |  2 --
 drivers/dma/ipu/ipu_idmac.c                           |  2 ++
 drivers/dma/mpc512x_dma.c                             |  1 +
 drivers/dma/ti/k3-udma.c                              |  1 +
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c          |  1 +
 drivers/gpu/drm/msm/msm_gem.c                         |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c           |  1 +
 drivers/mmc/host/jz4740_mmc.c                         |  2 ++
 drivers/mtd/chips/cfi_util.c                          |  4 ++--
 drivers/net/ethernet/netronome/nfp/flower/conntrack.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c      |  1 +
 drivers/pci/proc.c                                    |  2 +-
 drivers/power/supply/ab8500_fg.c                      |  2 ++
 drivers/power/supply/abx500_chargalg.c                |  1 +
 drivers/s390/char/tape_char.c                         |  2 --
 drivers/s390/net/ctcm_fsms.c                          |  1 +
 drivers/s390/net/qeth_l3_main.c                       |  1 +
 drivers/scsi/libsas/sas_discover.c                    |  2 +-
 drivers/usb/gadget/udc/fsl_qe_udc.c                   |  1 +
 drivers/video/fbdev/xilinxfb.c                        |  2 ++
 fs/fcntl.c                                            |  2 +-
 fs/xfs/libxfs/xfs_attr.c                              | 16 ++++++++--------
 include/math-emu/op-common.h                          |  2 +-
 kernel/debug/gdbstub.c                                |  2 +-
 sound/soc/mediatek/mt8183/mt8183-dai-adda.c           |  1 +
 31 files changed, 44 insertions(+), 27 deletions(-)
