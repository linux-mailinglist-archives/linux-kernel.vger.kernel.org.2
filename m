Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B16D34FEFC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhCaLAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:00:50 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:28755 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbhCaK7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188392; x=1648724392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4BQZ/iTmn3jDQYiKb3oiGkOU5qXJu63VT3CwhT9FgTM=;
  b=atupuNRiyaYK2L3oaDxNk8JbIlz4oi/DINNaLKy7SxI8P0c3+aEya1ur
   PclKTgUPMYBZ+rOdkZD0F9X8y813Eo4TSTDuDa4hfa2LWuIdBHcy7gppd
   w06wTGKAFoE+p9YeSZihDbdn1jJXgm6aH05BuIXBaX9L8XrSDovBdfngf
   X9rykK/UOG1EcGFF6LtaUoY8Ex18CFA9zJx9lpHrzxSx0WsmuxjnK+4pY
   d1tWA4cxJDu9fmH/Wl3WQ07nK8xA7RRZT7GQLQ6t9NLObDpOsAUB/YMBL
   sJnH3h/FrOUP7LrWRovB0IrbsMePqRryLj44x9F3Xei/q7mLIpnwJ9dqJ
   A==;
IronPort-SDR: qiwHCcUd3Ap2D8kT5N+7Vu74ymEvZ4iVEkAUBmrfpkgCi51Bg5kNFdJTeEQGITA42b6ziZGiKK
 62ywG0bLqMGkvxG0hPPzqUZcuBvJMLbYMourfVQ26WaBaQ0pQt8tp0NL8yBG3RVJCjsneHFOOv
 ZBvSPeB8wnkrgv9MuX8l374TyE3nkDirHgTd/DODSdbGQzULXhbrCJYWJXKCpdWjkFbqmU/81R
 TqrEtJwHFR3DCH1u/iiXZc38Oa3EtLqieGtCGc+FvFWRD2uV0GraiHUZcHJtxlumu//QreMvPY
 IyQ=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="109198810"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 03:59:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 03:59:51 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 03:59:49 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 15/24] ARM: at91: pm: wait for ddr power mode off
Date:   Wed, 31 Mar 2021 13:58:59 +0300
Message-ID: <20210331105908.23027-16-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wait for DDR power mode off before shutting down the core.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 9c9e08fd8300..7396e18dd7e5 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -980,6 +980,11 @@ ulp_exit:
 	mov	tmp1, #0x1
 	str	tmp1, [r0, #0x10]
 
+	/* Wait for it. */
+1:	ldr	tmp1, [r0, #0x10]
+	tst	tmp1, #0x1
+	beq	1b
+
 	/* Shutdown */
 	ldr	r0, .shdwc
 	mov	tmp1, #0xA5000000
-- 
2.25.1

