Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D213714A3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 13:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhECL7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 07:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231180AbhECL7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 07:59:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEC58611BD;
        Mon,  3 May 2021 11:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043130;
        bh=jWutM0lJ8C4urJ2vTw0bSXxDgKG7hL49aOdteYHbj1A=;
        h=From:To:Cc:Subject:Date:From;
        b=ku7mR3jQPimYS/2yyhYUCz2rNyS4nVfxG/AowgB+ngv/SDYgDFL00Ofl6s9wz7ZOP
         axalsZ4t0vlUkDchj3hKkeF/iwL/lXsqLgaQ77hZLh0Jk/ljHapcdKWYynq8pIm6IY
         Un8oMGQZK27+B6c3kLH17de+8Fx2oKHJr86lDZPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 00/69] "Revert and fix properly" patch series based on umn.edu re-review
Date:   Mon,  3 May 2021 13:56:27 +0200
Message-Id: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

[individuals put on bcc: due to quantity would have been rejected by vger]

Here is the "final" set of reverts and fixes based on the re-review of
all accepted umn.edu commits.  It consists of 7 "clean" reverts that do
not need to be fixed up again for various reasons (see the commit
messages for reasoning), and then 31 sets of "revert & fix" commits that
consist of reverting the offending commit and then fixing it up
properly.

Where these patches were accepted into stable kernels, I've properly
tagged them for reverting in the stable kernels automatically as well.

I'll be taking these through one of my trees, so there's no need for any
maintainer to have to worry about these needing to go through theirs.

Many thanks to the huge number of people who provided the original
"revert review" of all of the patches, as well as the developers here
who worked to provide "correct" fixes for these issues so that no kernel
release will go out with any bugfix being dropped.

thanks,

greg k-h

----------

Alaa Emad (2):
  media: dvb: Add check on sp8870_readreg return
  media: gspca: mt9m111: Check write_bridge for timeout

Anirudh Rayabharam (5):
  net: fujitsu: fix potential null-ptr-deref
  net/smc: properly handle workqueue allocation failure
  net: stmicro: handle clk_prepare() failure during init
  ath6kl: return error code in ath6kl_wmi_set_roam_lrssi_cmd()
  rapidio: handle create_workqueue() failure

Atul Gopinathan (3):
  serial: max310x: unregister uart driver in case of failure and abort
  cdrom: gdrom: deallocate struct gdrom_unit fields in remove_gdrom
  ALSA: sb8: Add a comment note regarding an unused pointer

Du Cheng (2):
  net: caif: remove BUG_ON(dev == NULL) in caif_xmit
  ethernet: sun: niu: fix missing checks of niu_pci_eeprom_read()

Greg Kroah-Hartman (44):
  Revert "crypto: cavium/nitrox - add an error message to explain the
    failure of pci_request_mem_regions"
  Revert "media: rcar_drif: fix a memory disclosure"
  Revert "hwmon: (lm80) fix a missing check of bus read in lm80 probe"
  Revert "serial: mvebu-uart: Fix to avoid a potential NULL pointer
    dereference"
  Revert "media: usb: gspca: add a missed check for goto_low_power"
  Revert "ALSA: sb: fix a missing check of snd_ctl_add"
  Revert "leds: lp5523: fix a missing check of return value of
    lp55xx_read"
  Revert "serial: max310x: pass return value of spi_register_driver"
  Revert "rtlwifi: fix a potential NULL pointer dereference"
  net: rtlwifi: properly check for alloc_workqueue() failure
  Revert "net: fujitsu: fix a potential NULL pointer dereference"
  Revert "net/smc: fix a NULL pointer dereference"
  Revert "net: caif: replace BUG_ON with recovery code"
  Revert "net: stmicro: fix a missing check of clk_prepare"
  Revert "niu: fix missing checks of niu_pci_eeprom_read"
  Revert "qlcnic: Avoid potential NULL pointer dereference"
  Revert "gdrom: fix a memory leak bug"
  Revert "char: hpet: fix a missing check of ioremap"
  Revert "scsi: ufs: fix a missing check of devm_reset_control_get"
  Revert "ALSA: gus: add a check of the status of snd_ctl_add"
  Revert "ALSA: sb8: add a check for request_region"
  Revert "ALSA: usx2y: Fix potential NULL pointer dereference"
  ALSA: usx2y: check for failure of usb_alloc_urb()
  Revert "video: hgafb: fix potential NULL pointer dereference"
  Revert "isdn: mISDNinfineon: fix potential NULL pointer dereference"
  Revert "ath6kl: return error code in ath6kl_wmi_set_roam_lrssi_cmd()"
  Revert "rapidio: fix a NULL pointer dereference when
    create_workqueue() fails"
  Revert "isdn: mISDN: Fix potential NULL pointer dereference of
    kzalloc"
  Revert "ecryptfs: replace BUG_ON with error handling code"
  Revert "dmaengine: qcom_hidma: Check for driver register failure"
  Revert "libertas: add checks for the return value of
    sysfs_create_group"
  libertas: register sysfs groups properly
  Revert "ASoC: rt5645: fix a NULL pointer dereference"
  Revert "ASoC: cs43130: fix a NULL pointer dereference"
  ASoC: cs43130: handle errors in cs43130_probe() properly
  Revert "media: dvb: Add check on sp8870_readreg"
  Revert "media: gspca: mt9m111: Check write_bridge for timeout"
  Revert "media: gspca: Check the return value of write_bridge for
    timeout"
  media: gspca: properly check for errors in po1030_probe()
  Revert "net: liquidio: fix a NULL pointer dereference"
  Revert "video: imsttfb: fix potential NULL pointer dereferences"
  video: imsttfb: check for ioremap() failures
  Revert "brcmfmac: add a check for the status of usb_register"
  brcmfmac: properly check for bus register errors

