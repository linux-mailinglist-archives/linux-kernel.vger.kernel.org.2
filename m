Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD89839C914
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 16:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFEOjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 10:39:45 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:45611 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFEOjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 10:39:44 -0400
Received: by mail-pj1-f50.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso4128156pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=MVXg+TM3W6qOVs0MrUWFbVcO7ai55q7VxFvc/ybDjWw=;
        b=kaL/5d26QQxWUXqTD+oWxqPqRvfHi6y4jxIP4S93hMZMiBkw4G9HXo2xFxrXXr88Y2
         iWrGd20SJUjsjSrCyS9H182a25EpKPMcB8FzSEDdAiyZ8vYZF4d3Uq86xOXARoxuV8c+
         Z1QPfwDax1t8nhZnQrdzA60PVuZEMk/Xs7cZqxMbD8ZHAjhouVrb2GAg516iKJ7sh8Sc
         v8dp67bRZj7CQF2sV5fLxj1qjbDYrkZvqXUhLmXt5D7IBhgN6MTziIfOgXd0bPo3Xv7e
         +rm4UIFEYTO8+RFM0bA5LTT6QAHTW21RRcalVERASbzyvW3/C+WN6EVlZmGxqWICGpv1
         MoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=MVXg+TM3W6qOVs0MrUWFbVcO7ai55q7VxFvc/ybDjWw=;
        b=lP7ILYTehlvCjVK3mE8nRUx7OFZcQkhIO+iHG+oYb5LCqv6LG/Khio/v3ndbWDeV6W
         x9Kgu5oVdQP8H4ZkjxYvTg6kemLyyMC1m+I5krPSMQnDO6Md02YZrQJSghONQaXXruct
         M7INrh/f6JO2IK08qpWJIe1F4zIh7v5M18jHz7rhTONaPACnGMBzGNIA0+i4qihQIU+1
         m97dOPf9/zGtUOrjWxaSvwTnY4n3REXIXw20tmKpriVefHKoqf8t06fjSpNM9wB0TfkO
         jYacLmYdDlwB901hKIn8RbwzMHtNeS2X0W47ojaDV8s1W45afVZQXKnG7Dz86CwGFbaK
         f9nw==
X-Gm-Message-State: AOAM530iUZfavK16Ndx7HS5TlKBpIKkZ0uiOZr1q7EKipHhATllME7cX
        2rgSBggYbU62ouBDt5cepqiliw==
X-Google-Smtp-Source: ABdhPJz2e10SXkzAW2wHeuYPnO5Ux9o74si+RhnWjaYFkoWIuzajzYNFS+gLvVsg8VwT8xcAZgRnkA==
X-Received: by 2002:a17:903:1c2:b029:10e:5ff0:bd44 with SMTP id e2-20020a17090301c2b029010e5ff0bd44mr9234171plh.7.1622903801524;
        Sat, 05 Jun 2021 07:36:41 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d12sm4017894pfv.190.2021.06.05.07.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 07:36:40 -0700 (PDT)
Date:   Sat, 05 Jun 2021 07:36:40 -0700 (PDT)
X-Google-Original-Date: Sat, 05 Jun 2021 07:36:38 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.13-rc5
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-8b83335c-43d4-4912-a2b6-2d609e10d7bf@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bab0d47c0ebb50ae0bcfa4e84986a60113bf7d6b:

  riscv: kexec: Fix W=1 build warnings (2021-05-22 22:05:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-rc5

for you to fetch changes up to 160ce364167fabf8df5bebfff1b38fd5d8c146c9:

  Merge remote-tracking branch 'riscv/riscv-wx-mappings' into fixes (2021-06-01 21:17:08 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.13-rc5

* Build with '-mno-relax' when using LLVM's linker, which doesn't
  support linker relaxation.
* A fix to build without SiFive's errata.
* A fix to use PAs during init_resources()
* A fix to avoid W+X mappings during boot.

----------------------------------------------------------------
Jisheng Zhang (1):
      riscv: mm: Fix W+X mappings at boot

Khem Raj (1):
      riscv: Use -mno-relax when using lld linker

Palmer Dabbelt (1):
      Merge remote-tracking branch 'riscv/riscv-wx-mappings' into fixes

Vincent (1):
      riscv: skip errata_cip_453.o if CONFIG_ERRATA_SIFIVE_CIP_453 is disabled

Wende Tan (1):
      RISC-V: Fix memblock_free() usages in init_resources()

 arch/riscv/Makefile               | 9 +++++++++
 arch/riscv/errata/sifive/Makefile | 2 +-
 arch/riscv/kernel/setup.c         | 4 ++--
 arch/riscv/mm/init.c              | 8 ++++++--
 4 files changed, 18 insertions(+), 5 deletions(-)
