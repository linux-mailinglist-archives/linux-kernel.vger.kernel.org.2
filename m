Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B69334FEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhCaLAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:00:11 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:43913 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbhCaK7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188373; x=1648724373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gaczm4jYujlw82qtS4a93aXK/+MgYExxVmBklBssBb0=;
  b=V0lWviY7gi5um0JPXjkvWJIGY9J9Vbk+k3XFq+GvqP+GXrMzxS4hPByN
   8vCC3XqlA4+fVC05xAes8YUwrjRd+XPdtU9BsoJIjrg9Vw+48w+Xzg3R1
   jS8uW8vCJP1FjDG27IwHjIS2I42bgqC8KyIgFDyJ6HlSriCcz7jUDqOxe
   nNURz6Zqe/mcRaoRPQ977CGsv8h/Yfp1h7lIkUn2zaCZSu1m8T+1POkyN
   xL2Jn8M4VdDHeA3alRA2DT/RjDQ7PffADtXtQr4gH/98gxHNEWn0YYKm6
   etztYPU9qGikGuMCFijTR+lUs5ghM9WBh/iFqjnteZ+gIvFOJjFXahtjr
   Q==;
IronPort-SDR: wHNZi9re5DUG4FOk2n6mh8ke6BbKa2t1/VynAJLeGX6pkEaYNeIr/OWWQKuSLaAaJ+ckezWUsT
 nWw6HF+oKPoT5lR8KYRu8or3Xza/m+2sinVFyNocmf5YSZaAoskROi64wvl+bJ4VUnbZz6ouZ1
 TA1h6mRUnldfDJ3CLC9UrnrKpPzbdDgoZZopbErJANVXLGAcyY1TFHEDHOCg81dYFje+p6SIWH
 IfLOWhqSaZVbVtS49TbXSppg9a7bv7KwdSsYuoApNOlGt65OrB/viUL0l0sH0CEuWA0l3lD+yH
 HkE=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="121233923"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 03:59:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 03:59:32 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 03:59:30 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 08/24] ARM: at91: pm: s/CONFIG_SOC_SAM9X60/CONFIG_HAVE_AT91_SAM9X60_PLL/g
Date:   Wed, 31 Mar 2021 13:58:52 +0300
Message-ID: <20210331105908.23027-9-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
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

