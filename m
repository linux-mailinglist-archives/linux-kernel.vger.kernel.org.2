Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9A741DB04
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351400AbhI3NaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:30:13 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17432 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351386AbhI3NaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633008506; x=1664544506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=tBS5epH0q6eCvymRi9e0lXppg+w8SolCNJJHP6DNxCY=;
  b=DUxPqSh45zmfMdRHSWUTDAtR0uX6ExL0D8edborTvYOzLFvN7tFeMvrJ
   9NYx6PskA4q15gSeW9N9PnMzBxH0eMFFEpOO53tVe0aGii4pxiEys1N38
   5yWUawRr6MiFNckHWuZBrnG/qBENT2oA7bNAy3N8KlEc/bZ3cZUE1nGk8
   DIMobdqZYEWHrPhZyeIUcmuv3LsqyIFmiNv3LomIYwruJBrRViOEXXQx4
   lojeKFCAJoH6HsjwXQmvukwkrywE/nO8TxHft1WRq/CiMZ+Vc3YXrgkOl
   r+30PZ3Z33RLzfsllOLBKoIobVflsn+kM5tlUgb6/MAv2p956CwDqiwSY
   Q==;
IronPort-SDR: e7FsoVLbCnl2ytg+8TVTCsTYap2FRNCxWhr93aw5K72dG/dBJbvdeSJ0DkHrdl9Vkes4WlLKtq
 boIbwpUlkgAIe/wm+j9WYlq4Mg1KAJ5yQU6qvIXhWN65P067CnD9/A6hyNwZiCZkpJOyQedU2t
 FbdYWSPuBrcsCmut/Qz9zNu8JdH0G7HMq/JvVaZzvxm8sIiNOFusamALoibwh5qVrNuFY+AbpY
 FDulzckyj+Ke896HDiBrUqcALUOYLlzAtTgK/YeGY56rW6UrAAAcDd4m+leqJA7W44xOGPjgGN
 Dicmk1NxTc0UBx8yYb3BhqgA
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="131255631"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2021 06:28:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 06:28:25 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 30 Sep 2021 06:28:22 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v7 1/3] dt-bindings: clock: lan966x: Add binding includes for lan966x SoC clock IDs
Date:   Thu, 30 Sep 2021 18:58:13 +0530
Message-ID: <20210930132815.15353-2-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210930132815.15353-1-kavyasree.kotagiri@microchip.com>
References: <20210930132815.15353-1-kavyasree.kotagiri@microchip.com>
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

