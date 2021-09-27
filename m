Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22ED5418F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 08:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhI0GjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 02:39:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:11814 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhI0GjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 02:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632724661; x=1664260661;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9zp3CVezY7kqKbQ0dlcpLUAzQumJ6y0zLma5cS1ayNU=;
  b=bXzUF/a7G9sXpo7clF7HDPowOpnYrxdHg+Ob9d8VK8Be4bVSoWcChmxL
   wEY+YBKr6hxMlL2WgingzVlgkEj5S8UHw9jUHISrbUJhg6ONAFLabdbh6
   P/BLYisbZu1VTQkY4ARB00DqbSntc6t1ZXe5ZsYlil8aHxFPji1FRFzub
   c8Ti7rF/1bh/PeeAaTm4pzx3pTQQCeQbZsnQeRFb7RDkuhlI18Mf0OqMf
   XYlSTZAKBl9yyBCVX3Lvu9jXFbFymb6Qjy6nc6oB7CLbYRkwsO2oFGjCW
   Ri6dFlWUZSp6luoNoCOMIz3xP75aUkd4uTGB/6oJVa+/uQNEm9ODdpnb8
   Q==;
IronPort-SDR: fMJIPbj9qIRhaaUc1LwcmSIOXCISAciDCQIvYi1oZ7xhVOFFTTCa0wjI3IGJp4J6fXENQts5fp
 9KUqrzoI8W805P5LCk5ePhC/SbgwMs5lTfvHmHdHfPsZL6v+y2lPMME5n1yawe0IuxdBQkdACc
 uOvQVRLEhMnR47S2N0XnwKM3SYFDldGBS+uYdbL1uBjrcr8NtKihII/7nqO901prSePLuFBfXM
 5Po1Ix+Raoqn0h2kxVGsyA9Of2F5gF9XtxSpajPgCqjzkvkhT2OsrviozPsfcXF5hCa9Vlh66w
 rAVCr1JwMWruA4PppcLlRsv0
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="130749939"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Sep 2021 23:37:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 26 Sep 2021 23:37:39 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 26 Sep 2021 23:37:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 0/2] irqchip/mchp-eic: add driver for Microchip EIC
Date:   Mon, 27 Sep 2021 09:36:55 +0300
Message-ID: <20210927063657.2157676-1-claudiu.beznea@microchip.com>
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

Changes in v5:
- solved the issue with dt bindings (accidentally picked file from
  v2 in previous version)

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

