Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C14423814
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 08:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbhJFGhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 02:37:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:10516 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbhJFGhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633502145; x=1665038145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ufDEsuY52pxxa0DVkU1pnc1ICkQqdqlQymHht+6zrl8=;
  b=UE/uBc0g26+oFp4awjJuEqfj0XdxV5xqGMX5OdR9p6cfnI/5+ddJvCo3
   FwsboDsqHd7RtqM6+Qf9InEqeQo4sMDKLZG8YklVQicQkbIvFH52LWz7r
   EMcuy2kC8H87ezFtPkwNyRdzRdV/WOaf0xc5p1Jnk6BilcT4X/+KY3zwO
   gr/TYVJqyic07p+z2uOHpOq4YVk4xjRn2Wm2DtSeAeDF+HQiaTe2bzSqa
   iTqnFFKGvKtoJz/Bo1Y8ST1aIfaT30iVKhsb9Lkw9ddb1LJ/FEJzGu3WD
   8WThdw5gvfhl+2lKA80WcAZH1cYCiGVv01H6LcbP4+rOYjkeSOzqwnHZ5
   g==;
IronPort-SDR: YlY5HRoamUd/2cDhVE2+uPS5OeBqRrOP7pSr97Bm/C0czOttFK2vHE69F+LKG2lrLUepcXI/DU
 Ouuf7cCdERF2LxCqGzuaucNafVsiK65OPZW2jrzMqegKrnfZo3nPamXyIQNCW1sE9MGRfbqmse
 6p725H6HaNMkYh+8tSdtIFEPYSgfEhJWoWsJpqWTYYy/kxVhEVdFOUSUnYA3dw+kQUv6351KRx
 PCdpJRa19Fsn09001RmrDyUw8Or0qG96bokGo750ecllKPz+XR1pALjX2VpfgddO2IMtGWDoFx
 vlPSa2J52D1GWJPsdLiDVdND
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="134419733"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Oct 2021 23:35:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 5 Oct 2021 23:35:30 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 5 Oct 2021 23:35:28 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <andrew@lunn.ch>,
        <alexandre.belloni@bootlin.com>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2 0/3] Add driver for lan966x Serdes driver
Date:   Wed, 6 Oct 2021 08:35:20 +0200
Message-ID: <20211006063523.3962427-1-horatiu.vultur@microchip.com>
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
Serdes support QSGMII.

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

v1 -> v2:
- replace the regmap with iomem
- update DT bindings


Horatiu Vultur (3):
  dt-bindings: phy: Add lan966x-serdes binding
  dt-bindings: phy: Add binding includes for lan966x serdes
  phy: Add lan966x ethernet serdes PHY driver

 .../phy/microchip,lan966x-serdes.yaml         |  43 ++
 drivers/phy/microchip/Kconfig                 |   8 +
 drivers/phy/microchip/Makefile                |   1 +
 drivers/phy/microchip/lan966x_serdes.c        | 542 ++++++++++++++++++
 drivers/phy/microchip/lan966x_serdes_regs.h   | 482 ++++++++++++++++
 include/dt-bindings/phy/lan966x_serdes.h      |  14 +
 6 files changed, 1090 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
 create mode 100644 drivers/phy/microchip/lan966x_serdes.c
 create mode 100644 drivers/phy/microchip/lan966x_serdes_regs.h
 create mode 100644 include/dt-bindings/phy/lan966x_serdes.h

-- 
2.33.0

