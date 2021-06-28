Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D843B5C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 12:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhF1KN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 06:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbhF1KN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 06:13:27 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F441C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 03:11:02 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e463:9bf2:1db6:b482])
        by albert.telenet-ops.be with bizsmtp
        id NaAy2500W4LH09C06aAy7a; Mon, 28 Jun 2021 12:10:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lxoEE-004YF8-Au; Mon, 28 Jun 2021 12:10:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lxoED-00EeO0-Og; Mon, 28 Jun 2021 12:10:57 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for 5.14
Date:   Mon, 28 Jun 2021 12:10:33 +0200
Message-Id: <20210628101033.3491773-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.14-tag1

for you to fetch changes up to c1367ee016e3550745315fb9a2dd1e4ce02cdcf6:

  m68k: atari: Fix ATARI_KBD_CORE kconfig unmet dependency warning (2021-06-07 16:28:51 +0200)

----------------------------------------------------------------
m68k updates for v5.14

  - Update Finn's email address in MAINTAINERS,
  - Defconfig updates,
  - Minor fixes and improvements.

Thanks for pulling!

----------------------------------------------------------------
Finn Thain (2):
      m68k: Drop -fno-strength-reduce from KBUILD_CFLAGS
      MAINTAINERS, .mailmap: Update Finn Thain's email address

Geert Uytterhoeven (1):
      m68k: defconfig: Update defconfigs for v5.13-rc1

Randy Dunlap (1):
      m68k: atari: Fix ATARI_KBD_CORE kconfig unmet dependency warning

Wan Jiabing (1):
      m68k: dma: Remove unnecessary include of asm/cacheflush.h

 .mailmap                             | 1 +
 MAINTAINERS                          | 4 ++--
 arch/m68k/Kconfig.machine            | 3 +++
 arch/m68k/Makefile                   | 3 +--
 arch/m68k/configs/amiga_defconfig    | 5 +++--
 arch/m68k/configs/apollo_defconfig   | 5 +++--
 arch/m68k/configs/atari_defconfig    | 5 +++--
 arch/m68k/configs/bvme6000_defconfig | 5 +++--
 arch/m68k/configs/hp300_defconfig    | 5 +++--
 arch/m68k/configs/mac_defconfig      | 5 +++--
 arch/m68k/configs/multi_defconfig    | 5 +++--
 arch/m68k/configs/mvme147_defconfig  | 5 +++--
 arch/m68k/configs/mvme16x_defconfig  | 5 +++--
 arch/m68k/configs/q40_defconfig      | 5 +++--
 arch/m68k/configs/sun3_defconfig     | 5 +++--
 arch/m68k/configs/sun3x_defconfig    | 5 +++--
 arch/m68k/kernel/dma.c               | 3 ---
 drivers/input/keyboard/Kconfig       | 3 ---
 18 files changed, 43 insertions(+), 34 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
