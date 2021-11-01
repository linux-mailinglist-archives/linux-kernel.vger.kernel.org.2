Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0550441E44
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhKAQgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhKAQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:36:42 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFE9C061766
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 09:34:07 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:5050:fce2:2424:248f])
        by michel.telenet-ops.be with bizsmtp
        id D4a42600G0xGf5L064a4Jx; Mon, 01 Nov 2021 17:34:06 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mhZsp-009XTD-2q; Mon, 01 Nov 2021 17:10:03 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mhWuy-00DRAe-U7; Mon, 01 Nov 2021 14:00:04 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v5.16
Date:   Mon,  1 Nov 2021 14:00:03 +0100
Message-Id: <20211101130003.3202665-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 9fde0348640252c79d462c4d29a09a14e8741f5c:

  m68k: Remove set_fs() (2021-09-24 13:35:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.16-tag1

for you to fetch changes up to 8a3c0a74ae87473589cb881a3854948d40000b7a:

  m68k: defconfig: Update defconfigs for v5.15-rc1 (2021-10-11 10:34:52 +0200)

----------------------------------------------------------------
m68k updates for v5.16

  - A small comma vs. semicolon cleanup,
  - Defconfig updates.

----------------------------------------------------------------
Geert Uytterhoeven (2):
      m68k: muldi3: Use semicolon instead of comma
      m68k: defconfig: Update defconfigs for v5.15-rc1

 arch/m68k/configs/amiga_defconfig    | 7 +++++--
 arch/m68k/configs/apollo_defconfig   | 7 +++++--
 arch/m68k/configs/atari_defconfig    | 7 +++++--
 arch/m68k/configs/bvme6000_defconfig | 7 +++++--
 arch/m68k/configs/hp300_defconfig    | 7 +++++--
 arch/m68k/configs/mac_defconfig      | 7 +++++--
 arch/m68k/configs/multi_defconfig    | 7 +++++--
 arch/m68k/configs/mvme147_defconfig  | 7 +++++--
 arch/m68k/configs/mvme16x_defconfig  | 7 +++++--
 arch/m68k/configs/q40_defconfig      | 7 +++++--
 arch/m68k/configs/sun3_defconfig     | 7 +++++--
 arch/m68k/configs/sun3x_defconfig    | 7 +++++--
 arch/m68k/lib/muldi3.c               | 2 +-
 13 files changed, 61 insertions(+), 25 deletions(-)

Thanks for pulling!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
