Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B9940D37A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhIPGy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbhIPGy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:54:27 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB2CC061764
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:53:06 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:39fa:3565:945d:98f4])
        by baptiste.telenet-ops.be with bizsmtp
        id uWt32500M3mHZPk01Wt3YJ; Thu, 16 Sep 2021 08:53:04 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQlGZ-0052Oc-C1; Thu, 16 Sep 2021 08:53:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mQlGY-003Fii-PN; Thu, 16 Sep 2021 08:53:02 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v5.15 (take two)
Date:   Thu, 16 Sep 2021 08:52:57 +0200
Message-Id: <20210916065257.775368-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.15-tag2

for you to fetch changes up to a7b68ed15d1fd72c1e451d5eb6edebee2a624b90:

  m68k: mvme: Remove overdue #warnings in RTC handling (2021-09-13 11:19:05 +0200)

----------------------------------------------------------------
m68k updates for v5.15 (take two)

  - Warning fixes to mitigate CONFIG_WERROR=y.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (1):
      m68k: mvme: Remove overdue #warnings in RTC handling

Guenter Roeck (1):
      m68k: Double cast io functions to unsigned long

 arch/m68k/include/asm/raw_io.h | 20 ++++++++++----------
 arch/m68k/mvme147/config.c     |  4 +++-
 arch/m68k/mvme16x/config.c     |  4 +++-
 3 files changed, 16 insertions(+), 12 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
