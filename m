Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0108446E50
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 15:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhKFOao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 10:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233955AbhKFOan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 10:30:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5152F61037;
        Sat,  6 Nov 2021 14:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636208881;
        bh=wYtc58kRUhLg7EDpTeQ9X2xEDPDUyxJ1E7Gs7uPUKUw=;
        h=Date:From:To:Cc:Subject:From;
        b=ibt7g6eezZSM9SDfZQjcCWtWDBFE+JcTy2UeuMWpDZAW0FPKtlxNGsJ7ce1OLz+3y
         QRtX3aWAY0rNTcNK17Pbhdrm4wK9ErVKZkNy1RFRFRrsoliLgMvA2q+xQ4tkDl3o1V
         5oKVl68IZKF4I+YGKCDQvhpq3WfP2IU2PuNzr0jXHRylw1tovT20dW4jr8uSsvOdcC
         kvOaO6nYNDOdpC7WYPpUd/A8ghkeuYiAlqK8rlb5YoFjCzjztbg5NsUaFknWSvJg29
         GbFpsrtgGyzoRJfVPRgorujNSu5k1Iqj58RQPSRSbho9RpzJHPge8w0JaiwoQ0KIaS
         sbt/FpLO08E2g==
Date:   Sat, 6 Nov 2021 15:27:47 +0100
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mianhan Liu <liumh1@shanghaitech.edu.cn>,
        Huiquan Deng <denghuiquan@cdjrlc.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v5.16
Message-ID: <20211106142747.GA19096@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.16

for you to fetch changes up to 97fbb29fc1ebde6ce362e3d0a9473d4c6dec7442:

  MAINTAINERS: Add DT Bindings for Auxiliary Display Drivers (2021-10-22 00:21:33 +0200)

----------------------------------------------------------------
Auxdisplay improvements:

  - 4-digit 7-segment and quad alphanumeric display support for
    the ht16k33 driver, allowing the user to display and scroll
    text messages, from Geert Uytterhoeven.

  - An assortment of fixes and cleanups from Geert Uytterhoeven.

  - Header cleanups from Mianhan Liu.

  - Whitespace cleanup from Huiquan Deng.
----------------------------------------------------------------
Geert Uytterhoeven (22):
      uapi: Add <linux/map_to_14segment.h>
      dt-bindings: auxdisplay: ht16k33: Document Adafruit segment displays
      auxdisplay: img-ascii-lcd: Fix lock-up when displaying empty string
      auxdisplay: img-ascii-lcd: Add helper variable dev
      auxdisplay: img-ascii-lcd: Convert device attribute to sysfs_emit()
      auxdisplay: Extract character line display core support
      auxdisplay: linedisp: Use kmemdup_nul() helper
      auxdisplay: linedisp: Add support for changing scroll rate
      auxdisplay: ht16k33: Connect backlight to fbdev
      auxdisplay: ht16k33: Fix frame buffer device blanking
      auxdisplay: ht16k33: Use HT16K33_FB_SIZE in ht16k33_initialize()
      auxdisplay: ht16k33: Remove unneeded error check in keypad probe()
      auxdisplay: ht16k33: Convert to simple i2c probe function
      auxdisplay: ht16k33: Add helper variable dev
      auxdisplay: ht16k33: Move delayed work
      auxdisplay: ht16k33: Extract ht16k33_brightness_set()
      auxdisplay: ht16k33: Extract frame buffer probing
      auxdisplay: ht16k33: Add support for segment displays
      dt-bindings: auxdisplay: ht16k33: Document LED subnode
      auxdisplay: ht16k33: Add LED support
      auxdisplay: ht16k33: Make use of device properties
      MAINTAINERS: Add DT Bindings for Auxiliary Display Drivers

Huiquan Deng (1):
      auxdisplay: cfag12864bfb: code indent should use tabs where possible

Mianhan Liu (3):
      auxdisplay: cfag12864bfb: remove superfluous header files
      auxdisplay: ks0108: remove superfluous header files
      auxdisplay: ht16k33: remove superfluous header files

 .../bindings/auxdisplay/holtek,ht16k33.yaml        |  32 +-
 MAINTAINERS                                        |   1 +
 drivers/auxdisplay/Kconfig                         |  12 +-
 drivers/auxdisplay/Makefile                        |   1 +
 drivers/auxdisplay/cfag12864bfb.c                  |   9 +-
 drivers/auxdisplay/ht16k33.c                       | 501 ++++++++++++++++-----
 drivers/auxdisplay/img-ascii-lcd.c                 | 205 ++-------
 drivers/auxdisplay/ks0108.c                        |   3 -
 drivers/auxdisplay/line-display.c                  | 261 +++++++++++
 drivers/auxdisplay/line-display.h                  |  43 ++
 include/uapi/linux/map_to_14segment.h              | 241 ++++++++++
 11 files changed, 1023 insertions(+), 286 deletions(-)
 create mode 100644 drivers/auxdisplay/line-display.c
 create mode 100644 drivers/auxdisplay/line-display.h
 create mode 100644 include/uapi/linux/map_to_14segment.h
