Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0590C426E75
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhJHQO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:32810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhJHQOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:14:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5842261038;
        Fri,  8 Oct 2021 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633709548;
        bh=l9NKonv+O2PXkvQdUpXNKXFolGTbnrr6j94U8d7AgSM=;
        h=Date:From:To:Cc:Subject:From;
        b=AEN+wYdH7DUCcS+PkPU3rle/AaRcvd0hw0VSsE/tZXmyPGkGyFjLAFw54AiU4bQ8s
         /JHO1EyBDoHzNsepgBludb5GbL++SZluKNAI2rNPGt24K9MStvL4m9YS1+lLYszxXX
         QOHSkmrJuOIlwn82npWG2yCmGGYdd7iQ82a48Syw=
Date:   Fri, 8 Oct 2021 18:12:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.15-rc5
Message-ID: <YWBt6v3kWkjcJcp0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.15-rc5

for you to fetch changes up to 58fc1daa4d2e9789b9ffc880907c961ea7c062cc:

  USB: cdc-acm: fix break reporting (2021-10-05 13:50:52 +0200)

----------------------------------------------------------------
USB fixes for 5.15-rc5

Here are some small USB fixes for 5.15-rc5 that resolve a number of
reported issues:
	- gadget driver fixes
	- xhci build warning fixes
	- build configuration fix
	- cdc-acm tty handling fixes
	- cdc-wdm fix
	- typec fixes

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      usb: dwc3: gadget: Revert "set gadgets parent to the right controller"

Arnd Bergmann (1):
      usb: xhci: tegra: mark PM functions as __maybe_unused

Ben Hutchings (1):
      Partially revert "usb: Kconfig: using select for USB_COMMON dependency"

Fabio Estevam (1):
      usb: chipidea: ci_hdrc_imx: Also search for 'phys' phandle

Heikki Krogerus (1):
      usb: typec: tipd: Remove dependency on "connector" child fwnode

Johan Hovold (2):
      USB: cdc-acm: fix racy tty buffer accesses
      USB: cdc-acm: fix break reporting

Pavel Hofman (1):
      usb: gadget: f_uac2: fixed EP-IN wMaxPacketSize

Rikard Falkeborn (1):
      usb: cdc-wdm: Fix check for WWAN

Xu Yang (2):
      usb: typec: tcpci: don't handle vSafe0V event if it's not enabled
      usb: typec: tcpm: handle SRC_STARTUP state if cc changes

 drivers/usb/chipidea/ci_hdrc_imx.c   | 15 ++++++++++-----
 drivers/usb/class/cdc-acm.c          |  8 ++++++++
 drivers/usb/class/cdc-wdm.c          |  6 +++---
 drivers/usb/common/Kconfig           |  3 +--
 drivers/usb/dwc3/gadget.c            |  2 +-
 drivers/usb/gadget/function/f_uac2.c | 14 ++++++++++----
 drivers/usb/host/xhci-tegra.c        | 12 ++++--------
 drivers/usb/typec/tcpm/tcpci.c       |  2 +-
 drivers/usb/typec/tcpm/tcpm.c        |  1 +
 drivers/usb/typec/tipd/core.c        |  8 +++-----
 10 files changed, 42 insertions(+), 29 deletions(-)
