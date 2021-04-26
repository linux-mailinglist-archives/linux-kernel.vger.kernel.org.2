Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC70336B9D3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 21:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbhDZTNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 15:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbhDZTNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:13:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212ABC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:12:24 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c17so5020148pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=UE7/6rvj/EBG7Nm4tLxNZNhCPyU11I9MLIjhXZdxvH0=;
        b=JqZGC23Y6+AZ6+SC54IM6IUgPLLv98vf7S3j7tuwRlGAK6hBmNjg1L1nXKbOhvordJ
         cpTaNVmM+WuAkM7TzU21LO5JF351vY9haHRN14NXGLcc1sblqXceDgbK/upig/Sn77lU
         acVluD18xwteFZV/UXxjxSbdKFL94XVdcxvBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UE7/6rvj/EBG7Nm4tLxNZNhCPyU11I9MLIjhXZdxvH0=;
        b=gcor7ANd6+dJ26i3CucieveCUPkKwHcCjusT7nE72vHVQ5pIxyPsgYYQZwG6fwSAMm
         1nat1UU7UJWkgy+HxFEZYBQrvJpc336k0otZO8aXBbtPR0g33EoBhCttstJXxKsBuvuP
         GvaulQNe1CHkwPaTDFk50TaT8DbQHq/10U/tKXVEQBaSlD5c59yAM6mNshJajrcs+LFY
         EDvttEiU3pfxw/TDwF151jj62hVQlyfFkVKQW1OxbdpGS7yiCDcZQ6AT0c1wzMCYFe5w
         n0yaS+xXYgli+TSu5EQYZpqOXNaTJ+ojvgmiFYuRZMSgEPovmA9VvmMTZFcJjPe3NLWy
         w5dQ==
X-Gm-Message-State: AOAM531qG2d9f//CoRnl+QeMMMtxPMQrgx30nqxHheGDrUYEi5zeB6FW
        VlNFFkKuLANs55UZwCgTM5S9xQ==
X-Google-Smtp-Source: ABdhPJx0w3ZBNw3x5KRP275ueAHxasKIUnJSVdeftyuMKm337UV4hc30lProwN52TGyrVtrc78M9Jg==
X-Received: by 2002:a63:d942:: with SMTP id e2mr18249854pgj.117.1619464343573;
        Mon, 26 Apr 2021 12:12:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g14sm413085pfm.143.2021.04.26.12.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 12:12:23 -0700 (PDT)
Date:   Mon, 26 Apr 2021 12:12:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dai <ben.dai@unisoc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Jack Pham <jackp@codeaurora.org>, Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [GIT PULL] CFI on arm64 series for v5.13-rc1
Message-ID: <202104261141.5B699FE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this CFI-on-arm64 series for v5.13-rc1. This builds on last
cycle's LTO work, and allows the arm64 kernels to be built with Clang's
Control Flow Integrity feature. This feature has happily lived in Android
kernels for almost 3 years[1], so I'm excited to have it ready for upstream.

While in -next, it gained one small conflict when the prototype for
arm64's __apply_alternatives() got tweaked:
https://lore.kernel.org/linux-next/20210426103433.01f527e0@canb.auug.org.au/

The wide diffstat is mainly due to the treewide fixing of mismatched
list_sort prototypes. Other things in core kernel are to address
various CFI corner cases. The largest code portion is the CFI runtime
implementation itself (which will be shared by all architectures
implementing support for CFI). The arm64 pieces are Acked by arm64
maintainers rather than coming through the arm64 tree since carrying
this tree over there was going to be awkward.

CFI support for x86 is still under development, but is pretty close.
There are a handful of corner cases on x86 that need some improvements
to Clang and objtool, but otherwise works well.

Finally, before your grep finds the panic() in this series, I'd like to
call your attention to CONFIG_CFI_PERMISSIVE which exists to provide
the WARN-only mode for CFI, useful for system builders exploring this
feature before they enable the "kill my machine" mode, which is the mode
used by Android (and by other folks enabling CFI as a meaningful defense).

Thanks!

-Kees

[1] https://android-developers.googleblog.com/2018/10/control-flow-integrity-in-android-kernel.html

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/cfi-v5.13-rc1

for you to fetch changes up to 9186ad8e66bab6a1edc66a939dd56c4638cda948:

  arm64: allow CONFIG_CFI_CLANG to be selected (2021-04-08 16:04:23 -0700)

----------------------------------------------------------------
CFI on arm64 series for v5.13-rc1

- Clean up list_sort prototypes (Sami Tolvanen)

- Introduce CONFIG_CFI_CLANG for arm64 (Sami Tolvanen)

