Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCE640F75D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242722AbhIQMXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:23:31 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:19736 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhIQMX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631881329; x=1663417329;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=GWB/xdnBZzsHUC5CSKcfcAdQsAkDVbqWbEvpd05XYFI=;
  b=f9VW+/wpDWD/RUb4UB2vduiDb2LE9RU21macWXn17UqXj7qGEE1P5XSX
   DnuN3+OEqvbktD7HFhJIxyJ/UZb+jhYv+c1+gdOgcjv175Ells7Ls5rhC
   BOD5nEz8ztYRGL+lRTINNbrclm9yuuXIl+kVICyenmJ6uezOBL3FImzqs
   pxqnLGyFYjhNcFCSQD+D6aA+N7+oCvvFPSL1BDWcCNLZ2xaQqY8HNM7gt
   1cMrpm9/BY38LPDhHG8jxiu61l6O2wE/jal5KIlXLkEXnrYs12xUWA6t2
   fVKQxB9zkYnhN4axwSVM38nbrlEF64j76XC1kCg4E1UHRnCieaUeCiaTK
   w==;
IronPort-SDR: 5FqMTClSsSWiD7YZT45/QI9xBuP0KMwj0jJUZaCdr3TFacA2nFtzOjDb9woUnJhUkXost/5qM4
 nrY/CVAq1WrVB1EHIR7v/DndUNvm1hCWvYKVjR4TrI9Yne38zPBeihbcPBZJPiAl9XhpnaXFCr
 QgrtuApLaIfAunrXTlh136tgL74U7uuebl9kcLZopOZE6LgIfv4MUyA9WCfLsjC0rm3mug/JKJ
 9wSK+tlICLFcaGA9R8LruqjkbQJ2tK2tWVmkvomyKZEbeGkLcjxTLhlJzGD3s7uNP29Ouh4Ezo
 Wu0yF1xjSE6F85ZhX1omy5r/
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="136357926"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:22:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:22:07 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:22:03 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v4 0/3] Add driver for lan966x Generic Clock Controller
Date:   Fri, 17 Sep 2021 17:51:54 +0530
Message-ID: <20210917122157.557-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a device driver for Generic Clock Controller
of lan966x SoC.

v3 -> v4:
- Updated "clocks" and added "clock-names" in dt-bindings.
- Used clk_parent_data instead of of_clk_get_parent_name().

v2 -> v3:
- Fixed dt_binding_check errors.

v1 -> v2:
- Updated license in dt-bindings.
- Updated example provided for clock controller node.

Kavyasree Kotagiri (3):
  dt-bindings: clock: lan966x: Add binding includes for lan966x SoC
    clock IDs
  dt-bindings: clock: lan966x: Add LAN966X Clock Controller
  clk: lan966x: Add lan966x SoC clock driver

 .../bindings/clock/microchip,lan966x-gck.yaml |  55 ++++
 drivers/clk/clk-lan966x.c                     | 236 ++++++++++++++++++
 include/dt-bindings/clock/microchip,lan966x.h |  28 +++
 3 files changed, 319 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
 create mode 100644 drivers/clk/clk-lan966x.c
 create mode 100644 include/dt-bindings/clock/microchip,lan966x.h

-- 
2.17.1

