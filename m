Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A69B359CE8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhDILPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:15:03 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49446 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhDILPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617966890; x=1649502890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OekT/yOqa/XDBMBTQSpkviI/blzoLGSPwS38au5y5kw=;
  b=RjQq3yY1+y2goOx+G5XBJ2Mng9joSTjU9ZZ4BGQXdLfy0OQbCaKN18IL
   wE0kNJGMmGIpGiVzjTJu7Gy0OcwGockMwLT4sjEwxEq/DJ6Kai5kOwOw5
   cprBOeoGSjp4sVJZhlm9O6sABTVhCjPg+KOArZXW+8kvS9uKRVbj1F1ua
   NEuEDs8vXuvCHeZ4l0JytBGM63sj1l9/SVeAOKeIAx9YImKl/7lWe1Hcd
   owVFwa7DAWjgFNCCtdQJeWMjulWAV9+BRa5yJ1g69BlMO7T68Sbv3Aeb/
   NZw0Zo1wWtvI2QIzBlCBUCaEIQCHHo5E2xRVhFX4ViuIWGsIjbwwD4nUd
   A==;
IronPort-SDR: tZkR/CoUqlo/qc0GXFLPzMhIvjwNP1/+Eh8dneyC/WlWoCxzSa4/X7vjwuLgee8cfOijDYlFfa
 9tS74mTjzlKPJ18pNPRqIJ04UqNogpOyOh+Ix/PSvj4DuxMZrHf4RoU6eGFYp/sk1cQ4OekPHr
 zDUmRiKPDlexvsdq2CgFlGoTh1nWrJdrTebvTH3ryjgS3rmjjGuKXKw20wCrV+OYr7oe8fXWIJ
 R8yu/t9sY0nyELrvfwKrVRTZPBZzluuhqqmNc4Q5MeO/O2o0QRrVhzcZJmkB5okLR9AzGqCb9S
 DPg=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="113022324"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:14:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:14:49 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:14:41 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 03/24] ARM: at91: pm: document at91_soc_pm structure
Date:   Fri, 9 Apr 2021 14:13:24 +0300
Message-ID: <20210409111345.294472-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
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

