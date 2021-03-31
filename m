Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBF234FEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhCaLAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:00:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:43894 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbhCaK72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188368; x=1648724368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C7hxWt9DV3Pc9H4oOYS4u5rYRQhOWg1AJzI3K4Hdue4=;
  b=wnjqqcPs9pvk2lSdpumR3fKV9uVtXzZPOQThFx/xqegraTeMHMCr0LkU
   s/b4BQeZbZIZkIHsuVjDc+QGi06ob5VD2/9RnXUcXgl31QXNUglI0VRYG
   JIAy3Ij3C+ZLf/M0dI1jukJqrhQX2/fIRR4M/x51w86CKlCEN7JSa6OPg
   MBNT/fpwu6D97P9tJzea+hd3saNn4yxEJlOfqDsg5bGBZmv0ax5m4UoLd
   Aly3ow8Gp9qBJ2UE2q2IPkCQWSXgWMGzvs9bOBD7JGr/1TbDBSj0NaaT4
   4SbQ4BBXneUPtIbGtEXQuJS0sMkD4kx3VeIgmqWfNWnmGiVH/i5AcpWVR
   A==;
IronPort-SDR: L1/SHFAWK5iKH28yY22g9zFEYkSmf3Q51BSDKwyZ7clpHkOnd3opfLK4AtO5ueI8Vya7i0dAYn
 zyLnTveCFJCNC7lmouq5cYZSsxtcqMRb+SX+11C8TAWRb6FLDvTCuqjvcvCNhn9sXUf1km0dhm
 BdNodPMQsbdkLB0J5uYMyvq5b3CdiLedEpF8ejrKAWNu6yVT2WBIgC2JEjrQS12pRQKkSx31Uq
 lkz3n5Ax854XNgcHEy3cRbUbCuCrYu+EU3jG10aUQ1p58S+7XFYs5zMpYGG8ZythWW9U4FjBfh
 3vo=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="121233918"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 03:59:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 03:59:27 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 03:59:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 06/24] ARM: at91: pm: use r7 instead of tmp1
Date:   Wed, 31 Mar 2021 13:58:50 +0300
Message-ID: <20210331105908.23027-7-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use r7 instead of tmp1 in macros. This prepares the filed for
next commits.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index b683c2caa40b..3d20c9880fee 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -31,30 +31,36 @@ tmp3	.req	r6
 
 /*
  * Wait until master oscillator has stabilized.
+ *
+ * Side effects: overwrites r7
  */
 	.macro wait_moscrdy
-1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
-	tst	tmp1, #AT91_PMC_MOSCS
+1:	ldr	r7, [pmc, #AT91_PMC_SR]
+	tst	r7, #AT91_PMC_MOSCS
 	beq	1b
 	.endm
 
 /*
  * Wait for main oscillator selection is done
+ *
+ * Side effects: overwrites r7
  */
 	.macro wait_moscsels
-1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
-	tst	tmp1, #AT91_PMC_MOSCSELS
+1:	ldr	r7, [pmc, #AT91_PMC_SR]
+	tst	r7, #AT91_PMC_MOSCSELS
 	beq	1b
 	.endm
 
 /*
  * Put the processor to enter the idle state
+ *
+ * Side effects: overwrites r7
  */
 	.macro at91_cpu_idle
 
 #if defined(CONFIG_CPU_V7)
-	mov	tmp1, #AT91_PMC_PCK
-	str	tmp1, [pmc, #AT91_PMC_SCDR]
+	mov	r7, #AT91_PMC_PCK
+	str	r7, [pmc, #AT91_PMC_SCDR]
 
 	dsb
 
-- 
2.25.1

