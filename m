Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B861E40F996
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 15:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbhIQNy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 09:54:27 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:54007 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbhIQNy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631886784; x=1663422784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=EH3FGK2s2PmEEbXcpF2p4CnCPATYbbauhs7C7pWuk8w=;
  b=iEikI7GFaSqupXVLI4JmKyR5/XSdEqUwpdIIXRuuhlxHoWrf1fYJ8qJh
   /KFDqyd+cHNB2Ld5ACee9Jco9mfruKMIKFwVvGqFJ3wKSGwkbwtSQxOeU
   Swv4DkjPw7xAPPkbdjQqL5Wh453giPZDWrAixOwXVOH+UvfCM6QAVqOB+
   bp7r9heoZtlvgiQTebPygD5aJ5ifq5fZvPtIyZii3A8ZuKmHsdevSPA6O
   C7q5lKiaMXyMs0LouzT2A++ZwzreOq9Czv/RzauFOU+BetSaAOZFsYwv1
   smWW/a+LcY4RSQ88JPdVUuGEF5K8pgSI6k6iMQE+7d1kDo14UD3xMWhwu
   Q==;
IronPort-SDR: kaoCetwTDiEVHfyNgi0q6mQyXk1UR7q6tQiikB5YC9djwwlfv6jnil7LPoq7l/zS4o5z/8qbtG
 vqyfW8qYLhg4EpAbbgAYED3TgpJuqai2sexErV88gnagBkv9t4fakWgpDiZqWrZNvnLpFaJYYM
 se7kESrGQjut8WMZE7GPDK2k1CaHezFMdkScqvIK+t2gM1qCtoe64WfOvqTMUTEcbpRgiK62VO
 4s1kEspr623K/rfy4CjxAv0ZUboMnAy60EgkqOxI/XplHe/VLwQFfvZQUhcvgArvh88gWDDJr7
 l2cvxmxhKxDECu3ATUlmc2f/
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="129684049"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 06:53:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 06:53:03 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 06:53:00 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v5 1/3] dt-bindings: clock: lan966x: Add binding includes for lan966x SoC clock IDs
Date:   Fri, 17 Sep 2021 19:21:40 +0530
Message-ID: <20210917135142.9689-2-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210917135142.9689-1-kavyasree.kotagiri@microchip.com>
References: <20210917135142.9689-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LAN966X supports 14 clock outputs for its peripherals.
This include file is introduced to use identifiers for clocks.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
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

