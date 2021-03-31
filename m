Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BC434FF00
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbhCaLBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:01:04 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:40139 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbhCaLAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188414; x=1648724414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1EEQphPvvifx5tT1d9lrbbNwiHANmvdL/6HrlgcCol8=;
  b=dW55f5XW9DF7RP5297C+CkFDP09tz9kBka9Dq3DOuS+rR2sUdn/tZVsZ
   napAOAqUQ96ypaG/O7wS0vFu7IVKyKSyBI6Pq3Z6trlyUd0nO3z/BwlNe
   9zlobM9ZPSWszOxhjBtoyxCO9G0ea7ba5OmK4xQRWffrSgnsZLWtGb4ag
   ItEErBxEOoFtlwpHmQjH2lubFnns71YUDqF04A81n1XgiG44gNJ7p9gaV
   VqOaL+efgJSQl0z0UczAYkebQMrVpsLVm78KSI3Ejd2W7PCxxKIeLqD1I
   86xFxo3ZQKVkhWYr5JUK0+LUg7tQyDgrj6WT6fMlLSlHR/yNj5hrmGyNv
   Q==;
IronPort-SDR: KglwRD31JvSJsaafilbWO6mOcWB6nJT1oeEbojZN2BSeHF/PTjh9c8FwqO+i3IXrsabB14gGHM
 DEcDRA9hl6SqvbdV9OxnKAQIfA7RN40Acp/MwHOzPmuno6uOfPB5dphwAgh5Dd/aZpuGxAQxQh
 wWyM1CpZGaVCNtHizzhGuOGOz6yxdbpw6TmTzJqGe92grhxhhsHYfxgF2i8wHA3RnOi5m10/Rf
 XlQFuQkR2C1fhcEcXt7GDBSviyZtEfqcNFyI7O1FDdP6K4a1CdK4MfZrq9+jdqFasFbwu2XH6/
 b7Y=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="115333372"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 04:00:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 04:00:03 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 04:00:01 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 20/24] ARM: at91: pm: add backup mode support for SAMA7G5
Date:   Wed, 31 Mar 2021 13:59:04 +0300
Message-ID: <20210331105908.23027-21-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adapt at91_pm_backup_init() to work for SAMA7G5. Also, set the LPM pin
to shutdown controller. This will signal to PMIC that it needs to switch
to the state corresponding to backup mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c         | 3 ++-
 arch/arm/mach-at91/pm_suspend.S | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 91b4014d2e10..fcb20272d65d 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -729,7 +729,8 @@ static int __init at91_pm_backup_init(void)
 	struct platform_device *pdev;
 	int ret = -ENODEV, located = 0;
 
-	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2))
+	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2) &&
+	    !IS_ENABLED(CONFIG_SOC_SAMA7G5))
 		return -EPERM;
 
 	if (!at91_is_pm_mode_active(AT91_PM_BACKUP))
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 7396e18dd7e5..cbd61a3bcab1 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -106,6 +106,12 @@ lp_done_\ena:
 #endif
 	.endm
 
+	.macro at91_backup_set_lpm reg
+#ifdef CONFIG_SOC_SAMA7
+	orr	\reg, \reg, #0x200000
+#endif
+	.endm
+
 	.text
 
 	.arm
@@ -989,6 +995,7 @@ ulp_exit:
 	ldr	r0, .shdwc
 	mov	tmp1, #0xA5000000
 	add	tmp1, tmp1, #0x1
+	at91_backup_set_lpm tmp1
 	str	tmp1, [r0, #0]
 .endm
 
-- 
2.25.1

