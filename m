Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F446330006
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 11:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhCGKIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 05:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbhCGKHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 05:07:46 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D87C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 02:07:43 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e0ad:f3ab:30c0:d794])
        by xavier.telenet-ops.be with bizsmtp
        id dN7g240042RkFys01N7gaJ; Sun, 07 Mar 2021 11:07:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lIqK3-005hLv-LG; Sun, 07 Mar 2021 11:07:39 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lIqK3-008fhq-61; Sun, 07 Mar 2021 11:07:39 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for 5.12 (take two)
Date:   Sun,  7 Mar 2021 11:07:31 +0100
Message-Id: <20210307100731.2066899-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.12-tag2

for you to fetch changes up to a65a802aadba072ca7514fc0c301fd7fdc6fc6cb:

  m68k: Fix virt_addr_valid() W=1 compiler warnings (2021-03-06 14:15:07 +0100)

----------------------------------------------------------------
m68k updates for v5.12 (take two)

  - Fix virt_addr_valid() W=1 compiler warnings.

This is a single non-critical fix.  As the build bots are now testing
all new code with W=1, these warnings are popping up everywhere,
confusing people.  Hence I think it makes sense to silence it as soon as
possible.

Note that I have just rebased this single commit to v5.12-rc2, to avoid
the swapfile bug.  Should be safe, as this file has not been touched
since v5.11-rc1.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (1):
      m68k: Fix virt_addr_valid() W=1 compiler warnings

 arch/m68k/include/asm/page_mm.h | 2 +-
 arch/m68k/include/asm/page_no.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
