Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9736334FEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhCaK7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:59:52 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62343 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhCaK7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188358; x=1648724358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z2vx+W7wZ3vJRHaEIqF3VSSUNclF5faqDVFYtB0zBng=;
  b=Vj5o/05EZroWhR5m7uAdBWU4Qd9HyAS9yA8ni4gTJFVnb3VdLFzLrZLR
   0WFriQbNj0Y1Y3m1ViEMbG6QixffbhXLoVWbDfv7G7qqLbTMfq7fKiOOn
   gCZJkZnXGEm0NXkOby2S0BpGNFV7TtGScYWZ5hMLdT7Xy2F1EYpuI6Kkb
   xDMAvTSG7qj4/nM3a/PKiLYJuZ7R0X7QCO6hFaaKYX0frACKuI3kxSJVu
   26C9A+49HnXOaDAvgq/Lg+qSwKaC3P/aPeAsHDykq2BZVT82eQgQVeZcP
   w1erCn7c01hj8zW2ayMxkA2UNnA8viGWneCUKA8scZMLGa2AWV4QOBmNk
   g==;
IronPort-SDR: z+HlOVFIWT9mOHNdolpXmDSGrcoGnhjDRab0rwH/WmWOpU7Fj0gK77iTWQR5DbnmeIBMiGuSQG
 c0Aqv44VsFOm8zA8zUW4NC8W2U5uRBv/MUVLooXKD58At1xJnnqTGU9cNRwHgIz5HOAlaQg1YA
 1v3wrhwz0+t6+ezDd0ZuJS+I6I1gc87RQ5HcqlZyqxBIAqfS/GSY4lGXi+dC0qAZ4Bq9aIEzUL
 bocLRt9njaehy1rHXakSwZJMOGQhOwpHFjSHIt0yMgNZJb2VH3YcrRcuQAB89k9lGth45DTlAa
 TpU=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="111996544"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 03:59:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 03:59:17 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 03:59:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 02/24] ARM: at91: pm: move the setup of soc_pm.bu->suspended
Date:   Wed, 31 Mar 2021 13:58:46 +0300
Message-ID: <20210331105908.23027-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
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

