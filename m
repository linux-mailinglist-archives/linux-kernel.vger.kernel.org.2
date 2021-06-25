Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4643B3DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhFYHss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhFYHsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:48:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61BC36142C;
        Fri, 25 Jun 2021 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624607172;
        bh=X3wjcU/BQy8GCBDaVQvj+55WHVFoAZZ33UGx75kbwJk=;
        h=From:To:Cc:Subject:Date:From;
        b=qKn6xupDGpi5uOfK3/Mtp2T6dIsoq6mEtDq51n6UcNUlAKY+CxtsdA4iYyBL+Mfcd
         FTNlTFujDZHcFe62YNxMbwBQAlw79SeO1kNngqVmkz+OyUS1eYuFPAOl3otu6pz67b
         D1MrKq6yW7tUQxI/gKedEMEZZTJ+HwpKibJQjCP7RsoWXlbsuK04XHrhysdKzLOqwJ
         t1z+/dyiFasHf2eIOHL/tYAugpKDS0fEJ8A2skEPjrdOfh/IYFWm7IfIOAkZ5ej9OA
         OeJaIREv91wiwye9nsCotmdr6J+M/MM7AtgfN3kSvURH0Sp/sFsC3HQox4bURnDeRx
         HB2ovOP7KjDQA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lwgXS-004ae2-7T; Fri, 25 Jun 2021 09:46:10 +0200
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
Subject: [PATCH v8 00/12] Move Hisilicon 6421v600 SPMI and USB drivers out of staging
Date:   Fri, 25 Jun 2021 09:45:52 +0200
Message-Id: <cover.1624606660.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for merging patches 1 and 2 from the v7 series!

Those are the remaining patches that are needed for the USB to work
with Hikey970.

I guess patches 1 and 2 on this series are also OK, as they were acked
by the PHY and SPMI maintainers.

As suggested on your last review, I broke the MFD staging patches 
into one logical change per patch.

Except for the split, the only change from v7 was at the copyright: 
I'm using 20xx-2021 instead of 20xx- to indicate that the copyrights
extend to the present. I also changed the HiSilicon name to better
reflect the name of the company.

Mauro Carvalho Chehab (12):
  phy: phy-hi3670-usb3: move driver from staging into phy
  spmi: hisi-spmi-controller: move driver from staging
  staging: hisilicon,hi6421-spmi-pmic.yaml: cleanup descriptions
  staging: hi6421-spmi-pmic: update copyright's year
  staging: hi6421-spmi-pmic: use devm_request_threaded_irq()
  staging: hi6421-spmi-pmic: better name IRQs
  staging: hi6421-spmi-pmic: change a return code
  staging: hi6421-spmi-pmic: change identation of a table
  staging: hi6421-spmi-pmic: cleanup some macros
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
 drivers/phy/hisilicon/phy-hi3670-usb3.c       | 661 ++++++++++++++++++
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
 .../hisilicon,hisi-spmi-controller.yaml       |  73 --
 drivers/staging/hikey9xx/phy-hi3670-usb3.c    | 661 ------------------
 drivers/staging/hikey9xx/phy-hi3670-usb3.yaml |  73 --
 27 files changed, 1932 insertions(+), 1681 deletions(-)
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


