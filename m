Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FE6357294
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354469AbhDGRBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:01:45 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:63109 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDGRBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617814890; x=1649350890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qRtCMGFGRkjuuWRlWSCNIxsSTEDl3YJPep2Zn3FPUF4=;
  b=Gves57qvUh00CUUBlo43+bPx1pfXMbtiNZ0M737jT0zhzZ6T9OoRx8ew
   hyhHnGD2UarvubKE6c9dDKn2/k/TgCdY8yPmUl6+KGRv6s5u2Hy+vdmp0
   I+LBi+fUP7RJs+1KTRgkJmhrjowKU2Ce50VhFTRgdaRnEg1Rb75nLCzfM
   ukV6iBml7Bg9KHrRuuBhju55kBQFySiI7SkqdrXPo7wv/Y7z5gowcqscm
   au9FX7ZlVFtcDvn50VArLlnl73l5tgaqUPCX04vmivHiD5lSEgrt6Wfic
   VafORmnqcDea3GdE+65eEPqZ2e+A0UUvnqNF2X417a2ctSyh52GUgEKUc
   A==;
IronPort-SDR: xtzIbm8agCFPYDcj50OTrFLE34GEU4biw3LFzgK7R2o56GEV3m2CMXyMPMciWWdSeKIZr6Qlle
 w5u41t55MumJaLsBL6UMf5sd6jCuocBb4gdsWjN5oclfXN2PaBUa+Bgd1Ljp3ROK/RTw4FYYyQ
 RRv6szToaIX/Y+XGPmPkY4Nw/0AfRsQhpps33Ek6vli9J4dRfcCtvBbND6otGgLJDSjkjBGOOO
 3CWF84k+VgtTpY91YTKDKtew1COKHdkDFiBql4IRlzv0wL/iMCzgG2rFxsDCzzaWUrhVY262Rh
 T9c=
X-IronPort-AV: E=Sophos;i="5.82,203,1613458800"; 
   d="scan'208";a="50327743"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2021 10:01:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 10:01:29 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 7 Apr 2021 10:01:11 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 3/3] ARM: at91: Kconfig: select PLL, generic clock and utmi support
Date:   Wed, 7 Apr 2021 20:00:53 +0300
Message-ID: <20210407170053.298056-3-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407170053.298056-1-eugen.hristev@microchip.com>
References: <20210407170053.298056-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Select PLL, generic clock and UTMI support for SAMA7G5.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/mach-at91/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 5eb2a9206f42..f52b46bccd85 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -60,6 +60,9 @@ config SOC_SAMA5D4
 config SOC_SAMA7G5
 	bool "SAMA7G5 family"
 	depends on ARCH_MULTI_V7
+	select HAVE_AT91_GENERATED_CLK
+	select HAVE_AT91_SAM9X60_PLL
+	select HAVE_AT91_UTMI
 	select SOC_SAMA7
 	help
 	  Select this if you are using one of Microchip's SAMA7G5 family SoC.
-- 
2.25.1

