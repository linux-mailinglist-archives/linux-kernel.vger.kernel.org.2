Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A509F400DB2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 02:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhIEARE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 20:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhIEARC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 20:17:02 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5405FC061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 17:15:59 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id f22so3153150qkm.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 17:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=B7vrOzHTc7yswPYkjLCgs5QJeJupsuPGF2q30Ah91fE=;
        b=lCrgJMk9nJK5b0g/FhOQkaToamxgpx9zp57NXTax9NDBYn0IEJgIdkeYg5mboezK2p
         p7dW5jwB0tw6/eJDDxiyLoz7a5KR3jJwfE1wfiHFOr9l0WF1O54XqO3d5Xn8KiK6G4Af
         9QZ7etsIu3IG/FqoWwSQA90PnlQWIhqmKxF4hR8dLgZ6aX7pW4Yy/VlcUfcNp6GpTB8s
         wbckXO1g3OQiAGt/wtPB28D6Zc21rybFVT4mDgXT8zOyukzp9XsPOcE5X2Mm5GyIiULg
         SY6z5sRUTrp082kE8sOy5zL4s5nnDuBNhYD1ubx2kdhvLasYanhOgsl/vR3IA4bYey8y
         kNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=B7vrOzHTc7yswPYkjLCgs5QJeJupsuPGF2q30Ah91fE=;
        b=LoMYVSmj/U6qacRXb5QKlXQpsR+ZKWCTBSzdZcmkt643UMID5St+1vPvZaPmyxNEav
         EfUkkyQW5gH3USf6eNyQ5r9XAMI009yXkZhHxNM4D20KEgZOGNuEq689dG36gRbTryck
         aQ/k12QeEMopiXsfTWJ0pS7WfGTze/SoEhtYGs3F0nEVf/jDc+1i5FOQ7j7SVAoF/Vux
         Egy0mXOaA+SgQlflfEEOXnU/OaVyewv5UocLTiPty3c9QQgkSoBMz7gjqTndRKgO99ci
         5lpAauDR6BDbRU2mwYahKr/Ko3IuIvBj2CYW2mdyxxHVzwhbiv2Jh+4Mt6UOpHZb8FAM
         5OpA==
X-Gm-Message-State: AOAM531fo8lk4jSlxSTPn18y5YKzpYtp/Mm/0ihgjUBQScoKMk9hIYPq
        nXVHPohCmZCv0hud0rjsS1zAtdGil3XgYAPB
X-Google-Smtp-Source: ABdhPJxjhANGjcxkOv3IRKoqKO2Q3WJjSJ1xyrp8NOmE+CMw66PXIQrSy/cLrtNCpVjp6/ba3eortQ==
X-Received: by 2002:a37:6849:: with SMTP id d70mr5145477qkc.267.1630800958389;
        Sat, 04 Sep 2021 17:15:58 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j18sm2850462qkl.12.2021.09.04.17.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 17:15:57 -0700 (PDT)
Date:   Sat, 04 Sep 2021 17:15:57 -0700 (PDT)
X-Google-Original-Date: Sat, 04 Sep 2021 17:15:51 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 5.15 Merge Window, Part 1
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-e13c978a-0771-4577-9adc-3a4b807fbfc2@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.15-mw0

for you to fetch changes up to c24a19674258dcc968a198d8e0d4717c8f27700c:

  riscv: add support for hugepage migration (2021-08-26 22:01:22 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.15 Merge Window, Part 1

* Support for PC-relative instructions (auipc and branches) in kprobes.
* Support for forced IRQ threading.
* Support for the hlt/nohlt kernel command line options, via the generic
  idle loop.
* Support for showing the edge/level triggered behavior of interrupts in
  /proc/interrupts.
* A handful of cleanups to our address mapping mechanisms.
* Support for allocating gigantic hugepages via CMA.
* Support for the undefined behavior sanitizer.
* A handful of cleanups to the VDSO that allow the kernel to build with
  LLD.
* Support for hugepage migration.

----------------------------------------------------------------
There are a handful of patches that I'm still hoping to pick up for this merge
window, but I thoughti t would be best to get these out now rather than
waiting.

----------------------------------------------------------------
Alexandre Ghiti (6):
      riscv: Optimize kernel virtual address conversion macro
      riscv: Introduce va_kernel_pa_offset for 32-bit kernel
      riscv: Get rid of map_size parameter to create_kernel_page_table
      riscv: Use __maybe_unused instead of #ifdefs around variable declarations
      riscv: Simplify BUILTIN_DTB device tree mapping handling
      riscv: Move early fdt mapping creation in its own function

Chen Lifu (2):
      riscv: kprobes: implement the auipc instruction
      riscv: kprobes: implement the branch instructions

Chen Wandun (1):
      riscv: add support for hugepage migration

Drew Fustini (1):
      dt-bindings: riscv: add starfive jh7100 bindings

Jason Wang (1):
      riscv: use strscpy to replace strlcpy

Jisheng Zhang (2):
      riscv: Keep the riscv Kconfig selects sorted
      riscv: Enable Undefined Behavior Sanitizer UBSAN

Kefeng Wang (4):
      riscv: Allow forced irq threading
      riscv: Enable idle generic idle loop
      riscv: Enable GENERIC_IRQ_SHOW_LEVEL
      riscv: Support allocating gigantic hugepages using CMA

Kenneth Lee (1):
      riscv: fix the global name pfn_base confliction error

Palmer Dabbelt (1):
      RISC-V: Fix VDSO build for !MMU

Saleem Abdulrasool (1):
      riscv: explicitly use symbol offsets for VDSO

Tong Tiangen (1):
      riscv: Implement thread_struct whitelist for hardened usercopy

 .../devicetree/bindings/riscv/starfive.yaml        |  27 +++++
 arch/riscv/Kconfig                                 |  12 +-
 arch/riscv/Makefile                                |   6 +
 arch/riscv/include/asm/page.h                      |  21 +---
 arch/riscv/include/asm/processor.h                 |   8 ++
 arch/riscv/include/asm/vdso.h                      |  23 ++--
 arch/riscv/kernel/probes/decode-insn.c             |   5 +-
 arch/riscv/kernel/probes/simulate-insn.c           | 112 ++++++++++++++++++
 arch/riscv/kernel/setup.c                          |   2 +-
 arch/riscv/kernel/vdso/Makefile                    |  26 ++---
 arch/riscv/kernel/vdso/gen_vdso_offsets.sh         |   5 +
 arch/riscv/kernel/vdso/so2s.sh                     |   6 -
 arch/riscv/mm/init.c                               | 130 +++++++++------------
 13 files changed, 256 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/starfive.yaml
 create mode 100755 arch/riscv/kernel/vdso/gen_vdso_offsets.sh
 delete mode 100755 arch/riscv/kernel/vdso/so2s.sh
