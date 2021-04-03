Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D4035337E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 12:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbhDCKwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 06:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236572AbhDCKud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 06:50:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E983A61006;
        Sat,  3 Apr 2021 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617447031;
        bh=ftYKzwzl0etbwfwVgR8wQejv9PrD7e36U+Wq1528puU=;
        h=Date:From:To:Cc:Subject:From;
        b=cNlg7N8TrZtMHNvv+YaZPepgikAdNETO0OD0l9mVY/LzoJTA4nFlfSDGEXf8+pp+B
         RtKGANllcA393QLXcwdx6wAmN2IMf6xZTUDqObzx3hJKOKh4L4vQ5UAhNcTbXkgslY
         ccBLIbtUXDWqsQT6BTXCuc7cEoaFor/1YydJmd1M=
Date:   Sat, 3 Apr 2021 12:50:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.12-rc6
Message-ID: <YGhIdRHZmIIavNM3@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.12-rc6

for you to fetch changes up to 93f672804bf2d7a49ef3fd96827ea6290ca1841e:

  usb: dwc2: Prevent core suspend when port connection flag is 0 (2021-03-26 14:51:34 +0100)

----------------------------------------------------------------
USB fixes for 5.12-rc6

Here are a few small USB driver fixes for 5.12-rc6 to resolve reported
problems.

They include:
	- a number of cdc-acm fixes for reported problems.  It seems
	  more people are using this driver lately...
	- dwc3 driver fixes for reported problems, and fixes for the
	  fixes :)
	- dwc2 driver fixes for reported issues.
	- musb driver fix.
	- new USB quirk additions.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      usb: dwc3: pci: Enable dis_uX_susphy_quirk for Intel Merrifield

Artur Petrosyan (2):
      usb: dwc2: Fix HPRT0.PrtSusp bit setting for HiKey 960 board.
      usb: dwc2: Prevent core suspend when port connection flag is 0

Chunfeng Yun (1):
      usb: xhci-mtk: fix broken streams issue on 0.96 xHCI

Johan Hovold (8):
      USB: cdc-acm: fix double free on probe failure
      USB: cdc-acm: fix use-after-free after probe failure
      USB: cdc-acm: drop redundant driver-data assignment
      USB: cdc-acm: drop redundant driver-data reset
      USB: cdc-acm: clean up probe error labels
      USB: cdc-acm: use negation for NULL checks
      USB: cdc-acm: always claim data interface
      USB: cdc-acm: do not log successful probe on later errors

Oliver Neukum (3):
      cdc-acm: fix BREAK rx code path adding necessary calls
      USB: cdc-acm: untangle a circular dependency between callback and softint
      USB: cdc-acm: downgrade message to debug

Shawn Guo (1):
      usb: dwc3: qcom: skip interconnect init for ACPI probe

Shuah Khan (1):
      usbip: vhci_hcd fix shift out-of-bounds in vhci_hub_control()

Thinh Nguyen (2):
      usb: dwc3: gadget: Set gadget_max_speed when set ssp_rate
      usb: dwc3: gadget: Use max speed if unspecified

Tong Zhang (1):
      usb: gadget: udc: amd5536udc_pci fix null-ptr-dereference

Tony Lindgren (1):
      usb: musb: Fix suspend with devices connected for a64

Vincent Palatin (1):
      USB: quirks: ignore remote wake-up on Fibocom L850-GL LTE modem

Wesley Cheng (1):
      usb: dwc3: gadget: Clear DEP flags after stop transfers in ep disable

 drivers/usb/class/cdc-acm.c             | 120 +++++++++++++++++++-------------
 drivers/usb/core/quirks.c               |   4 ++
 drivers/usb/dwc2/hcd.c                  |   5 +-
 drivers/usb/dwc3/dwc3-pci.c             |   2 +
 drivers/usb/dwc3/dwc3-qcom.c            |   3 +
 drivers/usb/dwc3/gadget.c               |  11 +--
 drivers/usb/gadget/udc/amd5536udc_pci.c |  10 +--
 drivers/usb/host/xhci-mtk.c             |  10 ++-
 drivers/usb/musb/musb_core.c            |  12 ++--
 drivers/usb/usbip/vhci_hcd.c            |   2 +
 10 files changed, 112 insertions(+), 67 deletions(-)
