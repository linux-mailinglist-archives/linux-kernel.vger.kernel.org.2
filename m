Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FCB359D0B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhDILR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:17:59 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49727 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbhDILRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617967057; x=1649503057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7KxROLHftHxojszu7kto2DqA+KMwMJOPHCNZ1DYkUlo=;
  b=gcQLhNr+HgOv83+1iBIuGxt/L3KPjhkjJBUuH31dyzcIrKRNS/mfuYLt
   Nb+7ybnoM9S0R40jpbeImvpLP4t0ZJSDomscJiO94iiiMvf5+OJsQFkkn
   k/4Gs8wS5TR8P3weulWn7KH1CetobDlk1KCvSJd5Smzuze1Bs40c1aJEr
   S6rgmvIgKu2MwF6j/BAc/5A+tfx3ARfbwkglz/i8S/55/B506qeoyDkEc
   xnv3ljpHIpKmJZ9wQGrkULz4LwZwT9IhESF7esb/BXHmv3o58MD6j5fvB
   452N4Tj/ZKW3C8cpoJi6g2gLS4qtTaDpSMFLClcGO3DvTZb8XaPWIWepb
   Q==;
IronPort-SDR: KX6jBs2HFEbi9n0Lx5fU5m1iiLDapwzcupqUGRo8LBt4GwWAGjlfgKtIf7FbisDxH8MAHSwMUw
 P6sHg2uWJMXA9lEEkCVovjkfOUr752vAL3WbaVSexUWoNnnN6NrmKIKCB/sn9CgXh1f1mCJHE0
 LosfCkFb/DHEc9YXndoLI+bWV/XE3/QjkVcb2Wnhgmi9r5j4hmUvWfGSPIzx4EhBtqrMjqUnfL
 X2ZHiAj/3RIhWnkpHTKJYAO7xUXvZFjRSQ/Ti1Sjx4UXj8cUgCBc0kbC0pe6gBa6OyxeV2LxKx
 TJ8=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="113022631"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:17:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:17:36 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:17:23 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 17/24] ARM: at91: pm: add sama7g5 ddr controller
Date:   Fri, 9 Apr 2021 14:13:38 +0300
Message-ID: <20210409111345.294472-18-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SAMA7G5 DDR controller to the list of DDR controller compatibles.
At the moment there is no standby support. Adapt the code for this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 65e13769cf50..5dc942a2012d 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -548,6 +548,7 @@ static const struct of_device_id ramc_ids[] __initconst = {
 	{ .compatible = "atmel,at91sam9260-sdramc", .data = &ramc_infos[1] },
 	{ .compatible = "atmel,at91sam9g45-ddramc", .data = &ramc_infos[2] },
 	{ .compatible = "atmel,sama5d3-ddramc", .data = &ramc_infos[3] },
+	{ .compatible = "microchip,sama7g5-uddrc", },
 	{ /*sentinel*/ }
 };
 
@@ -565,9 +566,11 @@ static __init void at91_dt_ramc(void)
 			panic(pr_fmt("unable to map ramc[%d] cpu registers\n"), idx);
 
 		ramc = of_id->data;
-		if (!standby)
-			standby = ramc->idle;
-		soc_pm.data.memctrl = ramc->memctrl;
+		if (ramc) {
+			if (!standby)
+				standby = ramc->idle;
+			soc_pm.data.memctrl = ramc->memctrl;
+		}
 
 		idx++;
 	}
-- 
2.25.1

