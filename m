Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD336F0A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhD2TfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 15:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhD2TfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 15:35:19 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204E3C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 12:34:31 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id m7so67022406ljp.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tyNtVUM7TJO4Y2MIU/RlvtsyLuW2eANi7CNPOMUEFlg=;
        b=TZoYPuAmO/+Eys0DIlZP56S2yT2i4l3DhcNwzaQGQTawDgk7G6qh1j7xZGAIoT4nZe
         B3x3eRmEslzz2JzVO9kT+DYkmFpU+zZaqoB/KewKy0wtMW/68bupWPL/flaOAHhzk1ms
         0R/qad6A4PVv/AsmLsDSBMJTu5WSXL82mIdDIHp/RWbXeWSb96JNPDVoxeCGHDn1h912
         tnud2eA0UGjiVj0wK67iFIySHBHJ4G6ssv3KwK2jhqZ+D9J+wwIzmNNxYRzHx+rWMZkO
         TYv9cFNTYVK3bMG6G9rhEaoPhro/6vFVwO0LVGscDQ1Ic4/eB3NZoUtgG7GRdQ4eNkT9
         CUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tyNtVUM7TJO4Y2MIU/RlvtsyLuW2eANi7CNPOMUEFlg=;
        b=ANFolQbns/lSh0H3KW0pG8+IV3wmZXpFFVri1faU+xxr3K65y4cwXbbI2sRtTfW6Vm
         7YiI9FraB8MG4vSAdQd4BmlddjiHVLtglcGFevmQMqZRsUziqGJzsPjFF2IvbRZSoZrZ
         bvd1zm79bO3a6RVv1ticonfu4dEgpYQtuseHnfUIfH/PVRA3ZOcerEDWd+aLxMATqAEF
         WpipBiyblXsS8xpFPluR5RzCOUJN5BnkwdftgvyjWB/arAkmUCcHjtCsFHewoSoV2Q8h
         yLK7QEWUEKrLZahggdnPa7dl1UnumILKPm68Vmt345ODvaO2NN3DwTqfALNA4v5N+7iy
         ROhA==
X-Gm-Message-State: AOAM5305s7csIg9c+3nREgv2CHe96HN8q/zcuvwVujVC2zYb5ENmpAJT
        tND4rVFNXgBZQ5AgYnf/Fg8=
X-Google-Smtp-Source: ABdhPJwVRxrXaamHuNvA2Ya+4m3QmjCouVYhaILSlVT7zreoNg1+DdqDUqtkhz7HfzE0hgJGE3s2Qw==
X-Received: by 2002:a2e:a793:: with SMTP id c19mr965247ljf.75.1619724869694;
        Thu, 29 Apr 2021 12:34:29 -0700 (PDT)
Received: from octofox.metropolis ([5.18.202.173])
        by smtp.gmail.com with ESMTPSA id t14sm597465ljk.107.2021.04.29.12.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 12:34:29 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 00/14] xtensa updates for v5.13
Date:   Thu, 29 Apr 2021 12:34:06 -0700
Message-Id: <20210429193406.12947-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following Xtensa architecture updates for v5.13:

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20210429

for you to fetch changes up to 6a8eb99e130f3f7658de2776934374fe1c41279e:

  xtensa: ISS: add GDBIO implementation to semihosting interface (2021-04-04 15:39:04 -0700)

----------------------------------------------------------------
Xtensa updates for v5.13:

- switch to generic syscall generation scripts
- new GDBIO implementation for xtensa semihosting interface
- various small code fixes and cleanups
- a few typo fixes in comments and Kconfig help text

----------------------------------------------------------------
Bhaskar Chowdhury (2):
      xtensa: Couple of typo fixes
      xtensa: simcall.h: Change compitible to compatible

Colin Ian King (1):
      xtensa: fix spelling mistake in Kconfig "wont" -> "won't"

Jiapeng Chong (1):
      xtensa: fix warning comparing pointer to 0

Masahiro Yamada (5):
      xtensa: move CONFIG_CPU_*_ENDIAN defines to Kconfig
      xtensa: remove unneeded export in boot-elf/Makefile
      xtensa: stop filling syscall array with sys_ni_syscall
      xtensa: syscalls: switch to generic syscalltbl.sh
      xtensa: syscalls: switch to generic syscallhdr.sh

Max Filippov (5):
      xtensa: simplify coherent_kvaddr logic
      xtensa: fix pgprot_noncached assumptions
      xtensa: drop extraneous register load from initialize_mmu
      xtensa: ISS: split simcall implementation from semihosting interface
      xtensa: ISS: add GDBIO implementation to semihosting interface

 arch/xtensa/Kconfig                                |  30 +++++-
 arch/xtensa/Makefile                               |   9 +-
 arch/xtensa/boot/Makefile                          |   4 -
 arch/xtensa/boot/boot-elf/Makefile                 |  11 +--
 arch/xtensa/boot/boot-redboot/Makefile             |   6 +-
 arch/xtensa/include/asm/initialize_mmu.h           |   2 +-
 arch/xtensa/include/asm/pgtable.h                  |   4 +-
 arch/xtensa/kernel/head.S                          |   4 +-
 arch/xtensa/kernel/pci.c                           |   2 +-
 arch/xtensa/kernel/syscall.c                       |   8 +-
 arch/xtensa/kernel/syscalls/Makefile               |  14 +--
 arch/xtensa/kernel/syscalls/syscallhdr.sh          |  36 -------
 arch/xtensa/kernel/syscalls/syscalltbl.sh          |  32 -------
 arch/xtensa/mm/cache.c                             |   9 +-
 arch/xtensa/mm/misc.S                              |  36 +------
 .../platforms/iss/include/platform/simcall-gdbio.h |  34 +++++++
 .../platforms/iss/include/platform/simcall-iss.h   |  73 +++++++++++++++
 .../platforms/iss/include/platform/simcall.h       | 104 ++++++++-------------
 18 files changed, 198 insertions(+), 220 deletions(-)
 delete mode 100644 arch/xtensa/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/xtensa/kernel/syscalls/syscalltbl.sh
 create mode 100644 arch/xtensa/platforms/iss/include/platform/simcall-gdbio.h
 create mode 100644 arch/xtensa/platforms/iss/include/platform/simcall-iss.h

 -- 
 Thanks.
 -- Max
