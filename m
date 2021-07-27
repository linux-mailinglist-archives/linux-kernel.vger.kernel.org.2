Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591883D777F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbhG0Ntu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbhG0Ntj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:49:39 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C71C0619E0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:47:38 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:b0a9:7e88:5ca4:551a])
        by xavier.telenet-ops.be with bizsmtp
        id aDnb250021fSPfK01Dnbz1; Tue, 27 Jul 2021 15:47:37 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m8NQk-001Pbz-Ll; Tue, 27 Jul 2021 15:47:34 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m8NQk-00Fnh8-9y; Tue, 27 Jul 2021 15:47:34 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Sam Ravnborg <sam@ravnborg.org>, Maxime Ripard <mripard@kernel.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 0/5] video: fbdev: ssd1307fb: Optimizations and improvements
Date:   Tue, 27 Jul 2021 15:47:25 +0200
Message-Id: <20210727134730.3765898-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series optimizes console operations on ssd1307fb, after the
customary fixes and cleanups.

Currently, each screen update triggers an I2C transfer of all screen
data, up to 1 KiB of data for a 128x64 display, which takes at least 20
ms in Fast mode.  While many displays are smaller, and thus require less
data to be transferred, 20 ms is still an optimistic value, as the
actual data transfer may be much slower, especially on bitbanged I2C
drivers.  After this series, the amount of data transfer is reduced, as
fillrect, copyarea, and imageblit only update the rectangle that
changed.

Changes compared to v1[1]:
  - Add Acked-by,
  - Use two separate helpers instead of a single combined helper,
  - Reorder operands in DIV_ROUND_UP() to improve readability.

This has been tested on an Adafruit FeatherWing OLED with an SSD1306
controller and a 128x32 OLED, connected to an OrangeCrab ECP5 FPGA board
running a 64 MHz VexRiscv RISC-V softcore, where it reduced the CPU
usage for blinking the cursor from more than 70% to ca. 10%.

Thanks for applying!

[1] https://lore.kernel.org/dri-devel/20210714145804.2530727-1-geert@linux-m68k.org

Geert Uytterhoeven (5):
  video: fbdev: ssd1307fb: Propagate errors via
    ssd1307fb_update_display()
  video: fbdev: ssd1307fb: Simplify ssd1307fb_update_display()
  video: fbdev: ssd1307fb: Extract ssd1307fb_set_{col,page}_range()
  video: fbdev: ssd1307fb: Optimize screen updates
  video: fbdev: ssd1307fb: Cache address ranges

 drivers/video/fbdev/ssd1307fb.c | 151 ++++++++++++++++++++++----------
 1 file changed, 104 insertions(+), 47 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
