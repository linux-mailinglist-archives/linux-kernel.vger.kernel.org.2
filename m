Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55419339EC4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 16:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhCMPDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 10:03:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:59744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233894AbhCMPDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 10:03:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B49864F19;
        Sat, 13 Mar 2021 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615647817;
        bh=Vh0iNf/TdyALBPjpQmgrER6J6CsYmhv+a6PhHNN1lqU=;
        h=Date:From:To:Cc:Subject:From;
        b=YW1RhzH16oIITJgh1UV23MdHM5kEpcRBhKSTzQjvumt63zXB5SjSXXn3QOxhVKSF7
         HGUa5wSUVER6O0NRX6ENZdl9YeQogAsi/lrBCk/HwuQWB6IVQa5q0sW28fCuL68IMv
         x8nvC1hTDkngSanR+ymYbqaq23E4qZWDhZ1TH0Go=
Date:   Sat, 13 Mar 2021 16:03:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fixes for 5.12-rc3
Message-ID: <YEzURs5m1NwP4DyY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.12-rc3

for you to fetch changes up to 16d7586dccf83785819f5b66f4d20fac9bfcd644:

  Revert "staging: wfx: remove unused included header files" (2021-03-10 09:23:30 +0100)

----------------------------------------------------------------
Staging driver fixes for 5.12-rc3

Here are some small staging driver fixes for reported problems for
5.12-rc3.  They include:
	- wfx header file cleanup patch reverted as it could cause
	  problems
	- comedi driver endian fixes
	- buffer overflow problems for staging wifi drivers
	- build dependency issue for rtl8192e driver

All have been in linux-next for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (5):
      staging: rtl8712: unterminated string leads to read overflow
      staging: ks7010: prevent buffer overflow in ks_wlan_set_scan()
      staging: rtl8192u: fix ->ssid overflow in r8192_wx_set_scan()
      staging: rtl8188eu: fix potential memory corruption in rtw_check_beacon_data()
      staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()

Greg Kroah-Hartman (1):
      Revert "staging: wfx: remove unused included header files"

Ian Abbott (14):
      staging: comedi: addi_apci_1032: Fix endian problem for COS sample
      staging: comedi: addi_apci_1500: Fix endian problem for command sample
      staging: comedi: adv_pci1710: Fix endian problem for AI command data
      staging: comedi: das6402: Fix endian problem for AI command data
      staging: comedi: das800: Fix endian problem for AI command data
      staging: comedi: dmm32at: Fix endian problem for AI command data
      staging: comedi: me4000: Fix endian problem for AI command data
      staging: comedi: pcl711: Fix endian problem for AI command data
      staging: comedi: pcl818: Fix endian problem for AI command data
      staging: comedi: amplc_pc236_common: Use 16-bit 0 for interrupt data
      staging: comedi: comedi_parport: Use 16-bit 0 for interrupt data
      staging: comedi: ni_6527: Use 16-bit 0 for interrupt data
      staging: comedi: ni_65xx: Use 16-bit 0 for interrupt data
      staging: comedi: pcl726: Use 16-bit 0 for interrupt data

Julian Braha (1):
      staging: rtl8192e: fix kconfig dependency on CRYPTO

Lee Gibson (2):
      staging: rtl8192e: Fix possible buffer overflow in _rtl92e_wx_set_scan
      staging: rtl8712: Fix possible buffer overflow in r8712_sitesurvey_cmd

 drivers/staging/comedi/drivers/addi_apci_1032.c     |  4 +++-
 drivers/staging/comedi/drivers/addi_apci_1500.c     | 18 +++++++++---------
 drivers/staging/comedi/drivers/adv_pci1710.c        | 10 +++++-----
 drivers/staging/comedi/drivers/amplc_pc236_common.c |  4 +++-
 drivers/staging/comedi/drivers/comedi_parport.c     |  3 ++-
 drivers/staging/comedi/drivers/das6402.c            |  2 +-
 drivers/staging/comedi/drivers/das800.c             |  2 +-
 drivers/staging/comedi/drivers/dmm32at.c            |  2 +-
 drivers/staging/comedi/drivers/me4000.c             |  2 +-
 drivers/staging/comedi/drivers/ni_6527.c            |  4 +++-
 drivers/staging/comedi/drivers/ni_65xx.c            |  3 ++-
 drivers/staging/comedi/drivers/pcl711.c             |  2 +-
 drivers/staging/comedi/drivers/pcl726.c             |  4 +++-
 drivers/staging/comedi/drivers/pcl818.c             |  2 +-
 drivers/staging/ks7010/ks_wlan_net.c                |  6 ++++--
 drivers/staging/rtl8188eu/core/rtw_ap.c             |  5 +++++
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c      |  6 ++++--
 drivers/staging/rtl8192e/Kconfig                    |  1 +
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c          |  7 ++++---
 drivers/staging/rtl8192u/r8192U_wx.c                |  6 ++++--
 drivers/staging/rtl8712/rtl871x_cmd.c               |  6 ++++--
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c       |  2 +-
 drivers/staging/wfx/bh.c                            |  1 +
 drivers/staging/wfx/bh.h                            |  4 ++++
 drivers/staging/wfx/bus.h                           |  3 +++
 drivers/staging/wfx/bus_sdio.c                      |  6 ++++++
 drivers/staging/wfx/bus_spi.c                       |  7 +++++++
 drivers/staging/wfx/data_rx.c                       |  5 +++++
 drivers/staging/wfx/data_tx.c                       |  5 +++++
 drivers/staging/wfx/data_tx.h                       |  3 +++
 drivers/staging/wfx/debug.c                         |  6 ++++++
 drivers/staging/wfx/fwio.c                          |  2 ++
 drivers/staging/wfx/hif_api_cmd.h                   |  4 ++++
 drivers/staging/wfx/hif_api_general.h               |  9 +++++++++
 drivers/staging/wfx/hif_tx.c                        |  4 ++++
 drivers/staging/wfx/hif_tx_mib.c                    |  5 +++++
 drivers/staging/wfx/hwio.c                          |  3 +++
 drivers/staging/wfx/hwio.h                          |  2 ++
 drivers/staging/wfx/key.c                           |  2 ++
 drivers/staging/wfx/key.h                           |  2 ++
 drivers/staging/wfx/main.c                          |  7 +++++++
 drivers/staging/wfx/main.h                          |  3 +++
 drivers/staging/wfx/queue.c                         |  4 ++++
 drivers/staging/wfx/queue.h                         |  3 +++
 drivers/staging/wfx/scan.h                          |  2 ++
 drivers/staging/wfx/sta.c                           |  6 ++++++
 drivers/staging/wfx/sta.h                           |  2 ++
 drivers/staging/wfx/traces.h                        |  3 +++
 drivers/staging/wfx/wfx.h                           |  3 +++
 49 files changed, 169 insertions(+), 38 deletions(-)
