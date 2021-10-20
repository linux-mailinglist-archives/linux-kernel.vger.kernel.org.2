Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A53434816
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhJTJpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:45:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:58344 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634723003; x=1666259003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z47sps6aiduYq9zxghfDWy+i1+XjGukGY3TIg6+nO8E=;
  b=BGExX2/j/d1JO9sYylnG9uLsnsh11A0gdY0Hf2iLdMpp2OWujV5Bx/qA
   cy1kOAF6q7XDgrHdQ8OLndpU8by1EpchM5akDm6cfYwwbnbUsocL5gxcG
   H70V7ffWf6U1kIF/eCu3+hKC0UOR5o+RIZQCe2nrf1Y0iejJgcNEFsIUG
   zOqmdfOoA77J12uePzXjEQZcpWb/nGZ8vZ3k2OEKhQ2pOmdt7UH/P4vQQ
   8YlUF2O4MJm/Uc5eYrpO4lMeETB55IIoijU8nYOwqL4TlNpNCocljIGjS
   XsnPgntwS99a6JBom4y/8//hfonqBaWVCzCW3YiFZoM/ZljhSEBt5d48n
   A==;
IronPort-SDR: QQSo92EB/7JhmETOogVnU7TUkxzNwqKjrgWO9W8yEum2fMjDr8XJkMf8D1coAjiztkfJckzHRl
 oybA6kAVxn3gklJySDUT0OCpoSlLpzM72xSx9m63XYUqRm7cXZraEpugaamhoxq9e6wH2cIv8z
 Jre7MHFWlhF5HAfbGbxoKRthDNJ4gsLbSm/lKhKODWqYaUPKnY2y6dnHFxKRqyoVudqykCADpn
 vwIljsjfH3GLLhYVyAJ/ks843zblzbbyl2rEmChIvPgsY2vs31NmejolQa8v2nnHBZihqW/US2
 0URVBz8bOXvhtPgkUXTlAV4U
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="133739400"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Oct 2021 02:43:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Oct 2021 02:43:22 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Oct 2021 02:43:20 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <alexandre.belloni@bootlin.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v4 0/3] phy: Add driver for lan966x Serdes driver
Date:   Wed, 20 Oct 2021 11:42:26 +0200
Message-ID: <20211020094229.1760793-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serie adds support for Microchip lan966x serdes. The lan966x
device contains has 7 interfaces, consisting of 2 copper transceivers,
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

