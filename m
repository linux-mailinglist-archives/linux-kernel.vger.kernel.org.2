Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B63C452ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhKPKS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:18:29 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:18402 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbhKPKR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637057701; x=1668593701;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Aqt80l1Y6tbSJAfiQi32uT4d2+Qm6+TpUaaH3QBLRUw=;
  b=Dbk3td7RaF2csZnKkdxODM6DaHdVIliKriVN0CinRz/pMNkJed1oEn4B
   8VwueIPCIJeTmS+s3MM07lUMIcEBMJNgzKsRZdx3tUmIjjMDS0L6HYacA
   ig0+Ui9tEC4msr06uBDcV72tnUpm4BeglQSXMP3OK2yM2RDiuz2/3xzk4
   57BjaQ/bDqQNTF//SFcoxNXW4e63b3JGW6BsMvqi2dgnvS8qxxkIaLP12
   AdyCxum1AcWnV7gfkR0/Kp3X8VpTHMvQek4RoGEHcfXmntA2//v+2X19F
   ZJM9RlZF/bU5Phz/fgP56TV///rq1HxbvQzUETWhkIy4MFSTr7IoHU5Ek
   g==;
IronPort-SDR: rs9dnnfEcHovf6tZaigQDdgATM2tySwW5i5ReS5q2HS34w6AJt7ZYk0L76SSJVCxUhMKyr1gNR
 kkwn+loo8cRKE22AN4qOh3IkH0pqagD4g3teIoDY4dR1Vh5wfDDOUwUvaZNRZAA1g9fq7X1l8I
 M6HdsIrKYo7ehhsSC4HfIYcxFOkA61TVLyv9VjwqKyYHDlbR384gZtYnA1lPR9jXk8u6KXnjLd
 4/LEOpcjcXYDMJwhFQQpP4KLoAeN15MaATs15o8/OCAr5sMo2vQ0LK15q+eoGVn+YajxkqmLAv
 I9nlnlmoT4ev8jV+yEYrbHR0
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="136710462"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 03:14:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 03:14:55 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 03:14:53 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <alexandre.belloni@bootlin.com>,
        <kuba@kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH resend v4 0/3] phy: Add driver for lan966x Serdes driver
Date:   Tue, 16 Nov 2021 11:08:15 +0100
Message-ID: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serie adds support for Microchip lan966x serdes. The lan966x
device contains 7 interfaces, consisting of 2 copper transceivers,
3 Serdes and 2 RGMII interfaces. Two of the Serdes support QSGMII.
The driver also adds the functionality of "muxing" the interfaces to
different logical ports.

The following table shows which interfaces can be supported by the port.

PortNumber    Max Speed    Ethernet interface options
    0            1Gbps       CuPHY, 1G SGMII or QSGMII
    1            1Gbps       CuPHY, 1G SGMII or QSGMII
    2          2.5Gbps       2.5G SGMII, QSGMII, RGMII
    3          2.5Gbps       2.5G SGMII, QSGMII, RGMII
    4          2.5Gbps       2.5G SGMII, QSGMII
    5            1Gbps       QSGMII, RGMII
    6            1Gbps       QSGMII, RGMII
    7            1Gbps       QSGMII

v3->v4:
- update description of the driver
- removed unused registers
- use bitfield operations in the registers
- add macros for PLL configuration
- move macros and structs at the top of the file

v2->v3:
- remove unused includes
- add missing '...' in microchip,lan966x-serdes.yaml
- rename lan966x-serdes.h to phy-lan966x-serdes.h
- Rename CU->PHY and RG->RGMII
- update commit message for PATCH 2

v1->v2:
- replace the regmap with iomem
- update DT bindings

Horatiu Vultur (3):
  dt-bindings: phy: Add lan966x-serdes binding
  dt-bindings: phy: Add constants for lan966x serdes
  phy: Add lan966x ethernet serdes PHY driver

 .../phy/microchip,lan966x-serdes.yaml         |  59 ++
 drivers/phy/microchip/Kconfig                 |   8 +
 drivers/phy/microchip/Makefile                |   1 +
 drivers/phy/microchip/lan966x_serdes.c        | 548 ++++++++++++++++++
 drivers/phy/microchip/lan966x_serdes_regs.h   | 209 +++++++
 include/dt-bindings/phy/phy-lan966x-serdes.h  |  14 +
 6 files changed, 839 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
 create mode 100644 drivers/phy/microchip/lan966x_serdes.c
 create mode 100644 drivers/phy/microchip/lan966x_serdes_regs.h
 create mode 100644 include/dt-bindings/phy/phy-lan966x-serdes.h

-- 
2.33.0

