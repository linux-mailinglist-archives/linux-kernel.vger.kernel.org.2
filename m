Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46D034FEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbhCaLAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:00:04 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:43894 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbhCaK7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188365; x=1648724365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U5NiENJ3r6pr7oIV8nUu7z5RbPOZH4Ba6WRiY6iI7HE=;
  b=OrJbNV7MdQ4uOa+3pMVAe/bcYxVkKbcL1X3ksSy47036lC4fQp8HiBtQ
   Lx+NIlvS4u9RxWCS5e6Y1rUC2KDMyAZxhDA1x1m5yMcTeR0tRmnBSNiW7
   lvi3mnP95XXn4m1kqbUWquzt9tY1XJ5YWOPKtkikC9s8kzM6sPbISzkbX
   kegRi9J/Riny2Wo9Obn5RIk32ls+Od5h6eng612DF0mu47lwmutQ7EMNP
   VWWBIH44w3buGvKwxfFsjRs34ghbHE6UQFgOEcIpzbji/yKxDK2xrAZAy
   zgwksB2dMl91YtDq1LoCkkm5lRGPt1Gn7AZlbs64okGH3NTeQyJKS1rwM
   Q==;
IronPort-SDR: Jv79PBKtv5f6X63XwZ9UhUeI/BxnU8liinkUXXvp+gMwZoph0kXFvhiB9tL7ucdwP0YKF7gqhz
 4E6DM61VRoRmweswlGTFxEwxe3O8oe0KISduOmQF++vSd8TmSxiKF53fFjEvB0xTnot5oMFWfU
 2l3+JjxtzDD9qIoXScudh6kVgzRqOgTjQH48fmux7KnryJ1/n9CkgEiIN5CgrV0YSHEpo5Wu5b
 KTU6SlvUL34OCTmgU1TXjVkPiGVrsVnecSxc8Cud5KHltTma/YUcQQ72DNuFMxE7WJm1OAlZdV
 2ns=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="121233915"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 03:59:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 03:59:25 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 03:59:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 05/24] ARM: at91: pm: do not initialize pdev
Date:   Wed, 31 Mar 2021 13:58:49 +0300
Message-ID: <20210331105908.23027-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to initialize pdev.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 5a6ce1d88971..65e13769cf50 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -659,7 +659,7 @@ static int __init at91_pm_backup_init(void)
 {
 	struct gen_pool *sram_pool;
 	struct device_node *np;
-	struct platform_device *pdev = NULL;
+	struct platform_device *pdev;
 	int ret = -ENODEV;
 
 	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2))
-- 
2.25.1

