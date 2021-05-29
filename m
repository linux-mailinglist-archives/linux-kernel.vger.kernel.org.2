Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFA1394C7B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 16:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhE2O2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 10:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhE2O2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 10:28:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3B1F6120A;
        Sat, 29 May 2021 14:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622298387;
        bh=FKf2xX/cJGbi4a7aLLpJcoRFwj8OpQFuybWTutvx3c4=;
        h=Date:From:To:Cc:Subject:From;
        b=rj+FbVqS5i/RROH3CPb5oJFs0R1gutwdDn3vK3Er2Tu3gv/Va87jQbImnsa6Gy/Ab
         jxEurKG6aHJYylEbgRN/e9qhJFM+nDMsoK/vXVzPi0AwUze7bUa56vrz0hlZYEHejV
         Jl/VH0EPFDhSFlypvh+O20ou2CBMhZFqIXulMCJ0=
Date:   Sat, 29 May 2021 16:26:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt driver fixes for 5.13-rc4
Message-ID: <YLJPEdFdHVjetmM5@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.13-rc4

for you to fetch changes up to a7f2e9272aff1ccfe0fc801dab1d5a7a1c6b7ed2:

  xhci: Fix 5.12 regression of missing xHC cache clearing command after a Stall (2021-05-25 10:21:47 +0200)

----------------------------------------------------------------
USB / Thunderbolt fixes for 5.13-rc4

Here are a number of tiny USB and Thunderbolt driver fixes for 5.13-rc4.

They consist of:
	- thunderbolt fixes for	some NVM bound issues
	- xhci fixes for reported problems
	- control-request fixups
	- documentation build warning fixes
	- new usb-serial driver device ids
	- typec bugfixes for reported issues
	- usbfs warning fixups (could be triggered from userspace)
	- other tiny fixes for reported problems.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: usbfs: Don't WARN about excessively large memory allocations

Andy Shevchenko (1):
      usb: typec: tcpm: Use LE to CPU conversion when accessing msg->header

Bjorn Andersson (2):
      usb: typec: mux: Fix matching with typec_altmode_desc
      usb: typec: ucsi: Clear pending after acking connector change

Daniele Palmas (1):
      USB: serial: option: add Telit LE910-S1 compositions 0x7010, 0x7011

Dinghao Liu (1):
      usb: cdns3: Fix runtime PM imbalance on error

Dominik Andreas Schorpp (1):
      USB: serial: ftdi_sio: add IDs for IDS GmbH Products

Dongliang Mu (1):
      misc/uss720: fix memory leak in uss720_probe

Fabio Estevam (1):
      usb: Restore the usb_header label

Greg Kroah-Hartman (3):
      Merge tag 'usb-serial-5.13-rc3' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus
      Merge tag 'usb-v5.13-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-linus
      Merge tag 'thunderbolt-for-v5.13-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus

Johan Hovold (1):
      USB: trancevibrator: fix control-request direction

Kyle Tso (2):
      usb: typec: tcpm: Properly interrupt VDM AMS
      usb: typec: tcpm: Respond Not_Supported if no snk_vdo

Li Jun (1):
      usb: chipidea: udc: assign interrupt number to USB gadget structure

Mathias Nyman (4):
      thunderbolt: dma_port: Fix NVM read buffer bounds and offset issue
      thunderbolt: usb4: Fix NVM read buffer bounds and offset issue
      xhci: fix giving back URB with incorrect status regression in 5.12
      xhci: Fix 5.12 regression of missing xHC cache clearing command after a Stall

Pawel Laszczak (1):
      usb: cdnsp: Fix lack of removing request from pending list.

Sean MacLennan (1):
      USB: serial: ti_usb_3410_5052: add startech.com device id

Thinh Nguyen (1):
      usb: dwc3: gadget: Properly track pending and queued SG

Yoshihiro Shimoda (1):
      usb: gadget: udc: renesas_usb3: Fix a race in usb3_start_pipen()

Zolton Jheng (1):
      USB: serial: pl2303: add device id for ADLINK ND-6530 GC

 Documentation/driver-api/usb/usb.rst  |  2 ++
 drivers/thunderbolt/dma_port.c        | 11 +++++-----
 drivers/thunderbolt/usb4.c            |  9 ++++----
 drivers/usb/cdns3/cdns3-gadget.c      |  4 +++-
 drivers/usb/cdns3/cdnsp-gadget.c      | 14 ++++++-------
 drivers/usb/chipidea/udc.c            |  1 +
 drivers/usb/core/devio.c              | 11 +++++++---
 drivers/usb/dwc3/gadget.c             | 13 ++++++------
 drivers/usb/gadget/udc/renesas_usb3.c |  5 +++--
 drivers/usb/host/xhci-ring.c          | 14 ++++++-------
 drivers/usb/misc/trancevibrator.c     |  4 ++--
 drivers/usb/misc/uss720.c             |  1 +
 drivers/usb/serial/ftdi_sio.c         |  3 +++
 drivers/usb/serial/ftdi_sio_ids.h     |  7 +++++++
 drivers/usb/serial/option.c           |  4 ++++
 drivers/usb/serial/pl2303.c           |  1 +
 drivers/usb/serial/pl2303.h           |  1 +
 drivers/usb/serial/ti_usb_3410_5052.c |  3 +++
 drivers/usb/typec/mux.c               |  7 ++++---
 drivers/usb/typec/tcpm/tcpm.c         | 39 ++++++++++++++++++++++++++++++++---
 drivers/usb/typec/ucsi/ucsi.c         |  2 +-
 21 files changed, 112 insertions(+), 44 deletions(-)
