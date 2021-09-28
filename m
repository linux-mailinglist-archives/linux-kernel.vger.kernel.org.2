Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8400C41B175
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbhI1OCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240898AbhI1OCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:02:04 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C11C061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:00:24 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:9d6a:ba71:99b4:9160])
        by albert.telenet-ops.be with bizsmtp
        id zS0M250034bPoua06S0MA4; Tue, 28 Sep 2021 16:00:21 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mVDef-000LNP-3P; Tue, 28 Sep 2021 16:00:21 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mVDee-00AFEY-Jf; Tue, 28 Sep 2021 16:00:20 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v5.15 (take three)
Date:   Tue, 28 Sep 2021 16:00:18 +0200
Message-Id: <20210928140018.2441795-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit a7b68ed15d1fd72c1e451d5eb6edebee2a624b90:

  m68k: mvme: Remove overdue #warnings in RTC handling (2021-09-13 11:19:05 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.15-tag3

for you to fetch changes up to 9fde0348640252c79d462c4d29a09a14e8741f5c:

  m68k: Remove set_fs() (2021-09-24 13:35:07 +0200)

----------------------------------------------------------------
m68k updates for v5.15 (take three)

  - Signal handling fixes,
  - Removal of set_fs().

Thanks for pulling!

----------------------------------------------------------------
Al Viro (3):
      m68k: Handle arrivals of multiple signals correctly
      m68k: Update ->thread.esp0 before calling syscall_trace() in ret_from_signal
      m68k: Leave stack mangling to asm wrapper of sigreturn()

Christoph Hellwig (6):
      m68k: Document that access_ok is broken for !CONFIG_CPU_HAS_ADDRESS_SPACES
      m68k: Remove the 030 case in virt_to_phys_slow
      m68k: Use BUILD_BUG for passing invalid sizes to get_user/put_user
      m68k: Factor the 8-byte lowlevel {get,put}_user code into helpers
      m68k: Provide __{get,put}_kernel_nofault
      m68k: Remove set_fs()

 arch/m68k/68000/entry.S             |   4 -
 arch/m68k/Kconfig                   |   1 -
 arch/m68k/coldfire/entry.S          |   4 -
 arch/m68k/include/asm/processor.h   |  31 +++++-
 arch/m68k/include/asm/segment.h     |  59 ----------
 arch/m68k/include/asm/thread_info.h |   3 -
 arch/m68k/include/asm/tlbflush.h    |  11 +-
 arch/m68k/include/asm/traps.h       |   4 +
 arch/m68k/include/asm/uaccess.h     | 215 +++++++++++++++++++++++-------------
 arch/m68k/kernel/asm-offsets.c      |   2 +-
 arch/m68k/kernel/entry.S            |  58 +++++-----
 arch/m68k/kernel/process.c          |   4 +-
 arch/m68k/kernel/signal.c           | 199 ++++++++++++++-------------------
 arch/m68k/kernel/traps.c            |  13 +--
 arch/m68k/mac/misc.c                |   1 -
 arch/m68k/mm/cache.c                |  25 +----
 arch/m68k/mm/init.c                 |   6 -
 arch/m68k/mm/kmap.c                 |   1 -
 arch/m68k/mm/memory.c               |   1 -
 arch/m68k/mm/motorola.c             |   2 +-
 arch/m68k/sun3/config.c             |   3 +-
 arch/m68k/sun3/mmu_emu.c            |   6 +-
 arch/m68k/sun3/sun3ints.c           |   1 -
 arch/m68k/sun3x/prom.c              |   1 -
 24 files changed, 301 insertions(+), 354 deletions(-)
 delete mode 100644 arch/m68k/include/asm/segment.h

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
