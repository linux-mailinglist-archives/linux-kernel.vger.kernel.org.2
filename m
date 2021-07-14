Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9B23C825C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbhGNKHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbhGNKHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:07:06 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A843EC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 03:04:14 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:39cc:190a:2775:cfe7])
        by michel.telenet-ops.be with bizsmtp
        id Uy4D250041ccfby06y4DSt; Wed, 14 Jul 2021 12:04:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3bkS-0016Ee-SU; Wed, 14 Jul 2021 12:04:12 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3bkS-00A4Jw-AU; Wed, 14 Jul 2021 12:04:12 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/3] Remove checks for gcc < 4
Date:   Wed, 14 Jul 2021 12:04:07 +0200
Message-Id: <cover.1626256876.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch removes the few remaining checks for gcc < 4, which is no
longer supported for building the kernel.

All three patches can be applied independently.

Changes compared to v1:
  - Add Acked-by,
  - Drop applied patch.

Thanks!

Geert Uytterhoeven (3):
  ARM: div64: Remove always-true __div64_const32_is_OK() duplicate
  ARM: unified: Remove check for gcc < 4
  asm-generic: div64: Remove always-true __div64_const32_is_OK()

 arch/arm/include/asm/div64.h   | 11 -----------
 arch/arm/include/asm/unified.h |  4 ----
 include/asm-generic/div64.h    | 14 ++++----------
 3 files changed, 4 insertions(+), 25 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
