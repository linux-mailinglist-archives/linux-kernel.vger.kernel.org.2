Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB69C38ACCD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241247AbhETLtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241815AbhETLZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:25:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E1A3611BD;
        Thu, 20 May 2021 11:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621508673;
        bh=BpBOIvyPz6mut73x6+GsB1T9+PiMdcYntciYNIcP7J0=;
        h=Date:From:To:Cc:Subject:From;
        b=dI2I85bYLMNSo8OFjOQ6kyATYiNCpi2GhgKyslRg6b86LQ38csbnfBL2cfaw3IQ5s
         hLKG8Gbm3rHFtxfjK67UJIjodF5LYr4nDtWuQeEdkS5VFCqUxjTeq6Leeqq5tTutw8
         hO/PvhDLv+IMtpZDZ0j/tNjeULto44gnH9NtaioI=
Date:   Thu, 20 May 2021 13:04:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.13-rc3
Message-ID: <YKZCPyufaCjGMZL7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.13-rc3

for you to fetch changes up to 2962484dfef8dbb7f9059822bc26ce8a04d0e47c:

  misc: eeprom: at24: check suspend status before disable regulator (2021-05-14 13:50:59 +0200)

----------------------------------------------------------------
Char/misc driver fixes for 5.13-rc3

Here is a big set of char/misc/other driver fixes for 5.13-rc3.

The majority here is the fallout of the umn.edu re-review of all prior
submissions.  That resulted in a bunch of reverts along with the
"correct" changes made, such that there is no regression of any of the
potential fixes that were made by those individuals.  I would like to
thank the over 80 different developers who helped with the review and
fixes for this mess.

Other than that, there's a few habanna driver fixes for reported issues,
and some dyndbg fixes for reported problems.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
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

Bharat Jauhari (1):
      habanalabs: expose ASIC specific PLL index

Christophe JAILLET (2):
      uio_hv_generic: Fix a memory leak in error handling paths
      uio_hv_generic: Fix another memory leak in error handling paths

Darrick J. Wong (1):
      ics932s401: fix broken handling of errors when word reading fails

Du Cheng (2):
      net: caif: remove BUG_ON(dev == NULL) in caif_xmit
      ethernet: sun: niu: fix missing checks of niu_pci_eeprom_read()

Greg Kroah-Hartman (46):
      Merge tag 'misc-habanalabs-fixes-2021-05-08' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux into char-misc-linus
      Revert "crypto: cavium/nitrox - add an error message to explain the failure of pci_request_mem_regions"
      Revert "media: rcar_drif: fix a memory disclosure"
      Revert "hwmon: (lm80) fix a missing check of bus read in lm80 probe"
      Revert "serial: mvebu-uart: Fix to avoid a potential NULL pointer dereference"
      Revert "media: usb: gspca: add a missed check for goto_low_power"
      Revert "ALSA: sb: fix a missing check of snd_ctl_add"
      Revert "leds: lp5523: fix a missing check of return value of lp55xx_read"
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
      Revert "video: hgafb: fix potential NULL pointer dereference"
      Revert "isdn: mISDNinfineon: fix potential NULL pointer dereference"
      Revert "ath6kl: return error code in ath6kl_wmi_set_roam_lrssi_cmd()"
      Revert "rapidio: fix a NULL pointer dereference when create_workqueue() fails"
      Revert "isdn: mISDN: Fix potential NULL pointer dereference of kzalloc"
      Revert "ecryptfs: replace BUG_ON with error handling code"
      Revert "dmaengine: qcom_hidma: Check for driver register failure"
      Revert "libertas: add checks for the return value of sysfs_create_group"
      libertas: register sysfs groups properly
      Revert "ASoC: rt5645: fix a NULL pointer dereference"
      Revert "ASoC: cs43130: fix a NULL pointer dereference"
      ASoC: cs43130: handle errors in cs43130_probe() properly
      Revert "media: dvb: Add check on sp8870_readreg"
      Revert "media: gspca: mt9m111: Check write_bridge for timeout"
      Revert "media: gspca: Check the return value of write_bridge for timeout"
      media: gspca: properly check for errors in po1030_probe()
      Revert "net: liquidio: fix a NULL pointer dereference"
      Revert "video: imsttfb: fix potential NULL pointer dereferences"
      video: imsttfb: check for ioremap() failures
      Revert "brcmfmac: add a check for the status of usb_register"
      brcmfmac: properly check for bus register errors
      cdrom: gdrom: initialize global variable at init time
      Revert "Revert "ALSA: usx2y: Fix potential NULL pointer dereference""

Hsin-Yi Wang (1):
      misc: eeprom: at24: check suspend status before disable regulator

Igor Matheus Andrade Torrente (1):
      video: hgafb: fix potential NULL pointer dereference

Jim Cromie (2):
      dyndbg: avoid calling dyndbg_emit_prefix when it has no work
      dyndbg: drop uninformative vpr_info

Luca Stefani (1):
      binder: Return EFAULT if we fail BINDER_ENABLE_ONEWAY_SPAM_DETECTION

Lv Yunlong (1):
      habanalabs/gaudi: Fix a potential use after free in gaudi_memset_device_memory

