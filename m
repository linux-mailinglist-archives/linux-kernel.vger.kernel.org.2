Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAFD418286
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 16:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245686AbhIYOO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 10:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233738AbhIYOOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 10:14:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 659A960F51;
        Sat, 25 Sep 2021 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632579171;
        bh=I2yRzzvQhOYCT9X/tkqYsXZAR9ypIEex3cNbC3c0D60=;
        h=Date:From:To:Cc:Subject:From;
        b=r/MqE9hVJyD4QGBVS4ml0EuNUyhq59lB5kgmejSMO+6n4YUSjzEy+qLi75+oUvn+p
         NJVt1Hg+jdlHf99BgHhYw3q75YS67MTkp1W9xfmiOUoQ7Q/3mRDtNkjRuoz9Mf4CRK
         GOgYq1gGkQQE2Ovdi3QV6WIz5XlQrRkiG3/f5UYY=
Date:   Sat, 25 Sep 2021 16:12:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.15-rc3
Message-ID: <YU8uYP1TwVMTvh52@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.15-rc3

for you to fetch changes up to 0292dbd7bd779b878942c3977507459f8a3e4e78:

  Merge tag 'usb-serial-5.15-rc3' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2021-09-24 10:22:53 +0200)

----------------------------------------------------------------
USB driver fixes for 5.15-rc3

Here are some USB driver fixes and new device ids for 5.15-rc3.

They include:
	- usb-storage quirk additions
	- usb-serial new device ids
	- usb-serial driver fixes
	- USB roothub registration bugfix to resolve a long-reported
	  issue
	- usb gadget driver fixes for a large number of small things
	- dwc2 driver fixes

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Carlo Lobrano (1):
      USB: serial: option: add Telit LN920 compositions

Dan Carpenter (2):
      usb: gadget: r8a66597: fix a loop in set_feature()
      usb: musb: tusb6010: uninitialized data in tusb_fifo_write_unaligned()

Faizel K B (1):
      usb: testusb: Fix for showing the connection speed

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-5.15-rc3' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Guenter Roeck (1):
      usb: ehci: Simplify platform driver registration

Jack Pham (2):
      usb: gadget: f_uac2: Add missing companion descriptor for feedback EP
      usb: gadget: f_uac2: Populate SS descriptors' wBytesPerInterval

Jiri Slaby (1):
      MAINTAINERS: usb, update Peter Korsgaard's entries

Johan Hovold (3):
      USB: cdc-acm: fix minor-number release
      USB: serial: cp210x: fix dropped characters with CP2102
      USB: serial: cp210x: add part-number debug printk

Julian Sikorski (1):
      Re-enable UAS for LaCie Rugged USB3-FW with fk quirk

Kishon Vijay Abraham I (3):
      usb: core: hcd: Add support for deferring roothub registration
      xhci: Set HCD flag to defer primary roothub registration
      usb: core: hcd: Modularize HCD stop configuration in usb_stop_hcd()

Krzysztof Kozlowski (2):
      USB: serial: mos7840: remove duplicated 0xac24 device ID
      USB: serial: option: remove duplicate USB device ID

Li Jun (1):
      usb: dwc3: core: balance phy init and exit

Minas Harutyunyan (2):
      usb: dwc2: gadget: Fix ISOC flow for BDMA and Slave
      usb: dwc2: gadget: Fix ISOC transfer complete handling for DDMA

Ondrej Zary (1):
      usb-storage: Add quirk for ScanLogic SL11R-IDE older than 2.6c

Pavel Hofman (1):
      usb: gadget: u_audio: EP-OUT bInterval in fback frequency

Pawel Laszczak (1):
      usb: cdns3: fix race condition before setting doorbell

Rafał Miłecki (1):
      Revert "USB: bcma: Add a check for devm_gpiod_get"

Robert Marko (1):
      arm64: dts: qcom: ipq8074: remove USB tx-fifo-resize property

Slark Xiao (1):
      USB: serial: option: add device id for Foxconn T99W265

Uwe Brandt (1):
      USB: serial: cp210x: add ID for GW Instek GDM-834x Digital Multimeter

Yang Yingliang (1):
      usb: dwc2: check return value after calling platform_get_resource()

 MAINTAINERS                           |   5 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi |   2 -
 drivers/usb/cdns3/cdns3-gadget.c      |  14 +++
 drivers/usb/class/cdc-acm.c           |   7 +-
 drivers/usb/class/cdc-acm.h           |   2 +
 drivers/usb/core/hcd.c                |  68 ++++++++----
 drivers/usb/dwc2/gadget.c             | 193 +++++++++++++++++++---------------
 drivers/usb/dwc2/hcd.c                |   4 +
 drivers/usb/dwc3/core.c               |  30 +++---
 drivers/usb/gadget/function/f_uac2.c  |  19 +++-
 drivers/usb/gadget/function/u_audio.c |  13 ++-
 drivers/usb/gadget/udc/r8a66597-udc.c |   2 +-
 drivers/usb/host/bcma-hcd.c           |   5 +-
 drivers/usb/host/ehci-hcd.c           |  75 +++++--------
 drivers/usb/host/xhci.c               |   1 +
 drivers/usb/musb/tusb6010.c           |   1 +
 drivers/usb/serial/cp210x.c           |  38 +++++++
 drivers/usb/serial/mos7840.c          |   2 -
 drivers/usb/serial/option.c           |  11 +-
 drivers/usb/storage/unusual_devs.h    |   9 +-
 drivers/usb/storage/unusual_uas.h     |   2 +-
 include/linux/usb/hcd.h               |   2 +
 tools/usb/testusb.c                   |  14 +--
 23 files changed, 318 insertions(+), 201 deletions(-)
