Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE9343481C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhJTJpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:45:47 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:52247 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhJTJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634723007; x=1666259007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jIJ1AwfUxGKF7dH+OvdoeRw3aK9VyFJmbBd8KYx8q5A=;
  b=Dc+dM6PJwluaAVbSlOQAnWMVsezjyPmqfz111Vr9VEqcxP7WtZDia7S0
   Kyv238tkQl4OLwKi4kzjBIWLfpsSvAtO6hdJlH6kZewtgVkhWvg1kmwr1
   YqubpYWmcqqGotr0uWmObqGgYGjxoYqg7XUmn+pikMHmKtQkwB1ue0Z4O
   aS8phd8fuli3n++LvWhFHTesxkkmJ3jkoKTBr4k3Cueq5AcLFmcr71MjD
   8IwF6q8t+2JbFxyvMLd+TsVepUk6AqOXl8NIhygp4GQF+rSf4jFJOWtrC
   56HDKc5++ZDhWXdGtQeENnHQhY3j0rVkedn2ZgzGqNr2T+dVEiZ9G8IH8
   Q==;
IronPort-SDR: 6FI26VcJou9CCMMY4EbBhJMHeVhZQeY2X6FMRedI1XmvEvW9QeN+dtIjQhOPGRxh2uiv8eYRLB
 +/GlhjSN97rwDnhp+MRZV699FDvyeGeyOkHg8PBWT4n162yqJRiFCUARsGSuSfb8GllRaLRvPW
 JqNGjhBfs4+/P5aDNvbwLpbIy/UZhE2DfW78IZnmZFi41JcABdGvIvqTJhJZyTug287jvTrIYL
 fQGflQgcYubpTWSQzoWiW3y627YMfxibZBpNfcOv5gXPznVvFsvVUZWVL7o4ydSlPANuexiE99
 YOuG6nZBWUQxOOCFKAaF5YVs
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="141015576"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Oct 2021 02:43:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Oct 2021 02:43:26 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Oct 2021 02:43:24 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <alexandre.belloni@bootlin.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v4 2/3] dt-bindings: phy: Add constants for lan966x serdes
Date:   Wed, 20 Oct 2021 11:42:28 +0200
Message-ID: <20211020094229.1760793-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211020094229.1760793-1-horatiu.vultur@microchip.com>
References: <20211020094229.1760793-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lan966x has: 2 integrated PHYs, 3 SerDes and 2 RGMII interfaces. Which
requires to be muxed based on the HW representation.

So add constants for each interface to be able to distinguish them.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/dt-bindings/phy/phy-lan966x-serdes.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 include/dt-bindings/phy/phy-lan966x-serdes.h

diff --git a/include/dt-bindings/phy/phy-lan966x-serdes.h b/include/dt-bindings/phy/phy-lan966x-serdes.h
new file mode 100644
index 000000000000..4330269a901e
--- /dev/null
+++ b/include/dt-bindings/phy/phy-lan966x-serdes.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+
+#ifndef __PHY_LAN966X_SERDES_H__
+#define __PHY_LAN966X_SERDES_H__
+
+#define CU(x)		(x)
+#define CU_MAX		CU(2)
+#define SERDES6G(x)	(CU_MAX + 1 + (x))
+#define SERDES6G_MAX	SERDES6G(3)
+#define RGMII(x)	(SERDES6G_MAX + 1 + (x))
+#define RGMII_MAX	RGMII(2)
+#define SERDES_MAX	(RGMII_MAX + 1)
+
+#endif
-- 
2.33.0

