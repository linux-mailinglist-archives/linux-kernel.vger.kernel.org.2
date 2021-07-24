Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15ADC3D49F1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 22:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGXUDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 16:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGXUDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 16:03:33 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91353C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:44:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m1so7302220pjv.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=fHIy9lbXbq0EmnYScsYc3vFgkMSvcm99KjgBrTvkyn0=;
        b=H3CGoVuCtjdwfAW606o7bV2y2BhORwoA13jObogqQSfUDRtr5fwzf/E+TmEpIIIgRZ
         ra3maKZ2KdoWHuQ57W3xIdeMipuGk27jYJz34mIkmZ/g7riZCHCYIEWg5K+2DKoF+o5T
         QvozPGtsBbJFY5zHfphpELhtamu0wkNyPHvMu+WgDPDo0HKrecpU/HQjIH8DYHpOmk2u
         dTJfNnYMusS3I7pasRuG/tcxgJl68WYjDmkkPKZjSw9Z8kKe1qHbv36xDnWyDQNQtXGd
         TGlo8zNCSXwX9FY2Hu+FQPPRRXp6nF5X104oficHDKMphOm7L9PQhNbJAyp190DKS/+M
         IgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=fHIy9lbXbq0EmnYScsYc3vFgkMSvcm99KjgBrTvkyn0=;
        b=iiBSOzBOKWF3cy67d1DHSkC+1f7Pa/omR0s2tPaVPTnTxQeXKBEjgCeHiBHIRk7Jhz
         myKvu0PA8bYEyIh0OKz0aQah5+LnqJlDjOwq/4/H79EJXw/YWP0KNbVet9yWzfwExZYz
         qnfbKlfto26hOdBEyVE5ACvGhkQtSZG2fP1EpVk8hlpcwWUhiDzMZoCAlQGLP5Y5n95u
         4cg7ho3DYZOCcacZ9BsvM/u3rpm8Qg/0SfxUzttTIu2dEkPQXw+LfH8dIWcIrxcaL1nX
         aoMZKpoZBXP8Y2riHWwBo0dgFNXeKcBG98Ec/VNyKUrnz5VxvfD0k3kxEZyrkobTDcNe
         R5Dg==
X-Gm-Message-State: AOAM532IAMdebSxaCM/ckzr5zQvY5HN5GWSsYtz3ETOQDNT76CcOaJC1
        2kTYRakdYLDdRbTKG/UD7Xq4mA==
X-Google-Smtp-Source: ABdhPJxkRP8dTyMihWOc+yCMatwPIuV/OqQ1vH8UmPqXdst02KAcWYVEld4KGK6M5R87WuR98uUuHg==
X-Received: by 2002:a17:90a:de11:: with SMTP id m17mr9949261pjv.5.1627159442791;
        Sat, 24 Jul 2021 13:44:02 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d9sm30976770pgm.89.2021.07.24.13.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 13:44:02 -0700 (PDT)
Date:   Sat, 24 Jul 2021 13:44:02 -0700 (PDT)
X-Google-Original-Date: Sat, 24 Jul 2021 13:43:59 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.13-rc3
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-5cd676be-7ed7-48de-b740-0e809ae67a56@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-rc3

for you to fetch changes up to ea196c548c0ac407afd31d142712b6da8bd00244:

  riscv: __asm_copy_to-from_user: Fix: Typos in comments (2021-07-23 17:49:12 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.13-rc3

* A fix to properly set the memory size, which fixes 32-bit systems.
* A fix to allow the initrd to load anywhere in memory, rather that
  restricting it to the first 256MiB.
* A fix for the mem= parameter on 64-bit systems, to properly account
  for the maximum supported memory now that the kernel is outside the
  linear map.
* A fix to avoid installing mappings into the last 4KiB of memory, which
  conflicts with error values.
* A fix to avoid the stack from being freed while it is being walked.
* A handful of fixes to the new copy to/from user routines.
---
There is one particularly odd bit in the history here: the fix for the 32-bit
boot failure is based on an older release, because a recent feature addition
also fixed the bug.  I wanted to take that patch so it could be backported to
stable, but it's erased by its own merge.  Not sure if there's a better way to
do this, but I figured this was saner than reverting the feature and then
bringing it back.

----------------------------------------------------------------
Akira Tsukamoto (4):
      riscv: __asm_copy_to-from_user: Fix: overrun copy
      riscv: __asm_copy_to-from_user: Fix: fail on RV32
      riscv: __asm_copy_to-from_user: Remove unnecessary size check
      riscv: __asm_copy_to-from_user: Fix: Typos in comments

Alexandre Ghiti (3):
      riscv: Fix memory_limit for 64-bit kernel
      riscv: Make sure the linear mapping does not use the kernel mapping
      riscv: Make sure the kernel mapping does not overlap with IS_ERR_VALUE

Bin Meng (1):
      riscv: Fix 32-bit RISC-V boot failure

Heinrich Schuchardt (1):
      RISC-V: load initrd wherever it fits into memory

Jisheng Zhang (1):
      riscv: stacktrace: pin the task's stack in get_wchan

Palmer Dabbelt (1):
      Merge remote-tracking branch 'riscv/riscv-fix-32bit' into fixes

 arch/riscv/include/asm/efi.h   |  4 ++--
 arch/riscv/kernel/stacktrace.c |  6 +++++-
 arch/riscv/lib/uaccess.S       | 27 +++++++++++++--------------
 arch/riscv/mm/init.c           | 32 ++++++++++++++++++++++++++++----
 4 files changed, 48 insertions(+), 21 deletions(-)
