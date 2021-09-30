Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E5941DDD5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbhI3Po2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:44:28 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31936 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345816AbhI3PoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633016562; x=1664552562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SmX4ZduoWNa9T+QX9SzZQaa1c/SEhdpbKRtqYpTPzX8=;
  b=T7uK9zS3ryz9ybWVjU+bxQqGzWKJw7nPlF5LeEchnkm1Z3JG0YBu0JRO
   4r9YzD8S7GZIL+VCExv9++u/mphHZ0sKmKk0dYIvNbTGLR5291aAX+ony
   +SGUiEvCZdOZ8WhxyDjYZIQm3DcV4pu0txO3kavKlqRHXESSQEY2KfGNX
   /h5tNb56rN66TusrLZVsDBcjsnMVKqcxAx4cmf6MuKTMbhJgmArHQK4sx
   98YtOZojjPVLaxYKuGAIpJYppKBotwTvpesGedgijliS4dCFVnfMlJhmt
   dXYh8MIHDRCy2Zp+QMHDerbWSJsNB4TEpZBswsFWyQxDnJrtkGz0PLWNt
   Q==;
IronPort-SDR: Z+hFzDs3S5AIqjSQpbShBujrezhH4N3q3B3MStemOvzxNlCKtg/D5G1Iw8yWJm1yHl8pHGDrHS
 deHT9y7we3ct7VnK82iGTIlhwZD5SSVAjvsA7H/zSfcD5pcAa7eKHkk4ozYLk4PvUGDAIsFeb8
 1gjbV2G3+UlG2sGK4do8HZuQmB22Sn+1ZC+vE45JdfBjvzquXZ058mjEPPv423mXd2OawYBmbA
 HCydYVIkZ7Fw68gL63IsCXo0MLVQ/F+Ky2HuvAdoksjxF2G1Q2FB1LO6LMj5SC8pRkbeUxQvoO
 6qWLdt8IxhUg4JLWCxpNn5a4
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="146284180"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2021 08:42:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 08:42:39 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 30 Sep 2021 08:42:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 3/3] ARM: at91: pm: preload base address of controllers in tlb
Date:   Thu, 30 Sep 2021 18:42:19 +0300
Message-ID: <20210930154219.2214051-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930154219.2214051-1-claudiu.beznea@microchip.com>
References: <20210930154219.2214051-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In suspend/resume procedure for AT91 architecture different controllers
(PMC, SHDWC, RAM, RAM PHY, SFRBU) are accessed to do the proper settings
for power saving. Commit f0bbf17958e8 ("ARM: at91: pm: add self-refresh
support for sama7g5") introduced the access to RAMC PHY controller for
SAMA7G5. The access to this controller is done after RAMC ports are
closed, thus any TLB walk necessary for RAMC PHY virtual address will
fail. In the development branch this was not encountered. However, on
current kernel the issue is reproducible.

To solve the issue the previous mechanism of pre-loading the TLB with
the RAMC PHY virtual address has been used. However, only the addition
of this new pre-load breaks the functionality for ARMv5 based
devices (SAM9X60). This behavior has been encountered previously
while debugging this code and using the same mechanism for pre-loading
address for different controllers (e.g. pin controller, the assumption
being that other requested translations are replaced from TLB).

To solve this new issue the TLB flush + the extension of pre-loading
the rest of controllers to TLB (e.g. PMC, RAMC) has been added. The
rest of the controllers should have been pre-loaded previously, anyway.

Fixes: f0bbf17958e8 ("ARM: at91: pm: add self-refresh support for sama7g5")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi Nicolas,

Please link this patch with the previous one in this series ("ARM: at91:
pm: group constants and addresses loading") with a Depends-on tag as this
will fail to apply if backported to older kernel versions.

Thank you,
Claudiu Beznea

 arch/arm/mach-at91/pm_suspend.S | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 34f251fdb743..fdb4f63ecde4 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -1014,6 +1014,10 @@ ENTRY(at91_pm_suspend_in_sram)
 	mov	tmp1, #0
 	mcr	p15, 0, tmp1, c7, c10, 4
 
+	/* Flush tlb. */
+	mov	r4, #0
+	mcr	p15, 0, r4, c8, c7, 0
+
 	ldr	tmp1, [r0, #PM_DATA_PMC_MCKR_OFFSET]
 	str	tmp1, .mckr_offset
 	ldr	tmp1, [r0, #PM_DATA_PMC_VERSION]
@@ -1023,23 +1027,42 @@ ENTRY(at91_pm_suspend_in_sram)
 	ldr	tmp1, [r0, #PM_DATA_MODE]
 	str	tmp1, .pm_mode
 
+	/*
+	 * ldrne below are here to preload their address in the TLB as access
+	 * to RAM may be limited while in self-refresh.
+	 */
 	ldr	tmp1, [r0, #PM_DATA_PMC]
 	str	tmp1, .pmc_base
+	cmp	tmp1, #0
+	ldrne	tmp2, [tmp1, #0]
+
 	ldr	tmp1, [r0, #PM_DATA_RAMC0]
 	str	tmp1, .sramc_base
+	cmp	tmp1, #0
+	ldrne	tmp2, [tmp1, #0]
+
 	ldr	tmp1, [r0, #PM_DATA_RAMC1]
 	str	tmp1, .sramc1_base
+	cmp	tmp1, #0
+	ldrne	tmp2, [tmp1, #0]
+
+#ifndef CONFIG_SOC_SAM_V4_V5
+	/* ldrne below are here to preload their address in the TLB */
 	ldr	tmp1, [r0, #PM_DATA_RAMC_PHY]
 	str	tmp1, .sramc_phy_base
-	/* Both ldrne below are here to preload their address in the TLB */
+	cmp	tmp1, #0
+	ldrne	tmp2, [tmp1, #0]
+
 	ldr	tmp1, [r0, #PM_DATA_SHDWC]
 	str	tmp1, .shdwc
 	cmp	tmp1, #0
 	ldrne	tmp2, [tmp1, #0]
+
 	ldr	tmp1, [r0, #PM_DATA_SFRBU]
 	str	tmp1, .sfrbu
 	cmp	tmp1, #0
 	ldrne	tmp2, [tmp1, #0x10]
+#endif
 
 	/* Active the self-refresh mode */
 	at91_sramc_self_refresh_ena
-- 
2.25.1

