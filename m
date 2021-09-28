Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE9841AAD0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbhI1IpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:45:08 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62356 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbhI1Ioy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632818596; x=1664354596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q0IZHstorNE0oUCKxBodA9uRcfcTGnYv+7N52jiTOP8=;
  b=d/tkaD9+Z65r7mV5pcgBT0PSeaQaDmIhbJDn1r6RArLZdTrf/qgl9g50
   xa/91vRh+2dHI3MO4WlgCCkY6YK/ut54vVqp5kUzIy4LWClqlfRjheKsu
   VD1O19BY5oGl+AY0DuU94rMNsden58Hzcp8xBDVr9Wa9ZT7u78KrjPL73
   34WZ9xDUfo+By7C3DaBvJIaiA2ZR5xqslwyEdnG/7J4jbu6FjTP5ywipQ
   C7eJysm+eon7/ihWof7Ez29Hxc7v+RVfxIIU79gDy2OYd1F8Dl/tiHAPs
   mxKvC1+YgwczlRotWNdliQG0xv6Ri5KT5TGWUHjLGbwzOhD9YLiWOBT6D
   w==;
IronPort-SDR: xRoBRr4Irb7a9Gg3jgjebKUHmWvsmRI0wHDoUCH8DaoZu5WTAUuJXHc25otsTHsMiTNQLWXMoL
 RrMXd+h393u+uDQiw5zeXj8F1ohIpkPF/5geoA0TfvZam9FyNWOGp/TZ3AOIM84SOHdJE/7C+v
 FEvQSM3nNqyyBEA164eOfUJdOHCIsBxeGzOu3n8rKWc92bwvXgMK4F1PyZnUbe5+92a09J9wRi
 IjOGcU3mUL7wgg/68M5WJINJBowp8u85DtlvE1xljje50dFRJ2YAda1UN07W6Gj0cQwBmymjtX
 h/rp3yPcFSotF7pm8Kf6EW5t
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="133440610"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Sep 2021 01:43:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 28 Sep 2021 01:43:14 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 28 Sep 2021 01:43:12 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux@armlinux.org.uk>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] ARM: at91: pm: group constants and addresses loading
Date:   Tue, 28 Sep 2021 11:42:56 +0300
Message-ID: <20210928084257.2188017-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928084257.2188017-1-claudiu.beznea@microchip.com>
References: <20210928084257.2188017-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group constants and addresses loading. This commit prepares the field for
the next one. Added fixes tag on this commit as the next one will fail
to apply if backported alone to older kernels.

Fixes: f0bbf17958e8 ("ARM: at91: pm: add self-refresh support for sama7g5")
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

