Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BC93C810F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbhGNJQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238380AbhGNJP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:15:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A5D3613AA;
        Wed, 14 Jul 2021 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626253985;
        bh=7gr0CBndfQM78/xqmfg/z2V2Fg0eKXeoB+3mVSmJ88k=;
        h=From:To:Cc:Subject:Date:From;
        b=CPRJ//RVN5MfTowiHLKPIM1o6PcibCynofRk9JLYkSBMgPae6zbViXlfAbmY0RVk9
         OW3Ajw9YuKEjzrbK0mWSvQDGP1ShQ3lYd6hthn7mewLkFZH5Jzi0EJ/4emcElYScJ3
         h0LCiDAvxdtaOyrwscda6OYT1DETYNnZ7NxO8vW6H0FlOS0xxu8MY3Mpy1KA4V6O98
         SgpcfWvQA240cZtGSfCM+DtDlAuAaSFEaEQuizPziFie+4vgdWmdF9Eljd0bj5+UMQ
         Zg54WixyoMQmctVWrNLOXZNeXIytwnPYSPPM5TC2hmIINoDcxDKOxMIVe6bVWzBpt2
         eTuio/uFmWx5w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m3awx-007q2E-09; Wed, 14 Jul 2021 11:13:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v13 0/9] Move Hisilicon 6421v600 SPMI and USB drivers  out of staging
Date:   Wed, 14 Jul 2021 11:12:52 +0200
Message-Id: <cover.1626253775.git.mchehab+huawei@kernel.org>
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

v13:
  - Addressed an issue pointed by Rob Herring at the DT file (patch 6).
v12:
  - Added Mark Brown's ack to patch 5;
  - Addressed a couple issues at the DT binding, as pointed by Rob Herring
    (patch 1).

Mauro Carvalho Chehab (9):
  staging: hi6421-spmi-pmic: rename GPIO IRQ OF node
  staging: hi6421-spmi-pmic:  add a missing dot at copyright
  staging: hikey9xx: split hi6421v600 irq into a separate driver
  staging: hi6421-spmi-pmic: cleanup drvdata
  staging: hi6421-spmi-pmic: rename spmi_device struct
  staging: hisilicon,hi6421-spmi-pmic.yaml: fix patternProperties
  mfd: hi6421-spmi-pmic: move driver from staging
  dts: hisilicon: add support for the PMIC found on Hikey 970
  dts: hisilicon: add support for USB3 on Hikey 970

 .../mfd}/hisilicon,hi6421-spmi-pmic.yaml      |  12 +-
 MAINTAINERS                                   |   7 +
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 129 +++++++++--
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  56 +++++
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  87 ++++++++
 drivers/mfd/Kconfig                           |  16 ++
 drivers/mfd/Makefile                          |   1 +
 .../mfd/hi6421-spmi-pmic.c                    |  78 +++++--
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 .../hi6421v600-irq.c}                         | 208 +++++++++---------
 drivers/regulator/hi6421v600-regulator.c      |  10 +-
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/staging/hikey9xx/Kconfig              |  19 --
 drivers/staging/hikey9xx/Makefile             |   3 -
 drivers/staging/hikey9xx/TODO                 |   5 -
 17 files changed, 463 insertions(+), 182 deletions(-)
 rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/mfd}/hisilicon,hi6421-spmi-pmic.yaml (93%)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
 rename include/linux/mfd/hi6421-spmi-pmic.h => drivers/mfd/hi6421-spmi-pmic.c (4%)
 rename drivers/{staging/hikey9xx/hi6421-spmi-pmic.c => misc/hi6421v600-irq.c} (48%)
 delete mode 100644 drivers/staging/hikey9xx/Kconfig
 delete mode 100644 drivers/staging/hikey9xx/Makefile
 delete mode 100644 drivers/staging/hikey9xx/TODO

-- 
2.31.1


