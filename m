Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887FF3FB2FD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhH3JSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbhH3JSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:18:04 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2805EC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:17:10 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:99a5:7017:6f3e:f1d2])
        by xavier.telenet-ops.be with bizsmtp
        id nlH82500V30rvgn01lH8FE; Mon, 30 Aug 2021 11:17:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mKdPf-000UMV-LU; Mon, 30 Aug 2021 11:17:07 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mKdPf-007mWC-1i; Mon, 30 Aug 2021 11:17:07 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for 5.15
Date:   Mon, 30 Aug 2021 11:17:05 +0200
Message-Id: <20210830091705.1854757-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 21ed49265986931b8921a2404394426870245bd2:

  m68k: MAC should select HAVE_PATA_PLATFORM (2021-07-19 12:18:42 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.15-tag1

for you to fetch changes up to 87d93029fe83e326d5b906e12e95600b157d2c0d:

  m68k: Fix asm register constraints for atomic ops (2021-08-23 13:23:57 +0200)

----------------------------------------------------------------
m68k updates for v5.15

  - Miscellaneous fixes,
  - Defconfig updates.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (3):
      m68k: defconfig: Update defconfigs for v5.14-rc1
      m68k: Fix invalid RMW_INSNS on CPUs that lack CAS
      m68k: Fix asm register constraints for atomic ops

Pavel Skripkin (1):
      m68k: emu: Fix invalid free in nfeth_cleanup()

 arch/m68k/Kconfig.cpu                | 8 +++++++-
 arch/m68k/configs/amiga_defconfig    | 6 ++++--
 arch/m68k/configs/apollo_defconfig   | 4 +++-
 arch/m68k/configs/atari_defconfig    | 6 ++++--
 arch/m68k/configs/bvme6000_defconfig | 4 +++-
 arch/m68k/configs/hp300_defconfig    | 4 +++-
 arch/m68k/configs/mac_defconfig      | 6 ++++--
 arch/m68k/configs/multi_defconfig    | 6 ++++--
 arch/m68k/configs/mvme147_defconfig  | 4 +++-
 arch/m68k/configs/mvme16x_defconfig  | 4 +++-
 arch/m68k/configs/q40_defconfig      | 6 ++++--
 arch/m68k/configs/sun3_defconfig     | 4 +++-
 arch/m68k/configs/sun3x_defconfig    | 4 +++-
 arch/m68k/emu/nfeth.c                | 4 ++--
 arch/m68k/include/asm/atomic.h       | 4 ++--
 15 files changed, 52 insertions(+), 22 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
