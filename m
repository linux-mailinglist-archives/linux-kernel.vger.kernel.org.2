Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFABC35AD6B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbhDJNGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234091AbhDJNGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:06:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 235CF610E7;
        Sat, 10 Apr 2021 13:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618059967;
        bh=Nx+Az8uucARo5rt3kk1DkG1a9AVj6LLG/pm3AuITkTc=;
        h=Date:From:To:Cc:Subject:From;
        b=B+Tz28WLLVVeR5HeyWbUyAr2DuCGJ7pQAj7EWMfIIhmXAtQvt6osvT31cSwkMCaDL
         EYbb18WrUlC1ts6QCYLxh3+GmfzhTqUXdRt4NisPGE1OonIm4c/nnAQxN8kDPdfH5R
         g+gqyS3eBOeMYx80WsCeouQKTfutoosdALoUcuy4=
Date:   Sat, 10 Apr 2021 15:06:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt driver fixes for 5.12-rc7
Message-ID: <YHGivAMSbiL2Y7je@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.12-rc7

for you to fetch changes up to bc2f3e4c662841dc19f7e7efae87782b9f3c0831:

  Merge tag 'thunderbolt-for-v5.12-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus (2021-04-08 11:48:48 +0200)

----------------------------------------------------------------
USB/Thunderbolt fixes for 5.12-rc7

Here are a few small USB and Thunderbolt driver fixes for 5.12-rc7 for
reported issues:
	- thunderbolt leaks and off-by-one fix
	- cdnsp deque fix
	- usbip fixes for syzbot-reported issues.

all have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (2):
      thunderbolt: Fix a leak in tb_retimer_add()
      thunderbolt: Fix off by one in tb_port_find_retimer()

Greg Kroah-Hartman (2):
      Merge tag 'v5.12-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-linus
      Merge tag 'thunderbolt-for-v5.12-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus

Pawel Laszczak (1):
      usb: cdnsp: Fixes issue with dequeuing requests after disabling endpoint

Shuah Khan (4):
      usbip: add sysfs_lock to synchronize sysfs code paths
      usbip: stub-dev synchronize sysfs code paths
      usbip: vudc synchronize sysfs code paths
      usbip: synchronize event handler with sysfs code paths

 drivers/thunderbolt/retimer.c    |  4 ++--
 drivers/usb/cdns3/cdnsp-gadget.c |  4 ++++
 drivers/usb/usbip/stub_dev.c     | 11 +++++++++--
 drivers/usb/usbip/usbip_common.h |  3 +++
 drivers/usb/usbip/usbip_event.c  |  2 ++
 drivers/usb/usbip/vhci_hcd.c     |  1 +
 drivers/usb/usbip/vhci_sysfs.c   | 30 +++++++++++++++++++++++++-----
 drivers/usb/usbip/vudc_dev.c     |  1 +
 drivers/usb/usbip/vudc_sysfs.c   |  5 +++++
 9 files changed, 52 insertions(+), 9 deletions(-)
