Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E280443D05
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 07:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhKCGWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 02:22:32 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:27413 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKCGW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 02:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635920392; x=1667456392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=F1Uf9//BXN8QrI7mSZkRXU0PdbhDtcfp2rYAmXma7uU=;
  b=aeLEvjd9JrdHvKh4O841rSKmIrE4eGck13nADU8Ajp7Vce9LtxRgkY74
   FtFchpOB/QaW7MdTjQw/r0Kvxg6tVQlyi49/LMWHdy+FDI/RveTto2kSZ
   aw3alLejA77IpJ/6unRo/jFzOiigE/lPtHZ4bAtmQgwz9MiXmqsm8eJKZ
   /jWFRXPGMFtR9+5kfn1dQIaHCclMhXeGNEfPwzvJfNNQqnFUFewm4JMjn
   d1AVyJzJHiI9sseznSzItuL+siIVVpBNlnpaD5978isXtASIEhmfojcyn
   gvBvqhEWo3LJ2fz2MO5EidGlsO2+3ei0VJYDwO06BhIERy2tXhX3X303E
   A==;
IronPort-SDR: SNO3wbYOLD5Y5XQIBSRUmwt85dNe544lv8Gw4OVyx9S11zC8WFJLEUL3fqqktErxtQsC5db2KW
 QpkAyy0Xwkh8f35lh3SK+TEdVGe/aisO6gBtzqBQE/GDWqRofNtnlHmgyy3mFK8UAa22uCSBMj
 sUzIXfsxdiuQGlois9vrVitQSR4wSS1dmUCMUIhXZCyiR5Dgoh+ccoebHbjkatFCPdFJWAAmwb
 A/DbqS660ewyEzuDaEY4/nylP3qWf0TU5S+2U143hIftINkitnjf4xm2IFkN6x/YBDIDdWEm6j
 W/CCgpJ5pdwc7mxADCXXmoDr
X-IronPort-AV: E=Sophos;i="5.87,204,1631602800"; 
   d="scan'208";a="142614147"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2021 23:19:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 2 Nov 2021 23:19:51 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 2 Nov 2021 23:19:48 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <nicolas.ferre@microchip.com>, <Eugen.Hristev@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Manohar.Puri@microchip.com>
Subject: [PATCH v10 1/3] dt-bindings: clock: lan966x: Add binding includes for lan966x SoC clock IDs
Date:   Wed, 3 Nov 2021 11:49:33 +0530
Message-ID: <20211103061935.25677-2-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211103061935.25677-1-kavyasree.kotagiri@microchip.com>
References: <20211103061935.25677-1-kavyasree.kotagiri@microchip.com>
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
v9 -> v10:
- No changes. 

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

