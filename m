Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A61311DA6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 15:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhBFOZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 09:25:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhBFOZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 09:25:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DE0F60202;
        Sat,  6 Feb 2021 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612621486;
        bh=/p4zLyT/sglIdYpclSaSgJPTKSydYopRWQ786pmalgk=;
        h=Date:From:To:Cc:Subject:From;
        b=DCtcwc3p1UqKmsDttVMygYfzhM8RnjEUI4TyRDpGr6uW8/+wSYjoc4ByOydSC9znI
         bpiJiIFHFSHFp/ZlWXjxFR12unKI2hUrIAVenRLu03VMO2ERVGjzIuC9acxrQB03cq
         TmgBooqD15kSPpqHhL46t2MgDswUn3FlWSiGUjGA=
Date:   Sat, 6 Feb 2021 15:24:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.11-rc7
Message-ID: <YB6mrF7MGZ7AsN3m@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.11-rc7

for you to fetch changes up to f670e9f9c8cac716c3506c6bac9e997b27ad441a:

  usb: dwc2: Fix endpoint direction check in ep_from_windex (2021-02-05 10:28:38 +0100)

----------------------------------------------------------------
USB fixes for 5.11-rc7

Here are some small, last-minute, USB driver fixes for 5.11-rc7

They all resolve issues reported, or are a few new device ids for some
drivers.  They include:
	- new device ids for some usb-serial drivers
	- xhci fixes for a variety of reported problems
	- dwc3 driver bugfixes
	- dwc2 driver bugfixes
	- usblp driver bugfix
	- thunderbolt bugfix
	- few other tiny fixes

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Chenxin Jin (1):
      USB: serial: cp210x: add new VID/PID for supporting Teraoka AD2000

Christoph Schemmel (1):
      USB: serial: option: Adding support for Cinterion MV31

Chunfeng Yun (2):
      usb: xhci-mtk: skip dropping bandwidth of unchecked endpoints
      usb: xhci-mtk: break loop when find the endpoint to drop

Dan Carpenter (1):
      USB: gadget: legacy: fix an error code in eth_bind()

Gary Bisson (1):
      usb: dwc3: fix clock issue during resume in OTG mode

Greg Kroah-Hartman (2):
      Merge tag 'usb-serial-5.11-rc6' of https://git.kernel.org/.../johan/usb-serial into usb-linus
      Merge tag 'thunderbolt-for-v5.11-rc7' of git://git.kernel.org/.../westeri/thunderbolt into usb-linus

Heiko Stuebner (1):
      usb: dwc2: Fix endpoint direction check in ep_from_windex

Ikjoon Jang (1):
      usb: xhci-mtk: fix unreleased bandwidth data

Jeremy Figgins (1):
      USB: usblp: don't call usb_set_interface if there's a single alt

Mario Limonciello (1):
      thunderbolt: Fix possible NULL pointer dereference in tb_acpi_add_link()

Mathias Nyman (1):
      xhci: fix bounce buffer usage for non-sg list case

Pali Rohár (1):
      usb: host: xhci: mvebu: make USB 3.0 PHY optional for Armada 3720

Pho Tran (1):
      USB: serial: cp210x: add pid/vid for WSDA-200-USB

Yoshihiro Shimoda (1):
      usb: renesas_usbhs: Clear pipe running flag in usbhs_pkt_pop()

kernel test robot (1):
      usb: gadget: aspeed: add missing of_node_put

 drivers/thunderbolt/acpi.c               |   2 +-
 drivers/usb/class/usblp.c                |  19 +++--
 drivers/usb/dwc2/gadget.c                |   8 +-
 drivers/usb/dwc3/core.c                  |   2 +-
 drivers/usb/gadget/legacy/ether.c        |   4 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c |   4 +-
 drivers/usb/host/xhci-mtk-sch.c          | 130 ++++++++++++++++++++++---------
 drivers/usb/host/xhci-mtk.c              |   2 +
 drivers/usb/host/xhci-mtk.h              |  15 ++++
 drivers/usb/host/xhci-mvebu.c            |  42 ++++++++++
 drivers/usb/host/xhci-mvebu.h            |   6 ++
 drivers/usb/host/xhci-plat.c             |  20 ++++-
 drivers/usb/host/xhci-plat.h             |   1 +
 drivers/usb/host/xhci-ring.c             |  31 +++++---
 drivers/usb/host/xhci.c                  |   8 +-
 drivers/usb/host/xhci.h                  |   4 +
 drivers/usb/renesas_usbhs/fifo.c         |   1 +
 drivers/usb/serial/cp210x.c              |   2 +
 drivers/usb/serial/option.c              |   6 ++
 19 files changed, 237 insertions(+), 70 deletions(-)
