Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3122D4307AF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 12:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245255AbhJQKH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 06:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245237AbhJQKH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 06:07:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BACD460FF2;
        Sun, 17 Oct 2021 10:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634465119;
        bh=vi7HaI24vuLkfpRHTC43LctuUicv6zO5FUxVompozDA=;
        h=Date:From:To:Cc:Subject:From;
        b=v0BWj/4zk9wUzHiCmry3m12tNaXSX1wgUezqDI9HjLlA7LK05hoZyCWiJUWc9eBPq
         S4wScCNwjQWeLu4YgheknrI1EX7FUBs0ct0AqUisrlPM2EXocsvS/0KZ0IVepTPjeF
         KZbkfsXwT6gMhm/zoMzjknbj2gAESxFcdjKFB4bU=
Date:   Sun, 17 Oct 2021 12:05:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.15-rc5
Message-ID: <YWv1XLbDBs/y1d3W@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc:

  Linux 5.15-rc5 (2021-10-10 17:01:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.15-rc6

for you to fetch changes up to cd932c2a1ecc8f261ecb8d140fa431c16379931f:

  Merge tag 'usb-serial-5.15-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2021-10-15 15:04:02 +0200)

----------------------------------------------------------------
USB fixes for 5.15-rc6

Here are some small USB fixes that resolve a number of tiny issues.
They include:
	- new USB serial driver ids
	- xhci driver fixes for a bunch of issues
	- musb error path fixes.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aleksander Morgado (1):
      USB: serial: qcserial: add EM9191 QDL support

Daniele Palmas (1):
      USB: serial: option: add Telit LE910Cx composition 0x1204

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-5.15-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Johan Hovold (1):
      USB: xhci: dbc: fix tty registration race

Jonathan Bell (2):
      xhci: guard accesses to ep_state in xhci_endpoint_reset()
      xhci: add quirk for host controllers that don't update endpoint DCS

Miquel Raynal (1):
      usb: musb: dsps: Fix the probe error path

Nikolay Martynov (1):
      xhci: Enable trust tx length quirk for Fresco FL11 USB controller

Pavankumar Kondeti (1):
      xhci: Fix command ring pointer corruption while aborting a command

Tomaz Solc (1):
      USB: serial: option: add prod. id for Quectel EG91

Yu-Tung Chang (1):
      USB: serial: option: add Quectel EC200S-CN module support

 drivers/usb/host/xhci-dbgtty.c | 28 +++++++++++++---------------
 drivers/usb/host/xhci-pci.c    |  6 +++++-
 drivers/usb/host/xhci-ring.c   | 39 ++++++++++++++++++++++++++++++++++-----
 drivers/usb/host/xhci.c        |  5 +++++
 drivers/usb/host/xhci.h        |  1 +
 drivers/usb/musb/musb_dsps.c   |  4 +++-
 drivers/usb/serial/option.c    |  8 ++++++++
 drivers/usb/serial/qcserial.c  |  1 +
 8 files changed, 70 insertions(+), 22 deletions(-)
