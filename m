Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519C83BFA8E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhGHMtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:49:18 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:17348 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230433AbhGHMtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:49:17 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168CfEJE011801;
        Thu, 8 Jul 2021 05:46:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pfpt0220;
 bh=m5Uc22hMRjeEfVSmrTxa3e2oLWBUJBkyj+WY38JXkrw=;
 b=GUPJ/Dym/fN685lueb9cEpshyWJM3jshhCaUS9p08PVnZFIU0Xz7foG5OqHrRqXPDa56
 I03Ldia5BXnRa/DkRpwSN1VMXlOiXtwchVHq6j8YdQF6CyBrPmy0T4ap7KWRMLUYLo2d
 pC/SWYbTzCeCfwiD0bxQ0U+AYs6YFabd3Y/MpnU4zhwd4Or2z9a4pqw5igq3FfZ4spM9
 8JO5vYePJsEGnUsHegZpCtoe2HDFvLCUDeilDAZNFutfuy4koPmCzAwnwOXBa8Ova0y3
 S/TvEdfBERdLw+fCNn/F7S+vykTY8MgonsBe96pNCogXJ0aN0XqZB9kN10tEfh1uk8it Ug== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 39nrnu1y0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 05:46:22 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 8 Jul
 2021 05:46:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 8 Jul 2021 05:46:20 -0700
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 723493F7079;
        Thu,  8 Jul 2021 05:46:16 -0700 (PDT)
From:   <kostap@marvell.com>
To:     <miquel.raynal@bootlin.com>, <kishon@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <vladimir.vid@sartura.hr>, <luka.kovacic@sartura.hr>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mw@semihalf.com>, <jaz@semihalf.com>, <nadavh@marvell.com>,
        <stefanc@marvell.com>, <bpeled@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH v7 0/5] DTS updates for Marvell Armada CN913x platforms
Date:   Thu, 8 Jul 2021 15:46:07 +0300
Message-ID: <20210708124612.30742-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7Nbks_ONXbq2kzqpEX9vtPMfr6MLwB7J
X-Proofpoint-GUID: 7Nbks_ONXbq2kzqpEX9vtPMfr6MLwB7J
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_06:2021-07-08,2021-07-08 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

This patch series contains the following changes/fixes:
1. Add support for Armada CN913x Development Board topology "B"
2. Add support for Armada CN913x Reference Design boards (CRB)
3. Fixes the NAND paritioninig scheme in DTS eliminating gap between
   consecutive partitions
4. Fix 10Gb ports PHY mode names

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

v6:
- Rebased on top of 5.13-rc, merging UTMI settings
  (requested by Gregory Clement)

v7:
- Remove documentation patch fixing CP11X references in PHY binding document
- Change Armada's family 10Gb port phy mode names from 10gbase-kr to 10gbase-r

Konstantin Porotchkin (4):
  arch/arm64/boot/dts/marvell: fix NAND partitioning scheme
  arm64: dts: cn913x: add device trees for topology B boards
  arm64: dts: add support for Marvell cn9130-crb platform
  arch/arm64: dts: change 10gbase-kr to 10gbase-r in Armada

Stefan Chulski (1):
  dts: marvell: Enable 10G interfaces on 9130-DB and 9131-DB boards

 arch/arm64/boot/dts/marvell/Makefile          |   5 +
 .../arm64/boot/dts/marvell/armada-7040-db.dts |   2 +-
 .../arm64/boot/dts/marvell/armada-8040-db.dts |   4 +-
 arch/arm64/boot/dts/marvell/cn9130-crb-A.dts  |  38 ++
 arch/arm64/boot/dts/marvell/cn9130-crb-B.dts  |  46 ++
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi   | 222 ++++++++++
 arch/arm64/boot/dts/marvell/cn9130-db-B.dts   |  22 +
 arch/arm64/boot/dts/marvell/cn9130-db.dts     | 403 +----------------
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi    | 410 ++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9131-db-B.dts   |  22 +
 arch/arm64/boot/dts/marvell/cn9131-db.dts     | 197 +--------
 arch/arm64/boot/dts/marvell/cn9131-db.dtsi    | 206 +++++++++
 arch/arm64/boot/dts/marvell/cn9132-db-B.dts   |  22 +
 arch/arm64/boot/dts/marvell/cn9132-db.dts     | 218 +---------
 arch/arm64/boot/dts/marvell/cn9132-db.dtsi    | 227 ++++++++++
 15 files changed, 1241 insertions(+), 803 deletions(-)
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

