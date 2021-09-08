Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE96403926
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 13:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351576AbhIHLuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 07:50:19 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:12525 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351552AbhIHLuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 07:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631101741; x=1662637741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Oa5DMt/6lL88F55AZatAhWw3PGJoIPW1eCuqGRpDTMo=;
  b=Ogy4jFP53KISuMR9kWnK7iPG2bTmDPJpD/Vb4XLDl2XeyhEcLja1NxYN
   ctcahKY0GqIKHHdTcZ7uqwXrzy7GbLJ5r4oBb9ZN3mQhDaTups3qG3Dp0
   qi3DVmy26a5Bivte4+WbbMxidC7puUEme+ftb3ArZss9U2YkbuP12RRgl
   DimvXnarjg6b2LRxqObzFSwY5EzhsFhMvq5G9EkeBJKmJGMvXKfbNnRDa
   wOFh8KraNTlQEZd81s/2enYwr81nJ7G8njK3VC0OoWSS+LBecM2n3IUcz
   qyfpMBcRdUaDaMuvMImZ47NeIYRYnUFdnt+AxXn/G+NzOGyAUABYRtYry
   Q==;
IronPort-SDR: PlbGovjzNak4ntkOKAKbFXBUwsuWK6GGLMKTMEJdEG8n1ya7nskvnhc/AuWWze+btkkVvRllef
 XFXH7YHQBETsJv1FtR9DQmi4KMoZuQr4o3DctVIJpOHqKivGpPep0kIubZ+DnEjCvK9q1gfd7D
 kuxmzur08srzGtptPihCLIymCwldl7+UdCjcmBHhV0Y7T+ZT7Qrk9FUzvdaE5aOKmNXxewWWhL
 9obGss2bkvNuOvugAr6veOJMHJsV/ps6/sUQcAT17YyxAWXlTcPjyPaUkXu7lfoyMG2LOdS1oc
 d57Q3eFzSSbSKIHG5B36q9mq
X-IronPort-AV: E=Sophos;i="5.85,277,1624345200"; 
   d="scan'208";a="135238375"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2021 04:48:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 8 Sep 2021 04:48:58 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 8 Sep 2021 04:48:54 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v2 1/3] dt-bindings: clock: lan966x: Add binding includes for lan966x SoC clock IDs
Date:   Wed, 8 Sep 2021 17:18:42 +0530
Message-ID: <20210908114844.22131-2-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908114844.22131-1-kavyasree.kotagiri@microchip.com>
References: <20210908114844.22131-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LAN966X supports 14 clock outputs for its peripherals.
This include file is introduced to use identifiers for clocks.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
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

