Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C010C34FEF5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbhCaLAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:00:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:43913 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbhCaK7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188378; x=1648724378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NVdLR/4vBiZXHdxKzbg48TM13jojIDCbZRf2vOwtXD0=;
  b=h8bKaUF6Y8NRoxSGiNWRjaOb4PD3D8iHtlGIrS4tZIUCVqIO2Zn4V0US
   Dgd6Q/1CxCJDtRqH9bTgUJdiAcc6hLWRZQhijtRrFj9sAj9Y90bJmtF+V
   7vZRLdJS0Z0gRA/Zv49J6FdKmqOExFoyBrai2UztpbdzKpEWcEoI/BzOE
   ARinx0tL9eOX5nJZ2KxdYtm4bg3M9YvVK6lN5+ixPRU0mXEJCWBvC6njP
   zt7t1CpVgoN/oZiW7ohnSbB6Qb5+V8JKNW2xcgWaFakTDOv0m0UzChF3U
   ckpPdiHty8ymiMvdNu6E+g2UUOrO3DZqVuSFMjkTqJ0eBFoMAgigk64PX
   A==;
IronPort-SDR: WrHGpatz0+gXv79qwOEhq/Jdn3MWaGK1FGtD/W3BRtkR2XjIIKHKSDvViPi0mwGk2oOEfehoaG
 /3V3GKnPIl3qYP+mhNJaGY08gU0QhHo/N3aHB+isQ/YwhpB7Af15E7Uf92UDIxiJQkT8QuZYDQ
 g1NMEJ0F1ih77rhkp8AM4TCz/5b31I1tdP1MWWZRwbGjkKQR9PkwCxLxs1AntYB+f7D6xMtwq0
 2HBekLtNkt/U1OXXKJlyCAJsdvbwiBrk4Qz1i4htcWZrkk2xi6rYqPpHvdjgvIrpQ51bo6h22p
 7zc=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="121233940"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 03:59:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 03:59:38 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 03:59:36 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 10/24] ARM: at91: sfrbu: add sfrbu registers definitions for sama7g5
Date:   Wed, 31 Mar 2021 13:58:54 +0300
Message-ID: <20210331105908.23027-11-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SFRBU registers definitions for SAMA7G5.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/soc/at91/sama7-sfrbu.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 include/soc/at91/sama7-sfrbu.h

diff --git a/include/soc/at91/sama7-sfrbu.h b/include/soc/at91/sama7-sfrbu.h
new file mode 100644
index 000000000000..76b740810d34
--- /dev/null
+++ b/include/soc/at91/sama7-sfrbu.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Microchip SAMA7 SFRBU registers offsets and bit definitions.
+ *
+ * Copyright (C) [2020] Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Claudu Beznea <claudiu.beznea@microchip.com>
+ */
+
+#ifndef __SAMA7_SFRBU_H__
+#define __SAMA7_SFRBU_H__
+
+#ifdef CONFIG_SOC_SAMA7
+
+#define AT91_SFRBU_PSWBU			(0x00)		/* SFRBU Power Switch BU Control Register */
+#define		AT91_SFRBU_PSWBU_PSWKEY		(0x4BD20C << 8)	/* Specific value mandatory to allow writing of other register bits */
+#define		AT91_SFRBU_PSWBU_STATE		(1 << 2)	/* Power switch BU state */
+#define		AT91_SFRBU_PSWBU_SOFTSWITCH	(1 << 1)	/* Power switch BU source selection */
+#define		AT91_SFRBU_PSWBU_CTRL		(1 << 0)	/* Power switch BU control */
+
+#define AT91_SFRBU_25LDOCR			(0x0C)		/* SFRBU 2.5V LDO Control Register */
+#define		AT91_SFRBU_25LDOCR_LDOANAKEY	(0x3B6E18 << 8)	/* Specific value mandatory to allow writing of other register bits. */
+#define		AT91_SFRBU_25LDOCR_STATE	(1 << 3)	/* LDOANA Switch On/Off Control */
+#define		AT91_SFRBU_25LDOCR_LP		(1 << 2)	/* LDOANA Low-Power Mode Control */
+#define		AT91_SFRBU_PD_VALUE_MSK		(0x3)
+#define		AT91_SFRBU_25LDOCR_PD_VALUE(v)	((v) & AT91_SFRBU_PD_VALUE_MSK)	/* LDOANA Pull-down value */
+
+#define AT91_FRBU_DDRPWR			(0x10)		/* SFRBU DDR Power Control Register */
+#define		AT91_FRBU_DDRPWR_STATE		(1 << 0)	/* DDR Power Mode State */
+
+#endif /* CONFIG_SOC_SAMA7 */
+
+#endif /* __SAMA7_SFRBU_H__ */
+
-- 
2.25.1

