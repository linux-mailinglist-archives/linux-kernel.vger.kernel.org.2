Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA77D34F1AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 21:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhC3Tec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 15:34:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:7836 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233186AbhC3TeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 15:34:01 -0400
IronPort-SDR: zsRayjdvCq7xtNsY6q0aAdiZwVlHkiZVTHXJUXiVaV4kyCrjcWgRWNhwHQCetp+E8mWzzSpTNo
 wjFiuNhWyleQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="171251094"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="171251094"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 12:34:01 -0700
IronPort-SDR: KG8vYIaP9LxOl0V6WBhByNsKrwYzIHAeHeILv7L3Vynf+SO0/HbMdc58+2sDsdI2qlyntM7ATD
 X2TO53hXFk5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="595587576"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 30 Mar 2021 12:33:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4AFF3179; Tue, 30 Mar 2021 22:34:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 3/3] mux: gpio: Simplify code by using dev_err_probe()
Date:   Tue, 30 Mar 2021 22:33:25 +0300
Message-Id: <20210330193325.68362-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330193325.68362-1-andriy.shevchenko@linux.intel.com>
References: <20210330193325.68362-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use already prepared dev_err_probe() introduced by the commit
a787e5400a1c ("driver core: add device probe log helper").
It simplifies EPROBE_DEFER handling.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Peter Rosin <peda@axentia.se>
---
v2: wrapped to 80 characters (Peter)
 drivers/mux/gpio.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index 92cc476c916e..cc5f2c1861d4 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -66,12 +66,9 @@ static int mux_gpio_probe(struct platform_device *pdev)
 	mux_chip->ops = &mux_gpio_ops;
 
 	mux_gpio->gpios = devm_gpiod_get_array(dev, "mux", GPIOD_OUT_LOW);
-	if (IS_ERR(mux_gpio->gpios)) {
-		ret = PTR_ERR(mux_gpio->gpios);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get gpios\n");
-		return ret;
-	}
+	if (IS_ERR(mux_gpio->gpios))
+		return dev_err_probe(dev, PTR_ERR(mux_gpio->gpios),
+				     "failed to get gpios\n");
 	WARN_ON(pins != mux_gpio->gpios->ndescs);
 	mux_chip->mux->states = BIT(pins);
 
-- 
2.30.2

