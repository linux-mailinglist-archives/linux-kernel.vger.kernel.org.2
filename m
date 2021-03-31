Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381EF34FEFE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhCaLBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:01:01 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:43949 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhCaK75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188396; x=1648724396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7KxROLHftHxojszu7kto2DqA+KMwMJOPHCNZ1DYkUlo=;
  b=vWfcUAdz2BXqCgSnm7TO4KMlBiCAXB3URyFXkdALZVIeX0JEPJhtEWVa
   ivRX8VC/tn2/KWQXvmC5c6ABnSo07Z4cMMq+4CNs5SaEnA/3OfBL9i8Io
   oXRmKc98bJ0qE3aZjKm136K83D19odx1o+Hb4bXpR1y5iOrOxckFZPyTo
   t+HXw3PTNbl3Q47qYpHRSaLgPXMizN89Kai7UG7pLB90jzSb7PX8vztxn
   4/uKGosTu3XVCkOG8q3quunY99t9waa8POMqFFo8czbWg2MtHNWzMyY7R
   922RYrjNzyAM70iaSdzV8elUGCqlvKMqUAef9jwAJNHQlqtJcndSQ7e7K
   g==;
IronPort-SDR: u3ELgjAP/MEeZkTpB4Z70bfo5M4KC5N6tbK6ZNipWI1c7Y2poxoIkQm6Z8y3ZIophMC+c2boc5
 W6nxJ1PPAUI3X0u0YQno7ZIr0oMF7q5c5tANBRNj4pcSUCDesipARP6iFin038KQh6AJv15ML7
 IynOhMDyYjpdjDQ3PYbYTBNQqNdxwBq1FN3KG4uZGb64yJ+97a29oQKJ62BTbo1REAVhxclUQB
 +Ekd3EoRiBkY7XfABF+pBY4BZmdnxYNMvIBHVeSES/g8DCndrwFynH/sPpyOfl1Qd4MOJKzyxT
 K50=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="121233973"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 03:59:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 03:59:56 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 03:59:54 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 17/24] ARM: at91: pm: add sama7g5 ddr controller
Date:   Wed, 31 Mar 2021 13:59:01 +0300
Message-ID: <20210331105908.23027-18-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
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

