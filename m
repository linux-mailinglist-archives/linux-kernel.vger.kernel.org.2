Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD3E3E39F8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 13:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhHHLbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 07:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhHHLbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 07:31:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8C8E60F9E;
        Sun,  8 Aug 2021 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628422244;
        bh=zy73ATk0gUClhvKF91vC+jx4QIns/T1Il9uBoVlX41I=;
        h=Date:From:To:Cc:Subject:From;
        b=aEFRbgSSJDSbyJda+n+GcFa+Wr8avXnk0WmQnmAWIKeDcJhtSXpqUtlNy1BqLM4rS
         99rbmRsRECrkUO41UudsphMwgtsWD2HYIhvb3C7PqYkRW7jVRPdG2f1tc+PAZzKga3
         XgGpSiDAnA2iwdbtqyXTTYA71psUX8b5ugG/HiaU=
Date:   Sun, 8 Aug 2021 13:30:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.14-rc5
Message-ID: <YQ/AYY7G/5Dq8wRh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.14-rc5

for you to fetch changes up to 43ad944cd73f2360ec8ff31d29ea44830b3119af:

  usb: typec: tcpm: Keep other events when receiving FRS and Sourcing_vbus events (2021-08-05 12:27:43 +0200)

----------------------------------------------------------------
USB driver fixes for 5.14-rc5

Here are some small USB driver fixes for 5.14-rc5.  They resolve a
number of small reported issues, including:
	- cdnsp driver fixes
	- usb serial driver fixes and device id updates
	- usb gadget hid fixes
	- usb host driver fixes
	- usb dwc3 driver fixes
	- other usb gadget driver fixes

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Christophe JAILLET (1):
      usb: cdnsp: Fix the IMAN_IE_SET and IMAN_IE_CLEAR macro

Claudiu Beznea (1):
      usb: host: ohci-at91: suspend/resume ports after/before OHCI accesses

Daniele Palmas (1):
      USB: serial: option: add Telit FD980 composition 0x1056

David Bauer (1):
      USB: serial: ftdi_sio: add device ID for Auto-M3 OP-COM v2

Dmitry Osipenko (1):
      usb: otg-fsm: Fix hrtimer list corruption

Greg Kroah-Hartman (2):
      Merge tag 'usb-v5.14-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-linus
      Merge tag 'usb-serial-5.14-rc5' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Johan Hovold (2):
      USB: serial: pl2303: fix HX type detection
      USB: serial: pl2303: fix GT type detection

Kyle Tso (1):
      usb: typec: tcpm: Keep other events when receiving FRS and Sourcing_vbus events

Maxim Devaev (2):
      usb: gadget: f_hid: added GET_IDLE and SET_IDLE handlers
      usb: gadget: f_hid: idle uses the highest byte for duration

Mika Westerberg (1):
      Revert "thunderbolt: Hide authorized attribute if router does not support PCIe tunnels"

Pawel Laszczak (3):
      usb: cdns3: Fixed incorrect gadget state
      usb: cdnsp: Fix incorrect supported maximum speed
      usb: cdnsp: Fixed issue with ZLP

Phil Elwell (1):
      usb: gadget: f_hid: fixed NULL pointer dereference

Qiang.zhang (1):
      USB: usbtmc: Fix RCU stall warning

Tony Lindgren (1):
      usb: musb: Fix suspend and resume issues for PHYs on I2C and SPI

Wesley Cheng (2):
      usb: dwc3: gadget: Use list_replace_init() before traversing lists
      usb: dwc3: gadget: Avoid runtime resume if disabling pullup

Willy Tarreau (1):
      USB: serial: ch341: fix character loss at high transfer rates

Zhang Qilong (1):
      usb: gadget: remove leaked entry from udc driver list

 drivers/thunderbolt/switch.c         | 15 +-----------
 drivers/usb/cdns3/cdns3-ep0.c        |  1 +
 drivers/usb/cdns3/cdnsp-gadget.c     |  2 +-
 drivers/usb/cdns3/cdnsp-gadget.h     |  4 ++--
 drivers/usb/cdns3/cdnsp-ring.c       | 18 +++++++--------
 drivers/usb/class/usbtmc.c           |  9 +-------
 drivers/usb/common/usb-otg-fsm.c     |  6 ++++-
 drivers/usb/dwc3/gadget.c            | 29 ++++++++++++++++++++++--
 drivers/usb/gadget/function/f_hid.c  | 44 +++++++++++++++++++++++++++++++-----
 drivers/usb/gadget/udc/max3420_udc.c | 14 ++++++++----
 drivers/usb/host/ohci-at91.c         |  9 ++++----
 drivers/usb/musb/omap2430.c          | 43 +++++++++++++++++++++++++++++++----
 drivers/usb/serial/ch341.c           |  1 +
 drivers/usb/serial/ftdi_sio.c        |  1 +
 drivers/usb/serial/ftdi_sio_ids.h    |  3 +++
 drivers/usb/serial/option.c          |  2 ++
 drivers/usb/serial/pl2303.c          | 42 +++++++++++++++++++++-------------
 drivers/usb/typec/tcpm/tcpm.c        |  4 ++--
 include/linux/usb/otg-fsm.h          |  1 +
 19 files changed, 173 insertions(+), 75 deletions(-)
