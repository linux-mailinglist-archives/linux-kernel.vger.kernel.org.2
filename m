Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A29F3A4F9C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 17:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhFLQBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 12:01:07 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:34457 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhFLQBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 12:01:06 -0400
Received: by mail-pg1-f176.google.com with SMTP id l1so5042709pgm.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=HbfYjfhGbhPgjXmvpwXGZWGeq+0VqyUCmSjflkjdYJM=;
        b=kIv453cF1uAwja7Al86wvZnDiAFaJURV8OqIQIk8IwVMhZbJdElYqFIolw2wHaPNup
         u9VdXnL+JbERX/QbjittM4OxEWu1/zxleANf5/UhOQGbLRtc1tAUKe/ZLAWezNjwjCmP
         OytB02SmiiG0ngdaidNZXWKMIB6D+as1e/j1zPIoC+/qSLF/zouFdURb+hSi02eMP/Y5
         6MOL3hxF6xQ5dOVzg5V7aIOwmQP9EZYZrdP8+dcMq3crc/bm76FzAI+wedCw9E+QC1sG
         /WNO20JLKrkf/AYbcU4Fdvxao8kIGz/YHtKmN40zinzy8+yCSI4dM5OVUc4SkC21m9Li
         la3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=HbfYjfhGbhPgjXmvpwXGZWGeq+0VqyUCmSjflkjdYJM=;
        b=gf19mLBt/qmmujxMk/a2ykYmtTsJ/NkjNNMpm2zItOKK1MmgsWxbzG8MMGPci83Kvb
         f0UK5ymNxpcqaY9O/zc3QcCrNyTRo+Ci0H0dbzHtbCJVTAr8KXPXpjWz3SQY07YR3YSj
         sVqnIjtUbxG5BOWeRzccJGXwi8rVA550LOVzhoOp6DIy5fUPU+Ii3xmkL9R14CAflUZc
         rDSh9yqX4lp1FHOPXCDov4I+NjI1tYyqCfEvzc3L+pmSmP4XFoIaPfwBZ2RN3ASWbl+z
         rAV+HcxJf9YN7sIaym7y0SaxmMWmb5VMlLTPJn3ul0WrD4G++oFFl3ItoMEhf5LszSdv
         yBDA==
X-Gm-Message-State: AOAM531g2ZsJEZbq4/msdBWZhrQIxK+c+yRljfzR8WHoDSuCz79apHXc
        4BpjFkZ//1LgvTgtkq+WqEua1Q==
X-Google-Smtp-Source: ABdhPJyldfcTCoTm49mMx0ZQIOdvC/vomORZsm110j1qIeZULqKBlMSlVTJN57hFB69SIl2cUWRRKQ==
X-Received: by 2002:aa7:93a9:0:b029:2e9:c839:d2d with SMTP id x9-20020aa793a90000b02902e9c8390d2dmr13372334pff.5.1623513486080;
        Sat, 12 Jun 2021 08:58:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j12sm8380392pgs.83.2021.06.12.08.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 08:58:05 -0700 (PDT)
Date:   Sat, 12 Jun 2021 08:58:05 -0700 (PDT)
X-Google-Original-Date: Sat, 12 Jun 2021 08:57:46 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.13-rc6
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-eafb1de7-d58e-417f-9a42-76e32e2a04d5@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 160ce364167fabf8df5bebfff1b38fd5d8c146c9:

  Merge remote-tracking branch 'riscv/riscv-wx-mappings' into fixes (2021-06-01 21:17:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-rc6

for you to fetch changes up to 0ddd7eaffa644baa78e247bbd220ab7195b1eed6:

  riscv: Fix BUILTIN_DTB for sifive and microchip soc (2021-06-11 21:07:09 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.13-rc6

* A pair of XIP fixes: one to fix alternatives, and one to turn off the
  rest of the features that require code modification.
* A fix to a type that was causing some alternatives to break.
* A build fix for BUILTIN_DTB.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Fix BUILTIN_DTB for sifive and microchip soc

Jisheng Zhang (1):
      riscv: code patching only works on !XIP_KERNEL

Vitaly Wool (2):
      riscv: xip: support runtime trap patching
      riscv: alternative: fix typo in macro name

 arch/riscv/Kconfig                          | 18 +++++++++---------
 arch/riscv/boot/dts/microchip/Makefile      |  1 +
 arch/riscv/boot/dts/sifive/Makefile         |  1 +
 arch/riscv/include/asm/alternative-macros.h |  4 ++--
 arch/riscv/kernel/traps.c                   | 13 +++++++++----
 arch/riscv/kernel/vmlinux-xip.lds.S         | 15 ++++++++++++++-
 6 files changed, 36 insertions(+), 16 deletions(-)
