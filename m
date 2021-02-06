Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD191311FB8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 20:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhBFTjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 14:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBFTji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 14:39:38 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA7AC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 11:38:58 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id e9so5706215pjj.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 11:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=7BXX/4Me98TVm3aHXjBwYhyDEkhhQPgOFfGzdq2Cjnw=;
        b=bfkdVqO+z3QvLShD/21Y6pJq9xJSVPH2xzVgSYj91jQKpRuzBtLYp4ESeqreJyBknz
         InprVmPcxuVBCTQa2Z6JzOXr/j4O8qI/9a2JhUNuRXMt3TiT+xUYIxeAWGVhoSGvvTY8
         bxHkFAA7vA/SqOXswoZ8rFG8A6hPpa8pKzJs58mo0dnttP7scHCcFGcoqlxfeXjbXdlU
         8PcaVaDZMEbQlyY/yq+pVpbJdKXt3MOqcjsY33tV6Ww8lWLCz8vQ1aaLYvMQW7zc8VDX
         m0lp3YCq/h+OtzKImSnm65KA99o0Q8coDOfBFSwkskVz+cVBMfOSceQmZbNgeshvJJ5R
         hg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=7BXX/4Me98TVm3aHXjBwYhyDEkhhQPgOFfGzdq2Cjnw=;
        b=lxbZTkZf1eDuwdeX5q8mUZAmD55K3kWVbbGaxevYO9C+v3zq0cgVc3qm0CeZ0JIbry
         PSDKuQDrTSyJv0D0iaKKp7AHYGpOyunobKrlZP29vx3a3ia9j//Py0gcn2sDFtiu5iAI
         KJP/qSipr3iTqoHNQSEUnYsrToDlVMww+B3HbigRtnX+YpU7Cs7Fx29BeC8I+bcdMVwj
         V5AsHrxm5pLtpqzHVIWx3BnxpgiVXsZS7AeYCGPWqDI1AHT/rZsW3JDDSdV5JTxRnenV
         FkpQ5P+dyjRJos22ntCH2ZJPDP0vkvtcgZXI/CCn/DGJWRFoDNE+9tgqIaKgU6e23z77
         2ATA==
X-Gm-Message-State: AOAM532EN0r6LzE33XvuF/Q65/DpWC9iFVhDBMTSFsxlfUmHbV+qxG4G
        veKuyFyM3t6MvGFkCiZ44LZk8150oZLy8J7l
X-Google-Smtp-Source: ABdhPJzDZLgMtoCGtXSeAZLnBcH3G2E+Ut6kGcPFeE5r3t7vnlVQ339UdIHjwojZKx8Tgy+HxpTkaw==
X-Received: by 2002:a17:902:47:b029:de:c58e:8257 with SMTP id 65-20020a1709020047b02900dec58e8257mr9617476pla.61.1612640337480;
        Sat, 06 Feb 2021 11:38:57 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b17sm14295662pfp.167.2021.02.06.11.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 11:38:56 -0800 (PST)
Date:   Sat, 06 Feb 2021 11:38:56 -0800 (PST)
X-Google-Original-Date: Sat, 06 Feb 2021 11:38:54 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 5.11-rc7
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-7c050ab0-3c41-4b21-b011-47b64a4b713e@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac:

  Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-rc7

for you to fetch changes up to de5f4b8f634beacf667e6eff334522601dd03b59:

  RISC-V: Define MAXPHYSMEM_1GB only for RV32 (2021-02-02 18:36:42 -0800)

----------------------------------------------------------------
RISC-V Fixes for 5.11-rc7

I have a handful of fixes for this week:

* A fix to avoid evalating the VA twice in virt_addr_valid, which fixes
  some WARNs under DEBUG_VIRTUAL.
* Two fixes related to STRICT_KERNEL_RWX: one that fixes some
  permissions when strict is disabled, and one to fix some alignment
  issues when strict is enabled.
* A fix to disallow the selection of MAXPHYSMEM_2GB on RV32, which isn't
  valid any more but may still show up in some oldconfigs.

We still have the HiFive Unleashed ethernet phy reset regression, so
there will likely be something coming next week.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: virt_addr_valid must check the address belongs to linear mapping

Atish Patra (2):
      RISC-V: Fix .init section permission update
      RISC-V: Define MAXPHYSMEM_1GB only for RV32

Sebastien Van Cauwenberghe (1):
      riscv: Align on L1_CACHE_BYTES when STRICT_KERNEL_RWX

 arch/riscv/Kconfig                  | 2 ++
 arch/riscv/include/asm/page.h       | 5 ++++-
 arch/riscv/include/asm/set_memory.h | 6 +++---
 arch/riscv/kernel/setup.c           | 4 +++-
 4 files changed, 12 insertions(+), 5 deletions(-)
