Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060133BE2CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 07:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhGGFtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 01:49:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:50792 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhGGFtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 01:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625636785; x=1657172785;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cmqsEodKms/fD10AxGX4BEvfRnUcTVNo5CDdJElY9+g=;
  b=PnsqgDPfbo1wPLUsHGslPLD5oW/dUNkCMgEfjE0QV8T3hFIxetU//FCl
   T3oCzp9E6Y7t8zsvX3ODIf6pcF3bkqhR+VxzK3QYvrW9EK9YxL5eQsouj
   m+lOPOP7EbIJ25QQNQOa5HY4NSweusO9XdJc4Bfattg8AzKXNX7yrnQfi
   2zOAmtZGH+rL1kaU5uZXp8Myc1bVP+OJgJpL90e4VI0IJPGl1Ye5FYcxu
   l2ilpoGxok/moMDrvkEpkLDAi+vKE67IH0AmPwVH8Xe5xxgy1kZdKIT1W
   tbSNrrpRdfNh79X4jLwYFvBt1lLQbFs0sFDbrlcBnaKOSRm4ojMqfYIuW
   g==;
IronPort-SDR: Cva3iMmADSFcEUepES8UdB5bL7CnEuei2J9O7sGFKKVjZf6JfbluIVneUsV2F5SI7b8PA6Yw7s
 OyUYnheg7EOXqyMK79sCO5M8hy7xN7Y7WJBIYAOMc9vsRA+W3kJBdQWPDTip3/qkP9SREoJFis
 XAHMxnf5gvgQ4fNvZGSnfRRK0tO03VzAfX/KXUJ4YDgxslMFGVX5AZkYIYSbYWmJGnZ6VxS4fy
 qvPB1+NSvDAtFf5uylP37Fx3TCVL73u87ZbmbtyVnAHcXyuaaIq3Wca37jwIlA7Q4VVWtD7ae1
 5wM=
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="134861712"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2021 22:46:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Jul 2021 22:46:24 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 6 Jul 2021 22:46:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] clocksource/drivers/timer-microchip-pit64b: remove mmio selection
Date:   Wed, 7 Jul 2021 08:44:14 +0300
Message-ID: <20210707054415.92832-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PIT64B timer driver doesn't depend on CLKSRC_MMIO since
commit e85c1d21b16b ("clocksource/drivers/timer-microchip-pit64b:
Add clocksource suspend/resume"). Remove the selection.

Fixes: e85c1d21b16b ("clocksource/drivers/timer-microchip-pit64b: Add clocksource suspend/resume")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi Daniel,

Please let me know if you want to squash these 2 patches together.

Thank you,
Claudiu Beznea

 drivers/clocksource/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 9fa28237715a..bddeb664e517 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -699,7 +699,6 @@ config INGENIC_OST
 config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
 	depends on OF || COMPILE_TEST
-	select CLKSRC_MMIO
 	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel
-- 
2.25.1

