Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7F336079D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhDOKvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:51:45 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:1061 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhDOKvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483880; x=1650019880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gaczm4jYujlw82qtS4a93aXK/+MgYExxVmBklBssBb0=;
  b=ASKPmMpHU+CHKqgvxRAUxvll5DamD8v03c2xLZc8QE9Cg5Gb02dweSIk
   VI7y8Z+e30LGLKIvT63k+kvcdjATsm2RPZmN/Qg26gtSsSdQbjvuVbArc
   M5uJdY7PE3RbS5taBQEqOd3zLXR30N6+y+Pf2w3La4SrEbMJs4q8yHw45
   5sdSD4y2dqlmOP0mVZQouzEVoaM1eOlo2CbTJZVV8g8QClVZvR9XBY32H
   Dl10IKF6CrSplECiN+v5vDDuOYcShk3BI5CNL8298Eu5cq66kSvcH4Ufd
   3unJw5R2WzWgS5EWLVOoudMVmbuOgXRg3vqtMZlKXYkCr1hjpz+r2CvC+
   Q==;
IronPort-SDR: aLtr6bKYUnEGgNC22lBogQIBpMT6JuuDPtho3elgl3Cz3rBlvMjP2eYr010lXzewcW4QiWpYSD
 nfgl4EkQG0yjRviYIuMgZO8aX3KqpuF53I/LzJMYDBy7sxOnN3JGAT5X1jX/V/JDo51t+FKhlD
 2FGjAhVIblIlB4AWLpKgIL6jVB2IlSZrNk+8vVocl5Q4GHwBTu4H70RP9gtoVTlcqU/Vh36Jnv
 Vx70NVQRXjyfbnW67vjy12nkS+hKWfIKOgMA8Z+YbadS48FUbbP9As5ggt2UkzOdDCc8bgZwAL
 rTg=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="117122115"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:51:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:51:16 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:51:09 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 08/24] ARM: at91: pm: s/CONFIG_SOC_SAM9X60/CONFIG_HAVE_AT91_SAM9X60_PLL/g
Date:   Thu, 15 Apr 2021 13:49:54 +0300
Message-ID: <20210415105010.569620-9-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace CONFIG_SOC_SAM9X60 with CONFIG_HAVE_AT91_SAM9X60_PLL as the
SAM9X60's PLL is also present on SAMA7G5.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 960ad29cce51..1f63bbfad728 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -422,7 +422,7 @@ sr_dis_exit:
 	cmp	tmp1, #AT91_PMC_V1
 	beq	1f
 
-#ifdef CONFIG_SOC_SAM9X60
+#ifdef CONFIG_HAVE_AT91_SAM9X60_PLL
 	/* Save PLLA settings. */
 	ldr	tmp2, [pmc, #AT91_PMC_PLL_UPDT]
 	bic	tmp2, tmp2, #AT91_PMC_PLL_UPDT_ID
@@ -489,7 +489,7 @@ sr_dis_exit:
 	cmp	tmp3, #AT91_PMC_V1
 	beq	4f
 
-#ifdef CONFIG_SOC_SAM9X60
+#ifdef CONFIG_HAVE_AT91_SAM9X60_PLL
 	/* step 1. */
 	ldr	tmp1, [pmc, #AT91_PMC_PLL_UPDT]
 	bic	tmp1, tmp1, #AT91_PMC_PLL_UPDT_ID
-- 
2.25.1

