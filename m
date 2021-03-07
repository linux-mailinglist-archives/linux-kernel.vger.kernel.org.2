Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7063302F5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 17:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhCGQeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 11:34:44 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:4990 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232420AbhCGQef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 11:34:35 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 127GU7in001922;
        Sun, 7 Mar 2021 08:34:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=KLPb1rsjkx3u5PlGJi+FbOtdgcEFCynWuOWB2GJCFGs=;
 b=Lgvh60sWzae7yYAxihota6M6a3gfJ4V2TK3Py6uRV5Hp4Hzi5s6miKdGgUJ2ySJm7aRt
 s44l5I2h8xsCkWq8CCZ4GVEkQ4MMOBeBSfu5auAQSF31RlzdRrt3AKwz3fvDhvO/2kMU
 5saaU60P0/rbkvNaFFSIzhbp9OJon/yoFA/QvOQ29HVnnoiQl5bgPHE2HA6iLZYrp6h1
 3R/T7IMzcEpJe79/HPVLl41pM87THgn3yol+tJq4MLZgpvs34I5Lk1vRH8utZD2HXIg2
 eQGUmuon6PeWAmdfwrFtE2aIIFSr03Jz5TDtc/IYUh3AtrXYm3+5o02c6d0F+aTFquc6 6Q== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 374drqsr2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 07 Mar 2021 08:34:01 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 7 Mar
 2021 08:33:59 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 7 Mar 2021 08:33:59 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 2DA893F7040;
        Sun,  7 Mar 2021 08:33:54 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lkundrak@v3.sk>, <linux@armlinux.org.uk>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@ti.com>, <miquel.raynal@bootlin.com>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <nadavh@marvell.com>, <stefanc@marvell.com>,
        <bpeled@marvell.com>, "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v3 0/5] Add support for CP110 UTMI PHY
Date:   Sun, 7 Mar 2021 18:33:37 +0200
Message-ID: <20210307163343.25684-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-07_10:2021-03-03,2021-03-07 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

This series of patches adds a new PHY driver for supporting CP110 UTMI
PHY in Linux. Currently the functionality of USB ports connected to
this PHY depends on boot loader setup.
The new driver eliminates kernel configuration dependency from the boot
loader. 

v3:
- rebase on top of Linux 5.12-rc2
- convert Armada 3700 UTMI PHY DT binding document to YAML schema
- create a separate DT binding for Armada CP11x UTMI PHY in YAML format
- change UTMI PHY port node names from "phy" to "usb-phy"

v2:
- extend the comment about reference clock 
- fix driver probe function, add some prints
- move to usage of dr_mode from connected USB controller instead of
  dedicated device tree property

Konstantin Porotchkin (5):
  drivers: phy: add support for Armada CP110 UTMI PHY
  dt-bindings: phy: convert phy-mvebu-utmi to YAML schema
  devicetree/bindings: add support for CP110 UTMI PHY
  arch/arm64: dts: add support for Marvell CP110 UTMI PHY
  arch/arm64: dts: enable CP110 UTMI PHY usage

 .../phy/marvell,armada-3700-utmi-phy.yaml     |  57 +++
 .../phy/marvell,armada-cp110-utmi-phy.yaml    | 109 +++++
 .../bindings/phy/phy-mvebu-utmi.txt           |  38 --
 .../arm64/boot/dts/marvell/armada-7040-db.dts |  14 +-
 .../arm64/boot/dts/marvell/armada-8040-db.dts |  21 +-
 .../boot/dts/marvell/armada-8040-mcbin.dtsi   |  19 +-
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |  19 +
 arch/arm64/boot/dts/marvell/cn9130-db.dts     |  12 +-
 arch/arm64/boot/dts/marvell/cn9131-db.dts     |   9 +-
 arch/arm64/boot/dts/marvell/cn9132-db.dts     |  11 +-
 drivers/phy/marvell/Kconfig                   |   8 +
 drivers/phy/marvell/Makefile                  |   1 +
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c    | 384 ++++++++++++++++++
 13 files changed, 650 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
 create mode 100644 drivers/phy/marvell/phy-mvebu-cp110-utmi.c

-- 
2.17.1

