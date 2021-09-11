Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74B2407A05
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 19:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhIKRpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 13:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhIKRpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 13:45:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD803C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 10:43:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g14so4892329pfm.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=3NAUD4pLhng5e+omesoYDFR9m1AaPpbXzzageJG9Ma8=;
        b=0SizikyDizbpPDgx6+o5KlEfv5fyR4MEubK6B4qO7bCy/F4VpuVzG4JFQTenJQwGLn
         iI/Kz/CcST+B1m273BpXw/Th9t00b2zfl5EYpVgxe6iGmURyhYxE3hnpdXA7DGMN5SA0
         WkeS2Fq0c7oAO45s+zyvOMtAMXDSsyTyukZGUvFtXx30eiLjgelv7Uyr1Ov5IvbQHZRp
         b0oLG3zxrR6dRhnF6qUfcQTEevKdjtGyiKxqNL4Gr1i7SHVwvK3R5FBBQXZwR2Q+uqGR
         Fj0EFLjwI6PaujO5SHEDsawic4sJaf/QoBd8BtM+1g0vIe6WQWCENCYupCLSB3UYXuBO
         wzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=3NAUD4pLhng5e+omesoYDFR9m1AaPpbXzzageJG9Ma8=;
        b=XqylktA4hMWPN9bpCXmWjmetOTKoHDQFjAK/vPGjeGEBm5lvKGop4tgOe3M5CdQI3J
         h4EL/wXb+ffOgbHqLnwX4TjGLSYBzSFXa7nG24D8Jr8qL/eS7tK07f1Hs9ADNjuL7C+/
         h6UE7VR36hzyzyrGQvSjaCVhoQD1nS0V0RYXHdtG09dtHRZb9ka9nU3foblCPp6uONct
         YNg1WWLet2SLCQ4QQDe9jn9UIVMujlortnrqXw+S2smPHtrX6z8XQXmJnfYAXdN2Ooz4
         aMAv8yFXmm1f0UW8MBj/LYvVPHlHFaMQ5xRalezkQ1JRcTaV47BeIk4fMjeyPd3G/PpH
         3iMQ==
X-Gm-Message-State: AOAM532A3bKmiohkoHelGfkiOCig2/tdi7fYioHKN5bls1kcc70DfeYV
        FaZufb5B4VHGNOSH4FyJkxG2Cn88jonBAla7
X-Google-Smtp-Source: ABdhPJyZRmww7urXa4w267bTP9i2mnmfwpoW9SrScImCH4DhJlXpz9zAOMEg6zKyIBCWz6ekuhe44w==
X-Received: by 2002:a63:e613:: with SMTP id g19mr3394586pgh.12.1631382228143;
        Sat, 11 Sep 2021 10:43:48 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y4sm2226561pjw.57.2021.09.11.10.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 10:43:47 -0700 (PDT)
Date:   Sat, 11 Sep 2021 10:43:47 -0700 (PDT)
X-Google-Original-Date: Sat, 11 Sep 2021 10:43:37 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 5.15 Merge Window, Part 2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-b2b622b6-e788-4923-8cf2-ada90a2a095f@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged tag 'riscv-for-linus-5.15-mw0'
The following changes since commit 063df71a574b88e94391a3a719cf66d1b46df884:

  Merge tag 'riscv-for-linus-5.15-mw0' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2021-09-05 11:31:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.15-mw1

for you to fetch changes up to 6f55ab36bef505b449723300a5a445ddc76a94d7:

  riscv: Move EXCEPTION_TABLE to RO_DATA segment (2021-09-10 23:59:48 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.15 Merge Window, Part 2

* A pair of defconfig additions, for NVMe and the EFI filesystem
  localization options.
* A larger address space for stack randomization.
* A cleanup to our install rules.
* A DTS update for the Microchip Icicle board, to fix the serial
  console.
* Support for build-time table sorting, which allows us to have
  __ex_table read-only.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      riscv: dts: microchip: mpfs-icicle: Fix serial console

Heinrich Schuchardt (2):
      riscv: defconfig: enable BLK_DEV_NVME
      riscv: defconfig: enable NLS_CODEPAGE_437, NLS_ISO8859_1

Jisheng Zhang (2):
      riscv: Enable BUILDTIME_TABLE_SORT
      riscv: Move EXCEPTION_TABLE to RO_DATA segment

Kefeng Wang (1):
      riscv: Improve stack randomisation on RV64

Masahiro Yamada (1):
      riscv: move the (z)install rules to arch/riscv/Makefile

 Documentation/features/vm/ELF-ASLR/arch-support.txt         | 2 +-
 arch/riscv/Kconfig                                          | 1 +
 arch/riscv/Makefile                                         | 7 +++++--
 arch/riscv/boot/Makefile                                    | 8 --------
 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 6 +++++-
 arch/riscv/configs/defconfig                                | 4 ++++
 arch/riscv/include/asm/elf.h                                | 3 +++
 arch/riscv/kernel/vmlinux-xip.lds.S                         | 1 -
 arch/riscv/kernel/vmlinux.lds.S                             | 4 ++--
 scripts/sorttable.c                                         | 1 +
 10 files changed, 22 insertions(+), 15 deletions(-)
