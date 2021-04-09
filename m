Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6846359CD9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhDILOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:14:46 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:50737 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbhDILOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617966870; x=1649502870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FFWqdC3u8rrc15OFLABpNkyEHG7NR8VJAkLO3zUhwh8=;
  b=Oit4FiL9zvW7kpo7DTHpHrnC5rA6xsN4CIORXe4qzsjL+BVthVcQSqxo
   /Oz4IYaA0EyR4QHQ8injTdMXUtqNXOl+JY8YoW9AKJS0hjPEus9WOfxih
   UE9ceTkzGoyMUN3cMDYtqhhS8jqkJmjmwM/wtBqnA0f7cuaaoH+epZG0e
   B4SLNiagg88ob3KL7Qvt1XhnjNS7X6V6tglD5E2oUgRFeVaJxNt+xHl5A
   JBuZkaAngLQJwAdq4tech1S3H0RvTHVIqWipaIqpueB5h6ujjAAjPheQr
   5gMV0NF83ijvnlekY9wMal6vIcK/U7EItFzyJXCcEfa1HiFuup5Z9UosU
   g==;
IronPort-SDR: BxE4bxwfkVu7WMPB5+bsxp4ekaiv7s4vvp+T9Z12ly+IgCj4tu+aMAf//ScMrtPWyQ7D1pxlX0
 CpMCtb/kpn+O405+R8hOzP/zZP9wxv8igZ8L6tEpgj3lmCBJmqu9HdJOokuHbgtTydpKfNxXbj
 rATLbfci2y8WJZjZE8XvLdTHII+lyGVx+e89wYVihQ7unJIS3tmIA5VJxptYFhkb+nJziIIezD
 SW4IyNjf1C/lqvXEUUGEItbhhDxPZPXjxVj79hLPP8w0emUxdlKhL4CGPbE0GqL//IMQCjHZay
 3Z4=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="50565812"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:14:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:14:30 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:14:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 01/24] ARM: at91: pm: move pm_bu to soc_pm data structure
Date:   Fri, 9 Apr 2021 14:13:22 +0300
Message-ID: <20210409111345.294472-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move pm_bu to soc_pm data structure.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 90dcdfe3b3d0..e13ceef7ac9a 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -27,10 +27,25 @@
 #include "generic.h"
 #include "pm.h"
 
+/**
+ * struct at91_pm_bu - AT91 power management backup unit data structure
+ * @suspended: true if suspended to backup mode
+ * @reserved: reserved
+ * @canary: canary data for memory checking after exit from backup mode
+ * @resume: resume API
+ */
+struct at91_pm_bu {
+	int suspended;
+	unsigned long reserved;
+	phys_addr_t canary;
+	phys_addr_t resume;
+};
+
 struct at91_soc_pm {
 	int (*config_shdwc_ws)(void __iomem *shdwc, u32 *mode, u32 *polarity);
 	int (*config_pmc_ws)(void __iomem *pmc, u32 mode, u32 polarity);
 	const struct of_device_id *ws_ids;
+	struct at91_pm_bu *bu;
 	struct at91_pm_data data;
 };
 
@@ -71,13 +86,6 @@ static int at91_pm_valid_state(suspend_state_t state)
 
 static int canary = 0xA5A5A5A5;
 
-static struct at91_pm_bu {
-	int suspended;
-	unsigned long reserved;
-	phys_addr_t canary;
-	phys_addr_t resume;
-} *pm_bu;
-
 struct wakeup_source_info {
 	unsigned int pmc_fsmr_bit;
 	unsigned int shdwc_mr_bit;
@@ -288,7 +296,7 @@ static int at91_suspend_finish(unsigned long val)
 static void at91_pm_suspend(suspend_state_t state)
 {
 	if (soc_pm.data.mode == AT91_PM_BACKUP) {
-		pm_bu->suspended = 1;
+		soc_pm.bu->suspended = 1;
 
 		cpu_suspend(0, at91_suspend_finish);
 
@@ -657,16 +665,16 @@ static int __init at91_pm_backup_init(void)
 		goto securam_fail;
 	}
 
-	pm_bu = (void *)gen_pool_alloc(sram_pool, sizeof(struct at91_pm_bu));
-	if (!pm_bu) {
+	soc_pm.bu = (void *)gen_pool_alloc(sram_pool, sizeof(struct at91_pm_bu));
+	if (!soc_pm.bu) {
 		pr_warn("%s: unable to alloc securam!\n", __func__);
 		ret = -ENOMEM;
 		goto securam_fail;
 	}
 
-	pm_bu->suspended = 0;
-	pm_bu->canary = __pa_symbol(&canary);
-	pm_bu->resume = __pa_symbol(cpu_resume);
+	soc_pm.bu->suspended = 0;
+	soc_pm.bu->canary = __pa_symbol(&canary);
+	soc_pm.bu->resume = __pa_symbol(cpu_resume);
 
 	return 0;
 
-- 
2.25.1

