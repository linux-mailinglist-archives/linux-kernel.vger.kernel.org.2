Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D773BBA5D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhGEJlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:41:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230421AbhGEJlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:41:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68C9E613F3;
        Mon,  5 Jul 2021 09:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625477942;
        bh=vxAWY0ph6pmD3HQOObhs9oaejXG7EqWCVvjjXkEJ4tQ=;
        h=From:To:Cc:Subject:Date:From;
        b=BHnV8OF0dDWQOPfKdV2ED8A+zfgkH6lFzOTOmc5wampmO/oBmLh42iS0nmVDrwXAO
         pD3qLZ1ks4qecuJ6jb9VZoUKB2ajzvFdbTT0A2YJrRSvbEAEISAz3m6YFv4MNinVAM
         iX7EKmsZ+R1ynxGrZG3rL45ZqkQ9V8oF+3Re0m4t1uQrnadJqzqFUpkhvNR8N1Jn4Q
         FcIbHiVAWHo9tN6vZKQs/UsImjM/cxFr+z+LXiVijkGglArAA6Sl98+EmpuSBMgv9k
         /RrxZouJfwqRxksPRuemsWSnaicuJaRIsRVtmrqN/7T8/TchLotdyGbrEJdsRxkYmw
         co0OwDiJrwGxw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m0L43-002toh-3M; Mon, 05 Jul 2021 11:38:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v12 0/9] Move Hisilicon 6421v600 SPMI and USB drivers  out of staging
Date:   Mon,  5 Jul 2021 11:38:41 +0200
Message-Id: <cover.1625477735.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This series depends on a regression fix patch merged via the regulator's tree, not merged upstream yet:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commit/?h=for-5.14&id=5db5dd5be70eaf808d9fd90174b957fc5c2912cb

(the dependence is just because of a trivial merge conflict)

This series contain the final bits needed for the USB3 bus to work
without staging drivers on Hikey 970.

v12:
  - Added Mark Brown's ack to patch 5;
  - Addressed a couple issues at the DT binding, as pointed by Rob Herring
    (patch 1).

Mauro Carvalho Chehab (9):
  staging: hi6421-spmi-pmic: rename GPIO IRQ OF node
  staging: hi6421-spmi-pmic:  add a missing dot at copyright
  regulator: hi6421v600-regulator: add a missing dot at copyright
  staging: hikey9xx: split hi6421v600 irq into a separate driver
  staging: hi6421-spmi-pmic: cleanup drvdata
  staging: hi6421-spmi-pmic: rename spmi_device struct
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
 drivers/regulator/hi6421v600-regulator.c      |  12 +-
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/staging/hikey9xx/Kconfig              |  19 --
 drivers/staging/hikey9xx/Makefile             |   3 -
 drivers/staging/hikey9xx/TODO                 |   5 -
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 311 -----------------
 .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 134 --------
 include/linux/mfd/hi6421-spmi-pmic.h          |  30 --
 20 files changed, 807 insertions(+), 530 deletions(-)
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


