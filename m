Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7F359CFC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhDILQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:16:40 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31314 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbhDILQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617966982; x=1649502982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gaczm4jYujlw82qtS4a93aXK/+MgYExxVmBklBssBb0=;
  b=R2cygRCFenshUgoT6bHo9bIKCbtwBbnOFLNG3RsrI+Yfx7qs5UN88j4+
   ecOH71rkX1y+NPaqJwUmjxmQNvfW/5/7Ae05/JhJVRkyJ5YYIt9MyC973
   RwRSgADcwSUzHPw0rYL2grL7sJIgwiNrLx3DcIFjQ8wVyHfISjzikaNTt
   UXecwzS+iZXchF94q5doeIWrxxCf4d2Niluya2Kj2MDaXm65kncgn3c7N
   5po7DE9Y+hF0kUjXwkbQzsVo7OCvqlsdt/7NCUXBlZJYKNY9ZbcaL58Fm
   I9w9tqFnxfYiVRC/Bx8iQlcVaj/Qi85S/rEqINWN45SgGatguoDA1u3UL
   A==;
IronPort-SDR: baXpunbK451V5Ul8OWyAddrnoDoeDUMA+kWYucOJgP7J0aTfTyZFj2tpelwl2B3k7wEhnt4kfx
 tl4ZFWZJdSwHidu0o7kmXtmFxdzMf2QWVkYfW7rbKgiEbwJNFFMkH7LFDd+DSG+jc9MWTGj+hS
 n2tR3naSAA5fz0l7kNhJqSYg08p1bR33iOw6LRv+dC/ePMNivIs83nXaCCZ+iM/q0F7o6cGtWs
 elMfsv8G0bCnIHsd1RSznpYh2V1eqUSlWvzeL9D+KC3eYy/LAPdeTfuYJ/j0YqjUuS0BrO4qC2
 h1Y=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="116427638"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:16:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:16:11 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:16:08 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 08/24] ARM: at91: pm: s/CONFIG_SOC_SAM9X60/CONFIG_HAVE_AT91_SAM9X60_PLL/g
Date:   Fri, 9 Apr 2021 14:13:29 +0300
Message-ID: <20210409111345.294472-9-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
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

