Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8E53FEB46
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343533AbhIBJaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:30:16 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:25294 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245677AbhIBJaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630574958; x=1662110958;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=5Dcx5Nq/oMIEsPOHd0nNJnABbHCZnAQ2ZES0DGApcQg=;
  b=iSu2K9usFA3XObHh3EFy7FcoMaHeSep2M82CL1RY3kZ1E6igRqQ7b5lS
   rxOJGeTo6ips1MVYmMU4UqjN4yodUiHv5K5zFyWpFS+zZVIUgZg7KHkL0
   FufMfvTVHpIIuhdHMgYauxa0qKdA7ZngKZUtBnXYs5XTFlOtwTPY+9FEc
   ZMMKeApWECRCX2bdbm5BM1siX2RsG9dLWg70XnxPlxv271KrzO8O99D8H
   H+icN6/Fhz/cdj7nRxmH7olvca3vm+VuSUw1cBWP3D74jzbk5UWysJXjA
   7+rTQHFl+a+0HJJcwBQEwwtzbijbeRLh38JoIK8f6zA8ADWZZSU2Mmy8B
   Q==;
IronPort-SDR: DuNahyJUOXSNTvjd1Khs8t4JQZnv1H63AuhHI8ZPoV9H7YpfPnj1706OhFI6J5Kb/pvPBKYG5m
 c1MWl5zIHH7HCPO9hhLO1NtvlgNoxo0MJhASZuKdYm9xGNbuB2VXR4dx64Z45x/w5HyMHEqj/l
 ML/Vn/AOD8kvK3MzKW32R6m6wOvAMR2pxw38rIesoHjHz0dmSBliDr3DIA4oI36+QIiHAIVmWJ
 BG4w3B1Ajff7PRNrc2MFU8e6HpXfisHDwaHeNbp2JcuAP85u71tgaHLUbaRO7EfLtaIW+fKb68
 0hleKSI22oxicOu1BexqxUPd
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="134575498"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2021 02:29:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 2 Sep 2021 02:29:16 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 2 Sep 2021 02:29:12 -0700
From:   <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH 1/3] dt-bindings: clock: lan966x: Add binding includes for lan966x SoC clock IDs
Date:   Thu, 2 Sep 2021 14:59:08 +0530
Message-ID: <20210902092908.28264-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kavyasree Kotagiri <Kavyasree.Kotagiri@microchip.com>

LAN966X supports 14 clock outputs for its peripherals.
This include file is introduced to use identifiers for clocks.

Signed-off-by: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 include/dt-bindings/clock/microchip,lan966x.h | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 include/dt-bindings/clock/microchip,lan966x.h

diff --git a/include/dt-bindings/clock/microchip,lan966x.h b/include/dt-bindings/clock/microchip,lan966x.h
new file mode 100644
index 000000000000..97dd9d6480a8
--- /dev/null
+++ b/include/dt-bindings/clock/microchip,lan966x.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
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

