Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1DA45F0A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354369AbhKZP3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377965AbhKZP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:27:48 -0500
X-Greylist: delayed 393 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Nov 2021 07:21:37 PST
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8921DC061799;
        Fri, 26 Nov 2021 07:21:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEE8BB827FE;
        Fri, 26 Nov 2021 15:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF96EC93056;
        Fri, 26 Nov 2021 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637939699;
        bh=yg4VdOJC94cNcEe+lgB1DuRUh7T1fIAIuVACWKrp3h8=;
        h=Date:From:To:Cc:Subject:From;
        b=oC0qL6yyQMlUT+3XALCVMRKESV5TttJ9LZQipg6IYNFNZO+uUgl4PVvJNiREVlvCk
         yr3NQtDNBMjJ4ev4LrZ2CsHiemLp46Jx/ynKprxy/LK6COa7cdOyTwDMY2l/lLhWwj
         iWdDgYR3Jn6f5IxiSy6XtIUYRxBHzy2SpaMBKP5g=
Date:   Fri, 26 Nov 2021 16:14:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.16-rc3
Message-ID: <YaD577+IUWacSYBm@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8ab774587903771821b59471cc723bba6d893942:

  Merge tag 'trace-v5.16-5' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2021-11-14 19:07:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16-rc1

for you to fetch changes up to a88db2ecc2d2c11aa8744be9817d6d249d001cca:

  Merge tag 'usb-serial-5.16-rc3' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2021-11-25 13:27:40 +0100)

----------------------------------------------------------------
USB fixes for 5.16-rc3

Here are a number of small USB fixes for reported problems for 5.16-rc3

Then include:
	- typec driver fixes
	- new usb-serial driver ids
	- usb hub enumeration issues that were much reported
	- gadget driver fixes
	- dwc3 driver fix
	- chipidea driver fixe

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Albert Wang (1):
      usb: dwc3: gadget: Fix null pointer exception

Christophe JAILLET (1):
      usb: gadget: udc-xilinx: Fix an error handling path in 'xudc_probe()'

Dan Carpenter (1):
      usb: chipidea: ci_hdrc_imx: fix potential error pointer dereference in probe

Daniele Palmas (1):
      USB: serial: option: add Telit LE910S1 0x9200 composition

Dmitry Osipenko (1):
      usb: xhci: tegra: Check padctrl interrupt presence in device tree

Fabio Aiuto (1):
      usb: dwc3: leave default DMA for PCI devices

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-5.16-rc3' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Hector Martin (2):
      usb: typec: tipd: Fix typo in cd321x_switch_power_state
      usb: typec: tipd: Fix initialization sequence for cd321x

Johan Hovold (1):
      USB: serial: pl2303: fix GC type detection

Mathias Nyman (2):
      usb: hub: Fix usb enumeration issue due to address0 race
      usb: hub: Fix locking issues with address0_mutex

Minas Harutyunyan (1):
      usb: dwc2: gadget: Fix ISOC flow for elapsed frames

Mingjie Zhang (1):
      USB: serial: option: add Fibocom FM101-GL variants

Nathan Chancellor (1):
      usb: dwc2: hcd_queue: Fix use of floating point literal

Ondrej Jirman (1):
      usb: typec: fusb302: Fix masking of comparator and bc_lvl interrupts

Thinh Nguyen (3):
      usb: dwc3: core: Revise GHWPARAMS9 offset
      usb: dwc3: gadget: Ignore NoStream after End Transfer
      usb: dwc3: gadget: Check for L1/L2/U3 for Start Transfer

 drivers/usb/chipidea/ci_hdrc_imx.c  | 18 ++++++++--------
 drivers/usb/core/hub.c              | 24 ++++++++++++++++------
 drivers/usb/dwc2/gadget.c           | 17 ++++++++++++---
 drivers/usb/dwc2/hcd_queue.c        |  2 +-
 drivers/usb/dwc3/core.c             |  8 +++++---
 drivers/usb/dwc3/core.h             |  2 +-
 drivers/usb/dwc3/gadget.c           | 39 +++++++++++++++++++++++++----------
 drivers/usb/gadget/udc/udc-xilinx.c |  5 ++++-
 drivers/usb/host/xhci-tegra.c       | 41 ++++++++++++++++++++++++++-----------
 drivers/usb/serial/option.c         |  5 +++++
 drivers/usb/serial/pl2303.c         |  1 +
 drivers/usb/typec/tcpm/fusb302.c    |  6 ++++--
 drivers/usb/typec/tipd/core.c       | 35 +++++++++++++++----------------
 13 files changed, 136 insertions(+), 67 deletions(-)
