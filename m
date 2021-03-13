Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F207339EBE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 16:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhCMPCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 10:02:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230441AbhCMPCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 10:02:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E227264F18;
        Sat, 13 Mar 2021 15:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615647725;
        bh=eW7CiY2DtD1D1I3DtX1NBMSSBxgl/ITXMqCDwH72UHM=;
        h=Date:From:To:Cc:Subject:From;
        b=H+J8WLmQfGXi2/qRsuXt4akLLAr7OPAk7PBmqZhA1GfDqJHbwT+si6zC291qRrgye
         UHY7lz2V7qDcY6wlDhoFTQvCeyKQT+qxRCs4fzpzrF2V+A8oxOdAtei8YN822eQVvZ
         8CxJhTnIXUf90cw5KQMPx92O71yNYSFgT0UltGKA=
Date:   Sat, 13 Mar 2021 16:02:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.12-rc3
Message-ID: <YEzT6kyiwo9T12Er@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.12-rc3

for you to fetch changes up to d26c00e7276fc92b18c253d69e872f6b03832bad:

  xhci: Fix repeated xhci wake after suspend due to uncleared internal wake state (2021-03-11 13:03:06 +0100)

----------------------------------------------------------------
USB fixes for 5.12-rc3

Here are a small number of USB fixes for 5.12-rc3 to resolve a bunch of
reported issues:
	- usbip fixups for issues found by syzbot
	- xhci driver fixes and quirk additions
	- gadget driver fixes
	- dwc3 QCOM driver fix
	- usb-serial new ids and fixes
	- usblp fix for a long-time issue
	- cdc-acm quirk addition
	- other tiny fixes for reported problems

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (1):
      USB: gadget: u_ether: Fix a configfs return code

Forest Crossman (1):
      usb: xhci: Fix ASMedia ASM1042A and ASM3242 DMA addressing

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-5.12-rc3' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Johan Hovold (1):
      USB: serial: xr: fix NULL-deref on disconnect

Karan Singhal (1):
      USB: serial: cp210x: add ID for Acuity Brands nLight Air Adapter

Mathias Nyman (2):
      xhci: Improve detection of device initiated wake signal.
      xhci: Fix repeated xhci wake after suspend due to uncleared internal wake state

Matthias Kaehlcke (1):
      usb: dwc3: qcom: Honor wakeup enabled/disabled state

Niv Sardi (1):
      USB: serial: ch341: add new Product ID

Pavel Skripkin (1):
      USB: serial: io_edgeport: fix memory leak in edge_startup

Pete Zaitcev (1):
      USB: usblp: fix a hang in poll() if disconnected

Ruslan Bilovol (2):
      usb: gadget: f_uac2: always increase endpoint max_packet_size by one audio slot
      usb: gadget: f_uac1: stop playback on function disable

Sebastian Reichel (1):
      USB: serial: cp210x: add some more GE USB IDs

Serge Semin (1):
      usb: dwc3: qcom: Add missing DWC3 OF node refcount decrement

Shawn Guo (1):
      usb: dwc3: qcom: add ACPI device id for sc8180x

Shuah Khan (6):
      usbip: fix stub_dev to check for stream socket
      usbip: fix vhci_hcd to check for stream socket
      usbip: fix vudc to check for stream socket
      usbip: fix stub_dev usbip_sockfd_store() races leading to gpf
      usbip: fix vhci_hcd attach_store() races leading to gpf
      usbip: fix vudc usbip_sockfd_store races leading to gpf

Stanislaw Gruszka (1):
      usb: xhci: do not perform Soft Retry for some xHCI hosts

Wei Yongjun (1):
      USB: gadget: udc: s3c2410_udc: fix return value check in s3c2410_udc_probe()

Yorick de Wid (1):
      Goodix Fingerprint device is not a modem

Yoshihiro Shimoda (1):
      usb: renesas_usbhs: Clear PIPECFG for re-enabling pipe with other EPNUM

 drivers/usb/class/cdc-acm.c                    |  5 ++
 drivers/usb/class/usblp.c                      | 16 ++++--
 drivers/usb/dwc3/dwc3-qcom.c                   | 18 ++++--
 drivers/usb/gadget/function/f_uac1.c           |  1 +
 drivers/usb/gadget/function/f_uac2.c           |  2 +-
 drivers/usb/gadget/function/u_ether_configfs.h |  5 +-
 drivers/usb/gadget/udc/s3c2410_udc.c           |  4 +-
 drivers/usb/host/xhci-pci.c                    | 13 ++++-
 drivers/usb/host/xhci-ring.c                   |  3 +-
 drivers/usb/host/xhci.c                        | 78 ++++++++++++++------------
 drivers/usb/host/xhci.h                        |  1 +
 drivers/usb/renesas_usbhs/pipe.c               |  2 +
 drivers/usb/serial/ch341.c                     |  1 +
 drivers/usb/serial/cp210x.c                    |  3 +
 drivers/usb/serial/io_edgeport.c               | 26 +++++----
 drivers/usb/serial/xr_serial.c                 | 25 ---------
 drivers/usb/usbip/stub_dev.c                   | 42 +++++++++++---
 drivers/usb/usbip/vhci_sysfs.c                 | 39 +++++++++++--
 drivers/usb/usbip/vudc_sysfs.c                 | 49 +++++++++++++---
 19 files changed, 226 insertions(+), 107 deletions(-)
