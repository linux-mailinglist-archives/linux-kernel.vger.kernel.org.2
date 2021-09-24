Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB694178D7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343987AbhIXQhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:37:33 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:26552 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344295AbhIXQgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632501306; x=1664037306;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LMgf4huk+uZ7p/xYH0ORNXOreLVJ/6aIi8d/i7Q7o/0=;
  b=BE4xuZbaLbj1alje02njNafg4ga6+svYKxKWNOieG4xXQPCAKtr5c0D7
   DQbq4olhEHc5JT6sPpjN0TSdYtHETx6l7hhF+pO2okbeFGU+fL1/R8fos
   6BFt9/l9h+dhB4F+WUdPkg1cvG9Y55e8BFlKixzntkbAEB3jiypbF9APV
   bn0OgjvS363MS8S+Xc+Te5y17xHfnjlD1bPxWX01GYqRfa3ImjwaLdqKh
   pN8rRsVuduwRc8ITBDsiUEru+o2h1rGMmTNAlrYm93XczIShjQ+b0ANQY
   xgIhcJejynPpBQhONAV4Hy96VOeVrQpMdG7LaDUK5yEDYZ86LwJY9nSIA
   g==;
IronPort-SDR: YPYuc3OhpUciHfj1RFDLqG1OY4eU9XYCvRwSH59Vm+oTwEvlC01Y4bviYRrbpzmWyuuJ5rJ3Ed
 K0I/WrzOP5UvcQ45PRXu7PAXpAXJNjCNh6HcOVtWmavZWffwM87jw3PrTMvbCqNXHt9xO3J1D+
 9G4C1sGKghi1omo+AtB384hsrw3ojqk6ojjT0TpL1zGyETsH16GUJpBsanPt2V+wv2uWySVtDl
 XhXPCete7PhR0EGM2o9KQB6R+Jc9szANggtAaoAZuicjLCmneptkR3qrSlbofF17rYYopmDoQd
 dVq9mm1xCVpSdJlOcArht6Fn
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="133103136"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2021 09:35:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 09:35:04 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 09:35:03 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 0/2] irqchip/mchp-eic: add driver for Microchip EIC
Date:   Fri, 24 Sep 2021 19:34:56 +0300
Message-ID: <20210924163458.2135247-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for Microchip External Interrupt Controller
present on SAMA7G5. The controller supports for 2 external interrupt
lines and is connected to GIC as follows:

pinX   +------+ EXT_IRQ0 +------+ int 153 (for pinX) +------+
------>|      |--------->|      |------------------->|      |
pinY   | PIO  | EXT_IRQ1 | EIC  | int 154 (for pinY) | GIC  |
------>|      |--------->|      |------------------->|      |
       +------+          +------+                    +------+

where PIO is the pin controller.

Thank you,
Claudiu Beznea

Changes in v4:
- use irq_domain_translate_twocell() instead of mchp_eic_domain_translate()
  from v2
- use IRQCHIP_PLATFORM_DRIVER_BEGIN(), IRQCHIP_MATCH(),
  IRQCHIP_PLATFORM_DRIVER_END() instead of builtin_platform_driver()
- register suspend/resume functins via syscore_ops; along with this
  driver private data structure (of type struct mchp_eic has been declared
  as static: struct mchp_eic *eic;)
- collected tags

Changes in v3:
- fix compilation warning on bindings

Changes in v2:
- s/mchp/microchip in bindings
- get rid of glitch filter settings
- use s/eic@/interrupt-controller@ in bindings
- removed '' around interrupts in bindings as proposed by Rob
- removed glitch filter settings
- switched to hierarchical irqchip driver
- addressed review comments
- use builtin_platform_driver instead of module_platform_driver

Claudiu Beznea (2):
  dt-bindings: microchip,eic: add bindings
  irqchip/mchp-eic: add support

 .../interrupt-controller/microchip,eic.yaml   |  73 +++++
 MAINTAINERS                                   |   6 +
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-mchp-eic.c                | 280 ++++++++++++++++++
 5 files changed, 368 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml
 create mode 100644 drivers/irqchip/irq-mchp-eic.c

-- 
2.25.1

