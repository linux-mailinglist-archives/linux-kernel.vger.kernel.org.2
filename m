Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07817360794
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhDOKv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:51:29 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49548 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhDOKvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483862; x=1650019862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U5NiENJ3r6pr7oIV8nUu7z5RbPOZH4Ba6WRiY6iI7HE=;
  b=v4qA26zxRkiBWsRb0cHJ0EueLTQCaf5NBemj1l8f9kjyG1pHekaXe8e3
   gnfqpTr26rHeONuPAUWc8pSNabOvki0IOlvruqEdrrpPh30doMa6A3uFN
   i4fUnXo7PmG1ovlEJ3xG5LhyFk3LNLMQe0s+EoyYEFLgFsmprbZHq1o5e
   Sp8+xLktuysU+jkS2BYPyODMQ9tDOH4LYCGPw9bnEhBZQJrn9blVVFrAJ
   lOLv8f22EHVxnhl/HI4l69W/KNfn2qxW+zdvH6ctgIBcN9E3kOviPMqzn
   C+oeiD5FXIerr4U9t95ecV+bEmoqthi65nrEgW58BjALlGoqLCgukiORF
   Q==;
IronPort-SDR: k5PLSCMzQjOdPWyacjx3G0teRYc/4/LJhoB0LDl1l3uxNL1thJntPEkkwT+VAetJZ7nEjM/tWH
 aIoZTDduKJhEeHW0X3BDljsrvld5TG2DF2JbEEqD/5kJgO+3bLn/oNwSgB47sAAtXzuPmG0ezf
 2N6jJlANZbZWCv9DcvRXMhD4kMly6Nq2AsLfWG4Q0Br0byr5m7DfVtLQsgvsC67eaXHJWZ7cmA
 1E4mLU6GGrGaxE0odnek9C7ewkI4T8YHjcmQJd6BHy5LtZjuhfAf7RsJHVRkh8HLMQJYazt5w7
 6LE=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="116551513"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:51:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:51:00 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:50:58 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 05/24] ARM: at91: pm: do not initialize pdev
Date:   Thu, 15 Apr 2021 13:49:51 +0300
Message-ID: <20210415105010.569620-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
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

