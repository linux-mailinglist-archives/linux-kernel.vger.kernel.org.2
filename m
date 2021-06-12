Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFC03A4F9A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 17:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhFLP5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 11:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231373AbhFLP53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 11:57:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7657B610FC;
        Sat, 12 Jun 2021 15:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623513319;
        bh=JG9O4NfiHdk3nCHbc/jik2VZDdoYJZACnH1oPGBd1q0=;
        h=Date:From:To:Cc:Subject:From;
        b=M5/Dcja4NYy5DoWnRJo5eDcjoealiVBlAPB3mpwJdb5kF1T980YEjit8go345+kMc
         5XeH9F0s91ePwfNd7GX75WR6MM7EjVunikOw3gw/6MmWZ4jkGLAN81ukfRiDkUW1gi
         /dADR/eu63TztBHK8KEB9K5KjynAMwrzysPsF9o8=
Date:   Sat, 12 Jun 2021 17:55:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.13-rc6
Message-ID: <YMTY5JKo71X92y/S@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8124c8a6b35386f73523d27eacb71b5364a68c4c:

  Linux 5.13-rc4 (2021-05-30 11:58:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.13-rc6

for you to fetch changes up to 7c4363d3948535e6a9116a325b2fb56eab6b88ff:

  Merge tag 'usb-serial-5.13-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2021-06-11 12:32:49 +0200)

----------------------------------------------------------------
USB fixes for 5.13-rc6

Here are a number of tiny USB fixes for 5.13-rc6.

There are more than I would normally like, but there's been a bunch of
people banging on the gadget and dwc3 and typec code recently for I
think an Android release, which has resulted in a number of small fixes.
It's nice to see companies send fixes upstream for this type of work, a
notable change from years ago.

Anyway, fixes in here are:
	- usb-serial device id updates
	- usb-serial cp210x driver fixes for broken firmware versions
	- typec fixes for crazy charging devices and other reported
	  problems
	- dwc3 fixes for reported problems found
	- gadget fixes for reported problems
	- tiny xhci fixes
	- other small fixes for reported issues.
	- revert of a problem fix found by linux-next testing

All of these have passed 0-day and linux-next testing with no reported
problems (the revert for the found linux-next build problem included).

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexandre GRIVEAUX (2):
      USB: serial: omninet: add device id for Zyxel Omni 56K Plus
      USB: serial: omninet: update driver description

Alexandru Elisei (1):
      Revert "usb: dwc3: core: Add shutdown callback for dwc3"

Andy Shevchenko (4):
      usb: typec: intel_pmc_mux: Put fwnode in error case during ->probe()
      usb: typec: intel_pmc_mux: Add missed error check for devm_ioremap_resource()
      usb: typec: intel_pmc_mux: Put ACPI device using acpi_dev_put()
      usb: typec: wcove: Use LE to CPU conversion when accessing msg->header

Bjorn Andersson (1):
      usb: typec: mux: Fix copy-paste mistake in typec_mux_match

Christophe JAILLET (1):
      usb: dwc3: meson-g12a: Disable the regulator in the error handling path of the probe

George McCollister (1):
      USB: serial: ftdi_sio: add NovaTech OrionMX product ID

Greg Kroah-Hartman (4):
      Merge tag 'usb-serial-5.13-rc5' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus
      Merge tag 'usb-v5.13-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-linus
      Revert "usb: gadget: fsl: Re-enable driver for ARM SoCs"
      Merge tag 'usb-serial-5.13-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Jack Pham (2):
      usb: dwc3: gadget: Bail from dwc3_gadget_exit() if dwc->gadget is NULL
      usb: dwc3: debugfs: Add and remove endpoint dirs dynamically

Joel Stanley (1):
      usb: gadget: fsl: Re-enable driver for ARM SoCs

Johan Hovold (2):
      USB: serial: quatech2: fix control-request directions
      USB: serial: cp210x: fix CP2102N-A01 modem control

Kyle Tso (8):
      usb: pd: Set PD_T_SINK_WAIT_CAP to 310ms
      dt-bindings: connector: Replace BIT macro with generic bit ops
      usb: typec: tcpm: Correct the responses in SVDM Version 2.0 DFP
      dt-bindings: connector: Add PD rev 2.0 VDO definition
      usb: typec: tcpm: Introduce snk_vdo_v1 for SVDM version 1.0
      usb: typec: tcpm: Fix misuses of AMS invocation
      usb: typec: tcpm: Properly handle Alert and Status Messages
      usb: typec: tcpm: Do not finish VDM AMS for retrying Responses

Li Jun (3):
      usb: typec: tcpm: cancel vdm and state machine hrtimer when unregister tcpm port
      usb: typec: tcpm: cancel frs hrtimer when unregister tcpm port
      usb: typec: tcpm: cancel send discover hrtimer when unregister tcpm port

Linyu Yuan (1):
      usb: gadget: eem: fix wrong eem header operation

Maciej Żenczykowski (4):
      USB: f_ncm: ncm_bitrate (speed) is unsigned
      usb: f_ncm: only first packet of aggregate needs to start timer
      usb: fix various gadgets null ptr deref on 10gbps cabling.
      usb: fix various gadget panics on 10gbps cabling

Marian-Cristian Rotariu (1):
      usb: dwc3: ep0: fix NULL pointer exception

Mario Limonciello (1):
      usb: pci-quirks: disable D3cold on xhci suspend for s2idle on AMD Renoir

Mayank Rana (1):
      usb: typec: ucsi: Clear PPM capability data in ucsi_init() error path

Neil Armstrong (1):
      usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0 is disabled

Pawel Laszczak (1):
      usb: cdnsp: Fix deadlock issue in cdnsp_thread_irq_handler

Rui Miguel Silva (1):
      MAINTAINERS: usb: add entry for isp1760

Sanket Parmar (1):
      usb: cdns3: Enable TDL_CHK only for OUT ep

Stefan Agner (1):
      USB: serial: cp210x: fix alternate function for CP2102N QFN20

Thomas Petazzoni (1):
      usb: musb: fix MUSB_QUIRK_B_DISCONNECT_99 handling

Wesley Cheng (2):
      usb: dwc3: gadget: Disable gadget IRQ during pullup disable
      usb: gadget: f_fs: Ensure io_completion_wq is idle during unbind

Yang Yingliang (1):
      usb: misc: brcmstb-usb-pinmap: check return value after calling platform_get_resource()

 .../bindings/connector/usb-connector.yaml          |  15 +++
 MAINTAINERS                                        |   7 ++
 drivers/usb/cdns3/cdns3-gadget.c                   |   8 +-
 drivers/usb/cdns3/cdnsp-ring.c                     |   7 +-
 drivers/usb/dwc3/core.c                            |   6 -
 drivers/usb/dwc3/debug.h                           |   3 +
 drivers/usb/dwc3/debugfs.c                         |  21 +---
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |  13 ++-
 drivers/usb/dwc3/ep0.c                             |   3 +
 drivers/usb/dwc3/gadget.c                          |  18 ++-
 drivers/usb/gadget/config.c                        |   8 ++
 drivers/usb/gadget/function/f_ecm.c                |   2 +-
 drivers/usb/gadget/function/f_eem.c                |   6 +-
 drivers/usb/gadget/function/f_fs.c                 |   3 +
 drivers/usb/gadget/function/f_hid.c                |   3 +-
 drivers/usb/gadget/function/f_loopback.c           |   2 +-
 drivers/usb/gadget/function/f_ncm.c                |  10 +-
 drivers/usb/gadget/function/f_printer.c            |   3 +-
 drivers/usb/gadget/function/f_rndis.c              |   2 +-
 drivers/usb/gadget/function/f_serial.c             |   2 +-
 drivers/usb/gadget/function/f_sourcesink.c         |   3 +-
 drivers/usb/gadget/function/f_subset.c             |   2 +-
 drivers/usb/gadget/function/f_tcm.c                |   3 +-
 drivers/usb/host/xhci-pci.c                        |   7 +-
 drivers/usb/host/xhci.h                            |   1 +
 drivers/usb/misc/brcmstb-usb-pinmap.c              |   2 +
 drivers/usb/musb/musb_core.c                       |   3 +-
 drivers/usb/serial/cp210x.c                        |  84 +++++++++++++-
 drivers/usb/serial/ftdi_sio.c                      |   1 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   1 +
 drivers/usb/serial/omninet.c                       |   8 +-
 drivers/usb/serial/quatech2.c                      |   6 +-
 drivers/usb/typec/mux.c                            |   2 +-
 drivers/usb/typec/mux/intel_pmc_mux.c              |  15 ++-
 drivers/usb/typec/tcpm/tcpm.c                      | 123 +++++++++++++--------
 drivers/usb/typec/tcpm/wcove.c                     |   2 +-
 drivers/usb/typec/ucsi/ucsi.c                      |   1 +
 include/dt-bindings/usb/pd.h                       |  89 ++++++++++++---
 include/linux/usb/pd.h                             |   2 +-
 include/linux/usb/pd_ext_sdb.h                     |   4 -
 40 files changed, 357 insertions(+), 144 deletions(-)
