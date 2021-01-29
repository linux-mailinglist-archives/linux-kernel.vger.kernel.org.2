Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3790B308DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhA2TxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:53:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232868AbhA2Twq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:52:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5344464E11;
        Fri, 29 Jan 2021 19:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611949925;
        bh=/vAPo6FjDg1j/+87POMJgSj4N2taKZvJjD0FjtW0fYo=;
        h=From:To:Cc:Subject:Date:From;
        b=ZGhvLIlIz73Nkqfl2zZL4Z7LG+DGy23xdjh/FTZCjfmFvea9RgrA6ftAZTPxXQHvW
         ypUh+oe1uxVvENGIz81IagdeTTl7IEdDh5LWmunTH92ZWW/WmqPzFuyrLpUo8lTrol
         4DaHKWrS4QthWCwwuvEpZtUqiWb33Ex82Porhgiz54+VKCDzaCpNfjykNLbmyd6R57
         T72KIW7BmQu1rQgC6xSQT03xbskzHhQrCR/OLo7fsRK+aiPXTozpeBKJ0Ni3pFM+3E
         eRbciB+GcrY2MDbSVBgqI6YSlqyqTT9tnRmVFho9h3efoErWiYjBWDdYkC7rFHBgnv
         iwKx8Zf2UFaHA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l5ZoI-007Wja-U2; Fri, 29 Jan 2021 20:52:02 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Gow <davidgow@google.com>,
        Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mayulong <mayulong1@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 00/14] Move Hisilicon 6421v600 SPMI and USB drivers out of staging
Date:   Fri, 29 Jan 2021 20:51:46 +0100
Message-Id: <cover.1611949675.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg/Mark/Lee/Vinod,

Another rebase , also the top of staging-testing.

This series contain the remaining patches for USB to start working,
except for a final DTS patch.

Patches 1 and 2 convert the SPMI and regulator
drivers to use regmap and simplifies the logic by using
regmap helpers.

Patches 3 to 9 address some issues pointed by Lee at the MFD driver.

I guess the best would be if Greg could apply patches 1 to 9
via the staging tree.

Patches 10 to 13 move the drivers and their corresponding
DT documentation bindings out of staging.

Patch 14 contains the DT which describes the regulator,
SPMI controller and MFD.

I'll submit the final patch with USB bindings after having
everything set (e.g. after 5.12-rc1).

-

v8: contains a fix for REGMAP dependencies and for a build breakage.

Mauro Carvalho Chehab (14):
  staging: hikey9xx: spmi driver: convert to regmap
  staging: hikey9xx: hi6421v600-regulator: use some regmap helpers
  staging: hikey9xx: hi6421-spmi-pmic: rename some vars
  staging: hikey9xx: hi6421-spmi-pmic: cleanup probe code
  staging: hikey9xx: hi6421-spmi-pmic: cleanup header file
  staging: hikey9xx: hi6421-spmi-pmic: fix IRQ handler code
  staging: hikey9xx: hi6421-spmi-pmic: cleanup IRQ handling code
  staging: hikey9xx: hi6421-spmi-pmic: document registers
  staging: hikey9xx: hi6421-spmi-pmic: update copyright notes
  phy: phy-hi3670-usb3: move driver from staging into phy
  spmi: hisi-spmi-controller: move driver from staging
  mfd: hi6421-spmi-pmic: move driver from staging
  regulator: hi6421v600-regulator: move it from staging
  dts: hisilicon: add support for the PMIC found on Hikey 970

 .../mfd}/hisilicon,hi6421-spmi-pmic.yaml      |   0
 .../bindings/phy/hisilicon,hi3670-usb3.yaml   |   0
 .../spmi}/hisilicon,hisi-spmi-controller.yaml |   0
 MAINTAINERS                                   |  24 +-
 .../boot/dts/hisilicon/hi3670-hikey970.dts    |  22 +-
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  87 +++++
 drivers/mfd/Kconfig                           |  16 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/hi6421-spmi-pmic.c                | 297 ++++++++++++++++
 drivers/phy/hisilicon/Kconfig                 |  10 +
 drivers/phy/hisilicon/Makefile                |   1 +
 .../hisilicon}/phy-hi3670-usb3.c              |   0
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 .../hi6421v600-regulator.c                    |  63 +---
 drivers/spmi/Kconfig                          |   9 +
 drivers/spmi/Makefile                         |   1 +
 .../hikey9xx => spmi}/hisi-spmi-controller.c  |   0
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/staging/hikey9xx/Kconfig              |  50 ---
 drivers/staging/hikey9xx/Makefile             |   7 -
 drivers/staging/hikey9xx/TODO                 |   5 -
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 326 ------------------
 include/linux/mfd/hi6421-spmi-pmic.h          |  28 +-
 25 files changed, 471 insertions(+), 489 deletions(-)
 rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/mfd}/hisilicon,hi6421-spmi-pmic.yaml (100%)
 rename drivers/staging/hikey9xx/phy-hi3670-usb3.yaml => Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml (100%)
 rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/spmi}/hisilicon,hisi-spmi-controller.yaml (100%)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
 create mode 100644 drivers/mfd/hi6421-spmi-pmic.c
 rename drivers/{staging/hikey9xx => phy/hisilicon}/phy-hi3670-usb3.c (100%)
 rename drivers/{staging/hikey9xx => regulator}/hi6421v600-regulator.c (81%)
 rename drivers/{staging/hikey9xx => spmi}/hisi-spmi-controller.c (100%)
 delete mode 100644 drivers/staging/hikey9xx/Kconfig
 delete mode 100644 drivers/staging/hikey9xx/Makefile
 delete mode 100644 drivers/staging/hikey9xx/TODO
 delete mode 100644 drivers/staging/hikey9xx/hi6421-spmi-pmic.c

-- 
2.29.2


