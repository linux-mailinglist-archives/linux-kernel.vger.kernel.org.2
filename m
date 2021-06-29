Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C913B70BE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 12:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhF2KeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 06:34:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232772AbhF2KeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 06:34:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7953261D4E;
        Tue, 29 Jun 2021 10:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624962694;
        bh=jKXivDk711GJY/luPmn+YiYTQh6/YAbNd2X1b6kZVVQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Tucg4Vh1knXAFd0Fi/1pOBHS2zcZLYm972pEAhHOgJUOMOVMaroQsGe86dDCZJ/Mj
         XA667h1MOVshuYX275n0359Sx2bOQ5DgJHcROCu2UfNo+W3mkOePedRknzLCE6psva
         +BUGHImUPgm2LcI5pQwPxEy8BA0bVi30iDvVbDxq8kExxvNiUpPaNHgkhk1JGRMsHF
         G8ZrztRlID+obtzGuf+szcIwoJpHQIYaPypQQAQSPvUn0Jd92oead524cn1thMYObC
         jmdqdFxzwjZvEyJvZ0r4BwR324uPmwYGGv942/ahB+6HAUFlFU9Os7UHDWGanYq9Zg
         nL+F2rBWMFNqg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lyB1g-00Cx7N-NP; Tue, 29 Jun 2021 12:31:32 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Axel Lin <axel.lin@ingics.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v10 0/5] Move Hisilicon 6421v600 SPMI and USB drivers  out of staging
Date:   Tue, 29 Jun 2021 12:31:26 +0200
Message-Id: <cover.1624962269.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This series contain the final bits needed for the USB3 bus to work
without staging drivers on Hikey 970.

Tested on a Hikey 970:

	$ lsusb
	Bus 002 Device 002: ID 0451:8140 Texas Instruments, Inc. TUSB8041 4-Port Hub
	Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
	Bus 001 Device 003: ID 046d:c52b Logitech, Inc. Unifying Receiver
	Bus 001 Device 002: ID 0451:8142 Texas Instruments, Inc. TUSB8041 4-Port Hub
	Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

and checked that mouse events are working using evtest:

	...
	Input device ID: bus 0x3 vendor 0x46d product 0xc52b version 0x111
	Input device name: "Logitech USB Receiver Mouse"
	....
	Testing ... (interrupt to exit)
	Event: time 1624640001.871917, type 2 (EV_REL), code 0 (REL_X), value -4
	Event: time 1624640001.871917, type 2 (EV_REL), code 1 (REL_Y), value -3
	Event: time 1624640001.871917, -------------- SYN_REPORT ------------
	Event: time 1624640001.879868, type 2 (EV_REL), code 0 (REL_X), value -5
	Event: time 1624640001.879868, type 2 (EV_REL), code 1 (REL_Y), value -4
	....

v10:
  - Addressed some issues pointed by Axel Lin at the regulator;
  - Removed a now uneeded header file (hi6421-spmi-pmic.h);
  - Addressed a couple of checkpatch warnings and did minor
    cleanups.

Mauro Carvalho Chehab (5):
  staging: hikey9xx: split hi6421v600 irq into a separate driver
  regulator: hi6421v600-regulator: fix platform drvdata
  mfd: hi6421-spmi-pmic: move driver from staging
  dts: hisilicon: add support for the PMIC found on Hikey 970
  dts: hisilicon: add support for USB3 on Hikey 970

 .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 134 ++++++++
 MAINTAINERS                                   |   7 +
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 129 ++++++--
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  56 ++++
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  87 +++++
 drivers/mfd/Kconfig                           |  16 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/hi6421-spmi-pmic.c                |  66 ++++
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/hi6421v600-irq.c                 | 313 ++++++++++++++++++
 drivers/regulator/hi6421v600-regulator.c      |  49 +--
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/staging/hikey9xx/Kconfig              |  19 --
 drivers/staging/hikey9xx/Makefile             |   3 -
 drivers/staging/hikey9xx/TODO                 |   5 -
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 311 -----------------
 .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 134 --------
 include/linux/mfd/hi6421-spmi-pmic.h          |  30 --
 20 files changed, 826 insertions(+), 548 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
 create mode 100644 drivers/mfd/hi6421-spmi-pmic.c
 create mode 100644 drivers/misc/hi6421v600-irq.c
 delete mode 100644 drivers/staging/hikey9xx/Kconfig
 delete mode 100644 drivers/staging/hikey9xx/Makefile
 delete mode 100644 drivers/staging/hikey9xx/TODO
 delete mode 100644 drivers/staging/hikey9xx/hi6421-spmi-pmic.c
 delete mode 100644 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
 delete mode 100644 include/linux/mfd/hi6421-spmi-pmic.h

-- 
2.31.1


