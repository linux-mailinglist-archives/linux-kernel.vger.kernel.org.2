Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52858443D02
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 07:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhKCGWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 02:22:25 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:25055 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKCGWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 02:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635920389; x=1667456389;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=8fiWC0I4AZJ0qKLZ/VUeYHpd1iutzUlsq7NnPUZ565g=;
  b=aKuSVTLYp/WiAYGrm5kqoR+a93Ru95s4ydDelpgn9EzqH/Vh6VSrrac7
   1JL61TCTWd7hpSQC9huT2NFaUL86L033Lk9WqBDXiroGqIoEE757uFHTF
   Zkizr/EMWPl1cO2gyBKr5mQcBaAkg3jX6trJ4SROpH0I0lxKwxTs/nK/l
   lf/XH3la+TXGsLP84w+g+H50vPKBp7AiRPIX/k2Hdvr8XjVL7Kn5xUMw1
   CKR3BAPnzAiRzoI5xBk9tk4w+PCLfiXKj/UXgAvWID7D3o58b6QWLwRS4
   bKGUsAV36xiw3g5vS9MwA8xSZyxrLgumEdtcSg6/Yw9wkh6qAJ8mX23Ts
   A==;
IronPort-SDR: 9rh9MjtsLzATcT3WLFkK9oTVBk63M9NnhvodoPUSHs2bH1vRJ0xuwK6fWbD8mYy3pUhh6SlGNs
 AbFG6g6f75nmTaDp/d/P2CkoLRh9/efK6/iM+/CVu4RzyvPNfsEq9d96p553VwluQ/W6aRBRmo
 lUSEMW21vZ3rZWisrpezStUXbWjVVyk2wc8qdXXSYZHtWw6JLOlbHRR5f1Kw9f+WuQ6+4USiQd
 82b5So2IQYS65BmgX2Pggt9PLMcZOHPvaUYB+FLrCQ+VK3RvGMqcSDbCfJoHWCXyBHkKuQ1J7P
 9YOlcv/6YpVhV7wd0ZyBdVtH
X-IronPort-AV: E=Sophos;i="5.87,204,1631602800"; 
   d="scan'208";a="142028626"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2021 23:19:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 2 Nov 2021 23:19:45 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 2 Nov 2021 23:19:42 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <nicolas.ferre@microchip.com>, <Eugen.Hristev@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Manohar.Puri@microchip.com>
Subject: [PATCH v10 0/3] Add driver for lan966x Generic Clock Controller
Date:   Wed, 3 Nov 2021 11:49:32 +0530
Message-ID: <20211103061935.25677-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a device driver for Generic Clock Controller
of lan966x SoC.

v9 -> v10:
- Removed .name from lan966x_gck_pdata struct.
- Removed "_clk" in fw_names like used in bindings  

v8 -> v9:
- Added Acked-by to dt-bindings and Documentation file.
- Changed clk_name "timer" to "timer1"
- Updated devm_kzalloc in probe function.

v7 -> v8:
- Defined new constant DIV_MAX.
- Corrected and updated prescaler divider condition check.
- Added Acked-by.

v6 -> v7:
- Added Kconfig and Makefile entires for lan966x clock driver.

v5 -> v6:
- Added Acked-by to dt-bindings file.
- Removed "_clk" in clock-names.
- Added Reviewed-by to Documentation file.

v4 -> v5:
- In v4 dt-bindings, missed adding "clock-names" in required
  properties and example. So, added them.
- Returning proper error - PTR_ERR.
- Removed unused variable "ret" in probe function.

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

 .../bindings/clock/microchip,lan966x-gck.yaml |  57 +++++
 drivers/clk/Kconfig                           |   7 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-lan966x.c                     | 240 ++++++++++++++++++
 include/dt-bindings/clock/microchip,lan966x.h |  28 ++
 5 files changed, 333 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
 create mode 100644 drivers/clk/clk-lan966x.c
 create mode 100644 include/dt-bindings/clock/microchip,lan966x.h

-- 
2.17.1

