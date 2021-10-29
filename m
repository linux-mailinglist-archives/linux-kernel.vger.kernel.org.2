Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED8143F8B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 10:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhJ2IX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 04:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232305AbhJ2IX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:23:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C06B761157;
        Fri, 29 Oct 2021 08:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635495659;
        bh=fvrMNV1slEZNVac6lk/nzzkxbd31MWmFEKKCXvb069E=;
        h=Date:From:To:Cc:Subject:From;
        b=mSc//ZXRflCu6pNz2JhCJUAExzFKmHKR/2gsz9ZRosW+D87MSssJDyVYoHRZF/f50
         ywKa7lS/aJ63J8FWxAEMdbIJDkf6doyzjJdd2Qpy3SNRwcIf8UyTdAM0Ll7dc/70Hb
         Efx2/QbOn0eGFPJQuXJZ2T5QYlo8x+eGwe95TbzEHWbLVAux8C/2a8Uxyaob/bzdzR
         vYz3aBR4rmrHN8kPrI4ZMRGJtHVxrROv58BB4DcKVw9/z4cXup2UrjTZDrluKy6MbS
         F2oylzmirajSi36WCXFOGlvmNUAWETnflIJcAAEfjLOXoxaieSLCnGngSwXIKmLR20
         ioKWaSD/YxcYw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mgN8D-0007Po-SM; Fri, 29 Oct 2021 10:20:57 +0200
Date:   Fri, 29 Oct 2021 10:20:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial updates for 5.16-rc1
Message-ID: <YXuu6YrDdp1E6Tpr@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.16-rc1

for you to fetch changes up to 910c996335c37552ee30fcb837375b808bb4f33b:

  USB: serial: keyspan: fix memleak on probe errors (2021-10-27 15:18:59 +0200)

----------------------------------------------------------------
USB-serial updates for 5.16-rc1

Here are the USB-serial updates for 5.16-rc1, including:

 - conversions of usb_control_msg() calls to use the new wrappers where
   appropriate
 - fix of the keyspan probe error handling after a low-order allocation
   failure (e.g. due to fault injection)
 - allow hung up ports to be runtime suspended

Included are also some related clean ups.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Himadri Pandya (6):
      USB: serial: f81232: use usb_control_msg_recv() and usb_control_msg_send()
      USB: serial: ftdi_sio: use usb_control_msg_recv()
      USB: serial: keyspan_pda: use usb_control_msg_recv()
      USB: serial: kl5kusb105: use usb_control_msg_recv() and usb_control_msg_send()
      USB: serial: ch314: use usb_control_msg_recv()
      USB: serial: cp210x: use usb_control_msg_recv() and usb_control_msg_send()

Johan Hovold (5):
      USB: serial: clean up core error labels
      USB: serial: allow hung up ports to be suspended
      USB: serial: kl5kusb105: clean up line-status handling
      USB: serial: kl5kusb105: simplify line-status handling
      USB: serial: kl5kusb105: drop line-status helper

Wang Hai (1):
      USB: serial: keyspan: fix memleak on probe errors

 drivers/usb/serial/ch341.c       |  85 +++++++++--------------------
 drivers/usb/serial/cp210x.c      | 109 +++++++++++--------------------------
 drivers/usb/serial/f81232.c      |  96 ++++++++++++--------------------
 drivers/usb/serial/ftdi_sio.c    |  53 +++++-------------
 drivers/usb/serial/keyspan.c     |  15 +++--
 drivers/usb/serial/keyspan_pda.c |  67 ++++++++++-------------
 drivers/usb/serial/kl5kusb105.c  | 115 +++++++++++++++------------------------
 drivers/usb/serial/usb-serial.c  |  59 ++++++++++----------
 8 files changed, 215 insertions(+), 384 deletions(-)
