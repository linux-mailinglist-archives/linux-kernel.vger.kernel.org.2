Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E1136B017
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhDZI71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhDZI7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:59:23 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785DBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 01:58:42 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:2da6:a4cf:424d:1343])
        by xavier.telenet-ops.be with bizsmtp
        id xLyg240081UBnF701LygM4; Mon, 26 Apr 2021 10:58:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lax4h-000bfj-OW; Mon, 26 Apr 2021 10:58:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lax4h-005BN9-3G; Mon, 26 Apr 2021 10:58:39 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for 5.13
Date:   Mon, 26 Apr 2021 10:58:37 +0200
Message-Id: <20210426085837.1235312-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit a65a802aadba072ca7514fc0c301fd7fdc6fc6cb:

  m68k: Fix virt_addr_valid() W=1 compiler warnings (2021-03-06 14:15:07 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.13-tag1

for you to fetch changes up to 34e5269bf987aff9a33ad3ab4f5d65c02913cbc1:

  m68k: sun3x: Remove unneeded semicolon (2021-04-19 12:11:55 +0200)

----------------------------------------------------------------
m68k updates for v5.13 (take one)

  - Fix flatmem setup for platforms where RAM starts at a non-zero
    address,
  - Defconfig updates,
  - Use common scripts for syscall table and header generation,
  - Fix timers on MVME platforms,
  - Fix lock imbalance in cacheflush syscall,
  - Minor fixes and improvements.

Note that the first commit is a duplicate of a commit already in
v5.12-rc8.  When I committed it, it was not clear that fix would make
v512 through the m68knommu tree, and it had just been discovered the bug
it fixes affects m68k-with-mmu too.

Thanks for pulling!

----------------------------------------------------------------
Angelo Dureghello (1):
      m68k: mm: Fix flatmem memory model setup

Finn Thain (1):
      m68k: mvme147,mvme16x: Don't wipe PCC timer config bits

Geert Uytterhoeven (1):
      m68k: defconfig: Update defconfigs for v5.12-rc1

Liam Howlett (1):
      m68k: Add missing mmap_read_lock() to sys_cacheflush()

Masahiro Yamada (4):
      m68k: syscalls: switch to generic syscalltbl.sh
      m68k: syscalls: switch to generic syscallhdr.sh
      m68k: fpsp040: Remove meaningless $(OS_OBJS)
      m68k: fpsp040,ifpsp060: Remove meaningless EXTRA_LDFLAGS

Wan Jiabing (1):
      m68k: sun3x: Remove unneeded semicolon

 arch/m68k/configs/amiga_defconfig       |  5 -----
 arch/m68k/configs/apollo_defconfig      |  5 -----
 arch/m68k/configs/atari_defconfig       |  5 -----
 arch/m68k/configs/bvme6000_defconfig    |  5 -----
 arch/m68k/configs/hp300_defconfig       |  5 -----
 arch/m68k/configs/mac_defconfig         |  5 -----
 arch/m68k/configs/multi_defconfig       |  5 -----
 arch/m68k/configs/mvme147_defconfig     |  5 -----
 arch/m68k/configs/mvme16x_defconfig     |  5 -----
 arch/m68k/configs/q40_defconfig         |  5 -----
 arch/m68k/configs/sun3_defconfig        |  5 -----
 arch/m68k/configs/sun3x_defconfig       |  5 -----
 arch/m68k/fpsp040/Makefile              |  4 ----
 arch/m68k/ifpsp060/Makefile             |  2 --
 arch/m68k/include/asm/mvme147hw.h       |  3 +++
 arch/m68k/include/asm/page_mm.h         |  2 +-
 arch/m68k/include/asm/sun3xflop.h       |  2 +-
 arch/m68k/kernel/sys_m68k.c             |  2 ++
 arch/m68k/kernel/syscalls/Makefile      | 14 ++++---------
 arch/m68k/kernel/syscalls/syscallhdr.sh | 36 ---------------------------------
 arch/m68k/kernel/syscalls/syscalltbl.sh | 32 -----------------------------
 arch/m68k/kernel/syscalltable.S         |  3 +--
 arch/m68k/mvme147/config.c              | 14 +++++++------
 arch/m68k/mvme16x/config.c              | 14 +++++++------
 24 files changed, 28 insertions(+), 160 deletions(-)
 delete mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
