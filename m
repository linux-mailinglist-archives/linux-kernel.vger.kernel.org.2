Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88F041D4A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 09:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348815AbhI3HlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 03:41:24 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:39399 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348782AbhI3HlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 03:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632987578; x=1664523578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BOv8Gg7PU5rXFtB1XFC+YKxGSaaPEsE7DzJZPSr3S4k=;
  b=wQ7bQHWczERt9YkHndhWank98XcyYVTfVo9JKkLnVtweuCLEyfAx8WQQ
   /FlMrWLJx2ngcPUMRj106I1YiChBA0eJs0bipXYMK3XE1AV4WUwI0t2yX
   aUnaJA8EK9PIrR2gwo813KvbJh0Wtw1HFBNEVDMSfmAemwPOXIBrfkxyU
   fUdrwuz6jmvIcvrJjvI2WBPzhGDmhpjyNrL0cyzaQLelvieST6LmIB0Rl
   r2juHx2tNjwytZ9fHCQaEt/hqt/Q5WEg6r75J9+edPFFmUrsCwX90bbaE
   r8g8tPr1Hw9gal7TVQWtRzrwqq351TA4UzbIXUgMAjDf3rnCXarvFXO5a
   w==;
IronPort-SDR: lybkGg5VruaNXsMvpvtnzgYqk/wM3V9iU+1Pd32hbwlSdowEbXRs1NCvdJeAo4S0sZu87OJszK
 xA3N+RRzBdqsZXOcnkQ8+/n4X0ntJEZL+cvERnbviJy5aKSAxITUBipEUFE2xn83L5dnAQTGns
 5/ko9bmxn+reR2S157mRGPNSTrH7LKS3MRr3norrRValld3lMgRRzTIl4YT1ha5bLSQmUXUrUd
 TO7xtNAz+/gClwLtQ5h7VJugvGuXIuMwCyXUEyUeWnhXl3Q5cb//NAmRapoAnoakvmemNpK2Gd
 0DXMHuhL9r+6GYTZ81R/Zo4n
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="146229527"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2021 00:39:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 00:39:38 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 30 Sep 2021 00:39:36 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>,
        <alexandre.belloni@bootlin.com>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 2/3] dt-bindings: phy: Add binding includes for lan966x serdes
Date:   Thu, 30 Sep 2021 09:38:21 +0200
Message-ID: <20210930073822.2709955-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930073822.2709955-1-horatiu.vultur@microchip.com>
References: <20210930073822.2709955-1-horatiu.vultur@microchip.com>
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

