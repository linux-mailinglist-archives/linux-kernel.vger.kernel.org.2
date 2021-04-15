Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC51F3607BB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhDOKwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:52:44 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49733 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhDOKwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483939; x=1650019939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8kI0413I2spxGJDHxPyI3JVC2W8j7DJTYYAyAAjaxbY=;
  b=AKFbPesfWDeolyoN/jqhVTLVCMuK3h/zf2UwICmBiptQ9KyE0eBDGiT9
   AAMvW11ONrXnDi7HJvlY8EjHjNvw8/pPJ7haibGtyuMp/aliRqEdDJz/p
   0M/HZfs4Xe0gZTMLLb64dECqCOHy0v4H/yu1hqGfdg9YLuK19gUkWAPk0
   UOX511q3v0dtxJlygHuzHVTKPslT2VQMZLWLRD7KkhuizU3ebqf9R7zxR
   h8N9klSINNpRZ/8+GwCdnnBXVYAOItd4+ZmXPh3eMG6oRWAqGsi8LFzHC
   M1mcWnvjOT4l9ITPmNCHH6LlRRy6KyVhCvuKQD3mVgSJZZ3Ut3pD5Tuow
   Q==;
IronPort-SDR: a44e7uxWAIXuCijQXcr4wk+RNpc1CRF/wK3pKMYSVM+kP6m7vEf9rIqme7eAAfoMCQzCLCvLgo
 HQXbYH1lpAo0JfDT8rBl9Ot4ZbGse8LmabVLYn2vPRIsBPXrbdj1EnLHUV3HUQNqsNUntThqBy
 0U7WZ3jLES5h/GeQ/8ZfYLwtXBFBmq2s6vxAQ69DTa5wrjssNscUYTrRThy3PAjYmR8KRu32zn
 6XnXqao1mYvmCSi9Ra5RKA2JhL8ONgY+PV3GY7HKRrW+fXkAv/2twqUPPgHaUCR8xLgV2m7HRV
 DlM=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="116551855"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:52:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:52:18 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:52:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 21/24] ARM: at91: pm: add sama7g5's pmc
Date:   Thu, 15 Apr 2021 13:50:07 +0300
Message-ID: <20210415105010.569620-22-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
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

