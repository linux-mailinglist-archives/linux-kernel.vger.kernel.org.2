Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E5034FF09
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhCaLB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:01:28 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:40139 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbhCaLA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188458; x=1648724458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8kI0413I2spxGJDHxPyI3JVC2W8j7DJTYYAyAAjaxbY=;
  b=XKl0rFeAgKm3p4vABSwrj7ANNj344Lh6jkJ2RVpx3Jq5YTby5JCr3p0Q
   chggyf2DXL0SOglhnRWafAoRitwkS6r0ylpHUDZRTcKrcZ0psx26f0Dex
   wkcIBKeUHSDFVVMh7OINkqAlof4VxD+WUFhX34zQwUG864tsqWjAGqcFk
   tSJ4GvTsx2+ZA6zOMaUQmyR6ISEflWfanBzldeKDcQwWqva7XHSVLaaQF
   9MROVO2FvOS0pOi1Yodv3GL5JmmB1o3+1Ot4PsI3cYzroESgj3JzQ3Jso
   R362/BMjManQBux/IptHWcjOs46OcEBkaGw9hAPBYL4dPjIEhFvVgvqp9
   A==;
IronPort-SDR: +lFDCBCKBnVV1PPyyHExUiQ+sV7esE/Q/JwMl8Le2xskqDHzXhjDnf1iUzdcZmqbnUV6wGo5sZ
 nVZCsHSxuUmaUcncyPWAtoc+UN+AV0du2DbyWCLk+LEkjz8FAToFoT0fDR0k8Gqm6OJkt1HsTM
 1wsN9RNLxpBp47d4xWcBI/mm50VmVboXOiJTMS/2mU21pXYFX48sODqPOBmJspoJ5WYh2aEtmH
 B7Q1t+5oqaYPWlCpfKVHlUFRjwAaRYJA5fyU21r4m2AfbNz3J34FHvFJbWuBAI5gJeCfn70thV
 ToA=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="115333381"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 04:00:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 04:00:06 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 04:00:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 21/24] ARM: at91: pm: add sama7g5's pmc
Date:   Wed, 31 Mar 2021 13:59:05 +0300
Message-ID: <20210331105908.23027-22-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SAMA7G5's PMC to compatible list.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index fcb20272d65d..f4e66a7c7d18 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -897,6 +897,11 @@ static const struct pmc_info pmc_infos[] __initconst = {
 		.mckr = 0x28,
 		.version = AT91_PMC_V2,
 	},
+	{
+		.mckr = 0x28,
+		.version = AT91_PMC_V2,
+	},
+
 };
 
 static const struct of_device_id atmel_pmc_ids[] __initconst = {
@@ -912,6 +917,7 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
 	{ .compatible = "atmel,sama5d4-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "microchip,sam9x60-pmc", .data = &pmc_infos[4] },
+	{ .compatible = "microchip,sama7g5-pmc", .data = &pmc_infos[5] },
 	{ /* sentinel */ },
 };
 
-- 
2.25.1

