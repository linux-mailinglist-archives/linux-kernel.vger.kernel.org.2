Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0947B4265DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhJHI2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:28:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:39435 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhJHI2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633681603; x=1665217603;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=jG3FaooEqU+OQN8jMyYxg2seRUzZov+lJuSmYgbfJRo=;
  b=ehlKPJagBflNtgd4lLsErwTJSrBOCuhzOZVZMx1ghdVSBi7V/f0XuNly
   f/UVJCJ1IT1vp76w7J/7q3SXDaXHyXhRcbuu7FiY7vwrTWq8rJXBlSCIr
   ibIphAqlV3KNW0NJkyXKxrDhQ51fs6SDQ2tYMk+8o00bFa0owjNNGPLl3
   j9mhqeDxzvc1ylxqbuCw+TdMTwbl3/S0ociwmeXHRdG9OfBFgo5dxB6ed
   wmM6fZlTHkiBmYg8L6LzC0ktI1+tkCHWe4+D0kpnIGS/2siGhZ943vQTn
   CW1h7L2sI6dUd9Oe1+AVTyQ4zNinaLEG8zs1zqIalTGdhtMiIH1diq7Tn
   w==;
IronPort-SDR: Z/i64MhOLghfmwNsVT0mTmhAjC/keoGvrMsIR68bAbG8gUHa/9QMUUrWq7jMCbuLbmiKF09VPk
 Gd+jkSwKDWhw0bGxwKADUbbSSzuVfkxRWRi3FPFJ+eT05sH8DSFzHFUt6ouKQuQz246UYxM1zw
 7LPaoISu17fd7StJvBTmur2JR2IJjhWwCb9IWaQxRJMo8Z8UOfMR2+pgecTO/KIAM0WcJy6y5P
 CXo+67FwXF7IBgsRVdUzGFCWLP9DWYMI/JmLe5frOaVlO5Zv/YwdX4LXrjDBn0cn1v1tkywMmo
 0bNzYfWaHE82l10U15mqVVFp
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="72132656"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Oct 2021 01:26:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 8 Oct 2021 01:26:41 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 8 Oct 2021 01:26:38 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v8 0/3] Add driver for lan966x Generic Clock Controller
Date:   Fri, 8 Oct 2021 13:56:32 +0530
Message-ID: <20211008082635.31774-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a device driver for Generic Clock Controller
of lan966x SoC.

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
 drivers/clk/clk-lan966x.c                     | 239 ++++++++++++++++++
 include/dt-bindings/clock/microchip,lan966x.h |  28 ++
 5 files changed, 332 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
 create mode 100644 drivers/clk/clk-lan966x.c
 create mode 100644 include/dt-bindings/clock/microchip,lan966x.h

-- 
2.17.1

