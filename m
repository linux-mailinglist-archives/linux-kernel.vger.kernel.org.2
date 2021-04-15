Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33993607C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhDOKx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:53:26 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:55011 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhDOKxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483970; x=1650019970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kSpQpv98sh3osaRVrIiVAdt+VOG++l/L01AbZfP6hA4=;
  b=a4CI7zzzKM5GKAUZWwYrs7sSom9BWf7gTdreQNHjPgYY2/Hk2s8cGBmD
   LS5SnHjpiicpdon/WbTA9XlYkZvbPf05FmDXN6ReAjFt1BKIb53LxBuG1
   vwxxMZtDfcgldCmDF5Vq0gjDQkPr9siAxatGI0gr/RXCfDf/QPkF86SHC
   cUC/3RjyrIR7G/lVBUPe9586oP4sqlGAPsogkRSlyiVd+Wp4/G+V8NVoF
   /SXS6zK/kZzg+OYr5Ws6afTifF0A42XI0Ab1nzDQJmkHCGWvHp9mHih6K
   FFMXVZWuqydUbWFyw4UrfoNl/hwuUuVWMSVEDq03Gze7ts4m53C4xw1xn
   g==;
IronPort-SDR: wzaoyz5ZxuGfha5Uk9u7i2qc1njj3Ernw1OKLNcNBcMLNRlldWDU/J7E3sbit9rMFNvm4fJig1
 h2r5XYArn8NoAlt0O6H5TlDbBbOj557qiec3UmzRkwmqHbJOc6/MAN3sTcbnHiMgFhqfuJZ/vS
 V6ZVdJ/W7X5MWDQNXBakRo3SP0Kv5d1gWJHra1+EU13ckvWkmww+IvniUR+L4HG0a0lIFUhs5S
 PaQB9abZ6RMVsKyXt5ysvo9Mjg8OQzbDmpkf5La75ODPDjorq33gozqo8zy64We6944Zou0oYO
 UhY=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="113688736"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:52:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:52:31 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:52:28 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 24/24] ARM: at91: pm: add sama7g5 shdwc
Date:   Thu, 15 Apr 2021 13:50:10 +0300
Message-ID: <20210415105010.569620-25-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
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

