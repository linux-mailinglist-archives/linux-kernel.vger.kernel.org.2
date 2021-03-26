Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7062634AD43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhCZRYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:24:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:50877 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhCZRXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:23:55 -0400
IronPort-SDR: wSztIgc8hlQ85stBmBNbbOc7gxw9gxY4FObdLYwX5YobORcN3F7R1Rocllq/iJT4OStNSRoNPZ
 hteUPDtxEnJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="190631533"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="190631533"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 10:23:54 -0700
IronPort-SDR: tk1ZuvV7O7PB8VY24qiPYWCR412OCX+qIm5hmw6fZRO/o7WO65DxhMSHJLYTusr87XRQmMHtsJ
 n4ORMyDW5GxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="409989812"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2021 10:23:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3080511F; Fri, 26 Mar 2021 19:24:08 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>
Subject: [PATCH v1 3/3] mux: gpio: Simplify code by using dev_err_probe()
Date:   Fri, 26 Mar 2021 19:24:01 +0200
Message-Id: <20210326172401.33685-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326172401.33685-1-andriy.shevchenko@linux.intel.com>
References: <20210326172401.33685-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use already prepared dev_err_probe() introduced by the commit
a787e5400a1c ("driver core: add device probe log helper").
It simplifies EPROBE_DEFER handling.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mux/gpio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index e5ef9284e2b4..c3036bfffd50 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -65,12 +65,8 @@ static int mux_gpio_probe(struct platform_device *pdev)
 	mux_chip->ops = &mux_gpio_ops;
 
 	mux_gpio->gpios = devm_gpiod_get_array(dev, "mux", GPIOD_OUT_LOW);
-	if (IS_ERR(mux_gpio->gpios)) {
-		ret = PTR_ERR(mux_gpio->gpios);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get gpios\n");
-		return ret;
-	}
+	if (IS_ERR(mux_gpio->gpios))
+		return dev_err_probe(dev, PTR_ERR(mux_gpio->gpios), "failed to get gpios\n");
 	WARN_ON(pins != mux_gpio->gpios->ndescs);
 	mux_chip->mux->states = BIT(pins);
 
-- 
2.30.2

