Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1400134FEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhCaK7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:59:54 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:40036 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbhCaK7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188360; x=1648724360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OekT/yOqa/XDBMBTQSpkviI/blzoLGSPwS38au5y5kw=;
  b=JSQK4gBBwR5e61xuJVqzNGQR45NSaAcKWiBBv5sQv5g6FAddRajLeFS+
   zkKucFC3EXPLk1DPp/Zv9r/SfbrEwHBpz6aoYkP0W08CpWqVJSRlBdoE1
   tnOiKZgq0CJLiXRO2EZLJ2Sl16uxuB9/5k7N2W30HGjdwmXJlH1tefQAr
   QP3uWNjtSEn9y/lEjYZ7QVVcrw607u4+81uGvqtKe0PIMufI7Xof+O8dG
   ITXoNRZ7HogzwahhMAqnkAlp4i++IHF7XSIoP9T1DWKqa27PHc7MrDvvd
   Dehm5DFp51Jbb/yPyuJwrlyZBlt8FEqoRrWj6Iqpf+Z1KENckthMMYe9P
   w==;
IronPort-SDR: 7yRVCt7kbkjhV1+qggbA127sh+ErT6RgZNmCJQtyZCQMm0hT7Ivm2qUnZCSwDFFc9T4KYTuV8u
 6iAHtjoJWBCd0GlhiPpuflPWseWkFQP1C+9KdLIgqwhotxty47apkbXFqaLN0am6fEU2cFbP9G
 vfPKnWZrB2CCShc1A+fmT69Fu37sr/8Z1oE5J2tHkWG+MO0Ap58zp5NqcD8PDj8lA/1RO2rsC6
 lH8tNNE2XY7Ui/Zh09sREiMHoRxiDqiZzwm3LspPYMnFXRd1d4gqV+4OVvUjHeJUqx/Y7jOiw7
 1Gc=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="115333291"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 03:59:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 03:59:20 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 03:59:18 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 03/24] ARM: at91: pm: document at91_soc_pm structure
Date:   Wed, 31 Mar 2021 13:58:47 +0300
Message-ID: <20210331105908.23027-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document at91_soc_pm structure.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 3742a1fb76db..3029351ec78e 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -41,6 +41,14 @@ struct at91_pm_bu {
 	phys_addr_t resume;
 };
 
+/**
+ * struct at91_soc_pm - AT91 SoC power management data structure
+ * @config_shdwc_ws: wakeup sources configuration function for SHDWC
+ * @config_pmc_ws: wakeup srouces configuration function for PMC
+ * @ws_ids: wakup sources of_device_id array
+ * @data: PM data to be used on last phase of suspend
+ * @bu: backup unit mapped data (for backup mode)
+ */
 struct at91_soc_pm {
 	int (*config_shdwc_ws)(void __iomem *shdwc, u32 *mode, u32 *polarity);
 	int (*config_pmc_ws)(void __iomem *pmc, u32 mode, u32 polarity);
-- 
2.25.1

