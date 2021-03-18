Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2139340645
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhCRNEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:04:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:30418 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhCRND2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:03:28 -0400
IronPort-SDR: rNKDf5Ixby2E6esleoxwlh4iESCR+LQ3Y47xFr0bf/1AKv0pZiQWVTaqlv19L4KEn1XK489IIr
 ODRm6L2t1eYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="187310741"
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; 
   d="scan'208";a="187310741"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 06:03:25 -0700
IronPort-SDR: Bu7g2B9NF3VfUAt1Qm7eYAGJ8QaUs/YBnliSjGjFMkMOGA48awAjVJITYPx4+N4GojBi4A8GQS
 REJcsIR3R4RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; 
   d="scan'208";a="411885195"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 18 Mar 2021 06:03:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9780629A; Thu, 18 Mar 2021 15:03:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 3/7] pps: clients: gpio: Remove redundant condition in ->remove()
Date:   Thu, 18 Mar 2021 15:03:17 +0200
Message-Id: <20210318130321.24227-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318130321.24227-1-andriy.shevchenko@linux.intel.com>
References: <20210318130321.24227-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer along with GPIO API are NULL-aware, there is no need to test
against existing GPIO echo line.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
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
2.30.2

