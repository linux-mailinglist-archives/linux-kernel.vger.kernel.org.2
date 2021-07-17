Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E353CC256
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 11:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhGQKBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 06:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232993AbhGQKBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 06:01:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA9D8613E8;
        Sat, 17 Jul 2021 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626515903;
        bh=4z4BKAC0MMEjYpl+Jy5xNnrifKZsNO5uPep0gMPeJTs=;
        h=From:To:Cc:Subject:Date:From;
        b=gvPpVFjWvOYKZ1RiwOcGtMRbXgoxC/s8rgOqoMzuO3QzXkXibtMxk76sb2nQO12AA
         d4/hoeFDL/BkZfuA/C7T90kVFE2wXqDy9Ic6dpDbdsrrSGuVA+dOjjC057e5LWQAoW
         N0J9GE8ybyUeUOUnYi4Nfx0JsqHvgKFQ+0RDdyPUN8WP9Rnjewi9drcRc91StmqI4i
         8gKGQmXMn2kzGGgxID5z7DePeupSaptgesSePrSW+x0UgP9+kPTKkzfKGx9xY0Zt5n
         OZJ4e0bNF6GP06pdsZLVuN7M05uSK5tl4Coh61UJELc9pelszn1zBCIFaNJDyPVtJt
         GVgYk681wpqzw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m4h5R-0007Jx-NT; Sat, 17 Jul 2021 11:58:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v14 0/9] Move Hisilicon 6421v600 SPMI and USB drivers  out of staging
Date:   Sat, 17 Jul 2021 11:58:11 +0200
Message-Id: <cover.1626515862.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This series contain the final bits needed for the USB3 bus to work without 
staging drivers on Hikey 970.  It is based on next-20210714, as it depends
on a patch on this branch:

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

v14:
  - use platform_get_irq() instead of of_get_gpio().
v13:
  - Addressed an issue pointed by Rob Herring at the DT file (patch 6).
v12:
  - Added Mark Brown's ack to patch 5;
  - Addressed a couple issues at the DT binding, as pointed by Rob Herring
    (patch 1).



Mauro Carvalho Chehab (9):
  staging: hi6421-spmi-pmic: rename spmi_device struct
  staging: hi6421-spmi-pmic: rename GPIO IRQ OF node
  staging: hi6421-spmi-pmic:  add a missing dot at copyright
  staging: hikey9xx: split hi6421v600 irq into a separate driver
  staging: hi6421-spmi-pmic: cleanup drvdata
  staging: hisilicon,hi6421-spmi-pmic.yaml: fix patternProperties
  mfd: hi6421-spmi-pmic: move driver from staging
  dts: hisilicon: add support for the PMIC found on Hikey 970
  dts: hisilicon: add support for USB3 on Hikey 970

 .../mfd}/hisilicon,hi6421-spmi-pmic.yaml      |  16 +-
 MAINTAINERS                                   |   7 +
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 129 ++++++--
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  56 ++++
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  88 +++++
 drivers/mfd/Kconfig                           |  16 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/hi6421-spmi-pmic.c                |  66 ++++
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/hi6421v600-irq.c                 | 306 +++++++++++++++++
 drivers/regulator/hi6421v600-regulator.c      |  10 +-
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/staging/hikey9xx/Kconfig              |  19 --
 drivers/staging/hikey9xx/Makefile             |   3 -
 drivers/staging/hikey9xx/TODO                 |   5 -
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 311 ------------------
 include/linux/mfd/hi6421-spmi-pmic.h          |  30 --
 19 files changed, 675 insertions(+), 402 deletions(-)
 rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/mfd}/hisilicon,hi6421-spmi-pmic.yaml (92%)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
 create mode 100644 drivers/mfd/hi6421-spmi-pmic.c
 create mode 100644 drivers/misc/hi6421v600-irq.c
 delete mode 100644 drivers/staging/hikey9xx/Kconfig
 delete mode 100644 drivers/staging/hikey9xx/Makefile
 delete mode 100644 drivers/staging/hikey9xx/TODO
 delete mode 100644 drivers/staging/hikey9xx/hi6421-spmi-pmic.c
 delete mode 100644 include/linux/mfd/hi6421-spmi-pmic.h

-- 
2.31.1


