Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647473269C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBZV5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhBZV5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:57:02 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D03C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:56:22 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id a4so6992062pgc.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=TOgfz0riGvw5VOf7q3sDXBxBiqhLDvuVsPPmymjAGUM=;
        b=WzGywr/MD4O5LnuRwrOgDak6irups+h9PTBHytDpvIJaY+UG+y7KB+qhEjflOR997n
         G3Xcpb8P9nWyGfExhyJJWMM47qulCQHpQBVfBNQlXJBFmcS18ywvIN/xu2sse0PmZ2QE
         4/9xC3FfguVVlCZszmhI8eMja66lJyjzK1bSeq6sZoeyBeYL5qG0bfja25K3J+4A4dqg
         PG3t+Gn9j9Ga5wnUhw/HRuZCokYP2oY9dZE089tRWYb/6JK/lLmaK9Pobam0QAwuVFTF
         iqiyDz367Hfy8oNo3qiEZcywCI/P+Y28DCzQwKor0p/X7qjUokKqiSGYgYSoBukLqDov
         koVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TOgfz0riGvw5VOf7q3sDXBxBiqhLDvuVsPPmymjAGUM=;
        b=rl2F6WRwlPlNVtg/kwtAS6jUXyPZ2hC6FVuOWb8Br1LZ9Zb6hd6IBQFpjs2uESYhEO
         pm6RCP0dOuACQ8byrP/rOh3injjlxvOSYnhNZB5mVSv54vX4RP6bcJv0VKL+nsbiZkov
         vZpfz1wvrFqfYZGpVwGd21Cg4dTB/OcOxmzzzFhcPJsEVg0etU5HPBrR2SkuITf0gPg5
         /m4AI49y9kBquJp9HZi5Auj5BI+l1U4KbNJWhfnKFMB7UBKiGF86suChwOxyDI2D5XSy
         JB4MVjqbOeryS5aqRFuytRQ354lKtk60EE6K+wcq8CazC0oWhi1K6XCc9ZLKgs5QP+Fq
         SWvQ==
X-Gm-Message-State: AOAM533ikFh1WWiX3oudu18dhwTsa2KjiI2yTI2hWKciFLtwcUDOzLH+
        9Hv+pdfc+MS3F7h5svZcTiUXXOe9rRA=
X-Google-Smtp-Source: ABdhPJxHZyERE4Ps9beeGxhXgs8x7TRRZ4L43bxD+rAwCR/DTOwe81+39rorJVCda7+GqUDsW8yt2Q==
X-Received: by 2002:a62:2:0:b029:1ed:6304:17d7 with SMTP id 2-20020a6200020000b02901ed630417d7mr5171855pfa.58.1614376582324;
        Fri, 26 Feb 2021 13:56:22 -0800 (PST)
Received: from localhost (g98.115-65-200.ppp.wakwak.ne.jp. [115.65.200.98])
        by smtp.gmail.com with ESMTPSA id c4sm3302315pfo.2.2021.02.26.13.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 13:56:21 -0800 (PST)
Date:   Sat, 27 Feb 2021 06:56:19 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Subject: [GIT PULL] OpenRISC updates for 5.12
Message-ID: <20210226215619.GC365039@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider for pull.

Note the starting point shows up a bit strange as I had to merge in 5.11 fixes
to resolve some conflicts pointed out by linux-next.  The below are the changes
since v5.11.

The following changes since commit 031c7a8cd6fc565e90320bf08f22ee6e70f9d969:

  openrisc: io: Add missing __iomem annotation to iounmap() (2021-01-20 06:14:26 +0900)

are available in the Git repository at:

  git@github.com:openrisc/linux.git tags/for-linus

for you to fetch changes up to 8f722f67452f4b28cd8d7acf1658daa5796437c2:

  openrisc: Use devicetree to determine present cpus (2021-02-09 05:38:50 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.12

Include:
 - Update for Litex SoC controller to support wider width registers as
   well as reset.
 - Refactor SMP code to use device tree to define possible cpus.
 - Updates build including generating vmlinux.bin

----------------------------------------------------------------
Gabriel Somlo (5):
      drivers/soc/litex: move generic accessors to litex.h
      drivers/soc/litex: separate MMIO from subregister offset calculation
      drivers/soc/litex: s/LITEX_REG_SIZE/LITEX_SUBREG_ALIGN/g
      drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs
      drivers/soc/litex: make 'litex_[set|get]_reg()' methods private

Geert Uytterhoeven (1):
      drivers/soc/litex: Add restart handler

Jan Henrik Weinstock (1):
      openrisc: Use devicetree to determine present cpus

Joel Stanley (2):
      openrisc: Add vmlinux.bin target
      openrisc: restart: Call common handlers before hanging

Masahiro Yamada (1):
      openrisc: add arch/openrisc/Kbuild

Stafford Horne (1):
      Merge remote-tracking branch 'openrisc/or1k-5.11-fixes' into or1k-5.12-updates

 arch/openrisc/Kbuild               |   3 +
 arch/openrisc/Makefile             |  21 +++---
 arch/openrisc/boot/.gitignore      |   2 +
 arch/openrisc/boot/Makefile        |  10 +++
 arch/openrisc/kernel/process.c     |  13 +++-
 arch/openrisc/kernel/smp.c         |  23 ++++--
 drivers/soc/litex/Kconfig          |  14 +++-
 drivers/soc/litex/litex_soc_ctrl.c | 116 +++++++++++-----------------
 include/linux/litex.h              | 150 +++++++++++++++++++++++++------------
 9 files changed, 211 insertions(+), 141 deletions(-)
 create mode 100644 arch/openrisc/Kbuild
 create mode 100644 arch/openrisc/boot/.gitignore
 create mode 100644 arch/openrisc/boot/Makefile
