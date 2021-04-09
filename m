Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08260359CF1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhDILPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:15:54 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:50814 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhDILPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617966939; x=1649502939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U5NiENJ3r6pr7oIV8nUu7z5RbPOZH4Ba6WRiY6iI7HE=;
  b=ud4zoAe8HHFbV8eCxB/P7sGcuQQoRwguk09WxJcfPhoQqEdmmhmXYEkU
   tu5FcUVWDKthmO+iFGK77O0bNMyn9zUsKoL0aqX+x7huREWiKrLWPb/A9
   Hoj2MiMAYMc8t08UZF3CehTeZ9aXIGTa0NwNiolCLH2TT8rsiPJekmYBv
   tEXtpDTFypyH/rJgtqq1fTus5rVVSeeVdXsHi/DE6Piu4eM0gf3fJZL/T
   IcNWvS+M/eZx4+iV2p2O52d4ImAIox8i84/FgRREdHRpPY2dP2TDai0Uy
   j4VhO5oZndq37ktBYHCvvMC6dTEIon+jn7bEP4UfBkOtxSrssvaBM6HL7
   Q==;
IronPort-SDR: 19NJZI65jRompkMez7dFAoNAqASItaCDK1B57NnBGb6g6Yd1fGM0JOcnvnQO1Akz3gtDpMVyFe
 JqzvcBxrjAHU7svX0cK06WDfuPjD00zga555lpNyam9MQSc5kKhn9eYYY3kwIic+SbHZRXkg2m
 kNjnfnpwKB9v+oBZZM7YskcgBk3ugfvLnAreRU2GHa4zh2Rmmr6REd3YDnWwFW5YuSLN9q1VUA
 1wv+cBgYFKL6sGD74VwkuoEYCsza3snWjeRlRr2jg9Ze5scK8hELDnMvkHpvxzdZqS2T/fUgyT
 8fw=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="50565871"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:15:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:15:39 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:15:21 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 05/24] ARM: at91: pm: do not initialize pdev
Date:   Fri, 9 Apr 2021 14:13:26 +0300
Message-ID: <20210409111345.294472-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
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

