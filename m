Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3983B30D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhFXOEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:04:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231974AbhFXOEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:04:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D26756140C;
        Thu, 24 Jun 2021 14:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624543300;
        bh=zEkwJclaRyftbeoALFZwDqxzWAqBzKVUv8k2r7oOZ74=;
        h=From:To:Cc:Subject:Date:From;
        b=ZS4eJajBkqgNK6KlXmGJzhGgE0BzT6xPsZ9oxvx2YFKaX+C3i3StkYLJfby56lFOx
         832howwBBhjAjyqzK3t8Uz0XnjEYE2ut7NrG3ePwZMvZGoqaKZwIebcXAtRbcD9Y/m
         lQ9JhdwFgfmSwUvFAWsvThNGe5SDHAzPQXSWAKY755a4xzCgQxkulCuOBE5VldMGcx
         PKdffA8L1cOoc/KgKg0F+7FGZEmQnyDQ1zwNoQMCSRyueIyIrEUU5vpx8cb4NMGCY2
         NQHH5KDgAsRzKxG4ByOq3g1/cGtiOnuuZbb6uEzz6TfmwpUK/57dEPFzf1pDjx8eFv
         ZMKV60bocKg+A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lwPvG-003wS9-J5; Thu, 24 Jun 2021 16:01:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org
Subject: [PATCH v7 0/8] Move Hisilicon 6421v600 SPMI and USB drivers out of staging
Date:   Thu, 24 Jun 2021 16:01:29 +0200
Message-Id: <cover.1624542940.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Those are the remaining patches that are needed for the USB to work
with Hikey970.

This series address the comments made on v5. Sorry for taking so long to
return back on this. Got sidetracked by other unrelated stuff.

v6:

Only patch 3 was changed (*):
- Copyrights changed to "20xx-" in order to indicate just the start date
  of the copyrights;
- HISI_8BITS_MASK is now defined as simply 0xff (without using GENMASK);
- There's no sense to mask the value read by regmap_read() when writing
  it back to acknowledge that IRQs got handled;
- removed one extra tab from the regmap_config identation;
- if irq_create_mapping() fails, return -ENODEV;
- use devm_request_threaded_irq().

(*) as we're using --no-merges, in order to show the full code at renames,
    patch 6 will also look different.

Mauro Carvalho Chehab (8):
  staging: phy-hi3670-usb3: do a some minor cleanups
  staging: hisi-spmi-controller: rename spmi-channel property
  staging: hi6421-spmi-pmic: do some additional cleanups
  phy: phy-hi3670-usb3: move driver from staging into phy
  spmi: hisi-spmi-controller: move driver from staging
  mfd: hi6421-spmi-pmic: move driver from staging
  dts: hisilicon: add support for the PMIC found on Hikey 970
  dts: hisilicon: add support for USB3 on Hikey 970

 .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 134 ++++
 .../bindings/phy/hisilicon,hi3670-usb3.yaml   |  73 ++
 .../spmi/hisilicon,hisi-spmi-controller.yaml  |  73 ++
 MAINTAINERS                                   |  23 +-
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 129 +++-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  56 ++
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  87 +++
 drivers/mfd/Kconfig                           |  16 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/hi6421-spmi-pmic.c                | 311 ++++++++
 drivers/phy/hisilicon/Kconfig                 |  10 +
 drivers/phy/hisilicon/Makefile                |   1 +
 drivers/phy/hisilicon/phy-hi3670-usb3.c       | 661 +++++++++++++++++
 drivers/spmi/Kconfig                          |   9 +
 drivers/spmi/Makefile                         |   1 +
 drivers/spmi/hisi-spmi-controller.c           | 367 ++++++++++
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/staging/hikey9xx/Kconfig              |  41 --
 drivers/staging/hikey9xx/Makefile             |   6 -
 drivers/staging/hikey9xx/TODO                 |   5 -
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 297 --------
 .../staging/hikey9xx/hisi-spmi-controller.c   | 367 ----------
 .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 135 ----
 .../hisilicon,hisi-spmi-controller.yaml       |  71 --
 drivers/staging/hikey9xx/phy-hi3670-usb3.c    | 668 ------------------
 drivers/staging/hikey9xx/phy-hi3670-usb3.yaml |  73 --
 27 files changed, 1932 insertions(+), 1686 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
 create mode 100644 Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
 create mode 100644 drivers/mfd/hi6421-spmi-pmic.c
 create mode 100644 drivers/phy/hisilicon/phy-hi3670-usb3.c
 create mode 100644 drivers/spmi/hisi-spmi-controller.c
 delete mode 100644 drivers/staging/hikey9xx/Kconfig
 delete mode 100644 drivers/staging/hikey9xx/Makefile
 delete mode 100644 drivers/staging/hikey9xx/TODO
 delete mode 100644 drivers/staging/hikey9xx/hi6421-spmi-pmic.c
 delete mode 100644 drivers/staging/hikey9xx/hisi-spmi-controller.c
 delete mode 100644 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
 delete mode 100644 drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
 delete mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.c
 delete mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.yaml

-- 
2.31.1


