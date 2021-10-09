Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6CA42775A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 06:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhJIEkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 00:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhJIEkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 00:40:12 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61DDC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 21:38:15 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r2so5024747pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 21:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=GLtUQay0Jz5XCFvG0wpPVlDUiFUuJN9wSLCgiMgA340=;
        b=IPJFaLK9fIGBZhDErrqZ6xMv5p/0wEAtlK+WmoAKM631dJUaqdpCwke1JPuCa2tc+q
         vwjdoHCJdqjMC1EctnOtR/jAtYEAeofm7p4Di6ZICdSAQ+KYZtrUxNeP/Ajzy06vqSOO
         UNbaSV4tFFqNt4ZdAChyNOgc10P5U3LL6yMUx+SqcaPKWLPZY7DqdNn01f16WQXLFm2X
         iNuA86jKPLLrCyLEuZoC6QLmkffXR1YQpPAavXGwqc0QBUkX0oPeWk22E3LR0PIVMmAD
         SQ+8aZ6oZ6jerIMCA9h+bDuDGDuXV9t7sb2bFuHakDxM9c24nsaO2U3xPk66tNqNOZQI
         1JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=GLtUQay0Jz5XCFvG0wpPVlDUiFUuJN9wSLCgiMgA340=;
        b=TT0fkm5YrbtqD1YYYiW1Wqwc4Mod8lANJQ/7rJqlvoDWUkoWEO4uqI+PUIwQxG35kC
         9MnpWDIyUrSwPJ06r6tFM1k31UkTdrEqrL4iro9rCOQAI5/3KtWEslYbUDV7OAvI2pPq
         LBiAyJpM82Ibj3Y6A7r/zEIe7cjSTLQ77+WGmOBmctUnW4Vl9PXjtC0WrCVn889xVTOo
         3ElfYboKmgl88eQpz0fItFa55JarmIvQbvi4szSHzl/WJ8jB7K9cRXEO02D2UxC9fpWr
         EnUt2wiOkTR/804gpBtrVW7AwdN3Y+jYZ3kwG7W9pjXeVVV7dhl7ikg9cdOif1pptAMX
         m/jw==
X-Gm-Message-State: AOAM533RulAo5DzYt880ogv7b1GuQ/1YvI3I0dI7Ni6cu+El+Ffnk9US
        PLaEaPhITgzutlm1kku+qVdrkQ==
X-Google-Smtp-Source: ABdhPJyXKpgNDYBHDZJYzeiQInmpo4RkTS3uQ4V5pukFx+04eSE2fphlDz2zyunAKOAULp0oBXYmDw==
X-Received: by 2002:a63:e74b:: with SMTP id j11mr7989017pgk.322.1633754295243;
        Fri, 08 Oct 2021 21:38:15 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e14sm914125pga.23.2021.10.08.21.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 21:38:14 -0700 (PDT)
Date:   Fri, 08 Oct 2021 21:38:14 -0700 (PDT)
X-Google-Original-Date: Fri, 08 Oct 2021 21:37:58 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.15-rc5
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-26107d68-d2af-46eb-a8a4-43c1496a9ef4@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.15-rc5

for you to fetch changes up to 3ef6ca4f354c53abf263cbeb51e7272523c294d8:

  checksyscalls: Unconditionally ignore fstat{,at}64 (2021-10-07 17:16:28 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.15-rc5

* A pair of fixes (along with the necessary cleanup) to our VDSO, to
  avoid
* A fix to checksyscalls to teach it about our rv32 UABI.
* A fix to add clone3() to the rv32 UABI, which was pointed out by
  checksyscalls.
* A fix to properly flush the icache on the local CPU in addition to the
  remote CPUs.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Flush current cpu icache before other cpus

Palmer Dabbelt (4):
      Merge remote-tracking branch 'palmer/riscv-vdso-cleanup' into fixes
      RISC-V: Include clone3() on rv32
      Merge remote-tracking branch 'palmer/riscv-clone3' into fixes
      checksyscalls: Unconditionally ignore fstat{,at}64

Tong Tiangen (3):
      riscv/vdso: Refactor asm/vdso.h
      riscv/vdso: Move vdso data page up front
      riscv/vdso: make arch_setup_additional_pages wait for mmap_sem for write killable

 arch/riscv/include/asm/syscall.h     |  1 +
 arch/riscv/include/asm/vdso.h        | 18 ++++++++----
 arch/riscv/include/uapi/asm/unistd.h |  3 +-
 arch/riscv/kernel/syscall_table.c    |  1 -
 arch/riscv/kernel/vdso.c             | 53 ++++++++++++++++++++++--------------
 arch/riscv/kernel/vdso/vdso.lds.S    |  3 +-
 arch/riscv/mm/cacheflush.c           |  2 ++
 scripts/checksyscalls.sh             |  6 ++--
 8 files changed, 56 insertions(+), 31 deletions(-)
