Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1EE41DDD3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345849AbhI3PoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:44:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:13156 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345816AbhI3PoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633016558; x=1664552558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k8rTAs71sYOBy5AaUJp/VkRWlqRjMEgAODabDK3o+O0=;
  b=YgGw5uwfD3om3JW3hLc0YJqsrLIouYg9HiXY7cSOOkVHKbmdDUOYQQNg
   UEcQL5qDI4nxP4Ewhad4TbSLiOFw2a/u01Xl2k4o/hNI0iUZeuxDsNC6T
   7AwMWJeiqYsSEMGhMtvSUl17SPjRs7N6BvVn626aLD4TAhPOvQwcMBJSo
   OTrBxEBHkossS9vIuJ6C6TBVkfNZ1qjoRDBVIRgbEwSSroyxgXJqwBNzk
   +DDVtn9JBaNJw8aAUu3hGJtpWgOKR/VR8jRlLCodwGlMTzSdUzvA/ZOe5
   UJpD3J346tkWMyGfqRvXcqZqE3cUEmH7rxDAV0VcZseDDwVgUmzLCfVMe
   A==;
IronPort-SDR: om+BUmowvRp8l5/Q9fEH/qQF+wec+POz3auxqoclxtx1R0+PKvmiJN87p4I8Xh3sYCZ/JXeEGh
 aQsmlJ8kDMU4J6AEgiaWSGvpB9VjYaizp820S0+CAQr3DKLkLVaW454f0UdoKTLWUolFvraMv/
 aHELLLx2Hrh0/0pCmZsSaACIEaFD+skYvVC11K6w0TwCxD9BMxujnHzNOINYKPCOjrqE4LfwQe
 egSuMyrTByLLsd4xmUSYMkWHryTNCBp/7U3KZjiFoJbD2Ch6TU2pUsmZ4L/u7gkPjusaAxgTop
 /iMkPhP05/9vBtkWvIJEcxZ8
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="138586105"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2021 08:42:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 08:42:36 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 30 Sep 2021 08:42:34 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/3] ARM: at91: pm: group constants and addresses loading
Date:   Thu, 30 Sep 2021 18:42:18 +0300
Message-ID: <20210930154219.2214051-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930154219.2214051-1-claudiu.beznea@microchip.com>
References: <20210930154219.2214051-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group constants and addresses loading. This commit prepares the field for
the next one.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index cbd61a3bcab1..34f251fdb743 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -1014,6 +1014,15 @@ ENTRY(at91_pm_suspend_in_sram)
 	mov	tmp1, #0
 	mcr	p15, 0, tmp1, c7, c10, 4
 
+	ldr	tmp1, [r0, #PM_DATA_PMC_MCKR_OFFSET]
+	str	tmp1, .mckr_offset
+	ldr	tmp1, [r0, #PM_DATA_PMC_VERSION]
+	str	tmp1, .pmc_version
+	ldr	tmp1, [r0, #PM_DATA_MEMCTRL]
+	str	tmp1, .memtype
+	ldr	tmp1, [r0, #PM_DATA_MODE]
+	str	tmp1, .pm_mode
+
 	ldr	tmp1, [r0, #PM_DATA_PMC]
 	str	tmp1, .pmc_base
 	ldr	tmp1, [r0, #PM_DATA_RAMC0]
@@ -1022,14 +1031,6 @@ ENTRY(at91_pm_suspend_in_sram)
 	str	tmp1, .sramc1_base
 	ldr	tmp1, [r0, #PM_DATA_RAMC_PHY]
 	str	tmp1, .sramc_phy_base
-	ldr	tmp1, [r0, #PM_DATA_MEMCTRL]
-	str	tmp1, .memtype
-	ldr	tmp1, [r0, #PM_DATA_MODE]
-	str	tmp1, .pm_mode
-	ldr	tmp1, [r0, #PM_DATA_PMC_MCKR_OFFSET]
-	str	tmp1, .mckr_offset
-	ldr	tmp1, [r0, #PM_DATA_PMC_VERSION]
-	str	tmp1, .pmc_version
 	/* Both ldrne below are here to preload their address in the TLB */
 	ldr	tmp1, [r0, #PM_DATA_SHDWC]
 	str	tmp1, .shdwc
-- 
2.25.1

