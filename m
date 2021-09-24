Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7977417881
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245754AbhIXQaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:30:03 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:56515 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244892AbhIXQaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632500909; x=1664036909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IJkLJsJGwbgzv0QK4qWxc6FaUK3E3ErcvZ2DRfDDe+I=;
  b=H4MXTf8A9HSagfqTYp9BsvP4b9/sOYpExd47v3x4zwHhHwq9NMSkIco2
   qwSHpVX9bUIfs4xpQBtLteLie0pai0S80wIRH0u3Ed5u/g7IuDSj4cE8k
   GvP4e4ZBl42hu5oNbccwW9H9RjSwX8ZDJKEZSBEOZQFQlXxa1VN/2qhrt
   6D0dKQbNSF6nnG3kfqbyELwWivWa1WpqSfvlbSydTLlcovrmdVydgsNCj
   tC5+Ur77CYs6C7SgbuaRm/Gmb5TadwPAT1pzf6yjmW6kPdWCT0MYoCXok
   ylKwQ+BmrB24ZUxhy57iZgrxA4lcKaE9sze/N+vYkSCA682yrQd9MPUo2
   Q==;
IronPort-SDR: HE+vvrvtj6qHpqypN+sPHxM9P3Cp2aDDAfEnhPJg+DGjv6OFSk+je/t9I7nwmhFydftAtZstTN
 Dv8Ii0im64DPGEHYeMuGbk6RBXkSA/sqRUwOiA8NB0yiePdvQtMt/YQp2C1cfMSwPvoJpf6OxK
 1YGsecW2QRBVWhyxdvMUmZZ4joFOldwnl9gEXVyLsm6ixbHnPvxpblK781BKuIjoKm4y3JVqjx
 kPfAznqIAYxrLOk2O/+ctreVO3LibAx9AmAkz7BOZeLTMP+HXDiBnlEeC6Cu90cAMpQN+3PPhg
 93JjqfMvSdt+Sj88ElyKGy4h
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="133102006"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2021 09:28:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 09:28:27 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 09:28:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 0/2] irqchip/mchp-eic: add driver for Microchip EIC
Date:   Fri, 24 Sep 2021 19:28:15 +0300
Message-ID: <20210924162817.2135056-1-claudiu.beznea@microchip.com>
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

Changes in v3:
- use irq_domain_translate_twocell() instead of mchp_eic_domain_translate()
  from v2
- use IRQCHIP_PLATFORM_DRIVER_BEGIN(), IRQCHIP_MATCH(),
  IRQCHIP_PLATFORM_DRIVER_END() instead of builtin_platform_driver()
- register suspend/resume functins via syscore_ops; along with this
  driver private data structure (of type struct mchp_eic has been declared
  as static: struct mchp_eic *eic;)
- collected tags

Changes in v2:
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

