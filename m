Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF35307403
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhA1Kqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:46:48 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:60695 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhA1Kql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611830800; x=1643366800;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D6qNV/vjZeiLfEcTt/3jdRVcFKcoTBJFa2PCRv2vvKM=;
  b=PZnbuS+6Tn/l3+Z4QVzvfvl4D/qrCMyIK/iPtBwUoS0sLUmdGos4J6ht
   U1xT90xG5962yMp6xhTUVlEbsrhajyUtDxS5xwGVWUlB4v60FpW7BcM0c
   PQbgyHMRpIoPhyqhcA+vGEED2MlwGxo9zl4mVvyugUsYD94qSdI/ukh+i
   h6wLT2aXS546RRYLrPY9U9guckLNRxrHoA59vL5tWAJMypTc3zOn7l6Gy
   6fa7IzWCkrWrr8G0+9VSai/fB4L0KTdQmAXEuZrr45fE0s2W/Iya1PZh2
   6nkILAGMHAuRJVYJ8sSWjNpkYZdTbuyd3+NzKNLrrhTwoA9BedynTJyG6
   g==;
IronPort-SDR: zBEaE9xo6X1i4YoEqKr+Gu/A4ObzZMwCBJrEaFOqnnWxJCvvGfnXSCZKbNbNGakN1eRVG+ex5p
 EY5qoedEjlJolArCoYzU7CTBwPe2MgiXTGk6k75kKK26pSNgnZGdqwVrCo+PV0wPKZGswPFyXI
 L4h8PZnDPo2x79PixPPNjOcccOzcnwek4Qc/bINMq9SBMzAY7d1cBt5gdjJewrhzvI5L9zSSBC
 Jo9jZ32Y5m6gTgGimj46QFl+by6jVLs8l2JKQ1iSbe4iNf1n6WFx3FetpUS2ZDgJVzakeEdWYE
 EBQ=
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="101743811"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jan 2021 03:45:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 28 Jan 2021 03:45:23 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 28 Jan 2021 03:45:20 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <claudiu.beznea@microchip.com>,
        <mirq-linux@rere.qmqm.pl>, <saravanak@google.com>
CC:     <gregkh@linuxfoundation.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] clk: at91: sama5d2: Mark device OF_POPULATED after setup
Date:   Thu, 28 Jan 2021 12:44:46 +0200
Message-ID: <20210128104446.164269-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sama5d2 requires the clock provider initialized before timers.
We can't use a platform driver for the sama5d2-pmc driver, as the
platform_bus_init() is called later on, after time_init().

As fw_devlink considers only devices, it does not know that the
pmc is ready. Hence probing of devices that depend on it fail:
probe deferral - supplier f0014000.pmc not ready

Fix this by setting the OF_POPULATED flag for the sama5d2_pmc
device node after successful setup. This will make
of_link_to_phandle() ignore the sama5d2_pmc device node as a
dependency, and consumer devices will be probed again.

Fixes: e590474768f1cc04 ("driver core: Set fw_devlink=on by default")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
I'll be out of office, will check the rest of the at91 SoCs
at the begining of next week.

 drivers/clk/at91/sama5d2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 9a5cbc7cd55a..5eea2b4a63dd 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -367,6 +367,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 	of_clk_add_hw_provider(np, of_clk_hw_pmc_get, sama5d2_pmc);
 
+	of_node_set_flag(np, OF_POPULATED);
+
 	return;
 
 err_free:
-- 
2.25.1

