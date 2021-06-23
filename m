Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5387B3B17DE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 12:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFWKNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 06:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhFWKNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 06:13:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8017D611AD;
        Wed, 23 Jun 2021 10:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624443093;
        bh=PTk8qF9sCzGm1VCM1jUzPQ75hDfSjU7UhDG0wpTdkAs=;
        h=From:To:Cc:Subject:Date:From;
        b=u/BlZi//ZEwXJ1K7hfctkcaocgcL2db4fg0wagf0wa95oJhq96rceAxSm4pKAYoLM
         Qh9+rpQMHYlwJsiqmXIEJV8OYe+pASV3v6t3A7kXDswXvS/i1q/f6UkNX2SJzEDfOK
         XZTVNy4Vl6FpqWtiLOwpQB68v7ny2zqrCzv1bR7Yv8xCp1IF6s+pcdB3q7RaiUOckt
         dtV/neNCw6Y/ufkjktd03V2lmVJMNFDoqepKPiZrLQe3xT97oESh1lHsX/G9rZ1S3K
         W+/ksiYh9+9bzyVVnDYRTHkhMsjI7XkmYEXgtnwURZobUvLJkkYsOQWs/s+J6Qc87J
         kAn1ulvlvOWkQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lvzr1-002pFQ-2O; Wed, 23 Jun 2021 12:11:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-staging@lists.linux.dev
Subject: [PATCH v6 0/8]Move Hisilicon 6421v600 SPMI and USB drivers out of staging
Date:   Wed, 23 Jun 2021 12:11:22 +0200
Message-Id: <cover.1624442566.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: the previous series is at:
        https://lore.kernel.org/lkml/cover.1616695231.git.mchehab+huawei@kernel.org/

Hi Greg,

Those are the remaining patches that are needed for the USB to work
with Hikey970.

This series address the comments made on v5. Sorry for taking so long to
return back on this. Got sidetracked by other unrelated stuff.

Changes from v5:

- Some changes at DT to comply with Rob Herring's feedback;
- a couple of cleanups at the phy-hi3670-usb3;
- Vinod's ack added to patch 4;
- Several cleanups at hi6421-spmi-pmic.c, in order to address
  Lee Jones feedbacks.

On this series, I opted to keep using "gpios" for the DT IRQ gpios needed
by the PMIC driver, as this is the string expected by of_get_gpio(), and
it is the most common pattern for IRQ gpios. If required, I'll send a
followup patch changing it to use, instead, the of_get_named_gpio_flags()
variant.

Mauro Carvalho Chehab (8):
  staging: phy-hi3670-usb3: do a some minor cleanups
  staging: hisi-spmi-controller: rename spmi-channel property
  staging: phy-hi3670-usb3: do some additional cleanups
  phy: phy-hi3670-usb3: move driver from staging into phy
  spmi: hisi-spmi-controller: move driver from staging
  mfd: hi6421-spmi-pmic: move driver from staging
  dts: hisilicon: add support for the PMIC found on Hikey 970
  dts: hisilicon: add support for USB3 on Hikey 970

 .../mfd}/hisilicon,hi6421-spmi-pmic.yaml      |   7 +-
 .../bindings/phy/hisilicon,hi3670-usb3.yaml   |   0
 .../spmi}/hisilicon,hisi-spmi-controller.yaml |  10 +-
 MAINTAINERS                                   |  23 +++-
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 129 +++++++++++++++---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  56 ++++++++
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  87 ++++++++++++
 drivers/mfd/Kconfig                           |  16 +++
 drivers/mfd/Makefile                          |   1 +
 .../hikey9xx => mfd}/hi6421-spmi-pmic.c       |  89 +++++++-----
 drivers/phy/hisilicon/Kconfig                 |  10 ++
 drivers/phy/hisilicon/Makefile                |   1 +
 .../hisilicon}/phy-hi3670-usb3.c              |  19 +--
 drivers/spmi/Kconfig                          |   9 ++
 drivers/spmi/Makefile                         |   1 +
 .../hikey9xx => spmi}/hisi-spmi-controller.c  |   2 +-
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/staging/hikey9xx/Kconfig              |  41 ------
 drivers/staging/hikey9xx/Makefile             |   6 -
 drivers/staging/hikey9xx/TODO                 |   5 -
 21 files changed, 383 insertions(+), 132 deletions(-)
 rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/mfd}/hisilicon,hi6421-spmi-pmic.yaml (93%)
 rename drivers/staging/hikey9xx/phy-hi3670-usb3.yaml => Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml (100%)
 rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/spmi}/hisilicon,hisi-spmi-controller.yaml (89%)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
 rename drivers/{staging/hikey9xx => mfd}/hi6421-spmi-pmic.c (76%)
 rename drivers/{staging/hikey9xx => phy/hisilicon}/phy-hi3670-usb3.c (98%)
 rename drivers/{staging/hikey9xx => spmi}/hisi-spmi-controller.c (99%)
 delete mode 100644 drivers/staging/hikey9xx/Kconfig
 delete mode 100644 drivers/staging/hikey9xx/Makefile
 delete mode 100644 drivers/staging/hikey9xx/TODO

-- 
2.31.1


