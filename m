Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264A542381A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 08:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbhJFGhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 02:37:47 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:10532 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237331AbhJFGhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633502148; x=1665038148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BOv8Gg7PU5rXFtB1XFC+YKxGSaaPEsE7DzJZPSr3S4k=;
  b=oO1L18t6BM9FSTlMOmTqg68/qcSLQ2ZtwV4JXyaBpNI3aNc1msrz8oEY
   c8cvB9Lw/i/pBdpq0V9rQp0vKVUiYybblRajniw0X0g5xa+i5hdCbmWTN
   uPgfqvn8vAU3L8zkKk14LTe1udtxB0IvdZgdODE9i/j5pzIMHsUNpYO5F
   d7Kxy6OeZgPdFqLvgJNMeWGw1bq54nxcdvDcyv8sZKvwkcFtlyiehMFMA
   8MeWqfsCdZj93knkrhUdLk4KiGczWznUcN96QRb5yWdbhtBm01iywPa8w
   T+7H9TBTbR+Vn8ssFuQ/U4/8z47MQxh/PKVng58H9ARXBxiLLyFFLWFUH
   A==;
IronPort-SDR: w+pW4Xha1EvPpdVxUwbOia+d83PP/wGmak3z9g+kY8TvxDptGYmFsZMIJocMUzsiaM5UhZ5mMw
 kvAN/MQAGl0pfnGg1ZiWrv2VQpqY4V61qiuImb0bMbL1KMj/2Q1tccqiO7SBblGKIVd/TN2MNf
 qhpvUPTBu7a2a7u0aGiPxivD/3iK0jYjN7lTjkTq6utAwYuuvMJNVR0CRfbA1BZ755w5lYt1o1
 ExSAvJ1klhKY8hC/E2vSQ4jKVnzxTgH6A8IbxAUqyLKuLPUCGiO9kQfUSgePmmmBm0QFBXVS42
 T8aUoa0A9pB9YjciJfsFCnOd
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="134419752"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Oct 2021 23:35:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 5 Oct 2021 23:35:35 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 5 Oct 2021 23:35:33 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <andrew@lunn.ch>,
        <alexandre.belloni@bootlin.com>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2 2/3] dt-bindings: phy: Add binding includes for lan966x serdes
Date:   Wed, 6 Oct 2021 08:35:22 +0200
Message-ID: <20211006063523.3962427-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006063523.3962427-1-horatiu.vultur@microchip.com>
References: <20211006063523.3962427-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add include bindings for lan966x serdes

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/dt-bindings/phy/lan966x_serdes.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 include/dt-bindings/phy/lan966x_serdes.h

diff --git a/include/dt-bindings/phy/lan966x_serdes.h b/include/dt-bindings/phy/lan966x_serdes.h
new file mode 100644
index 000000000000..06e529473475
--- /dev/null
+++ b/include/dt-bindings/phy/lan966x_serdes.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+
+#ifndef __LAN966X_SERDES_H__
+#define __LAN966X_SERDES_H__
+
+#define CU(x)		(x)
+#define CU_MAX		CU(2)
+#define SERDES6G(x)	(CU_MAX + 1 + (x))
+#define SERDES6G_MAX	SERDES6G(3)
+#define RG(x)		(SERDES6G_MAX + 1 + (x))
+#define RG_MAX		RG(2)
+#define SERDES_MAX	(RG_MAX + 1)
+
+#endif
-- 
2.33.0

