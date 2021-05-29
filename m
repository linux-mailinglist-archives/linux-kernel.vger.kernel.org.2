Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0C394D84
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 19:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhE2RX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 13:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhE2RXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 13:23:54 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C928FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 10:22:17 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id m190so5034261pga.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=q7CQNv9swkDWDrp6f04EPlU0B7np7rtJnJeA30IsokY=;
        b=q9ks+3gK/79CxIQZkGEG1LdX/QZTFKQv6gJ/NxUGtvJ3/pEfw1+jEFA6xjq0sGY3vV
         zDCAwdQPY1/oM23fx++24Rtd0PCcThCSsKdYj29kLsuwmA/7s/X4MOPskzBhzCtse2Xj
         knuGj/MoTvdrqC5lQzH+iujg9wQskBFOoLGnyCELdiDDCkiZujb0h/vLN3IQbmYlh5QA
         5m0ImddDDPDNkBkmbJhq3uobU26COhakeowL06bfyDoiv8W1VBqT/2i432b+KFf0+Aum
         /EghMK2FTlh2NmYNlsdijdJKt2KXgAHs6WTjlPKyn4HtOTskop7qdEm4Znh3na/T8JhY
         ZkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=q7CQNv9swkDWDrp6f04EPlU0B7np7rtJnJeA30IsokY=;
        b=s9PbqpPXQkP4uamghq13YcxjD3wd/4GeeXiHe3sjm9eZI/WY9Q8t4SyuOr2zrDGwL6
         meEilRMzY1qzqFHtxXDQ0GcCzehi0ojfJSdnk3Urji+EvPAmWxAwxiuCzDdyXbvvAc15
         doNS5o4phoTWWvh1OJBC57Um7VxQtaUIfkhVtU09n208jWMcTFoGL6WUITWoLzqXavw9
         hwbMWi223shO/dQZcclL3oK247zZhfC4bmsqtZgW/wOLzgBbJNyQ9zyZHNGuXWpwMQve
         r+fEq2HxIcc0CUq8a1tGXkEQZUrwzkgcTIlUO7AigQcP/5KVtNLzt3jGco/NCpMaWFgY
         eYAA==
X-Gm-Message-State: AOAM533hQmTSAcw1WdPfjSap0mmJBbjvXWWdSYVq2jKbFpCUH7H0vSiV
        ArCJUGngIDDicXRwrj0k0mKCxt2dL/sMWw==
X-Google-Smtp-Source: ABdhPJx3GspxyNsmPK29EQJJUBo6PPEaUQO+Az3IKbXmlReqj00gD62kDcuYmQzeVh9JBSYYmn7XZg==
X-Received: by 2002:a63:1906:: with SMTP id z6mr14538726pgl.173.1622308936937;
        Sat, 29 May 2021 10:22:16 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e188sm2174595pfe.23.2021.05.29.10.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 10:22:16 -0700 (PDT)
Date:   Sat, 29 May 2021 10:22:16 -0700 (PDT)
X-Google-Original-Date: Sat, 29 May 2021 10:22:13 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.13-rc4
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-5051d261-3f3c-405c-a9a0-68fb70aa7c71@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-rc4

for you to fetch changes up to bab0d47c0ebb50ae0bcfa4e84986a60113bf7d6b:

  riscv: kexec: Fix W=1 build warnings (2021-05-22 22:05:30 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.13-rc4

I have a handful of RISC-V related fixes:

* A fix to avoid errors when the stack tracing code is tracing itself.
* A fix to resurrect the memtest= kernel command line argument on
  RISC-V, which was briefly enabled during the merge window before a
  refactoring disabled it.
* A build fix and some warning cleanups.

----------------------------------------------------------------
Chen Huang (1):
      riscv: stacktrace: fix the riscv stacktrace when CONFIG_FRAME_POINTER enabled

Jisheng Zhang (2):
      riscv: kprobes: Fix build error when MMU=n
      riscv: kexec: Fix W=1 build warnings

Kefeng Wang (1):
      riscv: Select ARCH_USE_MEMTEST

 arch/riscv/Kconfig                 |  1 +
 arch/riscv/include/asm/kexec.h     |  4 ++--
 arch/riscv/kernel/machine_kexec.c  | 11 ++++++-----
 arch/riscv/kernel/probes/kprobes.c |  2 ++
 arch/riscv/kernel/stacktrace.c     | 14 +++++++-------
 5 files changed, 18 insertions(+), 14 deletions(-)
