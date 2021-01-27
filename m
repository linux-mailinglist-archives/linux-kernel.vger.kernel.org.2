Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4083059C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbhA0Lbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:31:47 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:10310 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236594AbhA0L26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:28:58 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10RBPagY006063;
        Wed, 27 Jan 2021 03:27:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=+U/r1hv8vMbwQxoqhKVPJyeN9OBrqKxluR3gLDB3EU8=;
 b=kGvYDjSoF+abdpf1zdmVc6d4JdYiptveLtI82VzpOlyEa5YLaIEXFz8IH9GFCmdFtF5p
 G81FvxdDuLH7LkyrEg+ii2O+qZhLMdXY8/MQmEiRRuHslpQ3ZWfD9/8Up3MlSH0kTivi
 Q/fBziH4HAWjFq+mXes2gTURPteC9vuwgCF8UavRGCxquXzJ7ckSbTOLXBnXS60F0ixW
 +HGslPSIlfpZ/VOD0h3gEB9wqyIAr8YGtrorlzq6US3T9TXJ/NMp3hfHYoTBUkc4jAjW
 uhARuciOkfn4biB2A0BCIqvhZeBp1OCsbmpoHUufzDRXdN8LAdnl/6F9x77zNOFji+SJ 7w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 368j1ubd7c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 03:27:48 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Jan
 2021 03:27:47 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Jan
 2021 03:27:46 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Jan 2021 03:27:46 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 525753F7040;
        Wed, 27 Jan 2021 03:27:42 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <lkundrak@v3.sk>,
        <linux@armlinux.org.uk>, <sebastian.hesselbarth@gmail.com>,
        <gregory.clement@bootlin.com>, <andrew@lunn.ch>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>, <kishon@ti.com>,
        <miquel.raynal@bootlin.com>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH 0/4] Add support for CP110 UTMI PHY
Date:   Wed, 27 Jan 2021 13:27:15 +0200
Message-ID: <20210127112719.30632-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_04:2021-01-27,2021-01-27 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

This series of patches adds a new PHY driver for supporting CP110 UTMI
PHY in Linux. Currently the functionality of USB ports connected to
this PHY depends on boot loader setup.
The new driver eliminates kernel configuration dependency from the boot
loader. 

Konstantin Porotchkin (4):
  drivers: phy: add support for Armada CP110 UTMI PHY
  devicetree/bindings: add support for CP110 UTMI driver
  arch/arm64: dts: add support for Marvell CP110 UTMI driver
  arch/arm64: dts: enable CP110 UTMI driver

 .../bindings/phy/phy-mvebu-utmi.txt           |  69 +++-
 .../arm64/boot/dts/marvell/armada-7040-db.dts |  12 +-
 .../arm64/boot/dts/marvell/armada-8040-db.dts |  18 +-
 .../boot/dts/marvell/armada-8040-mcbin.dtsi   |  16 +-
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |  19 +
 arch/arm64/boot/dts/marvell/cn9130-db.dts     |  10 +-
 arch/arm64/boot/dts/marvell/cn9131-db.dts     |   8 +-
 arch/arm64/boot/dts/marvell/cn9132-db.dts     |   9 +-
 drivers/phy/marvell/Kconfig                   |   8 +
 drivers/phy/marvell/Makefile                  |   1 +
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c    | 372 ++++++++++++++++++
 11 files changed, 522 insertions(+), 20 deletions(-)
 create mode 100644 drivers/phy/marvell/phy-mvebu-cp110-utmi.c

-- 
2.17.1

