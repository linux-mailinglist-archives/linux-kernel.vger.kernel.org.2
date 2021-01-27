Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7F63063D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344360AbhA0TKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:10:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344238AbhA0TJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:09:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B43864DAB;
        Wed, 27 Jan 2021 19:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611774505;
        bh=2HavwUWRXPYAzxhXM+vrsP246g6dUCKujiewop5u6Mw=;
        h=From:To:Cc:Subject:Date:From;
        b=exksylbd229tqjbMBx300VKVBsCgT8w/z3AhlXq2BxP1S2/hY+dwKeG/8OoOIQ9aV
         +SmhYyjis9Jkkg/M+KsikSNf/WVHWJ+Q3pRFhmy1YjfUOedXkJ4vn4R21nng0OxJgN
         4I0JhC+jnNgWMVlB4ue/EuBLoj7QvhfDT4b7s3EfoTZQSh9PCS7uvme/vSZjIZoFgg
         lg7WRJNNX31lWDKYhuWPIROAc9BJ/rwL/slRUanza9D8RgBeZsk3S4QXVH51YA8+zJ
         pNoUBy9AykXo3Mp2Xj0/qe4BczHrlP/0rNSLSqWrvDGeNjFbpKoBYva8P3zC5lNpii
         X4JMWzj3HVAsQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l4qAx-003n4p-09; Wed, 27 Jan 2021 20:08:23 +0100
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
        Stephen Boyd <sboyd@kernel.org>,
        Wang Hai <wanghai38@huawei.com>, Wei Xu <xuwei5@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/7] Move Hisilicon 6421v600 SPMI and USB drivers out of staging
Date:   Wed, 27 Jan 2021 20:08:15 +0100
Message-Id: <cover.1611773727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg/Mark/Lee/Vinod,

Just did a rebase on the top of staging-testing, and re-tested
at the hardware.

This series contain the remaining patches for USB to start working,
except for a final DTS patch, which depends on two patches
that should be merged via the ARM SoC tree.

Patches 1 and 2 convert the SPMI and regulator
drivers to use regmap and simplifies the logic by using
regmap helpers.

I guess the best would be if Greg could apply both patches
also via the staging tree.

Patches 3-6 move the drivers and their corresponding
DT documentation bindings out of staging.

Patch 7 contains the DT which describes the regulator,
SPMI controller and MFD.

I'll submit the final patch with USB bindings after having
everything set (e.g. after 5.12-rc1).

Mauro Carvalho Chehab (7):
  staging: hikey9xx: spmi driver: convert to regmap
  staging: hikey9xx: hi6421v600-regulator: use some regmap helpers
  phy: phy-hi3670-usb3: move driver from staging into phy
  spmi: hisi-spmi-controller: move driver from staging
  mfd: hi6421-spmi-pmic: move driver from staging
  regulator: hi6421v600-regulator: move it from staging
  dts: hisilicon: add support for the PMIC found on Hikey 970

 .../mfd}/hisilicon,hi6421-spmi-pmic.yaml      |   0
 .../bindings/phy/hisilicon,hi3670-usb3.yaml   |   0
 .../spmi}/hisilicon,hisi-spmi-controller.yaml |   0
 MAINTAINERS                                   |  24 +++-
 .../boot/dts/hisilicon/hi3670-hikey970.dts    |  22 +---
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  87 +++++++++++++
 drivers/mfd/Kconfig                           |  15 +++
 drivers/mfd/Makefile                          |   1 +
 .../hikey9xx => mfd}/hi6421-spmi-pmic.c       | 115 ++++++------------
 drivers/phy/hisilicon/Kconfig                 |  10 ++
 drivers/phy/hisilicon/Makefile                |   1 +
 .../hisilicon}/phy-hi3670-usb3.c              |   0
 drivers/regulator/Kconfig                     |   8 ++
 drivers/regulator/Makefile                    |   1 +
 .../hi6421v600-regulator.c                    |  63 ++--------
 drivers/spmi/Kconfig                          |   9 ++
 drivers/spmi/Makefile                         |   1 +
 .../hikey9xx => spmi}/hisi-spmi-controller.c  |   0
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/staging/hikey9xx/Kconfig              |  50 --------
 drivers/staging/hikey9xx/Makefile             |   7 --
 drivers/staging/hikey9xx/TODO                 |   5 -
 include/linux/mfd/hi6421-spmi-pmic.h          |   7 +-
 24 files changed, 207 insertions(+), 222 deletions(-)
 rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/mfd}/hisilicon,hi6421-spmi-pmic.yaml (100%)
 rename drivers/staging/hikey9xx/phy-hi3670-usb3.yaml => Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml (100%)
 rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/spmi}/hisilicon,hisi-spmi-controller.yaml (100%)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
 rename drivers/{staging/hikey9xx => mfd}/hi6421-spmi-pmic.c (72%)
 rename drivers/{staging/hikey9xx => phy/hisilicon}/phy-hi3670-usb3.c (100%)
 rename drivers/{staging/hikey9xx => regulator}/hi6421v600-regulator.c (81%)
 rename drivers/{staging/hikey9xx => spmi}/hisi-spmi-controller.c (100%)
 delete mode 100644 drivers/staging/hikey9xx/Kconfig
 delete mode 100644 drivers/staging/hikey9xx/Makefile
 delete mode 100644 drivers/staging/hikey9xx/TODO

-- 
2.29.2


