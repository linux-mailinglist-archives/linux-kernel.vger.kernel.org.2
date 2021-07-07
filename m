Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4BB3BE2CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 07:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhGGFtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 01:49:07 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:40428 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhGGFtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 01:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625636787; x=1657172787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KD9IDIgvJIqlhrE1l7TabFcKp5xF+Y60IKcxr0rkf+U=;
  b=TVYyGb+JUjqQP3uJieeAR7oXM5oUe/kOEVD9hkIpAZUDAIh+F/Wy4RfL
   M2lv0L3GUdlspfkeeph/sy6Vr0wqw6m80C/nSlTUpKN7MoK/g/UiOGfTC
   4hDpPeNUvaQ5m4jaekeigTU7vWNMiyxqoSHEh4hl1aTyJ6YOu3BJ2lrcr
   lFlnqe+z5XeFOQ/KKkS/QwEzfsti3ykv6MJTag2Ra8eTtJ7VJA/hIWMnr
   Tm4fsE1/WrAppNeIyeHATC5xj07p6MA1FMkKA8bzCoDhnyrXyZijbTCZ6
   glaLvkk8MGrSUtYPqMOXH207hx0KYJ3Fg6VOzfbOB/p3IJrbIGfQpiguE
   A==;
IronPort-SDR: 0r3N/mzcvnrT5dosuMy0FIxp5M9OSTHriJiuswEUsrGxc+LwpRKE9HLqifvtzNa9gg9+qPqud3
 1kVDZ2WvmCOlt1ojLmrguU8wj1d1o93WxRUdPeeTQvGtgsrUp/C4+tylmulHVSKRmJlQLom2jE
 t+fhUQckcUL/H46pY8w429xzZNByaccpu7v1NEd9Asw0luYaCVEqYJtrut4UnOvMXpTLT7EzFM
 +sut9gJD+RHpFkbkKdyhm0zD9tKNxLddB7s/rJEUR8BBLgVnNyvijidd1yuUTUpj1mqu6PalxY
 Gu0=
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="127908047"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2021 22:46:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Jul 2021 22:46:26 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 6 Jul 2021 22:46:24 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] clocksource/drivers/timer-microchip-pit64b: remove timer-of depenency
Date:   Wed, 7 Jul 2021 08:44:15 +0300
Message-ID: <20210707054415.92832-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707054415.92832-1-claudiu.beznea@microchip.com>
References: <20210707054415.92832-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PIT64B driver doesn't use timer-of APIs. Thus, remove the selection.

Fixes: 625022a5f160 ("clocksource/drivers/timer-microchip-pit64b: Add Microchip PIT64B support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index bddeb664e517..c50fd70b759f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -699,7 +699,6 @@ config INGENIC_OST
 config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
 	depends on OF || COMPILE_TEST
-	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel
 	  based system. It supports the oneshot, the periodic
-- 
2.25.1

