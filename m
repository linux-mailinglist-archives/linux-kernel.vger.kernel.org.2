Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3052C4265E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJHI2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:28:45 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:56904 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhJHI2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633681607; x=1665217607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=b8AeWASUSFmPxVEF4k4i8ozHxoQ+4tE13wttw8cGf8I=;
  b=KZdUq9IBB1tcMrbzO3amNCwCy6XsfufkxctjKoAMR3MLJzgx7X33larS
   SplHhqv7QFIqy1x8V23ZNbhnZRGcak9Mne3KnJ0vm0Th7aqpMNb2djb5E
   fOhsrkgQUCkuawsaX7xQqdxFMaXPC2O5QOMLM57k/dWYDLLQKFkCDd/u9
   qux4NNi2aKBp7Qwarsuc3Y/LJfcbdQPSQxu5TtY+Ddj19w7H2GC/3GGtw
   izbOBIlfbIuhncmAzORd9D7tyPNBVPtxnUn0BDv0HKngF4d+7NG8YUo3+
   RbOV3bVhqS/uOjwIT74bt4sTSB75NsZK1GRs/JK1JRlHtQBy+nLaHpJFF
   w==;
IronPort-SDR: YDcDz08gESluymFEzsauyBEAut/PCQw9k6q5b3P79DkP0eBkmNyYo2P/uZEVUrjIi+HzrgkcsX
 2YYhIG+icnkSRxk1cFeV+kcMv+uaudZMltBo3yRor7FWeDOaf1ExcH6FKKAh/TFZ74P9HCYaj+
 7BIcLU9imDQfb0wrgyTA1GR1Mi1FZTaR/zHdvbTkegidg3FMaKWHRQAT/SgNP2DF9xYlCjiK8w
 yPDfAuy5Z2jxpdrSq1GBLSM6oG7qbc4Qb4f6zHRVCfrA2LJh/E0P28ACKgnUQGfpZ+AbfUsoy0
 YsOl/dhSMZE2K/Avcb5/sEUA
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="132175339"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Oct 2021 01:26:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 8 Oct 2021 01:26:47 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 8 Oct 2021 01:26:43 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v8 1/3] dt-bindings: clock: lan966x: Add binding includes for lan966x SoC clock IDs
Date:   Fri, 8 Oct 2021 13:56:33 +0530
Message-ID: <20211008082635.31774-2-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211008082635.31774-1-kavyasree.kotagiri@microchip.com>
References: <20211008082635.31774-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LAN966X supports 14 clock outputs for its peripherals.
This include file is introduced to use identifiers for clocks.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
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

