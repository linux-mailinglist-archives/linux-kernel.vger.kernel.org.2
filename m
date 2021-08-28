Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356663FA716
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 20:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhH1SCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 14:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhH1SC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 14:02:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C9C860E97;
        Sat, 28 Aug 2021 18:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630173697;
        bh=BQexk/h9Kqj2ai3AnUJrH79xxSz2oWWtcfEv/pECOV0=;
        h=Date:From:To:Cc:Subject:From;
        b=Ls+xMWYINhp/DQrdSMa+0kqc9RKCv2oR9/Bg4gL4Y3/fJ+n+myb3JSIMQTCe3mE+p
         Xjf6eKv23GoKAfBC39NgPz9f6z/nEJFhiz8PrKdudhnC0dR+QnUw8dkIUboy5rbMqZ
         JliYUAkkjvjJ5zXpmitK2/APkbmK88TZIiVs4fW0=
Date:   Sat, 28 Aug 2021 20:01:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.14
Message-ID: <YSp5/U1nxmG77m6I@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

  Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.14

for you to fetch changes up to 068fdad20454f815e61e6f6eb9f051a8b3120e88:

  usb: gadget: u_audio: fix race condition on endpoint stop (2021-08-27 16:07:23 +0200)

----------------------------------------------------------------
USB fixes for 5.14

Here are a few tiny USB fixes for reported issues with some USB drivers.

These fixes include:
 - gadget driver fixes for regressions
 - tcpm driver fix
 - dwc3 driver fixes
 - xhci renesas firmware loading fix, again.
 - usb serial option driver device id addition
 - usb serial ch341 revert for regression

All all of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-5.14-rc8' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Jerome Brunet (2):
      usb: gadget: f_uac2: fixup feedback endpoint stop
      usb: gadget: u_audio: fix race condition on endpoint stop

Johan Hovold (1):
      Revert "USB: serial: ch341: fix character loss at high transfer rates"

Kyle Tso (1):
      usb: typec: tcpm: Raise vdm_sm_running flag only when VDM SM is running

Takashi Iwai (1):
      usb: renesas-xhci: Prefer firmware loading on unknown ROM state

Thinh Nguyen (1):
      usb: dwc3: gadget: Fix dwc3_calc_trbs_left()

Wesley Cheng (1):
      usb: dwc3: gadget: Stop EP0 transfers during pullup disable

Zhengjun Zhang (1):
      USB: serial: option: add new VID/PID to support Fibocom FG150

 drivers/usb/dwc3/gadget.c             | 23 +++++-----
 drivers/usb/gadget/function/u_audio.c | 23 ++++++----
 drivers/usb/host/xhci-pci-renesas.c   | 35 +++++++++------
 drivers/usb/serial/ch341.c            |  1 -
 drivers/usb/serial/option.c           |  2 +
 drivers/usb/typec/tcpm/tcpm.c         | 81 ++++++++++++++++-------------------
 6 files changed, 89 insertions(+), 76 deletions(-)
