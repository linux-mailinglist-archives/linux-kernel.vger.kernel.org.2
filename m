Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B1B4307B9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 12:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbhJQKJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 06:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236428AbhJQKJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 06:09:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A34F603E7;
        Sun, 17 Oct 2021 10:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634465230;
        bh=bbwKxxD/TTE7Tmqnd/xV2oqt+WsZec3voZmi17TJa4I=;
        h=Date:From:To:Cc:Subject:From;
        b=Yh8j9MWCI+zge3JzpIR9zbRD5QqMmQ7vcs7DmZQkt6FhI2SaX1fOVot7t7IhAo5+0
         Mt1qDceHUQVm/GMBxFxZ8XFo8TZf1TznKEZ0U8kwxvdCpL9dWasY4zjcrt9NrSQW4D
         UydF35ptrPhByO4c1npTa+6JL1CgN6ATdLA9I6Qs=
Date:   Sun, 17 Oct 2021 12:07:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.15-rc6
Message-ID: <YWv1zE2QO+Dsmt64@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc6

for you to fetch changes up to f42752729e2068a92c7d8b576d0dbbc9c1464149:

  eeprom: 93xx46: fix MODULE_DEVICE_TABLE (2021-10-15 10:54:02 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.15-rc6

Here are some small char/misc driver fixes for 5.15-rc6 for reported
issues that include:
	- habanalabs driver fixes
	- mei driver fixes and new ids
	- fpga new device ids
	- MAINTAINER file updates for fpga subsystem
	- spi module id table additions and fixes
	- fastrpc locking fixes
	- nvmem driver fix

All of these have been in linux-next for a while with no reported issues

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (1):
      mei: hbm: drop hbm responses on early shutdown

Andy Shevchenko (1):
      mei: me: add Ice Lake-N device id.

Arnd Bergmann (2):
      cb710: avoid NULL pointer subtraction
      eeprom: 93xx46: fix MODULE_DEVICE_TABLE

Greg Kroah-Hartman (3):
      Merge tag 'misc-habanalabs-fixes-2021-09-29' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux into char-misc-linus
      Merge tag 'fpga-fixes-5.15-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga into char-misc-next
      Merge tag 'fpga-maintainer-update' of git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga into char-misc-linus

Mark Brown (4):
      fpga: ice40-spi: Add SPI device ID table
      misc: gehc: Add SPI ID table
      eeprom: at25: Add SPI ID table
      eeprom: 93xx46: Add SPI device ID table

Moritz Fischer (2):
      MAINTAINERS: Add Hao and Yilun as maintainers
      MAINTAINERS: Drop outdated FPGA Manager website

Rajaravi Krishna Katta (1):
      habanalabs: fix resetting args in wait for CS IOCTL

Randy Dunlap (1):
      misc: HI6421V600_IRQ should depend on HAS_IOMEM

Srinivas Kandagatla (1):
      misc: fastrpc: Add missing lock before accessing find_vma()

Stephen Boyd (1):
      nvmem: Fix shift-out-of-bound (UBSAN) with byte size cells

 MAINTAINERS                                        |  3 +-
 drivers/fpga/ice40-spi.c                           |  7 +++++
 drivers/misc/Kconfig                               |  1 +
 drivers/misc/cb710/sgbuf2.c                        |  2 +-
 drivers/misc/eeprom/at25.c                         |  8 ++++++
 drivers/misc/eeprom/eeprom_93xx46.c                | 18 ++++++++++++
 drivers/misc/fastrpc.c                             |  2 ++
 drivers/misc/gehc-achc.c                           |  1 +
 .../misc/habanalabs/common/command_submission.c    | 33 +++++++++++++---------
 drivers/misc/mei/hbm.c                             | 12 +++++---
 drivers/misc/mei/hw-me-regs.h                      |  1 +
 drivers/misc/mei/pci-me.c                          |  1 +
 drivers/nvmem/core.c                               |  3 +-
 include/uapi/misc/habanalabs.h                     |  6 ++--
 14 files changed, 73 insertions(+), 25 deletions(-)