----------------------------------------------------------------
Sami Tolvanen (18):
      add support for Clang CFI
      cfi: add __cficanonical
      mm: add generic function_nocfi macro
      module: ensure __cfi_check alignment
      workqueue: use WARN_ON_FUNCTION_MISMATCH
      kthread: use WARN_ON_FUNCTION_MISMATCH
      kallsyms: strip ThinLTO hashes from static functions
      bpf: disable CFI in dispatcher functions
      treewide: Change list_sort to use const pointers
      lkdtm: use function_nocfi
      psci: use function_nocfi for cpu_resume
      arm64: implement function_nocfi
      arm64: use function_nocfi with __pa_symbol
      arm64: add __nocfi to functions that jump to a physical address
      arm64: add __nocfi to __apply_alternatives
      arm64: ftrace: use function_nocfi for ftrace_call
      KVM: arm64: Disable CFI for nVHE
      arm64: allow CONFIG_CFI_CLANG to be selected

 Makefile                                           |  17 ++
 arch/Kconfig                                       |  45 +++
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/include/asm/memory.h                    |  16 +
 arch/arm64/include/asm/mmu_context.h               |   4 +-
 arch/arm64/kernel/acpi_parking_protocol.c          |   3 +-
 arch/arm64/kernel/alternative.c                    |   4 +-
 arch/arm64/kernel/cpu-reset.h                      |  10 +-
 arch/arm64/kernel/cpufeature.c                     |   4 +-
 arch/arm64/kernel/ftrace.c                         |   2 +-
 arch/arm64/kernel/psci.c                           |   3 +-
 arch/arm64/kernel/smp_spin_table.c                 |   3 +-
 arch/arm64/kvm/hyp/nvhe/Makefile                   |   6 +-
 arch/arm64/kvm/vgic/vgic-its.c                     |   8 +-
 arch/arm64/kvm/vgic/vgic.c                         |   3 +-
 block/blk-mq-sched.c                               |   3 +-
 block/blk-mq.c                                     |   3 +-
 drivers/acpi/nfit/core.c                           |   3 +-
 drivers/acpi/numa/hmat.c                           |   3 +-
 drivers/clk/keystone/sci-clk.c                     |   4 +-
 drivers/firmware/psci/psci.c                       |   7 +-
 drivers/gpu/drm/drm_modes.c                        |   3 +-
 drivers/gpu/drm/i915/gt/intel_engine_user.c        |   3 +-
 drivers/gpu/drm/i915/gvt/debugfs.c                 |   2 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |   3 +-
 drivers/gpu/drm/radeon/radeon_cs.c                 |   4 +-
 .../infiniband/hw/usnic/usnic_uiom_interval_tree.c |   3 +-
 drivers/interconnect/qcom/bcm-voter.c              |   2 +-
 drivers/md/raid5.c                                 |   3 +-
 drivers/misc/lkdtm/usercopy.c                      |   2 +-
 drivers/misc/sram.c                                |   4 +-
 drivers/nvme/host/core.c                           |   3 +-
 drivers/pci/controller/cadence/pcie-cadence-host.c |   3 +-
 drivers/spi/spi-loopback-test.c                    |   3 +-
 fs/btrfs/raid56.c                                  |   3 +-
 fs/btrfs/tree-log.c                                |   3 +-
 fs/btrfs/volumes.c                                 |   3 +-
 fs/ext4/fsmap.c                                    |   4 +-
 fs/gfs2/glock.c                                    |   3 +-
 fs/gfs2/log.c                                      |   2 +-
 fs/gfs2/lops.c                                     |   3 +-
 fs/iomap/buffered-io.c                             |   3 +-
 fs/ubifs/gc.c                                      |   7 +-
 fs/ubifs/replay.c                                  |   4 +-
 fs/xfs/scrub/bitmap.c                              |   4 +-
 fs/xfs/xfs_bmap_item.c                             |   4 +-
 fs/xfs/xfs_buf.c                                   |   6 +-
 fs/xfs/xfs_extent_busy.c                           |   4 +-
 fs/xfs/xfs_extent_busy.h                           |   3 +-
 fs/xfs/xfs_extfree_item.c                          |   4 +-
 fs/xfs/xfs_refcount_item.c                         |   4 +-
 fs/xfs/xfs_rmap_item.c                             |   4 +-
 include/asm-generic/bug.h                          |  16 +
 include/asm-generic/vmlinux.lds.h                  |  20 +-
 include/linux/bpf.h                                |   4 +-
 include/linux/cfi.h                                |  41 +++
 include/linux/compiler-clang.h                     |   3 +
 include/linux/compiler_types.h                     |   8 +
 include/linux/init.h                               |   6 +-
 include/linux/list_sort.h                          |   7 +-
 include/linux/mm.h                                 |  10 +
 include/linux/module.h                             |  13 +-
 include/linux/pci.h                                |   4 +-
 init/Kconfig                                       |   2 +-
 kernel/Makefile                                    |   4 +
 kernel/cfi.c                                       | 329 +++++++++++++++++++++
 kernel/kallsyms.c                                  |  55 +++-
 kernel/kthread.c                                   |   3 +-
 kernel/module.c                                    |  43 +++
 kernel/workqueue.c                                 |   2 +-
 lib/list_sort.c                                    |  17 +-
 lib/test_list_sort.c                               |   3 +-
 net/tipc/name_table.c                              |   4 +-
 scripts/Makefile.modfinal                          |   2 +-
 scripts/module.lds.S                               |  19 +-
 75 files changed, 760 insertions(+), 113 deletions(-)
 create mode 100644 include/linux/cfi.h
 create mode 100644 kernel/cfi.c

-- 
Kees Cook