Martin Ågren (1):
      uio/uio_pci_generic: fix return value changed in refactoring

Oded Gabbay (3):
      habanalabs: skip reading f/w errors on bad status
      habanalabs: change error level of security not ready
      habanalabs: ignore f/w status error

Ofir Bitton (1):
      habanalabs: wait for interrupt wrong timeout calculation

Phillip Potter (7):
      leds: lp5523: check return value of lp5xx_read and jump to cleanup code
      scsi: ufs: handle cleanup correctly on devm_reset_control_get error
      isdn: mISDNinfineon: check/cleanup ioremap failure correctly in setup_io
      isdn: mISDN: correctly handle ph_info allocation failure in hfcsusb_ph_info
      fs: ecryptfs: remove BUG_ON from crypt_scatterlist
      dmaengine: qcom_hidma: comment platform_driver_register call
      ASoC: rt5645: add error checking to rt5645_probe function

Tom Seewald (3):
      qlcnic: Add null check after calling netdev_alloc_skb
      char: hpet: add checks after calling ioremap
      net: liquidio: Add missing null pointer checks

 drivers/android/binder.c                           |  2 +-
 drivers/cdrom/gdrom.c                              | 13 +++--
 drivers/char/hpet.c                                |  2 +
 drivers/crypto/cavium/nitrox/nitrox_main.c         |  1 -
 drivers/dma/qcom/hidma_mgmt.c                      | 17 ++++++-
 drivers/hwmon/lm80.c                               | 11 +---
 drivers/isdn/hardware/mISDN/hfcsusb.c              | 17 +++----
 drivers/isdn/hardware/mISDN/mISDNinfineon.c        | 21 +++++---
 drivers/leds/leds-lp5523.c                         |  2 +-
 drivers/media/dvb-frontends/sp8870.c               |  2 +-
 drivers/media/platform/rcar_drif.c                 |  1 -
 drivers/media/usb/gspca/cpia1.c                    |  6 +--
 drivers/media/usb/gspca/m5602/m5602_mt9m111.c      | 16 +++---
 drivers/media/usb/gspca/m5602/m5602_po1030.c       | 14 ++---
 drivers/misc/eeprom/at24.c                         |  6 ++-
 .../misc/habanalabs/common/command_submission.c    |  2 +-
 drivers/misc/habanalabs/common/firmware_if.c       | 53 +++++++++++--------
 drivers/misc/habanalabs/common/habanalabs.h        | 23 ++++++---
 drivers/misc/habanalabs/common/habanalabs_drv.c    |  7 +++
 drivers/misc/habanalabs/common/sysfs.c             |  4 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 59 +++++++++-------------
 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c        | 12 ++---
 drivers/misc/habanalabs/goya/goya.c                | 47 +++++++----------
 drivers/misc/habanalabs/goya/goya_hwmgr.c          | 40 +++++++--------
 drivers/misc/ics932s401.c                          |  2 +-
 drivers/net/caif/caif_serial.c                     |  3 --
 drivers/net/ethernet/cavium/liquidio/lio_main.c    | 27 ++++++----
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 27 +++++++---
 drivers/net/ethernet/fujitsu/fmvj18x_cs.c          |  4 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c    |  3 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  |  8 +--
 drivers/net/ethernet/sun/niu.c                     | 32 +++++++-----
 drivers/net/wireless/ath/ath6kl/debug.c            |  5 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |  8 +--
 .../net/wireless/broadcom/brcm80211/brcmfmac/bus.h | 19 ++++++-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    | 42 +++++++--------
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |  9 +---
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.h    |  5 --
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |  8 +--
 drivers/net/wireless/marvell/libertas/mesh.c       | 33 ++----------
 drivers/net/wireless/realtek/rtlwifi/base.c        | 18 +++----
 drivers/rapidio/rio_cm.c                           | 17 +++----
 drivers/scsi/ufs/ufs-hisi.c                        | 15 +++---
 drivers/tty/serial/max310x.c                       |  2 +
 drivers/tty/serial/mvebu-uart.c                    |  3 --
 drivers/uio/uio_hv_generic.c                       | 12 +++--
 drivers/uio/uio_pci_generic.c                      |  2 +-
 drivers/video/fbdev/hgafb.c                        | 21 ++++----
 drivers/video/fbdev/imsttfb.c                      | 26 +++++++---
 fs/ecryptfs/crypto.c                               |  4 --
 include/linux/dynamic_debug.h                      |  5 ++
 include/uapi/misc/habanalabs.h                     | 33 ++++++++++++
 lib/dynamic_debug.c                                | 20 +++++---
 net/smc/smc_ism.c                                  | 15 +++---
 sound/isa/gus/gus_main.c                           | 13 +----
 sound/isa/sb/sb16_main.c                           | 10 ++--
 sound/isa/sb/sb8.c                                 | 10 ++--
 sound/soc/codecs/cs43130.c                         | 28 +++++-----
 sound/soc/codecs/rt5645.c                          | 49 ++++++++++++++----
 59 files changed, 499 insertions(+), 417 deletions(-)
