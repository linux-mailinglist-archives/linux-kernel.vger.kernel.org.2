Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C40342AF1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 06:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhCTFjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 01:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhCTFj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 01:39:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8615DC061762
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 22:39:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so9304297pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 22:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=L37xP3um01dwHIo65VZFBsa9BPBQ2JNMQtwm2HUTIik=;
        b=TUFcxdwg2+t6j+XKWHK3UYxpi1TPPa6mcq+x57RJzmUenb8enpq3izvSr0rrqzW4IM
         Z/Y9u/8OsH0yfTlOL8CVI2qF/zgjc6h9VCxQGv51TyREKU3atRYkfdTEGz0y1sVZIFA+
         h/3krxJScR07hFJMJ0yzLcrBbOh18KnnqJ3FC4R13yAPNm2voBcKuVI5RGYdXN4WkHSc
         jaHCF99QImeJueHPNSnONZ6pcXXeoW0ez6jt/gXvIs3Xq0LXWwXsU9lBQFgDLy45nS3Y
         qQZAjTsiV92BGKjmSICf7PCBgMquwymsX8PXa8tDYuBD2o86fYx0QPwfgifnPN9ljgxr
         2M7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=L37xP3um01dwHIo65VZFBsa9BPBQ2JNMQtwm2HUTIik=;
        b=WZavJZqMDJ5vBE0A1ydeNc8bVTw95VvW08TdIHxUx3CorP+AzwWf2jiwlqAaza4mHc
         tWmQ/nnN/lOqgSLANN7fEO3Ano6oW0UESPBh3IrA1iswlt8aFg6lakqzyBxtu226hPXi
         BG4+u2717Qm0S1gwDrCmedRHY76rPk5Kz45CRZXjMsJZvsx++iGAqIrOyCrjyg42lRG/
         81RoED9g9jOOSHiqwjztc6qMIPd1+3u2nqh5HpzGXuY4h2g3fduRzHzIVSRJu9GRfd+U
         Hv68fBK7lUdX2uHWLYm09V0ZcvzahGLSC1vkNRYrMUathXRwV4fqZ3IjPVA8WMfkFb17
         xIZQ==
X-Gm-Message-State: AOAM5300DoV7fjb9r4+qYtlUvGCdQaonCMP61YJq6pRjxr/nmqZKF31t
        BS1824PzIL2wpZjs7dz5cbqFLE8RclQouQ==
X-Google-Smtp-Source: ABdhPJx3Ff/bFFZPlfljpGK3Xz2ePwTTmTeJI56jcdGCJGWEGH37XQxVRxyfOJjmUAacRMiXCRNBAA==
X-Received: by 2002:a17:902:e8d5:b029:e6:cabb:d07 with SMTP id v21-20020a170902e8d5b02900e6cabb0d07mr14687671plg.3.1616218763813;
        Fri, 19 Mar 2021 22:39:23 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g12sm7145995pfh.153.2021.03.19.22.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 22:39:23 -0700 (PDT)
Date:   Fri, 19 Mar 2021 22:39:23 -0700 (PDT)
X-Google-Original-Date: Fri, 19 Mar 2021 22:39:17 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.12-rc4
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-b3197f76-bb8d-4834-810e-3b255c26a5fd@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.12-rc4

for you to fetch changes up to a5406a7ff56e63376c210b06072aa0ef23473366:

  riscv: Correct SPARSEMEM configuration (2021-03-16 22:15:21 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.12-rc4

I have handful of fixes for 5.12:

* A fix to the SBI remote fence numbers for hypervisor fences, which had
  been transcribed in the wrong order in Linux.  These fences are only
  used with the KVM patches applied.
* A whole host of build warnings have been fixed, these should have no
  functional change.
* A fix to init_resources() that prevents an off-by-one error from
  causing an out-of-bounds array reference.  This is manifesting during
  boot on vexriscv.
* A fix to ensure the KASAN mappings are visible before proceeding to
  use them.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Ensure page table writes are flushed when initializing KASAN vmalloc

Colin Ian King (1):
      ftrace: Fix spelling mistake "disabed" -> "disabled"

Damien Le Moal (1):
      riscv: Fix compilation error with Canaan SoC

Geert Uytterhoeven (1):
      RISC-V: Fix out-of-bounds accesses in init_resources()

Heinrich Schuchardt (1):
      RISC-V: correct enum sbi_ext_rfence_fid

Kefeng Wang (1):
      riscv: Correct SPARSEMEM configuration

Nanyong Sun (9):
      riscv: traps: Fix no prototype warnings
      riscv: irq: Fix no prototype warning
      riscv: sbi: Fix comment of __sbi_set_timer_v01
      riscv: ptrace: Fix no prototype warnings
      riscv: time: Fix no prototype for time_init
      riscv: syscall_table: Reduce W=1 compilation warnings noise
      riscv: process: Fix no prototype for show_regs
      riscv: ftrace: Use ftrace_get_regs helper
      riscv: process: Fix no prototype for arch_dup_task_struct

Palmer Dabbelt (1):
      RISC-V: kasan: Declare kasan_shallow_populate() static

kernel test robot (1):
      riscv: fix bugon.cocci warnings

 arch/csky/kernel/probes/ftrace.c        |  2 +-
 arch/riscv/Kconfig                      |  4 ++--
 arch/riscv/Kconfig.socs                 |  2 ++
 arch/riscv/include/asm/asm-prototypes.h | 16 ++++++++++++++++
 arch/riscv/include/asm/irq.h            |  2 ++
 arch/riscv/include/asm/processor.h      |  1 +
 arch/riscv/include/asm/ptrace.h         |  5 +++++
 arch/riscv/include/asm/sbi.h            |  4 ++--
 arch/riscv/include/asm/timex.h          |  2 ++
 arch/riscv/kernel/Makefile              |  1 +
 arch/riscv/kernel/probes/ftrace.c       | 18 ++++++++++--------
 arch/riscv/kernel/probes/kprobes.c      |  3 +--
 arch/riscv/kernel/process.c             |  1 +
 arch/riscv/kernel/sbi.c                 |  2 +-
 arch/riscv/kernel/setup.c               |  3 ++-
 arch/riscv/kernel/time.c                |  1 +
 arch/riscv/kernel/traps.c               |  1 +
 arch/riscv/mm/kasan_init.c              |  4 +++-
 arch/x86/kernel/kprobes/ftrace.c        |  2 +-
 19 files changed, 55 insertions(+), 19 deletions(-)
