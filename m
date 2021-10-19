Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507AD432FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbhJSHnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:43:17 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:51898 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhJSHnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634629263; x=1666165263;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=2HOvg2qsdxuV/aAMySQ27g5Qv1GroU8zPXQsC82Zf70=;
  b=PDeWI+M+f/czg4aW8OdVKflxwvfeajzhW2Rt/nHQQxR1IdGGPjoMX2nG
   YLYd2MTBN6OtWXCLTTtbIa7OGiXCPMOFp3ZIuFgrG9PjDdBqGPSrMzeY0
   luVYSdwf+fApnOy25puzXVUA5WTR4IVcA0QSku48vliiU5BbCoIzCX2Mj
   8YJDXmGwFERJRTugH1fvbVWZVEWo9D4f+mPsr5/o1y36qVmfmc1MAj4tt
   HRR9tEfTYjM1LPMOfF14n2h5GqGmu/4tq/qLrbXC/dPcEkeAVT8kxC7g/
   pVCBkevbaamB+ePHzOxsAsCUd9tzOEeXXlO5eGk6VCLad01BiAED1o26s
   w==;
IronPort-SDR: gvNC6S43renk75poALb494E8craSye92XrZDuXltkVaBs4RDu04WUb9uo3TmmTJW8hwMESs+0o
 9rMjTuL3KqFJyTMEe72i8DfJ/KKF9m0UFUjhmGS/6Msg4szhpB5TU/0X0H+mwQmQXJnXUko4vP
 9W4EO02GBpfosE/8Tw604TvDaK7EQchroWNp9x8TGXPnFY8+mEdgkGC8dw6BX3JJTHeH6LIldZ
 kaxAJFXdJh5q2a+u4tfuyI6tE1wzjcfurAN7rnBk9PEOTF0qCQJvdsCFFeMovF3YpFNIdn1N/q
 Sapa4HtSeVTgbyUrvP6jo5LE
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="133549844"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2021 00:41:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 00:41:03 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 19 Oct 2021 00:40:59 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Eugen.Hristev@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Manohar.Puri@microchip.com>
Subject: [PATCH v9 0/3] Add driver for lan966x Generic Clock Controller
Date:   Tue, 19 Oct 2021 13:10:27 +0530
Message-ID: <20211019074030.31294-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a device driver for Generic Clock Controller
of lan966x SoC.

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

