Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232113167C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhBJNRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:17:52 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:14565 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231645AbhBJNRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:17:12 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AD0rJ5026544;
        Wed, 10 Feb 2021 05:16:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pfpt0220;
 bh=7G6G4s8kEGyi6axELou43lAhPB6F1vgNyot8VFqJ7Uk=;
 b=QDkgLEw/8zuwPH0pLZq0I8Qob+DUvgCV65xh1zdyAY6LFiT1LybgFCi1w/9X53RMyZOx
 VVFpaqVENu78ErYS/Qu5A+4DI/qfAwa35cDovc8778BHW1CfUIMm75NEuPZj+MKWKGyQ
 A43kraALHq9hR3oZGDEXITlJOve4keWvBFbGkEhhHXObJLTuNvfeamkyeXxsmCoWVKo+
 Ufe6I8xHxQjZl9hb1Akz+M4Yr20sIQvLDZ0d7aJYYVQkKCBZUT+XFsKvZKm0Oe1P1eFN
 Hgu+KE7J+94hIDcRvDeBJcuoBqEfKZKvkWFJDKYOscB55CeAXaMg+X4rKsnC28T6yrVs YQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36hugqbn5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 05:16:14 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 05:16:12 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 05:16:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Feb 2021 05:16:11 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 8348D3F7040;
        Wed, 10 Feb 2021 05:16:07 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <vladimir.vid@sartura.hr>, <tmn505@gmail.com>,
        <luka.kovacic@sartura.hr>, <sebastian.hesselbarth@gmail.com>,
        <gregory.clement@bootlin.com>, <andrew@lunn.ch>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>, <kishon@ti.com>,
        <miquel.raynal@bootlin.com>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v5 0/5] DTS updates for Marvell Armada CN913x platforms
Date:   Wed, 10 Feb 2021 15:15:59 +0200
Message-ID: <20210210131604.28806-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_05:2021-02-10,2021-02-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

This patch series contains the following changes/fixes:
1. Add support for Armada CN913x Development Board topology "B"
2. Add support for Armada CN913x Reference Design boards (CRB)
3. Fixes the CP11X references in PHY binding document
4. Fixes the NAND paritioninig scheme in DTS eliminating gap between
consecutive partitions
All above changes are already intergated into Marvell official SDK sources

v2:
- extract common nodes from DB boards to separate DTSI files
- disable eth2 on CRB boards until the required phy mode support is added
- mention the switch part ID in CRB board description

v3:
- do not rename setup A DTS files for DB variants
- fix a couple of wrong include names

v4:
- Rebase on top of Linus master branch (v5.11-rc7)
- Remove HS400 timing from CRB AP SDHCI (not supported by connected eMMC)
- Add cd-gpio entry to CP0 SDHCI for SD card support
- Add a comment to CN9130-CRB patch about the required defconfig
  changes for supporting the onboard i2c expander
- Add Stefan's patch to enable 10G port on CN9130-DB platforms

v5:
- Extend enablement of 10G port to CN9131-DB platform

Grzegorz Jaszczyk (1):
  Documentation/bindings: phy: update references to cp11x

Konstantin Porotchkin (3):
  arch/arm64/boot/dts/marvell: fix NAND partitioning scheme
  arm64: dts: cn913x: add device trees for topology B boards
  arm64: dts: add support for Marvell cn9130-crb platform

Stefan Chulski (1):
  dts: marvell: Enable 10G interfaces on 9130-DB and 9131-DB boards

 .../bindings/phy/phy-mvebu-comphy.txt         |  12 +-
 arch/arm64/boot/dts/marvell/Makefile          |   5 +
 arch/arm64/boot/dts/marvell/cn9130-crb-A.dts  |  38 ++
 arch/arm64/boot/dts/marvell/cn9130-crb-B.dts  |  46 ++
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi   | 222 ++++++++++
 arch/arm64/boot/dts/marvell/cn9130-db-B.dts   |  22 +
 arch/arm64/boot/dts/marvell/cn9130-db.dts     | 393 +----------------
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi    | 402 ++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9131-db-B.dts   |  22 +
 arch/arm64/boot/dts/marvell/cn9131-db.dts     | 192 +--------
 arch/arm64/boot/dts/marvell/cn9131-db.dtsi    | 201 +++++++++
 arch/arm64/boot/dts/marvell/cn9132-db-B.dts   |  22 +
 arch/arm64/boot/dts/marvell/cn9132-db.dts     | 211 +--------
 arch/arm64/boot/dts/marvell/cn9132-db.dtsi    | 220 ++++++++++
 14 files changed, 1224 insertions(+), 784 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-crb-A.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-crb-B.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db-B.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db-B.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9132-db-B.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9132-db.dtsi

-- 
2.17.1

