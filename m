Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C7D3ADAA7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 17:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhFSPpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 11:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbhFSPpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 11:45:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FC6C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 08:43:00 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id n12so1660696pgs.13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=WLt1aypUZFf0uLl5W0e4Cbr/bbAeIOctJoAlWFkvXzE=;
        b=gRPyoOYcDOFA7sfIDglnW7bevnFKWvhANMc+VSUN47ht8jV5axsiaZLo3NeGx74sT5
         xO7oezOz14Ryt2FjqAcHB0y3hr0Lw5VORWn8EN1AcKdTju2hatrFenYVglOPvyu0sS7X
         HKPqxcARMBYSqc6H+PpG6/TNGM0UAcbAoLPBkOVU6kBc3AL5vadpN0QOLxBkPNAwdcM5
         bZeqOUE57M6dZ80NjlS5aqGNZWpRdYukOZ2i75zJV85TAP0W/zmL9XmS93BDnEcZxGK0
         oGOr7hH6v9lDHTKmdiXpvAt6GNf/LSLPHCDiIn+/uAV55UNUXzl3v//8xqeyOOJuwLyu
         EgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=WLt1aypUZFf0uLl5W0e4Cbr/bbAeIOctJoAlWFkvXzE=;
        b=KrsCcJoTv//lpA9fwWwq4yODKm1KiUZjXI8++5mwioRD4XBBKZqApgHmVOmQnCfqfh
         5+aBP38ozqhjoDesLhJYL+V8Xg0bwgA0CHDdd/A1nT/ZGKdid7P0FsVjeZFmCNGRraJF
         S6qYKHfHLNhBG7zuTOEatWOoSDHJLQP5hWrGiYx3OdbwrTzls2uUGra+TNHEKzqpLnVk
         se9cpmZSeD6H50kjv5JWdhopaxCOx+aneDAuGgMIfLoLViip0NNjRnuE1DFO39Tkeejj
         zvtqQ39ujco2q0I78EI502Cf1k5IZ9n3qw4ieETsptNZddjFrkZHo8pPRaodDV9ve+sK
         pDnw==
X-Gm-Message-State: AOAM530JBF/W5G0IA8GJ4W6XvPiBgnraN+meKtAhmpmPkJfcnhrSAeWm
        7/cbLGYTkgsRPkA/xSF8Ydi0HQ==
X-Google-Smtp-Source: ABdhPJxA5FqeHFXUxAEAo2KZ9LrRDtalHguaHloHVDHAy7YM08UWIt6KnFzONUH5FP+Bje9Tkgga3Q==
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id p30-20020a056a000a1eb02902e289d85c87mr11021738pfh.73.1624117379725;
        Sat, 19 Jun 2021 08:42:59 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 10sm8352494pfh.174.2021.06.19.08.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 08:42:59 -0700 (PDT)
Date:   Sat, 19 Jun 2021 08:42:59 -0700 (PDT)
X-Google-Original-Date: Sat, 19 Jun 2021 08:42:55 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.13-rc7
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-768bd541-d21a-4a3e-9c92-da08277ab3ba@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0ddd7eaffa644baa78e247bbd220ab7195b1eed6:

  riscv: Fix BUILTIN_DTB for sifive and microchip soc (2021-06-11 21:07:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-rc7

for you to fetch changes up to 7ede12b01b59dc67bef2e2035297dd2da5bfe427:

  riscv: dts: fu740: fix cache-controller interrupts (2021-06-19 00:11:53 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.13-rc7

* A build fix to always build modules with the medany code model, as
  the module loader doesn't support medlow.
* A Kconfig warning fix for the SiFive errata.
* A pair of fixes that for regressions to the recent memory layout
  changes.
* A fix for the FU740 device tree.

----------------------------------------------------------------
David Abdurachmanov (1):
      riscv: dts: fu740: fix cache-controller interrupts

Jisheng Zhang (2):
      riscv: kasan: Fix MODULES_VADDR evaluation due to local variables' name
      riscv: Ensure BPF_JIT_REGION_START aligned with PMD size

Khem Raj (1):
      riscv32: Use medany C model for modules

Randy Dunlap (1):
      riscv: sifive: fix Kconfig errata warning

 Documentation/riscv/vm-layout.rst          |  4 ++--
 arch/riscv/Kconfig.socs                    |  1 +
 arch/riscv/Makefile                        |  2 +-
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi |  2 +-
 arch/riscv/include/asm/pgtable.h           |  5 ++---
 arch/riscv/mm/kasan_init.c                 | 10 +++++-----
 6 files changed, 12 insertions(+), 12 deletions(-)
