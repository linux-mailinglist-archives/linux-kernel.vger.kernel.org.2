Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80F8406712
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 08:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhIJGKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 02:10:19 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:9475 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhIJGKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 02:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631254148; x=1662790148;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rMISBhDoirXhSZzIMJvsSzelGB83Eh0UtdpXSnUSB5k=;
  b=loJqPfLTs09B5EeOAE+SKIeNflburkQyxwLcUxdyLLSQq5J9sNkcMt7p
   /o59FIqbYawHvv5NJJReqUzBYVHdWAcd+MTqMHZjv4ZZ+dqQ5v6dQbDEG
   iG1fc9EOTLpeFoUr3n3WzvJBvk/mnFgbFRodt9+enXUk8byHawSmV/NQ+
   7bC09PhR2gnD4Jry1gAemAlucLKf0KtWs1aVxTJn4Vt0mKP87foOqS/c7
   OtAANyYAHS9a5Ydgmil0jA1WWz0FTsV+j7JDGdD8W9rGk3oCTqWJqSt+l
   GbeA8a3v84xQ2vJ0BRPd4ihSqgG0YUS9Ho4hu2Cun3/PmrhQtO5bVyFaL
   w==;
IronPort-SDR: hJX4tHPpMy6RHIXo7Q7AzwVwbNShvcROajRz4d4BPnP91LAa0VQH+iFK/NXkLUAnS+smOHbM+M
 CM0d1OUrKlPowCrzrDUZCH7q1wc/jHQ6OXT+Ajsdwk5xBN60IgT6xqskRPyqci1j5uRHVHllCz
 X4uNEHUA9dNiGd4aj2KiTGd95Agk9qg0VHiA+Ppiokb7rGvjeEwvcrwfcgwEJSBW+Wr1UfjRpX
 LL6LT19T0hPUCfxNO+k6eXE/bpKk41W0/67UQgMJVNCRFR1nL6wNXB89jirI8BdhOeHWvhUJFK
 2WQKlJ0GkuWpYRAImV23z05J
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="68849088"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2021 23:09:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 9 Sep 2021 23:09:07 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 9 Sep 2021 23:09:03 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 0/2] irqchip/mchp-eic: add driver for Microchip EIC
Date:   Fri, 10 Sep 2021 09:06:54 +0300
Message-ID: <20210910060656.1061234-1-claudiu.beznea@microchip.com>
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

