Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27C634953B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhCYPTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhCYPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:19:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45308C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 08:19:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id e14so3494359ejz.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 08:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rb/4lNsqVgOsgi+5RasUem2G/Fu2mClLd9/QJD16Ei4=;
        b=gux5RZgjzZbDpiIy6k4zGv4Oe2fhtqkMZBVjGXMvK8iP/kJoT3gqp3pAqFAZZU1gnb
         cMpSeRC7Z5TOCvV2XSoANl42cWkGblimJ11j4ce/P8g9iIAC/AOd1aBX2bHUcdjKAlvJ
         3/N4t6pfw7A1jfITavtDbvhjbUho+iGlr7w0OwAccPr2dF7nHrokwvuA1JIkGzew85rl
         L/Qc8ozJ5WIRnlrCYxzqFZtiIAjOkF7dtPjBAbDud+mJB4pVk3MGXm5XjPaRlpGhHycG
         4yTNH8nU0oBZLuWapYR9Egu0VCtmDlB/ZdgWDCSuW2Qob9euN5tp2gVExXsBwwy1ZqHj
         r/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rb/4lNsqVgOsgi+5RasUem2G/Fu2mClLd9/QJD16Ei4=;
        b=gUhaVLOMZtpQIN7lZKIJT+z7bk0Clp1w23vn5GwbPv3ZFzUT6xqnAQTU7lf901+6yO
         5Ztivgx6E58qUYCa4HdqIg3OhBUkt8XvxU+LeVizOjmXL/Vk2NLhobrPR/a4pVJg5yii
         K7kJN12gOr5JWFsJ1ymBdaEolC0J3EUlrMaTx0p2kVOWOWeR552mIe58Xu/+w/0/dmtC
         QjKHqLsjDqX+DjaSBZHHnsZnglrJ5Lpx0EIfa+rM/DFY+t84utqyQltMzg8uWhRn5q3W
         Lx5T5ZpoZAEuMI5Rv3CBC1WaRbOqD/1xyEKHfUv9+jxqOX1DEFDub2qg8ssdTJY0fMlZ
         Q/2g==
X-Gm-Message-State: AOAM531xJ+3w9kIA5B4UqoyscjDnjygX1jrc/kKbuWJccnuIfONPogdh
        hiUrFUvzXrw8pP42/9nRASgWfg==
X-Google-Smtp-Source: ABdhPJxWtGWt012ym2jwngipDc+7qQRO9lct2VaHYotnCGtla/O4PfF12ojniifuxP3Vqhxio+V3og==
X-Received: by 2002:a17:906:ecaa:: with SMTP id qh10mr10077208ejb.425.1616685557977;
        Thu, 25 Mar 2021 08:19:17 -0700 (PDT)
Received: from localhost (cpe.ge-3-0-8-100.ryvnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id t15sm2892935edc.34.2021.03.25.08.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 08:19:17 -0700 (PDT)
From:   Daniel Gomez <daniel@qtec.com>
Cc:     Daniel Gomez <daniel@qtec.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: designware: Add base addr info
Date:   Thu, 25 Mar 2021 16:12:48 +0100
Message-Id: <20210325151248.1066643-1-daniel@qtec.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i2c hw base address in the adapter name and when the device is
probed.

Output:
root@qt5222:~# dmesg | grep -i syno
[    0.347045] i2c_designware AMDI0010:00: Synopsys DesignWare I2C
adapter at 0xfedc4000
[    0.348843] i2c_designware AMDI0010:01: Synopsys DesignWare I2C
adapter at 0xfedc5000
root@qt5222:~# i2cdetect -l | grep -i desig
i2c-1   i2c             Synopsys DesignWare I2C adapter at 0xfedc5000
I2C adapter
i2c-0   i2c             Synopsys DesignWare I2C adapter at 0xfedc4000
I2C adapter

Signed-off-by: Daniel Gomez <daniel@qtec.com>
---

Hi,
We think it might be interesting to add the physical address if you have
multiple adapters like the above example so we don't write to the wrong
device. Could it be possible to add this patch?

Thanks


 drivers/i2c/busses/i2c-designware-core.h    | 1 +
 drivers/i2c/busses/i2c-designware-master.c  | 2 +-
 drivers/i2c/busses/i2c-designware-platdrv.c | 6 +++++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 5392b82f68a4..8c56a7ec8693 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -241,6 +241,7 @@ struct dw_i2c_dev {
 	struct regmap		*sysmap;
 	void __iomem		*base;
 	void __iomem		*ext;
+	phys_addr_t		base_addr;
 	struct completion	cmd_complete;
 	struct clk		*clk;
 	struct clk		*pclk;
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index dd27b9dbe931..5e78b0aec2d3 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -767,7 +767,7 @@ int i2c_dw_probe_master(struct dw_i2c_dev *dev)
 		return ret;

 	snprintf(adap->name, sizeof(adap->name),
-		 "Synopsys DesignWare I2C adapter");
+		 "Synopsys DesignWare I2C adapter at 0x%llx", dev->base_addr);
 	adap->retries = 3;
 	adap->algo = &i2c_dw_algo;
 	adap->quirks = &i2c_dw_quirks;
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 0dfeb2d11603..c8ffcc85bc51 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -178,6 +178,7 @@ static void dw_i2c_plat_pm_cleanup(struct dw_i2c_dev *dev)
 static int dw_i2c_plat_request_regs(struct dw_i2c_dev *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev->dev);
+	struct resource *res;
 	int ret;

 	switch (dev->flags & MODEL_MASK) {
@@ -185,7 +186,8 @@ static int dw_i2c_plat_request_regs(struct dw_i2c_dev *dev)
 		ret = bt1_i2c_request_regs(dev);
 		break;
 	default:
-		dev->base = devm_platform_ioremap_resource(pdev, 0);
+		dev->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+		dev->base_addr = res->start;
 		ret = PTR_ERR_OR_ZERO(dev->base);
 		break;
 	}
@@ -313,6 +315,8 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (ret)
 		goto exit_probe;

+	dev_info(&pdev->dev, "%s\n", adap->name);
+
 	return ret;

 exit_probe:
--
2.30.2

