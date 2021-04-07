Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A75357292
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348014AbhDGRBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:01:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:63069 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343667AbhDGRBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617814869; x=1649350869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j87slTyYjyjRYvVn+F4v3yvbtHoWqD23rMrKKhZVRSY=;
  b=UD8aUnFEWCzmC0CtCCvRtw+1zlvRt60LRgt2iJuCgjHbqVE4+9Z14mj6
   ddufBPDgHjwAlv+ABtyKamjr7C7vgBz9ghGRPdlXDtgvdWM9HnwAU3uMd
   U8ZebAYdisLGqJ0Gv0v6RmpfjJ4cbBAwvk5LwWccoS8QWQ85Tv5xkcRak
   naOsa/Va17i2pdG/4oYrNZkMoyRFgZlIFOEDHPT/iZcOQu5ZzocGS7izU
   WG9XcxCjq7R6yTk4VeQabvNDJ0w2ugBuBVEyADHyKvejrCg1fMc/oLxfF
   sSWAqZ2sZu7QWoMyI45CgwePvJrKtxuBTg5Xo0QMPekQEFOf1dMSWQxL8
   g==;
IronPort-SDR: dUKYcU7P1NlSQdkVPcYZhFbj0cvurGp7vj3Ei0K0vV11+1Ur0cNZ+HFHKa+94kgfborDasANyB
 aR1CMAigR1t2xzajtu7zQIeCB9LaTwnJBXVQqwJmiy9Ic+rhRa9wZJ39akgnczObKU8ivq8pRy
 J2k0HRDOASMfx+H+UfWKljmhWxQYRhycXd2Bv+9tPhFW1g+bLr0MQep3iNOhBjRBr7fSQVNCiz
 bhGUwBkoXEY3YX+NRXTUD2VaFHFAxzx02FpmDl/m9vUa8s1InoyQUJpnIKgnStIpBYgqk3RSIh
 NfM=
X-IronPort-AV: E=Sophos;i="5.82,203,1613458800"; 
   d="scan'208";a="50327679"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2021 10:01:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 10:01:08 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 7 Apr 2021 10:01:01 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 1/3] ARM: at91: add new SoC sama7g5
Date:   Wed, 7 Apr 2021 20:00:51 +0300
Message-ID: <20210407170053.298056-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new SoC from at91 family : sama7g5

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/mach-at91/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index ccd7e80ce943..5eb2a9206f42 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -57,6 +57,13 @@ config SOC_SAMA5D4
 	help
 	  Select this if you are using one of Microchip's SAMA5D4 family SoC.
 
+config SOC_SAMA7G5
+	bool "SAMA7G5 family"
+	depends on ARCH_MULTI_V7
+	select SOC_SAMA7
+	help
+	  Select this if you are using one of Microchip's SAMA7G5 family SoC.
+
 config SOC_AT91RM9200
 	bool "AT91RM9200"
 	depends on ARCH_MULTI_V4T
@@ -191,4 +198,9 @@ config SOC_SAMA5
 config ATMEL_PM
 	bool
 
+config SOC_SAMA7
+	bool
+	select ARM_GIC
+	select MEMORY
+	select SOC_SAM_V7
 endif
-- 
2.25.1

