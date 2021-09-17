Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDD340F760
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhIQMXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:23:45 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:58765 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243284AbhIQMXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631881342; x=1663417342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xSKrC88R5/jeN/2FQuG3GYWUYfzwKjTcGRbrTAAnq5w=;
  b=X8d3jr4dFSsHkXwpNLr3506qJMkBmBAScWCn8U4CkkKa1BP5dYZpAbg2
   bU+VwVkeiVuBz4mptsaFwskKn9MUDzIrhhGVaUEPQnEIFDn9nDRGn1ZC/
   NfuRd7d+dLr2y8DWHgAEH8RAYTqWAxAC98SM3bPW3jII8D3pWoLndkYQt
   ubRptjuKd2AituiA0wijIAi7QlDV3jcPQ6eIbJ5LeUt+IVD+2d1VOvHhu
   MzLUS21j4SOnUdfJWNCwX5g0rkZZw1ATic6AxhHGS5cCPBPp7QbMQVI2Z
   AsaQnzXIAdag0luOoQesd5Us+klMuxR4pGddGXDop/eYIBA4BTFgqO6Wv
   g==;
IronPort-SDR: ZPlJ7YluEH/6tBnlge9BEzoLmohweGB4iY/8UpBHQSv01muRoKPOVWI2TYu6wsNIy7oYSl3v74
 l2zY2zcA4N98FYhPZKkk2VWEW7JUKOzwROlpm1jCEmOBP9dRVvLEWX/GWpcvXFShBEyOW3TXPA
 Hvo2xZYCV+o0sPqQ88O0xYHgm6kjmafVt22wmLPnCTLtIuX7yYuoc0hh/nxvENIW8hFGaUBCKe
 K5PeB5ZBLDh5EtYZFQbYE5Vi6TUxHnQTSP9nfk7FdsM+AqMJmPvVEi8mW1ghY/a2PA6qtX5pTd
 RLP9LheosmgSeTlK7ewLVJTk
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="132202608"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:22:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:22:21 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:22:17 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: clock: lan966x: Add binding includes for lan966x SoC clock IDs
Date:   Fri, 17 Sep 2021 17:51:55 +0530
Message-ID: <20210917122157.557-2-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210917122157.557-1-kavyasree.kotagiri@microchip.com>
References: <20210917122157.557-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LAN966X supports 14 clock outputs for its peripherals.
This include file is introduced to use identifiers for clocks.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
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

