Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F2F3150C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhBINto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:49:44 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:63504 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231682AbhBINrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:47:36 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119Dk7lg022653;
        Tue, 9 Feb 2021 05:46:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pfpt0220;
 bh=NsaKeOrilWlS6VK3p4SEc3ce3qbp86cqk1fIIO4fDGs=;
 b=g4nm0ZwdUZkgBANHfad5EPVOaNHM9P8a6AdI6A7FE/gn7m7HlB81ErA7otLY2pZwc81j
 EtQlOcADx+C3TtY5/VtIi66dRp0CXH7qa+shypzkfXmFClaedL7DgctP9VKZJdHgkLN/
 WaKdv2MkL+EHxRu3GT2l6IMlQYgjSygI3C5Q8BDR0CTAZQdLyV/4HaVRYk4GgwR5OCDr
 5KgtKc813+LGnS2fKEglz3fTfn+ItuOGKx1ai24W52UknVZMHBPvMhtM2u1qTg/B6+Eu
 IMR82me7tDg/yWg1h/95ZbNo7JUIgPvELSg99Gf/AmGV8067r7gRrNU1mi5xCh7Gx7IG sA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 36hsbrgcnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 05:46:35 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 9 Feb
 2021 05:46:34 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 9 Feb
 2021 05:46:33 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Feb 2021 05:46:33 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 907833F703F;
        Tue,  9 Feb 2021 05:46:29 -0800 (PST)
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
Subject: [PATCH v4 0/5] DTS updates for Marvell Armada CN913x platforms
Date:   Tue, 9 Feb 2021 15:46:05 +0200
Message-ID: <20210209134610.19904-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_03:2021-02-09,2021-02-09 signatures=0
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

Grzegorz Jaszczyk (1):
  Documentation/bindings: phy: update references to cp11x

Konstantin Porotchkin (3):
  arch/arm64/boot/dts/marvell: fix NAND partitioning scheme
  arm64: dts: cn913x: add device trees for topology B boards
  arm64: dts: add support for Marvell cn9130-crb platform

Stefan Chulski (1):
  dts: marvell: Enable 10G interface on 9130-DB board

 .../bindings/phy/phy-mvebu-comphy.txt         |  12 +-
 arch/arm64/boot/dts/marvell/Makefile          |   5 +
 arch/arm64/boot/dts/marvell/cn9130-crb-A.dts  |  38 ++
 arch/arm64/boot/dts/marvell/cn9130-crb-B.dts  |  46 ++
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi   | 221 ++++++++++
 arch/arm64/boot/dts/marvell/cn9130-db-B.dts   |  22 +
 arch/arm64/boot/dts/marvell/cn9130-db.dts     | 393 +----------------
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi    | 402 ++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9131-db-B.dts   |  22 +
 arch/arm64/boot/dts/marvell/cn9131-db.dts     | 192 +--------
 arch/arm64/boot/dts/marvell/cn9131-db.dtsi    | 201 +++++++++
 arch/arm64/boot/dts/marvell/cn9132-db-B.dts   |  22 +
 arch/arm64/boot/dts/marvell/cn9132-db.dts     | 211 +--------
 arch/arm64/boot/dts/marvell/cn9132-db.dtsi    | 220 ++++++++++
 14 files changed, 1223 insertions(+), 784 deletions(-)
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

