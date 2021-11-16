Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E701B452ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhKPKSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:18:45 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:44801 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbhKPKR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637057701; x=1668593701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/EoVRfeXsKrEx1Z5FwdvtGr5J+131lwL9RZTW9bzi3A=;
  b=DNbP32ox2pq0Qj2O1mYstNtM9LooeVpZoN0C1KHx/zrQNGSnF428/fqU
   DvqmMyVGAP1f9giIIj8yuoX4fnVB/MCyXmPB7MHuYUdOiCyxKSz9dstVG
   2lzNhdHZ65ARkodjEqsIky2/Sf4W5VS0xjSSG8ntMNe8PnLK0qMTXuAw9
   2zNKRQJk/S+q8X4DO78gk/9bDSO0rJgP2IcobPAdld3PlqzMUic7QnTnU
   uAUGbbk9Zq2pnUB//2xYkj2Zr1iigUdfJTbR+nciP1b1fa7ApOGzOpxnX
   Byoe4tJnTLjkHenRQar99TNKGhvENpcEpBndHuOYlUUW73a2dhMRYDTQZ
   w==;
IronPort-SDR: 1oaLpSh3HmN/8ZbcFsh7M8PXv6k9mBFlxKt4FtgSz+pgtTh0tdfHXCGECuPhWTQgKjrcmWxRpJ
 CwbvLZtGU4aW9Qv+RfoaauKG8KqPlYGOryoy7hj268elXis9dpIc1Ehlh8UCo69zO1oiVjKbm7
 adVLggY2bo90ogOQPRpidhUs0dZ0Q7R4wSPaGv9wjsHHJJHhpw6LRtjP40IevRA0zSB0NoYBeJ
 4wDkTdPLqHUhEfAm6al7M7c9pXyQ+RtAyahd7QHrprwyx4XVUePw4ADHT4PZFTYuR4BQ8jb6pG
 V85XvbyTkmUeanMoyrpwaPeZ
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="139272092"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 03:15:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 03:15:00 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 03:14:57 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <alexandre.belloni@bootlin.com>,
        <kuba@kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH resend v4 2/3] dt-bindings: phy: Add constants for lan966x serdes
Date:   Tue, 16 Nov 2021 11:08:17 +0100
Message-ID: <20211116100818.1615762-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
References: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lan966x has: 2 integrated PHYs, 3 SerDes and 2 RGMII interfaces. Which
requires to be muxed based on the HW representation.

So add constants for each interface to be able to distinguish them.

Reviewed-by: Rob Herring <robh@kernel.org>
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

