Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B41537739E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 20:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhEHS1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 14:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhEHS07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 14:26:59 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38510C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 11:25:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h14-20020a17090aea8eb02901553e1cc649so7332638pjz.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=shpt2GxHpkIOa8FMzNcihpagpGywSo+7Qiz4Q2suvAI=;
        b=YbSLrsKvWGXxgZOdaeVGPk2hu9f/9U6tqHnKd8hGyM3WtYKqMoC0lHAa5xhSfMEQ4o
         wltrmdtqPBvYN8vINKImd2CdosfRg15QXrt+/jxAPuXInmfTsVN0IahVPVyRIL8xZQnO
         h3eSKBzcUCCSHGDFGlaQ+tRF/5o2q+EnZgj8wtA/PwE2OiZC+e1EHr4xdufvbnjjFHs1
         ECWtxfZDibtIJb5O9rI4O3FEEMeZS4IXevLfens4AA3l0W7X5Qh8NBZfLmhGDR9gHRjn
         aCvR01aHk3pOqjfeKiwlaVfFaalGWaCFg6UJnD7G2cgzPENiRo/JlUUpFEIYduWkiIwj
         L7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=shpt2GxHpkIOa8FMzNcihpagpGywSo+7Qiz4Q2suvAI=;
        b=Ea0bujRglpc3Z2Z6LL5YozchyI7HB3ExeyNmetHWY+p6Uei4XDr94TNvux2xTeePxR
         lklR+U7DWPAJrffu/31vcd5uP/6oUu3wImuSSUBsoywPM+DN3rPeKoLXOT9L1ZQKYb1H
         2xVjLD8EsOifCgTmid10tcTF57afGO1wzKr+wA9aZtZpRjR3e0XbNu1KIJDVbQX6uIOm
         BzXfeysbqijNPdBmLfKJ6lkNpZiGaiT4f91PQ5xpJsqzKmscd+7M9obNcU+8vYFJ6HZp
         7qWemgf1KzszMfs+kLHZpxOIilwrE91vBIF/jHHLm4U1JKM7xl0EG7QAQR83jhcww3hc
         klsQ==
X-Gm-Message-State: AOAM5318pVcB/GhnO+81LhI/noXHSg8R99OtR9qLLvhSH2zCWjzPGjE5
        HbuNN5aVmHeRbUlFPiEXREHXfQ==
X-Google-Smtp-Source: ABdhPJyhtPPO3t6Ufe08/C/YxWRg/G4+Thpoy0pKKdO4FfP8qLBotuenF+sbOpMQAKxIaaOENH4l1A==
X-Received: by 2002:a17:90a:3f08:: with SMTP id l8mr30283213pjc.136.1620498357401;
        Sat, 08 May 2021 11:25:57 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g84sm7489467pfb.198.2021.05.08.11.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 11:25:56 -0700 (PDT)
Date:   Sat, 08 May 2021 11:25:56 -0700 (PDT)
X-Google-Original-Date: Sat, 08 May 2021 11:25:54 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for the Merge Window, Part 2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-00f4b683-5870-489d-b713-aa5f18aaa6c5@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged tag 'riscv-for-linus-5.13-mw0'
The following changes since commit 939b7cbc00906b02c6eae6a380ad6c24c7a1e043:

  Merge tag 'riscv-for-linus-5.13-mw0' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2021-05-06 09:24:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-mw1

for you to fetch changes up to beaf5ae15a13d835a01e30c282c8325ce0f1eb7e:

  riscv: remove unused handle_exception symbol (2021-05-06 09:40:16 -0700)

----------------------------------------------------------------
RISC-V Fixes for the Merge Window, Part 2

* A fix to avoid over-allocating the kernel's mapping on !MMU systems,
  which could lead to up to 2MiB of lost memory.
* The SiFive address extension errata only manifest on rv64, they are
  now disabled on rv32 where they are unnecessary.

There are also a pair of late-landing cleanups.

----------------------------------------------------------------
Geert Uytterhoeven (2):
      riscv: Only extend kernel reservation if mapped read-only
      riscv: Consistify protect_kernel_linear_mapping_text_rodata() use

Rouven Czerwinski (1):
      riscv: remove unused handle_exception symbol

Vincent Chen (1):
      riscv: enable SiFive errata CIP-453 and CIP-1200 Kconfig only if CONFIG_64BIT=y

 arch/riscv/Kconfig.erratas          |  4 ++--
 arch/riscv/include/asm/set_memory.h |  7 ++++++-
 arch/riscv/kernel/setup.c           |  2 --
 arch/riscv/kernel/traps.c           |  2 --
 arch/riscv/mm/init.c                | 11 ++++++++---
 5 files changed, 16 insertions(+), 10 deletions(-)
