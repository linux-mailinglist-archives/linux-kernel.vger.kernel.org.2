Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E700C42F131
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbhJOMoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:44:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:50441 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbhJOMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634301604; x=1665837604;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=62ij9G57oyBa2LbZbUA2DQuKc+bkP7u3EcIzSJwqHlQ=;
  b=tbS/Qi3PwmHUbHWv+6Sj7yktfU2CHcd6YhoGJWyuarhXMSTqneh1nDKB
   rn0Wz63iw4i0uamLwcK46230ksbJa6YeW41VlELwchuCVQYqJ9Aj6DwLB
   Q9n2vqqpfWWS8nB9nCY5SXptYXORab7CO8jH/6JUEN7aJfM1TeEmvySBq
   JPZaTEnCanT33oXf9o+j3wFjxQe+4W4EgIRhVmqwqI+i7xABduhEZxLNo
   Ejjq2VhGx9kkvHzC+l08nU2QjAYnCoAyHWS/6v4P8kx2i6RmkGmHhCIGF
   596+wGalMiVQAKszLar0K2sxEyaokpJv07hNEkIXzSeHI8CEX5WnfoIEE
   A==;
IronPort-SDR: KacCpRsrocVRVtW9UKX13c3xumoF8k8BUQxUjsBKhfAwg9eRqM8yLX9U1niRytGHdwCu98UPuF
 7kFtE24C+NppyAVsdgDyNTfASYO8VJt/UU5i8Zk3bzvEV3WLE9aXLehIQTMKxm3iWbI0AsvFOC
 Z6HDjIzLbrtOM49DfV+q16qu+rVGrSVQbm+ZBjQqCa+GBgpKv9fbluCZUa2laZ6nE4BNztRyHK
 Jj/+TLTh9Sf1aUAP3bZzk3pU5GKPFwkef+gAPGuB5f9SX2FQQSNQUatcSrTGlGSKRCvNQpbBBZ
 izRQFnx3mdqozUfYXqoQ3uKO
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="73070425"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 05:39:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 05:39:59 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 15 Oct 2021 05:39:57 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <alexandre.belloni@bootlin.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v3 0/3] Add driver for lan966x Serdes driver
Date:   Fri, 15 Oct 2021 14:39:17 +0200
Message-ID: <20211015123920.176782-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serie adds support for Microchip lan966x serdes. The lan966x
device which contains this serdes has 8 interfaces, consisting of 2
copper transceivers, 3 Serdes and 2 RGMII interfaces and 2 of the
Serdes support QSGMII. The driver add the functionality of "muxing" the
interfaces to different switch ports.

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

 .../phy/microchip,lan966x-serdes.yaml         |  45 ++
 drivers/phy/microchip/Kconfig                 |   8 +
 drivers/phy/microchip/Makefile                |   1 +
 drivers/phy/microchip/lan966x_serdes.c        | 540 ++++++++++++++++++
 drivers/phy/microchip/lan966x_serdes_regs.h   | 482 ++++++++++++++++
 include/dt-bindings/phy/phy-lan966x-serdes.h  |  14 +
 6 files changed, 1090 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
 create mode 100644 drivers/phy/microchip/lan966x_serdes.c
 create mode 100644 drivers/phy/microchip/lan966x_serdes_regs.h
 create mode 100644 include/dt-bindings/phy/phy-lan966x-serdes.h

-- 
2.33.0

