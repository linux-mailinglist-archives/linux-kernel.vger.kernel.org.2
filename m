Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E22531C9E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhBPLgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:36:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:9704 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhBPLfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:35:00 -0500
IronPort-SDR: tjql7rZu4X+S36RD/tUdBPL5fKkCBZNQ8pfK+czip9WMM0AW/CfaVA9kv/CftQ3wxVcVDSUdB0
 NUXirgbdIe0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="169994421"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="169994421"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 03:32:53 -0800
IronPort-SDR: E4dmK1qGVWljw1TBOKO5UO9PynXj0wVJ9DaYYkt/h9Y5yAHwu6kjZ83Ym178pm/bUBqWfho2Kw
 lMOVRCkDhVvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="493161366"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Feb 2021 03:32:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7907C2D5; Tue, 16 Feb 2021 13:32:50 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Ryan Govostes <rgovostes@whoi.edu>
Subject: [PATCH v1 3/7] pps: clients: gpio: Remove redundant condition in ->remove()
Date:   Tue, 16 Feb 2021 13:31:50 +0200
Message-Id: <20210216113154.70852-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
References: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer along with GPIO API are NULL-aware, there is no need to test
against existing GPIO echo line.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pps/clients/pps-gpio.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 78c9680e8063..dc9ed6fc3dae 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -240,11 +240,9 @@ static int pps_gpio_remove(struct platform_device *pdev)
 	struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
 
 	pps_unregister_source(data->pps);
-	if (data->echo_pin) {
-		del_timer_sync(&data->echo_timer);
-		/* reset echo pin in any case */
-		gpiod_set_value(data->echo_pin, 0);
-	}
+	del_timer_sync(&data->echo_timer);
+	/* reset echo pin in any case */
+	gpiod_set_value(data->echo_pin, 0);
 	dev_info(&pdev->dev, "removed IRQ %d as PPS source\n", data->irq);
 	return 0;
 }
-- 
2.30.0

