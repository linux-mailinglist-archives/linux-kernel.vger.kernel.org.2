Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F70430DB8B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhBCNla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:41:30 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:60732 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232143AbhBCNcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:32:54 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113DPtWS010584;
        Wed, 3 Feb 2021 05:31:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=n5N7J+5rz5QTQTkorPKF+GGCBs3nM6P5cR/xlECDUmo=;
 b=AQU46sY3/+OkkVMuvOMv6OrCtUfJvM3E99Z874gbBcndw1+pMn5wFg0zHhxjNF5U0BSU
 C0wAfAcX6Zk2ejdc5/Sws6yIK/G8W+YSVSNoGoC2rOdYWCzzLLODaoLiQq3ejZSWeRXG
 MnURmHCY1+0ZP7aXHTeT5lc32QLWHVa6tTjljxu/qYR4HC7P0WCy0NeAl1I8WKFppQNf
 Qmb1KWyGLS/r/q91ZD63cu8tb9CPg6piZm/9vc3sMU+0m1o1q+vMeHZMvgCkl2wE0LNH
 CpZmZkraHnpe/s8FtBgy+F8Miz1hImMmKE0YVp4YUfp6QBMHopOq91Cg2Qlm/UXLQB75 sA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36fnr6153s-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 05:31:48 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 05:31:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Feb 2021 05:31:44 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id C07973F7044;
        Wed,  3 Feb 2021 05:31:41 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH 00/11] Device tree fixes for Armada family
Date:   Wed, 3 Feb 2021 15:31:27 +0200
Message-ID: <20210203133138.10754-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-03_05:2021-02-03,2021-02-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

This set of patches include various device tree additions and fixes
for Marvell Armada SoC families A3700/A7K/A8K.
These changes are ported from Marvell SDK release files.

Ben Peled (2):
  dts: marvell: add 2 eeprom properties to A8K DB device tree
  dts: marvell: add 2 eeprom properties to A7K DB device tree

Grzegorz Jaszczyk (3):
  arm64: dts: marvell: armada-3720-db: add comphy references
  arm64: dts: marvell: armada-3270-espressobin: add comphy references
  arm64: dts: marvell: armada-3720-db: add eeprom description

Konstantin Porotchkin (5):
  fix: arm64: dts: replace wrong regulator on ap emmc
  dts: mvebu: Update A8K AP806 SDHCI settings
  dts: mvebu: Add pin control definitions for SDIO interafce
  fix: dts: a8k: Add CP eMMC regulator and update device parameters
  fix: ARM64: dts: cp110: Switch to 8-bit ECC NAND setting

Stefan Chulski (1):
  dts: a3700: enable dma coherence for PCIE interface

 .../arm64/boot/dts/marvell/armada-3720-db.dts | 13 ++++++
 .../dts/marvell/armada-3720-espressobin.dtsi  |  5 +++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  1 +
 .../arm64/boot/dts/marvell/armada-7040-db.dts | 33 +++++++++++++-
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi  |  6 +++
 .../arm64/boot/dts/marvell/armada-8040-db.dts | 44 +++++++++++++++++--
 .../boot/dts/marvell/armada-8040-mcbin.dtsi   |  7 +--
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi  |  6 +++
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi |  1 -
 9 files changed, 104 insertions(+), 12 deletions(-)

-- 
2.17.1

