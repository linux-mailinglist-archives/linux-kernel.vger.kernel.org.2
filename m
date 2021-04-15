Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AC73607A3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhDOKv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:51:57 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49604 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhDOKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483890; x=1650019890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NVdLR/4vBiZXHdxKzbg48TM13jojIDCbZRf2vOwtXD0=;
  b=mm+8iuYMZfVslhQH14ih8TR8jvInuPnK5YUiNOd7aVd8IKCkCuJbyUkA
   qswmZ8fYHVAXjKm+hk5Xt1/IsIn3XAX6dpOogj88dIPK/NZiRkML5Hw9c
   TOKA64MkcBZtBt/rGiXdQHjYw7uQ4dSK+vENOwUTwjP6FCGuqwPdnQaf5
   HV4JUwknhbGKNeP/OwK4g7MKW5Iqdnmam0eCKOhDL3l7IB8QCkJ2FFX4P
   PlLA8bVD1thTgmIJV/yqhiLe1WTLrdTFW8jDCx9K7IbqFrfrdlQ3SnMug
   3etwpmTZFsUjZ272QMIPpbFyPw7xrx3mMUJ5UuLbgoQqb0FR5NCIFIhEy
   w==;
IronPort-SDR: soura4eL2MGDRs/nN7aO2upcnUabgjr4BGBuWD8tWVJ2fENdC+jlxSo7dLIpKKle8N9SmsPQl3
 rq93Cl2mvOjD5Bpe5GEz3ZXxLDMUoqFkPH6HBn5NCqWRbemtOeIm39750Q6uYeBY3sQeyqTz5d
 P07BW459zZisHxPTixVndSWpuL5WS6nEjGn8w+DsU1KEWe4JVoSVs0AGRubta2v41pdYe9y9sR
 F5IwKpdJ0SF+Wp5tX2y95J2jglruGkpjnvlEuwrLQRsntqr85A2NV13uov/0UpNabxpNWavWDJ
 rCc=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="116551622"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:51:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:51:26 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:51:24 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 10/24] ARM: at91: sfrbu: add sfrbu registers definitions for sama7g5
Date:   Thu, 15 Apr 2021 13:49:56 +0300
Message-ID: <20210415105010.569620-11-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
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

