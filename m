Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DCD34FF07
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhCaLBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:01:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:40178 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbhCaLA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188426; x=1648724426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kSpQpv98sh3osaRVrIiVAdt+VOG++l/L01AbZfP6hA4=;
  b=LcGyzp15XE+EWCFAG3k2ND64utaKZ4xKOPkK88RTlftyEHo0xNnOfaWH
   zezTF10j8jyz+BlYTffkypEO7u0WEASXxtV6nsHKsCUQW3bzq+ne77Bda
   qBQeLBRB2UDUsCEpZcm27Kla2uLkf0wOcnhwKunLatMV3IjVQWF+2pvzQ
   SgXXSk1bFpj4QeXnbievAd+Tjg7wTj+DBb4G1eFQFqH5ktn+q15S0SEm9
   MmF4s2YSGCbVsq8HwTrmZZsu7xhpQbsR0mB9exsr7rCq9eyRrMp4hLLOX
   cTjcFx5lJbFmuE/v0+97s32//X3xOMe9uqHgEFoC1vQ8Tpm4vAvkFFHHL
   w==;
IronPort-SDR: 77vytisCZHCD9D2Mo3NVdc4UU2CqZsfxFNqYM2I5K49kDwqiBdJEl7mXQtC2+mr90ouFrJ6jS/
 XJIKRqOUSOHMk4hK0kHxb0/Rlpl4xakxwCrwlmv6GttFqpE6iUnTYLbPg5TIrY9mDIU/21c0qI
 lFv6Zwmm2KV1avNK4UKMzB5sFkR7+Y7cQ6XxiYaZQTBDlE/5kaQZ4YpTX59r1JmxHD1F/z0FB0
 kzPJCqwWql1F9ZiLKtbhJkfMa1nH2QlQ87ArfEBnowOAdh138BOFUuGJCuB9xXwr15gOELsCJp
 7kE=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="115333403"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 04:00:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 04:00:13 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 04:00:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 24/24] ARM: at91: pm: add sama7g5 shdwc
Date:   Wed, 31 Mar 2021 13:59:08 +0300
Message-ID: <20210331105908.23027-25-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SAMA7G5 SHDWC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 24d5fd06d487..d6cfe7c4bb00 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -794,6 +794,7 @@ static int __init at91_pm_backup_init(void)
 static const struct of_device_id atmel_shdwc_ids[] = {
 	{ .compatible = "atmel,sama5d2-shdwc" },
 	{ .compatible = "microchip,sam9x60-shdwc" },
+	{ .compatible = "microchip,sama7g5-shdwc" },
 	{ /* sentinel. */ }
 };
 
-- 
2.25.1

