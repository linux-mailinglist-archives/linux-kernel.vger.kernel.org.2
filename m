Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58001432FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhJSHoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:44:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3856 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhJSHoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634629312; x=1666165312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=HAWv49u1EvX/dBn6dQS2ayk6CAdQxekNMFMRdqPppaU=;
  b=jEoJLSay2NqSMWdmnP9BuS8Wz93Q129cFxoGZyK1Vg47emXt7GnBwA+m
   ucv0MwinWOJL8KK5+4ZFkg9zd6051CCeBCKizD6fOhLIRH0HrzQJSLM4l
   b4a2Kl5WD4/VKP9jUrrp5I2Jumd54ZDRiL0PKNrib9xyRBKC+OnsE5s8y
   IklRVQxQpuoOAQ2HWeh+LNna8LFgtZBjfOaeyaT55vCVVHEcypm8cjwV4
   zP0WRzth6wQahHHK5nTPW5BsU8T8QF0djkI+lZnUZL5EAJ+mD1t5hyjYt
   WJeCRwOUY/JFRgRPH8kyfi7F+vVZdKfVzMv2RHGsquLXQtUd5jX+u4cNC
   w==;
IronPort-SDR: QppKUU67MthQYSitfQDWOwTVEBRGFYILjN1XQtSBpaO8To0W8jQwNtCszNq2NpqL04x153YCer
 3+de7wcg4rqZ1FdgRcarCcYnMM44fvIAday4QrWYbjehnOHFUEgm2t7MBtJjMU49CdoIp2C7wk
 8dRWUjKyfiC4w9Eq0GMqUDgFOWreIlMsCJSL9+9n8ZPHYwD7f6sNFQ8td32bLquZx0tPi9Pjbi
 +dvOW/B2GBtuIPm/m2ul5kEt6aFXaXGIPrBiej/CUYe+NKN7+Py3rSoxCuWt41lQ8ABU7+M7sb
 J/WA++lN9KxvqyZQqa/eq/m+
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="148666100"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2021 00:41:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 00:41:52 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 19 Oct 2021 00:41:48 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Eugen.Hristev@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Manohar.Puri@microchip.com>
Subject: [PATCH v9 1/3] dt-bindings: clock: lan966x: Add binding includes for lan966x SoC clock IDs
Date:   Tue, 19 Oct 2021 13:10:28 +0530
Message-ID: <20211019074030.31294-2-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019074030.31294-1-kavyasree.kotagiri@microchip.com>
References: <20211019074030.31294-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LAN966X supports 14 clock outputs for its peripherals.
This include file is introduced to use identifiers for clocks.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
v8 -> v9:
- Added Acked-by: Nicolas Ferre.

v7 -> v8:
- No changes.

v6 -> v7:
- No changes.

v5 -> v6:
- Added Acked-by.

v4 -> v5:
- No changes.

v3 -> v4:
- No changes.

v2 -> v3:
- No changes.

v1 -> v2:
- Updated license.

 include/dt-bindings/clock/microchip,lan966x.h | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 include/dt-bindings/clock/microchip,lan966x.h

diff --git a/include/dt-bindings/clock/microchip,lan966x.h b/include/dt-bindings/clock/microchip,lan966x.h
new file mode 100644
index 000000000000..fe36ed6d8b5f
--- /dev/null
+++ b/include/dt-bindings/clock/microchip,lan966x.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021 Microchip Inc.
+ *
+ * Author: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_LAN966X_H
+#define _DT_BINDINGS_CLK_LAN966X_H
+
+#define GCK_ID_QSPI0		0
+#define GCK_ID_QSPI1		1
+#define GCK_ID_QSPI2		2
+#define GCK_ID_SDMMC0		3
+#define GCK_ID_PI		4
+#define GCK_ID_MCAN0		5
+#define GCK_ID_MCAN1		6
+#define GCK_ID_FLEXCOM0		7
+#define GCK_ID_FLEXCOM1		8
+#define GCK_ID_FLEXCOM2		9
+#define GCK_ID_FLEXCOM3		10
+#define GCK_ID_FLEXCOM4		11
+#define GCK_ID_TIMER		12
+#define GCK_ID_USB_REFCLK	13
+
+#define N_CLOCKS		14
+
+#endif
-- 
2.17.1

