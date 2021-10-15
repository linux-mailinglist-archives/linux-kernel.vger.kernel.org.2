Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67D642F12E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbhJOMoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:44:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:50457 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbhJOMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634301605; x=1665837605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j70I3MLfR+S39GoQ5y05nrBzwqYPqS8zv9d7ynokaLU=;
  b=Ae0C7W4Hci2S/V90J7jl5pBph8u7Tn3oaIx06fJ1NJTHLz3cuvjGPRtF
   KHBl9IF3flvgng/nPi3r8gxkfyNfz/gdkO1lS76u+UIUp+MlUuwEdb/+h
   p2KNf6JDRft0FaCP3tO4UXs/aKvL/3T8L+3BOjBFGD6LwcM0bRA6kxFbS
   9WV11B8qC2oP3q0Z6uzpD7mnymE/5cqBnhrRgwjk3XA/qOl4w2bfqd+s3
   vPMACkeQxlyYqT1yfX5pxRqM2S0u4i11dSoGOesyomeFAIc8pDTuU3oO4
   ySCUVw6OMic4ps+86f/+M7yZABA1bzlv6xY8Hw4bBFrSQV4oR7vVknLh0
   g==;
IronPort-SDR: +pD9xwTIUtt26j80oNLa49sgvVJDiV0Pr+WJA0vbFYMRhuvpy0uGP1W11EXfY7YFkUKdXQZpd6
 qMpGHMpcPVfAPTtracTFCDwHBxR3d2wgz5DMOuGGFztEeqH97mFc0Gf2C2EtVA8JcuJXXgn9Qw
 ELBn9RZMO8dA6qlvXMzVvD8oHMLN2SYDM1PIOaXaqYWXsLy4FJO1fMFIuPSG4lTXatZ+6kXDoT
 IRjpbMWCbtHPGK2FwUUlnWoBg6YXobqMxYfcBrt3e7gAhrfInK/Dm2w96VZ6OaCjedtwfGuIqY
 Smr4+2IXcr7pYy1aiwBmpdgG
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="73070434"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 05:40:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 05:40:04 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 15 Oct 2021 05:40:02 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <alexandre.belloni@bootlin.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v3 2/3] dt-bindings: phy: Add constants for lan966x serdes
Date:   Fri, 15 Oct 2021 14:39:19 +0200
Message-ID: <20211015123920.176782-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211015123920.176782-1-horatiu.vultur@microchip.com>
References: <20211015123920.176782-1-horatiu.vultur@microchip.com>
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
index 000000000000..8a05f93ecf41
--- /dev/null
+++ b/include/dt-bindings/phy/phy-lan966x-serdes.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+
+#ifndef __PHY_LAN966X_SERDES_H__
+#define __PHY_LAN966X_SERDES_H__
+
+#define PHY(x)		(x)
+#define PHY_MAX		PHY(2)
+#define SERDES6G(x)	(PHY_MAX + 1 + (x))
+#define SERDES6G_MAX	SERDES6G(3)
+#define RGMII(x)	(SERDES6G_MAX + 1 + (x))
+#define RGMII_MAX	RGMII(2)
+#define SERDES_MAX	(RGMII_MAX + 1)
+
+#endif
-- 
2.33.0

