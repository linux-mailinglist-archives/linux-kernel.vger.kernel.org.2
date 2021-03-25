Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA453495F3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhCYPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:47:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbhCYPqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:46:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44320619A3;
        Thu, 25 Mar 2021 15:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616687207;
        bh=BrV2f8UV7DfwZLtIuKvf80tdpFqcOSMeqyM1Lf9HasI=;
        h=From:To:Cc:Subject:Date:From;
        b=IonT1CEzd6aeLfaCrpGvBiZdh8mueXNygqKIfPPoxYP1zuPm6hxtqBrJS4DiPukEe
         aWCSNToM7PHzds0P0zxkXTS34u8XljYqHau+Yk9nozL3GC05uuPN723yq3KIisSIh7
         okrAoTh0X+vNrqlYqLwEDYO3k98mqUssxJospVus9cWJLYClLIRans2hVoEX+1I/Qv
         j/fE8YU/TPePj9fQM+yz9NP1cwNME9MNUZt8ZSbIH8D3ZDNs/Y2KyMFQrGYRirRMZk
         lvB0q3d7pgIwLTg2cRiTbePkr9dhRSmUHIjr0ckeS1GfwGz6ehi0IztEi7YH2pEekk
         a/h+1zthdJaZw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lPSC4-001FYj-3B; Thu, 25 Mar 2021 16:46:44 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Atul Gopinathan <leoatul12@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, Yu Chen <chenyu56@huawei.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v5 0/7] Move Hisilicon 6421v600 SPMI and USB drivers out of staging
Date:   Thu, 25 Mar 2021 16:46:34 +0100
Message-Id: <cover.1616686958.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Those are the remaining patches that are needed for the USB to work
with Hikey970. This is based on the top of next-20210323.

The main change from the previous patch series is that a new patch
was added:
  - staging: hisilicon,hisi-spmi-controller.yaml cleanup schema

It does some changes at the DT binding file, as requested by Rob.

My understanding from the discussions we had, back on Feb, is that
those patches will be merged via the staging tree.

Thanks!
Mauro

Mauro Carvalho Chehab (7):
  phy: phy-hi3670-usb3: move driver from staging into phy
  
  spmi: hisi-spmi-controller: move driver from staging
  mfd: hi6421-spmi-pmic: move driver from staging
  regulator: hi6421v600-regulator: move it from staging
  dts: hisilicon: add support for the PMIC found on Hikey 970
  dts: hisilicon: add support for USB3 on Hikey 970

 .../mfd}/hisilicon,hi6421-spmi-pmic.yaml      |   0
 .../bindings/phy/hisilicon,hi3670-usb3.yaml   |   0
 .../spmi}/hisilicon,hisi-spmi-controller.yaml |  18 +--
 MAINTAINERS                                   |  23 +++-
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 124 +++++++++++++++---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  58 ++++++++
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  87 ++++++++++++
 drivers/mfd/Kconfig                           |  16 +++
 drivers/mfd/Makefile                          |   1 +
 .../hikey9xx => mfd}/hi6421-spmi-pmic.c       |   0
 drivers/phy/hisilicon/Kconfig                 |  10 ++
 drivers/phy/hisilicon/Makefile                |   1 +
 .../hisilicon}/phy-hi3670-usb3.c              |   0
 drivers/regulator/Kconfig                     |   9 ++
 drivers/regulator/Makefile                    |   1 +
 .../hi6421v600-regulator.c                    |   0
 drivers/spmi/Kconfig                          |   9 ++
 drivers/spmi/Makefile                         |   1 +
 .../hikey9xx => spmi}/hisi-spmi-controller.c  |   0
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/staging/hikey9xx/Kconfig              |  52 --------
 drivers/staging/hikey9xx/Makefile             |   7 -
 drivers/staging/hikey9xx/TODO                 |   5 -
 24 files changed, 327 insertions(+), 98 deletions(-)
 rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/mfd}/hisilicon,hi6421-spmi-pmic.yaml (100%)
 rename drivers/staging/hikey9xx/phy-hi3670-usb3.yaml => Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml (100%)
 rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/spmi}/hisilicon,hisi-spmi-controller.yaml (89%)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
 rename drivers/{staging/hikey9xx => mfd}/hi6421-spmi-pmic.c (100%)
 rename drivers/{staging/hikey9xx => phy/hisilicon}/phy-hi3670-usb3.c (100%)
 rename drivers/{staging/hikey9xx => regulator}/hi6421v600-regulator.c (100%)
 rename drivers/{staging/hikey9xx => spmi}/hisi-spmi-controller.c (100%)
 delete mode 100644 drivers/staging/hikey9xx/Kconfig
 delete mode 100644 drivers/staging/hikey9xx/Makefile
 delete mode 100644 drivers/staging/hikey9xx/TODO

-- 
2.30.2


