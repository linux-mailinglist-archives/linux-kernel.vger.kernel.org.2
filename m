Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1313A360796
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhDOKvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:51:33 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:54803 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbhDOKv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483863; x=1650019863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EMydS6SpF+3ky5OFGHF+CX/2ifm7LJRo+KdwzVglFdE=;
  b=UcXmPdfb7I83JdShKO/0yZE91jY93hqQtzD7koYcx8i/J7joKUCh72qE
   xkFwPRYwfpdj/fxgKAze/ZZIwwzmBsagdxHZ8yJYJ9JY+wKZutsF3HsTI
   KbQYNVBj8k1WSnJpjEGKsugLi+MBiZgDlFxCjhLuEtT8W7oa72ASAKpV/
   yJBuzB4IXH7bRapZrpcYEQRBL/b5ZUPg3WRc6E+qmM4Oz/LBzF1h1xEgd
   HmPzhdUZDZCre2CF0TUiowrBsEZl9iTiIChWtmqk8dSmwEUQXoQhI8IJy
   4bCrDKzPWergKZVoqelCe9LFnTYOeybxcwQejQdMcbExTocJXPmpCz0Fz
   Q==;
IronPort-SDR: aNPeE1F5hCsUQzeED8p3GY5b3eJnDySepGq5BLmOM7Qk0q3wv5DO00/atzFKKeS9aok5xldc6i
 FmIE/0KEyi4BiK3C7k/AYu0s8toQ7oamM46D8bSpAhl1md5mfQZ9CtDu6YGMgSoCdBn1ULF4E1
 OMicRTsSFIuxg+1vQxxMtvfhpkSI9OrbaadW9C4UMRd3J8GP/FzALqGlkIXAEhvELLjXB9yzl0
 rLm20N7f6tG7sXn2eqMldOfMRXstnBUJmngc2/lh6aigkmKWETz/0Itnyrw0kiwqQ5Sd76UwbE
 MtE=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="113688131"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:50:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:50:52 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:50:49 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 02/24] ARM: at91: pm: move the setup of soc_pm.bu->suspended
Date:   Thu, 15 Apr 2021 13:49:48 +0300
Message-ID: <20210415105010.569620-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the setup of soc_pm.bu->suspended in platform_suspend::begin
function so that the PMC code in charge with clocks suspend/resume
to differentiate b/w standard PM mode and backup mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/mach-at91/pm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index e13ceef7ac9a..3742a1fb76db 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -214,6 +214,8 @@ static int at91_sam9x60_config_pmc_ws(void __iomem *pmc, u32 mode, u32 polarity)
  */
 static int at91_pm_begin(suspend_state_t state)
 {
+	int ret;
+
 	switch (state) {
 	case PM_SUSPEND_MEM:
 		soc_pm.data.mode = soc_pm.data.suspend_mode;
@@ -227,7 +229,16 @@ static int at91_pm_begin(suspend_state_t state)
 		soc_pm.data.mode = -1;
 	}
 
-	return at91_pm_config_ws(soc_pm.data.mode, true);
+	ret = at91_pm_config_ws(soc_pm.data.mode, true);
+	if (ret)
+		return ret;
+
+	if (soc_pm.data.mode == AT91_PM_BACKUP)
+		soc_pm.bu->suspended = 1;
+	else if (soc_pm.bu)
+		soc_pm.bu->suspended = 0;
+
+	return 0;
 }
 
 /*
@@ -296,8 +307,6 @@ static int at91_suspend_finish(unsigned long val)
 static void at91_pm_suspend(suspend_state_t state)
 {
 	if (soc_pm.data.mode == AT91_PM_BACKUP) {
-		soc_pm.bu->suspended = 1;
-
 		cpu_suspend(0, at91_suspend_finish);
 
 		/* The SRAM is lost between suspend cycles */
-- 
2.25.1

