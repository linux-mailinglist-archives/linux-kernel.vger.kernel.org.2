Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E62320EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 01:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhBVAmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 19:42:10 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47461 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhBVAmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 19:42:07 -0500
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id CA25920004;
        Mon, 22 Feb 2021 00:41:22 +0000 (UTC)
Date:   Mon, 22 Feb 2021 01:41:22 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 5.12
Message-ID: <YDL9slBuOqU83/RK@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the I3C pull request for v5.12 with a few improvements for the
core and a new driver.

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.12

for you to fetch changes up to 5c34b8e7e8bb605925b33e1aa7dc17966811219a:

  i3c: master: dw: Drop redundant disec call (2021-02-06 00:44:15 +0100)

----------------------------------------------------------------
I3C for 5.12

Subsystem:
 - Handle drivers without probe or remove callback
 - Remove callback now returns void
 - DT documentation is now in yaml

New driver:
 - Silvaco I3C master

----------------------------------------------------------------
David Gow (1):
      i3c/master/mipi-i3c-hci: Specify HAS_IOMEM dependency

Miquel Raynal (7):
      dt-bindings: i3c: Convert the bus description to yaml
      dt-bindings: i3c: mipi-hci: Include the bus binding
      dt-bindings: Add vendor prefix for Silvaco
      dt-bindings: i3c: Describe Silvaco master binding
      i3c: master: svc: Add Silvaco I3C master driver
      MAINTAINERS: Add Silvaco I3C master
      i3c: master: dw: Drop redundant disec call

Uwe Kleine-König (2):
      i3c: Handle drivers without probe or remove callback
      i3c: Make remove callback return void

 Documentation/devicetree/bindings/i3c/i3c.txt      |  140 --
 Documentation/devicetree/bindings/i3c/i3c.yaml     |  179 +++
 .../devicetree/bindings/i3c/mipi-i3c-hci.yaml      |    9 +-
 .../bindings/i3c/silvaco,i3c-master.yaml           |   60 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 MAINTAINERS                                        |    8 +
 drivers/i3c/device.c                               |    5 +
 drivers/i3c/master.c                               |    8 +-
 drivers/i3c/master/Kconfig                         |    9 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/dw-i3c-master.c                 |    5 -
 drivers/i3c/master/svc-i3c-master.c                | 1478 ++++++++++++++++++++
 include/linux/i3c/device.h                         |    2 +-
 13 files changed, 1753 insertions(+), 153 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt
 create mode 100644 Documentation/devicetree/bindings/i3c/i3c.yaml
 create mode 100644 Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
 create mode 100644 drivers/i3c/master/svc-i3c-master.c

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
