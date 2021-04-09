Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F28359D14
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhDILSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:18:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:50958 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbhDILSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617967074; x=1649503074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1EEQphPvvifx5tT1d9lrbbNwiHANmvdL/6HrlgcCol8=;
  b=d6vz6UYQ0jZ7kKcPmUETa65J/5Xy+lIwBpmoo+7Y6ObI7j0MxyIhp8kp
   i7DIFLgM4XZYCqs0uQzms1IsC6R0aM4yDFqYOUH7Ju0+7lxC1MvrVyFYW
   4PcOoVbOhCGeac7dIDo94nxbOI/Dbe6lZGTLA3oRviWnDjO9wKG70XEfX
   CLWkpuyXzbuVXOneMory/sldizDh4wCQXe6T6eGvlabThl0KIvRAT3Q/P
   bMqVW8IpJyoWpp8b+qMYzpdRL1AAvNUPepTRA6qSkdettIXYfTWWIogLK
   okur8YjbGkWvK46ltfNlufSYHjTeF+YacvegHeORtEX6CqmnALngpKOJm
   w==;
IronPort-SDR: IOjV5b+AdlRqR9ESUsr69GTBNFVbd4RNZ2INpImewqaGKUXAcLEuIUuF3g8J6GhSS/cz+Vo8OW
 K30KShDBv7kbs3tVeGgu/rNfZHRT0XtnIF9rvNa9AKhkDteRzbkJNc7EwEkniWviCXM/FXva79
 ivp66VwpVEI/Eq7rRPmAvdxlt49UFBDCxsj7FxBJK0cOYo42b3IbxXTXrx/v/9UFPsR1EftXDv
 3uMjVkFV+0auyGkoJ6fcuNTqCv1CUGEIqVlssmIrgCE/4xstgYpFMG6zXtwbs3h2MIo2CYd8Ja
 fP8=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="50565938"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:17:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:17:53 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:17:48 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 20/24] ARM: at91: pm: add backup mode support for SAMA7G5
Date:   Fri, 9 Apr 2021 14:13:41 +0300
Message-ID: <20210409111345.294472-21-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
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

