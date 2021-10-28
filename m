Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A9243E2A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhJ1Ny1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:54:27 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:46830 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhJ1NyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635429110; x=1666965110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dU+TKEqFhookugii6e48sZZmL7sX4kZZtdRkPRAXV1A=;
  b=ej4BLdwZmyzWxhgz5296NgshlsW4M5aEtJnbY1mVzQjpGL1KH/VlUCI4
   uKgBlo40chXkH8nMEeY6YrISKXYK+6eI4zmQbSrb8OULATcDisysjqM51
   C1nHt724WFTb7vEqtS+zSkSLVPvUGFYiCqmBvqlMfbTBCJ98X26YgarI+
   qQMM/xCWOMV7HzoHXNwy+bbK2lYVn+7wOQDK418vtSPF7GRtcBNtdlJyt
   +anrcLbHkQsxTBgmkOMNgvrw1yoNU6vpJw7l9zIVFdwPQIftFdYhaN/nu
   /LuJdvo8uyYL+nR8jhFJzIxPlmq9qi031I0pOxlXQknhvHGyFlPA5ep4p
   A==;
IronPort-SDR: rM/lXGyAi+bIgAGFPtr1FNHDDRhtFDR7jL6dPDregF/oUhTwRy4tIYbkn1HRkCVq6VWjI0lS33
 eznC8t7k87ZYsIpo3qJm+KClJ5R1LKk0QSNcElZ/1FkBszWpYCDMhwVm7Dt50yGwrZHWF9WfQ1
 /GbsbQbRUyYIvpm5m+zFIN+A/NDqRtUj5it4SNAbW3w9Bmfj7v/O05HJe2rRdJq3U1NCJZH29o
 /U/WVnD3odHWvC18dP8uTZk9tGkiQPZ8D9rkZPWNYPpUGST0eFmWCafJ0YzZ0s+plMHlGZr7tC
 PZmmbaFtHWPkvIYY2+Je5zdB
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="142003400"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Oct 2021 06:51:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 28 Oct 2021 06:51:49 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 28 Oct 2021 06:51:47 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lee.jones@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <romain.izard.pro@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH v2 2/2] mfd: atmel-flexcom: use resume_noirq
Date:   Thu, 28 Oct 2021 16:51:38 +0300
Message-ID: <20211028135138.3481166-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211028135138.3481166-1-claudiu.beznea@microchip.com>
References: <20211028135138.3481166-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flexcom IP embeds 3 other IPs: usart, i2c, spi and selects the operation
mode (usart, i2c, spi) via mode register (FLEX_MR). On i2c bus there might
be connected critical devices (like PMIC) which on suspend/resume should
be suspended/resumed at the end/beginning. i2c uses
.suspend_noirq/.resume_noirq for this kind of purposes. Align flexcom
to use .resume_noirq as it should be resumed before the embedded IPs.
Otherwise the embedded devices might behave badly.

Fixes: 7fdec11015c3 ("atmel_flexcom: Support resuming after a chip reset")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Tested-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/mfd/atmel-flexcom.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
index 962f66dc8813..559eb4d352b6 100644
--- a/drivers/mfd/atmel-flexcom.c
+++ b/drivers/mfd/atmel-flexcom.c
@@ -87,7 +87,7 @@ static const struct of_device_id atmel_flexcom_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
 
-static int __maybe_unused atmel_flexcom_resume(struct device *dev)
+static int __maybe_unused atmel_flexcom_resume_noirq(struct device *dev)
 {
 	struct atmel_flexcom *ddata = dev_get_drvdata(dev);
 	int err;
@@ -105,8 +105,9 @@ static int __maybe_unused atmel_flexcom_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(atmel_flexcom_pm_ops, NULL,
-			 atmel_flexcom_resume);
+static const struct dev_pm_ops atmel_flexcom_pm_ops = {
+	.resume_noirq = atmel_flexcom_resume_noirq,
+};
 
 static struct platform_driver atmel_flexcom_driver = {
 	.probe	= atmel_flexcom_probe,
-- 
2.33.0

