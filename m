Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB504343277
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 13:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCUMcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 08:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhCUMb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 08:31:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5D7761946;
        Sun, 21 Mar 2021 12:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616329917;
        bh=R9ndp25O5jaeMmSShQmqOo8nfPyqkJSIUbdSkrz0DD8=;
        h=Date:From:To:Cc:Subject:From;
        b=iRt/4MOVj8LF5PYdTKOz0TQS35HGQjPo2QerSEP0EoabmRnE8PJxNahd2jKCDIPKJ
         xYd6KPogxJ9FLVVehVQkw+Ix9a2y1z3P48u53J2wCJlloIfsLPLt5tdoneuKBijSID
         Z6oLI2Rc0mRx/RUBdt1dUxas/MXeoN8cT8o1Lcy0=
Date:   Sun, 21 Mar 2021 13:31:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt driver fixes for 5.12-rc4
Message-ID: <YFc8ump8iC8fj2pa@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.12-rc4

for you to fetch changes up to 2b8c956ea6ba896ec18ae36c2684ecfa04c1f479:

  usb: typec: tcpm: Skip sink_cap query only when VDM sm is busy (2021-03-18 09:47:47 +0100)

----------------------------------------------------------------
USB / Thunderbolt driver fixes for 5.12-rc4

Here are some small Thunderbolt and USB driver fixes for some reported
issues:
	- thunderbolt fixes for minor problems
	- typec fixes for power issues
	- usb-storage quirk addition
	- usbip bugfix
	- dwc3 bugfix when stopping transfers
	- cdnsp bugfix for isoc transfers
	- gadget use-after-free fix

All have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      usb-storage: Add quirk to defeat Kindle's automatic unload

Badhri Jagan Sridharan (2):
      usb: typec: tcpm: Invoke power_supply_changed for tcpm-source-psy-
      usb: typec: tcpm: Skip sink_cap query only when VDM sm is busy

Colin Ian King (1):
      usbip: Fix incorrect double assignment to udc->ud.tcp_rx

Elias Rudberg (1):
      usb: typec: Remove vdo[3] part of tps6598x_rx_identity_reg struct

Greg Kroah-Hartman (2):
      Merge tag 'thunderbolt-for-v5.12-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus
      Merge tag 'usb-v5.12-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-linus

Jim Lin (1):
      usb: gadget: configfs: Fix KASAN use-after-free

Mika Westerberg (2):
      thunderbolt: Initialize HopID IDAs in tb_switch_alloc()
      thunderbolt: Increase runtime PM reference count on DP tunnel discovery

Pawel Laszczak (1):
      usb: cdnsp: Fixes incorrect value in ISOC TRB

Wesley Cheng (1):
      usb: dwc3: gadget: Prevent EP queuing while stopping transfers

 drivers/thunderbolt/switch.c       | 18 ++++++++----------
 drivers/thunderbolt/tb.c           |  4 ++++
 drivers/usb/cdns3/cdnsp-ring.c     |  5 ++++-
 drivers/usb/dwc3/gadget.c          | 11 +++++------
 drivers/usb/gadget/configfs.c      | 14 ++++++++++----
 drivers/usb/storage/transport.c    |  7 +++++++
 drivers/usb/storage/unusual_devs.h | 12 ++++++++++++
 drivers/usb/typec/tcpm/tcpm.c      | 11 +++++++++--
 drivers/usb/typec/tps6598x.c       |  1 -
 drivers/usb/usbip/vudc_sysfs.c     |  2 +-
 include/linux/usb_usual.h          |  2 ++
 11 files changed, 62 insertions(+), 25 deletions(-)
