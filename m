Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151D83B9D0D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 09:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhGBHkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 03:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhGBHkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 03:40:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA51E61422;
        Fri,  2 Jul 2021 07:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625211449;
        bh=9wdXOn+pi5x21zThZ9xYsOcTNUeFf2P6+hKfw/j90ks=;
        h=From:To:Cc:Subject:Date:From;
        b=ozgFGtfddw/jhVGe1By8fTZrC7efwneSZ+hUFMq9HdIRsRabHLn2FT6MRXMqTiQFn
         +Uct/R/nUz6QFmvvAYijqb01RD9sH35wwTkvIzmMNenyRWv/PtzoxDN5iZnIRTfJaa
         JqMPw79aSLweB1xY+/K4LrbZyhCbh5inK4986oollB3MSJzky1TBN4zFjYdSny6hQ6
         FYXmTr8i1v+zST/tQ/ldpwuki9IAN56HTdXpOOuGWCxZA+IaKHgMQTtqkPNfvbQJqr
         5bECufDCsRSaP4UStTOL/zH31aaOfQTwKOYOE2h6j0x/CnGl+ecTm7DPMd44Vx749u
         1zld4cuFtQ7jA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lzDjo-000gZY-MZ; Fri, 02 Jul 2021 09:37:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Axel Lin <axel.lin@ingics.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v11 0/8] Move Hisilicon 6421v600 SPMI and USB drivers  out of staging
Date:   Fri,  2 Jul 2021 09:37:15 +0200
Message-Id: <cover.1625211021.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

As promised, that's the version 11, meant to be applied after -rc1.

It depends on a regression fix patch merged via the regulator's tree:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commit/?h=for-5.14&id=5db5dd5be70eaf808d9fd90174b957fc5c2912cb

(the dependence is just because of a trivial merge conflict)

This series contain the final bits needed for the USB3 bus to work
without staging drivers on Hikey 970.

Mauro Carvalho Chehab (8):
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


