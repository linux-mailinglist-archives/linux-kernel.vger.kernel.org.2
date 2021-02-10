Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E8A3168B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhBJOKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:10:52 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:61244 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230107AbhBJOKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:10:49 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AE0M2r011318;
        Wed, 10 Feb 2021 06:09:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=UZ1uAkupVwu3+By+ZrjgfOs+rNpiV3vVUnT4lZE5/zg=;
 b=TPGUEEs7BRU4ZGloKc7Xgo2wgeK5wd83HU+40e7x9VDu5BGZz+BF4YQ5PrwUllvV4COF
 BysCVrYx2T5ultzjFSNRd3cAGgAhk7OM08qrMGDHNPM/xhBLpyMENevicjZ8OyICz4vO
 Cr1ypVcUI/HVCFD2yqP+EX/eYZvyx1GxCQEFhUu8PRq4S/G+pjLViuNkMhwpIm11kNnF
 xCvY3kXDFqJySPhlaFgFJMbJfTUoUDhj2F1+zTMaExW351rqNwR1whxp+22Lfzl3Jhui
 /mVd2+fFec/xwoHC/B+QRCfeqqkzOprVKAL7Pw8demW8unKTn+1k3syMC05grDd1wOjA rw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36hugqbryh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 06:09:57 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 06:09:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Feb 2021 06:09:55 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 656A43F7041;
        Wed, 10 Feb 2021 06:09:52 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v2 00/12] Device tree fixes for Armada family
Date:   Wed, 10 Feb 2021 16:09:37 +0200
Message-ID: <20210210140949.32515-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_05:2021-02-10,2021-02-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

This set of patches include various device tree additions and fixes
for Marvell Armada SoC families A3700/A7K/A8K.
These changes are ported from Marvell SDK release files.

v2:
- Rebase on top of Linus master branch 5.11-rc7
- Move AP SDHCI "slow-mode" property from AP80x DTSI to AP806 DTSI
- move AP SDHCI bus width change for A8040-DB to a separatye patch
- fix typos in pin control definitions patch
- fix patch description for pin control definitions patch

Ben Peled (2):
  dts: marvell: add 2 eeprom properties to A8K DB device tree
  dts: marvell: add 2 eeprom properties to A7K DB device tree

Grzegorz Jaszczyk (3):
  arm64: dts: marvell: armada-3720-db: add comphy references
  arm64: dts: marvell: armada-3270-espressobin: add comphy references
  arm64: dts: marvell: armada-3720-db: add eeprom description

Konstantin Porotchkin (6):
  fix: arm64: dts: replace wrong regulator on ap emmc
  dts: mvebu: Update A8K AP806/AP807 SDHCI settings
  dts: mvebu: Add pin control definitions for SDIO interafce
  fix: dts: a8k: Add CP eMMC regulator and update device parameters
  fix: ARM64: dts: cp110: Switch to 8-bit ECC NAND setting
  arm64: dts: fix the Armada 8040 DB AP SDHCI bus width

Stefan Chulski (1):
  dts: a3700: enable dma coherence

 .../arm64/boot/dts/marvell/armada-3720-db.dts | 13 +++++++
 .../dts/marvell/armada-3720-espressobin.dtsi  |  5 +++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  2 ++
 .../arm64/boot/dts/marvell/armada-7040-db.dts | 33 +++++++++++++++--
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi  |  6 ++++
 .../arm64/boot/dts/marvell/armada-8040-db.dts | 35 +++++++++++++++++--
 .../boot/dts/marvell/armada-8040-mcbin.dtsi   |  7 +---
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi  |  6 ++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 12 +++++++
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi |  1 -
 10 files changed, 108 insertions(+), 12 deletions(-)

-- 
2.17.1

