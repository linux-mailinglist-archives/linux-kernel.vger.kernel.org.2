Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0902B343ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCVHhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:37:38 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:45008 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhCVHh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:37:26 -0400
Received: by mail-lf1-f41.google.com with SMTP id b83so19660519lfd.11;
        Mon, 22 Mar 2021 00:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Rc72VFcdGikA4iw93UKiEviUsRbqS+/SG2EjEpppYs=;
        b=PrTa4ChTCABlmTAzQWSj2FCBbxeoH9XSvp4jzqGzRkga1WwvFJG+vo8Kt5rEKHT30p
         XYadMHGNIWQPufiEy0k1DoMqeEKXEHdB6TRcnNsKYp0P8cHuvbewFen7uSh7KQxBZGfb
         T7gzaaowu+AsE6eGvB+sqHZFNqjKQM6mOw4tLaH5CCUf4F/ysaETV+ZQ9m/qc74VoKkS
         Alh4OHtC5zq07YE4z9yjejmAM21ZxHEYUyuocucutN3g7virSFk/hWiMXyr4H/4DGxY3
         0riFP2l67AJAC/N2reT7DsMT0d9mmdRLENhVLNg7IbU7iiAVf45Ae9Vli3t8ASGl5u6P
         sy3w==
X-Gm-Message-State: AOAM533YA8IDgBGtK+uMwwFrpMmjGZWr/m+ndp8RTqXTGIyTYF2gEFh0
        i4YIgfipWuBBeSJonc8N/NI=
X-Google-Smtp-Source: ABdhPJwnT9ciFHTC6qAHGdo5mIkimpgNxb3kZPPADn6nqCyTAUvj2P1qNA655dFbGPTTHfnPlqT8kQ==
X-Received: by 2002:a05:6512:108b:: with SMTP id j11mr7987542lfg.289.1616398644814;
        Mon, 22 Mar 2021 00:37:24 -0700 (PDT)
Received: from localhost.localdomain (mobile-access-5673b7-246.dhcp.inet.fi. [86.115.183.246])
        by smtp.gmail.com with ESMTPSA id a28sm1885621ljn.45.2021.03.22.00.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 00:37:24 -0700 (PDT)
Date:   Mon, 22 Mar 2021 09:37:18 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [RFC RESEND PATCH v2 4/8] hwmon: raspberry-pi: Clean-up few drivers
 by using managed work init
Message-ID: <fc14075a0aae06678cde0bae80ec92d93378ac62.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few drivers implement remove call-back only for ensuring a delayed
work gets cancelled prior driver removal. Clean-up these by switching
to use devm_delayed_work_autocancel() instead.

This change is compile-tested only. All testing is appreciated.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/hwmon/raspberrypi-hwmon.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/raspberrypi-hwmon.c b/drivers/hwmon/raspberrypi-hwmon.c
index d3a64a35f7a9..805d396aa81b 100644
--- a/drivers/hwmon/raspberrypi-hwmon.c
+++ b/drivers/hwmon/raspberrypi-hwmon.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2018 Stefan Wahren <stefan.wahren@i2se.com>
  */
 #include <linux/device.h>
+#include <linux/devm-helpers.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
 #include <linux/module.h>
@@ -106,6 +107,7 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rpi_hwmon_data *data;
+	int ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -119,7 +121,10 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
 							       &rpi_chip_info,
 							       NULL);
 
-	INIT_DELAYED_WORK(&data->get_values_poll_work, get_values_poll);
+	ret = devm_delayed_work_autocancel(dev, &data->get_values_poll_work,
+					   get_values_poll);
+	if (ret)
+		return ret;
 	platform_set_drvdata(pdev, data);
 
 	if (!PTR_ERR_OR_ZERO(data->hwmon_dev))
@@ -128,18 +133,8 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(data->hwmon_dev);
 }
 
-static int rpi_hwmon_remove(struct platform_device *pdev)
-{
-	struct rpi_hwmon_data *data = platform_get_drvdata(pdev);
-
-	cancel_delayed_work_sync(&data->get_values_poll_work);
-
-	return 0;
-}
-
 static struct platform_driver rpi_hwmon_driver = {
 	.probe = rpi_hwmon_probe,
-	.remove = rpi_hwmon_remove,
 	.driver = {
 		.name = "raspberrypi-hwmon",
 	},
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