Igor Matheus Andrade Torrente (1):
  video: hgafb: fix potential NULL pointer dereference

Kees Cook (1):
  Revert "ACPI: custom_method: fix memory leaks"

Kurt Manucredo (1):
  ALSA: gus: properly handle snd_ctl_add() error

Phillip Potter (7):
  leds: lp5523: check return value of lp5xx_read and jump to cleanup
    code
  scsi: ufs: handle cleanup correctly on devm_reset_control_get error
  isdn: mISDNinfineon: check/cleanup ioremap failure correctly in
    setup_io
  isdn: mISDN: correctly handle ph_info allocation failure in
    hfcsusb_ph_info
  fs: ecryptfs: remove BUG_ON from crypt_scatterlist
  dmaengine: qcom_hidma: comment platform_driver_register call
  ASoC: rt5645: add error checking to rt5645_probe function

Tom Seewald (3):
  qlcnic: Add null check after calling netdev_alloc_skb
  char: hpet: add checks after calling ioremap
  net: liquidio: Add missing null pointer checks

 drivers/acpi/custom_method.c                  |  5 +-
 drivers/cdrom/gdrom.c                         |  4 +-
 drivers/char/hpet.c                           |  2 +
 drivers/crypto/cavium/nitrox/nitrox_main.c    |  1 -
 drivers/dma/qcom/hidma_mgmt.c                 | 17 ++++++-
 drivers/hwmon/lm80.c                          | 11 +----
 drivers/isdn/hardware/mISDN/hfcsusb.c         | 17 +++----
 drivers/isdn/hardware/mISDN/mISDNinfineon.c   | 21 +++++---
 drivers/leds/leds-lp5523.c                    |  2 +-
 drivers/media/dvb-frontends/sp8870.c          |  2 +-
 drivers/media/platform/rcar_drif.c            |  1 -
 drivers/media/usb/gspca/cpia1.c               |  6 +--
 drivers/media/usb/gspca/m5602/m5602_mt9m111.c | 16 +++---
 drivers/media/usb/gspca/m5602/m5602_po1030.c  | 14 +++---
 drivers/net/caif/caif_serial.c                |  3 --
 .../net/ethernet/cavium/liquidio/lio_main.c   | 27 ++++++----
 .../ethernet/cavium/liquidio/lio_vf_main.c    | 27 +++++++---
 drivers/net/ethernet/fujitsu/fmvj18x_cs.c     |  4 +-
 .../ethernet/qlogic/qlcnic/qlcnic_ethtool.c   |  3 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c |  8 +--
 drivers/net/ethernet/sun/niu.c                | 32 +++++++-----
 drivers/net/wireless/ath/ath6kl/debug.c       |  5 +-
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  8 +--
 .../broadcom/brcm80211/brcmfmac/bus.h         | 19 ++++++-
 .../broadcom/brcm80211/brcmfmac/core.c        | 42 +++++++---------
 .../broadcom/brcm80211/brcmfmac/pcie.c        |  9 +---
 .../broadcom/brcm80211/brcmfmac/pcie.h        |  5 --
 .../broadcom/brcm80211/brcmfmac/usb.c         |  8 +--
 drivers/net/wireless/marvell/libertas/mesh.c  | 33 ++-----------
 drivers/net/wireless/realtek/rtlwifi/base.c   | 18 +++----
 drivers/rapidio/rio_cm.c                      | 17 +++----
 drivers/scsi/ufs/ufs-hisi.c                   | 15 +++---
 drivers/tty/serial/max310x.c                  |  2 +
 drivers/tty/serial/mvebu-uart.c               |  3 --
 drivers/video/fbdev/hgafb.c                   | 21 ++++----
 drivers/video/fbdev/imsttfb.c                 | 26 +++++++---
 fs/ecryptfs/crypto.c                          |  4 --
 net/smc/smc_ism.c                             | 15 +++---
 sound/isa/gus/gus_main.c                      | 19 ++-----
 sound/isa/sb/sb16_main.c                      | 10 ++--
 sound/isa/sb/sb8.c                            | 10 ++--
 sound/soc/codecs/cs43130.c                    | 28 +++++------
 sound/soc/codecs/rt5645.c                     | 49 ++++++++++++++-----
 sound/usb/usx2y/usb_stream.c                  | 22 +++++++--
 44 files changed, 323 insertions(+), 288 deletions(-)

-- 
2.31.1

