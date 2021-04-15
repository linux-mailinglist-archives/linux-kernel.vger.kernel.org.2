Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162DA3607B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhDOKw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:52:29 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:54924 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbhDOKwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483922; x=1650019922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7KxROLHftHxojszu7kto2DqA+KMwMJOPHCNZ1DYkUlo=;
  b=xDl7o2cJsO9Rml/5kwusKDmOfDBj1uyRASpDnEN+Y87TWG4uVcZANlnJ
   SEFLizhcgujfpzSiL+79AmMyXg8gkeNU/ZHO0LINr++m1lKDXfgIUBkxl
   hOnithjJi4v5X6O/iAO5XHzHObhRwUH50ZHges964ht5JO4Qq+I2eKhiY
   48kwACVNw4MGM3yTlwzKrT9b/4uOBNWZd0UldnllLiIw33J6zpEYjc4rB
   2lxbD+nJvfXinWaecclsk81izl9YXJ7jUX54q+NwJu4Ag8PHG3ozwGyvD
   AALyVcIxwJvQac13tTwnF+ceaDvklgRJBmslug9ZwjIUa50afresS6sRX
   g==;
IronPort-SDR: IIS7L/6Q3r7V19nf1WTkjKxU+Q3U1GOp95jXtlspwrac1xoz2cQ+SFZFGCI4MoUOttdfK7m+V5
 zhEeBiW+xRV2l4h9dKf8iIbCQrO4la9VyFc0HcSIbNJAROZLQ655hVMpel6p54emzPLzX+b/lt
 +/bcZRkQz104TfqgzfJJMFf5wH7tHQ5bX/ayyZjSaNeoNVvX2667KRLye9OnWghk050rqqtgso
 AFkpXUw6N1CtWd8+5lB2DD/kAMi61bH0uuWw4IPanpFp5Vytt/otH++1Os/2apG5rUa4QTRA08
 4fo=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="113688532"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:52:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:52:01 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:51:59 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 17/24] ARM: at91: pm: add sama7g5 ddr controller
Date:   Thu, 15 Apr 2021 13:50:03 +0300
Message-ID: <20210415105010.569620-18-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SAMA7G5 DDR controller to the list of DDR controller compatibles.
At the moment there is no standby support. Adapt the code for this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 65e13769cf50..5dc942a2012d 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -548,6 +548,7 @@ static const struct of_device_id ramc_ids[] __initconst = {
 	{ .compatible = "atmel,at91sam9260-sdramc", .data = &ramc_infos[1] },
 	{ .compatible = "atmel,at91sam9g45-ddramc", .data = &ramc_infos[2] },
 	{ .compatible = "atmel,sama5d3-ddramc", .data = &ramc_infos[3] },
+	{ .compatible = "microchip,sama7g5-uddrc", },
 	{ /*sentinel*/ }
 };
 
@@ -565,9 +566,11 @@ static __init void at91_dt_ramc(void)
 			panic(pr_fmt("unable to map ramc[%d] cpu registers\n"), idx);
 
 		ramc = of_id->data;
-		if (!standby)
-			standby = ramc->idle;
-		soc_pm.data.memctrl = ramc->memctrl;
+		if (ramc) {
+			if (!standby)
+				standby = ramc->idle;
+			soc_pm.data.memctrl = ramc->memctrl;
+		}
 
 		idx++;
 	}
-- 
2.25.1

