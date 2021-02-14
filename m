Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D6131B119
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 17:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhBNQCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 11:02:32 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43904 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229818AbhBNQC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 11:02:27 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11EG1GEU021788;
        Sun, 14 Feb 2021 08:01:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=ogSuRtTToDxm0KLDyCBxSkm64HdwCCcJDDXpIYcxEww=;
 b=CP2jAmYtexe057KcyKfykr1152lXqdloEw1u3qjJnMo0s2xSgp6GhzU0uiX8S8oWIch7
 jVDuiZhv5bkE2bWghOWIaNPOh7RY2p4NddKycZOFfWgtg9OAziWApKYrdh03qG7J6kd2
 rCrWcCqhw+yJryEXn+lnXGA4l7P/ETuXIHgOd+e0FZXGXtP48IbF759BksQ9QEdF6vcs
 j1qH7b59jWsKBH3nJhMuTs6WcOgnV1Qr0j0dVUY+Sxz0M4D7Epx5BgjErxGKNcAApIh9
 Ak5JSvwOINrDHEeqZT4KEiHsOC/ZQX88UK6QtGbuvFd0daPF+/y+oInA/V0ELEcTKO4w ng== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 36pd0vj6g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 14 Feb 2021 08:01:16 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 14 Feb
 2021 08:01:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 14 Feb 2021 08:01:14 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id A24073F703F;
        Sun, 14 Feb 2021 08:01:10 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lkundrak@v3.sk>, <linux@armlinux.org.uk>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@ti.com>, <miquel.raynal@bootlin.com>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <nadavh@marvell.com>, <stefanc@marvell.com>,
        <bpeled@marvell.com>, "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v2 0/4] Add support for CP110 UTMI PHY
Date:   Sun, 14 Feb 2021 18:01:04 +0200
Message-ID: <20210214160108.3879-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-14_04:2021-02-12,2021-02-14 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

This series of patches adds a new PHY driver for supporting CP110 UTMI
PHY in Linux. Currently the functionality of USB ports connected to
this PHY depends on boot loader setup.
The new driver eliminates kernel configuration dependency from the boot
loader. 

v2:
- extend the comment about reference clock 
- fix driver probe function, add some prints
- move to usage of dr_mode from connected USB controller instead of
  dedicated device tree property

Konstantin Porotchkin (4):
  drivers: phy: add support for Armada CP110 UTMI PHY
  devicetree/bindings: add support for CP110 UTMI driver
  arch/arm64: dts: add support for Marvell CP110 UTMI driver
  arch/arm64: dts: enable CP110 UTMI driver

 .../bindings/phy/phy-mvebu-utmi.txt           |  78 +++-
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
 11 files changed, 556 insertions(+), 20 deletions(-)
 create mode 100644 drivers/phy/marvell/phy-mvebu-cp110-utmi.c

-- 
2.17.1

