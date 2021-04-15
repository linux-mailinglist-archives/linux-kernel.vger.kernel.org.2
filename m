Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690D936078F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhDOKvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:51:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:63519 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbhDOKvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483856; x=1650019856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OekT/yOqa/XDBMBTQSpkviI/blzoLGSPwS38au5y5kw=;
  b=royqlor1NTzldOPs6WiPHHtkQemqa7Y+DltYMpJ39/P4nKq9deXkHRq6
   sqh5AMqasrNllZdSmTUsUyISALkYU7JVJ1NCYpu4kRe+uo4mSqDKmUsYP
   r7UG11HLh7fE94DSiks5hr6QL0/JdjqueJ0rDUBu4rCx+a7IFPJ2Ha/6N
   TldoIAAmR84dMVdVnyTgG8sRQl4SFS8UjcAV6DL+dqz162ETifTbxqNjy
   MFW4eBSIqDZyY5bHGwvMuQxGaxu6TsJQq1V4WrqvEJiTpnIg7VNo7ltZY
   rcddR/kr+iotD3QTfxNgoILze+Z/vChSoKSl4ADrwL+U4nKzHKkUjzVwG
   w==;
IronPort-SDR: E4Sd1DVwPfLTZiZPAwkuu96fhG1qhJGIV6Lr1Ip1oaZqst4/PnIdVJxAGHZg+Py3YbnrGP8BFQ
 dLLZ9Lp0tlFc0tzucQQ+PKhuMQvorlW7fHwFxdtDEvFG+N4FhJ6H67mw1gOH0JvTl+/sV6j0n7
 TIF8+L/q9hTHh8ZBzOP8ze9XFsQmj7hRt5QpRc0r5HekOKdLIRgLKmVWqzsyo8hi8KLUgEcSS3
 aLTVR2pFshovtUqR4Gs837KKXk9CnepL9pWjFr+L4jUkNRby3ggi5RSCnW+BSUXhfuv8IvY50I
 Bus=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="110922867"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:50:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:50:55 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:50:53 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 03/24] ARM: at91: pm: document at91_soc_pm structure
Date:   Thu, 15 Apr 2021 13:49:49 +0300
Message-ID: <20210415105010.569620-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
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

