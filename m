Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F87E417400
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345703AbhIXNBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:01:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:22018 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345613AbhIXM6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632488224; x=1664024224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=0usFPvOlAO0sJ/RUuOGRTVAVjTFyvonH5jhW3bfUWaA=;
  b=tOE6EzxeUNMXmV9JfXCUvpLndwS/EtxgcfX9w2X6GdiwMb/2gTjwLNIC
   ONQxWti0epMaFrw/vLS3Bg/izRxIuGoQyY4pIyT59SiczBN3gW6t9mi+a
   JU9AGpJXRN1pkZH2pMif+Db8fBUhe7cSgXhaH/aWeyVZAPLEAnN7BefUc
   S19VnxEDQ+9BFqjhyonCOU9klq2HVR7/DB25Ul8tr8fng4XXLiFODFVlN
   2njEcjBi+Puwaa0d3ViKc8e0ltXrhxanquATIssbkX9bIflNKdst5lB2Y
   gLjr9EpgZIOp2VXNwinyZpJUgicfE64VXVfSeAtWIQ8h6BCheF+iZC4dK
   g==;
IronPort-SDR: xLKPtKAFjiBWMImOhz1AAU7WIB9RuWOECTRcGgXpoAMLY0nC8tctxA5pGp5QpH2euwiftSejaZ
 Js0yInW5NcVTJoSe7aWpCQy5WoaEBW9yvcZkrd0jPHKHaj6KHhqt4f5yAd6RUiAmRc3vt8F4P1
 PIac59jufRfOo7sJCnwXNiekECPaweqqcU2V15kl2VuRaF7d66PQ9AxZm3BHt7F6PyOFvMkxpI
 7Q0SfOOFL/Afi2nZgqIG2gURDNvxmvJ/aaVxUL9kocJy+wKwyDC003Bo+YA4BJccvl2m8Mig8t
 6eREQJVK2AGwjJ4el0YWdv+t
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="70524977"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2021 05:57:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 05:57:03 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 05:57:00 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v6 1/3] dt-bindings: clock: lan966x: Add binding includes for lan966x SoC clock IDs
Date:   Fri, 24 Sep 2021 18:26:51 +0530
Message-ID: <20210924125653.2955-2-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210924125653.2955-1-kavyasree.kotagiri@microchip.com>
References: <20210924125653.2955-1-kavyasree.kotagiri@microchip.com>
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

