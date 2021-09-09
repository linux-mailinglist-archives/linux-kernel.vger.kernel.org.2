Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBA7404671
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352740AbhIIHlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 03:41:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17114 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352725AbhIIHlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631173211; x=1662709211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=8Z/q9u6J6X9odZyZgZS3kh3rN7rE+HIwG/tPx58z6YY=;
  b=bM+HdsXGRC9FVi4RN82hoXECumHtXBMjVWrCUQHMZ0ywhiFq/rUxjd3J
   0Ek+dMTEJS4GnnCd75MgDsw5g08ryUEiJ5//9IkzJVcqIIG/ACGOdlOeO
   S2h5GTSvKOfLmZxTDaWwWB6dXx9WXncb8nOe7QUidQQ4BLG9wmpqMpCUJ
   FUOGMlOJhN8vxwOVGdJ5QSbwZdyrvdPYFtWDntOfypIiJPlaabPZZmFVN
   IT+S9LKspi59QeER8jl6ZqpwMT25wFaCYwo2PUxrhiat1eQAbtp90eVhS
   xtHJM46pkmb7O9Ur3J+mJemgGPpZ68wt4GHfB8kLrqd+04J7cbJRTRwe1
   g==;
IronPort-SDR: yLbLj7c0NsXqAmtS2BPMOGjHLmkKu0vsVZa8mG2CGMDkRPBc/YfNy0rMsRXunNo8PhPgb1bnSy
 88+leyqACG2mVPvQ4LB0ZTIQVya1SUgRlACJKcXwk7q0qyugJ2o1fMwb/ORqrNDiKU/RaFFvK3
 wMNYYwkNwRis0BMrtlumCftvEEBz3gXkP8l1RF5eLiqQQWRg1x6fnor2/5L/0NZPGt8GgiYYVR
 R5ZsfcNMGpZLIBJmBsjlKTK0W/bslqfotJVs4+g1LN85kB4iSev+AMsXgpr/X8tACsnxECYD6L
 TFFVBlKEZrDmoAsF63iMs9Pu
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="128724859"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2021 00:40:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 9 Sep 2021 00:40:09 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 9 Sep 2021 00:40:05 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v3 1/3] dt-bindings: clock: lan966x: Add binding includes for lan966x SoC clock IDs
Date:   Thu, 9 Sep 2021 13:09:45 +0530
Message-ID: <20210909073947.17438-2-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210909073947.17438-1-kavyasree.kotagiri@microchip.com>
References: <20210909073947.17438-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LAN966X supports 14 clock outputs for its peripherals.
This include file is introduced to use identifiers for clocks.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
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

