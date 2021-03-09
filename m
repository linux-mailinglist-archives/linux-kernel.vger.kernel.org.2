Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FF23323E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhCILYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:24:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:41542 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230143AbhCILYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:24:22 -0500
IronPort-SDR: srbLZq1z1PzsKoqaAXEaWW6CAZH/1UjZFMtctOVL9A9lkG1znLoSrmICI5hdN2tdnHOdgMUsoA
 A+jqJF8cYQrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="207987902"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="207987902"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 03:24:20 -0800
IronPort-SDR: iu3pPFhufT3eE8F61ZkGDSuw66Ee6s2XXS5pblTWjohPH3I5IInaCRuIYPbe9aLT26xyQaYoNo
 50L6MFVbuDPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="408609069"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 09 Mar 2021 03:24:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7CE53490; Tue,  9 Mar 2021 13:24:18 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH resend v1 3/7] pps: clients: gpio: Remove redundant condition in ->remove()
Date:   Tue,  9 Mar 2021 13:23:59 +0200
Message-Id: <20210309112403.36633-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
References: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
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
2.30.1

