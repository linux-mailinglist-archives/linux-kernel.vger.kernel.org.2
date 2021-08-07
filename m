Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661043E3656
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 18:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhHGQkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 12:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhHGQkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 12:40:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4C9C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 09:39:51 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u2so11465284plg.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=grhFZWxTWMmC2nk3rV2w/FHZSjI97u/vyUnDNsG5W9M=;
        b=XrkliiU5S+vfR/+wxmgI/3TIBaZ6HY2Fsy/6/i+FMVC5WUr5HeFYXlD2AAdJQVl3tJ
         E+2EOamHW9BPOWUk7yCfIrf7jDeOAxGa0doHnl9m94NzYhkKypiSd3HEe+RgvIapvKEg
         FQbpKqTm5gr2zim5i/olvJdo7leV21sdYSeyDaiG/a7AvYhLLPrjn4gCCAr1mBp6/oHf
         ibbTFTbi9iQE+BD54rm14U2AwN/2VT53ZPSPJZ/tUCDQv+4Ksiy0bw/zGkirbk2n2+my
         9yjmHgyGrWGgypbokB53SPxsB2eq935GRM+yByOcVd9NjGue9RpyKCnelfT/yDn4KLJY
         J3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=grhFZWxTWMmC2nk3rV2w/FHZSjI97u/vyUnDNsG5W9M=;
        b=XtOrRpbb4sYi4Vk7RZSnevKP3IZ9RyZh1/0ViO33kU+Qx8vtRj5WNZUldx2n8dWyPm
         hpyG+fV8vOuRg/grJit522NCUn8PcxOfBKmhpQHgkHo8uRxChpEOR00md2dblkuW/xSM
         20pidg2ayf8PMmacT1Ung1v4PM42UYPlkONkcILTKZuX+E4Rr5A61bwge4NFp+h6bf09
         abTOgVyYcEpo/0lpfkAIy2QHFwVmzs3T62ucsz0Rid+5TyD+UfY5oFFAbg59bXckLVK2
         SbtKnzlVC84XJwp9yn8LmqSyTv/JHclq5NK31wC+OiWLIYWpdvi+GVdjL28Oe9SBEZQp
         D1fw==
X-Gm-Message-State: AOAM532DGSf1U3U1XCz0GCNje8Y4r2pOS+omQPBLzL1jnhg1NPPZyru8
        Xp6FY9ALwI+rB5IWvvcny+y7yw==
X-Google-Smtp-Source: ABdhPJxD/zozsaYYd4McHQ1wf+eJJ1Tb0yRRbC4NRCqa6TfwodEcUeE1yuhQyMZx1m80QSml4bvebQ==
X-Received: by 2002:a63:f145:: with SMTP id o5mr138042pgk.273.1628354390553;
        Sat, 07 Aug 2021 09:39:50 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j22sm16340647pgb.62.2021.08.07.09.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 09:39:50 -0700 (PDT)
Date:   Sat, 07 Aug 2021 09:39:50 -0700 (PDT)
X-Google-Original-Date: Sat, 07 Aug 2021 09:39:47 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.14-rc5
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-bafc6421-186d-4f3b-b5bd-7c7f15bf94fe@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ea196c548c0ac407afd31d142712b6da8bd00244:

  riscv: __asm_copy_to-from_user: Fix: Typos in comments (2021-07-23 17:49:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-rc5

for you to fetch changes up to 867432bec1c6e7df21a361d7f12022a8c5f54022:

  Revert "riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED" (2021-08-06 22:41:39 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.14-rc5

* A fix to avoid dereferencing a null task pointer while walking the
  stack.
* A fix to the memory size in the HiFive Unleashed device tree.
* A fix to disable stack protectors when randstruct is enabled, which
  results in non-deterministic offsets during module builds.
* A pair of fixes to avoid relying on a constant physical memory base
  for the non-XIP builds.

----------------------------------------------------------------
Alexandre Ghiti (2):
      riscv: Get rid of CONFIG_PHYS_RAM_BASE in kernel physical address conversion
      Revert "riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED"

Guenter Roeck (1):
      riscv: Disable STACKPROTECTOR_PER_TASK if GCC_PLUGIN_RANDSTRUCT is enabled

Jisheng Zhang (1):
      riscv: stacktrace: Fix NULL pointer dereference

Qiu Wenbo (1):
      riscv: dts: fix memory size for the SiFive HiFive Unmatched

 arch/riscv/Kconfig                                  |  7 +++++++
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts |  2 +-
 arch/riscv/include/asm/page.h                       |  7 ++++---
 arch/riscv/kernel/stacktrace.c                      |  2 +-
 arch/riscv/mm/init.c                                | 17 ++++++++++++-----
 5 files changed, 25 insertions(+), 10 deletions(-)
