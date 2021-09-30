Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40ACF41D49E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 09:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348790AbhI3HlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 03:41:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:63631 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348782AbhI3HlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 03:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632987575; x=1664523575;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OZhx3Wc97/jetcqXzisC549SCP5efiZyVPD52r34XrI=;
  b=zJ2xS/3WFJXE+0n68kcJODtmEnZ2++biy+FWq3emwLK4f8ueOQvPOgYb
   XxxaNgddAnOKw8tVM5r9ijKvJKzujbD9C2fXDyf0vYvQKXH2YaO57NQZu
   Iv0k39qTtg1q8B5TUx1tsT2TEpF0wsGknqOYbzlVqvRai5zap1g8BPr9H
   d5J0+n/yMNBSnK/klEz89VoJ6twK4QDA3wLkgZPw5252AfCK19q82XwaU
   VIHeE5eKzm/froVBYrhC9xN/NmRNolXJNL9QI6o3IM5nb0J/CsYPXujp2
   3Mp05V5Ev+ObCVsJHht+Cx7FLGH2p2zdvTFAXxJjLx1r9vG1DZdb+ojFN
   A==;
IronPort-SDR: +fcuMBAvv22U2Unajd/xbQgKD7Q+DIjHC6Nxm7BPKU+YyBpmOfH49uUTDWhry+mXnEZ5HyZJfW
 BBQD/D8yOkIstToHT/F4JzV3pbyF0J71eeCqUuJ/OdUque82mWChqm8Rq24hDAjhDYd45UvKI4
 tyAT/79e1x6Lo2WWLPrsqOgKrqQUOuQKFftud6dIerLA/rGYpGmy242R2eHE5RwSfoQwqs8aB+
 kU6Ql3eOgHcIu9pltg5xPcSPr+375TYsvwYEnafU7kI+jJreCNBDZkHRXsIogBcq+n1voivYh2
 WrJ+GxzoOwGLsocMNuuZSBFp
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="133752522"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2021 00:39:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 00:39:33 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 30 Sep 2021 00:39:31 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>,
        <alexandre.belloni@bootlin.com>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 0/3] Add driver for lan966x Serdes driver
Date:   Thu, 30 Sep 2021 09:38:19 +0200
Message-ID: <20210930073822.2709955-1-horatiu.vultur@microchip.com>
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

Horatiu Vultur (3):
  dt-bindings: phy: Add lan966x-serdes binding
  dt-bindings: phy: Add binding includes for lan966x serdes
  phy: Add lan966x ethernet serdes PHY driver

 .../phy/microchip,lan966x-serdes.yaml         |  45 ++
 drivers/phy/microchip/Kconfig                 |   8 +
 drivers/phy/microchip/Makefile                |   1 +
 drivers/phy/microchip/lan966x_serdes.c        | 545 ++++++++++++++++++
 drivers/phy/microchip/lan966x_serdes_regs.h   | 482 ++++++++++++++++
 include/dt-bindings/phy/lan966x_serdes.h      |  14 +
 6 files changed, 1095 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
 create mode 100644 drivers/phy/microchip/lan966x_serdes.c
 create mode 100644 drivers/phy/microchip/lan966x_serdes_regs.h
 create mode 100644 include/dt-bindings/phy/lan966x_serdes.h

-- 
2.33.0

