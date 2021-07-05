Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835173BBC3A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhGELfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:35:54 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:47816 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhGELfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625484796; x=1657020796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zSlXXaMWmpaIruL70G2uArDgeP8tRphJOudMX0EJyTk=;
  b=YXhWy4SZUT7lYm/x0lckXe/AvqhAxgoKILtMTE2lCZ/6t7Txssv5GCKO
   JXZTnU08QC6vC18zWTAS8pAgk44mBKrUaM+P8aaUTjANKAnlgFeP0X+TH
   axH2hMuNSYgyGCJrwMwTLLR9B/1cA4Xu4JyU6JxNiQISEe5RPJ0TgySYB
   Q3EBTmOidrJZ8UtzQgofaV+V4V5osxVJTqDw3ZkG/WDg/fhLxAO/qTVx7
   EG0F8B8xHpfFkjM5xnM9yAC8Pq8JuuVKh5MwfXZKfJvTgEWHymqtJqCLG
   vnMzgAwURJipHA7b0CCBwh6HiTwDTBdO10FlOfaJ27dpn3AB+pgDXJ2WH
   A==;
IronPort-SDR: qqRGo4LG29iWzFEC099TAWHho2vVHqQmJtyGXa26+d+2aMaksnf4EsirIHh7cWjGb8U3BXR0l2
 PzSOKOxRsG8el5086LO2UardHJ3oJvZYS/MLS8nqjdFBa/wfWLOs3l4BbFBkr+XTW5WwnmBG1h
 SBDUDAk51G2Kp7akEuybXNFHgzs5p9t8kvkZrV8awysMhiRKI4I3ZVPnGicdXY8K60cCH/qsbH
 y472bjM+BJbZwLjO78Pg5l0XF9SQSZa3y+PdvBFemc6zaDAGQOg79pRCZJVXgyr5irsVRHZzSu
 oGE=
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="134613673"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2021 04:33:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 04:33:16 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 5 Jul 2021 04:33:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lee.jones@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <romain.izard.pro@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] mfd: atmel-flexcom: use resume_noirq
Date:   Mon, 5 Jul 2021 14:31:04 +0300
Message-ID: <20210705113104.579535-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210705113104.579535-1-claudiu.beznea@microchip.com>
References: <20210705113104.579535-1-claudiu.beznea@microchip.com>
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
2.25.1

