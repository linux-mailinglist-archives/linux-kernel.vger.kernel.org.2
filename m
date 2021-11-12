Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE0844EC03
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 18:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhKLRfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 12:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhKLRfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 12:35:08 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41327C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:32:17 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id o14so8972549plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=27qMKBfE9SqMjFa/icnG6O/UTntPosZR3vJbadVwXiU=;
        b=DBQ0ibsXf4NCyq/ULPbu87OnYXRMaFgFxH2//Z2XWW+RPZit6fCT/wKWNJO0D46CCW
         yczk2B8vylVOesxhHRI3usqwHj6EiKmiB8CageWaFyA8rfbfdrqW/qi0GJGypRf51Onk
         N1nDaq0EI7xl8ePvhPjauoemaXwATNstKGZs9Ychd2//EVsTd6cDNQjoDUA7ubv81eIE
         +xDZ6DBUhca2dutRNEbUoK8QuPWmhYhTXmEsF9fYbaETrukV/K1uiDMfH4wOHJn0NQvn
         gumVMslOVDaI4iYQf55BLxMa3riZ0YT0He4OgHznowCuKn6p4rL6VwSB41+qR841/uVD
         tMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=27qMKBfE9SqMjFa/icnG6O/UTntPosZR3vJbadVwXiU=;
        b=pQqQExDla26gylGUvSksaQUKnhSHcSeg/wxube5dVEbLvuaCTWl+cxGo+z4zs5/eyY
         ldZsgdjJxrBykArq8dKqWkr72TSzfh8sTzEpt69po+VisSCchzEQFOmBr5evQzkudIGG
         3117wwgCLEY7fXm/sQiAHoc9BwzBAla5+FsWiKlNn4PJXll6EYcALoP7LWUWEiNCqVO5
         AzLs9mdqVfvyYVXF0iZNkIVvacPqMfStEDcvbfQGyjK5Rk1FAySqEKWIA2WQypq7H6EY
         ZDXGcogYXRKsLfIzUjtNALNonj9Ibi801ayWl7+59xNClJFognUdVd6Ifvg7iOYG5qh8
         qdDg==
X-Gm-Message-State: AOAM530nkUGegRDp+o+fhI+i+aF2gCFMcVuEWfY37AYnRMdzKYYi7FU6
        pJfqbrNwTPVA9ofZR+ovbJeIY+mw9vKgmg==
X-Google-Smtp-Source: ABdhPJyCrQVPmwKxTW3NnqjcUyZvA7sND1qbR7JaJBjlXHJLK/zwjPmnEk+sQQDvZrmwkXt2pmGiBw==
X-Received: by 2002:a17:902:b941:b0:143:ae25:ba1a with SMTP id h1-20020a170902b94100b00143ae25ba1amr2737346pls.66.1636738336342;
        Fri, 12 Nov 2021 09:32:16 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a11sm6862342pfh.108.2021.11.12.09.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 09:32:15 -0800 (PST)
Date:   Fri, 12 Nov 2021 09:32:15 -0800 (PST)
X-Google-Original-Date: Fri, 12 Nov 2021 09:32:02 PST (-0800)
Subject: [GIT PULL] RISC-V Patches for the 5.16 Merge Window, Part 1
CC:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-109b0503-bc7c-4da8-8621-28aec8d9df59@palmer-ri-x1c9>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3f2401f47d29d669e2cb137709d10dd4c156a02f:

  RISC-V: Add hypervisor extension related CSR defines (2021-10-04 04:54:55 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.16-mw1

for you to fetch changes up to ffa7a9141bb70702744a312f904b190ca064bdd7:

  riscv: defconfig: enable DRM_NOUVEAU (2021-10-27 14:36:09 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.16 Merge Window, Part 1

* Support for time namespaces in the VDSO, along with some associated
  cleanups.
* Support for building rv32 randconfigs.
* Improvements to the XIP port that allow larger kernels to function
* Various device tree cleanups for both the SiFive and Microchip boards
* A handful of defconfig updates, including enabling Nouveau.

There are also various small cleanups.

----------------------------------------------------------------
Dimitri John Ledkov (1):
      riscv: set default pm_power_off to NULL

Heinrich Schuchardt (1):
      riscv: defconfig: enable DRM_NOUVEAU

Kefeng Wang (1):
      riscv/vdso: Drop unneeded part due to merge issue

Krzysztof Kozlowski (11):
      dt-bindings: mmc: cdns: document Microchip MPFS MMC/SDHCI controller
      riscv: dts: microchip: drop duplicated nodes
      riscv: dts: microchip: fix board compatible
      riscv: dts: microchip: drop duplicated MMC/SDHC node
      riscv: dts: microchip: drop unused pinctrl-names
      riscv: dts: microchip: use vendor compatible for Cadence SD4HC
      riscv: dts: sifive: use only generic JEDEC SPI NOR flash compatible
      riscv: dts: sifive: fix Unleashed board compatible
      riscv: dts: sifive: drop duplicated nodes and properties in sifive
      riscv: dts: microchip: add missing compatibles for clint and plic
      riscv: dts: sifive: add missing compatible for plic

Palmer Dabbelt (3):
      Merge remote-tracking branch 'palmer/riscv-vdso-cleanup' into for-next
      Merge tag 'for-riscv' of https://git.kernel.org/pub/scm/virt/kvm/kvm.git into for-next
      Merge tag 'riscv-sifive-dt-5.16' of git://gitolite.kernel.org/pub/scm/linux/kernel/git/krzk/linux into for-next

Randy Dunlap (1):
      riscv: add rv32 and rv64 randconfig build targets

Tong Tiangen (1):
      riscv/vdso: Add support for time namespaces

Vineet Gupta (1):
      riscv: mm: don't advertise 1 num_asid for 0 asid bits

Vitaly Wool (1):
      riscv: remove .text section size limitation for XIP

 .../devicetree/bindings/mmc/cdns,sdhci.yaml        |   1 +
 arch/riscv/Kconfig                                 |   1 +
 arch/riscv/Makefile                                |  10 +
 .../dts/microchip/microchip-mpfs-icicle-kit.dts    |  18 +-
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi  |  40 +---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi         |   2 +-
 .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  10 +-
 .../riscv/boot/dts/sifive/hifive-unmatched-a00.dts |   7 +-
 arch/riscv/configs/32-bit.config                   |   2 +
 arch/riscv/configs/64-bit.config                   |   2 +
 arch/riscv/configs/defconfig                       |   7 +-
 arch/riscv/include/asm/page.h                      |   2 +
 arch/riscv/include/asm/pgtable.h                   |   6 +-
 arch/riscv/include/asm/syscall.h                   |   1 +
 arch/riscv/include/asm/vdso.h                      |  13 +-
 arch/riscv/include/asm/vdso/gettimeofday.h         |   7 +
 arch/riscv/kernel/head.S                           |  12 +
 arch/riscv/kernel/reset.c                          |  12 +-
 arch/riscv/kernel/syscall_table.c                  |   1 -
 arch/riscv/kernel/vdso.c                           | 261 +++++++++++++++++----
 arch/riscv/kernel/vdso/vdso.lds.S                  |   6 +-
 arch/riscv/kernel/vmlinux-xip.lds.S                |  10 +-
 arch/riscv/mm/context.c                            |   8 +-
 arch/riscv/mm/init.c                               |   7 +-
 24 files changed, 311 insertions(+), 135 deletions(-)
 create mode 100644 arch/riscv/configs/32-bit.config
 create mode 100644 arch/riscv/configs/64-bit.config
