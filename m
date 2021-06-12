Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862C03A4F92
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 17:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhFLP4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 11:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhFLP4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 11:56:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4DCF61108;
        Sat, 12 Jun 2021 15:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623513234;
        bh=s5CWoNNaiFWA1OIl1MRQejTQtxHv1XyW16BtfLKyBA8=;
        h=Date:From:To:Cc:Subject:From;
        b=HauOqxp6gBIXmUF4BQoGhw7IXS4nTjUrDXdAHSq44CL18+6VvT4RdS5Q8G7LgcGQF
         KUqAfP5199zrncscLdIIidLhJmUSW8hGIuMD76M99RY7/0ANYhhNNA9KEkjO9EBo2x
         L2FyhgwvdOYolwXE8bW41UFpQzsb4m8VcPLTcGUk=
Date:   Sat, 12 Jun 2021 17:53:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.13-rc6
Message-ID: <YMTYj8wXW1/FXK/v@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8124c8a6b35386f73523d27eacb71b5364a68c4c:

  Linux 5.13-rc4 (2021-05-30 11:58:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.13-rc6

for you to fetch changes up to 3df4fce739e2b263120f528c5e0fe6b2f8937b5b:

  misc: rtsx: separate aspm mode into MODE_REG and MODE_CFG (2021-06-09 19:10:22 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.13-rc6

Here are some small misc driver fixes for 5.13-rc6 that fix some
reported problems:
	- Tiny phy driver fixes for reported issues
	- rtsx regression for when the device suspended
	- mhi driver fix for a use-after-free

All of these have been in linux-next for a few days with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Chen Li (1):
      phy: usb: Fix misuse of IS_ENABLED

Greg Kroah-Hartman (1):
      Merge tag 'phy-fixes-5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into char-misc-linus

Jarvis Jiang (1):
      bus: mhi: pci_generic: T99W175: update channel name from AT to DUN

Loic Poulain (1):
      bus: mhi: pci-generic: Fix hibernation

Ricky Wu (1):
      misc: rtsx: separate aspm mode into MODE_REG and MODE_CFG

Sergio Paracuellos (1):
      phy: ralink: phy-mt7621-pci: drop 'of_match_ptr' to fix -Wunused-const-variable

Tiezhu Yang (1):
      phy: phy-mtk-tphy: Fix some resource leaks in mtk_phy_init()

Wang Wensheng (1):
      phy: cadence: Sierra: Fix error return code in cdns_sierra_phy_probe()

Wei Yongjun (1):
      bus: mhi: pci_generic: Fix possible use-after-free in mhi_pci_remove()

Yang Li (1):
      phy: ti: Fix an error code in wiz_probe()

Yang Yingliang (1):
      phy: Sparx5 Eth SerDes: check return value after calling platform_get_resource()

 drivers/bus/mhi/pci_generic.c            | 42 +++++++++++++++++++++++++++---
 drivers/misc/cardreader/rtl8411.c        |  1 +
 drivers/misc/cardreader/rts5209.c        |  1 +
 drivers/misc/cardreader/rts5227.c        |  2 ++
 drivers/misc/cardreader/rts5228.c        |  1 +
 drivers/misc/cardreader/rts5229.c        |  1 +
 drivers/misc/cardreader/rts5249.c        |  3 +++
 drivers/misc/cardreader/rts5260.c        |  1 +
 drivers/misc/cardreader/rts5261.c        |  1 +
 drivers/misc/cardreader/rtsx_pcr.c       | 44 ++++++++++++++++++++++----------
 drivers/phy/broadcom/phy-brcm-usb-init.h |  4 +--
 drivers/phy/cadence/phy-cadence-sierra.c |  1 +
 drivers/phy/mediatek/phy-mtk-tphy.c      |  2 ++
 drivers/phy/microchip/sparx5_serdes.c    |  4 +++
 drivers/phy/ralink/phy-mt7621-pci.c      |  2 +-
 drivers/phy/ti/phy-j721e-wiz.c           |  1 +
 include/linux/rtsx_pci.h                 |  2 ++
 17 files changed, 93 insertions(+), 20 deletions(-)
