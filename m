Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A1D381D7F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 11:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhEPJBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 05:01:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhEPJBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 05:01:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9F8A6100C;
        Sun, 16 May 2021 09:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621155604;
        bh=KL+76SwYHYbW6KLhpURnfNwEzzg2zJzq1M0TeQLjPZ0=;
        h=Date:From:To:Cc:Subject:From;
        b=EtHA/2/e1raREY2lVU7Jz3Xeg6jPDQPKzJk2AWouhXBblowmLJzIQrCvzUg+bCZOg
         WeOGBLWVr1vFCQiRtdcDP46axt1JauwiJGwnDKx/vKS36tJSj0UL5m8323/VX/fRv9
         A0M4mgMdq2FVMnUS/wfRP5oZmP84ynPe/dFz8avM=
Date:   Sun, 16 May 2021 10:59:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.13-rc2
Message-ID: <YKDfDeaFp966UjS1@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.13-rc2

for you to fetch changes up to 975f94c7d6c306b833628baa9aec3f79db1eb3a1:

  usb: core: hub: fix race condition about TRSMRCY of resume (2021-05-13 16:00:24 +0200)

----------------------------------------------------------------
USB fixes for 5.13-rc2

Here are some small USB fixes for 5.13-rc2.  They consist of a number of
resolutions for reported issues:
	- typec fixes for found problems
	- xhci fixes and quirk additions
	- dwc3 driver fixes
	- minor fixes found by Coverity
	- cdc-wdm fixes for reported problems

All of these have been in linux-next for a few days with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abhijeet Rao (1):
      xhci-pci: Allow host runtime PM as default for Intel Alder Lake xHCI

Andy Shevchenko (1):
      usb: typec: ucsi: Put fwnode in any case during ->probe()

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Fix SINK_DISCOVERY current limit for Rp-default

Christophe JAILLET (3):
      usb: fotg210-hcd: Fix an error message
      usb: musb: Fix an error message
      xhci: Do not use GFP_KERNEL in (potentially) atomic context

Chunfeng Yun (1):
      usb: core: hub: fix race condition about TRSMRCY of resume

Fabio Estevam (1):
      usb: Restore the reference to ch9.h

Ferry Toth (1):
      usb: dwc3: pci: Enable usb2-gadget-lpm-disable for Intel Merrifield

Jack Pham (4):
      usb: dwc3: gadget: Enable suspend events
      usb: dwc3: gadget: Rename EOPF event macros to Suspend
      usb: dwc3: gadget: Free gadget structure only after freeing endpoints
      usb: typec: ucsi: Retrieve all the PDOs instead of just the first 4

Kyle Tso (3):
      usb: typec: tcpm: Fix wrong handling in GET_SINK_CAP
      usb: typec: tcpm: Send DISCOVER_IDENTITY from dedicated work
      usb: typec: tcpm: Fix wrong handling for Not_Supported in VDM AMS

Li Jun (1):
      usb: dwc3: imx8mp: detect dwc3 core node via compatible string

Marcel Hamer (1):
      usb: dwc3: omap: improve extcon initialization

Mathias Nyman (1):
      xhci: Fix giving back cancelled URBs even if halted endpoint can't reset

Matthijs Kooijman (1):
      usb: dwc2: Remove obsolete MODULE_ constants from platform.c

Maximilian Luz (1):
      usb: xhci: Increase timeout for HC halt

Oliver Neukum (1):
      cdc-wdm: untangle a circular dependency between callback and softint

Phil Elwell (1):
      usb: dwc2: Fix gadget DMA unmap direction

Sandeep Singh (1):
      xhci: Add reset resume quirk for AMD xhci controller.

Thinh Nguyen (1):
      usb: dwc3: core: Add missing GHWPARAMS9 doc

Wei Ming Chen (1):
      docs: usb: function: Modify path name

Wesley Cheng (1):
      usb: dwc3: gadget: Return success always for kick transfer in ep queue

Zhen Lei (1):
      usb: dwc3: imx8mp: fix error return code in dwc3_imx8mp_probe()

 Documentation/driver-api/usb/usb.rst  |  15 +++--
 Documentation/usb/gadget_configfs.rst |   2 +-
 drivers/usb/class/cdc-wdm.c           |  30 +++++++---
 drivers/usb/core/hub.c                |   6 +-
 drivers/usb/dwc2/core.h               |   2 +
 drivers/usb/dwc2/gadget.c             |   3 +-
 drivers/usb/dwc2/platform.c           |   4 --
 drivers/usb/dwc3/core.h               |   7 ++-
 drivers/usb/dwc3/debug.h              |   8 +--
 drivers/usb/dwc3/dwc3-imx8mp.c        |   3 +-
 drivers/usb/dwc3/dwc3-omap.c          |   5 ++
 drivers/usb/dwc3/dwc3-pci.c           |   1 +
 drivers/usb/dwc3/gadget.c             |  13 ++++-
 drivers/usb/host/fotg210-hcd.c        |   4 +-
 drivers/usb/host/xhci-ext-caps.h      |   5 +-
 drivers/usb/host/xhci-pci.c           |   8 ++-
 drivers/usb/host/xhci-ring.c          |  16 ++++--
 drivers/usb/host/xhci.c               |   6 +-
 drivers/usb/musb/mediatek.c           |   2 +-
 drivers/usb/typec/tcpm/tcpm.c         | 103 +++++++++++++++++++++++++++++-----
 drivers/usb/typec/ucsi/ucsi.c         |  46 +++++++++++----
 drivers/usb/typec/ucsi/ucsi.h         |   6 +-
 22 files changed, 220 insertions(+), 75 deletions(-)
