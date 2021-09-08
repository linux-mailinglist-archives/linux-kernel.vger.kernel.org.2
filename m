Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F723403609
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348145AbhIHIZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:25:41 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:56615 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240561AbhIHIZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631089473; x=1662625473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e7vycfPqyxmFecum49yy1fjoHbrRq7/OdSzGptDeoXI=;
  b=q9tTi4w5vIBfu1aRys7dGkNSCch3UWHRaPqyJ1nakAgQ6tjJF6p9oSx1
   V+7fCSmof9bRDikXT4GWxiHR09fIsU2DEIdGfaACubOZepihB0msT99GL
   dBIy2yZf5zC24Chnbw0kMx7IyaNZZnzv32XB3qln8SK+aScEofK/RBeb+
   A16vztSAFIPg+PZT+tQr/ceBfgeENvRZ5Lehn7ltT3KgvOYxcZooetx9t
   0oTgEyRwGsof9Rf1hA0XjVK5h9SkJyUFODuRApM3vLz24uBvbPnxKetR2
   xygVikbEzAd+dJsfQQzCKKWtTjqXyJ3Q8pkBdhd6L84iHDRtoHZmwV87O
   A==;
IronPort-SDR: DqRTXpuzHhb4ivRgZoMJ/vMzFkL47tnvVt0LjqGmvA6jgQt+cDIIkPpGyC6zF4hVOh+OnMPQ9y
 Ch9I+YaE5TXYS/FQVET3M/bwSbrtHhxdaTFBt/GSeEBS8gC2Oea+fQ1KGk+5ZPbEgj53LYsYMi
 5CVrDxjjPz9fewUXstLU2xO/eXz0hPRdZz42afxGrjyxXiLm7u92xlFee0fuvPormE9B4674PH
 tWPLmwusw1SdiWsjCSkvYPnFoOT7lBh9exIIEtV0pAP4RFp4T+0fYTl9TKzk0/fEgfolf149pB
 RRiuBmCfC5fkNsgub31COTBK
X-IronPort-AV: E=Sophos;i="5.85,277,1624345200"; 
   d="scan'208";a="143286276"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2021 01:24:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 8 Sep 2021 01:24:28 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 8 Sep 2021 01:24:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/2] irqchip/mchp-eic: add driver for Microchip EIC
Date:   Wed, 8 Sep 2021 11:23:48 +0300
Message-ID: <20210908082350.106948-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds support for Microchip External Interrupt Controller
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

 .../interrupt-controller/microchip,eic.yaml   |  73 ++++
 MAINTAINERS                                   |   6 +
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-mchp-eic.c                | 314 ++++++++++++++++++
 5 files changed, 402 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml
 create mode 100644 drivers/irqchip/irq-mchp-eic.c

-- 
2.25.1

